---
sidebar_label: convert 命令
sidebar_position: 2
slug: /convert
---

# convert 命令 - 图像格式转换工具



## 介绍

**convert** 命令用于对图像进行转换，支持包括转换图像格式、调整图像大小、模糊、裁剪、翻转、合并等功能。

convert 命令由 [ImageMagick](https://imagemagick.org/index.php) 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install imagemagick
```

**语法**：

```bash
convert [input-option] input-file [output-option] output-file
```



## 示例

Convert 的 resize 子命令应该是在 ImageMagick 中使用较多的命令，它实现了图片任意大小的缩放，唯一需要掌握的就是如何使用它的一些参数测试设定值：

此说明文件中所用的原始文件（src.png），宽度：400，高度：300

```bash
$ file src.png 
src.png: PNG image data, 400 x 300, 8-bit/color RGB, non-interlaced
```

命令格式：

```bash
-resize {width}x{height}{%} {@} {!} {<} {>} {^}
```

默认时，宽度和高度表示要最终需要转换图像的最大尺寸，同时 convert 会控制图片的宽和高，保证图片按比例进行缩放。如：

```bash
convert -resize 200x150 src.png dst.png
```

转换后的 dst.png 的图片大小（宽度为 200，而高度已经按比例调整为 150）。也可以只指定宽度或者高度，按比例对图片进行缩放。

只指定宽度：

```bash
convert -resize 200 src.png dst.png
```

只指定高度：

```bash
convert -resize x150 src.png dst.png
```


如果需要转换成 200x200，而图片无需保持原有比例，可以在宽高后面加上一个感叹号 !。如：

```bash
convert -resize 200x200! src.png dst.png
```


默认都是使用像素作为单位，也可以使用百分比来形象图片的缩放。如：

```bash
convert -resize 50%x100%! src.png dst.png
```

或者

```bash
convert -resize 50%x100% src.png dst.png
```

此参数只会按你的比例计算后缩放，不保持原有比例。（结果尺寸为 200×300）

使用 @ 来指定图片的像素个数。如：

```bash
convert -resize "10000@" src.png dst.png
```

此命令执行后，dst.png 图片大小为（115×86），图片保持原有比例（115×86 = 9080 < 10000）。

当原始文件大于指定的宽高时，才进行图片放大缩小，可使用 > 命令后缀。如：

```bash
convert -resize "200x100>" src.png dst.png
```

此命令执行后，dst.png 图片大小为（133×100），图片保持原有比例。

```bash
convert -resize "200x100>!" src.png dst.png
```

此命令执行后，dst.jpg 图片大小为（100×50），图片不保持原有比例。

当原始文件小于指定的宽高时，才进行图片放大转换，可使用 < 命令后缀。如：

```bash
convert -resize "100x500<" src.png dst.png 
```

或者

```bash
convert -resize "100x100<!" src.png dst.png
```

此命令执行后，dst.png 和 src.png 大小相同，因为原始图片宽比 100 大。如：

```bash
convert -resize "600x600<" src.png dst.png
```


此命令执行后，dst.png 图片大小为（600×450），图片保持原有比例。如：

```bash
convert -resize "600x600<!" src.png dst.png
```

此命令执行后，dst.png 图片大小为（600×600），图片不保持原有比例。

使用 ^ 命令后缀可以使用宽高中较小的那个值作为尺寸。如：

```bash
convert -resize "600x600^" src.png dst.png
```

此命令执行后，dst.png 图片大小为（800×600），图片保持原有比例。

```bash
convert -resize "600x400^" src.png dst.png
```

此命令执行后，dst.png 图片大小为（600×450），图片保持原有比例。

