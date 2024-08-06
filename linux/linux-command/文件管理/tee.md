---
sidebar_position: 20
slug: /tee
---

# tee 命令



## 介绍

**tee** 命令会从标准输入设备读取数据，将其内容输出到标准输出设备，同时保存成文件 。

**语法**：

```shell
tee [OPTION]... [FILE]...
```

**选项**：

- `-a`, `--append` ：附加到既有文件的后面，而非覆盖它．
- `-i`, `--ignore-interrupts` ：忽略中断信号。
- `--help` ：显示帮助。
- `--version` ：显示版本信息。



## 示例

将用户输入的数据同时保存到文件 file1 和 file2 中：

```sh
tee file1 file2 
```

将 ping 的信息输出到终端，同时也写入到文件中：

```shell
ping google.com | tee output.txt
```

