---
sidebar_position: 3
sidebar_label: SPL、TPL、VPL 与 U-Boot proper
slug: /xpl-and-u-boot-proper
---

# U-Boot SPL、TPL、VPL 与 U-Boot proper

很多真实芯片不能一上电就运行完整 U-Boot。原因很现实：Boot ROM 加载空间有限，片上 SRAM 很小，DRAM 还没有初始化。因此 U-Boot 常被拆成多个阶段。

本章标题中的 xPL 是一个泛称，用来包含 SPL、TPL、VPL 这类 U-Boot 早期阶段。你不需要一开始掌握所有缩写，但要理解“完整 U-Boot proper 之前可能还有更小的加载器”。

## 1. U-Boot proper

U-Boot proper 指完整功能的 U-Boot 主体。你在 QEMU 中看到命令行、环境变量、bootflow、文件系统、网络等功能，主要都属于 U-Boot proper。

U-Boot proper 通常运行在 DRAM 中，空间相对充足，可以包含更多命令、文件系统、网络、USB、Driver Model 等功能。你在教程前半部分使用的 QEMU `-bios u-boot.bin`，基本是在学习 U-Boot proper 的能力。

## 2. SPL

SPL 是 Secondary Program Loader。它通常很小，职责集中：

- 初始化最基本的时钟和 pinmux。
- 初始化 DRAM。
- 从启动介质加载 U-Boot proper。
- 跳转到 U-Boot proper。

SPL 中可用命令和驱动非常有限，不要期待它具备完整 U-Boot 命令行能力。

SPL 常运行在片上 SRAM 中，因此空间非常紧张。很多功能必须裁剪，只保留“启动下一阶段”所必需的代码。你在 U-Boot proper 中可用的 ext4、USB、网络命令，在 SPL 中通常都不存在。

## 3. SPL 通常加载什么

常见后级目标包括：

- U-Boot proper。
- FIT image 中的 U-Boot proper。
- TF-A BL31 和 U-Boot proper。
- OP-TEE 和 U-Boot proper。
- OpenSBI 和 U-Boot proper。

具体由平台决定。阅读板级文档时，你要弄清楚 SPL 加载的后级镜像格式、位置和入口地址。

## 4. TPL 与 VPL

TPL 通常比 SPL 更早、更小，用在 SRAM 更紧张或启动链更复杂的平台。VPL 是较新的验证阶段概念，常与 verified boot 流程相关。

并不是所有平台都需要 TPL、VPL。是否使用取决于 SoC 启动要求和 U-Boot 配置。

可以这样粗略记：

- TPL：比 SPL 更早、更小。
- SPL：常见的早期加载器。
- VPL：与验证流程相关的早期阶段。
- U-Boot proper：完整主体。

## 5. 分阶段带来的配置差异

SPL/TPL/VPL 有自己的配置命名空间，例如很多选项以 `CONFIG_SPL_` 开头。一个驱动在 U-Boot proper 中可用，不代表在 SPL 中也可用。

排查早期启动时要特别注意：

- 串口驱动是否在 SPL 中启用。
- DRAM 初始化代码是否运行。
- SPL 是否能访问启动介质。
- SPL 加载 U-Boot proper 的偏移是否正确。

在源码中查看 SPL 配置：

```bash
# [Host]
grep CONFIG_SPL .config
```

如果你发现 U-Boot proper 能访问 MMC，但 SPL 找不到后级镜像，优先检查 `CONFIG_SPL_MMC`、SPL 设备树和启动介质偏移。

## 6. SPL 日志怎么读

SPL 日志通常很短。你要特别关注：

- 是否出现 SPL 版本或阶段横幅。
- DRAM 初始化是否成功。
- 后级镜像从哪里加载。
- 加载地址和大小。
- 是否跳转到 U-Boot proper。

如果 SPL 后没有 U-Boot proper 横幅，问题多半发生在加载后级镜像或跳转阶段。

## 7. QEMU 为什么让你感觉没有 SPL

本教程 QEMU ARM64 路径主要用 `-bios u-boot.bin` 直接运行 U-Boot proper，省略了很多真实硬件的早期阶段。这对入门很好，因为你可以先理解 U-Boot 命令和启动 Linux 的主流程。

但真实开发板上，如果 Boot ROM 只能加载一个很小的第一阶段镜像，你就必须处理 SPL/TPL、固件打包和启动介质偏移。

## 本章小结

如果你的开发板需要 SPL，不要只调试 U-Boot proper。上电后最先失败的往往是 SPL 阶段：串口没输出、DRAM 初始化失败、找不到后级镜像，都会让系统停在 Linux 之前很远的位置。

## 思考与练习

1. 查看目标板 defconfig 中是否启用了 `CONFIG_SPL`。
2. 从原厂日志中找出 SPL 和 U-Boot proper 的分界。
3. 解释为什么 U-Boot proper 中可用的驱动，不代表 SPL 中也可用。
