---
sidebar_position: 2
sidebar_label: 运行 U-Boot
slug: /first-run
---

# 第一次运行 U-Boot

上一章准备了 QEMU 和 ARM64 U-Boot 镜像。本章将第一次启动它：观察启动信息、进入 `=>` 命令行，完成几项只读检查，然后复位并安全退出 QEMU。

> 本教程以 Mainline U-Boot v2026.07、Ubuntu 24.04 x86_64 和 QEMU ARM64 `virt` 为基准。命令前的 `[Host]` 与 `[U-Boot]` 表示执行位置，不是命令的一部分。

## 学习目标

阅读本章后，你将能够：

- 使用 QEMU ARM64 `virt` 启动 `u-boot.bin`
- 理解启动命令中各个参数的作用
- 识别 U-Boot 启动横幅、自动启动倒计时和命令提示符
- 区分 Host Shell、U-Boot Console 与 QEMU Monitor
- 使用几个无破坏性的命令验证 U-Boot
- 复位 U-Boot，并正确退出 QEMU
- 编写可重复使用的 QEMU 启动脚本

## 前置知识

必须先完成[搭建 QEMU 实验环境](/uboot/qemu-environment/)中的环境验收，确认 `~/uboot-lab/images/u-boot-v2026.07-qemu-arm64.bin` 已就绪。若上一章未输出 `PASS`，请先不要继续本章。

## 1. 启动前检查

本章沿用上一章建立的目录：

```bash
~/uboot-lab/
├── build/
├── images/
│   └── u-boot-v2026.07-qemu-arm64.bin
├── scripts/
└── src/
```

先确认 QEMU 和 U-Boot 镜像都已准备好：

```bash
# [Host]
command -v qemu-system-aarch64
test -s "$HOME/uboot-lab/images/u-boot-v2026.07-qemu-arm64.bin" \
    && echo "PASS: U-Boot image is ready"
```

第一条命令应输出 QEMU 程序路径，例如 `/usr/bin/qemu-system-aarch64`。第二条在镜像存在且非空时应输出 `PASS: U-Boot image is ready`。若检查失败，请先回到上一章完成镜像构建和复制。

## 2. 第一次启动

在 Host Shell 中执行：

```bash
# [Host]
qemu-system-aarch64 \
    -machine virt \
    -cpu cortex-a57 \
    -m 512M \
    -nographic \
    -bios "$HOME/uboot-lab/images/u-boot-v2026.07-qemu-arm64.bin"
```

按下 Enter 后，当前终端会被 QEMU 接管，并开始显示 U-Boot 的串口输出。

这条命令不需要 `sudo`，也不需要 `-enable-kvm`。QEMU 正在 x86_64 Host 上模拟 AArch64 机器；本实验使用软件模拟即可。

### 2.1 参数说明

| 参数 | 作用 |
| --- | --- |
| `qemu-system-aarch64` | 启动 AArch64 System Emulator |
| `-machine virt` | 创建通用 ARM `virt` 虚拟机器 |
| `-cpu cortex-a57` | 指定支持 AArch64 的 CPU Model |
| `-m 512M` | 为虚拟机器分配 512 MiB RAM |
| `-nographic` | 不创建图形窗口，把串口和 QEMU Monitor 复用到当前终端 |
| `-bios <file>` | 把指定文件作为虚拟机固件运行 |

这里需要特别注意两个参数。

第一，`qemu-system-aarch64` 仍应显式指定一个 64 位 CPU，例如 `cortex-a57`。U-Boot 官方文档指出，不指定时 QEMU 可能以 32 位模式启动，无法正确运行当前的 AArch64 镜像。

第二，U-Boot 在本实验中是虚拟机固件，所以使用 `-bios`，不是 `-kernel`。`-kernel` 通常用于让 QEMU 直接装载 Kernel；那会绕开本章要观察的固件启动过程。

## 3. 认识第一次启动输出

