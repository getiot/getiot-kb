---
sidebar_position: 4
---

# KiCad 图框编辑器 Pl_Editor



KiCad 中的 Pl_Editor（Page Layout Editor）是一个图框布局编辑器工具，用于创建自定义标题块和框架引用。与框架引用和其他图形项（Logo）关联的标题栏在此称为图框。

打开 KiCad 之后，点击主界面右侧的图标即可打开 Pl_Editor。

![KiCad Pl_Editor Ubuntu Screenshot](https://static.getiot.tech/KiCad-ubuntu-screenshot-pleditor.png#center)



## 基本图框

KiCad 支持的基本图框项目有：

- **线**
- **矩形**
- **文本** （带格式符号，将被实际文本替换， 比如 Eeschema 或 Pcbnew 中的日期，页码…）
- **多边形** （主要用于放置 Logo 和特殊图形形状）
- **位图**（位图只能由 PDF 和 PS 绘图仪绘制，对于其他绘图仪，仅绘制边界框）

为了方便操作，KiCad 图框项目可以重复，可以旋转文本和多边形。

- 文本、多边形和位图由位置定义，可以旋转。
- 线和矩形由两点定义（起点和终点），不能旋转。

这些基本项目都是可以重复的。同时，重复的文本还可以接受标签的增量值（仅在文本是一个字母或一个数字时才有意义）。



## Pl_Editor 主窗口

下图是 Pl_Editor 图框编辑器的主窗口，左侧窗格包含基本项目列表，右侧窗格是项目设置编辑器。

![](https://static.getiot.tech/kicad-page-layout-editor.png#center)

### 主窗口工具栏

下图是 Pl_Editor 的顶部工具栏：

![main toolbar](https://docs.kicad.org/5.1/zh/pl_editor/images/zh/main_toolbar.png#center)

工具栏中提供了许多实用功能，可以轻松访问以下命令：

| 图标                                                         | 功能                                                   |
| ------------------------------------------------------------ | ------------------------------------------------------ |
| ![new page layout](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/new_page_layout.png#center) | 新建图框                                               |
| ![open page layout](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/open_page_layout.png#center) | 打开现有的图框布局设计文件                             |
| ![save](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/save.png#center) | 保存当前图框文件，文件后缀为 .kicad_wks                |
| ![sheetset](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/sheetset.png#center) | 图框设置，可设置图框尺寸、方向和标题栏参数             |
| ![print button](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/print_button.png#center) | 打印图框                                               |
| ![delete](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/delete.png#center) | 删除当前选定的项目                                     |
| ![undo](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/undo.png#center) ![redo](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/redo.png#center) | 撤消/重做                                              |
| ![zoom in](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/zoom_in.png#center) ![zoom out](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/zoom_out.png#center) ![zoom redraw](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/zoom_redraw.png#center) ![zoom fit in page](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/zoom_fit_in_page.png#center) | 分别是放大、缩小、重绘和自动                           |
| ![pagelayout normal view mode](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/pagelayout_normal_view_mode.png#center) | 标题栏的显示为实际显示，即文本格式符号由用户文本替换   |
| ![pagelayout special view mode](https://docs.kicad.org/5.1/zh/pl_editor/images/icons/pagelayout_special_view_mode.png#center) | 在编辑模式下显示标题栏，文本按“原样”显示，无需任何替换 |
| ![set base corner](https://docs.kicad.org/5.1/zh/pl_editor/images/zh/set_base_corner.png#center) | 参考角选择，用于显示到状态栏的坐标                     |
| ![set current page](https://docs.kicad.org/5.1/zh/pl_editor/images/zh/set_current_page.png#center) | 选择页码（页面和/或其他页面）                          |



### 绘图面板

下面是在 Pl_Editor 绘图区域中可以使用的一些命令，包括键盘命令、鼠标命令和上下文菜单。

**键盘命令**

| 按键     | 功能                       |
| -------- | -------------------------- |
| F1       | 放大                       |
| F2       | 缩小                       |
| F3       | 刷新显示                   |
| F4       | 将光标移动到显示窗口的中心 |
| Home     | 将封装放入显示窗口         |
| 空格键   | 设置当前光标位置的相对坐标 |
| 右箭头   | 将光标向右移动一个网格位置 |
| 向左箭头 | 将光标向左移动一个网格位置 |
| 向上箭头 | 将光标向上移动一个网格位置 |
| 向下箭头 | 将光标向下移动一个网格位置 |

**鼠标命令**

| 按键        | 功能                     |
| ----------- | ------------------------ |
| 滚轮        | 在当前光标位置放大和缩小 |
| Ctrl +滚轮  | 左右平移                 |
| Shift +滚轮 | 上下平移                 |
| 右键单击    | 打开上下文菜单           |

**上下文菜单**

- 添加线
- 添加矩形
- 添加文字
- 附加图框描述文件
- 缩放选择
- 网格选择





## 参考

- [Pl_Editor 简介](https://docs.kicad.org/master/zh/pl_editor/pl_editor.html)
