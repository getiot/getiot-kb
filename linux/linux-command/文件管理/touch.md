---
sidebar_label: touch 命令
sidebar_position: 14
slug: /touch
---

# Linux touch 命令 - 创建或更新文件



## 介绍

**touch** 命令有两个功能：一是创建新的空文件，二是改变已有文件的时间戳属性。

touch 命令会根据当前的系统时间更新指定文件的访问时间和修改时间。如果文件不存在，将会创建新的空文件。

**语法**：

```bash
touch [OPTION]... FILE...
```

**选项**：

- `-a` ：改变文件的读取时间记录。
- `-m` ：改变文件的修改时间记录。
- `-c` ：假如目标文件不存在，不会建立新的文件。与 `--no-create` 的效果一样。
- `-f` ：不使用，是为了与其他 unix 系统的相容性而保留。
- `-r` ：使用参考文件的时间记录，与 `--file` 的效果一样。
- `-d` ：设定时间与日期，可以使用各种不同的格式。
- `-t` ：设定文件的时间记录，格式与 date 指令相同。
- `--no-create` ：不会建立新档案。
- `--help` ：显示帮助信息。
- `--version` ：显示版本信息。



## 示例

创建空文件

```bash
touch file.txt
```

批量创建文件

```bash
touch file{1..5}.txt 
```

修改文件的 access（访问）时间

```bash
touch -a file.txt
```

提示：文件的 access（访问）时间可通过 [stat](/linux-command/stat/) 命令查看。