你会看到类似下面的内容：

```bash
U-Boot 2026.07 (...)

DRAM:  512 MiB
Core:  ...
Flash: ...
Loading Environment ...
In:    serial@...
Out:   serial@...
Err:   serial@...
Net:   ...
Hit any key to stop autoboot:  0
...
=>
```

这段输出是结构示例，不是要求逐字一致的标准答案。编译器版本、构建时间、启用的设备、环境存储后端和 U-Boot 配置不同，日志内容也会不同。

第一次运行时，先关注下面几项：

| 输出 | 含义 |
| --- | --- |
| `U-Boot 2026.07` | 当前运行的 U-Boot 版本 |
| `DRAM: 512 MiB` | U-Boot 识别到 QEMU 提供的内存 |
| `In`、`Out`、`Err` | 标准输入、标准输出和标准错误使用的 Console |
| `Hit any key to stop autoboot` | U-Boot 正在等待是否中断自动启动 |
| `=>` | U-Boot 命令行提示符 |

看到 `=>` 说明 U-Boot 已经完成了足以进入主循环的初始化，并准备接收命令。它不代表 Linux 已经启动。

### 3.1 为什么还会出现启动扫描信息

U-Boot 倒计时结束后会执行默认启动流程。当前虚拟机没有连接磁盘，也没有提供 Linux Kernel，因此 U-Boot 可能扫描可用的 Boot Device、寻找 Bootflow，并输出“没有找到可启动内容”一类信息（若启用了 Standard Boot，还可能看到与 `bootflow` / bootdev 相关的提示）。

这通常不是故障。只要最终可以回到 `=>`，就可以继续本章实验。

不同配置的默认启动行为可能不同：有的会完成扫描后返回命令行，有的可能再次尝试启动。为了获得稳定的实验入口，建议在倒计时期间按任意键。

## 4. 中断自动启动

重新执行启动命令。当出现：

```bash
Hit any key to stop autoboot:  2
```

立即按任意键，例如空格键。倒计时会停止并出现：

```bash
=>
```

这一步称为 **中断自动启动**。在真实开发板上，串口工具也使用相同思路：上电后观察日志，在 `bootdelay` 倒计时结束前发送按键。

如果没有及时按键，不需要关闭终端。等待 U-Boot 返回提示符；如果当前配置持续尝试启动，可以使用本章后面介绍的 QEMU 退出键重新开始。

## 5. 不要混淆三种命令行

使用 `-nographic` 后，同一个终端承载了多个交互环境。判断当前所在位置时，先看提示符。

| 环境 | 常见提示符 | 可以输入什么 |
| --- | --- | --- |
| Host Shell | `$`、`user@host:~$` | `qemu-system-aarch64`、`ls`、`chmod` 等 Linux 命令 |
| U-Boot Console | `=>` | `version`、`bdinfo`、`printenv` 等 U-Boot 命令 |
| QEMU Monitor | `(qemu)` | `info registers`、`quit` 等 QEMU Monitor 命令 |

例如：

```bash
$ qemu-system-aarch64 ...   ← Host Shell
...
=> version                  ← U-Boot Console
```

QEMU 运行期间，普通键盘输入会发送给当前复用的虚拟串口。此时即使终端外观没有变化，也不能在 `=>` 后输入 `ls`、`cd` 或 `sudo` 等 Host 命令。

同样，`(qemu)` 是 QEMU 自身的调试和控制界面，不是 U-Boot。如果误切换到 QEMU Monitor，可以按 `Ctrl+A`，松开后再按 `c`，切回串口。

## 6. 完成最小验证

进入 `=>` 后，先执行几个无破坏性的命令。

### 6.1 查看版本

```bash
# [U-Boot]
=> version
```

输出应包含：

```bash
U-Boot 2026.07
```

它验证了当前运行的镜像版本。构建时间、编译器和 Git Revision 等附加信息可能因构建方式而异。

