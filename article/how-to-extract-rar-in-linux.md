---
sidebar_position: 27
slug: /how-to-extract-rar-in-linux
---

# 如何在 Linux 系统中解压缩 rar 文件



RAR 是一种用于数据压缩与归档打包的私有（专利）文件格式。首个公开版本 RAR 1.3 发布于1993年，开发者为俄罗斯的尤金·罗谢尔，RAR 的全名是“Roshal ARchive”，即“罗谢尔的归档”之意。

RAR 是 Windows 用户常用的压缩格式，但在 Linux 系统上就不像 tar 和 zip 包那么方便了。为了解压缩 rar 包，在 Linux 上需要额外安装软件包。具体步骤如下：

1、安装 rar 软件包

```bash
sudo apt install rar
```

2、解压缩

```bash
rar x file.rar
```

rar 命令提供了许多命令选项，其中 `x` 命令选项用于提取具有完整路径的文件。
