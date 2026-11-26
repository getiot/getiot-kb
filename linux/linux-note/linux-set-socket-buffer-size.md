---
sidebar_position: 15
---

# Linux 查看和设置 socket 缓冲区大小



## 问题背景

最近我们开发的软件在客户现场运行很容易出现丢包现象，由于我们的软件需要接收来自传感器的庞大数据量，一秒钟有数万个数据包，网络带宽可达 200 Mb/s。 然而，当我们出发去到客户现场调试时，发现软件在我们自己的设备上运行良好，而客户的设备依然丢包严重。多年的工作经验使我意识到，这可能是个系统性能问题，常见的性能瓶颈包括 CPU、内存、IO 读写等等。经过初步诊断，我们发现线程的 CPU 占用率、内存使用情况均正常，于是把焦点放在网络 IO 上，也就是说丢包很可能出现在 recv 线程上。最终，当我们在客户的设备上增大 socket 接收缓冲区大小后，丢包现象就消失了。因此，本文介绍在 Linux 系统中查看和设置 socket 缓冲区大小的方法。



## 查看系统值

### socket 缓冲区

```bash
$ cat /proc/sys/net/core/rmem_max      # 接收缓冲区最大值
10485760
$ cat /proc/sys/net/core/wmem_max      # 发送缓冲区最大值
10485760
$ cat /proc/sys/net/core/rmem_default  # 接收缓冲区默认值
212992
$ cat /proc/sys/net/core/wmem_default  # 发送缓冲区默认值
212992
```



### TCP 缓冲区

```bash
$ cat /proc/sys/net/ipv4/tcp_rmem
4096	131072	6291456
$ cat /proc/sys/net/ipv4/tcp_wmem
4096	16384	4194304
$ cat /proc/sys/net/ipv4/tcp_mem
187092	249458	374184
```

**tcp_rmem** 和 **tcp_wmem** 都有 3 个 INTEGER 变量（min, default, max），具体含义如下：

- **`min`**：为 TCP socket 预留用于接收/发送缓冲的内存最小值。默认值为 4096（4K）。
- **`default`**：为 TCP socket 预留用于接收/发送缓冲的内存数量，默认情况下该值会影响其它协议使用的 `net.core.wmem_default` 值，一般要低于 `net.core.wmem_default` 的值。默认值为 16384（16K）。
- **`max`**: 用于 TCP socket 接收/发送缓冲的内存最大值。该值不会影响 `net.core.wmem_max`，"静态"选择参数 `SO_RCVBUF` 或 `SO_SNDBUF` 则不受该值影响。默认值为 131072（128K）。（对于服务器而言，增加这个参数的值对于发送数据很有帮助）

而 **tcp_mem** 也有 3 个 INTEGER 变量（low, pressure, high），具体含义如下：

- **`low`**：当 TCP 使用了低于该值的内存页面数时，TCP 不会考虑释放内存。
- **`pressure`**：当 TCP 使用了超过该值的内存页面数量时，TCP 试图稳定其内存使用，进入 pressure 模式，当内存消耗低于 low 值时则退出 pressure 状态。
- **`high`**：允许所有 TCP sockets 用于排队缓冲数据报的页面量。（如果超过这个值，TCP 连接将被拒绝）



### UDP 缓冲区

```bash
$ cat /proc/sys/net/ipv4/udp_mem 
374187	498916	748374
$ cat /proc/sys/net/ipv4/udp_rmem_min 
4096
$ cat /proc/sys/net/ipv4/udp_wmem_min 
4096
```



## 临时设置

我们可以通过 [echo](/linux-command/echo/) 命令直接给 /proc/sys/net 的参数赋值，从而修改缓冲区大小。例如：

```bash
echo 16777216 > /proc/sys/net/core/rmem_max
echo 16777216 > /proc/sys/net/core/wmem_max
echo "4096 873800 16777216" > /proc/sys/net/ipv4/tcp_rmem
echo "4096 873800 16777216" > /proc/sys/net/ipv4/tcp_wmem
echo "3073344 4097792 16777216" > /proc/sys/net/ipv4/tcp_mem
```

不过这种修改方式是临时的，在系统重启后会恢复为原值。

:::tip

设置缓冲区大小需要 root 权限，可通过 `sudo su` 切换 root 用户再执行命令。

:::

## 永久设置

如果想要使设置永久有效，则需要在文件 /etc/sysctl.conf 中写入设置参数。例如：

```bash
net.core.rmem_default = 16777216
net.core.rmem_max = 16777216
net.core.wmem_default = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_mem = 6177504 8236672 16777216
net.ipv4.tcp_rmem = 4096 873800 16777216
net.ipv4.tcp_wmem = 4096 873800 16777216
```

简单来说，/etc/sysctl.conf 配置文件是 Linux 系统提供的一个接口，允许你改变正在运行中的 Linux 系统参数。它包含一些 TCP/IP 堆栈和虚拟内存系统的高级选项，可用来控制 Linux 网络配置。

由于 /proc/sys/net 目录内容的临时性，因此建议把 TCP/IP 参数的修改添加到 /etc/sysctl.conf 文件，然后保存文件，使用命令 `sysctl -p` 使之立即生效。



## 通过代码设置

实际上，除了上述修改方式，我们还可以直接通过代码设置 socket 接收/发送缓冲区大小。

下面是一个设置 socket 接收缓冲区大小的示例，在这个示例中，我们先通过 `getsockopt()` 获取默认值，再通过 `setsockopt()` 将其设置为原来的两倍。

```c showLineNumbers title="代码片段"
{
    uint32_t opt_val;
    socklen_t opt_len = sizeof(uint32_t);
    getsockopt(fd, SOL_SOCKET, SO_RCVBUF, (char*)&opt_val, &opt_len);
    opt_val *= 2;
    setsockopt(fd, SOL_SOCKET, SO_RCVBUF, (char*)&opt_val, opt_len);
}
```

这里读取到的接收缓冲区大小实际上等于 /proc/sys/net/core/rmem_default 的默认值。
