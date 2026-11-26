---
sidebar_position: 4
slug: /embedded-rtos
---

# 常见嵌入式操作系统

RTOS 的全称是 Real Time Operating System，即实时操作系统，具有实时性（Real-time）、多任务（Multi-task）、确定性（deterministic）、可靠性（Reliability）、可裁剪（configuration）、紧凑小巧（Small footprint）等特点。

本文将介绍国外常用的嵌入式操作系统，包括嵌入式 Linux、FreeRTOS、μC/OS、Zephyr 和国内的 RT-Thread、Huawei LiteOS 和 AliOS-Things 等等。



## 嵌入式 Linux

嵌入式 Linux 以 Linux 内核为基础，被设计来使用于嵌入式设备上的一类系统。广泛应用于移动电话、个人数码助理（PDA）、媒体播放器以及众多消费性电子设备中。由于 Linux 不是硬实时操作系统，因此这类产品通常对于实时性要求并不严苛。

如果你想在单片机上运行 Linux，可以尝试使用 uClinux。uClinux 是针对控制领域的嵌入式 Linux 操作系统，它从 Linux 2.0/2.4 内核派生而来，沿袭了主流 Linux 的绝大部分特性。适合不具备内存管理单元（MMU）的微处理器/微控制器。没有 MMU 支持是 uClinux 与主流 Linux 的基本差异。

