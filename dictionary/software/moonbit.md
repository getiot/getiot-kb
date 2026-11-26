---
sidebar_position: 20
sidebar_label: MoonBit
slug: /moonbit
---

# MoonBit：AI 原生云原生编程语言

## 简介

**MoonBit**（月兔）是由北京大学教授张宏波团队领衔研发的我国首个自主研发的通用编程语言，也是全球首个 AI 原生云原生开发平台。MoonBit 由粤港澳大湾区数字经济研究院（福田）（IDEA 研究院）主导开发，于 2024 年 9 月正式对外发布，标志着中国在基础软件领域取得重要突破。

MoonBit 是一个端到端的编程语言工具链，专为云和边缘计算设计，使用 WebAssembly（Wasm）作为编译目标。它旨在解决现有编程语言在 WebAssembly 场景下的痛点：低级语言（如 Rust、C/C++）学习曲线陡峭且编译时间长，而高级语言（如 Golang）生成的代码效率低下且体积庞大。

## 项目起源

MoonBit 项目成立于 2022 年，由粤港澳大湾区数字经济研究院（IDEA 研究院）主导开发。该项目的领导者是张宏波教授，他在语言设计和开发方面拥有十多年的专业经验，曾为多种编程语言做出贡献，包括 OCaml、ReScript（原 ReasonML/BuckleScript）等。在收到 IDEA 研究院院长沈向洋的邀请后，张宏波回到了深圳，成立了基础软件研究中心，并组建了 MoonBit 团队。

IDEA 研究院致力于人工智能和数字经济领域的前沿研究与产业落地，是一家国际化创新型机构。MoonBit 作为编程语言以及开发者平台，专注于 AI 原生通用程序语言的设计、编译器、运行时、IDE 以及构建系统的开发。

## 核心定位

MoonBit 具有三大核心定位：

### AI 原生

- **扁平化语言设计**：语言设计简洁扁平，更适合 Transformer 架构的 AI 代码生成
- **解决 AI 代码生成的安全问题**：通过语言层面的设计，提高 AI 生成代码的安全性和可靠性
- **与 AI 工具深度集成**：提供 MoonBit Agent IDE（MoonPilot），实现 AI 辅助编程

### 云原生

- **为云计算和边缘计算设计**：专为云和边缘计算场景优化
- **天然支持分布式开发**：语言和工具链设计考虑了分布式应用的需求
- **WebAssembly 优先**：以 WebAssembly 作为主要编译目标，充分利用 Wasm 的效率、安全性和紧凑性

### 全栈平台

- **一体化开发平台**：涵盖语言、编译器、构建系统、云 IDE 的完整工具链
- **快速构建和运行**：编译速度快，运行时性能优秀
- **紧凑的代码输出**：生成的 WebAssembly 代码体积小，适合边缘计算场景

## 主要特点

#### 快速构建和运行

MoonBit 的构建系统经过优化，编译速度快，能够显著提升开发效率。同时，生成的代码运行效率高，充分利用 WebAssembly 的性能优势。

#### 紧凑的代码输出

MoonBit 生成的 WebAssembly 代码体积小，这对于边缘计算和云原生应用非常重要。小的代码体积意味着更快的加载速度和更低的资源消耗。

#### 用户友好

MoonBit 的设计目标是像 Golang 一样简单易用，同时避免现有语言的遗留问题。语言设计简洁，学习曲线平缓，适合快速上手。

#### WebAssembly 优先

MoonBit 是专为 WebAssembly 设计的语言，充分利用 Wasm 的关键优势：
- **效率**：接近原生代码的执行性能
- **安全性**：沙箱执行环境，提供更好的安全隔离
- **紧凑性**：代码体积小，适合网络传输
- **跨平台**：一次编译，到处运行

## 技术架构

### 语言特性

MoonBit 语言设计简洁现代，支持：

