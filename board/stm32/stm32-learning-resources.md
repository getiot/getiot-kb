---
sidebar_position: 6
---

# STM32 学习资料



自从 STM32 微处理器进入国内市场，ST 官方就提供了非常详细的文档，并且有相当一部分被翻译成中文。同时，国内也有一些第三方厂商提供了配套的 STM32 开发板和教程，迎合了国内工程师的思维，也是初学者的不错选择。本文就来介绍 STM32 的常用开发文档、获取方式，以及第三方提供的教程。



## ST 官方

STM32 的手册通常会分为几大类：

- **参考手册（Reference Manual）**

  对芯片每个外设的具体描述和功能介绍，比如我们要查 USART，SPI，DMA 相关寄存器和功能的介绍就可以使用这个手册。

- **数据手册（Data Sheet）**

  在我们要设计 PCB 的时候用到这个手册的情况比较多，这个手册上面有关于这个系列芯片的引脚定义、电气特性、机械封装、料号定义等信息。

- **勘误手册（Errata Sheet）**

  描述了芯片某些功能的局限性，并给出解决办法。这个手册也比较重要，有时候我们觉得有些地方调试老是出问题，就需要查找一下，看看是否是硬件 bug。

- **闪存编程手册（Flash Programming Manual）**

  芯片的片上 Flash 操作指南，比如芯片的擦除，编程，闪存读写保护，选项字节信息等。

- **内核编程手册（Cortex-M Programming Manual）**

  对内核的系统控制块的介绍。这个手册有时候也要用到，比如我们需要了解 NVIC 和 SysTick 相关的寄存器，就需要使用这个手册。这个手册可以在 ARM 官方网站下载，也可以到 ST 官网下载，区别是 ARM 官网下载的手册是通用的，而 ST 的是针对自家芯片做的。有时候在参考手册上面找不到相关寄存器的信息时，就需要用到这个手册。

- **应用笔记（Application Note）**

  针对不同应用主题的描述性文档，部分笔记还会有配套的固件例程。应用笔记的重要性不言而喻，很多时候官方对一些应用做出了解决方案，都会以应用笔记的形式发布。

- **用户手册（User Manual）**

  一般是对某个软件库的说明文档。

这些文档都可以在 ST 的官网以及中文官网获取。

- ST 官网：[www.st.com](https://www.st.com/)
- 中文官网：[www.stmcu.com.cn](https://www.stmcu.com.cn/)

另外，ST 官方还分别为 MCU 和 MPU 提供了详细的 Wiki 网站：

- [STM32 MCU Wiki](https://wiki.stmicroelectronics.cn/stm32mcu)
- [STM32 MPU Wiki](https://wiki.stmicroelectronics.cn/stm32mpu)

还有，GitHub 主页 [github.com/STMicroelectronics](https://github.com/STMicroelectronics)



## 野火电子

- [野火产品资料下载中心](https://doc.embedfire.com/products/link/zh/latest/index.html)
- [STM32 HAL 库开发实战指南 —— 基于 H750_Pro_V](https://doc.embedfire.com/mcu/stm32/h750prov/hal/zh/latest/index.html) （[视频](https://www.bilibili.com/video/BV18X4y1M763)）
- [STM32 库开发实战指南（标准库）](https://doc.embedfire.com/products/link/zh/latest/tutorial/ebf_stm32_stdlib_tutorial.html) （电子版《[零死角玩转STM32](https://pan.baidu.com/s/1flEiiynNhaMAmk8WsY2qsg?pwd=b2ex)》）
- 哔哩哔哩：[野火_firege](https://space.bilibili.com/356820657)



## 正点原子

- [正点原子资料下载中心](http://www.openedv.com/docs/index.html)
- [STM32F7开发指南 —— HAL 库版本](https://pan.baidu.com/s/1mi12PHA)
- [STM32F7 开发指南-寄存器版本](https://pan.baidu.com/s/1o7UoP8A)
- [STM32F767 UCOS 开发手册](https://pan.baidu.com/s/1mi34HGc)
- [STM32F767 EMWIN 开发手册](https://pan.baidu.com/s/1kVHJSUV)
- [STM32F767 LWIP 开发手册](https://pan.baidu.com/s/1qYAijfu)
- 哔哩哔哩：[正点原子官方](https://space.bilibili.com/394620890)



## 百问科技

- 哔哩哔哩：[韦东山](https://space.bilibili.com/275908810)



## 洋桃电子

- [STM32 入门 100 步](https://www.bilibili.com/video/BV1MW411q7Jn/)
- [STM32 物联网入门 30 步](https://www.bilibili.com/video/BV1jP4y1E7TJ)
- [入门 PCB 设计](https://www.bilibili.com/video/BV1w7411s7De)
- [杜洋工作室](http://www.doyoung.net/)

