---
sidebar_position: 2
slug: /a-brief-history-of-unix
authors: [luhuadong]
---

# Unix 起源



## Multics 项目

由于早期的计算机并不像现在的个人计算机一样普遍，只有极少数人才有机会接触到，并且当时的计算机架构很难使用，操作接口麻烦。因此在1965年前后，由贝尔实验室（Bell）、麻省理工学院（MIT）及通用电气公司（GE）共同发起了 Multics 的项目，Multics（全称：MULTiplexed Information and Computing System）是一个全面的、通用的分时操作系统，Multics 项目的目的是想让大型主机可以同时提供 300 台以上的终端机连接使用的目标。

可是，到了1969年前后，项目进度落后，资金也短缺，在认为 Multics 项目不可能成功之后，贝尔实验室退出了该项目的研究工作。最终 Multics 项目还是成功地开发出了他们的系统，Multics 系统虽然后来没有受到很大的重视，但是该项目培养出了很多优秀的人才，包括 Ken Thompson、Dennis Ritchie、Joe Ossanna、Douglas McIlroy、Peter Neumann、Stan Dunten、Rudd Canaday 等等。

![Multics 分时操作系统的历史](https://static.getiot.tech/multics-history.gif#center)

> Multics 分时操作系统的历史



## Unics 系统

参与 Multics 项目的工程师们调回贝尔实验室后，面对实验室落后的仍以批处理工作的计算机环境，他们非常怀念 Multics。其中一位工程师 Ken Thompson，他因为想移植一套名为“太空旅游”的游戏，希望开发一个小的操作系统以供使用。1969年8月，万般无奈的 Thompson 在库房里发现了一个闲置的 PDP-7，刚好此时处于休假期并且他的妻儿探亲去了，于是 Thompson 有了额外的一个月时间实施他的计划。经过4个星期的奋斗，以汇编语言写出了一组内核程序，还包括一些内核工具程序，以及一个小的文件系统。在操作系统、Shell 程序、编辑器和汇编程序上，他各花了一周时间。

由于当时 Thompson 从 Multics 项目中获得想法，将 Multics 庞大而复杂的系统进行简化，于是同实验室的朋友都戏称这个系统为 Unics（该系统就是 Unix 的原型）。

Thompson 的这个文件系统有两个重要的概念，分别是：

- 所有的程序或系统装置都是文件。
- 不管构建编辑器还是附属文件，所写的程序只有一个目的，就是要有效地完成目标。

这些概念在后来对于 Linux 的开发有相当重要的影响。这也就是著名的 KISS（keep it simple, stupid）原则，即“简单原则”——尽量用简单的方法解决问题，这是 “Unix 哲学” 的根本原则。

![最初运行 Unix 系统的 DEC PDP-7](https://static.getiot.tech/unix-DEC-PDP-7.jpg#center)

> 最初运行 Unix 系统的 DEC PDP-7



## C 语言与 Unix

由于 Thompson 写的 Unics 实在太好用了，所以在贝尔实验室内部广为流传，并且多次经过改版。但是因为 Unics 是以汇编语言写的，高度依赖硬件，所以每次安装到不同的机器上都需要重新编写汇编语言。于是 Thompson 与 Ritchie 合作想将 Unics 改用更高级的程序语言来编写，从而提高可移植性。他们先选择了 BCPL（简称 B 语言），然后又尝试 PASCAL，发现编译出来的内核性能都不是很好，因为这些语言都不太贴近硬件操作。于是，两人（主要是 Dennis Ritchie）决定自己开发一套新的语言：这就是大名鼎鼎的 C 语言。

![Ken Thompson 和 Dennis Ritchie 在 PDP-11 前工作](https://static.getiot.tech/unix-ken-thompson-and-dennis-ritchie.jpg#center)

> Ken Thompson（坐着）和 Dennis Ritchie 在 PDP-11 前工作

1973年，Dennis Ritchie 用 C 语言重写与编译 Unics 的内核，最后发行出 Unix 的正式版本。“重写”说起来简单，实际上并不是简单的汇编到 C 语言的翻译，这里边包含了很多的发明和创造。在此期间引入的 “pipe”（管道）功能后来成为了 Unix 的一大优势，这种功能使得程序间输出结果的传递非常容易。管道的概念是贝尔实验室的 Douglas McIlroy 发明的，后被很多操作系统大量拷贝，其中包括 Unix 的所有变体、Linux、DOS 和 Windows。

重写过的 Unix 很快就流行起来，此后便一直应用于生产领域。50多年过去了，虽然出现了很多的类 Unix 系统（例如Linux），但是他们都继承了 Unix 中的基本思想，并且发扬光大。著名的类 Unix 系统包括 Berkeley Unix、Minix、Linux、AIX、A/UX、HP-UX 以及 Solaris，苹果的 Mac OS X 则是基于 Berkeley Software Distribution（简称 BSD）Unix。

![](https://static.getiot.tech/unix-ken-thompson-and-dennis-ritchie-1998.jpg#center)

> 1998年被授予国家科技奖章（左起分别是 Thompson、Ritchie 和克林顿）



## BSD 分支

Unix 是以 C 语言写成的，理论上是具有可移植性的，只要获得Unix的源码，并且针对大型主机的特性加以修改，就可能将 Unix 移植到另一台不同的主机上。

1973年以后，Unix 开始与学术界合作开发，其中最重要的是与加州大学伯克利分校（Berkeley）的合作。伯克利大学的 Bill Joy 在移植 Unix 的过程中加入了很多工具软件与编译程序，最终将它命名为 Berkeley Software Distribution (BSD)。BSD 是 Unix 很重要的一个分支。同时 Bill Joy 也是 Sun 这家公司的创办者。Sun 公司即是以 BSD 开发的内核进行自己的商业 Unix 版本的开发的。（后来可以安装在 x86 硬件架构上面 FreeBSD 即是 BSD 改版而来！）

由于 Unix 的高度可移植性与强大的性能，加上当时并没有版权的纠纷，所以让很多商业公司开始了 Unix 操作系统的开发。但每一家公司自己出品的 Unix 虽然在架构上大同小异，但是却仅能支持自身的硬件，所以，早些年的 Unix 只能与服务器（Server）或者大型工作站（Workstation）划上等号。直到1979年，AT&T 推出了 System V 第七版 Unix，才支持 x86 架构的个人计算机系统。后来因为 AT&T 出于商业考虑，想将 Unix 的版权收回去，因此在第七版 System V 中特别提到了“不可对学生提供源码”的严格限制。

目前被称为纯种 UNIX 的指的就是 System V 和 BSD 这两套。

![类 Unix 系统家谱](https://static.getiot.tech/unix-like-family.jpg#center)

> 类 Unix 系统家谱

从 Unix 诞生之日起，各种信誓旦旦的预言就伴随着它，说 Unix 必将衰败，或者被其它操作系统挤出市场。可是在今天，它化身为 Linux、BSD、Solaris、MacOS X 以及好几个其它变种的 Unix，却显得前所未有的强大。



## 小结

- Unix 诞生于 1969 年，此后快速被广泛应用；
- Unix 一开始是开源的，后来 AT&T 收回版权，并且不公开源代码；
- Unix 的代码是由 90% 的 C 语言和 10% 的汇编组成；
- Unix 后来的两大分支：AT&T 的 System V 和 BSD。

