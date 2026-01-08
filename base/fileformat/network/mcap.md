---
sidebar_position: 3
sidebar_label: MCAP 格式
slug: /mcap
---

# MCAP 文件格式

**MCAP**（Modular Container for Autonomous Platforms，自主平台模块化容器）是一种用于异构时间戳数据的模块化容器文件格式，由机器人技术公司 Foxglove 于 2021 年推出，专为自动驾驶和机器人系统设计的一种数据存储格式。

它支持 ROS/ROS2 消息、点云、传感器数据的高效存储，内置时间同步索引和 CRC 校验，提供零拷贝读取优化，适配 [Kafka](https://kaitai.io) 流式传输，是无人系统数据记录的开源标准。目前，MCAP 格式已经被 Apollo、ROS 2 等主流框架原生支持，是 rosbag 格式的进化替代方案。

:::tip

MCAP 的发音是 /ˈɛmkæp/，类似于 "em-cap"。

:::



## 为什么要发明 MCAP？

在过去，许多机器人公司花费宝贵的内部资源开发自定义文件格式，结果只是增加了未来的工作量，并使第三方工具集成变得复杂。Foxglove 团队能够专注于他们的核心机器人问题，避免浪费宝贵时间开发商品化工具，因此开发了 MCAP。

在 MCAP 之前，机器人团队选择哪种存储日志数据的格式主要取决于他们的框架。使用 ROS 1 的团队默认使用 .bag 格式；使用 ROS 2 的团队默认使用基于 SQLite 的格式。不使用 ROS 的公司通常使用自定义的内部二进制格式，例如长度分隔的 Protobuf，或将消息存储为现有文件格式中的不透明字节，例如 HDF5。

这些现有的存储选项有几个缺点。自定义的内部格式缺乏互操作性，并且需要开发多种语言的库来读取和写入文件。ROS 1 的 bag 格式在 ROS 生态系统之外使用起来非常困难，而 ROS 2 的 SQLite 格式并不完全自包含，这使得第三方工具难以读取。

MCAP 作为一种容器格式，解决了许多这些问题。它是自包含的，可以在单个文件中嵌入多种不同序列化格式编码的数据流，甚至支持元数据和附件。MCAP 文件针对高性能写入和高效索引读取进行了优化，即使在远程连接下也是如此。



## 技术优势

MCAP 可以在一个文件中记录多条结构化和非结构化数据流（例如 ROS、Protobuf、JSON Schema 等），非常适合机器人应用程序。简单来说，它具有以下优势：

- **异构数据**

  - 在单个文件中存储多种序列化格式编码的消息
  - 包含元数据和附件
- **高性能写入**

  - 仅追加结构
  - 在数据记录被中断时恢复部分写入的文件
- **高效查找**
  - 无需扫描整个文件即可提取数据
  - 快速访问已索引的摘要数据

- **自包含文件**
  - 将所有消息模式嵌入文件中
  - 解码无需额外依赖




## 关键特性

1. **发布/订阅日志记录**：它可以存储多个通道的时间戳日志数据，例如发布/订阅消息或多模态传感器数据。
2. **序列化无关性**：MCAP 可以记录和回放任何格式的二进制消息，例如 Protobuf、DDS（CDR）、ROS、JSON 等。
3. **高性能写入**：MCAP 采用行式、追加式设计，以最小化磁盘 I/O 操作，并降低在非正常关机时数据损坏的风险。
4. **自包含性**：MCAP 将消息模式与数据一同存储，因此即使随着代码库的演变，文件在未来仍可读取。
5. **高效查找**：MCAP 文件包含一个可选的索引，允许快速、高效地读取，即使在低带宽的互联网连接下也是如此。
6. **可选压缩**：你可以选择 LZ4 或 Zstandard 进行基于块的压缩，同时仍然支持高效的索引读取。
7. **广泛的语言支持**：C++、Go、Python、Rust、Swift 和 TypeScript 等语言均提供原生的读写库。
8. **灵活性**：你可以配置诸如分块、索引、CRC 校验和和压缩等可选功能，以为你的应用程序做出正确的权衡。
9. **生产级**：从自动驾驶汽车到无人机，各种公司都在生产中使用 MCAP，它还是 ROS 2 的默认日志格式。



## 应用场景

**1. 自动驾驶路测**

- 多传感器同步记录（64 线 LiDAR + 8 路摄像头 + IMU）
- 支持 TB 级数据集的快速检索（示例：在 2TB 数据集中定位特定交通灯事件 < 5s）

**2. 工业机器人调试**

- 实时记录关节扭矩/位姿数据（1kHz 采样率）
- 与 PLC 数据的时间对齐精度达 ±100μs

**3. 云端数据分析**

- 通过 Foxglove WebSocket 协议实现浏览器直接解析
- 支持按需提取数据子集（如仅提取 `/camera` 话题）



## 名词解释

MCAP 是一种模块化容器文件格式，通过消息（Message）、通道（Channel）和模式（Schema）来组织其数据。

- **Message**：发布/订阅系统（pub/sub）中节点之间的通信单位。
- **Channel**：具有相同类型或架构的消息流，相当于发布者和订阅者之间的连接。
- **Schema**：对通道上消息的结构和内容的描述，例如 [Protobuf Schema](https://protobuf.dev/programming-guides/proto3/) 或 [JSON Schema](https://json-schema.org/)。



## 文件结构

下面是一个简单、有效的 MCAP 文件结构，其中 Summary 和 Summary Offset 部分是可选的。

```bash
<Magic>
<Header>
<Data section>[<Summary section>][<Summary Offset section>]
<Footer>
<Magic>
```

Data（数据）、Summary（摘要）和 Summary Offset（摘要偏移）部分的结构为**记录**（records）序列：

```bash
[
<record type><record content length><record>
<record type><record content length><record>
...
]
```

不符合此结构的文件被视为格式错误。



### Magic

MCAP 文件必须以以下[魔法字节](https://en.wikipedia.org/wiki/File_format#Magic_number)（magic bytes）开始和结束：

```bash
0x89, M, C, A, P, 0x30, \r, \n
```

“MCAP”后面的字节 `0x30` 是主版本字节，它是 ASCII 字符 `0`。对本规范文档的任何更改（即向记录添加字段、引入新记录）都将在主版本中二进制向后兼容。

### Header

前导魔法字节之后的第一个记录是[头](https://mcap.dev/spec#header-op0x01)记录（Header）。

```text
<0x01><record content length><record>
```



### Footer

尾随魔法字节之前的最后一条记录是[页脚](https://mcap.dev/spec#footer-op0x02)记录。

```text
<0x02><record content length><record>
```



### Data Section

数据部分包含带有消息数据，附件和支持记录的记录。

数据部分允许出现以下记录：

- [Schema](https://mcap.dev/spec#schema-op0x03)
- [Channel](https://mcap.dev/spec#channel-op0x04)
- [Message](https://mcap.dev/spec#message-op0x05)
- [Attachment](https://mcap.dev/spec#attachment-op0x09)
- [Chunk](https://mcap.dev/spec#chunk-op0x06)
- [Message Index](https://mcap.dev/spec#message-index-op0x07)
- [Metadata](https://mcap.dev/spec#metadata-op0x0C)
- [Data End](https://mcap.dev/spec#data-end-op0x0F)

数据部分中的最后一条记录必须是[数据结束](https://mcap.dev/spec#data-end-op0x0F)（Data End）记录。

#### 块（Chunk）记录的使用

MCAP 文件可以将 Schema、Channel 和 Message 记录直接写入数据部分，也可以将它们写入 Chunk 记录中，以方便索引和压缩。对于在摘要部分包含 [Chunk Index](https://mcap.dev/spec#chunk-index-op0x08) 记录的 MCAP，所有 Message 记录都应写入 Chunk 记录中。

> 为什么呢？因为摘要部分中存在的“区块索引”记录向读者表明 MCAP 已被索引，他们可以使用这些记录按日志时间或主题查找消息。但是，区块之外的消息记录无法被索引，读者使用索引可能无法找到它们。

### Summary Section

可选的摘要部分（Summary Section）包含用于快速查找文件信息或其他数据部分记录的记录。

下列记录允许出现在摘要部分：

- [Schema](https://mcap.dev/spec#schema-op0x03)
- [Channel](https://mcap.dev/spec#channel-op0x04)
- [Chunk Index](https://mcap.dev/spec#chunk-index-op0x08)
- [Attachment Index](https://mcap.dev/spec#attachment-index-op0x0A)
- [Metadata Index](https://mcap.dev/spec#metadata-index-op0x0D)
- [Statistics](https://mcap.dev/spec#statistics-op0x0B)

摘要部分的所有记录必须按操作码（opcode）分组。

> 为什么呢？因为按记录操作码对摘要记录进行分组可以更有效地在摘要偏移量部分对摘要进行索引。

摘要中的通道记录是整个数据部分中的通道记录的重复。

摘要中的 Schema 记录是整个数据部分中 Schema 记录的重复。

### Summary Offset Section

可选的摘要偏移部分包含[摘要偏移](https://mcap.dev/spec#summary-offset-op0x0E)记录，用于快速查找摘要部分记录。

摘要偏移部分有助于随机访问读取。



## Records

MCAP 文件可能包含各种记录（records）。记录由单字节**操作码**（opcode）标识。`0x01`-`0x7F` 范围内的记录操作码保留用于将来的 MCAP 格式使用。`0x80`-`0xFF` 保留用于应用程序扩展和用户提案。`0x00` 不是有效的操作码。

所有 MCAP 记录按以下方式序列化：

```text
<record type><record content length><record content>
```

记录类型是单字节操作码，记录内容长度是 `uint64` 值。

可以通过在现有字段末尾添加新字段来扩展记录。读者应忽略任何未知字段。

> 页脚和消息记录将不会被扩展，因为它们的格式不允许向后兼容的大小变化。

下面的每个记录定义都包含一个`Type`列。请参阅[序列化](https://mcap.dev/spec#serialization)部分以了解如何序列化每种类型。



## 生态与未来

MCAP 已形成完整工具链生态：

- Foxglove Studio：可视化分析工具
- mcap-cli：跨平台命令行工具
- AWS RoboMaker：原生云存储支持

随着 IEEE 正在制定的 P3196 机器人数据标准，MCAP 正在演进为行业基础架构的重要组成。其设计哲学启示我们：优秀的数据格式应该在存储效率与读取便利间找到平衡，这正是 MCAP 在机器人革命中脱颖而出的关键。



## 相关链接

- MCAP 官网：[https://mcap.dev](https://mcap.dev)
- GitHub 仓库：[https://github.com/foxglove/mcap](https://github.com/foxglove/mcap)
