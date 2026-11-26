---
sidebar_position: 5
sidebar_label: 查找文件
slug: /linux-find-files
---

# Linux 查找文件：find、locate、which、whereis

当文件越来越多时，只靠 `ls` 一层层翻目录会很低效。Linux 提供了几类查找工具：按目录实时搜索、按数据库快速搜索、查找命令位置、查找手册和相关文件。

本文介绍 [find](/linux-command/find/)、[locate](/linux-command/locate/)、[which](/linux-command/which/) 和 [whereis](/linux-command/whereis/)。

## find：实时查找

`find` 会从指定目录开始，递归搜索文件：

```bash
find 起始目录 条件
```

例如查找当前目录下所有 `.txt` 文件：

```bash
find . -name "*.txt"
```

查找 `/etc` 下名字包含 `ssh` 的文件：

```bash
find /etc -name "*ssh*"
```

如果遇到权限不足，可以先把错误输出丢弃：

```bash
find /etc -name "*ssh*" 2>/dev/null
```

这里的 `2>/dev/null` 会在重定向章节详细讲。

## 按类型查找

只查普通文件：

```bash
find . -type f
```

只查目录：

```bash
find . -type d
```

查找 `.log` 普通文件：

```bash
find . -type f -name "*.log"
```

## 按大小和时间查找

查找大于 100 MB 的文件：

```bash
find . -type f -size +100M
```

查找最近 1 天修改过的文件：

```bash
find . -type f -mtime -1
```

查找 30 天前修改过的日志：

```bash
find /var/log -type f -name "*.log" -mtime +30 2>/dev/null
```

## find 的安全使用

`find` 可以和删除动作配合，但初学阶段要特别谨慎。比如：

```bash
find . -type f -name "*.tmp" -print
```

先用 `-print` 确认结果。确认无误后再考虑删除：

```bash
find . -type f -name "*.tmp" -delete
```

:::warning
不要在不了解匹配范围时直接执行 `find / -delete` 或类似命令。先限定目录，再打印检查。
:::

## locate：快速查找

`locate` 通过预先建立的数据库查找文件，速度很快：

```bash
locate ssh_config
```

它的限制是：数据库可能不是实时更新的。刚创建的文件不一定马上能搜到。

有些系统没有默认安装 `locate`，需要通过发行版的软件包管理器安装并更新数据库。你可以先运行：

```bash
which locate
```

判断是否已经存在。

## which：查找命令路径

`which` 用来查找外部命令的可执行文件位置：

```bash
which ls
```

输出可能是：

```text
/usr/bin/ls
```

这说明你运行的 `ls` 来自 `/usr/bin/ls`。

## whereis：查找相关位置

`whereis` 会查找命令的二进制文件、源码位置和手册页：

```bash
whereis ls
```

输出类似：

```text
ls: /usr/bin/ls /usr/share/man/man1/ls.1.gz
```

它比 `which` 给的信息更多，但不一定用于判断 Shell 实际会执行哪个命令。

## type：判断命令类型

虽然本文标题没有写 `type`，但它很值得你记住：

```bash
type cd
type ls
```

`cd` 通常是 Shell 内建命令；`ls` 通常是外部程序。判断命令类型时，[type](/linux-command/type/) 经常比 `which` 更准确。

## 小结

你可以按需求选择工具：

| 需求 | 命令 |
| --- | --- |
| 在目录中实时查找文件 | `find` |
| 快速按文件名搜索 | `locate` |
| 查命令可执行文件路径 | `which` |
| 查命令相关文件和手册 | `whereis` |
| 判断命令是内建、别名还是程序 | `type` |

初学阶段重点练好 `find . -name "..."` 和 `find . -type f -name "..."`，它们会非常常用。
