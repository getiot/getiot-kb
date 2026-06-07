---
sidebar_label: colordiff 命令
sidebar_position: 34
slug: /colordiff
---

# Linux colordiff 命令 - 彩色显示文件差异



## 介绍

**colordiff** 是 [diff](/linux-command/diff/) 命令的包装工具，在终端中以彩色高亮显示文件差异，使新增、删除和修改的行更容易辨认。它接受与 `diff` 相同的参数，适合在代码审查、补丁对比等场景中使用。

colordiff 命令由 colordiff 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install colordiff
```

**语法**：

```bash
colordiff [options] file1 file2
colordiff [options] < diff_output
```

所有 `diff` 的选项均可直接使用，例如 `-u`（统一格式）、`-y`（并排显示）等。也可将 `diff` 的输出通过管道传给 `colordiff` 进行着色。

相关命令：[diff](/linux-command/diff/)、[grep](/linux-command/grep/)、[rg](/linux-command/rg/)



## 示例

1、彩色比较两个文件的差异：

```bash
colordiff file1.txt file2.txt
```

2、以统一格式（unified）彩色输出差异：

```bash
colordiff -u old.c new.c
```

3、并排显示两个文件的差异：

```bash
colordiff -y -W 80 file1.txt file2.txt
```

4、对已有 diff 输出进行着色：

```bash
diff -u old.c new.c | colordiff
```

5、比较两个目录中同名文件的差异：

```bash
colordiff -r dir1/ dir2/
```
