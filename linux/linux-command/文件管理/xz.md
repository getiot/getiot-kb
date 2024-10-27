---
sidebar_label: xz 命令
sidebar_position: 27
slug: /xz
---

# xz 命令



## 介绍

**xz** 命令是为 POSIX 平台开发具有高压缩率的工具。它使用 LZMA2 压缩算法，生成的压缩文件比 POSIX 平台传统使用的 gzip、bzip2 生成的压缩文件更小，而且解压缩速度也很快。

最初 XZ Utils 的是基于 LZMA-SDK 开发，但是 LZMA-SDK 包含了一些 Windows 平台的特性，而 XZ Utils 为适应 POSIX 平台作了大幅的修改。XZ Utils 的出现也是为了取代 POSIX 系统中旧的 LZMA Utils。

xz 命令由 XZ Utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
$ sudo apt install xz-utils
```

**语法**：

```bash
xz [option...]  [file...]
```

**选项**：

- `-z, --compress`：强制压缩。
- `-d, --decompress`：强制解压缩。
- `-t, --test`：测试压缩文件完整性。
- `-l, --list`：列出 .xz 文件的信息。
- `-k, --keep`：保留（不要删除）输入文件。
- `-f, --force`：强制覆写输出文件和（解）压缩链接。
- `-c, --stdout`：向标准输出写入，同时不要删除输入文件。
- `-0 ... -9`：压缩预设等级；默认为 6；使用 7-9 的等级之前，请先考虑压缩和解压缩所需的内存用量！（会占用大量内存空间）
- `-e, --extreme`：尝试使用更多 CPU 时间来改进压缩比率；不会影响解压缩的内存需求量。
- `-T, --threads=数量`：使用最多指定数量的线程；默认值为 1；设置为 0 可以使用与处理器内核数量相同的线程数。
- `-q, --quiet`：不显示警告信息；指定两次可不显示错误信息。
- `-v, --verbose`：输出详细信息；指定两次可以输出更详细的信息。
- `-h, --help`：显示本短帮助信息并退出。
- `-H, --long-help`：显示长帮助信息（同时列出高级选项）。
- `-V, --version`：显示软件版本号并退出。



## 示例

压缩一个文件 hello.txt，压缩成功后生成 hello.txt.xz：

```bash
xz hello.txt
```

解压 hello.txt.xz 文件，并保持原文件不被删除：

```bash
xz -d -k hello.txt.xz
```

:::warning

xz 在压缩和解压的时候，默认都会将原文件删除，如果不希望删除原文件，请使用 `-k` 选项。

:::

查看 .xz 文件的基本信息（包括压缩率、校验方式等），可与 `-v` 或 `-vv` 选项配合显示更详尽的信息：

```bash
$ xz -l  hello.txt.xz
Strms  Blocks   Compressed Uncompressed  Ratio  Check   Filename
    1       1        856 B      5,913 B  0.145  CRC64   hello.txt.xz
```

使用参数 -0, -1, -2, … -6, … -9 或参数 `--fast`, `--best` 设定压缩率：

```bash
$ xz -k7 hello.txt
$ xz -k --fast hello.txt
```

再次查看 hello.txt.xz 文件基本信息，可以发现压缩大小和压缩比例和之前不一样了：

```bash
$ xz -l hello.txt.xz 
Strms  Blocks   Compressed Uncompressed  Ratio  Check   Filename
    1       1        896 B      5,913 B  0.152  CRC64   hello.txt.xz
```

:::tip

xz 命令的默认的压缩率预设值为 -6 ，对于大多数系统来说，甚至是一些较旧的系统，-4 … -6 压缩率预设值都不错的表现。

:::

借助 [`xargs`](/linux-command/xargs) 命令并行压缩多文件，例如将 /var/log 目录下所有的扩展名为 .log 的文件压缩在一起：

```bash
find /var/log -type f -iname "*.log" -print0 | xargs -P4 -n16 xz -T1
```

