---
sidebar_position: 8
sidebar_label: Standard Boot 启动框架
slug: /standard-boot
---

# U-Boot Standard Boot 启动框架

早期 U-Boot 系统常见做法是手写一大段 `bootcmd`。这种方式灵活，但不同厂商、不同板子的变量命名差异很大。Standard Boot 是 U-Boot 中更现代的启动框架，它试图用统一方式扫描启动设备、发现启动配置，并执行对应启动流程。

你可以把 Standard Boot 理解成“U-Boot 帮你按统一规则找启动项”。它不是新的 Linux 启动原理，而是把查找设备、查找配置文件、读取配置、加载 kernel 这些动作标准化。

## 1. 为什么需要 Standard Boot

如果每块板子都手写一套 `bootcmd`，维护成本会越来越高：SD card、USB、NVMe、网络启动的逻辑重复；extlinux、EFI、PXE、script 等启动方式难以统一；用户换启动介质时需要改大量变量。

Standard Boot 把启动过程拆成几个对象：

- `bootdev`：从哪里启动，例如 virtio、mmc、usb、net。
- `bootmeth`：用什么方法启动，例如 extlinux、EFI、PXE、script。
- `bootflow`：一次被发现的可启动配置。

一个简单类比是：

- `bootdev` 像“去哪个抽屉找资料”。
- `bootmeth` 像“按哪种格式识别资料”。
- `bootflow` 像“找到的一份可执行启动方案”。

## 2. 查看状态

在 U-Boot v2026.07 的 QEMU ARM64 配置中，可以先查看相关命令是否存在：

```bash
# [U-Boot]
help bootflow
help bootdev
help bootmeth
```

如果当前镜像支持，可以继续查看：

```bash
# [U-Boot]
bootdev list
bootmeth list
bootflow scan -l
bootflow list
```

`-l` 会列出更详细的扫描过程，适合学习和排障。

如果你想看所有 boot method，包括没有进入默认顺序的，可以尝试：

```bash
# [U-Boot]
bootmeth list -a
```

如果你想触发 bootdev hunter 查找设备：

```bash
# [U-Boot]
bootdev hunt -l
bootdev hunt
bootdev list
```

具体输出取决于当前 U-Boot 配置和 QEMU/开发板设备。

## 3. extlinux.conf

Standard Boot 常见配置文件是 `extlinux.conf`。它通常位于 `/boot/extlinux/extlinux.conf` 或 `/extlinux/extlinux.conf`。

一个最小示例：

```bash
default qemu-arm64
timeout 3

label qemu-arm64
    kernel /boot/Image
    fdt /boot/qemu-arm64.dtb
    append console=ttyAMA0 root=/dev/vda2 rw rootwait
```

你可以把它理解为“把手动启动命令写成配置文件”。`kernel` 指向内核，`fdt` 指向设备树，`append` 对应内核启动参数。

### 路径相对谁

`extlinux.conf` 中的 `kernel` 和 `fdt` 路径通常相对于所在文件系统根目录。比如配置写 `/boot/Image`，就要求 U-Boot 在扫描到的那个分区里能找到 `/boot/Image`。

如果你的启动分区本身挂载为 Linux 的 `/boot`，那么 U-Boot 看到的路径可能是 `/Image`，而不是 `/boot/Image`。这类路径差异是 Standard Boot 扫描失败的常见原因。

## 4. 准备配置文件

配套实验仓库提供了一个示例：

```bash
experiments/qemu-arm64/extlinux/extlinux.conf
```

你可以把它放到启动分区的 `/boot/extlinux/extlinux.conf`。如果当前环境还没有磁盘镜像，也可以先阅读配置，理解它和手动启动命令的对应关系。

对应关系大致是：

| extlinux 字段 | 手动启动中的角色 |
| --- | --- |
| `kernel` | `load ... ${kernel_addr_r} ...` |
| `fdt` | `load ... ${fdt_addr_r} ...` |
| `append` | `setenv bootargs ...` |
| `label` | 启动项名称 |

## 5. 启动一个 bootflow

扫描到启动项后，可以直接启动：

```bash
# [U-Boot]
bootflow boot
```

也可以先选择再启动：

```bash
# [U-Boot]
bootflow select 0
bootflow info
bootflow boot
```

如果扫描不到，使用详细输出：

```bash
# [U-Boot]
bootflow scan -lb
```

`bootflow scan -lb` 中：

- `-l`：列出扫描过程。
- `-b`：找到可启动项后尝试启动。

学习时可以先只用 `bootflow scan -l` 观察，不要立即启动。确认它找到了你预期的设备和配置后，再执行 `bootflow boot`。

## 6. 与手动启动的关系

Standard Boot 并没有改变 Linux 启动的本质。它仍然要找到 kernel、找到 DTB、设置 bootargs，并执行 `booti`、`bootm` 或 EFI 启动路径。它只是把“怎么找、怎么组织配置”标准化了。

手动启动更适合学习和排障，Standard Boot 更适合日常启动和产品配置。你应该同时掌握两者：Standard Boot 失败时，用手动启动缩小问题；手动启动稳定后，再整理为 Standard Boot 配置。

## 7. 常见问题

#### 扫描不到 bootflow

按顺序检查：

```bash
# [U-Boot]
bootdev list
bootmeth list
bootflow scan -l
ls virtio 0:1 /
ls virtio 0:1 /boot/extlinux
```

确认设备存在、分区可读、`extlinux.conf` 路径正确。

#### 扫描到了，但启动失败

这说明 Standard Boot 已经找到了配置，但 kernel、DTB、bootargs 或 rootfs 仍可能有问题。用手动启动命令复现同一组路径和参数，通常更容易定位。

#### 多个启动项顺序不符合预期

检查 `boot_targets`、`bootmeths` 或板级默认启动顺序。不同平台可能会先扫 MMC，再扫 USB、网络或 virtio。

## 本章小结

Standard Boot 是产品化启动流程的重要方向。对初学者来说，最重要的是理解 `bootdev`、`bootmeth`、`bootflow` 三个概念，并能用 `bootflow scan -l` 阅读启动扫描过程。

## 思考与练习

1. 解释 `bootdev`、`bootmeth`、`bootflow` 三者的区别。
2. 把一组手动启动命令改写成 `extlinux.conf`。
3. 使用 `bootflow scan -l` 观察 U-Boot 扫描了哪些设备和方法。
