---
sidebar_position: 51
slug: /nproc
---

# nproc 命令



## 介绍

**nproc** 命令用于打印 Linux 系统当前进程可用的处理器数，注意此数目可能小于实际的 CPU 核心数。

**语法**：

```bash
nproc [OPTION]...
```

**选项**：

- `--all`：打印所拥有的处理器数目。
- `--ignore=N`：可能的话，排除 N 个处理单元。
- `--help`：显示此帮助信息并退出。
- `--version`：显示版本信息并退出。



## 示例

在我的 Ubuntu 上直接执行 `nproc`，输出结果如下：

```bash
$ nproc 
8
```

`nproc` 命令本身很简单，更多的是用在 Shell 脚本中，例如 `make` 时以进程可用的最大核心数进行编译：

```bash
make -j$(nproc)
```

