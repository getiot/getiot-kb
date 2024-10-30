---
sidebar_label: qrencode 命令
sidebar_position: 3
slug: /qrencode
---

# qrencode 命令 - 生成二维码的工具



## 介绍

**qrencode**（英文全拼：QR Encode）命令用于根据输入文本生成二维码，可保存为 PNG 或 EPS 格式图片。

在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```shell
sudo apt install qrencode
```

**语法**：

```shell
qrencode [OPTION]...  [STRING]
```

**选项**：

- `-o`, `--output=FILENAME` ：将图像输出到 FILENAME 文件，如果指定 `-` 则输出到标准输出。
- `-r`, `--read-from=FILENAME` ：从 FILENAME 文件读取输入数据。
- `-s`, `--size=NUMBER` ：指定二维码中每个点的像素大小（默认为 3）。
- `-m`, `--margin=NUMBER` ：指定 margin 宽度（默认为 4）
- `-d`, `--dpi=NUMBER` ：指定生成 PNG 图片的 DPI（默认为 72）
- `-t`, `--type=TYPE` ：指定生成的图片类型（默认为 PNG），支持参数包括 PNG、PNG32、EPS、SVG、XPM、ANSI、ANSI256、ASCII、ASCIIi、UTF8、ANSIUTF8。
- `-i`, `--ignorecase` ：忽略大小写区别，仅使用大写字母。
- `-h`, `--help` ：显示帮助信息。
- `-V`, `--version` ：显示版本信息。

**参数**：字符串 STRING，如果没有给定则从标准输入获取



## 示例

根据 URL 在标准输出生成二维码

```shell
echo "https://getiot.tech" | qrencode -o - -t ANSI
```

生成二维码图片

```shell
qrencode -o qrcode.png 'https://getiot.tech'
```

如下：

![](https://static.getiot.tech/qrcode.png#center)

指定生成图片的像素尺寸

```shell
qrencode -s 4 -o qrcode.png 'https://getiot.tech'
```

