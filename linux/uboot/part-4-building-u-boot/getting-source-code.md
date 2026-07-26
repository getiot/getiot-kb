---
sidebar_position: 2
sidebar_label: 获取 U-Boot 源代码
slug: /getting-source-code
---

# 获取 U-Boot 源代码

本教程使用 Mainline U-Boot v2026.07。配套实验代码会维护在 GitHub 仓库 [getiot/uboot-courses](https://github.com/getiot/uboot-courses)。建议你先下载实验仓库：

```bash
# [Host]
git clone https://github.com/getiot/uboot-courses.git
cd uboot-courses
```

如果仓库中已经包含或你已经手动下载了 U-Boot v2026.07 源码，请确认源码位于：

```bash
# [Host]
cd /home/rudy/workspace/Projects/GetIoT/uboot-courses/u-boot-v2026.07
```

如果你使用不同的工作目录，请把后续命令中的 `/home/rudy/workspace/Projects/GetIoT/uboot-courses` 替换成自己的本地路径。

:::tip
教程中出现的绝对路径是为了让命令更明确。你不必使用完全相同的目录，只要保持实验仓库内部结构一致即可。
:::

## 1. 确认源码版本

查看源码根目录：

```bash
# [Host]
ls
```

你应该能看到 `Makefile`、`Kconfig`、`arch`、`board`、`cmd`、`common`、`drivers`、`doc` 等目录或文件。

确认版本信息：

```bash
# [Host]
make --no-print-directory -s ubootversion
```

预期版本应接近：

```bash
2026.07
```

如果你使用 Git 获取源码，也可以查看 tag：

```bash
# [Host]
git describe --tags
```

如果源码不是 Git checkout，而是从压缩包解压出来，`git describe` 可能不可用。这不是问题，只要源码内容确实对应 v2026.07 即可。

## 2. 为什么固定版本

U-Boot 是持续演进的项目。命令、配置选项、默认启动框架、文档位置都可能随版本变化。固定 v2026.07 的好处是：

- 教程命令更容易复现。
- 读者遇到问题时可以对齐同一份源码。
- 后续分析源码路径时不会频繁漂移。

:::note
如果你使用发行版软件仓库中的 `u-boot-tools`，它只提供 `mkimage`、`dumpimage` 等主机工具，不等于获得了本教程所需的 U-Boot 源码。
:::

## 3. 从官方源码获取

如果实验仓库没有包含源码，或者你希望自己下载，可以从 U-Boot 官方仓库获取指定 tag：

```bash
# [Host]
git clone https://source.denx.de/u-boot/u-boot.git u-boot-v2026.07
cd u-boot-v2026.07
git checkout v2026.07
```

也可以使用官方发布的归档包。无论使用哪种方式，关键是版本要固定，目录名建议保持为 `u-boot-v2026.07/`，方便和教程路径对应。

:::note
如果 GitHub 或官方 Git 服务访问较慢，可以使用你信任的镜像源下载源码，但提交、引用和排错时仍应以官方 tag `v2026.07` 为准。
:::

## 4. 源码与实验代码的关系

建议保持下面的目录结构：

```bash
uboot-courses/
├── README.md
├── u-boot-v2026.07/
├── experiments/
├── scripts/
└── tftpboot/
```

其中 `u-boot-v2026.07/` 保持接近官方源码，课程实验脚本放在外层 `experiments/` 和 `scripts/`。这样你在更新教程实验时，不会污染 U-Boot 源码树。

## 5. 为什么不直接在源码树里放实验脚本

U-Boot 源码树本身已经很复杂。如果把课程脚本、临时镜像、日志、TFTP 文件全部丢进源码目录，很快会难以区分哪些是官方源码，哪些是你的实验文件。

推荐做法是：

- `u-boot-v2026.07/`：尽量保持官方源码。
- `experiments/`：保存课程配置和脚本样例。
- `scripts/`：保存课程辅助脚本。
- `tftpboot/`：保存临时网络启动文件。
- `logs/`：保存串口日志。

这样以后你可以删除、重建或替换 U-Boot 源码，而不会丢失课程实验材料。

## 6. 检查源码是否干净

如果源码是 Git 仓库，可以查看状态：

```bash
# [Host]
git status --short
```

刚开始学习时，建议先在干净源码上完成一次编译。等你理解构建流程后，再添加自定义命令或修改配置。

如果你后续要做源码实验，可以把改动保存为 patch 或单独提交，方便回滚和比较。

## 本章小结

学习 U-Boot 时，固定源码版本很重要。后续命令会以 `/home/rudy/workspace/Projects/GetIoT/uboot-courses/u-boot-v2026.07` 作为示例路径；如果你的仓库 clone 到其他位置，请使用自己的实际路径。

## 思考与练习

1. 说明实验仓库和 U-Boot 官方源码之间的关系。
2. 在源码根目录中找到 `configs/qemu_arm64_defconfig`。
3. 解释为什么教程要固定到 v2026.07，而不是直接使用最新 master。
