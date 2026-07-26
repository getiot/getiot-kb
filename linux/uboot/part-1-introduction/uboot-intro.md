---
sidebar_position: 2
sidebar_label: U-Boot 简介
slug: /what-is-uboot
---

# U-Boot 简介

上一章介绍了嵌入式系统为什么需要 Bootloader，以及典型启动链包含哪些阶段。本章进一步认识 U-Boot：它是什么、从哪里发展而来、能解决哪些问题，以及 Mainline U-Boot 与厂商版本有什么区别。

> 本教程以 Mainline U-Boot v2026.07 为基准。U-Boot 的具体功能由编译配置和硬件平台决定，不同设备上的命令和启动流程可能并不相同。

## 学习目标

阅读本章后，你将能够：

- 说明 U-Boot 的主要定位
- 了解 U-Boot 的名称和发展脉络
- 认识 U-Boot 的典型应用场景与主要能力
- 理解命令、环境变量和自动启动之间的关系
- 区分 Mainline U-Boot 与厂商 U-Boot
- 判断一份教程或命令是否适用于自己的设备

## 前置知识

建议先阅读[嵌入式系统与 Bootloader](/uboot/embedded-system-and-bootloader/)。

## 1. U-Boot 是什么

U-Boot 是一个面向嵌入式系统的开源 Bootloader。它可以初始化和测试必要的硬件，从存储设备或网络中加载程序，并将控制权交给操作系统或其他目标程序。

在嵌入式 Linux 系统中，它最常见的任务是：

1. 完成启动所需的硬件初始化
2. 确定从哪里启动
3. 加载 Linux 内核、设备树和可选的 initramfs
4. 准备启动参数
5. 验证镜像并跳转到内核入口

不过，U-Boot 不只是一个“复制内核并跳转”的小程序。它还提供命令行、环境变量、启动脚本、设备驱动、文件系统、网络协议、镜像管理和固件升级等能力。

可以把 U-Boot 理解成操作系统启动前的小型运行环境：

```mermaid
flowchart LR
    A["存储 / 网络 / 调试输入"] --> B["U-Boot"]
    B --> C["Linux 或其他目标程序"]
```

这套环境的最终目的仍然是启动后续系统，而不是长期代替操作系统运行。

## 2. “Das U-Boot”与“U-Boot”

项目的正式名称是 **Das U-Boot**，日常文档和技术交流中使用 **U-Boot**。

其中，“U-Boot”是德语 `Unterseeboot`（潜艇）的简称，“Das”是德语定冠词。它是项目名称，并不是由某个英文技术短语的首字母组成的缩写。

书写时应注意：

| 使用位置 | 推荐写法 |
| --- | --- |
| 正文、标题和注释 | `U-Boot` |
| 源码目录和仓库名 | `u-boot` |
| 文件名 | `u-boot.bin`、`u-boot.dtb` |
| C 标识符和配置宏 | `u_boot`、`U_BOOT_*`、`CONFIG_*` |

因此，本教程始终写作 `U-Boot`，不使用 `Uboot` 或 `U-boot`。

## 3. U-Boot 的发展脉络

U-Boot 并不是从一开始就以现在的形式出现。根据项目源码中的历史说明，它的发展可以概括为：

1. 早期工作源自面向 PowerPC 8xx 系列的 8xxROM
2. 在此基础上形成 PPCBoot
3. 随后出现面向 ARM 的 ARMBoot
4. 项目逐步支持更多处理器架构和开发板
5. 最终发展为今天的 U-Boot

Wolfgang Denk 是 U-Boot 早期发展和长期维护中的关键人物。如今，U-Boot 已经成为由维护者、芯片厂商、设备厂商和开源社区共同参与的项目。

U-Boot 的正式版本采用按年份和月份编号的方式，例如：

```bash
v2025.10
v2026.01
v2026.04
v2026.07
```

版本号 `v2026.07` 表示 2026 年 7 月发布的版本。候选版本会增加 `-rc` 后缀，例如 `v2026.10-rc1`。

