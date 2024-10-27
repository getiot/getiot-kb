---
sidebar_label: man 命令
sidebar_position: 1
slug: /man
---

# man 命令



## 介绍

**man**（英文全拼：manuals）命令用于列出指定命令的说明文档，内容包括命令描述、语法、选项说明及相关命令等。

实际上，man 不仅可用于查看命令的使用手册，也可以查看软件服务配置文件、系统调用、库函数等帮助信息。

man 手册页文件存放在 /usr/share/man 目录下。

**语法**：

```bash
man [选项...] [章节] 手册页...
```

**选项**：

- `-f`, `--whatis` ：等同于 whatis。
- `-k`, `--apropos` ：等同于 apropos。
- `-K`, `--global-apropos` ：在所有页面中搜索文字。
- `-l`, `--local-file` ：把“手册页”参数当成本地文件名来解读。
- `-w`, `--where`, `--path`, `--location` ：输出手册页的物理位置。
- `-W`, `--where-cat`, `--location-cat` ：输出 cat 文件的物理位置。
- `-c`, `--catman` ：由 catman 使用，用来对过时的 cat 页重新排版。
- `-R`, `--recode=编码` ：以指定编码输出手册页源码。

**章节**：

| 章节号 | 说明                                        |
| ------ | ------------------------------------------- |
| 1      | 可执行程序或 shell 命令                     |
| 2      | 系统调用（内核提供的函数）                  |
| 3      | 库调用（程序库中的函数）                    |
| 4      | 特殊文件（通常位于 /dev）                   |
| 5      | 文件格式和约定，例如 /etc/passwd            |
| 6      | 游戏                                        |
| 7      | 杂项（包括宏包和规范，如 man(7)，groff(7)） |
| 8      | 系统管理命令（通常只针对 root 用户）        |
| 9      | 内核例程 （非标准）                         |



## 示例

查看 man 命令本身的用法

```bash
man man
```

将会打开一个字符阅读器，按 Enter 键或 Down 键逐行下翻，按 Up 键逐行上翻，按 q 键退出。

查看 cp 命令的用法

```bash
man cp
```

查看 /etc/passwd 文件信息

```bash
man /etc/passwd
```

查看 chown 函数的用法（而不是 chown 命令，数字 2 指定章节不可忽略）

```bash
man 2 chown
```

查看线程创建函数的用法（数字 3 指定章节可忽略）

```bash
man 3 pthread_create
```

