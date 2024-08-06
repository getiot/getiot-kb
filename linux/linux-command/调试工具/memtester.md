---
sidebar_position: 2
slug: /memtester
---

# memtester 命令



## 介绍

**memtester**（英文全拼：memory tester）是 Linux 下的一款内存测试工具，可用于内存压力测试及查找内存子系统故障。

memtester 运行在用户空间下，是一款用于**测试内存正确性**的命令行实用工具，适用于大多数平台。可以在 32 位或 64 位的类 Unix 操作系统编译和运行（当然也包括 macOS）。这款工具主要面向硬件开发人员，从 4.1.0 版本开始，memtester 可以指定起始物理内存地址进行测试。

memtester 工具主要是捕获内存错误和一直处于很高或者很低的坏位，其测试的主要项目有随机值、异或比较、减法、乘法、除法、与或运算等等。通过给定测试内存的大小和次数，可以对系统现有的内存进行上面项目的测试。通过指定物理地址，memtester 还可以用于测试内存映射 I/O 设备和类似设备。需要注意的是，内存区域在测试过程中会被覆盖，因此要特别小心，如果指定为系统或其他应用程序分配的内存，将可能导致它们崩溃。

如果你的系统没有 memtester 工具，请先安装，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install memtester
```

项目官网：[http://pyropus.ca/software/memtester](http://pyropus.ca/software/memtester/)

**语法**：

```bash
memtester [-p PHYSADDR [-d DEVICE]] <MEMORY> [ITERATIONS]
```

**选项**：

- `-p PHYSADDR` ：测试从给定的物理地址 PHYSADDR 起始的特定内存区域（以十六进制表示），通过映射 -d 选项指定的设备。
- `-d DEVICE` ：指定设备，默认为 /dev/mem 设备。

**参数**：

- `MEMORY` ：需要分配和测试的内存大小，默认以兆字节为单位，可以通过后缀 B、K、M 或 G 分别表示字节、千字节、兆字节或千兆字节。
- `ITERATIONS` ：循环测试次数（默认为无限次）。



## 示例

提示：因为系统运行和本工具运行都需要内存，所以不能把所有的内存都测试到，可以先用 free 命令查看系统剩余多少内存空间再测试。

测试 300M 内存 10 次

```bash
memtester 300M 10
```

测试结果

```bash
memtester version 4.3.0 (64-bit)
Copyright (C) 2001-2012 Charles Cazabon.
Licensed under the GNU General Public License version 2 (only).

pagesize is 4096
pagesizemask is 0xfffffffffffff000
want 300MB (314572800 bytes)
got  300MB (314572800 bytes), trying mlock ...locked.
Loop 1/10:
  Stuck Address       : ok
  Random Value        : ok
  Compare XOR         : ok
  Compare SUB         : ok
  Compare MUL         : ok
  Compare DIV         : ok
  Compare OR          : ok
  Compare AND         : ok
  Sequential Increment: ok
  Solid Bits          : ok
  Block Sequential    : ok
  Checkerboard        : ok
  Bit Spread          : ok
  Bit Flip            : ok
  Walking Ones        : ok
  Walking Zeroes      : ok

Loop 2/10:
  ......
  
Loop 10/10:
  Stuck Address       : ok         
  Random Value        : ok
  Compare XOR         : ok
  Compare SUB         : ok
  Compare MUL         : ok
  Compare DIV         : ok
  Compare OR          : ok
  Compare AND         : ok
  Sequential Increment: ok
  Solid Bits          : ok         
  Block Sequential    : ok         
  Checkerboard        : ok         
  Bit Spread          : ok         
  Bit Flip            : ok         
  Walking Ones        : ok         
  Walking Zeroes      : ok         
  8-bit Writes        : ok
  16-bit Writes       : ok

Done.
```

结果全部为 ok 则说明内存工作正常。