### 6.2 输出文本

```bash
# [U-Boot]
=> echo Hello from U-Boot
Hello from U-Boot
```

这验证了命令解析和 Console 输出。

### 6.3 查看自动启动等待时间

```bash
# [U-Boot]
=> printenv bootdelay
```

可能看到类似：

```bash
bootdelay=2
```

具体数值取决于默认配置。如果输出 `## Error: "bootdelay" not defined`，表示该环境变量没有显式定义，并不代表 U-Boot 启动失败。

### 6.4 查看板级信息

```bash
# [U-Boot]
=> bdinfo
```

`bdinfo` 会显示当前架构、内存区域、设备树地址、Console Baud Rate 等板级信息。输出较长，本章暂时不逐项解释；此处只需确认命令可以执行，并观察内存容量与启动参数是否一致。

以上命令都不会擦除 Flash、修改存储设备或永久保存环境变量，适合作为第一次运行时的检查项。命令语法、参数、返回值和常用命令会在下一章系统介绍。

## 7. 复位 U-Boot

在 U-Boot Console 中执行：

```bash
# [U-Boot]
=> reset
```

`reset` 请求复位 CPU。QEMU ARM `virt` 提供 PSCI System Reset，因此虚拟机会重新开始启动，并再次显示 U-Boot 横幅。

复位后，尝试再次中断自动启动并执行：

```bash
# [U-Boot]
=> version
```

这验证了“启动—进入命令行—复位—再次启动”的完整闭环。

> `=> reset` 是 U-Boot 的系统复位命令。本文后面用于修复 Host 终端显示的 `reset` 是 Linux Shell 命令。二者名称相同，但执行位置和作用完全不同。

## 8. 正确退出 QEMU

在 `-nographic` 模式下，退出 QEMU 的默认按键序列是：

```bash
Ctrl+A，然后按 x
```

操作时先按住 `Ctrl` 并按一下 `A`，松开后再按小写字母 `x`，不需要按 `Shift`。这是一组顺序按键，不是同时按住三个键。

常用的 QEMU Multiplexer 按键还有：

| 按键序列 | 作用 |
| --- | --- |
| `Ctrl+A`，然后 `h` | 显示按键帮助 |
| `Ctrl+A`，然后 `c` | 在串口与 QEMU Monitor 之间切换 |
| `Ctrl+A`，然后 `x` | 退出 QEMU |

成功退出后，你会回到 Host Shell 提示符：

```bash
user@host:~$
```

不要把 `Ctrl+C` 作为本教程的主要退出方式。`-nographic` 会复用串口与 Monitor，`Ctrl+C` 可能被传递给 U-Boot 或以后运行的 Linux Guest，行为与普通 Host 程序不同。

### 8.1 终端显示异常怎么办

如果 QEMU 被异常终止，Host 终端可能出现不回显、换行错乱等问题。确认已经回到 Host Shell 后执行：

```bash
# [Host]
stty sane
```

如果仍未恢复，可以执行：

```bash
# [Host]
reset
```

不要在 `=>` 或 `(qemu)` 后执行这两个 Host 命令。

## 9. 建立可重复使用的启动脚本

每次手工输入完整命令既繁琐，也容易漏掉参数。使用你熟悉的文本编辑器创建：

```bash
~/uboot-lab/scripts/run-uboot.sh
```

写入以下内容：

```bash showLineNumbers
#!/usr/bin/env bash
# set -euo pipefail：遇错退出、未定义变量报错、管道失败也算失败
set -euo pipefail

readonly LAB_DIR="${HOME}/uboot-lab"
readonly UBOOT_BIN="${LAB_DIR}/images/u-boot-v2026.07-qemu-arm64.bin"

if [[ ! -s "${UBOOT_BIN}" ]]; then
    echo "Error: U-Boot image not found: ${UBOOT_BIN}" >&2
    exit 1
fi

exec qemu-system-aarch64 \
    -machine virt \
    -cpu cortex-a57 \
    -m 512M \
    -nographic \
    -bios "${UBOOT_BIN}"
```

