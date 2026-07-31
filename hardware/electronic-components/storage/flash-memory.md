---
sidebar_position: 1
sidebar_label: "Flash 存储器"
slug: /flash-memory
title: "Flash 存储器：NOR/NAND 与嵌入式存储"
description: "介绍 Flash Memory 的特点、NOR/NAND 差异和在嵌入式系统中的角色，帮助理解固件与数据存储基础。"
authors: [luhuadong]
---

# Flash 存储器：NOR/NAND 与嵌入式存储



Flash Memory 是一种非易失性的存储器。在嵌入式系统中通常用于存放系统、应用和数据等，与 SDRAM、SoC 构成最小系统。在 PC 系统中，则主要用在固态硬盘以及主板 BIOS 中。另外，绝大部分的 U 盘、SDCard 等移动存储设备也都是使用 Flash Memory 作为存储介质。



## 原理

Flash 也常被译做「快闪」或「闪存」等，这是源于它能快速擦写存储阵列块的特点。其基本工作原理就是通过浮栅（Float Gate）的俘获和释放电子来改变晶体管的阈值电压，以使晶体管在某一控制栅电压下分别处于导通和截止两种不同的状态，来分别表示逻辑上的“1”和“0”。

![](https://static.getiot.tech/nor-nand-flash-single-cell-structure.gif#center)



## 特性

与传统的硬盘存储器（机械式）相比，Flash 存储器具有质量轻、能耗低、体积小、抗震能力强等的优点，但相应的也有带来了一些局限性，主要如下：

- **需要先擦除再写入**
  往 Flash 存储器写入数据时有一定的限制。它只能将当前为 1 的比特改写为 0，而无法将已经为 0 的比特改写为 1，只有在擦除的操作中，才能把整块的比特改写为 1。
- **块擦除次数有限**
  Flash 存储器的每个数据块都有擦除次数的限制（十万到百万次不等），擦写超过一定次数后，该数据块将无法可靠存储数据，成为坏块。
  为了最大化的延长 Flash Memory 的寿命，在软件上需要做擦写均衡（Wear Leveling），通过分散写入、动态映射等手段均衡使用各个数据块。同时，软件还需要进行坏块管理（Bad Block Management，BBM），标识坏块，不让坏块参与数据存储。（注：除了擦写导致的坏块外，Flash Memory 在生产过程也会产生坏块，即固有坏块。）
- **读写干扰**
  由于硬件实现上的物理特性，Flash 存储器在进行读写操作时，有可能会导致邻近的其他比特发生位翻转，导致数据异常。这种异常可以通过重新擦除来恢复。Flash 存储应用中通常会使用 ECC 等算法进行错误检测和数据修正。
- **电荷泄漏**
  存储在 Flash Memory 存储单元的电荷，如果长期没有使用，会发生电荷泄漏，导致数据错误。不过这个时间比较长，一般十年左右。此种异常是非永久性的，重新擦除可以恢复。



## 分类

根据硬件上存储原理的不同，Flash Memory 主要可以分为 NOR Flash 和 NAND Flash 两类。

其中，NOR Flash 技术是 Intel 公司于1988年首先研发出来的，它的出现彻底改变了原先由 EPROM 和 EEPROM 一统天下的局面。很快，东芝公司于1989年发表了 NAND Flash 存储结构，强调降低每比特的成本，拥有更高的性能，并且可以像磁盘一样可以通过接口轻松升级。

### NOR Flash

NOR Flash 根据与 CPU 端接口的不同，可以分为 Parallel NOR Flash（并行）和 Serial NOR Flash（串行）两类。

并行 NOR Flash 可以接入到 Host 的 SRAM/DRAM Controller 上，所存储的内容可以直接映射到 CPU 地址空间，不需要拷贝到 RAM 中即可被 CPU 访问，因而支持片上执行。串行 NOR Flash 的成本比 Parallel NOR Flash 低，主要通过 SPI 接口与 Host 连接。

![](https://static.getiot.tech/nor_flash_interface.png#center)

鉴于 NOR Flash 擦写速度慢，成本高等特性，NOR Flash 主要应用于小容量、内容更新少的场景，例如 PC 主板 BIOS、路由器系统存储等。



### NAND Flash

NAND Flash 需要通过专门的 NFI（NAND Flash Interface）与 Host 端进行通信。

![](https://static.getiot.tech/nand_flash_interface.png#center)

根据每个存储单元内存储比特个数的不同，NAND Flash 可以分为 SLC（Single-Level Cell）、MLC（Multi-Level Cell） 和 TLC（Triple-Level Cell） 三类。其中，在一个存储单元中，SLC 可以存储 1 个比特，MLC 可以存储 2 个比特，TLC 则可以存储 3 个比特。

NAND Flash 的一个存储单元内部，是通过不同的电压等级，来表示其所存储的信息的。在 SLC 中，存储单元的电压被分为两个等级，分别表示 0 和 1 两个状态，即 1 个比特。在 MLC 中，存储单元的电压则被分为 4 个等级，分别表示 00 01 10 11 四个状态，即 2 个比特位。同理，在 TLC 中，存储单元的电压被分为 8 个等级，存储 3 个比特信息。

![](https://static.getiot.tech/nand_flash_slc_mlc_tlc.png#center)

NAND Flash 的单个存储单元存储的比特位越多，读写性能会越差，寿命也越短，但是成本会更低。



### 对比

总结一下，NOR Flash 和 NAND Flash 有如下共同点：

- **都是非易失存储介质**。即掉电都不会丢失内容。
- **在写入前都需要擦除**。实际上 NOR Flash 的一个 bit 可以从1变成0，而要从0变1就要擦除整块。NAND flash 都需要擦除。

两者的主要的差异如下表所示：

|              | NOR Flash          | NAND Flash          |
| ------------ | ------------------ | ------------------- |
| 容量         | 较小               | 很大                |
| 片上执行代码 | 可以               | 不可以              |
| 读取速度     | 很快               | 快                  |
| 写入速度     | 慢                 | 快                  |
| 擦除速度     | 很慢               | 快                  |
| 可擦除次数   | 10,000 - 100,000   | 100,000 - 1,000,000 |
| 可靠性       | 高                 | 较低                |
| 访问方式     | 可随机访问         | 块方式              |
| 接口方式     | 特定完整存储器接口 | 任意 I/O 口         |
| 价格         | 高                 | 低                  |

可以看到，NAND Flash 读取速度与 NOR Flash 相近（根据接口的不同有所差异），但 NAND Flash 的写入速度和擦除速度都比 NOR Flash 快很多。同时由于两者的接口方式不同，使得 NOR Flash 的驱动程序比 NAND Flash 简单。另外在大容量下，NAND Flash 比 NOR Flash 成本要低很多，体积也更小。

可擦除次数曾经是需要考虑的一个重要特性，因为与 NOR Flash 相比，NAND Flash 的擦除次数曾高出10倍。随着今天的技术进步，这种情况已经发生了变化，如今一些 NOR Flash 的可擦除次数也可达 10 万次。不过，由于 NAND Flash 使用的块大小较小，每次操作擦除的区域较小。因此，NAND Flash 整体寿命更高一些。

一般来说，对于需要较低容量、快速随机读取访问和较高数据可靠性的应用，如代码执行所需，NOR Flash 存储器是一个很好的选择。NAND Flash 则是数据存储等应用的理想选择，因为这些应用需要更高的内存容量和更快的写入和擦除速度。目前，绝大部分手机和平板等移动设备中所使用的 eMMC 内部的 Flash Memory 都属于 NAND Flash，PC 中的固态硬盘中也是使用 NAND Flash。



## FTL 软件层

由于 Flash 存储器存在按块擦写、擦写次数的限制、读写干扰、电荷泄露等的局限，为了最大程度的发挥 Flash 的价值，通常需要有一个特殊的软件层次，实现坏块管理、擦写均衡、ECC、垃圾回收等的功能，这一个软件层次称为 FTL（Flash Translation Layer）。

在具体实现中，根据 FTL 所在的位置的不同，可以把 Flash Memory 分为 Raw Flash 和 Managed Flash 两类。

![](https://static.getiot.tech/raw_vs_managed_flash.png#center)

**Raw Flash** 需要在 Host 端提供专门的 FTL 或者 Flash 文件系统来实现坏块管理、擦写均衡等的功能。Host 端的软件复杂度较高，但是整体方案的成本较低，常用于价格敏感的嵌入式产品中。前面介绍的 NOR Flash 和 NAND Flash 都属于 Raw Flash。

**Managed Flash** 在其内部集成了 Flash 控制器，用于完成擦写均衡、坏块管理、ECC 校验等功能。相比于直接将 Flash 接入到 Host 端，Managed Flash 屏蔽了 Flash 的物理特性，对 Host 提供标准化的接口，可以减少 Host 端软件的复杂度，让 Host 端专注于上层业务，省去对 Flash 进行特殊的处理。eMMC、SD Card、UFS、U 盘都属于 Managed Flash。





## 参考

- [What is NOR Flash Memory and How is it Different from NAND? (techtarget.com)](https://searchstorage.techtarget.com/definition/NOR-flash-memory)
- [Flash (nieyong.github.io)](https://nieyong.github.io/wiki_ny/Flash.html) :star:
- [eMMC 原理 1 ：Flash Memory 简介 (wowotech.net)](http://www.wowotech.net/basic_tech/flash_memory_intro.html)
- [NAND闪存与NOR闪存 · 语雀 (yuque.com)](https://www.yuque.com/gi/5g_elc/ed699v) :star:
- [一文看懂NOR Flash - 极术社区 - 连接 AIoT 开发者与生态服务 (aijishu.com)](https://aijishu.com/a/1060000000188692)
- [杂谈闪存二：NOR和NAND Flash - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/26745577)
- [Flash 101: NAND Flash vs NOR Flash - Embedded.com](https://www.embedded.com/flash-101-nand-flash-vs-nor-flash/)
- [NAND Flash和Nor Flash到底有什么区别 (zlg.cn)](https://tools.zlg.cn/tools/article/detail/id/454.html)
- [The Basics of NAND Flash Memory Technology | Silicon Power (silicon-power.com)](https://www.silicon-power.com/blog/index.php/guides/nand-flash-memory-technology-basics/)
- [神秘的Flash Translation Layer （FTL）_存储之道的技术博客_51CTO博客](https://blog.51cto.com/alanwu/1427101)

