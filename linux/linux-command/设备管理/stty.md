---
sidebar_label: stty 命令
sidebar_position: 11
slug: /stty
---

# stty 命令 - 配置终端行属性



## 介绍

**stty**（英文全拼：set tty）命令用于显示和修改终端命令行（terminal line）的相关设置。

**语法**：

```bash
stty [选项] [参数]
```

**选项**：

- `-a` ：以容易阅读的方式打印当前的所有配置。
- `-g` ：以 stty 可读方式打印当前的所有配置。
- `-F`, `--file=<DEVICE>` ：打开并使用指定的文件，而不是使用标准输入。
- `--help` ：显示帮助信息并退出。
- `--version` ：输出版本信息并退出。



## 示例

查看当前注册终端的设置情况

```bash
stty -a
```

在命令行下禁止输出大写

```bash
stty iuclc     # 开启
stty -iuclc    # 恢复
```

在命令行下禁止输出小写

```bash
stty olcuc     # 开启
stty -olcuc    # 恢复
```

屏蔽显示

```bash
stty -echo   # 禁止回显
stty echo    # 打开回显
```

忽略回车符

```bash
stty igncr     # 开启
stty -igncr    # 恢复
```

打印出终端的行数和列数

```bash
stty size
```

修改文件结束符

```bash
stty eof 'c'
```

系统默认是 Ctrl+D 来表示文件的结束，通过上述命令，将改变为使用字符 c

另外，stty 命令也常用于串口调试，比如查看串口设备参数

```bash
stty -F "/dev/ttymxc1" -a
```

设置串口设备波特率为 115200

````bash
stty -F "/dev/ttymxc1" 115200
````

在使用串口时，我们通常会关心如下一些参数：

- speed：波特率
- cs8：8位数据位
- parenb：偶校验
- parodd：奇校验
- cstopb：2位停止位
- crtscts：硬件流控

如果上述参数前面有 `-` 号，则表示未设置状态，比如设置硬件流控

```bash
stty -F "/dev/ttymxc1" -crtscts  # 去掉流控
stty -F "/dev/ttymxc1" crtscts   # 增加流控
```

禁止 XOFF 信号（相当于 Ctrl + S，对应 ASCII 码 0x13）

```bash
stty -ixon
```

