---
sidebar_label: locate 命令
sidebar_position: 33
slug: /locate
---

# Linux locate 命令 - 快速查找文件



## 介绍

**locate** 命令用于在 Linux 系统中查找符合条件的文档，作用类似于 find 命令。不过，locate 命令会去保存文档和目录名称的数据库内，查找合乎范本样式条件的文档或目录。一般情况，我们只需要输入 `locate <filename>` 即可查找指定文件。

相关命令：[which](/linux-command/which)、[whereis](/linux-command/whereis)、[find](/linux-command/find)

**安装**：

locate 命令由 mlocate 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install mlocate
```

在安装 mlocate 软件包期间，Linux 系统将创建一个 cron 作业，该作业每24小时运行一次 `updatedb` 命令，这样可以确保数据库得到定期更新。有关 cron 作业的更多信息，请检查 `/etc/cron.daily/mlocate` 文件。

如果需要手动更新数据库，可以通过 root 或具有 sudo 特权的用户身份运行 `updatedb` 命令。更新过程将花费一些时间，具体取决于文件和目录的数量以及系统的速度。

与功能强大的 `find` 命令相比，`locate` 命令的运行速度更快，使用方法更简单。但它缺少许多高级功能，只能按文件名进行搜索。

**语法**：

```bash
locate [-d  path | --database=path] [-e | -E | --[non-]existing] [-i |
       --ignore-case] [-0 | --null] [-c | --count] [-w |  --wholename]  [-b  |
       --basename]  [-l  N  |  --limit=N]  [-S | --statistics] [-r | --regex ]
       [--regextype R] [--max-database-age D] [-P | -H  |  --nofollow]  [-L  |
       --follow] [--version] [-A | --all] [-p | --print] [--help] pattern...
```

**选项**：

- `-b`, `--basename`：仅匹配路径名的基本名称。
- `-c`, `--count`：只输出找到的数量。
- `-d`, `--database DBPATH`：使用 DBPATH 指定的数据库，而不是默认数据库 /var/lib/mlocate/mlocate.db。
- `-e`, `--existing`：仅打印当前现有文件的条目。
- `-1`：如果是 1，则启动安全模式。在安全模式下，使用者不会看到权限无法看到的档案。这会使速度减慢，因为 locate 必须到实际的档案系统中取得档案的权限资料。
- `-0`, `--null`：在输出上带有 NUL 的单独条目。
- `-S`, `--statistics`：不搜索条目，打印有关每个数据库的统计信息。
- `-q`：安静模式，不会显示任何错误讯息。
- `-P`, `--nofollow`, `-H`：检查文件存在时不要遵循尾随的符号链接。
- `-l`, `--limit`, `-n LIMIT`：将输出（或计数）限制为 LIMIT 个条目。
- `-n`：至多显示 n 个输出。
- `-m`, `--mmap`：被忽略，为了向后兼容。
- `-r`, `--regexp REGEXP`：使用基本正则表达式。
- `--regex`：使用扩展正则表达式。
- `-q`, `--quiet`：安静模式，不会显示任何错误讯息。
- `-s`, `--stdio`：被忽略，为了向后兼容。
- `-o`：指定资料库存的名称。
- `-h`, `--help`：显示帮助。
- `-i`, `--ignore-case`：忽略大小写。
- `-V`, `--version`：显示版本信息。



## 示例

查找 passwd 文件，输入以下命令：

```bash
locate passwd
```

搜索 etc 目录下所有以 sh 开头的文件 ：

```bash
locate /etc/sh
```

忽略大小写搜索当前用户目录下所有以 r 开头的文件 ：

```bash
locate -i ~/r
```