- [Linux 代码仓库](https://github.com/torvalds/linux)
- [Linux 在线文档](https://docs.kernel.org)
- [uClinux 介绍](https://wiki.csie.ncku.edu.tw/embedded/uclinux)



## VxWorks

VxWorks 是美国风河系统（WindRiver）公司于1983年设计开发的一种嵌入式实时操作系统（RTOS）。VxWorks 以其良好的可靠性和卓越的实时性被广泛地应用在通信、军事、航空、航天等高精尖技术及实时性要求极高的领域中，如卫星通讯、军事演习、弹道制导、飞机导航等。

VxWorks 不是开源的，随着 Linux 的兴起，VxWorks 也对某些版本代码进行了开源，促进了 VxWorks 的发展。VxWorks的开发环境有 Tornado 和 Workbench，Tornado 适用于旧版本，Workbench 适用于较新的版本。也可以用 Tilcon 进行 VxWorks 平台的开发。因为适用场合较小，VxWorks 的例子和开源代码主要来自于官方。

- [Wind-River GitHub 主页](https://github.com/Wind-River)
- [VxWorks 在线文档](https://docs.windriver.com)



## QNX

QNX 最早是加拿大 Quantum Software Systems 公司开发的一个商用实时操作系统，现在属于黑莓（BlackBerry）公司。QNX 具有安全（Secure）、可靠（Reliable）、可信（Trusted）的特点，通常应用于对安全性要求极高的领域，例如汽车、航空、核电站、工业自动化等领域。

值得一提的是，QNX 是世界上第一个微内核实时操作系统，甚至比微软和 Wind River 的 Vxworks 还要早。微内核架构也是 QNX 实现性能和可靠性平衡的关键所在。QNX 是全球第一款通过 ISO 26262 ASIL levelD 安全认证的车载操作系统，因此它一直是汽车领域市场占有率最高的操作系统。但由于其开放性不够，因此兼容性较差、应用生态缺乏，在娱乐系统开发中应用不多。

- [QNX 官网](https://blackberry.qnx.com)



## FreeRTOS

FreeRTOS 是一款著名的开源实时操作系统，最早于2003年由英国工程师 Richard Barry 开发，其目的是提供一个免费的、容易使用的 RTOS 解决方案。FreeRTOS 非常轻巧，仅占用很小的存储空间和处理器资源，非常适合于资源有限、功耗要求严格的嵌入式设备。并且具有高度可移植性，可以运行在各种处理器架构和开发板上。

FreeRTOS 内核最初使用 GPL 授权，2016年被 Amazon 收购，并在 MIT 开源许可证下免费分发。如今，FreeRTOS 包括一个内核和一组不断丰富的软件库，适用于各种行业部门和应用程序。可以帮助开发者轻松编写、部署、保护和维护基于微控制器的边缘设备。

除了开源的 FreeRTOS 版本，还提供 OpenRTOS 商业许可版本以及通过安全认证的 SafeRTOS 版本。

- [FreeRTOS 代码仓库](https://github.com/FreeRTOS/FreeRTOS-Kernel)
- [FreeRTOS 在线文档](https://www.freertos.org/zh-cn-cmn-s/)



## RT-Thread

RT-Thread 是一个来自中国的开源实时操作系统，以“小而美的物联网操作系统”著称。最早在2006年由中国工程师熊谱翔开发，并集合开源社区力量逐步发展为一个组件完整丰富、高度可伸缩、简易开发、超低功耗、高安全性的物联网操作系统。

RT-Thread 使用 Apache License 2.0 开源许可协议，可以免费在商业产品中使用，并且不需要公开私有代码，没有潜在商业风险。截至2023年，RT-Thread 的装机量已经超过了14亿台，应用范围涵盖了智能家居、安防、工业、穿戴、智慧城市等众多行业领域，成为了市面上装机量最大的嵌入式操作系统之一。

除了 RT-Thread 标准开源版本，还提供 RT-Thread Smart Pro 高性能混合微内核操作系统专业版，面向航天领域的高安全可靠实时操作系统内核 RT-Thread Space，以及面向汽车领域的 RT-Thread Secure Auto 安全型实时操作系统和 RT-Thread Smart Auto 微内核操作系统等。

- [RT-Thread 代码仓库](https://github.com/RT-Thread/rt-thread)
- [RT-Thread 在线文档](https://www.rt-thread.org/document/site/#/)



## μC/OS

μC/OS 由 Micrium 公司开发的一个可移植、可固化、可裁剪、占先式多任务实时内核，它适用于多种微处理器，微控制器和数字处理芯片（已经移植到超过100种以上的微处理器应用中）。同时，该系统源代码开放、整洁、一致，注释详尽，适合系统开发。μC/OS 主要包括经典的 µC/OS-II 和 µC/OS-III 两个版本。μC/OS-II 已经通过联邦航空局（FAA）商用航行器认证，符合航空无线电技术委员会（RTCA）DO-178B 标准。

μC/OS 的故事始于1989年，创始人 Jean J.Labrosse 参加了一个 Dynalco 控制项目，并开始设计用于大型工业往复式发动机的基于微处理器的新型点火控制系统。经过一番这折腾之后，J.Labrosse 开始着手开发自己的实时内核。在经过大约一年后，操作系统 μC/OS 问世了。1998年发布 μC/OS-II 版本；1999年成立 Micrium 公司；2016年 Micrium 公司被 Silicon Labs 收购。

- [μC/OS 代码仓库](https://github.com/weston-embedded)
- [μC/OS 在线文档](https://micrium.atlassian.net/wiki/spaces)



## Keil RTX

RTX 是一种嵌入式实时操作系统（RTOS），由 Keil 公司（现为 ARM 的一部分）开发。它专为 ARM 及 Cortex M 系列微控制器设计，提供了一套完整的实时多任务操作系统解决方案，包括任务调度、中断处理、同步通信等功能。

经常和 RTX 一起出现的一个名词是 CMSIS-RTX。CMSIS（Cortex Microcontroller Software Interface Standard）是 ARM 公司提供的一套嵌入式软件开发接口标准，旨在促进针对 ARM Cortex-M 处理器的软件开发。CMSIS-RTOS 是 CMSIS 的一部分，定义了一套面向嵌入式系统的标准 API，以便于不同厂商的实时操作系统对外提供统一的接口。而 CMSIS-RTX 则是 CMSIS 中的一个组件，是基于 RTX 实现的符合 CMSIS-RTOS 标准的嵌入式操作系统。它提供了一套符合标准的 API，使得开发人员可以在不同的 Cortex-M 处理器上轻松移植和使用。

因此，可以将 RTX 视为 CMSIS-RTX 的实现之一。通过符合 CMSIS-RTOS 标准，CMSIS-RTX 使得开发人员可以更加方便地在不同的 Cortex-M 处理器上开发和移植嵌入式系统，同时利用了 RTX 提供的丰富功能和可靠性。

- [CMSIS-RTX 代码仓库](https://github.com/ARM-software/CMSIS-RTX)
- [CMSIS-RTOS 在线文档](https://www.keil.com/pack/doc/CMSIS/RTOS/html/index.html)



## NuttX

NuttX 是一个成熟的嵌入式实时操作系统，占用空间极小，遵循 POSIX 和 ANSI C 标准，具有模块化设计、代码精简、轻量级、高度兼容 Linux（NuttX 支持大多数 RTOS 都没有实现的进程概念，并提供完整的 POSIX API）等特点。NuttX 支持的硬件平台广泛，从低端的 8 位单片机到高端的 ARM、x86 均可移植。无人机领域著名的 Ardupoilt 和 PX4 飞控系统固件都是基于 Nuttx 操作系统。

- [NuttX 代码仓库](https://github.com/apache/nuttx)
- [NuttX Apps 代码仓库](https://github.com/apache/nuttx-apps)
- [NuttX 在线文档](https://nuttx.apache.org/docs/latest/)



## Zephyr

Zephyr 最初是风河系统公司在2015年推出的为物联网设备开发的“Rocket内核”，更早时称为“Microkernel Profile for VxWorks”，代码移植于2001年并购 Eonic Systems 得来的 Virtuoso DSP RTOS。2016年成为 Linux 基金会的项目，并更名为 Zephyr。Linux 基金会非常有雄心，希望借助于 Zephyr 来统一联网物联网领域的操作系统。

- [Zephyr 代码仓库](https://github.com/zephyrproject-rtos/zephyr)
- [Zephyr 在线文档](https://docs.zephyrproject.org/latest/)



## ThreadX

ThreadX 是由 Express Logic 公司开发的硬实时操作系统（RTOS），适用于深嵌入式应用中，具有规模小、实时性强、可靠性高、无产品版权费、易于使用等特点，并且支持大量的处理器和SoC，包括 ARM、PowerPC、SH 4、MIPS、ADI DSP、TI DPS、Nios II等，因此广泛应用于消费电子、汽车电子、工业自动化、网络解决方案、军事与航空航天等领域中。惠普公司的多款数码相机中应用了 ThreadX RTOS 和配套的 FileX 文件系统组件，同时，惠普公司也在全系列打印机产品中使用了 ThreadX RTOS。

微软在 2019 年收购了 Express Logic 公司，并宣布在 MIT 许可证下将 ThreadX RTOS 开源，将其捐赠给 Eclipse 基金会，改名为 Eclipse ThreadX 或简称 ThreadX。ThreadX 的作者 William Lamie 后来离开了微软创办了新的公司，开发了新的实时操作系统 PX5OS。

- [ThreadX 代码仓库](https://github.com/eclipse-threadx/threadx)
- [ThreadX 在线文档](https://learn.microsoft.com/en-us/azure/rtos/threadx/)



## ARM Mbed OS

ARM Mbed OS 是 ARM 公司专门为物联网设备而设计的开源嵌入式操作系统，主要面向 ARM Cortex-M 系列微控制器，非常适合涉及智能城市、智能家庭和穿戴式设备等领域的应用程序。

相比于其他嵌入式操作系统，ARM Mbed OS 的主要优势在于其提供 mbed TLS 和 mbed uVisor 安全机制、支持多种协议栈（包括 Bluetooth LE、Wi-Fi、6LoWPAN、Thread、Lora 等）、提供完整的工具链支持（包括在线 IDE、mbed CLI 以及第三方 IDE），以及拥有良好的社区生态。

- [Mbed OS 代码仓库](https://github.com/ARMmbed/mbed-os)
- [Mbed OS 在线文档](https://os.mbed.com/docs/mbed-os)



## Huawei LiteOS

Huawei LiteOS 是华为面向物联网领域开发的一个基于实时内核的轻量级操作系统。LiteOS 是针对物联网设备设计的操作系统，它由内核和构筑在内核之上的框架、对应用提供的 API 接口构成。LiteOS 后来被整合到鸿蒙生态系统中。

- [LiteOS 代码仓库](https://github.com/LiteOS/LiteOS)
- [LiteOS 在线文档](https://support.huaweicloud.com/LiteOS/index.html)



## AliOS Things

AliOS Things 阿里巴巴旗下面向 IoT 领域的轻量级物联网嵌入式操作系统，致力于搭建云端一体化IoT基础设备。具备极致性能，极简开发、云端一体、丰富组件、安全防护等关键能力，并支持终端设备连接到阿里云 Link，可广泛应用在智能家居、智慧城市、新出行等领域。

- [AliOS Things 代码仓库](https://github.com/alibaba/AliOS-Things)
- [AliOS Things 在线文档](https://help.aliyun.com/zh/alios-things/)



## SylixOS

SylixOS 是一款诞生于2006年、由中国人自己开发的、大型、嵌入式、实时、类 UNIX 操作系统。现由翼辉信息有限公司专门推广和开发。主要应用在航空航天、工业自动化、通信、新能源等领域。

特别强调一下，SylixOS 不是 Linux 的衍生版，也不是照抄了其他操作系统的内核，SylixOS 内核完全是国人自主开发的，另外配套移植了一些第三方开源软件（如 FAT 文件系统，QT 图形界面等，其他操作系统的很多中间件也大多是移植第三方开源软件）而组成的操作系统。

除了 SylixOS 大型实时操作系统，翼辉信息还推出了用于边缘计算的 EdgerOS，以及用于嵌入式设备的轻量级操作系统 MS-RTOS。

- [翼辉信息官网](https://www.acoinfo.com)



## TobudOS

TobudOS 是面向物联网领域开发的实时操作系统，早期版本基于腾讯自研的物联网操作系统 TencentOS Tiny，2020年由腾讯捐赠到开放原子开源基金会进行孵化，2023年正式更名为 TobudOS。

TobudOS 具有低功耗，低资源占用，模块化，安全可靠等特点，可有效提升物联网终端产品开发效率，提供精简的 RTOS 内核，内核组件可裁剪可配置，可快速移植到多种主流 MCU（如 STM32 全系列）及模组芯片上。而且，基于 RTOS 内核提供了丰富的物联网组件，内部集成主流物联网协议栈（如 CoAP/MQTT/TLS/DTLS/LoRaWAN/NB-IoT 等），可助力物联网终端设备及业务快速接入物联网云平台。

- [TobudOS 代码仓库](https://atomgit.com/tobudos)
- [TobudOS 在线文档](https://cloud.tencent.com/product/tos-tiny)



## Nucleus RTOS

Nucleus 是由 Mentor Graphics 嵌入式软件部门开发的 RTOS，该部门是西门子旗下一家支持 32 位和 64 位嵌入式系统平台的公司。Nucleus 操作系统主要用于医疗、航空航天、工业、消费电子和物联网（IoT） 应用中的实时嵌入式系统。

- [Nucleus RTOS 介绍](https://en.wikipedia.org/wiki/Nucleus_RTOS)



## µOS++

µOS++ 是一个支持 POSIX 接口的、可移植的、开源的（MIT 许可）、多任务的实时操作系统框架，使用 C++ 编写，适用于32/64位嵌入式应用程序。它包含多个组件，如引导启动、内存管理、任务调度、设备驱动、文件系统等。

- [µOS++ 代码仓库](https://github.com/micro-os-plus/micro-os-plus-iii)
- [µOS++ 在线文档](https://micro-os-plus.github.io)



## 更多

还有更多其他 RTOS，包括 eCOS、MiCO IoT OS、TRON、uT/OS、Ruff、Ostro、Contiki 等，这里就不一一介绍了，感兴趣的读者可以自行搜索。

