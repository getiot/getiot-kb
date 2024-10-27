---
sidebar_label: tail 命令
sidebar_position: 25
slug: /tail
---

# tail 命令



## 介绍

**tail** 命令可用于查看文件的末尾部分的内容，默认显示后 10 行的内容。有一个常用的参数 **-f** 常用于查阅正在改变的日志文件。

**语法**：

```shell
tail [OPTION]... [FILE]...
```

**选项**：

- `-f` ：循环读取。
- `-q` ：不显示处理信息。
- `-v` ：显示详细的处理信息。
- `-c`, `--bytes=[+]NUM` ：显示的字节数。
- `-n`, `--lines=[+]NUM` ：显示文件的尾部 n 行内容。
- `--pid=PID` ：与 `-f` 合用，表示在进程 ID、PID 死掉之后结束。
- `-q`, `--quiet`, `--silent` ：从不输出给出文件名的首部。
- `-s`, `--sleep-interval=S` ：与 `-f` 合用，表示在每次反复的间隔休眠S秒。



## 示例

显示 getiot.log 文件的最后 10 行：

```shell
tail getiot.log
```

跟踪名为 getiot.log 的文件的增长情况：

```shell
tail -f getiot.log
```

此命令显示 getiot.log 文件的最后 10 行。当将某些行添加至 getiot.log 文件时，tail 命令会继续显示这些行。 显示一直继续，直到您按下（Ctrl-C）组合键停止显示。

显示文件 getiot.log 的内容，从第 20 行至文件末尾：

```shell
tail -n +20 notes.log
```

显示文件 getiot.log 的最后 5 个字符：

```shell
tail -c 5 notes.log
```

