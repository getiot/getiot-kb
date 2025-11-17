---
sidebar_position: 20
---

# Ubuntu 安装 7zip 及其使用方法



7-Zip 是一个开放源码的数据压缩程序，主要用在 Microsoft Windows 操作系统，Unix-like 的操作系统如 Linux 与 FreeBSD 下面有 7-zip 的移植版本 p7zip 可以使用。它提供命令行接口的程序或图形用户界面的程序，而且可以与资源管理器结合。

下面将介绍如何在 Ubuntu（或其他 Linux 发行版）安装和使用 7zip。对应的，7-Zip 文件的扩展名通常使用 .7z 后缀。



## 安装 7Zip

注意，7Zip 软件包的名称是 p7zip，如果直接搜索 7zip 将找不到软件包。在 Ubuntu 中，提供了 p7zip、p7zip-full 和 p7zip-rar 三个软件包。

p7zip 和 p7zip-full 之间的区别在于 p7zip 是一个更轻的版本，仅支持 .7z；而完整版本则支持更多的 7z 压缩算法（例如用于音频文件等）；p7zip-rar 包则提供了对 RAR 文件的支持。在大多数情况下，安装 p7zip-full 包就足够了，当然你也可以安装 p7zip-rar 以获得对 rar 文件的额外支持。

p7zip 软件包位于 Ubuntu 的 universe 仓库（社区维护的免费和开源软件），为确保顺利安装 p7zip，建议先执行以下命令：

```bash
sudo add-apt-repository universe
sudo apt update
```

在 Debian 和 Ubuntu 系统中，执行下面命令安装 7zip：

```bash
sudo apt install p7zip-full p7zip-rar
```

现在，7zip 已经安装成功了！



## 解压/提取 7Zip 文件

一旦安装好 7Zip 软件包，我们就可以在 Linux 系统中通过命令行或 GUI 的方式解压/提取 7zip 文件。

在 GUI 中，你可以像提取任何其他压缩文件一样提取 .7z 文件，右键单击该文件提取它即可。

在 Shell 终端中，你可以通过如下命令解压/提取 .7z 文件：

```bash
7z e file.7z
```



## 将文件压缩为 7zip 格式

同样的，你可以通过 GUI 和命令行两种方式将文件压缩为 7zip 格式。最简单的方式是在文件浏览器中右键单击该文件或目录，然后选择 **Compress** 压缩文件，格式选择 .7z 或 7zip 即可。

![](https://static.getiot.tech/Ubuntu-7zip-compress.png#center)

另外，你还可以使用命令行方式来操作，命令格式如下：

```bash
7z a OutputFile files_to_compress
```

例如：将 images 目录打包为 images.7z 压缩包

```bash
7z a images.7z images/
```

默认情况下，存档文件的扩展名为 .7z。





