---
sidebar_label: who 命令
sidebar_position: 31
slug: /who
---

# who 命令 - 显示当前登录用户



## 介绍

**who** 命令用于显示系统中有哪些使用者正在上面，显示的资料包含了使用者 ID、使用的终端机、从哪边连上来的、上线时间、呆滞时间、CPU 使用量、动作等等。

**语法**：

```shell
who [OPTION]... [ FILE | ARG1 ARG2 ]
```

**选项**：

- `-a`, `--all` ：等价于 `-b -d --login -p -r -t -T -u`。
- `-b`, `--boot` ：显示最近一次系统启动的时间。
- `-H`, `--heading` ：打印行头标题。
- `-q`, `--count` ：只显示登录的账户名称和总人数。
- `-r`, `--runlevel` ：打印当前运行等级。
- `-s`, `--short` ：简短输出，只打印账户名称、线路和时间。
- `-u`, `--users` ：列出登录的所有用户。
- `--help` ：显示帮助信息。
- `--version` ：显示版本信息。

**参数**：如果没有指定 FILE，则默认使用 /var/run/utmp。



## 示例

显示当前系统登录的用户

```shell
who
```

显示当前系统登录的用户，并显示标题栏

```shell
who -H
```

显示系统启动时间

```shell
who -b
```

精简模式显示

```shell
who -q
```

