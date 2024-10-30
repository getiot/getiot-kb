---
sidebar_label: sysctl 命令
sidebar_position: 53
slug: /sysctl
---

# Linux sysctl 命令 - 读取/设置内核参数



## 介绍

**sysctl**（英文全拼：system control）命令被用于在 Linux 内核运行时动态地修改内核的运行参数。可用的内核参数会导出到 /proc 文件系统的 sys 目录中，其中包含一些 TCP/IP 堆栈和虚拟内存系统的高级选项，可用来控制 Linux 网络配置，这些参数对于系统性能非常重要。

**语法**：

```bash
sysctl [options] [variable[=value] ...]
```

**选项**：

- `-a`, `--all`：显示所有变量。
- `--deprecated`：将不推荐使用的参数包含到列表中。
- `-b`, `--binary`：打印值但不换行。
- `-e`, `--ignore`：忽略未知变量错误。
- `-N`, `--names`：打印没有值的变量名称。
- `-n`, `--values`：仅打印给定变量的值。
- `-p`, `--load[=<file>]`：从文件中读取值。
- `--system`：从所有系统目录读取值。
- `-r`, `--pattern <expression>`：选择与表达式匹配的设置。
- `-q`, `--quiet`：不回显变量集。
- `-w`, `--write`：允许将值写入变量。
- `-h`, `--help`：显示帮助信息。
- `-V`, `--version`：显示版本信息。



## 示例

查看所有可读变量：

```bash
sysctl -a
```

重新加载 /etc/sysctl.conf 配置文件，使配置生效：

```bash
sysctl -p
```

