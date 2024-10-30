---
sidebar_label: cyclitest 命令
sidebar_position: 4
slug: /cyclitest
---

# Linux cyclitest 命令 - 测试 CPU 负载和响应时间



## 介绍

**cyclitest** 是一个用于测试 Linux 内核实时性的命令行程序，是 rt-tests 下的一个测试工具，也是 rt-tests 下使用最广泛的测试工具，一般用来测试 Linux 内核的延迟。

cyclitest 命令由 rt-tests 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install rt-tests
```

代码仓库：[https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests](https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests)

**语法**：

```bash
cyclictest <options>
```

**选项**：

- `-a`, `--affinity[=PROC-SET]`：指示 CPU 亲和性，即在处理器 N 上运行线程，例如 `-a 0,1,2`、`-a 0-2`、`-a 0-2,4` 都可以，`!` 表示否定，如 `-a !2-4` 表示绑定在 2-4 以外的所有 CPU 核上。
- `-A`, `--align=USEC`：以微秒为单位将测量线程唤醒与特定偏移量对齐。
- `-b`, `--breaktrace=USEC`：调试选项，用于控制实施抢占补丁中的延迟跟踪器。当延时大于 USEC 指定的值时，发送停止跟踪。USEC 单位为 μs。
- `-c`, `--clock=CLOCK`：选择时钟。0 为线性增长时钟，1 为墙上时间时钟。当设置 `-s` 选项时，该选项失效。
- `-C`, `--context`：上下文切换。调试相关，和 `-b` 选项一起用的。
- `-d`, `--distance=DIST`：当多个线程时，设置间隔（睡眠时间）的增量 distance。interval (线程n) = interval (线程n-1) + DIST。当该选项设置为 0 时，即 DIST=0 时，所有线程都会在同一时间醒来，不过这违背了cyclictest 的初衷，它是想测试每时每刻系统响应速度，而不是一瞬间把系统爆掉。
- `-E`, `--event`：调试相关，和 `-b` 选项联合使用。
- `-f`, `--ftrace`：调试相关，和 `-b` 选项联合使用。
- `-h`, `--histogram=US`：输出直方图到 stdout。指定要跟踪的最大的延迟数值。
- `--histfile=<path>`：输出直方图到文件。
- `-H`：同 `-h` 选项，同时该选项还会输出多一列数据在最右边，表示求和，当只有一个线程时，`-H` 等价于 `-h`。
- `-i`, `--interval=INTV`：设置第一个线程的间隔（睡眠时间），默认 1000us。
- `-l`, `--loops=LOOPS`：默认为 0，表示无止境测下去。
- `-m`, `--mlockall`：锁定当前和未来的内存分配以阻止被 page out（页调出）。
- `-M`, `--refresh_on_max`：延迟更新屏幕直到达到新的最大延迟（对于在低带宽连接上运行循环测试很有用）。
- `-n`, `--nanosleep`：使用 clock_nanosleep 代替 posix interval timer。
- `-N`, `--nsecs`：用纳秒为单位显示结果，而不是默认的微秒。
- `-o`, `--oscope=RED`：示波器模式。
- `-O`, `--traceopt=TRACING_OPTION`：跟踪选项相关。
- `-p`, `--prio=PRIO`：设置第一个线程的优先级。Priority(n) = max (Priority(n-1)-1, 0)
- `-q`, `--quiet`：静默模式，只输出概述信息。适用于自动化测试的时候，在脚本中使用这个选项。
- `-r`, `--relative`：使用相对时间。默认绝对时间。官方手册不建议使用。
- `-s`, `--system`：使用 sys_nanosleep 和 sys_setitimer 取代 posix timer。但是 `-s` 选项只应该在一个线程时使用，因为 itimer 每个进程只有一个，而不是每个线程都有。该选项可以结合 `-n` 选项一起使用，这样就不会受限于只对一个线程使用了。
- `-S`, `--smp`：为 SMP 系统上的标准测试设置选项。等效于使用选项 `-t -a -n` 以及在所有线程中保持任何指定的优先级相等。
- `-t`, `--threads[=NUM]`：该选项用来指定线程数。没有指定该选项时，默认 1 个线程。指定了该选项但又没有指定数字时，会开启 CPU 核心个数个线程。
- `-T`, `--tracer=TRACEFUNC`：跟踪器相关。
- `-v`, `--verbose`：输出统计信息。结合 `-l` 使用。
- `-D`, `--duration=TIME`：运行时间，默认单位 s，可以使用 “m h d” 代表分钟、小时、天。
- `-w`, `--wakeup`：唤醒追踪，配合 `-b` 选项。
- `-W`, `--wakeuprt`：实时线程唤醒追踪，配合 `-b` 选项。
- `-y`, `--policy=NAME`：设置调度策略。可选 other、normal、batch、idle、fifo、rr 策略。



## 示例

运行 5 个线程，线程优先级 80，无限循环

```bash
cyclictest -t 5 -p 80 -n
```

运行 1 个线程（使用 clock_nanosleep），线程优先级 80，间隔 10000 微秒，10000 次循环，无负载

```bash
cyclictest -t1 -p 80 -n -i 10000 -l 10000
```

运行 1 个线程（使用 posix interval timer）线程优先级 80，间隔 10000 微秒，10000 次循环，无负载

```bash
cyclictest -t1 -p 80 -i 10000 -l 10000
```



## 输出格式

下面是 cyclictest 测试示例运行时的打印信息：

```bash
$ sudo cyclictest -t 5 -p 80
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 1.85 1.89 3.04 1/2760 1556268           

T: 0 (1556027) P:80 I:1000 C:  14957 Min:      1 Act:    2 Avg:    2 Max:     258
T: 1 (1556028) P:80 I:1500 C:   9971 Min:      1 Act:    2 Avg:    2 Max:     365
T: 2 (1556029) P:80 I:2000 C:   7478 Min:      1 Act:    7 Avg:    3 Max:     388
T: 3 (1556030) P:80 I:2500 C:   5982 Min:      1 Act:    4 Avg:    2 Max:      39
T: 4 (1556031) P:80 I:3000 C:   4985 Min:      1 Act:    3 Avg:    3 Max:     224
```

输出字段说明如下表所示：

| 字段  | 描述                                           |
| ----- | ---------------------------------------------- |
| `T`   | 线程序号，括号里面是 PID                       |
| `P`   | 线程优先级                                     |
| `C`   | 计数器（线程的时间间隔每达到一次，计数器加 1） |
| `I`   | 时间间隔，单位是微秒（us）                     |
| `Min` | 最小延时，单位是微秒（us）                     |
| `Act` | 最近一次的延时，单位是微秒（us）               |
| `Avg` | 平均延时，单位是微秒（us）                     |
| `Max` | 最大延时，单位是微秒（us）                     |

