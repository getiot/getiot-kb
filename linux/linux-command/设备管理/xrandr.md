---
sidebar_position: 14
slug: /xrandr
---

# xrandr 命令



## 介绍

**xrandr** 是用于与 X RandR 扩展进行交互的命令行工具。它允许对 X server 进行实时配置（即无需重新启动即可使配置生效），xrandr 提供了显示模式（如分辨率、刷新率等）的自动检测，以及动态配置输出（如调整大小、旋转、移动屏幕等）的功能。

**语法**：

```bash
xrandr [options]
```

**选项**：

- `-q`, `--query` ：查询
- `-s <size>/<width>x<height>` ：设置分辨率
- `-r <rate>` ：设置刷新率
- `-o`, `--output <output>` ：指定输出模式



## 示例

显示系统支持的所有分辨率

```bash
$ xrandr
Screen 0: minimum 0 x 0, current 1920 x 1080, maximum 32768 x 32768
default connected primary 1920x1080+0+0 507mm x 285mm
   1920x1080      0.00*
```

将屏幕恢复到原来的分辨率

```bash
xrandr -s 0
```

设置具体分辨率

```bash
xrandr -s 1024x768
```

旋转屏幕

```bash
xrandr -o left     # 向左旋转90度
xrandr -o right    # 向右旋转90度
xrandr -o inverted # 上下翻转
xrandr -o normal   # 回到正常角度
```

由于出错的硬件或驱动，xrandr 可能未能检测出显示器所有有效的分辨率。那么我们可以在 xrandr 里为显示器添加所需的分辨率。

首先，新建一种 xrandr 模式

```bash
xrandr --newmode '1024x768_60' 65.00 1024 1048 1184 1344 768 771 777 806 -hsync -vsync
```

然后，把这个模式添加到当前的输出设备（假设为 DisplayPort-1）

```bash
xrandr --addmode DisplayPort-1 1024x768_60
```

最后，把 DisplayPort-1 的分辨率指定为刚刚添加的新模式

```bash
xrandr --output  DisplayPort-1 --mode 1024x768_60
```

删除 xrandr 模式

```bash
xrandr --rmmode 1024x768_60
```



