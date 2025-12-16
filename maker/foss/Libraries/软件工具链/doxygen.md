---
sidebar_position: 28
slug: /doxygen
---

# Doxygen

![](https://static.getiot.tech/doxygen-logo.png#center-100)

## 简介

**Doxygen** 是一个编写软件参考文档的工具，也是从带注释的 C++ 源代码生成文档的事实上的标准工具。这意味着该文档是直接写在源代码中的，因此比较容易保持更新。Doxygen 支持交叉引用，因此文档的读者可以很容易地引用实际的源代码。

虽然 Doxygen 常用于 C++ 项目，但它同时也支持其他流行的编程语言，例如 C、Objective-C、C#、PHP、Java、Python、IDL（接口描述语言，如 Corba、Microsoft 和 UNO/OpenOffice 风格）、Fortran 等等。在某种程度上，Doxygen 也支持 D 语言、VHDL 硬件描述语言。

Doxygen 的发布遵守 GNU 通用公共许可证（GPL 2.0），是一个优秀的自由软件。你可以在 [https://doxygen.nl](https://doxygen.nl/) 下载最新的 Doxygen 源代码和预编译二进制文件。

著名的 [KDE](https://kde.org/) 项目已将 Doxygen 作为它的一部分，且在 [KDevelop](https://www.kdevelop.org/) 集成开发环境中提供内置的支持。



## 用途

Doxygen 可以通过三种方式帮助你创建文档：

1. 它可以从一组文档源文件中生成一个在线文档浏览器（HTML）和/或离线参考手册（LaTeX）。还支持在 RTF（MS-Word）、PostScript、超链接 PDF、压缩 HTML、DocBook 和 Unix 手册页中生成输出。文档直接从源代码中提取，这使得文档与源代码保持一致变得更加容易。
2. 你可以配置 doxygen 以从未记录的源文件中提取代码结构。这对于在大型源代码分发中快速找到您的方式非常有用。Doxygen 还可以通过包括依赖图、继承图和协作图等 UML 图表的方式将各种元素之间的关系可视化，这些都是自动生成的。
3. 你也可以使用 doxygen 创建普通文档（就像 doxygen 项目本身的用户手册和 doxygen 网站所做的那样）。



## 语法

下面以 C++ 为例，介绍在源代码中如何添加 Doxygen 注释。

注释文档一般用两个星号标志：

```cpp
/**
 * <A short one line description>
 *
 * <Longer description>
 * <May span multiple lines or paragraphs as needed>
 *
 * @param  Description of method's or function's input parameter
 * @param  ...
 * @return Description of the return value
 */
```

但也能像 HeaderDoc 一样使用 `*!` 的标志。例如：

```cpp
/*!
 * <A short one line description>
 *
 * <Longer description>
 * <May span multiple lines or paragraphs as needed>
 *
 * @param  Description of method's or function's input parameter
 * @param  ...
 * @return Description of the return value
 */
```



## 相关链接

- 官方网站：[https://doxygen.nl](https://doxygen.nl/)
- GitHub 主页：[https://github.com/doxygen](https://github.com/doxygen/doxygen)
- 应用示例：[从 C++ 源代码生成 UML 类图](/article/how-to-generate-uml-from-cpp-source-code/)