- **方法和特征（Traits）**：面向对象编程支持
- **派生内建特征**：自动实现常用接口
- **错误处理**：完善的错误处理机制
- **包管理**：内置包管理系统
- **测试支持**：内置测试框架
- **基准测试**：性能测试工具
- **文档生成**：自动生成 API 文档
- **属性系统**：元编程支持
- **外部函数接口（FFI）**：与 WebAssembly 宿主交互
- **异步编程**：原生支持异步编程

### 工具链

MoonBit 提供完整的工具链：

- **Moon 构建系统**：现代化的构建系统，支持模块化开发
- **包管理**：集成包管理系统，支持依赖管理
- **云 IDE**：在线集成开发环境，无需安装即可使用
- **VSCode 插件**：本地开发支持
- **WebAssembly 集成**：与 WebAssembly 组件模型集成

### MoonBit Agent IDE（MoonPilot）

MoonPilot 是 MoonBit 的 AI 代码代理，提供：

- **智能代码生成**：基于 AI 的代码补全和生成
- **对话式编程**：通过对话与 AI 协作编程
- **Git 集成**：与版本控制系统集成
- **模型配置**：支持多种 AI 模型配置

## 应用领域

MoonBit 适用于以下场景：

#### 云计算

- **微服务开发**：紧凑的代码体积和快速启动时间适合微服务架构
- **Serverless 函数**：WebAssembly 的沙箱特性适合 Serverless 场景
- **边缘计算**：小体积代码适合资源受限的边缘设备

#### AI 应用开发

- **AI 原生设计**：语言设计适合 AI 代码生成
- **模型部署**：可以用于 AI 模型的部署和推理
- **AI 工具开发**：开发 AI 相关的工具和应用

#### Web 应用

- **前端应用**：WebAssembly 可以在浏览器中运行
- **Web 服务**：可以用于构建 Web 后端服务

## 使用方式

### 在线 IDE

MoonBit 提供在线 IDE 环境，可在 [https://try.moonbitlang.cn](https://try.moonbitlang.cn) 试用，无需安装，也不依赖任何服务器。

### 本地开发

- **CLI 工具**：下载 MoonBit CLI 工具进行本地开发
- **VSCode 插件**：安装 VSCode 插件获得完整的 IDE 体验
- **构建系统**：使用 Moon 构建系统管理项目

### 包管理

MoonBit 提供包管理系统，可以通过 [mooncakes.io](https://mooncakes.io) 查找和管理包。

## 发展路线图

MoonBit 项目预计在 2024 年第二季度末达到 beta 状态，该阶段将具有：
- 相对稳定的语言特性
- 最少的 bug
- 强大的外部函数接口（FFI）用于与 Wasm 宿主交互

达到 beta 质量后，MoonBit 将公开源代码。未来计划包括：
- **Wasm 2.0 集成**：集成 Wasm GC（垃圾回收）
- **Wasm 1.0 GC**：自研的符合 Wasm 规范的 GC 实现

## 社区和资源

**官方资源**

- **官方网站**：[https://www.moonbitlang.cn](https://www.moonbitlang.cn)
- **文档**：[https://docs.moonbitlang.cn](https://docs.moonbitlang.cn)
- **在线 IDE**：[https://try.moonbitlang.cn](https://try.moonbitlang.cn)
- **包管理中心**：[https://mooncakes.io](https://mooncakes.io)

**学习资源**

- **教程**：官方提供新手教程和 Go 开发者入门指南
- **导览**：交互式语言练习场
- **示例**：提供多个示例项目，如数独求解器、Lambda 演算、Myers Diff 等

**社区支持**

- **论坛**：可以在官方论坛发表问题
- **Discord**：加入 Discord 社区
- **GitHub**：关注项目更新



## 相关链接

- [MoonBit 官方网站](https://www.moonbitlang.cn)
- [MoonBit 官方文档](https://docs.moonbitlang.cn)
- [MoonBit 在线 IDE](https://try.moonbitlang.cn)
- [MoonBit 包管理中心](https://mooncakes.io)
- [MoonBit GitHub 主页](https://github.com/moonbitlang)
- [粤港澳大湾区数字经济研究院](https://www.idea.edu.cn)
