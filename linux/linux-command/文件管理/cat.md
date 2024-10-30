---
sidebar_label: cat 命令
sidebar_position: 1
slug: /cat
---

# cat 命令 - 显示文件内容



## 介绍

**cat**（英文全拼：concatenate）命令用于连接文件并打印到标准输出设备上。常用于在 Shell 终端中显示文件内容。

注意：当文件较大时，文本在屏幕上迅速闪过（滚屏），用户往往看不清所显示的内容。因此，一般用 [more](/linux-command/more) 等命令分屏显示。为了控制滚屏，可以按 Ctrl+S 键，停止滚屏；按 Ctrl+Q 键可以恢复滚屏。按 Ctrl+C（中断）键可以终止该命令的执行，并且返回 Shell 提示符状态。

**语法**：

```bash
cat [-AbeEnstTuv] [--help] [--version] fileName
```

**选项**：

- `-n`, `--number` ：由 1 开始对所有输出的行数编号。
- `-b`, `--number-nonblank` ：和 `-n` 相似，只不过对于空白行不编号。
- `-s`, `--squeeze-blank` ：当遇到有连续两行以上的空白行，就代换为一行的空白行。
- `-v`, `--show-nonprinting` ：使用 `^` 和 `M-` 符号，除了 LFD 和 TAB 之外。
- `-E`, `--show-ends` ：在每行结束处显示 `$`。
- `-T`, `--show-tabs` ：将 TAB 字符显示为 `^I`。
- `-A`, `--show-all` ：等价于 `-vET` 选项。
- `-e` ：等价于 `-vE` 选项。
- `-t` ：等价于 `-vT` 选项。



## 示例

把 textfile1 文件的内容加上行号后输入 textfile2 文件

```bash
cat -n textfile1 > textfile2
```

把 textfile1 和 textfile2 文件的内容加上行号（空白行不加）之后将内容附加到 textfile3 文件

```bash
cat -b textfile1 textfile2 >> textfile3
```

清空 test.txt 文档内容

```bash
cat /dev/null > test.txt
```

cat 也可以用来制作镜像文件

```bash
cat /dev/sdb1 > image-file
```

也可以将镜像文件写到磁盘

```bash
cat image-file > /dev/sdb1
```

将多个拆解的 zip 包（如 linux.zip.001、linux.zip.002 和 linux.zip.003）合并成一个 zip 包

```bash
cat linux.zip* > linux.zip
```

