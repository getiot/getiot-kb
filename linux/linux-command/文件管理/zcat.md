---
sidebar_label: zcat 命令
sidebar_position: 2
slug: /zcat
---

# zcat 命令



## 介绍

**zcat** 命令用于查看压缩文件的内容，而无需对其进行解压缩。

它将压缩文件扩展为标准输出，使你可以查看其内容。zcat 的运行效果与 `gunzip -c` 命令完全相同。

**语法**：

```bash
zcat [OPTION]... [FILE]...
```

**选项**：

- `-c`, `--stdout` ：将文件内容写到标准输出，保持原始文件不变。
- `-d`, `--decompress` ：执行解压缩操作。
- `-f`, `--force` ：强制覆盖输出文件并压缩链接。
- `-h`, `--help` ：显示帮助信息。
- `-k`, `--keep` ：保留（不删除）输入文件。
- `-l`, `--list` ：列出压缩文件内容。
- `-L`, `--license` ：显示软件许可信息。
- `-n`, `--no-name` 不保存或恢复原始名称和时间戳。
- `-N`, `--name` ：保存或恢复原始名称和时间戳。
- `-q`, `--quiet` ：禁用警告信息。
- `-r`, `--recursive` ：在目录上执行递归操作。
- `--rsyncable` ：制作 rsync-friendly 存档文件。
- `-S`, `--suffix=SUF` ：指定 gzip 格式的压缩包的后缀，当后缀不是标准压缩包后缀时使用此选项。
- `--synchronous` ：同步输出（如果系统崩溃，这会更安全，但速度更慢）。
- `-t`, `--test` ：测试压缩文件的完整性。
- `-v`, `--verbose` ：详细模式。
- `-V`, `--version` ：显示版本信息。
- `-1`, `--fast` ：更快的压缩速度。
- `-9`, `--best` ：更高的压缩比。

**参数**：指定压缩文件名。

提示：zcat 是 gzip 软件包中的一个实用程序，上述许多选项参数对于 zcat 查看压缩文件内容来说是无实际效果的。另外，zutils 软件包也提供了 zcat 命令，两者在使用上有一些区别，因此要留意你正在使用的是哪个 zcat 命令。



## 示例

当 Linux 内核配置 `CONFIG_IKCONFIG` 和 `CONFIG_IKCONFIG_PROC` 为 `y` 时，在 /proc 会中出现 config.gz 文件。它是内核提供给用户的当前 Linux 内核配置文件副本，并且是经过 gzip 格式压缩的。

例如，在 /proc/config.gz 文件中查找 IKCONFIG 配置信息

```bash
root@npi:~# zcat /proc/config.gz | grep IKCONFIG
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
```

列出 /proc/config.gz 文件信息

```bash
root@npi:~# zcat -l /proc/config.gz
         compressed        uncompressed  ratio uncompressed_name
              34042              149025  77.2% /proc/config
```





