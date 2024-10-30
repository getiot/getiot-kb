---
sidebar_label: dwebp 命令
sidebar_position: 7
slug: /dwebp
---

# Linux dwebp 命令 - 将 WebP 图像转换为其他格式



## 介绍

**dwebp**（英文全拼：decompress WebP）命令用于将 WebP 格式图片解码成 PNG、PAM、PPM 或 PGM 格式。

WebP 格式是谷歌在 2010 年推出的新一代图片格式，旨在加快图片加载速度。图片压缩体积大约只有 JPEG 的2/3，能节省大量的服务器宽带资源和数据空间。WebP 既支持有损压缩也支持无损压缩，相较编码 JPEG 文件，编码同样质量的 WebP 文件需要占用更多的计算资源。

dwebp 命令由 webp 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```shell
sudo apt install webp
```

相关命令：[cwebp](/linux-command/cwebp)

**语法**：

```shell
dwebp [options] input_file.webp
```

**选项**：

- `-h` ：打印帮助信息。
- `-version` ：打印版本信息。
- `-bmp` ：将输出格式更改为未压缩的 BMP。
- `-tiff` ：将输出格式更改为未压缩的 TIFF。
- `-pam` ：将输出格式更改为 PAM（保留 alpha 通道）。
- `-ppm` ：将输出格式更改为 PPM（丢弃 alpha 通道）。
- `-pgm` ：将输出格式更改为 PGM。
- `-yuv` ：将输出格式更改为 YUV。



## 示例

将 picture.webp 图片解码为 PNG 格式

```shell
dwebp picture.webp -o output.png
```

将 picture.webp 图片解码为 PPM 格式

```shell
dwebp picture.webp -ppm -o output.ppm
```





