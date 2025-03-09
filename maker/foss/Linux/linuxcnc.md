---
sidebar_position: 2
sidebar_label: LinuxCNC
slug: /linuxcnc
---

# LinuxCNC 开源数控系统

**LinuxCNC**（原名 EMC2）诞生于1990年代，最初由美国国家标准与技术研究院（NIST）发起，旨在为制造业提供开放、灵活的运动控制解决方案。它基于 Linux 实时内核扩展，专为数控机床、机器人、3D 打印机及定制化工业设备设计，支持从 3 轴铣床到 9 轴复杂系统的控制需求。

:::tip

**CNC** 是 **Computer Numerical Control** 的缩写，中文译为 **计算机数字控制**（简称“数控”）。它是一种通过计算机编程（通常是 G代码 或 M代码）来自动控制机床或制造设备的技术，可以精确控制机床的移动、转速、进给率等参数，实现自动化加工，广泛应用于机械加工、工业生产和自动化领域。

:::



## 关键特性

- **实时性能**：通过 `PREEMPT_RT` 补丁或 Xenomai 实现微秒级硬实时控制。
- **多轴同步**：支持多达9轴联动，集成高级运动学模型（如 Delta 机器人、SCARA 机械臂）。
- **硬件兼容性**：适配 EtherCAT、Modbus、MESA FPGA 等工业总线与硬件接口。
- **模块化架构**：基于硬件抽象层（HAL），允许开发者动态重组控制逻辑。



## 技术架构

LinuxCNC 的架构设计以**实时性**和**可扩展性**为核心，分为以下关键模块：

- **实时内核（RTOS）**：LinuxCNC 依赖实时补丁的 Linux 内核（如 `PREEMPT_RT`），确保控制循环的确定性延迟（通常 < 50μs）。开发者可通过 [`cyclictest`](/linux-command/cyclictest) 工具验证系统实时性能。
- **运动控制器**：核心算法包括轨迹规划（如速度前瞻、加速度限制）、PID 控制及非线性补偿（如摩擦模型）。开发者可通过自定义插件扩展运动学模型（例如并联机器人逆解算法）。
- **硬件抽象层（HAL）**：HAL 是 LinuxCNC 的灵魂，允许开发者以“软接线”方式连接逻辑组件（如编码器输入、PWM输出）。通过图形化工具（如HALscope）或脚本，可动态配置信号流，无需重新编译代码。
- **用户界面（UI）**：提供多种界面选项：基于 Tcl/Tk 的经典界面（Axis）、触摸屏优化的 Touchy，或通过 Python、ROS 集成自定义 HMI。
- **通信接口**：支持 ROS 主题、SocketCAN、OPC-UA 等协议，便于与工业物联网（IIoT）平台集成。



## 应用场景

LinuxCNC 的典型应用场景包括：

- **数控机床升级**。将老式机床（如铣床、车床）改造成智能设备，增加网络监控、自适应加工功能。
- **定制化机器人控制**。为并联机器人、协作机械臂开发专用控制器，集成力反馈或视觉引导。
- **数字化产线集成**。通过 EtherCAT 连接 PLC、伺服驱动器，构建低成本柔性制造单元（FMC）。
- **研究与教育**。提供透明化的控制框架，用于算法验证（如新型插补算法）或工程教学。



## 资源链接

- 项目官网：[https://linuxcnc.org](https://linuxcnc.org)
- GitHub 主页：[https://github.com/LinuxCNC](https://github.com/LinuxCNC)
- 社区案例集：[linuxcnc.org/applications](https://linuxcnc.org/applications/)
