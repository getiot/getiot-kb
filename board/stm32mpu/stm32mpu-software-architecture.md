---
sidebar_position: 3
---

# STM32MPU 软件生态



## 软件生态概览

STM32MPU 软件生态包含在 STM32MPU Embedded Software distribution（STM32MPU 嵌入式软件发行版）中，它是一套软件、系统构建和开发工具，旨在简化在 STM32 MPU 设备上进行的开发。这套开发工具主要包括两部分，如下图所示。

- 一个是运行在 Arm Cortex-A 核的 Linux 发行版，称为 **OpenSTLinux distribution**。
- 另一个是运行在 Arm Cortex-M 核的 STM32CubeMPU 软件包，称为 **STM32CubeMP1 Package**。（目前仅支持 STM32MP15x 产品线）

![](https://static.getiot.tech/STM32MPU_Embedded_Software_distribution.png#center)

### OpenSTLinux distribution

OpenSTLinux 发行版运行在 Arm Cortex-A 核，主要包括以下几部分：

- **OpenSTLinux BSP**
  - 基于 [TF-A](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/TF-A_overview) 和 [U-Boot](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/U-Boot_overview) 的 [boot chain](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/Boot_chain_overview)。
  - 以安全模式在 Arm Cortex-A 上运行的 [OP-TEE ](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/OP-TEE_overview) 安全操作系统。
  - 以非安全模式在 Arm Cortex-A 上运行的 [Linux kernel](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/STM32_MPU_Linux_kernel_overview)。
- **Linux middleware** 中间件依赖 BSP 向通过显示器、触摸屏等外设与用户交互的应用程序提供 API。
- 在 **OP-TEE** 方面，可信应用程序（Trusted Applications，简称 TA）依赖 OP-TEE 核心进行秘密操作（从 Linux 和 STM32Cube MPU 包中不可见）。

### STM32Cube MPU Package

STM32Cube MPU Package 运行在 Arm Cortex-M 核，且目前仅支持 STM32MP15x 产品线。它基于 HAL 驱动程序和中间件，例如 STM32 微控制器，并配有用于与 Cortex-A 交互的协处理器管理。



![](https://static.getiot.tech/STM32MPU_Embedded_Software_architecture_overview.png#center)

更多信息：

1. [STM32CubeMP1 architecture](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/STM32CubeMP1_architecture)
2. [OP-TEE overview](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/OP-TEE_overview)
3. [TF-A overview](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/TF-A_overview)
4. [U-Boot overview](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/U-Boot_overview)
5. [STM32 MPU Linux kernel overview](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/STM32_MPU_Linux_kernel_overview)
6. [Boot chain overview](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/Boot_chain_overview)
7. [Linux application frameworks overview](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/Linux_application_frameworks_overview)
8. [OpenSTLinux BSP architecture overview](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/OpenSTLinux_BSP_architecture_overview)
9. [OpenSTLinux architecture overview](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/OpenSTLinux_architecture_overview)
10. [Category:Platform configuration](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/Category:Platform_configuration)
11. [Security overview](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/Security_overview)
12. [Arm Cortex-A7](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/Arm_Cortex-A7)
13. [Arm Cortex-M4](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/Arm_Cortex-M4)
14. [STM32MP13 microprocessor](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/STM32MP13_microprocessor)
15. [STM32MP15 microprocessor](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/STM32MP15_microprocessor)



## 开源软件哲学

意法半导体与 Linux 开源社区紧密合作，最大限度地利用开源软件并为这些社区做出贡献。其中，OpenSTLinux Distribution 已被 Linux 社区（Linux 基金会、Yocto project 和 Linaro）审查并认可，并与 OP-TEE 安全操作系统预先集成。

STM32 MPU 产品线的所有开源软件源代码根据许可证发布，版权所有者授予用户出于任何目的研究、更改和分发该软件的权利。

不过需要注意，由于软件审查生命周期的原因，社区接受所有开发可能需要一些时间，因此意法半导体还可以暂时在 [GitHub](https://github.com/STMicroelectronics) 上提供一些源代码，直到将其合并到目标存储库中。



## 参考

- [STM32MPU Embedded Software architecture overview](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/STM32MPU_Embedded_Software_architecture_overview)
- [STM32MPU Embedded Software distribution](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/Category:STM32MPU_Embedded_Software_distribution)
- [STM32MP1 Distribution Package](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/STM32MP1_Distribution_Package)
- [OpenSTLinux distribution](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/OpenSTLinux_distribution)
- [STM32CubeMP1 Package](https://wiki.stmicroelectronics.cn/stm32mpu/wiki/STM32CubeMP1_Package)