U-Boot 通常大约每三个月发布一个正式版本（以[官方 Release Cycle](https://docs.u-boot.org/en/v2026.07/develop/release_cycle.html) 为准）。编写教程或开发产品时，应固定到明确的正式版本或 Git commit，不要直接依赖不断变化的 `master` 分支。

## 4. U-Boot 的首要目标

U-Boot 功能很多，但它的首要目标始终是：

> 尽快、可靠地加载并启动操作系统。

U-Boot 的官方设计原则强调保持小巧、快速、简单和可移植。对最终用户来说，U-Boot 通常不是产品本身，而只是从按下电源键到应用程序开始运行之间的一个过渡阶段。

因此，U-Boot 的设计重点与 Linux 不同：

| U-Boot | Linux |
| --- | --- |
| 只需建立启动所需的运行环境 | 建立完整的操作系统运行环境 |
| 通常只初始化启动会使用的设备 | 通过驱动管理系统中的各种设备 |
| 重点是可靠加载和移交控制权 | 重点是进程、内存、设备和资源管理 |
| 运行时间通常较短 | 在设备工作期间持续运行 |
| 功能由板级配置裁剪 | 功能由内核配置、模块和用户空间共同组成 |

开发调试时，我们可能长时间停留在 U-Boot 命令行中；但在正常产品中，U-Boot 往往只运行很短时间，然后自动启动操作系统。

## 5. U-Boot 的典型应用场景

### 5.1 启动操作系统

这是 U-Boot 最核心的用途。它可以从 eMMC、SD 卡、SPI Flash、NAND Flash、USB 存储设备或网络中加载 Linux，也可以启动其他受支持的操作系统、EFI 应用或独立程序。

### 5.2 新硬件调试

一块新开发板刚刚点亮时，Linux 往往还无法启动。开发者可以先通过 U-Boot 验证串口、DRAM、存储、以太网和部分外设是否基本可用。这种工作通常称为 **Board Bring-up**。

### 5.3 系统调试与故障排查

即使 Linux 无法启动，U-Boot 命令行仍可能提供查看内存、分区、文件和环境变量，以及手动加载不同内核或设备树的入口。

### 5.4 网络启动

在内核和根文件系统频繁变化的开发阶段，可通过 DHCP、TFTP 或 NFS 等方式减少反复烧录。U-Boot 通常负责通过网络获取内核和设备树；Linux 启动后可以继续使用 NFS 根文件系统。

### 5.5 固件升级与故障恢复

U-Boot 可以参与系统升级、A/B 启动、Recovery、Fastboot、USB DFU 等流程。当主系统损坏时，还可能从备用分区或恢复镜像启动。

### 5.6 生产测试

在生产阶段，U-Boot 可配合脚本检查部分硬件，或写入序列号、网络地址等。这类命令通常属于厂商或产品定制，并不一定包含在 Mainline U-Boot 中。

## 6. U-Boot 具备哪些能力

| 类别 | 典型能力 |
| --- | --- |
| 处理器与板级支持 | 支持多种处理器架构、SoC 和开发板 |
| 设备驱动 | 串口、时钟、GPIO、I2C、SPI、MMC、USB、网卡等 |
| 存储与分区 | MMC、NVMe、SATA、NAND、SPI Flash、GPT、MBR 等 |
| 文件系统 | FAT、EXT 系列、SquashFS、UBIFS 等，具体取决于配置 |
| 网络 | DHCP、TFTP、NFS、PXE 等 |
| 命令行 | 查看和修改内存、环境变量、设备及文件 |
| 启动方式 | 手动启动、启动脚本、Standard Boot、EFI 启动等 |
| 镜像处理 | Legacy Image、FIT、压缩镜像、哈希和签名验证 |
| 更新与恢复 | DFU、Fastboot、备用启动、Recovery 等 |
| 调试与测试 | 日志、内存测试、设备树查看、驱动模型命令等 |

这张表描述的是 U-Boot 项目整体具备的能力，不代表每一份 U-Boot 镜像都包含这些功能。

U-Boot 使用 Kconfig 和板级 `defconfig` 对功能进行裁剪。只有启用了相应的 `CONFIG_CMD_*` 等配置，命令才会出现在最终镜像中；只有包含对应驱动，U-Boot 才能访问某类硬件。

所以，当你在文档中看到一条命令，却在自己的开发板上得到：

```bash
Unknown command
```

不一定是输入错误，也可能是当前 U-Boot 没有编译这条命令。

## 7. 命令行、环境变量和启动脚本

U-Boot 启动后通常提供交互式命令行，提示符一般是：

```bash
=>
```

你可以在这里执行命令，例如查看版本、列出设备或手动启动 Linux。

U-Boot 命令行与 Linux Shell 有些相似，但两者不是同一个运行环境。U-Boot 中通常没有 Linux 进程、用户权限、软件包管理和完整的 POSIX 文件系统语义。

三者的关系可以概括为：

| 概念 | 作用 | 示例 |
| --- | --- | --- |
| 命令 | 完成单个操作 | `md`、`ext4load`、`booti` |
| 环境变量 | 保存参数或一组命令 | `bootdelay`、`bootcmd`、`bootargs` |
| 启动脚本 | 组合命令并表达启动逻辑 | 写在 `bootcmd` 或其他变量中的多条命令 |

常见环境变量包括：

- `bootdelay`：自动启动前等待多长时间
- `bootcmd`：自动启动时执行什么
- `bootargs`：传递给 Linux 的内核命令行
- `loadaddr`：常用的文件加载地址
- `ipaddr`、`serverip`：网络启动使用的地址

:::warning
修改环境变量与执行 `env save` 是两件事。前者通常只改变内存中的当前环境，后者会写入持久化存储。保存前必须确认该开发板的环境存储位置和冗余方案。
:::

命令练习、脚本语法和环境变量细节见后续[命令行与常用命令](/uboot/commands/)、[环境变量与启动脚本](/uboot/environment-and-scripts/)。

## 8. U-Boot 如何启动操作系统

从使用者角度看，可以把启动方式分成三个层次：

1. **手动启动**：逐条选择设备、加载内核与设备树、设置 `bootargs`、执行 `booti` / `bootz` / `bootm`。步骤多，但最适合理解每个动作。
2. **环境变量与脚本自动启动**：把手动命令整理进 `bootcmd` 等变量，倒计时结束后自动执行。旧项目和厂商 BSP 中仍很常见。
3. **Standard Boot**：用统一框架扫描可启动设备和启动配置，引入 `bootdev`、`bootmeth`、`bootflow` 等概念，减少每块板手写一套复杂脚本。

教程后面会先带你手动启动 Linux，再学环境变量与脚本，最后介绍 Standard Boot。这样既能理解底层动作，也能看懂现代框架和旧版 BSP。

## 9. U-Boot 不只是一个二进制文件

初学者常把 U-Boot 理解为一个固定的 `u-boot.bin`。实际上，U-Boot 是一个源码项目，会根据架构、开发板和构建配置生成不同产物。

| 文件 | 常见含义 |
| --- | --- |
| `u-boot` | ELF 格式，含符号信息，适合调试 |
| `u-boot.bin` | 不带 ELF 头的原始二进制镜像 |
| `u-boot.dtb` | U-Boot 自身使用的设备树 |
| `u-boot.img` | 带 Legacy Image 头的镜像 |
| `u-boot.itb` | 使用 FIT 格式打包的镜像 |
| `spl/u-boot-spl.bin` | U-Boot SPL 的二进制文件 |

某个平台可能只使用其中一部分，也可能通过 Binman 或厂商工具生成组合镜像。文件名相同也不意味着可以在不同开发板之间通用。

## 10. Mainline U-Boot 与厂商 U-Boot

### 10.1 Mainline U-Boot

Mainline U-Boot 指官方上游仓库中的版本。它由社区按统一规范维护，采用固定发布周期，官方文档也主要描述这一版本。更适合学习通用机制、跟进新架构，以及向社区提交可复用改进。

### 10.2 厂商 U-Boot

芯片或开发板厂商经常基于某个 U-Boot 版本建立自己的分支，并加入尚未合入上游的 SoC / 板级支持、DDR 固件、镜像格式与烧录工具、量产或安全启动功能等。

| 对比项 | Mainline U-Boot | 厂商 U-Boot |
| --- | --- | --- |
| 维护来源 | U-Boot 上游社区 | 芯片厂商、板卡厂商或产品团队 |
| 版本 | 通常较新且持续发布 | 可能长期停留在某个旧版本 |
| 通用性 | 强调跨平台和可维护性 | 强调特定芯片或产品可用 |
| 新硬件支持 | 需要硬件支持进入上游 | 往往更早支持厂商最新硬件 |
| 文档来源 | U-Boot 官方文档 | 厂商 BSP、SDK 和开发板文档 |
| 直接替换风险 | 不能保证兼容厂商镜像和启动链 | 通常与厂商固件组合绑定 |

:::danger
不要因为 Mainline U-Boot 版本更新，就直接把它烧录到使用厂商 BSP 的设备中。DDR 固件、镜像布局、签名方式和写入偏移不匹配，都可能导致设备无法启动。
:::

本教程使用 Mainline U-Boot 建立通用知识，再在真实硬件章节中讨论厂商 BSP 和平台差异。

## 11. U-Boot 适合哪些系统

U-Boot 特别适合：使用 Linux 等复杂操作系统、需要多种存储 / 网络启动、需要命令行调试或 Recovery、希望使用设备树、FIT、Standard Boot 等通用机制的场景。

它不是所有嵌入式产品的唯一选择。资源有限的 MCU 可能更适合简单启动代码或 MCUboot；PC 通常采用 UEFI 配合 GRUB 等；部分 Android 与安全设备会使用高度定制的厂商 Bootloader。

## 12. 如何识别自己正在使用的 U-Boot

进入 U-Boot 后，启动横幅通常会显示版本、编译时间和平台信息。在命令行中执行 `version`，通常也可以查看版本和编译信息。

```bash
# [U-Boot]
=> version
```

不过，仅看到一个版本号还不够。判断一份教程是否适用时，至少要确认：

1. 使用的是 Mainline 还是厂商分支
2. 对应的 SoC 和开发板是什么
3. U-Boot 的具体版本或 Git commit 是什么
4. 使用哪个 `defconfig`
5. 命令和驱动是否已经启用
6. 启动链中是否还有 SPL、TF-A、OpenSBI 或厂商 Loader

这些信息会直接影响构建命令、镜像文件、烧录位置和启动方法。

## 13. 常见认识误区

#### 误区一：所有 U-Boot 都具有相同命令

不是。命令和驱动由 Kconfig 与板级配置决定。

#### 误区二：版本号相同，生成的镜像就可以通用

不是。U-Boot 是针对具体硬件配置构建的。

#### 误区三：Mainline U-Boot 一定比厂商版本更适合真实硬件

不一定。Mainline 更适合学习通用机制和长期维护，但某些新硬件可能仍依赖厂商补丁、固件和打包工具。

#### 误区四：U-Boot 命令行就是一个精简版 Linux Shell

不是。两者在变量、命令、文件访问和脚本能力上存在明显差异。

#### 误区五：能够修改环境变量，就一定能够安全保存

不是。持久化环境的位置和格式由平台决定，错误保存可能覆盖其他数据或破坏启动配置。

## 本章小结

U-Boot 是面向嵌入式系统的开源 Bootloader，核心任务是可靠地加载并启动操作系统。它同时提供命令行、环境变量、设备访问和升级恢复等能力。学习时需要区分 Mainline 与厂商版本，并认识到每份镜像都由具体硬件和构建配置决定。

## 思考与练习

1. U-Boot 与 Linux 的主要职责有什么不同？
2. 为什么在文档中看到的命令可能不存在于自己的开发板中？
3. Mainline U-Boot 和厂商 U-Boot 各有什么优势和限制？
4. 如何判断一块开发板当前运行的是 Mainline 还是厂商分支？
5. 找一份开发板的启动日志，记录它的 U-Boot 版本、开发板型号和启动介质。

## 参考资料

- [U-Boot 官方源码与 README](https://git.u-boot-project.org/u-boot/u-boot)
- [U-Boot Design Principles](https://docs.u-boot.org/en/v2026.07/develop/designprinciples.html)
- [U-Boot Release Cycle](https://docs.u-boot.org/en/v2026.07/develop/release_cycle.html)
- [U-Boot Environment Variables](https://docs.u-boot.org/en/v2026.07/usage/environment.html)
- [Standard Boot Overview](https://docs.u-boot.org/en/v2026.07/develop/bootstd/overview.html)
- [U-Boot Flat Image Tree](https://docs.u-boot.org/en/v2026.07/usage/fit/index.html)
