---
sidebar_position: 14
slug: /cad-software
---

# CAD 制图软件



本文收集一些好用的二维设计及绘图的计算机辅助设计（computer-aided design）软件，即我们常说的 CAD 制图软件。在这些软件中，大部分是商业付费软件，例如大名鼎鼎的 AutoCAD。但我们仍然努力寻找一些好用的开源或免费的替代。



## AutoCAD

AutoCAD 是 Autodesk 公司开发的一款自动计算机辅助设计软件，用于二维绘图、详细绘制、设计文档和基本三维设计，现已经成为国际上广为流行的绘图工具。AutoCAD 具有良好的用户界面，通过交互菜单或命令行方式便可以进行各种操作。

![](https://static.getiot.tech/AutoCAD-screenshot.png#center)

- [AutoCAD 官网](https://www.autodesk.com/products/autocad/overview)



## DraftSight

如果你习惯在 AutoCAD 上作业。那么，DraftSight 将是完美的替代。

DraftSight 是一个在 Linux 上可用的极好的 CAD 工具。它有相当类似于 AutoCAD 的工作流，这使得迁移更容易。它甚至提供一种类似的外观和感觉。DrafSight 也兼容 AutoCAD 的 .dwg 文件格式。 但是，DrafSight 是一个 2D CAD 软件。截至当前，它不支持 3D CAD 。

![](https://static.getiot.tech/draftsight-screenshot.png#center)

尽管 DrafSight 是一款起价 149 美元的商业软件。在 [DraftSight 网站](https://www.draftsight2018.com/)上可获得一个免费版本。你可以下载 .deb 软件包，并在基于 Ubuntu 的发行版上安装它。为了开始使用 DraftSight ，你需要使用你的电子邮件 ID 来注册你的免费版本。

- [DraftSight 官网](https://www.draftsight.com)



## BRL-CAD

BRL-CAD 是最老的 CAD 工具之一。它也深受 Linux/UNIX 用户喜爱，因为它与模块化和自由的 *nix 哲学相一致。

BRL-CAD 始于 1979 年，并且，它仍然在积极开发。现在，BRL-CAD 不是 AutoCAD，但是对于像热穿透和弹道穿透等等的运输研究仍然是一个极好的选择。BRL-CAD 构成 CSG 的基础，而不是边界表示。在选择 BRL-CAD 时，你可能需要记住这一点。你可以从它的官方网站下载 BRL-CAD 。

- [BRL-CAD 官网](https://brlcad.org)
- [BRL-CAD 开源代码仓库](https://github.com/BRL-CAD/brlcad)



## QCAD

QCAD 是一个用于二维设计及绘图的计算机辅助设计软件，QCAD 使用了很多和 AutoCAD 相似的接口及概念，支持 AutoCAD DXF 文件格式的读写，并可以导入或导出位图。你可以使用 QCAD 绘制技术图纸，如建筑平面图、内部平面图、机械零件平面图或轮廓略图等。

QCAD 由 [RibbonSoft](https://www.ribbonsoft.com) 公司从1999年10月开始开发，代码基础是 [CAM Expert](https://zh.wikipedia.org/w/index.php?title=CAM_Expert&action=edit&redlink=1)。从名字可以看出，QCAD 使用 Qt 框架实现，支持 Linux、Mac OS X、Unix 及 Microsoft Windows 操作系统。

QCAD 提供付费的专业版本（Professional Edition）和免费的社区开源版本（Community Edition），社区版使用 GPL 协议发布，功能比专业版要少。对于一些 Linux 平台有提供预编译的 QCAD 社区版软件包，如 Debian 系统。

![](https://static.getiot.tech/QCAD-screenshot.png#center)

- [QCAD 官网](https://qcad.org)
- [QCAD 开源代码仓库](https://github.com/qcad/qcad)



## 豹图 CAD

豹图 CAD 是佛山小图科技开发的一款软件，它不是一个全面的 CAD 制图软件，但对于浏览 CAD 文件是一个不错的选择。它有干净清爽的用户界面，能够最大程度的展现图纸的内容，还提供了一些测量工具，如个数测量、长度不间断测量、面积测量、角度测量等，可以大大提高用户的工作效率。



---



## Fusion 360

Fusion 360 是 Autodesk 开发的一款基于云的 CAD/CAM/CAE 工具，整合了工业设计、机械设计、3D 建模、协作、加工等功能于一体，可输出 .OBJ 和 .STL 两种文件格式。

- [https://fusion.online.autodesk.com](https://fusion.online.autodesk.com)



## SolidWorks



## FreeCAD

对于 3D 建模，FreeCAD 是一个极好的选择，它是自由和开源软件。FreeCAD 坚持以构建机械工程和产品设计为目标。FreeCAD 是多平台的，可用于 Windows、Mac OS X+ 以及 Linux。

尽管 FreeCAD 已经是很多 Linux 用户的选择，应该注意到，FreeCAD 仍然是 0.17 版本，因此，不适用于重要的部署。但是最近开发加速了。

FreeCAD 并不专注于 direct-2D 绘图和真实形状的动画，但是它对机械工程相关的设计极好。FreeCAD 的 0.15 版本在 Ubuntu 存储库中可用。你可以通过运行下面的命令安装。

```shell
sudo apt install freecad
```

为获取新的每日构建（目前 0.17），打开一个终端（`ctrl+alt+t`），并逐个运行下面的命令。

```shell
sudo add-apt-repository ppa:freecad-maintainers/freecad-daily
sudo apt update
sudo apt install freecad-daily
```



## LibreCAD

LibreCAD 是一个自由开源的、2D CAD 解决方案。一般来说，CAD 是一个资源密集型任务，如果你有一个相当普通的硬件，那么我建议你使用 LibreCAD ，因为它在资源使用方面真的轻量化。LibreCAD 是几何图形结构方面的一个极好的候选者。

作为一个 2D 工具，LibreCAD 是好的，但是它不能在 3D 模型和渲染上工作。它有时可能不稳定，但是，它有一个可靠的自动保存，它不会让你的工作浪费。

```shell
sudo apt install librecad
```



## OpenSCAD

OpenSCAD 是一个自由的 3D CAD 软件。OpenSCAD 非常轻量和灵活。OpenSCAD 不是交互式的。你需要‘编程’模型，OpenSCAD 来解释这些代码来渲染一个可视化模型。在某种意义上说，它是一个编译器。你不能直接绘制模型，而是描述模型。

```shell
sudo apt install openscad
```





## 参考

- [Linux 上 5 个最好 CAD 软件](https://linux.cn/article-11319-1.html)

