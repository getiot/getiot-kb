---
sidebar_position: 12
sidebar_label: Dora-rs
slug: /dora-rs
---

# Dora-rs：面向 AI 机器人的数据流框架

![Dora-rs 框架](https://static.getiot.tech/dora-rs-banner.webp)

## Dora-rs 是什么

**Dora-rs**，也写作 **dora**，全称是 **Dataflow-Oriented Robotic Architecture**。它是一个面向机器人和 AI 应用的数据流中间件，目标是用声明式数据流图组织机器人应用，降低多传感器、多模型、多硬件协同时的集成复杂度。

Dora-rs 使用 Rust 实现核心运行时，并提供 Python、Rust、C、C++ 等接口。它的设计重点是低延迟、可组合、可分布式的数据流能力，适合 AI 机器人、具身智能、多模态感知和边缘推理等场景。

:::note
Dora-rs 仍处在快速发展阶段。性能指标、API 和组件生态可能变化较快。涉及性能对比时，应以官方 benchmark、论文或你自己的测试环境为准。
:::

## 为什么需要 Dora-rs

传统机器人软件栈通常以“节点 + 消息通信”的方式组织系统。在移动机器人、机械臂或无人车中，这种方式已经很成熟。但在 AI 机器人场景下，系统经常同时包含：

- 相机、麦克风、LiDAR、IMU 等多种传感器。
- VLM、LLM、语音识别、TTS、目标检测、分割等 AI 模型。
- CPU、GPU、NPU、边缘设备和云端服务。
- 控制、规划、可视化、日志和远程调试模块。

这些模块之间的数据量大、链路长、调试困难。Dora-rs 选择把应用建模为 dataflow pipeline，让你用拓扑文件描述数据如何流动，再由运行时负责调度、传输和连接。

## 核心设计

### 数据流驱动

在 Dora-rs 中，一个应用可以被描述成由多个节点组成的数据流图。每个节点负责一个明确任务，例如读取相机、运行模型、生成语音或发送控制命令。

你可以通过 YAML 描述拓扑。下面是一个简化示例（实际字段以官方 YAML 规范为准）：

```yaml
nodes:
  - id: camera
    path: opencv-video-capture
    inputs:
      tick: dora/timer/millis/20
    outputs:
      - image

  - id: object-detection
    path: dora-yolo
    inputs:
      image: camera/image
    outputs:
      - bbox

  - id: plot
    path: dora-rerun
    inputs:
      image: camera/image
      boxes2d: object-detection/bbox
```

这种方式的好处是：系统结构可以被直接读出来，模块之间的输入输出关系也更明确。

### 多语言接口

Dora-rs 的核心使用 Rust 实现，但实际机器人项目往往同时使用多种语言：

- Python 适合快速接入 AI 模型和数据处理。
- Rust 适合写高性能、低开销运行时组件。
- C/C++ 适合接入传统机器人算法、驱动和硬件 SDK。

多语言支持使 Dora-rs 更适合把 AI 生态和机器人底层模块接在一起。

### 低延迟通信

官方资料强调 Dora-rs 的低延迟和高吞吐能力，并给出与 ROS 2 的性能对比。由于性能结果强依赖数据大小、机器配置、通信路径、语言绑定和测试方法，实际项目中应重新测试，不应直接把官方数字当成所有场景下的确定结论。

### 分布式能力

Dora-rs 也关注跨机器数据流。对于边缘机器人系统，你可能会把相机采集放在设备端，把大模型推理放在 Jetson、工作站或云端。数据流模型有助于明确这些模块如何部署和连接。

## 适合哪些场景

Dora-rs 适合评估的场景包括：

- AI 机器人原型系统。
- 具身智能应用。
- 多模态感知和推理 pipeline。
- 机器人视觉、语音和动作链路集成。
- 需要跨语言、跨进程、跨设备组织数据流的项目。

如果你的项目主要依赖 ROS/ROS 2 生态中的成熟包，例如 Navigation、MoveIt、Gazebo、RViz 等，ROS/ROS 2 仍然是更稳妥的基础选择。Dora-rs 更适合对数据流、AI 模型集成和低延迟通信有明确需求的团队。

## 和 ROS/ROS 2 的关系

Dora-rs 不是“ROS 2 的简单替代品”。二者关注点不同：

- ROS/ROS 2 拥有庞大的机器人生态、工具链和现成算法包。
- Dora-rs 更强调数据流建模、AI pipeline 和低延迟运行时。

实际工程中，你可以把 Dora-rs 当作新的机器人中间件方案来评估，也可以探索它与现有 ROS/ROS 2 系统的互补关系。

## 学习建议

建议按这个顺序学习：

1. 阅读官方文档，理解 dataflow、node、operator、pipeline。
2. 安装 CLI，跑通官方最小示例。
3. 用 Python 写一个简单节点。
4. 尝试连接相机输入和 AI 推理节点。
5. 再评估分布式部署、共享内存和性能测试。

不要一开始就把完整机器人系统迁移到 Dora-rs。先用一个独立 pipeline 验证它是否解决你的实际问题。

## 相关链接

- Dora-rs 项目官网：[https://dora-rs.ai](https://dora-rs.ai)
- Dora-rs GitHub 仓库：[https://github.com/dora-rs/dora](https://github.com/dora-rs/dora)
- Dora-rs GitHub 组织：[https://github.com/dora-rs](https://github.com/dora-rs)
- Dora-rs 中文社区：[https://doracc.com/](https://doracc.com/)

## 小结

Dora-rs 是一个面向机器人和 AI 应用的数据流框架。它适合需要把多模态 AI、硬件输入、控制输出和分布式节点组织成清晰 pipeline 的项目。评估时要重点关注生态成熟度、团队技术栈、性能测试和与现有机器人框架的集成成本。
