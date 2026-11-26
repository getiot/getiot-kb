---
sidebar_position: 16
authors: [luhuadong]
---

# OpenSCAD 使用教程



OpenSCAD 是一个免费的实体计算机辅助设计三维建模工具，支持 Windows、macOS 和 Linux 操作系统。不同于大多数自由软件，用于创建 3D 模型（如著名的应用 Blender），OpenSCAD 不专注于艺术方面的 3D 建模，而是专注于 CAD 方面。

与其他许多 CAD 设计工具不同，OpenSCAD 并没有提供交互建模，而是通过在脚本文件中描述对象来呈现 3D 模型，这意味着，你需要使用代码而不是鼠标来设计部件。这种方式的优点是，用户拥有建模过程的完全控制权，可以轻松地更改任何步骤在建模过程中，甚至设计所定义的配置参数。



## 安装

OpenSCAD 支持 Windows、macOS 和 Linux 操作系统，不同平台的安装方法略有区别，具体参考[这里](https://openscad.org/downloads.html)。

下面列举一些常用系统的命令行安装方式：

```bash
brew install openscad  # macOS
apt install openscad   # Ubuntu
yum install openscad   # Fedora
pacman -S openscad     # Arch Linux
```



## 创建模型

安装好之后，启动 OpenSCAD，点击“New”创建一个新设计文件。

![](https://static.getiot.tech/openscad-welcome-dialog.png)

进入 OpenSCAD 工作台，除了上方菜单栏和下方的状态栏，主界面主要分为 4 大区域：① 文本编辑器、② 可视区域、③ 命令行窗口、④ 属性配置窗口。

![](https://static.getiot.tech/OpenSCAD-main-ui.png)

具体说明如下：

- **文本编辑器**：内置的文本编辑器提供了基本的编辑功能，如文本搜索和替换，也支持语法高亮。在首选项对话框中可以选择预定义的颜色方案。可在该区域输入脚本代码，按 Save 保存后更新到可视区域。
- **可视化区域**：预览和渲染效果输出到视图显示区。通过使用 *Show Axes* 菜单进入相应选项，来设定坐标轴是否启用。
- **控制台窗口**：在控制台窗口中显示状态信息、警告和错误。



## 简单示例

OpenSCAD大部分时间的工作方式是通过简单形状的加法和减法。你可以用这种方法建立非常复杂的模型，所以让我们开始吧。

### 立方体

这是第一个形状，一个简单的盒子：

![OpenSCAD Simple Box](https://image.tl80.cn/article/images/a9980e060532493bb3bf8c52f56af720.png#center)

下面是代码：

```c
cube(); // create a cube
```

要让代码执行并构建模型，您需要预览它。默认情况下，每次保存时OpenSCAD都会执行此操作，也可以按F5键强制刷新。按住鼠标左键或右键在三维空间中四处移动。

现在，这产生了一个很好的立方体，但是如果没有任何维度，它就没有多大用处。OpenSCAD在任何特定的测量系统中都不起作用，相反，单位都是相对的。您可以创建一个20 x 10的长方体，并由任何其他程序（如您的3D打印切片器）来解释这些，无论是公制还是英制。它实际上提供了很大的灵活性。

让我们为立方体添加一些维度。您可以通过向多维数据集方法传入参数来执行此操作：

```c
cube(size = [10, 20, 30]); // rectangle
```

值10、20和30表示立方体在X、Y和Z轴上的大小。注意这是如何产生一个更大的矩形的：

![OpenSCAD Rectangle](https://image.tl80.cn/article/images/a96d0baa53a74b2699a7ebbf43f22e53.png#center)

默认情况下，OpenSCAD 从左下角绘制组件。您可以通过将“中心”参数设置为true来调整此设置。下面是对矩形执行此操作的代码：

```c
cube(size = [10, 20, 30], center = true); // rectangle centered
```

下面是它的样子：

![OpenSCAD Rectangle Centered](https://image.tl80.cn/article/images/bf903697e35f4072a11c229a4f086505.png#center)

居中对象对于简单的形状很有效，但是对于非对称对象，居中对象会使事情变得复杂。你需要决定哪种方法最适合你。

### 圆柱体

转到更复杂的形状，这里是一个圆柱体：

![OpenSCAD Cylinder](https://image.tl80.cn/article/images/4db248dce91247eb9b22d9ca289af570.png#center)

下面是创建它的代码：

```c
cylinder(d = 10, h = 10, center = true); // cylinder
```

与立方体不同，圆柱体会自动在X轴和Y轴的中心绘制。d参数表示直径（如果愿意，可以通过半径）。h参数是高度。不过，这里出了点问题。这个气缸看起来很“块状”。您需要增加圆周上绘制的面数。这很容易做到——将以下参数添加到您的圆柱体代码中。

```c
$fn = 100
```

因此圆柱体定义为：

```c
cylinder(d = 10, h = 10, center = true, $fn = 100);
```

下面是它的样子：

![OpenSCAD High Resolution Cylinder](https://image.tl80.cn/article/images/4c54d3140119400781299204d20fc474.png#center)

这增加了做圆所需的面数——100是一个很好的起点。请记住，这将大大增加渲染时间，特别是在复杂的模型上，因此通常最好在完成设计之前忽略这一点。

在形状上应用变换很容易。在创建形状之前，需要调用特殊方法。下面是如何使用旋转方法旋转圆柱体：

```c
rotate(a = [0, 90, 0]) cylinder(d = 10, h = 10, center = true); // rotated cylinder
```

传递给a参数的值表示X、Y和Z轴的旋转角度。结果如下：

![OpenSCAD Rotation](https://image.tl80.cn/article/images/3e0b1cf83cf048bfbc46ec84b0d69778.png#center)

另一个非常有用的函数是translate。这允许您在三维空间中移动对象。再一次，您需要传递每个轴的移动量。结果如下：

![OpenSCAD Translate](https://image.tl80.cn/article/images/154ba340f7174633bf46a02451ddfe4f.png#center)

代码如下：

```c
translate(v = [0, 25, 0]) cylinder(d = 10, h = 10, center = true); // translated cylinder
```

理解翻译方法是你能做的最重要的事情之一。它是设计最复杂的设计所必需的。

### 球体

最后，另一个有用的形状是球体：

![OpenSCAD Sphere](https://image.tl80.cn/article/images/a7994a863a8e442dba935387f2d455ef.png#center)

代码如下：

```c
sphere(d = 20);
```

就像圆柱体一样，您可以使用上面的$fn代码使其平滑。

```c
sphere(d = 20, $fn = 100);
```





## 高级编码

既然你知道了基本知识，让我们来看看一些更高级的技能。当设计零件时，有助于思考如何由较小的形状和对象构成零件。你不必这样做，你可以在你走的时候“弥补”事情，但有一个粗略的计划确实有帮助——即使只是在你的头脑里。

让我们创建一个高级形状：一个具有空心球体内部的立方体。创建一个立方体和一个中心设置为true的球体。使用差分法从另一个中减去一个：

```c
difference() {
    // subtraction
    cube(size = [50, 50, 50], center = true); // outer cube
    sphere(d = 65, center = true); // inner sphere
}
```

结果如下：

![OpenSCAD Advanced Cube](https://image.tl80.cn/article/images/978b483593d3453d9b2a5252c9e4c9c4.png#center)

用球的直径（d参数）进行实验，看看会发生什么。

在 OpenSCAD 中，通常有许多方法来完成相同的任务。如果你想在一个立方体上有一个凹槽，你可以从中减去另一个立方体，或者在上面再加两个。通常情况下，用哪种方式做事情并不重要，但根据零件的复杂程度，先做某些操作可能更容易。

下面介绍如何在多维数据集中创建通道。使用圆柱体将创建圆形通道，而不是使用另一个立方体。请注意如何再次使用差分方法，以及如何使用平移和旋转方法来操纵形状。使用rotate方法通常会使变换变得很棘手，因此在获得所需结果之前，请使用这些参数。代码如下：

```c
difference() {
    // subtraction
    cube(size = [50, 150, 50]); // outer cube
    translate(v = [25, 150, 50]) rotate(a = [90, 0, 0]) cylinder(d = 40, h = 150); // cylinder channel
}
```

下面是它的样子：

![OpenSCAD Channel Cube](https://image.tl80.cn/article/images/3f62d52d57924d90a6410af0b4552cb6.png#center)

你可能想知道什么是绿色的东西。这是因为3D模型现在只是一个预览。若要修复此问题，请按F6键完全渲染模型。这可能需要一些时间，具体取决于复杂性。预览（F5）通常在工作时足够好。以下是最终渲染的效果（将$fn设置为100）：

![OpenSCAD High Resolution Channel Cube](https://image.tl80.cn/article/images/2f093ba9a255451a9e86c1414db19c49.png#center)

下面是另一个高级示例。比如说你想用螺栓装东西。使用圆柱体创建孔非常简单，但是如果您希望埋头螺栓的螺栓头平齐安装，该怎么办？您可以简单地创建一个大圆柱体，让螺栓头坐在其中，但这看起来不是很好。解决方案是一个倒角，可以使用圆柱体方法创建。这里的技巧是指定两个直径 —— d1 和 d2。这些不同的尺寸，剩下的由 OpenSCAD 来完成。

因为我是英国人，所以我会用公制尺寸来表示 M5 沉头螺栓。你可以很容易地调整，以适应任何固定你想使用。代码如下：

```c
$fn = 100;
// bolt settings
m5_clearance_diameter = 5.5;
m5_head_clearance_diameter = 11;
m5_head_depth = 5;
difference() {
    // subtract
    cube(20, 20, 20);
    bolt_hole(10, 10, 20);
    bolt_bevel(10, 10, 15);
}
module bolt_hole(x, y, height) {
    /* M5 hole at 90 deg. */
    translate(v = [x, y, 0]) cylinder(d = m5_clearance_diameter, h = height);
}
module bolt_bevel(x, y, z) {
    // M5 bevel
    translate(v = [x, y, z]) cylinder(d2 = m5_head_clearance_diameter, d1 = m5_clearance_diameter, h = m5_head_depth);
}
```

注意螺栓尺寸是如何存储在变量中的吗？这使得编码和维护更加容易。一种你可能还没有遇到的方法是模块。这允许您定义一个代码块，以便随时执行。实际上，这是一个函数。对于任何复杂的形状，您都应该使用模块和变量，因为它们使内容更易于阅读，并且可以更快地进行任何更改。倒角如下：

![OpenSCAD Chamfer](https://image.tl80.cn/article/images/93f0edc6565c414a9870654ac3b026ce.png#center)

让我们看最后一个例子。假设你想在一个圆周围产生一系列的洞。您可以手动测量、平移和旋转所有这些，但即使使用模块，这也会很乏味。最终结果是，10个圆柱体均匀分布在一个圆上：

![OpenSCAD Circle Distribution](https://image.tl80.cn/article/images/81ea345d69b64422abb107651bedf023.png#center)

代码如下：

```c
$fn = 100;
number_of_holes = 10;
for(i = [1 : 360 / number_of_holes : 360]) {
    // number_of_holes defines number of times this code runs
    make_cylinder(i);
}
module make_cylinder(i) {
    // make cylinder and even distribute
    rotate([0, 0, i]) translate([10, 0, 0]) cylinder(h = 2, r = 2);
}
```

此代码比您预期的简单。for循环用于调用make_u缸模块10次。由于圆中有360度，360/10=36，因此每个圆柱体需要以36度的增量旋转。这个循环的每次迭代都会使i变量增加36。这个循环调用make_u圆柱体模块，它只需绘制一个圆柱体，并根据循环传递给它的度数来定位它。可以通过修改\u孔变量的number_来绘制多个或更少的圆柱体，尽管如果要调整间距，则可能需要调整间距。下面是100个圆柱体的形状，它们稍微重叠：

![OpenSCAD 100 Circle Distribution](https://image.tl80.cn/article/images/28b6c363a59f4238951d54e5861b3a53.png#center)



```c
$fn = 200;

r = 20;
hole = 10;

module cut() {
    cylinder(r = hole, h = 2.5 * r, center = ture);
}

module logo() {
    difference() {
        sphere(r = r);
        cut();
        rotate([0, 90, 0]) cut();
        #rotate([90, 0, 0]) cut();
    }
}

rotate([0, 0, -25]) logo();
```





## 导出

既然您知道如何在OpenScad中编码，那么在您可以3D打印模型之前，还需要最后一步。您需要将您的设计从OpenSCAD导出为大多数3D打印机使用的标准STL格式。幸运的是，有一个“导出到STL”按钮：“编辑器”菜单&gt；右上角：

![OpenSCAD Export STL](https://image.tl80.cn/article/images/09155e02ce8b41ffb1be80826d25549c.png#center)

今天到此为止。您现在应该对OpenSCAD有了很好的了解——所有复杂的东西都建立在这些基础之上，许多复杂的形状实际上是许多简单形状的组合。





