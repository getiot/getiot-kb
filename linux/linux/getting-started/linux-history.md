---
sidebar_position: 3
sidebar_label: Linux 简史
slug: /linux-history
authors: [luhuadong]
---

# Linux 简史



如今 Linux 无处不在，不管你在哪儿，都不太可能不用 Linux。Linux 正在被越来越多的设备和产品所使用，包括遍布世界的公共电话交换网、全球数据网络、手机、无线基站控制器，以及管理这些无线蜂窝网络的通信基础设施，还有各种消费电子产品、汽车车载设备、打印机、路由器等。那么 Linux 到底是如何创造出来的？



## GNU/Linux 起源

1991年，芬兰的赫尔辛基大学的 Linus Torvalds 在 BBS 上面贴了一则消息，宣称他以 bash、gcc 等工具写了一个可以在 Intel 的 386 机器上面运行的内核程序，许多人对此很感兴趣，乘自由软件运动的春风，Linux 开始了它不平凡的旅程。

最初的 Linux 内核是由芬兰人 Linus Torvalds（托瓦兹，1969年出生）所开发的。托瓦兹的外祖父是赫尔辛基大学的统计学家，他的外祖父为了让自己的小孙子能够学点东西，所以从小就将托瓦兹带到身边来管理一些微计算机。正因如此，托瓦兹很小就学会了汇编语言。1988年，托瓦兹顺利进入赫尔辛基大学，并选读了计算机科学系。当时整个赫尔辛基只有一台 UNIX 系统的计算机，并且仅支持 16 个终端机。由于操作麻烦，需要耗费大量时间等待，实在难以满足托瓦兹的需求。为此，他不禁想到 “何不自己搞一部 UNIX 来玩？” 不过由于UNIX不向学生提供源代码，要自己写内核程序，谈何容易？

