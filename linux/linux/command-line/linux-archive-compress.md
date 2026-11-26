---
sidebar_position: 8
sidebar_label: 压缩与归档
slug: /linux-archive-compress
---

# Linux 压缩与归档：tar、gzip、zip

在 Linux 中，你经常会遇到 `.tar.gz`、`.tgz`、`.zip`、`.tar.xz` 这类文件。它们和备份、源码包、日志归档、文件传输都有关。

这一篇会帮你分清“归档”和“压缩”，并掌握 [tar](/linux-command/tar/)、[zip](/linux-command/zip/) 和 [unzip](/linux-command/unzip/) 的基本用法。

## 归档和压缩有什么不同

归档是把多个文件打包成一个文件。压缩是把数据变小。

`tar` 原本主要负责归档，常见文件名是 `.tar`。如果再配合 gzip 或 xz 压缩，就会得到：

- `.tar.gz`
- `.tgz`
- `.tar.xz`

`zip` 通常同时完成归档和压缩，常见于 Windows、macOS 和跨平台文件传输。

## 准备练习目录

```bash
mkdir -p ~/linux-practice/archive-demo/project
cd ~/linux-practice/archive-demo
echo "hello" > project/README.txt
echo "config" > project/config.conf
```

## 使用 tar 打包

创建 `.tar` 归档：

```bash
tar -cf project.tar project
```

查看归档内容：

```bash
tar -tf project.tar
```

常用选项可以这样记：

- `-c`：create，创建归档。
- `-f`：file，指定归档文件名。
- `-t`：list，列出归档内容。
- `-x`：extract，解包。

## 使用 tar.gz

创建 gzip 压缩归档：

```bash
tar -czf project.tar.gz project
```

解压到当前目录：

```bash
tar -xzf project.tar.gz
```

查看内容：

```bash
tar -tzf project.tar.gz
```

这里多了一个 `-z`，表示使用 gzip。

## 解压到指定目录

```bash
mkdir output
tar -xzf project.tar.gz -C output
```

`-C` 表示切换到指定目录后再解包。它很适合避免把文件散落到当前目录。

## 使用 zip 和 unzip

创建 zip 包：

```bash
zip -r project.zip project
```

查看 zip 内容：

```bash
unzip -l project.zip
```

解压：

```bash
unzip project.zip -d output-zip
```

如果你要和 Windows 用户交换文件，`.zip` 通常最方便。

## 常见文件类型

| 后缀 | 常见处理方式 |
| --- | --- |
| `.tar` | `tar -xf file.tar` |
| `.tar.gz` | `tar -xzf file.tar.gz` |
| `.tgz` | `tar -xzf file.tgz` |
| `.tar.xz` | `tar -xJf file.tar.xz` |
| `.zip` | `unzip file.zip` |

不要只看后缀，必要时可以用 [file](/linux-command/file/) 判断文件类型：

```bash
file project.tar.gz
```

## 打包时避免多套一层目录

打包前先看目录结构：

```bash
ls project
```

推荐打包整个项目目录：

```bash
tar -czf project.tar.gz project
```

这样别人解压后会得到一个 `project` 目录，不容易污染当前目录。

## 小结

你需要掌握这些命令：

- `tar -czf name.tar.gz dir`：打包并 gzip 压缩。
- `tar -xzf name.tar.gz`：解压 `.tar.gz`。
- `tar -tf name.tar`：查看 `.tar` 内容。
- `zip -r name.zip dir`：创建 `.zip`。
- `unzip name.zip -d dir`：解压 `.zip` 到指定目录。

对于初学者，先记住 `.tar.gz` 用 `tar -xzf`，`.zip` 用 `unzip`，就能处理大多数场景。
