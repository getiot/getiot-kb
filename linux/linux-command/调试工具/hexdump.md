---
sidebar_label: hexdump 命令
sidebar_position: 1
slug: /hexdump
---

# Linux hexdump 命令 - 查看二进制文件



## 介绍

**hexdump** 命令通常用于查看二进制文件，可以将二进制文件转换为 ASCII、八进制、十进制、十六进制格式进行查看。

注：hexdump 有一个缩写命令 hd，下面所有命令中都可以用 hd 替换 hexdump。

**语法**：

```bash
hexdump [OPTIONS...] [FILES...]
```

**选项**

- `-b` ：每个字节显示为八进制。一行共16个字节，一行开始以十六进制显示偏移值。
- `-c` ：每个字节显示为 ASCII 字符。
- `-C` ：每个字节显示为十六进制和相应的 ASCII 字符。标准十六进制 + ascii 码显示，十六进制显示偏移量，每行16个字符，每字符两位显示，不足补0，结尾显示当前16位数据的 ascii 码值，以 `|` 框住。
- `-d` ：双字节十进制显示，十六进制显示偏移量，每行8组（16字节）每组5位，不足补零，列间以空格分隔，以无符号十进制数值显示。
- `-e <format_string>` ：指定格式字符串，格式字符串包含在一对单引号中。
- `-f <format_file>` ：根据 format_file 中的格式进行输出，忽略 format_file 中空行及以 `#` 开始的行会。
- `-n <length>` ：只显示前面 length 个字节的数据。
- `-o` ：双字节八进制显示。十六进制显示偏移量，每行8组数据，每数据占两字节，6列，不足补零，以空格分隔。
- `-s <offset>` ：跳过从开始的 offset 个字节，默认输入十进制，以 0x 或 0X 开始按16进制处理，否则如以 0 开始按八进制处理，如果以 b/k/m 结尾，则原数值乘以 512/1024/1048576。
- `-v` ：显示所有数据，如果不包含这一选项，对于同上一行完全相同的数据，hexdump 会以 * 代替显示。
- `-x` ：两位十六进制显示，十六进制显示偏移量，每行8组数据，每数据占两字节，4列，不足补零，以空格分隔。

**格式**：

-e 选项指定格式字符串，格式字符串包含在一对单引号中，格式字符串形如：

```bash
'a/b "format1" "format2"'
```

每个格式字符串由三部分组成，每个由空格分隔，第一个形如 a/b，b 表示对每 b 个输入字节应用 format1 格式，a 表示对每 a 个输入字节应用 format2 格式，一般 a>b，且 b 只能为 1、2、4，另外 a 可以省略，省略则 a=1。format1 和 format2 中可以使用类似 printf 的格式字符串，如：

- `%02d` ：两位十进制
- `%03x` ：三位十六进制
- `%02o` ：两位八进制
- `%c` ：单个字符等

还有一些特殊的用法：

- `%_ad` ：标记下一个输出字节的序号，用十进制表示
- `%_ax` ：标记下一个输出字节的序号，用十六进制表示
- `%_ao` ：标记下一个输出字节的序号，用八进制表示
- `%_p` ：对不能以常规字符显示的用 `.` 代替

同一行如果要显示多个格式字符串，则可以跟多个 -e 选项。



## 示例

假设有文件 test.txt，内容如下：

```bash
$ cat test.txt 
ABCDEFG
HIJKLMN
1234567
```

以八进制显示文件里面的字符：

```bash
$ hexdump -b test.txt 
0000000 101 102 103 104 105 106 107 012 110 111 112 113 114 115 116 012
0000010 061 062 063 064 065 066 067 012                                
0000018
```

第一列是十六进制表示的偏移值，最后一个 0x18 即表示 test.txt 文件共 24 个字节。每一行显示16个字节，每行后面有一个换行符 `\n`（八进制为 012）。

再以 ASCII 码显示，这样更清晰：

```bash
$ hexdump -c test.txt 
0000000   A   B   C   D   E   F   G  \n   H   I   J   K   L   M   N  \n
0000010   1   2   3   4   5   6   7  \n                                
0000018
```

显示十六进制和相应的 ASCII 字符：

```bash
$ hexdump -C test.txt 
00000000  41 42 43 44 45 46 47 0a  48 49 4a 4b 4c 4d 4e 0a  |ABCDEFG.HIJKLMN.|
00000010  31 32 33 34 35 36 37 0a                           |1234567.|
00000018
```

只查看前3个字节内容：

```bash
$ hexdump -C -n 3 test.txt 
00000000  41 42 43                                          |ABC|
00000003
```

查看偏移16个字节后的3个字节内容：

```bash
$ hexdump -C -n 3 -s 16 test.txt 
00000010  31 32 33                                          |123|
00000013
```

在嵌入式开发中，hexdump 命令也很有用，比如查看 eeprom 中的数据：

```bash
hexdump -C /sys/bus/i2c/devices/3-0054/eeprom
```

或者查看设备树节点的信息：

```bash
hexdump -C /proc/device-tree/soc@0/compatible
```

