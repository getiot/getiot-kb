---
sidebar_position: 1
---

# Lua 简介



![](https://static.getiot.tech/Lua-Logo_128x128.png#center)



## 概述

**[Lua](https://www.lua.org)** 是一门可扩展的轻量级嵌入式脚本语言，项目起源于 1993 年巴西[里约热内卢天主教大学](https://www.puc-rio.br/index.html)（Pontifical Catholic University of Rio de Janeiro，简称 PUC-Rio）的 Tecgraf 实验室里的一个研究小组，由 [Roberto Ierusalimschy](https://en.wikipedia.org/wiki/Roberto_Ierusalimschy)、[Waldemar Celes](http://www.inf.puc-rio.br/en/teacher/@waldemar-celes) 和 [Luiz Henrique de Figueiredo](https://lhf.impa.br/bio.html) 三人完成设计。

![](https://static.getiot.tech/lua-author-team.jpg#center)

> 图. 从左到右分别是 Waldemar, Roberto, Luiz

其设计目的是为了嵌入应用程序中，从而为应用程序提供灵活的扩展和定制功能。Lua 由标准 C 编写而成，几乎在所有操作系统和平台上都可以编译、运行。Lua 并没有提供强大的库，这是由它的定位决定的。所以 Lua 不适合作为开发独立应用程序的语言。Lua 有一个同时进行的 JIT 项目，提供在特定平台上的即时编译功能。



## 项目起源

Tecgraf 实验室创立于1987年，主要专注于图形图像相关的工具研发上。在创立之后，该实验室的工作就是向客户提供基本的图形相关的软件工具，比如图形库、图形终端等。

由于 1977 至 1992 年间，巴西政府对电脑软硬件进行了严格的管制措施，使得 Petrobras（巴西石油公司）成为 Tecgraf 实验室最大的客户之一。Tecgraf 为其开发了两门语言，分别是 DEL 和 SOL，而这两门语言正是 Lua 语言的前身。

Lua 于 1993 年作为一个内部项目进行开发，因为这门语言的前身之一是 SOL 语言，在葡萄牙语中这个单词的意思是“太阳”，因此团队决定给这门新的语言起名为“Lua”，葡萄牙语的意思是“月亮”。

1996 年对 Lua 来说是很重要的一年，这一年 Lua 在国际上获得了关注，开始迎来国际用户。其一是作者在《Software: Practice & Experience》杂志上发表了一篇关于 Lua 的论文，吸引来了不少的关注。同年12月，Lua2.5 版本发布，《Dr. Dobb’s Journal》杂志专门针对 Lua 做了报告，由于这本杂志在程序员圈子里受众颇多，吸引了不少从业者的注意，其中包括时任 Lucas 艺术旗下 Grim Fandango 游戏项目的主管 Bret Mogilefsky。他在自己的项目中，使用 Lua 替换掉了原来项目中使用的脚本语言，后来又在 Game Developers’s Conference（简称为 GDC，是游戏程序员最重要的会议之一）分享了自己使用 Lua 的成功经验。从此，Lua 在游戏圈就开始流行起来了，成为游戏领域使用最广泛的脚本语言之一。

Lua 虽然起源于巴西，也是从巴西公司的项目中受驱动而开发的，但是从一开始这门语言的设计者就把眼光投向世界。在很长一段时间里，Lua 的文档只有英语版本，而不是作者的母语葡萄牙语。作者的国际化视野使得 Lua 项目得以成为全球性的开源项目。



## 功能特性

Lua 语言从一开始就将自己定位成一个“嵌入式的脚本语言”，提供了如下的特性：

1. **可移植性**：使用纯 C 语言编写的解释器，可以在 Mac、Linux、Windows 及嵌入式设备上编译运行。
2. **良好的嵌入性**：Lua 提供了非常丰富的 API，可供宿主程序与 Lua 脚本之间进行通信和交换数据。
3. **轻量级**：Lua 代码简洁优美，Lua 5.4.3 版本的压缩包仅有 350KB 大小，编译后的二进制库文件也不过 300KB。
4. **高效**：Lua 的效率很高，几乎是脚本语言中速度最快的语言。为了提高Lua的性能，作者们将最初的使用 Lex、Yacc 等工具自动生成的代码都变成了自己手写的词法分析器和解析器。
5. **可扩展**：Lua 提供了易于使用的扩展接口和机制 —— 由宿主语言（通常是 C 或 C++）提供这些功能，Lua 可以使用它们，就像是本来就内置的功能一样。
6. **免费和开源**：开放和低成本大大降低了 Lua 的使用门槛。
7. 其他特性：
   - 支持面向过程（procedure-oriented）编程和函数式编程（functional programming）；
   - 自动内存管理；
   - 只提供了一种通用类型的表（table），用它可以实现数组，哈希表，集合，对象；
   - 语言内置模式匹配；
   - 闭包(closure)；
   - 函数也可以看做一个值；
   - 提供多线程（协同进程，并非操作系统所支持的线程）支持；
   - 通过闭包和 table 可以很方便地支持面向对象编程所需要的一些关键机制，比如数据抽象，虚函数，继承和重载等。

总的来说，Lua 语言解释器非常成熟，体积小，速度快。它已经从其他编程语言和上层软件的标准演变而来的。可以运行于网络服务器，或作为小型程序运行在内存小的设备上。



## 应用场景

- 游戏编程
- 脚本中的独立应用程序
- 网页脚本
- 扩展和插件（例如 MySQL 代理和 MySQL 数据库的工作台）
- 安全系统（如入侵检测系统）



## 相关链接

- 官方网站：[https://www.lua.org](https://www.lua.org)
- GitHub 仓库：[https://github.com/lua/lua](https://github.com/lua/lua)

