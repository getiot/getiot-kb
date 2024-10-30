---
sidebar_label: rsync 命令
sidebar_position: 22
slug: /rsync
---

# rsync 命令 - 远程数据同步工具



## 介绍

**rsync**（英文全拼：remote synchronize）是 Linux 系统中的一个远程数据同步工具，可通过 LAN/WAN 快速同步多台主机间的文件。需要注意的是，rsync 可以在本地主机和远程主机之间，或者在两个本地目录之间同步文件，但不支持两台远程主机之间的同步。

rsync 使用所谓的“rsync算法”来使本地和远程两个主机之间的文件达到同步，这个算法只传送两个文件的不同部分，而不是每次都整份传送，因此速度相当快。

**语法**：

```bash
rsync [OPTION]... SRC [SRC]... DEST
rsync [OPTION]... SRC [SRC]... [USER@]HOST:DEST
rsync [OPTION]... SRC [SRC]... [USER@]HOST::DEST
rsync [OPTION]... SRC [SRC]... rsync://[USER@]HOST[:PORT]/DEST
rsync [OPTION]... [USER@]HOST:SRC [DEST]
rsync [OPTION]... [USER@]HOST::SRC [DEST]
rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]
```

**选项**：

- `-v`, `--verbose`：详细模式输出。
- `-q`, `--quiet`：精简输出模式。
- `-c`, `--checksum`：打开校验开关，强制对文件传输进行校验。
- `-a`, `--archive`：归档模式，表示以递归方式传输文件，并保持所有文件属性。
- `-r`, `--recursive`：对子目录以递归模式处理。
- `-R`, `--relative`：使用相对路径信息。
- `-b`, `--backup`：创建备份，也就是对于目的已经存在有同样的文件名时，将老的文件重新命名为 ~filename。可以使用 `--suffix` 选项来指定不同的备份文件前缀。
- `--backup-dir`：将备份文件（如 ~filename）存放在在目录下。
- `-suffix=SUFFIX`：定义备份文件前缀。
- `-u`, `--update`：仅仅进行更新，也就是跳过所有已经存在于 DST，并且文件时间晚于要备份的文件，不覆盖更新的文件。
- `-l`, `--links`：保留软链结。
- `-L`, `--copy-links`：想对待常规文件一样处理软链结。
- `--copy-unsafe-links`：仅仅拷贝指向 SRC 路径目录树以外的链结。
- `--safe-links`：忽略指向 SRC 路径目录树以外的链结。
- `-H`, `--hard-links`：保留硬链结。
- `-p`, `--perms`：保持文件权限。
- `-o`, `--owner`：保持文件属主信息。
- `-g`, `--group`：保持文件属组信息。
- `-D`, `--devices`：保持设备文件信息。
- `-t`, `--times`：保持文件时间信息。
- `-S`, `--sparse`：对稀疏文件进行特殊处理以节省 DST 的空间。
- `-n`, `--dry-run`：现实哪些文件将被传输。
- `-w`, `--whole-file`：拷贝文件，不进行增量检测。
- `-x`, `--one-file-system`：不要跨越文件系统边界。
- `-B`, `--block-size=SIZE`：检验算法使用的块尺寸，默认是 700 字节。
- `-e`, `--rsh=command`：指定使用rsh、ssh方式进行数据同步。
- `--rsync-path=PATH`：指定远程服务器上的rsync命令所在路径信息。
- `-C`, `--cvs-exclude`：使用和 CVS 一样的方法自动忽略文件，用来排除那些不希望传输的文件。
- `--existing`：仅仅更新那些已经存在于 DST 的文件，而不备份那些新创建的文件。
- `--delete`：删除那些 DST 中 SRC 没有的文件。
- `--delete-excluded`：同样删除接收端那些被该选项指定排除的文件。
- `--delete-after`：传输结束以后再删除。
- `--ignore-errors`：及时出现 IO 错误也进行删除。
- `--max-delete=NUM`：最多删除 NUM 个文件。
- `--partial`：保留那些因故没有完全传输的文件，以是加快随后的再次传输。
- `--force`：强制删除目录，即使不为空。
- `--numeric-ids`：不将数字的用户和组 ID 匹配为用户名和组名。
- `--timeout=time`：IP 超时时间，单位为秒。
- `-I`, `--ignore-times`：不跳过那些有同样的时间和长度的文件。
- `--size-only`：当决定是否要备份文件时，仅仅察看文件大小而不考虑文件时间。
- `--modify-window=NUM`：决定文件是否时间相同时使用的时间戳窗口，默认为 0。
- -T --temp-dir=DIR：在 DIR 中创建临时文件。
- `--compare-dest=DIR`：同样比较 DIR 中的文件来决定是否需要备份。
- `-P`：等同于 `--partial`。
- `--progress`：显示备份过程。
- `-z`, `--compress`：对备份的文件在传输时进行压缩处理。
- `--exclude=PATTERN`：指定排除不需要传输的文件模式。
- `--include=PATTERN`：指定不排除而需要传输的文件模式。
- `--exclude-from=FILE`：排除 FILE 中指定模式的文件。
- `--include-from=FILE`：不排除 FILE 指定模式匹配的文件。
- `--version`：打印版本信息。
- `--address`：绑定到特定的地址。
- `--config=FILE`：指定其他的配置文件，不使用默认的 rsyncd.conf 文件。
- `--port=PORT`：指定其他的 rsync 服务端口。
- `--blocking-io`：对远程 shell 使用阻塞 I/O。
- `--stats`：给出某些文件的传输状态。
- `--progress`：在传输时显示传输过程。
- `--log-format=formAT`：指定日志文件格式。
- `--password-file=FILE`：从 FILE 中得到密码。
- `--bwlimit=KBPS`：限制 I/O 带宽，单位为 KBytes per second。
- `-h`, `--help`：显示帮助信息。



## 示例

关联两个本地的目录，保持文件同步：

```bash
rsync -r /Dir1 /Dir2
```

列出本地指定目录内的文件列表：

```bash
rsync /Dir1
```

将本地目录（/web_root）与远程目录（192.168.1.10:/web_root）相关联，保持文件同步：

```bash
rsync -r /web_root 192.168.1.10:/web_root
```

将远程目录（192.168.1.10:/web_root）与本地目录（/web_root）相关联，保持文件同步：

```bash
rsync -r 192.168.1.10:/web_root /web_root
```



