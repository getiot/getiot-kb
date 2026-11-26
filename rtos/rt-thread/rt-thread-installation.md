---
sidebar_position: 3
authors: [luhuadong]
---

# RT-Thread 开发环境



为了提升开发体验，RT-Thread 为我们提供了几种开发环境，主要包括使用多年的 Env 工具和近年来主推的 RT-Thread Studio 集成开发环境。当然，Env 工具提供了 IAR、MDK、GCC 等工程的构建，因此您完全可以使用这些熟悉的工具进行开发。



## Env 工具

Env 是 RT-Thread 推出的开发辅助工具，针对基于 RT-Thread 操作系统的项目工程，提供编译构建环境、图形化系统配置及软件包管理功能。其内置的 menuconfig 提供了简单易用的配置剪裁工具，可对内核、组件和软件包进行自由裁剪，使系统以搭积木的方式进行构建。

- 优点：支持 Windows/Linux/MacOS 平台，配置、运行速度快。
- 缺点：学习周期较长，需要了解 git、scons、Kconfig、Python 等知识，需要配合其他工具进行编辑和调试。
- 下载：[https://www.rt-thread.org/page/download.html](https://www.rt-thread.org/page/download.html)
- GitHub 仓库：[https://github.com/RT-Thread/env](https://github.com/RT-Thread/env)

Env 工具的相关知识点如下图所示：

![](https://static.getiot.tech/rtt-env-tools-map.png#center)



## RT-Thread Studio

RT-Thread Studio 是一个基于 Eclipse 的开发工具软件，主要包括工程创建和管理，代码编辑，SDK管理，RT-Thread配置，构建配置，调试配置，程序下载和调试等功能。

- 优点：低门槛快速上手，一站式开发，图形化配置，社区版本永久免费。
- 缺点：目前只支持 Windows 平台，配置、编译、运行速度较慢，支持的硬件平台较少。
- 下载：[https://www.rt-thread.org/page/studio.html](https://www.rt-thread.org/page/studio.html)

![](https://static.getiot.tech/rt-thread-studio-show.png#center)




## 其他

还有其他一些开发方式，比如在 Keil MDK 中以 pack 形式添加 RT-Thread 内核。

