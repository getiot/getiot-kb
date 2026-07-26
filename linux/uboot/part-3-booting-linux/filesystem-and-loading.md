---
sidebar_position: 3
sidebar_label: 文件系统与文件加载
slug: /filesystem-and-loading
---

# U-Boot 文件系统与文件加载

当 U-Boot 能识别存储设备和分区后，下一步就是读取文件。启动 Linux 常见的文件可能位于 FAT、ext4、UBIFS 或网络目录中。本章我们先从最容易理解的文件系统加载开始。

从用户角度看，“文件系统加载”就是让 U-Boot 像一个很小的文件读取工具：进入某个设备分区，找到路径，把文件内容复制到内存地址。你不需要先理解文件系统内部实现，但要知道当前 U-Boot 是否支持这种文件系统。

## 1. 使用 `load`

在较新的 U-Boot 中，`load` 命令可以从多种文件系统加载文件。典型格式是：

```bash
# [U-Boot]
load <interface> <dev[:part]> <addr> <filename>
```

这四个参数要逐个看：

- `<interface>`：设备接口，例如 `virtio`、`mmc`、`usb`。
- `<dev[:part]>`：设备编号和分区编号，例如 `0:1`。
- `<addr>`：加载到内存的地址。
- `<filename>`：文件路径。

例如从 QEMU virtio block 的第 1 个分区加载 kernel：

```bash
# [U-Boot]
virtio scan
load virtio 0:1 ${kernel_addr_r} /boot/Image
```

加载成功后，U-Boot 通常会设置 `filesize`：

```bash
# [U-Boot]
echo ${filesize}
```

`filesize` 表示刚刚加载的文件大小，后续启动 initramfs 或做校验时经常会用到。

你还可以立刻做一次 CRC：

```bash
# [U-Boot]
crc32 ${kernel_addr_r} ${filesize}
```

这不是安全验证，但可以帮助你比较两次加载结果是否一致。

## 2. 查看目录

加载前最好先确认文件路径：

```bash
# [U-Boot]
ls virtio 0:1 /
ls virtio 0:1 /boot
```

如果是 SD card：

```bash
# [U-Boot]
ls mmc 0:1 /boot
```

路径大小写要完全匹配。Linux 文件系统区分大小写，`Image` 和 `image` 是不同文件。

如果 `ls virtio 0:1 /boot` 失败，可以按顺序检查：

1. 是否执行过 `virtio scan`。
2. `part list virtio 0` 是否能看到分区。
3. `/boot` 是否真的在第 1 个分区。
4. 当前 U-Boot 是否支持该文件系统。

## 3. 文件系统支持从哪里来

U-Boot 能不能读取 FAT 或 ext4，不取决于 Linux rootfs 支不支持，而取决于 U-Boot 自己编译了哪些功能。你可以先看命令：

```bash
# [U-Boot]
help load
help fatload
help ext4load
```

也可以在源码构建目录中查看配置：

```bash
# [Host]
grep -E 'CONFIG_CMD_FS_GENERIC|CONFIG_CMD_FAT|CONFIG_CMD_EXT4|CONFIG_FS_FAT|CONFIG_FS_EXT4' .config
```

如果当前镜像没有对应命令，你需要回到 U-Boot 配置和编译阶段，而不是修改磁盘里的文件。

## 4. FAT 与 ext4

有些 U-Boot 配置提供了更具体的命令：

```bash
# [U-Boot]
fatls mmc 0:1
fatload mmc 0:1 ${kernel_addr_r} Image
ext4ls mmc 0:2 /boot
ext4load mmc 0:2 ${kernel_addr_r} /boot/Image
```

对初学者来说，优先学 `load`，再了解 `fatload`、`ext4load`。如果提示 `Unknown command`，说明当前 U-Boot 没有编译对应命令，需要回到配置阶段检查文件系统和命令选项。

FAT 常用于 boot 分区，因为实现简单、很多固件都能识别。ext4 更接近 Linux 常规根文件系统，但对 Bootloader 来说实现更复杂。产品到底用哪种布局，不是语言层面的好坏，而是启动链、升级方案、工具链和维护习惯共同决定。

## 5. 加载后验证

加载 kernel 后，可以查看前几个字节：

```bash
# [U-Boot]
md.b ${kernel_addr_r} 40
```

加载 DTB 后，可以让 `fdt` 命令解析它：

```bash
# [U-Boot]
load virtio 0:1 ${fdt_addr_r} /boot/qemu-arm64.dtb
fdt addr ${fdt_addr_r}
fdt header
```

如果 `fdt header` 能显示 magic、totalsize、version 等字段，说明这个地址上确实是一份 DTB。

对于 kernel，`md` 只能说明内存里有数据，不能保证格式一定正确。真正启动时，如果镜像格式不匹配，`booti`、`bootz`、`bootm` 会给出更明确的错误。你要学会把“加载成功”和“启动成功”分开看：加载成功只是把文件读到了内存，启动成功还要求文件格式、地址、DTB 和 bootargs 都正确。

## 6. 常见路径

| 文件 | 常见路径 |
| --- | --- |
| ARM64 kernel | `/boot/Image`、`/Image` |
| ARM zImage | `/boot/zImage`、`/zImage` |
| DTB | `/boot/dtb/<board>.dtb`、`/boot/<board>.dtb` |
| initramfs | `/boot/initrd.img`、`/boot/initramfs.cpio.gz` |
| extlinux 配置 | `/boot/extlinux/extlinux.conf`、`/extlinux/extlinux.conf` |

写启动脚本时，不要假设所有系统都一样。先用 `ls` 验证，再固定路径。

## 7. `load` 失败时怎么读错误

常见失败大致分三类：

### 设备或分区错误

如果提示找不到设备、无法选择分区，回到上一章检查：

```bash
# [U-Boot]
virtio scan
virtio info
part list virtio 0
```

### 文件系统不支持

如果设备和分区存在，但 U-Boot 无法识别文件系统，检查当前命令和配置。比如镜像分区是 ext4，但 U-Boot 没有启用 ext4 支持，就无法读取。

### 路径错误

如果提示文件不存在，用 `ls` 一层层查看：

```bash
# [U-Boot]
ls virtio 0:1 /
ls virtio 0:1 /boot
ls virtio 0:1 /boot/extlinux
```

不要凭 Linux 系统中的路径猜测启动分区中的路径。有些发行版的 `/boot` 是独立分区；挂载到 U-Boot 后，路径可能从 `/` 开始就是 `Image`，而不是 `/boot/Image`。

## 8. 一个完整的小实验

假设第 1 个 virtio 分区中有 `/boot/qemu-arm64.dtb`，你可以只加载 DTB 并验证：

```bash
# [U-Boot]
setenv fdt_addr_r 0x4fa00000
virtio scan
ls virtio 0:1 /boot
load virtio 0:1 ${fdt_addr_r} /boot/qemu-arm64.dtb
echo ${filesize}
fdt addr ${fdt_addr_r}
fdt header
```

这个实验不会启动 Linux，但能让你确认“扫描设备、查看目录、加载文件、验证格式”这条链路是通的。

## 本章小结

文件加载是 U-Boot 启动 Linux 的中间环节：设备和分区解决“从哪里读”，地址变量解决“读到哪里”，而 `load` 把两者连接起来。

## 思考与练习

1. 用 `ls` 找到你的 kernel、DTB 和 extlinux 配置所在路径。
2. 加载一个 DTB，并使用 `fdt header` 验证。
3. 故意把文件名大小写写错，观察 U-Boot 的错误信息，然后恢复正确命令。
