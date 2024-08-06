---
sidebar_position: 7
slug: /numactl
---

# numactl 命令



## 介绍

**numactl**（英文全拼：NUMA Control）命令用于查看当前服务器的 NUMA 节点配置和运行状态，可通过该工具将进程绑定到指定 CPU core，由指定 CPU core 来运行对应进程。

numactl 通常不会预先安装，但可在大多数 Linux 发行版的默认仓库中找到。例如，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
$ sudo apt install numactl
```

安装完成后会有两个命令：`numactl` 和 `numastat`

**语法**：

```bash
numactl  [  --all ] [ --interleave nodes ] [ --preferred node ] [ --membind nodes ] 
         [ --cpunodebind nodes ] [ --physcpubind cpus ] [ --localalloc ] [--] command {arguments ...}
numactl --show
numactl --hardware
numactl [ --huge ] [ --offset offset ] [ --shmmode shmmode ] [ --length length ] [ --strict ]
        [ --shmid id ] --shm shmkeyfile | --file tmpfsfile
        [ --touch ] [ --dump ] [ --dump-nodes ] memory policy
```

**选项**：

- `--interleave=nodes`, `-i nodes`：这个选项用于设定内存的交织分配模式。也就是说系统在为多个节点分配内存空间的时候，将会以轮询分发的方式被分配给这多个节点。如果在当前众多的交织分配内存节点中的目标节点无法正确的分配内存空间的话，内存空间将会由其他的节点来分配。
- `--membind=nodes`, `-m nodes`：选项 `--membind` 仅用来从节点中分配内存空间所用。如果在这些节点中无法分配出所请求的空间大小的话该分配操作将会失败。
- `--cpunodebind=nodes`, `-N nodes`：上述命令仅用于施加在运行与 CPU 上的进程。这个命令用于显示 CPU 的个数，CPU 数目信息同样记录在系统中的存放处理器领域信息的 /proc/cpuinfo 文件夹下，或者是按照关联的 CPU 信息，在当前的 CPU 集中所存放。
- `--localalloc`, `-l`：这个命令选项通常是为当前的节点分配内存的。
- `--preferred=node`：该命令由于指定优先分配内存空间的节点，如果无法将空间分配给该节点的话，应该分配给该节点上的空间将会被分发到其他的节点上，该命令选项后面仅接收一个单独的节点标号。
- `--show`, `-s`：该命令用于显示 NUMA 机制作用在当前运行的那些进程上。
- `--hardware`, `-H`：该命令用于显示当前系统中有多少个可用的节点。
- `--huge`：当创建一个基于大内存页面的系统级的共享内存段的时候,使用 `--huge` 这个选项。`--huge` 选项仅在 `--shmid` 或是 `--shm` 命令的后面使用才有效。
- `--offset`：该参数选项用于指定共享内存段中的位移量的偏移。默认的情况下偏移量是 0 。有效的偏移量单位是 m、g、k，分别表示 MB、GB 和 KB，没有指定则被认为是以字节为单位。
- `--strict`：这个参数选项 当施加了 NUMA 调度机制的共享内存段区域的页面被施加了另一个机制而导致错误的时候，使用 `--strict` 选项将会把错误信息显示出来，默认情况是不使用该选项的。
- `--shmmode <shmmode>`：该选项仅在 `--shmid` 或是 `--shm` 之前使用才会生效。当创建一个共享内存段的时候，通过整型数值来指定共享内存的共享的模式类型。
- `--length <length>`：将策略应用于共享内存段中的长度范围或使段长度变长，默认是使用剩余长度，需要创建共享内存段时指定新段的长度。有效的单位是 m、g、k，分别表示 MB、GB 和 KB，没有指定则被认为是以字节为单位。
- `--shmid <id>`：通过 ID 号码来创建或使用一个共享内存段。(如果共享内存段已经存在，那么通过 shmid 来指定下面要使用某个 ID 的共享内存段 ;  如果该 ID 对应的共享内存段并不存在的话，那么就创建一个)。
- `--shm <shmkeyfile>`：通过存放在 shmkeyfile（共享内存-键文件）中的 ID 号码来创建或者是使用一个共享内存段。访问 shmkeyfile 文件的进程是通过 `fork(3 arguments)` 方法来实现的。
- `--file <tmpfsfile>`：将 NUMA 机制施加于文件上面，这个文件属于 tmpfs 或者是 hugetlbfs 这种特殊的文件系统。
- `--touch`：通过将 NUMA 机制施加于刚刚页面上来实现内存的早期 NUMA 化。默认情况下是不使用该选项，如果存在映射或是访问页面的应用的话，将会使用该早期实行 NUMA 机制的这种方法。
- `--dump`：该选项用于废除将已经 NUMA 化的特定区域上的 NUMA 性质。`--dump` 选项后面，有效指定 node 的书写方式为：
  - `all`：用于将所有的节点上的 NUMA 特性移除；
  - `number`：通过指定 node 后接的数值来废除该数字对应的 node；
  - `number1(number2)`：node number1（node number2）上的 NUMA 特性将会被移除；
  - `number1-number2`：node number1 -- node number2 区间上的所有存在的 node 的 NUMA 特性将会被移除；
  - `!nodes`：除了 nodes 所指定的节点以外的所有节点上的 NUMA 特性全都会被移除。



## 示例

1、查看当前的 NUMA 运行状态

```bash
$ numastat
                           node0
numa_hit              2011064712
numa_miss                      0
numa_foreign                   0
interleave_hit             47040
local_node            2011064712
other_node                     0
```

字段说明：

- `numa_hit` 表示节点内 CPU 核访问本地内存的次数。
- `numa_miss` 表示节点内核访问其他节点内存的次数。跨节点的内存访问会存在高延迟从而降低性能，因此 `numa_miss` 的值应当越低越好，如果过高，则应当考虑绑核。

2、查看当前服务器的 NUMA 配置

```bash
numactl -H
```

3、将应用程序 test 绑定到 0~7 核运行

```bash
numactl -C 0-7 ./test
```





