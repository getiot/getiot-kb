---
sidebar_position: 41
slug: /lscpu
---

# lscpu 命令



## 介绍

**lscpu**（英文全拼：list cpu）命令用来显示 CPU 的相关信息。

该命令从 sysfs 和 /proc/cpuinfo 收集 cpu 体系结构信息，再以易读的格式输出，输出的信息包含 cpu 数量、核心数、线程数、套接字 和 NUMA（Non-Uniform Memory Access）、缓存等。但并不一定所有的字段都有数据显示，这和所支持的 CPU 架构有关系，如果指定了不支持的字段，那么 lscpu 将打印字段名，但不显示数据。

**语法**：

```bash
lscpu [选项]
```

**选项**：

- `-a`, `--all` ：同时打印在线和离线 CPU（-e 选项默认值）。
- `-b`, `--online` ：只打印在线 CPU（-p 选项默认值）。
- `-B`, `--bytes` ：以字节为单位打印。
- `-C`, `--caches[=<list>]` ：以易读的格式打印 cache 信息。
- `-c`, `--offline` ：只打印离线 CPU。
- `-J`, `--json` ：使用 JSON 格式作为默认或扩展格式。
- `-e`, `--extended[=<列表>]` ：打印扩展的可读格式。
- `-p`, `--parse[=<列表>]` ：打印可解析格式。
- `-s`, `--sysroot <目录>` ：以指定目录作为系统根目录。
- `-x`, `--hex` ：打印十六进制掩码而非 CPU 列表。
- `-y`, `--physical` ：打印物理 ID 而非逻辑 ID。
- `-h`, `--help` ：显示帮助信息。
- `-V`, `--version` ：显示版本信息。




## 示例

在 i.MX8MQ 上执行 lscpu，查看 CPU 信息

```bash
root@imx8mqevk:~# lscpu
Architecture:                    aarch64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
CPU(s):                          4
On-line CPU(s) list:             0-3
Thread(s) per core:              1
Core(s) per socket:              4
Socket(s):                       1
NUMA node(s):                    1
Vendor ID:                       ARM
Model:                           4
Model name:                      Cortex-A53
Stepping:                        r0p4
CPU max MHz:                     1300.0000
CPU min MHz:                     800.0000
BogoMIPS:                        16.66
NUMA node0 CPU(s):               0-3
Vulnerability Itlb multihit:     Not affected
Vulnerability L1tf:              Not affected
Vulnerability Mds:               Not affected
Vulnerability Meltdown:          Not affected
Vulnerability Spec store bypass: Not affected
Vulnerability Spectre v1:        Mitigation; __user pointer sanitization
Vulnerability Spectre v2:        Not affected
Vulnerability Srbds:             Not affected
Vulnerability Tsx async abort:   Not affected
Flags:                           fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
```

各字段说明如下：

```bash
Architecture:        # 架构
CPU op-mode(s):      # CPU运行模式
Byte Order:          # 字节序
CPU(s):              # 逻辑CPU颗数
On-line CPU(s) list: # 在线CPU列表
Thread(s) per core:  # 每个核的线程数
Core(s) per socket:  # 每个CPU插槽核数/每颗物理CPU核数
CPU socket(s):       # CPU插槽数
NUMA node(s):        # NUMA节点
Vendor ID:           # CPU厂商ID
CPU family:          # CPU系列
Model:               # 型号
Model name:          # 型号名称
Stepping:            # 步进
CPU MHz:             # CPU主频
CPU max MHz:         # CPU最大主频
CPU min MHz:         # CPU最小主频
Virtualization:      # CPU支持的虚拟化技术
L1d cache:           # 一级缓存（CPU的L1数据缓存）
L1i cache:           # 一级缓存（CPU的L1指令缓存）
L2 cache:            # 二级缓存
...
```

另外，除了 lscpu，通常还会从 /sys 和 /proc 获取 CPU 相关信息

```bash
cat /proc/cpuinfo
```

查看 cpu0 当前工作频率

```bash
cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
```

