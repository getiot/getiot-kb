---
sidebar_position: 11
sidebar_label: Dora-rs
slug: /dora-rs
---

# Dora-rs：为具身智能时代而生的新一代机器人框架

![Dora-rs 框架](https://static.getiot.tech/dora-rs-banner.webp)

## Dora-rs 是什么？

**Dora-rs** （Dataflow-Oriented Robotic Architecture） 是一个**面向“实时多 AI + 多硬件协同”的开源数据流框架**，旨在简化基于 **人工智能的具身智能机器人** 应用开发。其核心理念是将复杂的机器人应用程序建模为声明式的有向图，即“数据流” 。这种范式从根本上促进了系统的模块化、可配置性和可扩展性 。

Dora-rs 中的 `rs` 是指 **Rust** 语言，显然其核心是用 Rust 语言编写的。虽然 dora-rs 对外提供 Python/Rust/C/C++ 多语言 API，但其运行时内核（包括共享内存服务 `dora-coordinator`、调度器、通信层等）全部基于 Rust 实现 —— 这也是它能实现零拷贝、低延迟、高可靠的关键基础。



## 为什么需要 Dora？

在 AI 爆发的今天，主流机器人框架（如 ROS/ROS2）仍停留在“前大模型时代”的设计范式，面临三大核心瓶颈：

| 痛点           | 具体表现                               | 开发者困境                                            |
| :------------- | -------------------------------------- | ----------------------------------------------------- |
| **通信低效**   | 基于 DDS 的 CDR 序列化，数据需多次拷贝 | 单次 40MB 消息延迟高达 35ms，制约实时控制与多模态融合 |
| **系统紧耦合** | 节点通过话题强绑定，调试需全局重启     | 修改一个模块，整套系统重编译部署，迭代成本高          |
| **实时性缺失** | 非确定性调度 + GC 不可控语言（Python） | 工业级响应（<10ms）难以保障，尤其在视觉-控制闭环中    |

这些问题在 **具身智能（Embodied AI）** 场景下尤为致命 —— 当机器人需同时运行 VLM（视觉语言模型）、TTS、实时定位与运动规划时，传统架构成为性能瓶颈。

于是，Dora-rs 应运而生！值得一提的是，它并非简单“ROS2 的 Rust 版”，而是一次自底向上的架构革命。



## 核心技术

### ① 零拷贝通信体系

- 底层基于 **Apache Arrow** 统一内存格式，跨语言（Python/Rust/C/C++）传递数据无需序列化。
- 自研 **dora-coordinator 共享内存服务**，单机内节点通信延迟降至微秒级。
- 支持 GPU/NPU 直接访问共享内存（如 PyTorch CUDA 张量直通），端到端吞吐达 20GB/s。

### ② 数据流驱动模型

- **节点（Node）**：最小执行单元（如 `usb-camera`、`qwen2.5-vl`）。
- **算子（Operator）**：封装处理逻辑（支持事件/周期双触发模式）。
- **拓扑（YAML）**：声明式定义数据流，实现“所见即所得”的系统构建。

```yaml showLineNumbers
nodes:
  - id: cam
    operator: dora-usb-camera
  - id: vision
    operator: qwen2.5-vl
    inputs: [cam/image]
  - id: speak
    operator: kokoro-tts
    inputs: [vision/response]
```

### ③ 分布式原生支持

- 内建集成 **Zenoh** 分布式中间件（2025.03 新增）。
- 跨机器部署无需手动配置 discovery，YAML 拓扑自动映射到集群。
- 支持混合云边架构：树莓派采集 → Jetson 推理 → 云端 LLM 决策。

### ④ 全栈可观测性

- 原生集成 **OpenTelemetry**。
- CLI 工具实时查看：节点延迟、吞吐、错误率、资源占用。
- 日志/指标/链路追踪一键导出，适配 Prometheus/Loki/Grafana 前端。



## 性能差异

官方基准测试（Python API，40MB 随机数据传输）显示，ROS2 平均延迟约 35 ms，而 Dora-rs 仅 2 ms，内存占用比 ROS2 降低 60%。

这种差距不仅仅是 Rust 和 C++ 的区别，更是架构设计方面的优化。ROS2 的消息传递链条需要经过话题 → 序列化 → 网络 → 反序列化 → 回调。而 Dora 则采用共享内存地址传递 + Arrow Schema 校验方式，更加高效。

而在 GPU 场景中，Dora 可绕过 Host↔Device 拷贝，使 SAM2 分割结果直接供给运动规划模块，端到端延迟下降 50%+。



## 相关链接

- [Dora-rs 项目官网](https://dora-rs.ai)
- [Dora-rs 中文社区](https://doracc.com/)
- [Dora-rs GitHub 主页](https://github.com/dora-rs)