保存后先检查 Bash 语法，再添加执行权限：

```bash
# [Host]
bash -n "$HOME/uboot-lab/scripts/run-uboot.sh"
chmod +x "$HOME/uboot-lab/scripts/run-uboot.sh"
```

以后可以直接运行：

```bash
# [Host]
"$HOME/uboot-lab/scripts/run-uboot.sh"
```

脚本使用 `exec` 让 QEMU 替换当前脚本进程，并在启动前检查镜像是否存在且非空。将参数集中在一个脚本中，也便于后续逐步加入虚拟磁盘、网络设备和调试选项。

## 10. QEMU 在启动过程中做了什么

可以简化理解为：

1. 创建 ARM `virt` 机器，并配置 CPU 与 RAM
2. 将 U-Boot 放入模拟 Flash 基址（常为 `0x0`）
3. 生成设备树，并放到 DRAM 约定位置（`virt` 上 DRAM 基址常见为 `0x40000000`）
4. 复位 CPU，开始执行 U-Boot proper

本章没有模拟某款 SoC 的 Boot ROM、DDR Training 或多阶段加载链。更完整的对照见[本教程中的 QEMU 启动链](/uboot/boot-process/)。

## 11. 一个简单的参数实验

退出 QEMU，把启动脚本中的：

```bash
-m 512M
```

临时改为：

```bash
-m 256M
```

重新运行脚本，并在 U-Boot 中执行：

```bash
# [U-Boot]
=> bdinfo
```

对比两次输出中的 DRAM Size。这个实验说明：U-Boot 显示的内存不是写死在日志中的文字，而是来自 QEMU 创建的虚拟硬件及其 Device Tree 描述。

实验完成后，把脚本恢复为 `-m 512M`，以便后续章节使用统一配置。

## 12. 当前环境变量不会持久保存

本章的 QEMU 命令只通过 `-bios` 提供 U-Boot 镜像，没有连接单独的可写环境存储镜像。因此，即使你在 U-Boot 中临时修改环境变量，退出或重新启动 QEMU 后也不应依赖这些修改仍然存在。

U-Boot 官方 QEMU 文档给出的持久环境方案，是额外创建一个 `envstore.img`，并把它作为第二个 pflash Device 连接。这个机制会在后面的[环境变量与启动脚本](/uboot/environment-and-scripts/)中介绍。

:::warning
现阶段请不要尝试 `saveenv` / `env save`。本章的 QEMU 命令没有连接可写环境存储；第一次运行只使用只读检查命令即可。
:::

## 13. 常见问题

### 13.1 QEMU 找不到镜像

错误可能类似：

```bash
qemu-system-aarch64: Could not find ROM image ...
```

检查文件路径：

```bash
# [Host]
ls -lh "$HOME/uboot-lab/images/u-boot-v2026.07-qemu-arm64.bin"
```

如果文件不存在或大小为 0，请回到上一章重新复制构建产物。

### 13.2 启动后没有任何输出

依次检查：

1. 命令中是否包含 `-nographic`
2. `-bios` 指向的是否为 AArch64 `u-boot.bin`
3. 镜像是否由 `qemu_arm64_defconfig` 构建
4. 命令中是否误加了 `-S`
5. CPU 是否显式指定为 `cortex-a57`

`-S` 会让 QEMU 创建虚拟机后暂停 CPU，必须在 Monitor 中继续执行；本教程的普通启动命令不使用它。

### 13.3 使用了错误架构的镜像

如果把 ARM32、x86 或其他架构的 U-Boot 镜像交给当前命令，可能没有输出，也可能立即出现异常。

在 Host Shell 中检查构建产物：

```bash
# [Host]
file "$HOME/uboot-lab/build/qemu-arm64/u-boot"
```

