---
sidebar_position: 7
slug: /ipcs
---

# ipcs 命令



## 介绍

**ipcs** 命令用于报告 Linux 中进程间通信设施的状态，显示的信息包括消息列表、共享内存和信号量的信息。 

**语法**：

```bash
 ipcs [resource ...] [output-format]
 ipcs [resource] -i <id>
```

**选项**：

```bash
 -i, --id <id>  打印由 id 标识的资源的详细信息
 -h, --help     显示此帮助并退出
 -V, --version  输出版本信息并退出
```

**资源选项**：

```bash
 -m, --shmems      共享内存段
 -q, --queues      消息队列
 -s, --semaphores  信号量
 -a, --all         全部(默认)
```

**输出格式**：

```bash
 -t, --time        显示附加、脱离和更改时间
 -p, --pid         显示 PID 的创建者和最后操作
 -c, --creator     显示创建者和拥有者
 -l, --limits      显示资源限制
 -u, --summary     显示状态摘要
     --human       以易读格式显示大小
 -b, --bytes       以字节数显示大小
```



## 示例

显示所有的 IPC 设施：

```bash
ipcs -a
```

显示所有的消息队列（Message Queue）：

```bash
ipcs -q
```

显示所有的信号量：

```bash
ipcs -s
```

显示所有的共享内存：

```bash
ipcs -m
```

显示 IPC 设施的详细信息：

```bash
ipcs -q -i <id>
```

:::tip

id 对应 shmid、semid、msgid 等。`-q` 对应设施的类型（队列），查看信号量详细情况使用 `-s`，查看共享内存使用 `-m`。

:::

显示 IPC 设施（共享内存）的限制大小：

```bash
ipcs -m -l
ipcs -s -l
ipcs -q -l
```

显示 IPC 设施的权限关系：

```bash
ipcs -c
ipcs -m -c
ipcs -q -c
ipcs -s -c
```

显示最近访问过 IPC 设施的进程 ID：

```bash
ipcs -p
ipcs -m -p
ipcs -q -p
```

显示 IPC 设施的最后操作时间：

```bash
ipcs -t
ipcs -q -t
ipcs -m -t
ipcs -s -t
```

显示 IPC 设施的当前状态：

```bash
ipcs -u 
```

