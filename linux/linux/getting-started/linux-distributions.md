---
sidebar_position: 4
sidebar_label: Linux 发行版
slug: /linux-distributions
authors: [luhuadong]
---

# Linux 发行版

![](https://static.getiot.tech/linux-distro-banner.png#center)

自1991年发布以来，Linux 系统得到了来自世界各地的 Hacker 的支持，从而得到长足的发展。如今 Linux 已成为最具活力的 Unix 分支，也形成了各种各样的 Linux 发行版。不同的 Linux 发行版有不同的特色和目标，其中广为人知有 Redhat、Debian、Ubuntu、SuSE 等。



## 什么是 Linux 发行版

从技术上说，Linux 只是一个符合 POSIX 标准的内核，还不是一个完整的操作系统。除了 Linux 内核，一个典型的桌面操作系统通常还包括一个 Shell 交互界面、一些基础的工具和库、附加的软件和文档，以及窗口系统、窗口管理器等。这样一个完整的操作系统就被称为“Linux 发行版”（distribution，简称 distro）。

这个术语之所以是 “Linux 发行版”，是因为像 Debian、Ubuntu 这样的机构“发行”了 Linux 内核以及所有必要的软件及实用程序（如网络管理器、软件包管理器、桌面环境等），使其可以作为一个操作系统被用户使用。



## 类 Unix 系统大家族

下面是一份来自 [linuxtoy](http://i.linuxtoy.org/docs/guide/ch48s09.html) 的 Linux 发行版分支图，列举了从1991年到2007年间各种 Linux 发行版的发展和它们之间的关系。

![](https://static.getiot.tech/20161211011210228.png)

![](https://static.getiot.tech/20161211011123946.jpeg)



## 常见的 Linux 发行版

Linux 的发行版本可以大体分为两类，一类是商业公司维护的发行版本，一类是社区组织维护的发行版本。前者以著名的Redhat（RHEL）为代表，后者以 Debian 为代表。

### Redhat 系列

Redhat 系列包括 RHEL（Redhat Enterprise Linux，也就是所谓的 Redhat Advance Server，收费版本）、Fedora Core（由原来的 Redhat 桌面版本发展而来，免费版本）、CentOS（RHEL的社区克隆版本，免费）等。Redhat 曾经是在国内使用人群最多的 Linux 版本，甚至有人将 Redhat 等同于 Linux，而有些老鸟更是只用这一个版本的 Linux。所以这个版本的特点就是使用人群数量大，资料非常多。 

Redhat 系列的包管理方式采用的是基于 RPM 包的 YUM 包管理方式，包分发方式是编译好的二进制文件。稳定性方面 RHEL 和 CentOS 的稳定性非常好，适合于服务器使用，但是 Fedora Core 的稳定性稍差，最好只用于桌面应用。

### Debian 系列

Debian 系列包括 Debian 和Ubuntu，以及近年来开始流行的 Linux Mint 和 Elementary OS 等。Debian 是社区类 Linux 的典范，是迄今为止最遵循 GNU 规范的 Linux 系统。

Debian 最早由 Lan Murdock 于1993年创建，分为三个版本分支（branch），即 stable、testing 和 unstable。其中，unstable 为最新的测试版本，其中包括最新的软件包，但是也有相对较多的 bug，适合桌面用户；testing 的版本都经过unstable中的测试，相对较为稳定，也支持了不少新技术（比如 SMP 等）；而 stable 一般只用于服务器，上面的软件包大部分都比较过时，但是稳定和安全性都非常的高。

Debian 最具特色的是 apt-get / dpkg 包管理方式，其实 Redhat 的 YUM 也是在模仿 Debian 的 APT 方式，但在二进制文件发行方式中，APT 应该是最好的了。同时 Debian 的资料也很丰富，有很多支持的社区。

### 其他发行版

除了 Redhat 系列和 Debian 系列，以下 Linux 发行版同样值得关注。

#### SUSE Linux

SUSE Linux 简称 SuSE（德文为 Software- und System-Entwicklung，英文为 Software and system development）。现在这家公司的名字再度更改成 SUSE Linux。它原是德国的 SuSE Linux AG 公司发行维护的 Linux 发行版，是属于此公司的注册商标。2004年这家公司被 Novell 公司收购，2011年被 Attachmate 集团收购。在2015，open SUSE 团队决定靠拢 SUSE Linux 企业版（SLE）以便用户可以共享企业服务版本的 DNA，就像 CentOS 和 Ubuntu 一样。之后，open SUSE 变成了 open SUSELeap，直接基于 SLESP1。这两个发行版将共享代码库以互惠互利，SUSE 将吸取 open SUSE 的优秀内容，反之亦然。通过这一举措，open SUSE 也抛弃了常规的发行周期，一个新的版本将和 SLE 保持一致。这意味着每个版本将有更长的生命周期。

#### Gentoo

伟大的 Gentoo 是 Linux 世界最年轻的发行版本，正因为年轻，所以能吸取在她之前的所有发行版本的优点，这也是 Gentoo 被称为最完美的 Linux 发行版本的原因之一。Gentoo 最初由 Daniel Robbins（FreeBSD 的开发者之一）创建，首个稳定版本发布于2002年。

由于开发者对 FreeBSD 的熟识，所以 Gentoo 拥有媲美 FreeBSD 的广受美誉的 ports 系统 —— Portage 包管理系统。不同于 APT 和 YUM 等二进制文件分发的包管理系统，Portage 是基于源代码分发的，必须编译后才能运行，对于大型软件而言比较慢，不过正因为所有软件都是在本地机器编译的，在经过各种定制的编译参数优化后，能将机器的硬件性能发挥到极致。Gentoo 是所有 Linux 发行版本里安装最复杂的，但是又是安装完成后最便于管理的版本，也是在相同硬件环境下运行最快的版本。

但 Gentoo Linux 操作系统近年来已经失去了其原有的荣光。有些 Gentoo 用户已经认识到耗时的编译一个软件程序包带来的只是边际效益的速度和优化。自从 Gentoo 的创始人和仁慈的独裁者从2004年从项目辞职后，新成立的 Gentoo 基金会一直在试图避免明确的开发方向和频繁的开发相冲突，这导致几个高知名度的著名人士离开 Gentoo。这还有待观察是 Gentoo 是否能够恢复过去的创新素质，还是会慢慢分解成一个缺乏个人明确目标定义的松散的项目集合。

#### Arch Linux

ArchLinux 是一个为那些想了解 Linux 一切的人准备的发行版，因为你必须手动安装一切，它会让你学会基于 Linux 的操作系统的每个部分。Arch Linux ARM 被称为最好的 ARM 设备发行版。随着 Android 的成功，我们已经被 ARM 设备所包围，从树莓派到 Chromebook 再到 Nvidia Shield。为 Intel/AMD 处理器编写的传统发行版将不能在这些设备上运行。虽然一些发行版专为 ARM 设计，但是大多数都只针对具体的硬件，比如为树莓派设计的 Raspbian。这也是为什么 ArchLinuxARM（ALARM）让人眼前一亮。因为它是一个纯粹由社区主导的基于 ArchLinux 的发行版，你可以在树莓派、Chromebook、Android 设备、Nvidia Shield 等上面运行它。这个发行版更有趣的是，因为 Arch User Repository（AUR）的原因，所以你可以安装许多你可能在其他发行版上无法获得的应用程序。Arch 也因优异的文档闻名。ArchWiki 可以让我得到任何 Linux 相关的资料。

### 国产 Linux 发行版

在国产 Linux 发行版方面，比较著名的有红旗 Linux、麒麟 Linux、openEuler、Anolis OS 等发行版。

#### 红旗 Linux

红旗 Linux（RedFlag）是由北京中科红旗软件技术有限公司开发的一系列 Linux 发行版，包括桌面版、工作站版、数据中心服务器版、HA集群版和红旗嵌入式 Linux 等产品。目前在中国各软件专卖店可以购买到光盘版，同时官方网站也提供光盘镜像免费下载。红旗 Linux 是中国较大、较成熟的 Linux 发行版之一。

#### KylinOS

麒麟软件是专业从事国产操作系统研发和产业化的高新技术企业，旗下拥有银河麒麟、中标麒麟、星光麒麟三大国产操作系统品牌，服务国内用户超过6万家。

银河麒麟（KylinOS）原是在“863计划”和国家核高基科技重大专项支持下，国防科技大学研发的操作系统，后由国防科技大学将品牌授权给天津麒麟，后者在2019年与中标软件合并为麒麟软件有限公司，继续研制的以 Linux 为内核的操作系统。

中标麒麟（原名中标普华 Linux），2010年12月底，中标普华与国防科技大学强强联手进行操作系统方面的技术合作，合作之后的中标普华 Linux 操作系统更名为“中标麒麟”。中标麒麟操作系统采用强化的 Linux 内核，分成桌面版、通用版、高级版和安全版等，满足不同客户的要求，已经广泛的使用在能源、金融、交通、政府、央企等行业领域。

中标麒麟和银河麒麟在技术方面并没有太大的差异，只是各自背景有所不同。银河麒麟有军方背景，而中标麒麟则是纯粹的民营企业背景。它们都是基于 Linux 内核发展而来。

#### openEuler

EulerOS，又称为欧拉操作系统，是华为基于 CentOS 源代码，面向企业应用环境开发的一个商用 Linux 发行版。其开源的社区版本为 openEuler，又称为欧拉开源操作系统。2021年11月9日，华为携手欧拉社区的全体伙伴，在“操作系统产业峰会2021”上，将 openEuler 操作系统正式捐赠给开放原子开源基金会。这标志着欧拉从创始企业主导的开源项目演进到产业共建、社区自治的项目。

#### Anolis OS

Anolis OS 8 是 OpenAnolis 社区推出的完全开源、中立、开放的发行版，它支持多计算架构，也面向云端场景优化，兼容 CentOS 软件生态。Anolis OS 8 旨在为广大开发者和运维人员提供稳定、高性能、安全、可靠、开源的操作系统服务。



### 特殊用途的 Linux 发行版

最后，介绍一些具有特殊用途的 Linux 发行版，说不定它们当中就有你想找的呢。

- **Parted Magic**

  Parted Magic 是基于Linux的小型发行版本（40MB左右），专门实现磁盘分区和管理功能。Parted Magic 可通过 ISO 光盘、U 盘或 PXE 网络启动，启动后进入图形界面可运行 GParted 等工具软件进行硬盘的分区设置；Parted Magic 与 Lubi 是独立成的开源项目，但 Lubi 使用了 Parted Magic 的分区功能。

- **SystemRescueCD**

  SystemRescueCD 是一份可启动光盘 Linux 系统，它用于在崩溃后修复系统及数据。它的另一个目标是为在你的计算机上完成管理任务提供方便， 例如创建和修改硬盘分区。它包含了大量的系统实用工具（parted、partimage、fstools等）及基本软件（编辑器、midnight commander，网络工具）。它面向易用性，只要从光盘引导你就可以做任何事情了。其内核支持大多数最重要的文件系统（ext2/ext3、 reiserfs、xfs、jfs、vfat、ntfs、iso9660），以及网络系统（samba和nfs）。SystemRescueCD 基于 Gentoo LiveCd。

- **BackTrack**

  BackTrack 是基于 Ubuntu 的自启动运行光盘，它包含了一套安全及计算机取证工具。它其实是依靠融合 Auditor Security Linux 和 WHAX（先前的 Whoppix）而创建成的。

- **Ubuntu Studio**

  Ubuntu Studio 是一个 Ubuntu 的变种版本，主要是提供一个捆绑了专业音频、视频和图形处理软件的工作站版本。

- **Mythbuntu**

  Mythbuntu 是一份基于 Ubuntu 的发行，它是一张自启动运行光盘，着眼于构建一份单独的 MythTV 系统，这与 KnoppMyth 或 Mythdora 类似。它可以被用于安装一份独立的前端或后端或组合机器。Mythbuntu 采用 Xfce 作为缺省桌面，它提供一份图形化的控制中心来配置系统。

- **Scientific Linux**

  Scientific Linux 是一份重新编译的 Red Hat Enterprise Linux，它包含了遍布世界的多种多样的实验室和大学的贡献。

- **Tails**

  The Amnesic Incognito Live System（Tails）是基于 Debian 的自启动光盘或 USB 发行，其目标是为用户提供完整的因特网匿名功能。该发行装备了一些因特网应用程序，包括网页浏览 器、IRC 客户端、邮件 mail 客户端、即时消息信使，这都以安全为理念进行了预配置，并对网络流量进行了匿名性处理。为达到此目标，Incognito 使用了 Tor 网络，以使得网络流量很难被追踪。

- **LinuxCNC**

  LinuxCNC 是一个计算机控制机器的软件系统，例如铣床、车床、等离子切割机、切断机、机器人、hexapods 等等。

- **Edubuntu**

  Edubuntu 是一个专门面向学校和其他教育环境的 Linux 发行版. 基于深受大家欢迎的 Ubuntu 发行版建立, 它是一个完整的操作系统, 包含一个办公套件, 网页浏览器, 许多教育应用程序等等。Edubuntu 是为教师量身定做的，或者网络管理员也能够用它轻松而快速地建立一个电子教室。

- **VortexBox**

  VortexBox 是基于 Fedora 的 Linux 发行，它将一台没在使用的计算机转变为一台易于使用的音乐服务器或电唱机。一旦 VortexBox 加载好，它能自动从 CD 唱片转换出 FLAC 和 MP3 文件、对文件进行 ID3 标记、下载封面图样。VortexBox 之后便能使这些文件服务于网络媒体播放软件。音乐文件也能以流媒体形式运送到 Windows 或 Mac OS X 操作系统。

- **DouDouLinux**

  DouDouLinux 是一个儿童专用 Linux 系统，适合儿童使用的 Linux 操作系统，操作很简单，界面很卡通。

- **Ubuntu Mobile**

  Ubuntu Mobile 是移动版 Ubuntu，为互联网设备而生，可作为手机操作系统。基于当下非常流行的 Ubuntu Linux 发行版、开源、具有完整的网络支持以及丰富自定义项目。

- **Veket Linux**

  Veket Linux 是一个随身的可装在 U 盘的 Linux 操作系统，可谓百用随身系统。

还有太多了介绍不完，感兴趣的话可以点[这里](https://www.oschina.net/project/tag/3/operating-system)进一步了解。



## 应该选择哪个发行版？

可以看到，众多的 Linux 发行版百花齐放，Linux 的阵营日益壮大，每一款发行版都拥有一大批用户，开发者自愿为相关项目投入精力。Linux 发行版可谓是形形色色，它们旨在满足每一种能想得到的需求。那么，对于 Linux 开发者，就有必要理清各个发行版脉络，并从中选择适合自己的平台。

下表是 Google 趋势得分给出的 2023年 GNU/Linux 发行版排名表，在排名前 80 位的 Linux 发行版中，Ubuntu 位列第一。（右侧是 [distrowatch](https://distrowatch.com) 网站 Linux 发行版受欢迎程度排名，排名第一的是 MX Linux）

![](https://static.getiot.tech/linux-distributions-list-2023.png)

对于 Linux 初学者，我个人建议可以直接选择 Ubuntu，因为它非常流行，网络上有大量的中英文文档和讨论。当你熟悉 Linux 操作系统之后，就可以根据个人需求选择其他 Linux 发行版。如果你对选择怎么样的 Linux 发行版仍有疑问，请参考下图。

![](https://static.getiot.tech/20161211012130399.png)
