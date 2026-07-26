---
sidebar_position: 7
sidebar_label: 环境变量与启动脚本
slug: /environment-and-scripts
---

# U-Boot 环境变量与启动脚本

手动启动适合学习和排障，但产品不能每次靠人输入十几条命令。U-Boot 使用环境变量和脚本变量把启动流程保存下来，最常见的入口就是 `bootcmd`。

你可以把环境变量分成两类：一类保存普通配置，例如地址、文件路径、IP；另一类保存一段可以 `run` 的命令序列。U-Boot 的启动脚本经常就是由很多小变量拼出来的。

## 1. 从手动命令开始

假设你已经验证下面的命令可以启动 Linux：

```bash
# [U-Boot]
virtio scan
load virtio 0:1 ${kernel_addr_r} /boot/Image
load virtio 0:1 ${fdt_addr_r} /boot/qemu-arm64.dtb
setenv bootargs "console=ttyAMA0 root=/dev/vda2 rw rootwait"
booti ${kernel_addr_r} - ${fdt_addr_r}
```

下一步就是把它拆成可维护的变量。

## 2. 先固定配置变量

先把地址、设备、路径和参数分开：

```bash
# [U-Boot]
setenv kernel_addr_r 0x40200000
setenv fdt_addr_r 0x4fa00000
setenv bootdev_type virtio
setenv bootdev_num 0
setenv bootpart 1
setenv kernel_path /boot/Image
setenv fdt_path /boot/qemu-arm64.dtb
setenv qemu_bootargs 'console=ttyAMA0 root=/dev/vda2 rw rootwait'
```

这样做的好处是：以后 kernel 路径变化，只改 `kernel_path`；从 `virtio` 换到 `mmc`，只改设备相关变量。

## 3. 拆分启动脚本

```bash
# [U-Boot]
setenv scan_dev '${bootdev_type} scan'
setenv load_kernel 'load ${bootdev_type} ${bootdev_num}:${bootpart} ${kernel_addr_r} ${kernel_path}'
setenv load_fdt 'load ${bootdev_type} ${bootdev_num}:${bootpart} ${fdt_addr_r} ${fdt_path}'
setenv setup_args 'setenv bootargs ${qemu_bootargs}'
setenv boot_linux 'booti ${kernel_addr_r} - ${fdt_addr_r}'
setenv bootcmd 'run scan_dev load_kernel load_fdt setup_args boot_linux'
run bootcmd
```

这种拆法比把所有命令塞进一个超长变量更容易排查。比如加载 DTB 失败时，你可以只执行：

```bash
# [U-Boot]
run scan_dev load_fdt
```

如果这一步失败，说明问题集中在设备扫描、分区、路径或 DTB 文件，而不是 `booti`。

## 4. 引号与变量展开

定义脚本变量时，单引号和双引号很重要：

```bash
# [U-Boot]
setenv load_kernel 'load virtio 0:1 ${kernel_addr_r} /boot/Image'
```

这样 `${kernel_addr_r}` 会在以后 `run load_kernel` 时展开。如果使用双引号，变量可能在定义时就被展开，后续修改地址变量时脚本不会跟着变。

你可以做一个小实验：

```bash
# [U-Boot]
setenv addr 0x40200000
setenv demo_single 'echo ${addr}'
setenv demo_double "echo ${addr}"
setenv addr 0x41000000
run demo_single
run demo_double
```

观察两条输出是否相同。这个实验能帮助你理解“定义时展开”和“运行时展开”的区别。

## 5. 命令返回值与 `&&`

U-Boot 脚本中可以使用 `&&` 表示前一步成功才继续。例如：

```bash
# [U-Boot]
setenv bootcmd 'run scan_dev && run load_kernel && run load_fdt && run setup_args && run boot_linux'
```

这比单纯用空格串起多个 `run` 更安全。加载 kernel 失败时，后面的 DTB 加载和 `booti` 不会继续执行。

不过，脚本越复杂，越要保持可读性。初学阶段先拆小变量，再逐个验证。

## 6. `bootdelay` 与自动启动

```bash
# [U-Boot]
printenv bootdelay
setenv bootdelay 5
```

设置为 `0` 表示几乎立即执行，设置为 `-1` 在很多配置中表示禁用自动启动。具体行为可能受配置选项影响，真实产品中不要随意修改。

如果你想临时阻止自动启动，可以在倒计时期间按任意键或 `Ctrl+C`，具体取决于配置。QEMU 里如果错过倒计时，直接复位重试即可：

```bash
# [U-Boot]
reset
```

## 7. 关于 `saveenv`

:::warning
`saveenv` 会把当前环境变量写入持久化存储。真实开发板上，如果写入位置、冗余环境或存储驱动配置错误，可能破坏启动环境。本教程除非明确说明，不要求你执行 `saveenv`。
:::

你可以先用临时变量把启动流程跑通，再考虑是否保存。产品中保存前还要确认 environment 后端，例如 SPI NOR、MMC offset、FAT 文件或冗余环境。

## 8. 从文本导入环境

U-Boot 支持把文本形式的环境导入内存：

```bash
# [U-Boot]
load virtio 0:1 ${scriptaddr} /boot/u-boot.env.txt
env import -t ${scriptaddr} ${filesize}
printenv bootcmd
```

这样你可以在主机上编辑文本文件，再导入 U-Boot 测试，避免一行一行手敲。

配套实验仓库中的 `experiments/qemu-arm64/boot.env.txt` 就是这种思路。导入后可以查看：

```bash
# [U-Boot]
printenv qemu_bootcmd
run qemu_bootcmd
```

## 9. boot script：把命令做成 `boot.scr`

另一种常见方式是写一个文本脚本 `boot.cmd`，再用 `mkimage` 生成 U-Boot 可执行的 `boot.scr`：

```bash
# [Host]
mkimage -A arm64 -O linux -T script -C none \
  -n "QEMU ARM64 boot script" \
  -d boot.cmd boot.scr
```

在 U-Boot 中加载并执行：

```bash
# [U-Boot]
load virtio 0:1 ${scriptaddr} /boot/boot.scr
source ${scriptaddr}
```

`boot.scr` 适合放在启动分区中。它比永久修改 environment 更容易替换，也更适合开发阶段调试。

## 10. 常见问题

#### `run` 提示变量不存在

使用 `printenv <name>` 确认变量名是否拼写正确。脚本变量名多了以后，命名要清晰，例如统一使用 `qemu_` 前缀。

#### 脚本定义后变量值不对

优先检查引号。需要运行时展开的变量，通常放在单引号中定义。

#### 自动启动执行的不是你刚才设置的命令

检查 `bootcmd` 是否被其他脚本覆盖。如果使用 Standard Boot，默认 `bootcmd` 可能会执行 `bootflow scan` 相关逻辑，而不是你手动写的变量。

## 本章小结

环境变量让启动流程从“临时命令”变成“可维护配置”。学习阶段建议先手动验证，再拆成变量，最后再考虑持久化保存。

## 思考与练习

1. 把你手动启动 Linux 的命令拆成至少 4 个脚本变量。
2. 使用 `run` 分段验证每个变量。
3. 解释为什么学习阶段不建议直接 `saveenv`。
