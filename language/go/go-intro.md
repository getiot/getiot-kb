---
sidebar_position: 1
slug: /go-intro
---

# Go 语言简介

Go（也称为 Golang）是由 Google 开发的一种开源的、静态强类型、编译型编程语言，它能让构造简单、可靠且高效的软件变得容易。

![Go 语言 Logo](https://static.getiot.tech/img/subjects/go-logo.png#center-100)



## 发展历史

Go 是从2007年末由 [Robert Griesemer](https://en.wikipedia.org/wiki/Robert_Griesemer)、[Rob Pike](https://en.wikipedia.org/wiki/Rob_Pike)、[Ken Thompson](https://en.wikipedia.org/wiki/Ken_Thompson) 主持开发，后来还加入了 [Ian Lance Taylor](https://github.com/ianlancetaylor)、[Russ Cox](https://github.com/rsc) 等人，并最终于2009年11月以开放源代码的形式向全球发布。

![](https://static.getiot.tech/golang-designers.jpeg#center)

> 图：从左到右分别是 Robert Griesemer、Rob Pike 和 Ken Thompson

2007年9月，在 Rob Pike 回复给 Robert Griesemer、Ken Thompson 的邮件中，谈到了一门全新的编程语言，其设计仍在雏形中，建议将之取名为 Go。在敲定名字之后，Rob、Robert、Ken 三人开始在 Google 内部进行研发。

2008年5月，Go 的研发获得了 Google 的全力支持。

2009年11月10日，Go 项目团队首次公开发布该语言，并将代码全部开源，因此这一天也被定为 Go 的官方生日。

如今，Go 语言拥有一个活跃的社区，按计划每半年发布一个主要版本，一般在每年的2月和8月。截至2024年2月，发布的最新版本是 Go 1.22 版本。Go 语言的维护周期终止在落后两个主要版本时，例如 Go 1.20 会在 Go 1.22 发布时停止支持。



## 主要特性

以下是 Go 的一些关键特点和概念：

1. **简洁而清晰的语法**：Go 的语法非常简洁，注重可读性，减少了不必要的语法元素（没有继承、多态、类等），使得代码更加清晰易懂。
2. **语法层面支持并发**：Go 内置了轻量级线程（goroutine）和通道机制（channel），使得并发编程变得更加简单。这有助于编写高效的并发程序，充分利用多核处理器的优势。
3. **垃圾回收**：Go 具有自动垃圾回收机制（GC），开发者无需手动管理内存，这有助于降低程序的复杂性，并提高开发效率。
4. **静态类型语言**：Go 是一种静态类型语言，但也支持类型推断。这使得代码更加健壮，同时保留了某种程度的灵活性。
5. **开发速度**：Go 的编译速度非常快，而且由于其简洁的语法和标准库，开发者可以更快速地编写和测试代码。
6. **强调工程实践**：Go 鼓励一些良好的工程实践，如清晰的代码结构、单元测试和文档化。
7. **跨平台支持**：Go 支持跨多个操作系统的开发，包括 Windows、Linux、macOS 等。交叉编译也非常简单，仅需更改环境变量即可。
8. **开放源代码**：Go 是开源的，拥有一个活跃的社区，可以在 GitHub 上找到 Go 的源代码以及丰富的第三方库。
9. **提供一系列辅助工具**：Go 提供了一系列工具，如 Go 命令、Go 工具链等，使得开发、构建和测试过程更加便捷。



## 应用场景

Go 语言被设计成一门应用于搭载 Web 服务器，存储集群或类似用途的巨型中央服务器的系统编程语言。目前主要用于构建 API、Web 后端和 CLI 工具。

对于高性能分布式系统领域而言，Go 语言无疑比大多数其它语言有着更高的开发效率。由于它提供了海量并行的支持，因此非常适用于需要高并发的 Web 后端开发，例如游戏服务端。



## 为什么要学习 Go

Go 语言天生“为云而生”，在全面拥抱云的时代拥有得天独厚的优势。由于 Go 语言生成的二进制可执行文件很小，可以快速启动，内存占用也很小，在容器中运行时，没有遗留负担。因此在世界各地，使用 Go 语言的大公司和优秀开源项目都比较多。例如很多 CNCF 项目，包括 Kubernetes 和 Istio 等，都是用 Go 编写的。因此，如果你想从事云端开发工作，那么掌握 Go 语言就是一项基本技能。

对开发者来说，Go 语言在保证了快速编译的同时，也保证了高效的开发效率和程序运行性能。相较于 Java 和 C++ 的滞重，Go 语言可以让开发速度更快、更容易，且性能也不差。此外，Go 语言的特性也不多，更容易上手，尤其对有 C 语言基础的同学，学习成本较低。而随着基础设施的不断云化，Go 语言在未来会变得越来越重要。



## 相关链接

- [官网 go.dev](https://go.dev)
- [国内官网镜像 golang.google.cn](https://golang.google.cn)
- [Go Release History](https://golang.google.cn/doc/devel/release)
- [Go Forum 社区](https://forum.golangbridge.org)
- [Go GitHub 主页](https://github.com/golang)
- [Go Wiki](https://go.dev/wiki/)



