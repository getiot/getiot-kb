---
sidebar_label: mv 命令
sidebar_position: 17
slug: /mv
---

# mv 命令 - 移动或重命名文件



## 介绍

**mv**（英文全拼：move）命令用于移动文件或对其重命名。

**语法**：

```bash
mv [options] source dest
mv [options] source... directory
```

**选项**：

- `-b` ：当目标文件或目录存在时，在执行覆盖前，会为其创建一个备份。
- `-i` ：如果指定移动的源目录或文件与目标的目录或文件同名，则会先询问是否覆盖旧文件，输入 "y" 表示直接覆盖，输入 "n" 表示取消该操作。
- `-f` ：如果指定移动的源目录或文件与目标的目录或文件同名，不会询问，直接覆盖旧文件。
- `-n` ：不要覆盖任何已存在的文件或目录。
- `-u` ：当源文件比目标文件新或者目标文件不存在时，才执行移动操作。



## 示例

将文件 testfile1 重命名为 testfile2：

```bash
mv testfile1 testfile2
```

将文件 file 移动到目录 dir 中：

```bash
mv file dir/
```

将目录 dir1 移动目录 dir2 中（前提是目录 dir2 已存在，若不存在为重命名）：

```bash
mv dir1/ dir2/
```

