---
sidebar_position: 2
slug: /pmap
---

# pmap 命令



## 介绍

**pmap**（英文全拼：process memory map）命令用于查看进程的内存映射。

pmap 实际上是一个 Sun OS 上的命令，Linux 仅支持其有限的功能。可以显示一个或多个进程的内存状态，其报告进程的地址空间和内存状态信息。对查看完整的进程地址空间很有帮助。

**语法**：

```shell
pmap [options] pid [...]
```

**选项**：

- `-x`, `--extended` ：显示扩展格式。
- `-d`, `--device` ：显示设备格式。
- `-q`, `--quiet` ：不显示 header 和 footer 行。
- `-A`, `--range low,high` ：将给定范围内的结果限制为低地址和高地址范围。请注意，low 和 high 参数是用逗号分隔的单个字符串。
- `-X` ：显示比 -x 选项更多的详细信息。注意：格式根据 /proc/PID/smaps 更改。
- `-XX` ：显示内核提供的一切。
- `-p`, `--show-path` ：在映射列中显示文件的完整路径。
- `-c`, `--read-rc` ：读取默认配置。
- `-C`, `--read-rc-from file` ：从文件 file 中读取配置。
- `-n`, `--create-rc` ：创建新的默认配置。
- `-N`, `--create-rc-to file` ：创建新的配置，并保存到文件。
- `-h`, `--help` ：显示帮助信息并退出。
- `-V`, `--version` ：显示版本信息并退出。

**参数**：进程 PID（可接多个参数）



## 示例

查看单一进程内存状态

```shell
$ pmap 5969
5969:   /usr/share/typora/Typora README.md
0000315900000000     48K rw---   [ anon ]
000031590000c000    208K -----   [ anon ]
0000315900040000      4K rw---   [ anon ]
0000315900041000      4K -----   [ anon ]
0000315900042000     64K r-x--   [ anon ]
...
00007fc4383b8000     28K rw--- libepoxy.so.0.0.0
00007fc4383bf000     16K r---- libcairo-gobject.so.2.11600.0
00007fc4383c3000      8K r-x-- libcairo-gobject.so.2.11600.0
00007fc4383c5000      8K r---- libcairo-gobject.so.2.11600.0
00007fc4383c7000      4K ----- libcairo-gobject.so.2.11600.0
00007fc4383c8000      8K r---- libcairo-gobject.so.2.11600.0
00007fc4383ca000      4K rw--- libcairo-gobject.so.2.11600.0
00007fc4383cb000     64K r---- libsystemd.so.0.28.0
00007fc4383db000    468K r-x-- libsystemd.so.0.28.0
00007fc438450000    148K r---- libsystemd.so.0.28.0
00007fc438475000     12K r---- libsystemd.so.0.28.0
00007fc438478000      4K rw--- libsystemd.so.0.28.0
...
00007fff3fc90000    132K rw---   [ stack ]
00007fff3fcc8000     16K r----   [ anon ]
00007fff3fccc000      8K r-x--   [ anon ]
ffffffffff600000      4K --x--   [ anon ]
 total          4931388K
```

查看多进程内存状态

```shell
$ pmap 5969 5972 5973
```

以扩展形式显示进程内存

```shell
$ pmap -x 5969
5969:   /usr/share/typora/Typora README.md
Address           Kbytes     RSS   Dirty Mode  Mapping
0000315900000000      48      48      48 rw---   [ anon ]
000031590000c000     208       0       0 -----   [ anon ]
0000315900040000       4       4       4 rw---   [ anon ]
0000315900041000       4       0       0 -----   [ anon ]
0000315900042000      64      64      64 r-x--   [ anon ]
...
00007fc4383b8000      28      28      28 rw--- libepoxy.so.0.0.0
00007fc4383bf000      16      16       0 r---- libcairo-gobject.so.2.11600.0
00007fc4383c3000       8       8       0 r-x-- libcairo-gobject.so.2.11600.0
00007fc4383c5000       8       8       0 r---- libcairo-gobject.so.2.11600.0
00007fc4383c7000       4       0       0 ----- libcairo-gobject.so.2.11600.0
00007fc4383c8000       8       8       8 r---- libcairo-gobject.so.2.11600.0
00007fc4383ca000       4       4       4 rw--- libcairo-gobject.so.2.11600.0
00007fc4383cb000      64      64       0 r---- libsystemd.so.0.28.0
00007fc4383db000     468      60       0 r-x-- libsystemd.so.0.28.0
00007fc438450000     148       0       0 r---- libsystemd.so.0.28.0
00007fc438475000      12      12      12 r---- libsystemd.so.0.28.0
00007fc438478000       4       4       4 rw--- libsystemd.so.0.28.0
...
00007fff3fc90000     132      88      88 rw---   [ stack ]
00007fff3fcc8000      16       0       0 r----   [ anon ]
00007fff3fccc000       8       4       0 r-x--   [ anon ]
ffffffffff600000       4       0       0 --x--   [ anon ]
---------------- ------- ------- ------- 
total kB         4931388  163028   44052
```

各字段说明如下：

- Address：内存开始地址；
- Kbytes：占用内存的字节数（KB）；
- RSS：保留内存的字节数（KB）；
- Dirty：脏页的字节数（包括共享和私有的）（KB）；
- Mode：内存的权限包括 read、write、execute、shared、private（写时复制）；
- Mapping：占用内存的文件，或 [anon]（分配的内存）、[stack]（堆栈）。

