---
sidebar_position: 17
slug: /time
---

# time 命令



## 介绍

**time** 命令用于计算特定指令执行时所需消耗的时间及系统资源等数据。例如 cpu 时间、内存、IO 资源等。

我们经常用 time 命令来计算某个程序的运行耗时（real），用户态 cpu 耗时（user），系统态 cpu 耗时（sys）。

**语法**：

```shell
time [options] COMMAND [arguments]
```

**选项**：

- `-o`, `--output=FILE` ：指定结果输出文件。将 time 的输出写入文件中，如果文件已经存在，则覆盖其内容。
- `-a`, `--append` ：配合 `-o` 选项使用，将结果写入到文件的末端，而不会覆盖原有内容。
- `-f`, `--format FORMAT` ：以 FORMAT 格式字符串设定显示方式。如果没有指定，则使用系统预设的格式，亦可通过系统环境变量 `TIME` 来设定该格式。



## 示例

直接执行 time 命令（显示 real、user、sys 时间）：

```shell
$ time

real    0m0.000s
user    0m0.000s
sys     0m0.000s
```

其中，real 表示程序运行耗时，user 表示用户态 cpu 耗时，sys 表示内核态 cpu 耗时。

计算 `sleep 2` 命令的执行时间：

```shell
$ time sleep 2

real    0m2.004s
user    0m0.001s
sys     0m0.001s
```

计算硬盘写测试所用的时间：

```shell
time dd if=/dev/zero of=testw.dbf bs=4k count=102400
102400+0 records in
102400+0 records out
419430400 bytes (419 MB, 400 MiB) copied, 1.98527 s, 211 MB/s

real    0m1.990s
user    0m0.104s
sys     0m1.866s
```

注意：real time 表示时钟走过的时间，user time 表示程序在用户态占用 cpu 的时间，sys time 表示程序在内核态占用 cpu 的时间。real、user 和 sys 三者之间没有严格的关系，user + sys 不等于 real 时间，在多核系统中，user + sys 可能会大于 real 时间。

我们可以这样计算程序运行期间的 CPU 占用率：

```shell
%cpu_usage = (user_time + sys_time)/real_time * 100%
```

