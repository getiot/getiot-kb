---
sidebar_position: 4
sidebar_label: TF-A、OP-TEE 与 OpenSBI
slug: /firmware-components
---

# U-Boot 与 TF-A、OP-TEE、OpenSBI

U-Boot 经常不是启动链中唯一的固件。现代 ARMv8 和 RISC-V 系统通常还需要其他固件组件配合。理解它们的边界，能帮你避免把所有问题都归咎于 U-Boot。

你可以把启动链看成一组接力棒。Boot ROM、TF-A、OP-TEE、OpenSBI、U-Boot、Linux 各自负责一段。如果前一棒没有把 CPU 状态、内存、设备树或固件参数交接好，后一棒可能看起来“坏了”，但根因不在它身上。

## 1. TF-A

TF-A 是 Trusted Firmware-A，常用于 ARMv8 平台。它通常负责 EL3 安全世界相关初始化，并提供 PSCI 等接口。典型启动链可能是：

```bash
Boot ROM -> TF-A BL2 -> TF-A BL31 -> U-Boot -> Linux
```

具体 BL 阶段如何安排取决于平台。你需要阅读 SoC 或板级文档，不要套用别的平台。

常见概念：

- BL1：通常与 Boot ROM 或最早期加载有关，具体平台差异大。
- BL2：常负责加载后续镜像。
- BL31：运行在 EL3，提供 PSCI 等运行时服务。
- BL33：非安全世界 payload，常见是 U-Boot。

不同平台的 TF-A 集成方式差异很大。有的平台由 U-Boot SPL 加载 TF-A，有的平台由 TF-A 加载 U-Boot。你要看当前 SoC 的实际启动链。

## 2. OP-TEE

OP-TEE 是开源 Trusted Execution Environment。启用 OP-TEE 的系统中，启动链可能把 OP-TEE OS 加载到 secure world，然后 Linux 通过 tee 驱动与它通信。

如果产品不使用 TEE，不一定需要 OP-TEE。不要为了“看起来完整”而加入不理解的安全组件。

OP-TEE 相关问题常见表现包括：

- secure world 初始化失败。
- Linux 中 tee 驱动不可用。
- 启动链中镜像加载地址冲突。
- 设备树中 reserved-memory 配置不匹配。

如果你只是学习 U-Boot 基本启动，不必强行加入 OP-TEE。等普通启动链稳定后，再引入 TEE 会更稳妥。

## 3. OpenSBI

OpenSBI 常用于 RISC-V 平台，提供 supervisor binary interface。Linux 通常运行在 S-mode，需要 OpenSBI 提供底层服务。常见启动链可能是：

```bash
Boot ROM -> OpenSBI -> U-Boot -> Linux
Boot ROM -> U-Boot SPL -> OpenSBI -> U-Boot proper -> Linux
```

OpenSBI 日志通常会打印平台、hart、domain、firmware base 等信息。RISC-V 开发板上，如果没有 OpenSBI 或等价 SBI 实现，Linux 很可能无法正常启动。

## 4. 厂商 loader

很多 SoC 还有厂商私有 loader 或打包工具。它们可能负责：

- DDR training。
- 生成 Boot ROM 识别的镜像头。
- 加载 TF-A、OP-TEE、U-Boot。
- 签名或加密固件。
- 提供 USB download/recovery 模式。

这些组件不一定完全开源。移植 mainline U-Boot 时，常见策略是先复用厂商早期 loader，让 mainline U-Boot proper 跑起来；等理解启动链后，再考虑替换更多阶段。

## 5. 如何确认谁负责什么

阅读串口日志时，注意每个阶段的版本横幅：

- TF-A 通常会打印 BL 阶段信息。
- OP-TEE 会打印 TEE 版本和初始化日志。
- OpenSBI 会打印平台、hart、domain 等信息。
- U-Boot 会打印 `U-Boot <version>`。

启动失败时，先看最后一个成功打印横幅的组件是哪一个。

你可以用一张表记录：

| 阶段 | 是否出现日志 | 版本/标识 | 下一阶段 |
| --- | --- | --- | --- |
| Boot ROM | 需要确认 |  |  |
| SPL/vendor loader |  |  |  |
| TF-A/OpenSBI/OP-TEE |  |  |  |
| U-Boot proper |  |  | Linux |

## 6. 组件集成时最容易错的地方

- 加载地址互相覆盖。
- 入口地址错误。
- 设备树 reserved-memory 不匹配。
- TF-A 期望的 BL33 格式和你提供的 U-Boot 格式不同。
- OP-TEE 或 OpenSBI 版本与 kernel/设备树不匹配。
- 打包工具参数来自另一块板子。

遇到这类问题时，不要只盯着 U-Boot 命令行，因为系统可能还没走到 U-Boot proper。

## 本章小结

U-Boot 的职责是启动操作系统和提供启动期设备访问，但它常常依赖 TF-A、OP-TEE、OpenSBI 或厂商 loader。移植真实硬件时，要先画出完整启动链，再决定该调试哪个组件。

## 思考与练习

1. 从原厂日志中标出 TF-A、OP-TEE、OpenSBI 或 vendor loader 的位置。
2. 判断你的目标板是否需要 BL31 或 OpenSBI。
3. 解释为什么 U-Boot proper 启动失败，根因可能在前一级固件。