![](https://static.getiot.tech/linus-torvalds.png#center)

> 图. 年轻时的Linus Torvalds

托瓦兹是幸运的，因为当时存在一个类似 UNIX 的系统，并且与 UNIX 完全兼容，还可以在 Intel 386 机器上运行。这个系统就是 Andrew Tanenbaum 教授出于教育目的编写的 Minix 系统。

### Minix 系统

Andrew Tanenbaum 出生在美国纽约，但他是荷兰侨民（1914年他的祖辈来到美国）。他在 MIT 上大学、在加洲大学 Berkeley 分校念博士学位。由于读博士后的缘故，他来到了家乡荷兰，从此就与家乡一直有来往。后来就在荷兰 Vrije 大学开始教书、带研究生了。荷兰首都 Amsterdam 是个常年阴雨绵绵的城市，而对于 Tanenbaum 来说，这最好不过了，因为这样他就可以待在家里摆弄他的计算机了。他在 1987 年编制的 MINIX，主要用于学生学习操作系统原理。到 1991 年时版本是 1.5，目前主要有两个版本在使用 —— 1.5 版和 2.0 版，当时该操作系统在大学使用是免费的，但其它用途不是，当然目前都已经是免费的，可以从许多 FTP 上下载。到 2014 年，MINIX 3.3.0 发布，兼容 x86 和 ARM Cortex A8。

![](https://static.getiot.tech/andrew-s-tanenbaum.png#center)

> 图. Andrew S. Tanenbaum

于是，托瓦兹贷款买了一台最新式的 386 计算机，并且购买了 Minix 操作系统进行实验，发现 386 确实能够很好地支持多任务操作。由于 Minix 操作系统是附带源码的，所以托瓦兹可以从中学习到很多有关内核程序设计的概念。

而此时的 Andrew Tanenbaum 教授忙于教学，已经不大搭理 Minix 的更新，于是托瓦兹决定用 GNU 的 Bash shell 和 GCC，参照 Minix 的设计理念和书上的程序代码自己写一个 OS。1991年，托瓦兹将第一个 kernel 放上 FTP 网站的一个名为 Linux 的目录下，编号为 0.02。这项伟大的运动就此诞生！

Linux 操作系统刚开始时并没有被称作 Linux，托瓦兹给他的操作系统取名为 FREAX，其英文含义是怪诞的、怪物、异想天开等意思。在他将新的操作系统上载到 ftp.funet.fi 服务器上时，管理员 Ari Lemke 很不喜欢这个名称。他认为既然是 Linus 的操作系统就取其谐音 Linux 作为该操作系统的目录吧，于是 Linux 这个名称就开始流传下来。

### GNU 计划

与此同时，从 1983 年开始的 GNU 计划已经完成了除系统内核外的各种必备软件的开发。在 Linus Torvalds 和其他开发人员的努力下，GNU 组件可以运行于 Linux 内核之上。整个内核是基于 GPL 许可的，但是 Linux 内核并不是 GNU 计划的一部分。因为 GNU 项目有自己的系统内核 —— HURD，它的开发始于1984年，在 Linux 出现之前它有 7~8 年的时间创造出一个可用的内核，然而它的开发进程，不时被频繁的改变中断。Richard Stallman 为了无止境寻找完美内核，而忘记了 HURD 的原本目的 —— 能用的操作系统。Linux 的出现恰恰填补了 GNU 项目在操作系统内核方面的空白。

在1992年2月发布 Linux 0.12 版本时候，托瓦兹采用 GPL 许可证的新版权声明。GPL 规定用户在获取程序的时候有权获得源代码，但 GPL 没有规定转让程序是否必须免费。所以理论上，只要有人愿意购买你的程序，你开价 100 万美元都可以，只不过你必须给他相应的源代码。Linux 系统发布没几年就开始受到关注，但托瓦兹并不准备把这个系统卖掉，也不准备失去对 Linux 的控制权。他坚持开源，希望在 GPL 许可证效力下，人们能加入进来，参与 Linux 系统内核的升级过程。

### Linux 吉祥物

Linux 的标志和吉祥物是一只名字叫做 tux 的企鹅，Linux 的注册商标为 Linus Torvalds 所有。这是由于在 1996 年，一个名字叫做 William R. Della Croce 的律师开始向各个 Linux 发布商发信，声明他拥有 Linux 商标的所有权，并且要求各个发布商支付版税，这些发行商集体进行上诉，要求将该注册商标重新分配给 Linus Torvalds。

![](https://static.getiot.tech/linux-tux.png#center)

> 图. Tux：Linux吉祥物/Logo

### Linux 发行版

Linux 的快速发展离不开 GNU 项目。严格来讲，Linux 这个词本身只表示 Linux 内核，但在实际上人们已经习惯了用 Linux 来形容整个基于 Linux 内核，并且使用 GNU 工程各种工具和数据库的操作系统。包含这些组件的 Linux 软件被称为 Linux 发行版。通常，一个 Linux 发行套件包含大量的软件，比如软件开发工具、数据库、web 服务器（例如 apache）、X window、桌面环境（比如 GNOME 和 KDE）及办公套件等等。

绝大多数基于 Linux 内核的操作系统使用了大量的 GNU 软件，包括了 Shell 程序、程序库、编译器，还有许多应用程序（例如 Emacs）。正是由于 Linux 使用了许多 GNU 程序，GNU 项目的开创者 Richard Stallman 博士和自由软件基金会更加推崇将 Linux 操作系统改名为 GNU/Linux。但实际上，很多人还是喜欢把这样的操作系统叫做“Linux”。

有部分 Linux 套件，例如 Debian，目前一直采用了“GNU/Linux”的称呼，表示其对 GNU 项目和自由软件基金会尊重和肯定，以及坚守 Unix 和自由软件的精神。但大多数商业 Linux 套件依然将操作系统称为 Linux。有些人认为“操作系统”一词指的应该只是系统的内核，其他程序都只能算是应用软件，这么一来，该操作系统的内核应叫 Linux，而 Linux 套件是在 Linux 内核的基础上加入各种 GNU 工具。 

![](https://static.getiot.tech/gnu-linux.png#center)

> 图. GNU/Linux

Linux 取得了巨大的成功，但创造 Linux 的托瓦兹，生活跟以前基本一样，开着一辆牌照是“DAD OF 3”的车。家里的壁炉上，放满了他最喜欢的企鹅公仔。对于 Linux 系统，Andrew Tanenbaum 表示对其开发者 Linus Torvalds 的称赞。但他认为 Linux 的发展有很大原因是因为他为了保持 Minix 的小型化，能让学生在一个学期内就能学完，而没有接纳全世界许多人对 Minix 的扩展要求。因此，激发了托瓦兹编写 Linux，而托瓦兹正好抓住了这个好时机。

![](https://static.getiot.tech/linus-torvalds-and-andrew-tanenbaum.png#center)

> 图. Linus Torvalds 和 Andrew S. Tanenbaum



## 小结

总的来说，Linux 系统的成功，离不开以下五大支柱：

 - UNIX 操作系统 —— 1969 年诞生于贝尔实验室，Linux 是 UNIX 的一种克隆系统。
 - Minix 操作系统 —— Minix 也是 UNIX 的一种克隆系统，但 Minix 系统提供源代码。
 - GNU 计划 —— 开发 Linux 操作系统，以及 Linux 上所用大多数软件基本上都来自 GNU 计划。
 - POSIX 标准 —— 该标准在推动 Linux 操作系统以后朝着正规路上发展起着重要的作用，是 Linux 前进的灯塔。
 - Internet —— 如果没有互联网，没有遍布全世界的无数计算机 Hacker 的无私奉献，那么 Linux 最多只能发展到 0.13 (0.95) 版的水平。
