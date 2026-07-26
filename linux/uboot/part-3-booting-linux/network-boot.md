---
sidebar_position: 9
sidebar_label: 通过网络启动 Linux
slug: /network-boot
---

# 用 U-Boot 通过网络启动 Linux

网络启动是嵌入式 Linux 开发中非常常用的能力。你可以把 kernel、DTB、initramfs 放在主机目录中，让 U-Boot 通过 TFTP 下载，然后启动 Linux。这样每次修改内核或设备树后，不必反复写 SD card 或 eMMC。

网络启动尤其适合内核和设备树调试。你只需要替换主机 TFTP 目录中的文件，再让 U-Boot 重新下载启动，省去了反复制作和烧写启动介质的时间。

## 1. 网络启动需要什么

最小网络启动链路包括：

- U-Boot 中可用的网卡驱动。
- IP 地址配置。
- 一台 TFTP server。
- kernel、DTB，可选 initramfs。

在 QEMU 用户网络中，主机通常可以通过 `10.0.2.2` 被 guest 访问。你可以把它作为 `serverip`：

```bash
# [U-Boot]
setenv serverip 10.0.2.2
setenv ipaddr 10.0.2.15
```

如果当前网络环境支持 DHCP，也可以尝试：

```bash
# [U-Boot]
dhcp
```

QEMU 用户网络的 `10.0.2.2` 是一个特殊约定，表示 guest 访问宿主机的地址。真实开发板没有这个默认地址，你需要根据自己的局域网设置 `serverip` 和 `ipaddr`，或者使用 DHCP。

## 2. QEMU 中启用 TFTP 目录

启动 QEMU 时，可以让用户网络内置一个 TFTP 根目录：

```bash
# [Host]
qemu-system-aarch64 \
  -machine virt \
  -cpu cortex-a57 \
  -m 1024 \
  -nographic \
  -bios u-boot.bin \
  -netdev user,id=net0,tftp=/home/rudy/workspace/Projects/GetIoT/uboot-courses/tftpboot \
  -device virtio-net-device,netdev=net0
```

然后你可以把 `Image`、`qemu-arm64.dtb`、`initramfs.cpio.gz` 放入 `tftpboot` 目录。

使用配套实验仓库时，目录通常是：

```bash
# [Host]
cd /home/rudy/workspace/Projects/GetIoT/uboot-courses
mkdir -p tftpboot
```

把启动文件放进去：

```bash
# [Host]
cp /path/to/Image tftpboot/
cp /path/to/qemu-arm64.dtb tftpboot/
```

如果暂时没有 Linux kernel 和 DTB，可以先完成 U-Boot 网络命令的认识，等准备好文件后再做完整启动。

## 3. 检查网络状态

进入 U-Boot 后，先查看网络相关变量：

```bash
# [U-Boot]
printenv ipaddr serverip ethaddr
```

设置 QEMU 用户网络常用地址：

```bash
# [U-Boot]
setenv serverip 10.0.2.2
setenv ipaddr 10.0.2.15
```

如果支持 `ping`，可以测试：

```bash
# [U-Boot]
ping ${serverip}
```

注意，有些 QEMU 用户网络或 U-Boot 配置下 ICMP 行为可能受限制。`ping` 失败不一定等于 TFTP 必定失败，但它仍然是一个很有用的初步检查。

## 4. 使用 TFTP 加载文件

```bash
# [U-Boot]
setenv serverip 10.0.2.2
setenv ipaddr 10.0.2.15
setenv kernel_addr_r 0x40200000
setenv fdt_addr_r 0x4fa00000

tftpboot ${kernel_addr_r} Image
tftpboot ${fdt_addr_r} qemu-arm64.dtb
setenv bootargs "console=ttyAMA0 root=/dev/vda2 rw rootwait"
booti ${kernel_addr_r} - ${fdt_addr_r}
```

使用 initramfs 时：

```bash
# [U-Boot]
setenv ramdisk_addr_r 0x4fb00000
tftpboot ${ramdisk_addr_r} initramfs.cpio.gz
setenv ramdisk_size ${filesize}
setenv bootargs "console=ttyAMA0"
booti ${kernel_addr_r} ${ramdisk_addr_r}:${ramdisk_size} ${fdt_addr_r}
```

你可以把 TFTP 启动和磁盘启动对照起来看：

| 动作 | 磁盘启动 | 网络启动 |
| --- | --- | --- |
| 加载 kernel | `load virtio 0:1 ... /boot/Image` | `tftpboot ... Image` |
| 加载 DTB | `load virtio 0:1 ... /boot/qemu-arm64.dtb` | `tftpboot ... qemu-arm64.dtb` |
| 启动命令 | `booti` | `booti` |

也就是说，网络启动只改变“文件从哪里来”，并不改变 `booti` 的基本含义。

## 5. 常见问题

`No ethernet found` 说明当前 U-Boot 没有识别到网卡。检查 QEMU 是否添加了网络设备、U-Boot 配置是否启用了对应驱动、`dm tree` 中是否能看到网络设备。

`TFTP error: File not found` 说明文件不在 TFTP 根目录，或者文件名大小写不匹配。TFTP 路径通常相对于 TFTP 根目录，不要写主机绝对路径。

一直超时时，检查 `serverip`、`ipaddr`、QEMU 网络参数和防火墙。如果使用外部 TFTP server，还要确认服务监听地址和权限。

#### DHCP 后变量被改了

执行 `dhcp` 后，U-Boot 可能会更新 `ipaddr`、`serverip`、`bootfile` 等变量。你可以在 DHCP 后重新 `printenv` 查看：

```bash
# [U-Boot]
dhcp
printenv ipaddr serverip bootfile
```

如果 DHCP 给出的 `serverip` 不是你的 TFTP server，就需要手动改回去。

#### TFTP 下载成功但启动失败

说明网络传输已经通过。后面继续按普通启动排查：kernel 格式、DTB、地址、bootargs、rootfs。

## 6. 网络启动与 NFS root

开发内核时，常见组合是 kernel 和 DTB 通过 TFTP 下载，rootfs 通过 NFS 挂载。对应 `bootargs` 类似：

```bash
# [U-Boot]
setenv bootargs "console=ttyAMA0 root=/dev/nfs nfsroot=10.0.2.2:/path/to/rootfs,tcp ip=dhcp"
```

NFS root 涉及主机导出目录、内核 NFS 支持和网络参数，本教程这里只建立概念。实际使用时请结合 Linux 内核文档和你的发行版 NFS server 配置。

与 TFTP 不同，NFS root 是 Linux kernel 启动后的事情。U-Boot 只负责把 `nfsroot=`、`ip=` 等参数传给 Linux；真正挂载 NFS root 的是 Linux。

## 7. 安全提醒

TFTP 没有认证和加密，适合受控开发网络，不适合直接暴露到不可信网络。产品升级和安全启动不要依赖裸 TFTP 作为唯一保护机制。

## 本章小结

网络启动能显著提高开发效率。排查时按“网卡是否存在、IP 是否正确、文件是否可访问、启动参数是否正确”逐层检查。

## 思考与练习

1. 解释 QEMU 用户网络中 `10.0.2.2` 的含义。
2. 使用 TFTP 下载一个 DTB，并用 `fdt header` 验证。
3. 对比 `load virtio` 和 `tftpboot`，说明它们改变的是启动链中的哪一环。
