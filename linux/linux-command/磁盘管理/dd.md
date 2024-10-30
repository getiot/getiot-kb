---
sidebar_label: dd 命令
sidebar_position: 24
slug: /dd
---

# Linux dd 命令 - 数据复制和转换



## 介绍

**dd**（英文全拼：disk dump）命令用于读取、转换并输出数据。可从标准输入或文件中读取数据，根据指定的格式来转换数据，再输出到文件、设备或标准输出。

dd 命令功能很强大的，对于一些比较底层的问题，使用 dd 命令往往可以得到出人意料的效果。用的比较多的还是用 dd 来备份裸设备。

:::tip

裸设备（raw device，也称裸分区或原始分区）是一种没有经过格式化，不被 Linux 系统通过文件系统来读取的特殊块设备文件。裸设备不被操作系统直接管理，不经过文件系统的缓冲，直接由应用程序对它进行读写操作。因此 I/O 效率更高，不少数据库都能通过使用裸设备作为存储介质来提高 I/O 效率。

:::

**语法**：

```bash
dd [选项]
```

**选项**：

- `if=<文件>`：输入文件名，即指定源文件。
- `of=<文件>`：输出文件名，即指定目的文件。
- `bs=<字节数>`：将 ibs（输入）与 obs（输出）设成指定的字节数。（bs 是  block size 的缩写）
- `ibs=<字节数>`：每次读取的字节数，即指定一个块的大小。
- `obs=<字节数>`：每次输出的字节数，即指定一个块的大小。
- `cbs=<字节数>`：转换时，每次只转换指定的字节数（即指定转换缓冲区大小）。
- `count=<区块数>`：仅读取指定的区块数，块大小等于 (i/o)bs 指定的字节数。
- `skip=<区块数>`：一开始从输入文件读取时，跳过指定的区块数。
- `seek=<区块数>`：一开始写入到输出文件时，跳过指定的区块数。
- `conv=<关键字>`：指定文件转换的方式；关键字可以是：
  - conversion：用指定的参数转换文件
  - ascii：转换 ebcdic 为 ascii
  - ebcdic：转换 ascii 为 ebcdic
  - ibm：转换 ascii 为 alternate ebcdic
  - block：把每一行转换为长度为 cbs，不足部分用空格填充
  - unblock：使每一行的长度都为 cbs，不足部分用空格填充
  - lcase：把大写字符转换为小写字符
  - ucase：把小写字符转换为大写字符
  - swap：交换输入的每对字节
  - noerror：出错时不停止
  - notrunc：不截短输出文件
  - sync：将每个输入块填充到 ibs 个字节，不足部分用空（NUL）字符补齐
  - fdatasync：在完成之前实际写入数据到输出文件
  - fsync：类似于 fdatasync，但同时会写入 metadata 元数据
- `--help`：显示帮助信息。
- `--version`：显示版本信息。

另外，块大小可以使用的计量单位如下表所示。

| 单元大小         | 代码 |
| ---------------- | ---- |
| 字节（1B）       | c    |
| 字节（2B）       | w    |
| 块（512B）       | b    |
| 千字节（1024B）  | k    |
| 兆字节（1024KB） | M    |
| 吉字节（1024MB） | G    |



## 示例

将 openwrt.img 写入 TF 卡（/dev/sdx）：

```bash
dd if=/tmp/upload/openwrt.img of=/dev/sdx
```

将 flash.bin 写入 TF 卡，并偏移 33 个区块：

```bash
dd if=flash.bin of=/dev/sdx bs=1k seek=33 conv=fsync
```

创建一个 1M 大小的文件：

```bash
$ dd if=/dev/zero of=output.txt bs=1M count=1
1+0 records in
1+0 records out
1048576 bytes (1.0 MB) copied, 0.006107 seconds, 172 MB/s
```

该命令创建了一个 1M 大小的文件 output.txt。

```bash
$ du -sh output.txt 
1.1M    output.txt
```

说明：**/dev/zero** 是一个字符设备，会不断返回 0 值字节（`\0`）。上述命令可用来测试内存操作速度。

将 testfile 文件中的所有英文字母转换为大写，然后转成为 testfile_1 文件：

```bash
dd if=testfile of=testfile_1 conv=ucase 
```

由标准输入设备读入字符串，并将字符串转换成大写后，再输出到标准输出设备：

```bash
dd conv=ucase 
```

输入以上命令后按回车键，输入字符串，再按回车键，按组合键 Ctrl+D 退出，出现以下结果：

```bash
$ dd conv=ucase
hello, getiot.tech  # 输入字符串后按回车键
HELLO, GETIOT.TECH  # 按组合键Ctrl+D退出，转换成大写结果
记录了0+1 的读入
记录了0+1 的写出
19字节已复制，9.27639 s，0.0 kB/s
```

### 读写测试

在 Linux 系统中，我们经常用 dd 命令使用 /dev/zero 和 /dev/null 设备来测试硬盘读写速度，配合 [time](/linux-command/time) 命令可以计算 dd 命令执行过程的资源使用情况（比如 cpu 时间）。

**测试硬盘写能力**

```bash
time dd if=/dev/zero of=/testw.dbf bs=4k count=100000
```

因为 /dev/zero 是一个伪设备，它只产生空字符流，对它不会产生 IO，所以，IO 都会集中在 of 文件中，of 文件只用于写，所以这个命令相当于测试磁盘的写能力。命令结尾添加 `oflag=direct` 将跳过内存缓存，添加 `oflag=sync` 将跳过 hdd 缓存。

**测试硬盘读能力**

```bash
time dd if=/dev/sdb of=/dev/null bs=4k
```

因为 /dev/sdb 是一个物理分区，对它的读取会产生 IO，/dev/null 是伪设备，相当于黑洞，of 到该设备不会产生 IO，所以，这个命令的 IO 只发生在 /dev/sdb 上，也相当于测试磁盘的读能力。（Ctrl+C 终止测试）

**测试同时读写能力**

```bash
time dd if=/dev/sdb of=/testrw.dbf bs=4k
```

**测试纯写入性能**

```bash
dd if=/dev/zero of=test bs=8k count=10000 oflag=direct
```

**测试纯读取性能**

```bash
dd if=test of=/dev/null bs=8k count=10000 iflag=direct
```

注意：dd 只能提供一个大概的测试结果，而且是连续 I/O 而不是随机 I/O，理论上文件规模越大，测试结果越准确。 同时，iflag/oflag 提供 direct 模式，direct 模式是把写入请求直接封装成 I/O 指令发到磁盘，非 direct 模式只是把数据写入到系统缓存就认为 I/O 成功，并由操作系统决定缓存中的数据什么时候被写入磁盘。

