---
sidebar_label: echo 命令
sidebar_position: 3
slug: /echo
---

# Linux echo 命令 - 输出字符串内容



## 介绍

**echo** 命令用于在 Shell 终端中输出内容（比如 shell 变量的值，或者直接输出指定的字符串）。

Linux 的 echo 命令，在 shell 编程中极为常用，通常起到一个提示的作用。

**语法**：

```bash
echo [OPTION]... [STRING]...
```

**选项**：

- `-n` ：不输出尾随的换行符。
- `-e` ：激活转义字符。



## 示例

显示普通字符串

```bash
echo "Welcome to getiot.tech"
```

这里的双引号完全可以省略，以下命令与上面实例效果一致

```bash
echo Welcome to getiot.tech
```

显示转义字符

```bash
echo "\"Welcome to getiot.tech\""
```

不换行显示

```bash
echo -n "Welcome to getiot.tech"
```

转义输出（显示换行符）

```bash
echo -e "Welcome to getiot.tech\n"
```

将显示结果重定向至文件

```bash
echo "Welcome to getiot.tech" > file.txt
```

把十六进制数据 0xdd 0xff 发送到串口 /dev/ttyUSB0

```bash
echo -e -n "\xdd\xff" > /dev/ttyUSB0
```

显示命令执行结果

```bash
echo `date`
```

注意：这里使用的是反引号 **`**，而不是单引号 **'**。

