---
sidebar_position: 21
slug: /sync
---

# sync 命令



## 介绍

**sync**（英文全拼：synchronize）命令用于数据同步，强制将内存缓冲区中的数据立即写入磁盘。

在 Linux/Unix 系统中，在文件或数据处理过程中一般先放到内存缓冲区（filesystem buffer）中，等到适当的时候再写入磁盘，以提高系统的运行效率。

用户通常不需执行 sync 命令，系统会自动周期性执行 update 或 bdflush 操作，将缓冲区的数据写入磁盘。只有在 update 或 bdflush 无法执行或用户需要非正常关机时，才需手动执行 sync 命令。在关闭 Linux 系统时也会自动执行 sync 命令。

**语法**：

```bash
sync [OPTION] [FILE]...
```

**选项**：

- `-d, --data`：仅同步文件数据，不同步不需要的元数据（metadata）。
- `-f, --file-system`：同步包含文件的文件系统。
- `--help`：显示帮助信息。
- `--version`：显示版本信息。



## 示例

手动的输入 sync 命令来真正地去写磁盘

```bash
sync
```

