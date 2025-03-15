---
sidebar_position: 27
slug: /pcb-design-software
---

# PCB 设计工具



本文收集一些常用、好用的 PCB 设计软件工具，包括 Altium Designer、OrCAD、PADS、Autodesk EAGLE、KiCad 等等。



## Altium Designer

Altium Designer 是 Altium 公司开发的一款电子设计自动化软件，提供原理图、PCB、FPGA 设计等功能。是目前国内使用最广泛的 PCB 设计工具，通常简称为 AD。它在 2005 年之前叫做 Protel，Protel 99SE 是许多工程师的情怀版本。后来与收购来的 PCAD 及 TASKING 整合成为 Altium Designer。

Altium Designer 目前只支持 Windows 操作系统，免费提供一个月的全功能体验，一个月之后就需要购买并获得使用授权才能继续使用。



## OrCAD

OrCAD 是一款经典的 PCB 设计工具，名字来源于 Oregon + CAD，它集成了仿真（PSpice）和分析工具以及 CIS（元器件信息系统），还可以输出 HDL 格式的 Netlist，更有全功能的免费版本做体验，跟 PSpice 和 Cadence 旗下的另一款知名 PCB 设计工具 Allegro 进行了深度整合。



## PADS

PADS 是一款规则驱动、功能强大的交互式 PCB 布局、布线软件，由 MentorGraphics 公司开发。PADS 也是国内从事电路设计的工程师和技术人员主要使用的电路设计软件之一，被很多企业定位为高端 CAD 软件。

PADS 包括 PADS Logic、PADS Layout（PowerPCB）和 PADS Router，并且可以对接 OrCAD、CAD350、Autodesk、ProE 等流行的设计工具。



## Autodesk EAGLE

EAGLE 是一款可编写脚本（Script）的 EDA 工具，具有原理图输入、PCB 布局、自动布线和计算机辅助制造（CAM）功能。EAGLE 是 Easily Applicable Graphical Layout Editor 的缩写，即易于应用的图形布局编辑器。最早由德国的 CadSoft Computer GmbH 公司开发，2016 年被 Autodesk 收购。

Autodesk EAGLE 的收费模式是按月收费，免费版本限制了电路图只能使用两个页面，PCB 只能使用两层并且尺寸最大为 80cm²。不过由于 EAGLE 被收购之前在开源硬件领域广泛使用，因此拥有丰富的库资源，GitHub 上也有许多 Eagle 格式的设计源文件。



## KiCad

KiCad 是一种免费、开源的 PCB 设计工具，它提供了大量满足任意项目设计所需的功能。包括用于生产的 BOM 和 Gerber 文件，对 PCB 进行 3D 查看的功能等等。

KiCad 最初由法国人 Jean-Pierre Charras 开发，2013 年 CERN（欧洲核子研究组织）的 BE-CO-HT 部门开始贡献一些资源，支持 KiCad 成为开源硬件领域与商用的 CAD 工具相似的工具软件。并于 2015 年发布了 KiCad 4.0.0 版本，这是第一个由大量 CERN 开发者开发的高级工具的版本，CERN 也希望通过捐款的方式支持更多开发者完善这个软件。

KiCad 如今已成为一款全功能的 PCB 设计工具，其免费、开源的特点非常适合中小企业使用，并且支持 Windows、MacOS、Linux 三大操作系统，支持 Python 脚本对电路板和封装库的自动化处理。

KiCad 是一个工具套装，由多个工具组合而成，除了工程管理这个功能以外，还包括以下 8 个部分。

| 名称               | 功能                                 |
| ------------------ | ------------------------------------ |
| Eeschema           | 原理图绘制编辑器                     |
| Symbol Editor      | 符号编辑器，为 Eeschema 提供配合服务 |
| PCBNew             | PCB 布局布线，包含 3D 预览功能       |
| Footprint Editor   | 封装编辑器，为 PCBNew 提供配合服务   |
| Gerber View        | 查看 Gerber 文件                     |
| Bitmap2Component   | 将图像文件转变成 PCB 的封装          |
| PCB Calculator     | PCB 上的参数计算器                   |
| Page Layout Editor | 页面布局编辑器                       |



## EasyEDA / 立创EDA

EasyEDA 是一款国产的免费、免安装、基于云的在线 EDA 设计工具，也就是说，用户可以在浏览器上完成 PCB 的设计工作。海外市场使用“EasyEDA”的名字，国内市场则使用“立创EDA”。EasyEDA 与其母公司立创商城和嘉立创融合，立创商城所售卖的元件都做成了原理图和 PCB 的封装库文件，大大方便了 PCB 的设计，PCB 设计完成后可以直接在嘉立创打样，形成了“工业4.0”的模板。

- EasyEDA：[https://easyeda.com](https://easyeda.com)
- 立创EDA：[https://lceda.cn](https://lceda.cn)
