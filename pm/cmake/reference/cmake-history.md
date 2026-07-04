---
sidebar_position: 4
slug: /cmake-history
authors: [luhuadong]
---

# CMake 发展历史

CMake 由 Kitware 在约 1999–2000 年开发，最初服务于美国国家医学图书馆的 ITK（Insight Segmentation and Registration Toolkit）项目，作为替代 autoconf/libtool 的跨平台构建方案。其设计目标是：与平台和编译器无关的配置、简单的使用方式、不占用开发者过多时间。随后从“构建系统生成器”扩展为工具家族：**CMake**（配置与生成）、**CTest**（测试）、**CPack**（打包）、**CDash**（测试结果展示与持续集成）。多年来被 KDE、VTK、ITK、OpenCV 等大量项目采用，并成为 C/C++ 领域事实上的跨平台构建标准之一。



## 为什么发明 CMake？

1999年，Kitware 公司承接了美国国立卫生研究院（NIH）资助的 **ITK**（Insight Segmentation and Registration Toolkit） 项目，这是一个需要跨平台运行的大型 C++ 医学图像处理库。

当时面临的核心痛点：

- **跨平台构建地狱**：同一份代码需要在 Windows（MSVC）、Linux（GCC）、macOS 上构建，手写 Makefile 和 Visual Studio 工程文件极其繁琐
- **已有工具不够用**：GNU Autotools 只能在 Unix 上运行，不支持 Windows；其他工具也各有局限
- **大型项目管理困难**：ITK 体量庞大，需要自动检测依赖、配置系统环境

于是 Kitware 决定自己造轮子，CMake（Cross-platform Make）由此诞生。



## 发展历史

| 时间           | 里程碑                                                       |
| -------------- | ------------------------------------------------------------ |
| **2000年**     | CMake 1.0 发布，最初为 ITK 项目服务                          |
| **2001年**     | 被 VTK（Visualization Toolkit）采用，开始推广                |
| **2006年**     | CMake 2.4，逐渐被更多开源项目接受                            |
| **2008年**     | CMake 2.6，功能日趋完善，社区开始增长                        |
| **2012年**     | CMake 2.8，成为 C/C++ 跨平台构建的主流选择之一               |
| **2013年**     | 现代 CMake（Modern CMake） 理念萌芽，引入 target-based 设计  |
| **2014年**     | CMake 3.0 发布 —— 划时代的版本，引入 `target_include_directories`、`target_link_libraries` 等基于 Target 的现代 API |
| **2016年之后** | 快速迭代，每年多个版本，增加对 CUDA、Swift、C++ Modules 等的支持 |
| **2023～今**   | CMake 3.25+，持续完善对 C++20 Modules、预编译头、多平台工具链的支持 |



## 设计哲学的演变

CMake 的历史可以粗略分为两个时代：

**旧时代（CMake 2.x）**： 以"目录/变量"为中心，配置繁琐，全局变量污染严重，常被诟病语法丑陋。

**现代 CMake（3.x+）**： 以 Target（目标） 为中心，依赖关系通过 `target_*` 系列命令显式声明，构建逻辑更清晰、可组合、可复用。现在社区普遍推荐使用 CMake 3.14+ 的写法。

