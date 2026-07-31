---
sidebar_label: xxd 命令
sidebar_position: 2
slug: /xxd
description: "xxd 命令用于以十六进制格式查看文件内容，也可将十六进制转储还原为二进制文件。输出格式经典直观（偏移量 + 十六进制 + ASCII），是嵌入式开发和二进制调试中常用的工具。功能与 hexdump 类似，但语法更简洁。"
---

# Linux xxd 命令 - 十六进制查看与编辑



## 介绍

**xxd** 命令用于以十六进制格式查看文件内容，也可将十六进制转储还原为二进制文件。输出格式经典直观（偏移量 + 十六进制 + ASCII），是嵌入式开发和二进制调试中常用的工具。功能与 [hexdump](/linux-command/hexdump/) 类似，但语法更简洁。

xxd 命令通常随 vim 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install xxd
# 或
sudo apt install vim-common
```

**语法**：

```bash
xxd [options] [infile [outfile]]
xxd -r [-s [-]offset] [-c cols] [-ps] [infile [outfile]]
```

**选项**：

- `-a`：自动跳过空行，以 `*` 代替（默认关闭）
- `-b`：以二进制位显示（不能与 `-ps`、`-i`、`-r` 同时使用）
- `-c cols`：每行显示的列数（默认 16）
- `-C`：C 头文件风格输出时，变量名大写
- `-e`：小端序显示（默认大端）
- `-g bytes`：每组字节数（默认 2）
- `-i`：以 C 语言头文件数组格式输出
- `-l len`：只处理前 `len` 个字节
- `-o off`：显示偏移量时加上 `off`
- `-p, -ps`：纯十六进制连续输出（无偏移和 ASCII）
- `-r`：反向操作，将十六进制转储还原为二进制
- `-s [+][-]seek`：从指定偏移开始读取
- `-d`：偏移量以十进制显示
- `-u`：使用大写十六进制字母
- `-h`：显示帮助
- `-v`：显示版本

相关命令：[hexdump](/linux-command/hexdump/)



## 示例

1、以经典格式查看文件内容：

```bash
xxd firmware.bin
```

2、只查看前 64 字节：

```bash
xxd -l 64 firmware.bin
```

3、从偏移 0x100 处开始查看：

```bash
xxd -s 0x100 firmware.bin
```

4、以 C 头文件数组格式输出（用于嵌入固件）：

```bash
xxd -i firmware.bin > firmware.h
```

5、纯十六进制输出（适合管道处理）：

```bash
xxd -p firmware.bin
```

6、将十六进制转储还原为二进制文件：

```bash
xxd -r dump.txt restored.bin
```

7、查看二进制文件并显示大写十六进制：

```bash
xxd -u -g 1 firmware.bin | head
```

8、比较两个文件的十六进制差异：

```bash
xxd file1.bin > /tmp/a
xxd file2.bin > /tmp/b
diff /tmp/a /tmp/b
```
