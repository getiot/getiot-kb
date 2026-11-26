---
sidebar_position: 5
authors: [luhuadong]
---

# 3D 打印流程

简单来说，3D 打印的流程主要有三步：建模（Modeling）、切片（Slicing）、打印（Printing）。

![](https://static.getiot.tech/3D-Printing-Process.jpeg#center)



## 建模

首先我们需要得到一个物体的 3D 模型，你可以在许多 [提供 3D 模型的网站](/3d-printing/3d-printing-model-website/) 上寻找你需要的模型，也可以自己亲自建模。

我们可以借助一些 CAD 软件工具来辅助我们建立 3D 模型，比如 [FreeCAD](https://www.freecadweb.org/)、[OpenSCAD](https://www.openscad.org/)、[Tinkercad](https://www.tinkercad.com/)、[Autodesk Fusion 360](https://www.autodesk.com/products/fusion-360/overview)、[SketchUp](https://www.sketchup.com/) 等等，都是不错的工具。（可参考 [3D 打印建模软件](/3d-printing/3d-printing-modeling-software/)）

当然，如果你需要对复杂的物体进行建模，还需要学习很多知识，包括模型的设计、材料的选择、加工的细节等等。

![](https://static.getiot.tech/3D-Modeling.png#center)

设计好 3D 模型之后，通常需要将其导出为 STL 文件。STL 文件格式已成为快速原型制造行业的事实标准数据传输格式，将实体模型的曲面用多个三角形面片表示，每个三角形面片的定义包括三角形各个定点的三维坐标及三角形面片的法矢量。



## 切片

有了 3D 模型的 STL 文件之后，就需要对其进行切片（Slicing），即将模型按照打印的先后顺序切成许多很薄的水平层。切片的结果是产生模型打印所需的 G-code 代码。

G 代码（G-code，又称 RS-274）是广泛使用的数控（numerical control）编程语言，定义了快速定位、逆圆插补、顺圆插补、中间点圆弧插补、半径编程、跳转加工等指令，用于控制机器的运动轨迹、运动速度等所有加工细节。

因此，切片对模型的打印质量至关重要，需要根据不同的 3D 打印机、不同的打印材料等因素调节切片的参数，以期达到最佳的打印效果。

![](https://static.getiot.tech/3D-Slicing.png#center)

关于切片软件，也有很多选择，包括著名的 [Cura](https://ultimaker.com/en/products/cura-software)、[Slic3r](https://slic3r.org/) 和 [PrusaSlicer](https://www.prusa3d.com/prusaslicer/) 等等，以及许多 3D 打印机厂商自己的切片软件。（可参考 [3D 打印切片软件](/3d-printing/3d-printing-slicing-software/)）



## 打印

将模型切片后的 G-code 文件（后缀 .gcode）传送到 3D 打印机，准备打印模型。3D 打印机通常支持 SD 卡脱机打印，也就是说，将 G-code 文件存储于 SD 卡，再插入 3D 打印机即可。如果机器支持 WiFi 等其他通信接口，也可以通过这些方式传送文件，控制 3D 打印机作业。

对于有 LCD 显示屏的 3D 打印机，通常可以直接通过面板来控制 3D 打印机。如果没有屏幕，可以使用 “Host 软件”（上位机）来操作。从技术上讲，任何带有 USB 端口和串行终端的设备都可以充当 Host，但使用专为 3D 打印机设计的上位机软件，将获得更好的打印体验。比如 [Pronterface](https://www.pronterface.com/)、[Repetier Host](https://www.repetier.com/)、[OctoPrint](https://octoprint.org/)、[Cura](https://ultimaker.com/en/products/cura-software)、[Simplify3D](https://www.simplify3d.com/) 等等。

上料、预热，一切准备就绪，就可以开始打印你的 3D 模型啦！

