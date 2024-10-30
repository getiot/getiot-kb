---
sidebar_label: pv 命令
sidebar_position: 8
slug: /pv
---

# pv 命令 - 显示数据传输进度



## 介绍

**pv**（英文全拼：pipe viewer）命令用于通过管道监控数据处理的进度信息。这些信息包括已经耗费的时间、完成的百分比（通过进度条显示）、当前的速度、全部传输的数据，以及估计剩余的时间。

**语法**：

```shell
pv [OPTION] [FILE]...
```

**选项**：

- `-p`, `--progress` ：显示进度条。
- `-t`, `--timer` ：显示任务已经进行的时长。
- `-e`, `--eta` ：显示剩余多长时间完成。
- `-I`, `--fineta` ：以绝对时间显示预计完成时间。
- `-r`, `--rate` ：显示当前传输速率。
- `-a`, `--average-rate` ：显示平均传输速率。
- `-b`, `--bytes` ：显示传输的字节数。
- `-T`, `--buffer-percent` ：显示正在使用的传输缓冲区的百分比。
- `-A`, `--last-written NUM` ：显示最后写入的 NUM 个字节。
- `-F`, `--format FORMAT` ：设置输出格式为 FORMAT。
- `-n`, `--numeric` ：显示进度百分比数字，而不是可视化信息。
- `-q`, `--quiet` ：安静模式，不要输出任何传输信息。
- `-W`, `--wait` ：在传输第一个字节之前不显示任何内容。
- `-D`, `--delay-start SEC` ：在经过 SEC 秒数之前不显示任何内容。
- `-s`, `--size SIZE` ：将估计数据大小设置为 SIZE 字节。
- `-l`, `--line-mode` ：计数行而不是字节。
- `-0`, `--null` ：行是 null-terminated 的。
- `-i`, `--interval SEC` ：每 SEC 秒更新一次。
- `-w`, `--width WIDTH` ：假设终端是 WIDTH 个字符宽。
- `-H`, `--height HEIGHT` ：假设终端是 HEIGHT 行高。
- `-N`, `--name NAME` ：使用 NAME 作为可视信息的前缀。
- `-f`, `--force` ：强制输出，即使标准错误不是终端也输出。
- `-c`, `--cursor` ：使用光标定位转义序列。
- `-L`, `--rate-limit RATE` ：将传输限制为每秒 RATE 字节。
- `-B`, `--buffer-size BYTES` ：使用 BYTES 的缓冲区大小。
- `-C`, `--no-splice` ：从不使用 splice()，始终使用读/写。
- `-E`, `--skip-errors` ：跳过输入中的读取错误。
- `-S`, `--stop-at-size` ：在传输 --size 字节后停止。
- `-R`, `--remote PID` ：更新进程 PID 的设置。
- `-P`, `--pidfile FILE` ：在 FILE 中保存进程 ID。
- `-d`, `--watchfd PID[:FD]` ：监视进程 PID 打开的文件 FD。
- `-h`, `--help` ：显示帮助信息并退出。
- `-V`, `--version` ：显示版本信息并退出。



## 示例

复制文件时显示进度条（如果没有指定选项，默认使用 -p, -t, -e, -r 和 -b 选项）

```shell
$ pv getiot.db > getiot.db.bak
```

将 /var/log/syslog 文件打包成 zip 压缩包，并显示进度

```shell
$ pv /var/log/syslog | zip > syslog.zip
```

使用 tar 命令解压缩时显示进度条

```shell
$ pv rootfs.tar.bz2 | tar -jxf - -C rootfs/
12.3MiB 0:00:02 [6.15MiB/s] [=========>                                     ] 21% ETA 0:00:07
```

解压完成

```shell
$ pv rootfs.tar.bz2 | tar -jxf - -C rootfs/
57.8MiB 0:00:10 [5.53MiB/s] [==============================================>] 100%
```





