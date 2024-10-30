---
sidebar_label: info 命令
sidebar_position: 2
slug: /info
---

# Linux info 命令 - 查看命令和程序的文档



## 介绍

**info**（英文全拼：informations）命令用于阅读 Linux 下 info 格式的帮助信息。

就内容来说，info 页面比 [man](/linux-command/man) page 编写得要更好、更容易理解，也更友好，并支持链接跳转功能。但 man page 使用起来更容易，一个 man page 只有一页，而 info 页面则将内容组织成多个区段（称为节点），每个区段也可能包含子区段（称为子节点）。因此掌握 info 命令，需要学习如何在单独的 info 页面中浏览导航，以及如何在节点和子节点之间切换。

info 文档存放在 /usr/share/info 目录中，该目录提供了整个软件包的帮助文档。

**语法**：

```bash
info [选项] [参数]
```

**选项**：

- `-d` ：添加包含 info 格式帮助文档的目录。
- `-f` ：指定要读取的 info 格式的帮助文档。
- `-n` ：指定首先访问的 info 帮助文件的节点。
- `-o` ：输出被选择的节点内容到指定文件。
- `-w` ：显示 info 文档的物理位置。

**参数**：指定需要获得帮助的主题，可以是指令、函数或配置文件。



## 示例

查看 Automake 手册

```bash
info Automake
```

查看 info 命令本身的 info 文档

```bash
info info
```

显示 ls 命令 info 文档的位置

```bash
info -w ls
```

