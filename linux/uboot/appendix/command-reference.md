---
sidebar_position: 1
sidebar_label: U-Boot 常用命令速查
slug: /command-reference
---

# U-Boot 常用命令速查

本页按用途整理常用 U-Boot 命令。不同板级配置支持的命令不同，使用前请先 `help <command>` 验证。

## 基本信息

```bash
# [U-Boot]
version
bdinfo
help
help booti
coninfo
```

## 环境变量

```bash
# [U-Boot]
printenv
printenv bootcmd bootargs
setenv name value
setenv name
run bootcmd
env default -a
env import -t ${scriptaddr} ${filesize}
env export -t ${scriptaddr}
```

:::warning
`saveenv` 会写入持久化存储。真实开发板上执行前请确认 environment 位置和恢复方法。
:::

## 内存

```bash
# [U-Boot]
md.b 0x40200000 40
mw.b 0x41000000 0x55 0x10
cp.b 0x41000000 0x41000100 0x20
cmp.b 0x41000000 0x41000100 0x20
crc32 0x41000000 0x20
```

## 设备与分区

```bash
# [U-Boot]
virtio scan
virtio info
mmc list
mmc dev 0
mmc info
usb start
usb storage
part list virtio 0
part list mmc 0
lsblk
```

## 文件加载

```bash
# [U-Boot]
ls virtio 0:1 /boot
load virtio 0:1 ${kernel_addr_r} /boot/Image
load mmc 0:1 ${fdt_addr_r} /boot/<board>.dtb
fatload mmc 0:1 ${kernel_addr_r} Image
ext4load mmc 0:2 ${kernel_addr_r} /boot/Image
```

## 网络

```bash
# [U-Boot]
dhcp
ping ${serverip}
tftpboot ${kernel_addr_r} Image
nfs ${kernel_addr_r} ${serverip}:/path/to/Image
```

## 启动

```bash
# [U-Boot]
booti ${kernel_addr_r} - ${fdt_addr_r}
booti ${kernel_addr_r} ${ramdisk_addr_r}:${ramdisk_size} ${fdt_addr_r}
bootm ${kernel_addr_r}
bootflow scan -l
bootflow scan -lb
bootflow list
bootflow info
bootflow boot
bootdev list
bootmeth list
```

## Driver Model 与 FDT

```bash
# [U-Boot]
dm tree
dm uclass
fdt addr ${fdt_addr_r}
fdt header
fdt print /chosen
```

## 镜像与脚本

```bash
# [U-Boot]
iminfo ${kernel_addr_r}
source ${scriptaddr}
bootm ${fit_addr}#conf
```

## 危险命令提醒

下面这些命令会修改持久化存储，真实硬件上不要随意执行：

```bash
# [U-Boot]
saveenv
mmc write
sf erase
sf write
nand erase
nand write
gpt write
```
