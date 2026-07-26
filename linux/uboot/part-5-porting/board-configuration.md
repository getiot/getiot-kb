---
sidebar_position: 2
sidebar_label: 板级配置与设备树适配
slug: /board-configuration
---

# U-Boot 板级配置与设备树适配

U-Boot 对一块板子的支持通常由三类内容组成：Kconfig/defconfig 选择功能，板级 C 代码处理特殊初始化，设备树描述硬件。移植时你要让这三者互相匹配。

如果把一块板子的 U-Boot 支持比作一套房子，defconfig 像“装修清单”，设备树像“户型图”，板级代码像“那些图纸表达不了的现场处理”。三者缺一块，系统就可能看起来编译成功，但上板后无法启动或设备不可用。

## 1. 从相近开发板开始

不要从空目录开始。先在 `configs/`、`board/`、`arch/`、`dts/` 中寻找同 SoC 或同系列开发板：

```bash
# [Host]
rg "YOUR_SOC_NAME" configs board arch dts
```

如果已有相近板子，复制并裁剪通常比完全新建更稳妥。

选择相近板子时，优先级通常是：

1. 同一块板的 mainline 支持。
2. 同 SoC、同 DRAM、同启动介质的开发板。
3. 同 SoC 但外设不同的开发板。
4. 同系列 SoC 的开发板。

不要只看 CPU 核心相同。启动介质、DDR 初始化、PMIC、电源时序、pinmux 都可能决定能否启动。

## 2. defconfig 负责选择功能

`configs/<board>_defconfig` 会决定：

- 目标架构和 SoC。
- 是否启用 SPL。
- 启动介质驱动。
- 命令集合。
- environment 存储方式。
- bootstd、网络、文件系统等功能。

修改配置时，建议使用：

```bash
# [Host]
make <board>_defconfig
make menuconfig
make savedefconfig
```

然后把生成的 `defconfig` 内容整理回 `configs/<board>_defconfig`。

初学者要特别理解：defconfig 不是完整配置。执行 `make <board>_defconfig` 后生成的 `.config` 才是完整展开结果。移植时经常要同时查看：

```bash
# [Host]
sed -n '1,160p' configs/<board>_defconfig
grep CONFIG_SPL .config
grep CONFIG_DM .config
```

## 3. 设备树负责描述硬件

设备树至少要正确描述：

- `memory`。
- `chosen` 中的 console。
- UART。
- 存储控制器。
- pinctrl、clock、reset。
- 以太网、USB、PMIC 等启动相关设备。

常见错误是 Linux 设备树能用，但 U-Boot 不能用。原因可能是 U-Boot 未启用对应驱动，或者早期阶段需要更小的 SPL 设备树。

### U-Boot 设备树和 Linux 设备树

有些项目会尽量复用 Linux 设备树，有些项目会维护 U-Boot 专用 `.dts` 或 `.dtsi`。差异可能来自：

- U-Boot 只需要启动相关设备。
- SPL 容量有限，需要裁剪设备树。
- 某些节点需要 `u-boot,dm-pre-reloc` 等 U-Boot 特有属性。
- Linux 驱动支持某个 binding，但 U-Boot 驱动暂不支持。

所以“Linux 能识别设备”不等于“U-Boot 一定能识别设备”。

## 4. 板级代码处理特殊逻辑

如果某些初始化无法单靠设备树表达，就需要板级代码。例如读取板卡版本、设置 GPIO、电源域、MAC 地址、DRAM size 修正等。

板级代码应尽量少。能放到设备树和通用驱动里的内容，不要写成板级私有逻辑。

常见板级代码路径可能在：

```bash
board/<vendor>/<board>/
arch/<arch>/mach-<soc>/
```

阅读时先找：

- `board_init()`
- `dram_init()`
- `board_late_init()`
- SPL 相关初始化函数

具体函数名会随平台变化。

## 5. 环境变量位置也属于板级适配

environment 存储位置由配置决定。移植时必须确认：

- environment 存在哪里。
- 大小是多少。
- 是否冗余。
- 默认环境是什么。
- `saveenv` 是否安全。

如果 environment 偏移配置错误，保存环境变量可能覆盖 U-Boot、kernel 或分区表。这类错误很隐蔽，也很危险。

## 6. 最小适配检查清单

上板前检查：

- defconfig 是否来自正确基线。
- `.config` 是否启用目标启动介质。
- 串口驱动是否启用，SPL 阶段是否也启用。
- 设备树 `memory`、`chosen`、UART、启动介质节点是否正确。
- 如果需要 SPL，SPL 设备树是否包含早期设备。
- environment 存储位置是否明确。

## 本章小结

板级适配不是只改一个文件。你需要让 defconfig、设备树、板级代码和驱动配置保持一致。排查时先确认“配置启用了没有，设备树描述了没有，驱动绑定了没有”。

## 思考与练习

1. 为目标板找到一个最相近的 mainline defconfig。
2. 比较原厂设备树和 mainline 设备树中 UART、memory、启动介质节点的差异。
3. 说明为什么 `saveenv` 的安全性属于板级适配问题。