结果应包含：

```bash
ELF 64-bit ... ARM aarch64 ...
```

`u-boot.bin` 是 Raw Binary，不包含完整的 ELF Metadata，所以应检查构建目录中的 `u-boot` ELF 文件。

### 13.4 一直看到自动启动扫描

当前实验没有连接磁盘或 Kernel，默认启动流程找不到操作系统是正常现象。重新运行 QEMU，并在 `Hit any key to stop autoboot` 倒计时期间按空格键。

### 13.5 提示符变成了 `(qemu)`

你进入了 QEMU Monitor。按：

```bash
Ctrl+A，然后按 c
```

即可切回虚拟串口和 U-Boot Console。

### 13.6 `Ctrl+A`、`x` 无法退出

先按：

```bash
Ctrl+A，然后按 h
```

查看当前 Multiplexer 的按键帮助。注意先发送 `Ctrl+A`，松开后再按 `x`，不要同时按下三个键。终端模拟器或外层 Multiplexer 也可能拦截该组合键。

### 13.7 `bdinfo` 的地址与示例不同

这是正常现象。地址可能随 U-Boot 版本、配置、内存容量和重定位位置变化。不要把示例地址直接复制到自己的启动脚本中；后续章节会解释如何从变量和板级信息中选择加载地址。

## 14. 完成标准

如果你已经完成下面所有操作，本章实验就通过了：

- 启动 QEMU ARM64 `virt`
- 看到 `U-Boot 2026.07` 横幅
- 看到约 512 MiB DRAM
- 中断自动启动并进入 `=>`
- 成功执行 `version`、`echo` 和 `bdinfo`
- 使用 `reset` 重新启动虚拟机
- 使用 `Ctrl+A`、`x` 退出 QEMU
- 创建并运行 `run-uboot.sh`

## 15. 容易混淆的概念

| 说法 | 正确理解 |
| --- | --- |
| “QEMU 已经启动成功” | 只说明虚拟机进程在运行，不一定说明 U-Boot 已正确执行 |
| “看到了 `=>`” | 表示进入 U-Boot Console，不表示 Linux 已启动 |
| “使用了 `-bios`” | 表示把文件作为虚拟固件运行，不是在真实 Flash 上烧录 |
| “执行 `reset`” | 必须根据提示符判断是复位 U-Boot，还是重置 Host 终端 |
| “修改了环境变量” | 当前只修改内存中的环境，不代表已经持久保存 |
| “进入了 `(qemu)`” | 这是 QEMU Monitor，不是 U-Boot 命令行 |

## 本章小结

本章使用 QEMU ARM64 `virt` 运行了 U-Boot v2026.07，认识了启动横幅、自动启动倒计时和 `=>` 提示符，并完成版本检查、复位和退出。通过固定启动脚本，你已经建立了可重复使用的 U-Boot 实验入口。

## 思考与练习

1. `-bios` 与 `-kernel` 在本实验中的用途有什么区别？
2. 为什么需要显式指定 `-cpu cortex-a57`？
3. `-nographic` 对串口和 QEMU Monitor 做了什么？
4. `=>`、`(qemu)` 和 `$` 分别属于哪个环境？
5. 倒计时结束后找不到可启动设备，为什么不一定是故障？
6. 把内存从 512 MiB 改成 256 MiB 后，U-Boot 从哪里得知新的容量？
7. 为什么当前实验不应该依赖环境变量在重启后继续存在？
8. 不退出 QEMU，尝试在 U-Boot Console 与 QEMU Monitor 之间切换两次。

## 参考资料

- [U-Boot：QEMU ARM](https://docs.u-boot.org/en/v2026.07/board/emulation/qemu-arm.html)
- [U-Boot：reset command](https://docs.u-boot.org/en/v2026.07/usage/cmd/reset.html)
- [QEMU：Invocation](https://www.qemu.org/docs/master/system/invocation.html)
