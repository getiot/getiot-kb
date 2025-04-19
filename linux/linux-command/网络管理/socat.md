---
sidebar_label: socat 命令
sidebar_position: 42
slug: /socat
---

# Linux socat 命令 - 双向数据传输工具



## 介绍

**socat**（英文全拼：Socket CAT）是 Linux 下的一个多功能的网络工具，其功能与有瑞士军刀之称的 [Netcat](/linux-command/netcat/) 类似，可以看作是 Netcat 的加强版。socat 的主要特点就是在两个数据流之间建立通道，这些数据通道包含文件、管道、设备（终端或调制解调器等）、Socket、SSL、SOCKS4 客户端或代理 CONNECT。

socat 支持众多协议和链接方式，如 IP、TCP、 UDP、IPv6、PIPE、EXEC、System、Open、Proxy、Openssl、Socket 等。支持广播和多播、抽象 Unix sockets、Linux tun/tap、GNU readline 和 PTY，并提供了分叉、记录和进程间通信的不同模式。

项目网址：[http://www.dest-unreach.org/socat/](http://www.dest-unreach.org/socat/)

socat 命令由 socat 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install socat
```

**语法**：

```bash
socat [options] <address> <address>
```

**选项**：

- `-V` ：显示版本信息及特性。
- `-h|-?` ：显示帮助信息，包括选项（options）和地址（addresses）。
- `-hh` ：与 -h 类似，但会列出所有通用的地址选项名称。
- `-hhh` ：与 -hh 类似，但会列出所有可用的地址选项名称。
- `-d[ddd]` ：增加详细程度（最多使用 4 次，建议使用 2 次）。
- `-D` ：在循环之前分析文件描述符。
- `-ly[facility]` ：将日志输出到 syslog 系统日志（默认使用守护进程）。
- `-lf<logfile>` ：将日志输出到文件。
- `-ls` ：将日志输出到标准错误 stderr（如果没有指定其他日志，则默认使用 stderr）。
- `-lm[facility]` ：混合日志模式（初始化期间使用标准错误 stderr，之后使用系统日志 syslog）。
- `-lp<progname>` ：设置用于日志记录的程序名称。
- `-lu` ：使用微秒记录日志时间戳。
- `-lh` ：在日志信息中添加主机名称。
- `-v` ：详细的数据流量，文本格式。
- `-x` ：详细数据流量，十六进制格式。
- `-b<size_t>` ：设置数据缓冲区大小（默认 8192）。
- `-s` ：马虎模式（出错时继续执行）。
- `-t<timeout>` ：在关闭第二个频道之前等待几秒钟。
- `-T<timeout>` ：总的不活动（inactivity ）超时时间（以秒为单位）。
- `-u` ：单向模式（从左到右）。
- `-U` ：单向模式（从右到左）。
- `-g` ：不检查选项组。
- `-L <lockfile>` ：尝试获取锁，否则失败。
- `-W <lockfile>` ：尝试获取锁，否则等待。
- `-4` ：如果未明确指定版本，则首选 IPv4。prefer IPv4 if version is not explicitly specified
- `-6` ：如果未明确指定版本，则首选 IPv6。prefer IPv6 if version is not explicitly specified

**参数**：address 参数用于提供数据通道的必要信息，不同类型的数据通道有不同的地址参数。下列列出几种模式：

- `-` `STDIN` `STDOUT` ：表示标准输入输出，可以就用一个横杠代替。
- `/var/log/syslog` ：也可以是任意路径，如果是相对路径要使用 `./`，打开一个文件作为数据流。
- `TCP:127.0.0.1:1080` ：建立一个 TCP 连接作为数据流，TCP 也可以替换为 UDP。
- `TCP-LISTEN:12345` ：建立 TCP 监听端口，TCP 也可以替换为 UDP。
- `EXEC:/bin/bash` ：执行一个程序作为数据流。



## 示例

### 文件操作

通过 socat 读取一个本地的文件，并在终端显示

```bash
socat - /etc/sysctl.conf
```

通过 socat 将一段文本写入一个本地文件

```bash
echo "Hello GetIoT.tech" | socat - /tmp/hello.txt
```



### 虚拟串口

创建两个可以相互通信的 Linux 虚拟串口

```bash
$ socat -d -d PTY PTY
2026/07/15 05:29:51 socat[1533] N PTY is /dev/pts/0
2026/07/15 05:29:51 socat[1533] N PTY is /dev/pts/1
2026/07/15 05:29:51 socat[1533] N starting data transfer loop with FDs [5,5] and [7,7]
```

当前产生的虚拟串口为 `/dev/pts/0` 和 `/dev/pts/1`，如果想要虚拟的串口一直有效，必须使 socat 一直运行。

可以给 address 字段添加额外参数

```bash
socat -d -d pty,raw,echo=0 pty,raw,echo=0
```

接着就可以使用 minicom 打开串口终端进行测试

```bash
minicom -D /dev/pts/0 -b 9600    # 打开一个串口终端
minicom -D /dev/pts/1 -b 9600    # 打开另一个串口终端
```

在 minicom 命令中输入指令，在另一个 minicom 终端就能接收到了。



### TCP 通信

创建服务器端，侦听 2222 端口

```bash
socat – tcp4-listen:2222
```

查看 2222 端口是否打开

```bash
netstat -pantu | grep :2222
```

客户端连接到服务器端

```bash
socat tcp:192.168.1.110:2222
```

服务端和客户端就能相互通信了



### 网络管理

连接远程端口

```bash
socat - TCP:192.168.1.252:3306
```

监听一个新端口

```bash
socat TCP-LISTEN:7000 -
```



### 端口转发

在实际生产中我们经常会遇到到一个场景就是，用一台机器作为转发服务器，连接 AB 两个网段，将转发服务器的某个端口上的流量转发到 B 网段的某台机器的某个端口，这样 A 网段的服务器就可以通过访问转发服务器上的端口访问到 B 网段的服务器端口。

这样的场景一般在和客户建立专线的连接时候经常用到，一般也可以采用 iptables 做转发，但是比较复杂。socat 可以很轻松的完成这个功能，但是 socat 不支持端口段转发，只适用于单端口或者少量端口。

#### 转发 TCP

监听 192.168.1.252 网卡的 15672 端口，并将请求转发至 172.17.0.15 的 15672 端口。

```bash
socat -d -d -lf /var/log/socat.log TCP4-LISTEN:15672,bind=192.168.1.252,reuseaddr,fork TCP4:172.17.0.15:15672
```

参数说明：

- 前面两个连续的 `-d` `-d` 代表调试信息的输出级别。
- `-lf /var/log/socat.log` 指定输出信息的文件保存位置。 
- `TCP4-LISTEN:15672` 在本地建立一个 TCP IPv4 协议的监听端口，也就是转发端口。这里是 15672，请根据实际情况改成你自己需要转发的端口。
- `bind` 指定监听绑定的 IP 地址。
- `reuseaddr` 设置本地端口可重复使用。
- `fork TCP4:172.17.0.15:15672` 指的是要转发到的服务器 IP 和端口，这里是 172.17.0.15 的 15672 端口。

#### 转发 UDP

转发 UDP 和 TCP 类似，只要把 TCP4 改成 UDP4 就行了。

```bash
socat -d -d -lf /var/log/socat.log UDP4-LISTEN:123,bind=192.168.1.252,reuseaddr,fork UDP4:172.17.0.15:123
```

#### NAT 映射

在一个 NAT 网络环境中，也是可以通过 socat 将内部机器端口映射到公网上的。

在外部公网机器上执行

```bash
socat tcp-listen:1234 tcp-listen:3389
```

在内部私网机器上执行

```bash
socat tcp:outerhost:1234 tcp:192.168.1.34:3389
```

这样，外部机器上的 3389 就映射在内网 192.168.1.34 的 3389 端口上，实现私网穿透。



### 文件传递

#### 文件传送

将文件 demo.tar.gz 使用 2000 端口从 192.168.1.252 传到 192.168.1.253，文件传输完毕后会自动退出。

在 192.168.1.252 上执行

```bash
socat -u open:demo.tar.gz tcp-listen:2000,reuseaddr
```

在 192.168.1.253 上执行

```bash
socat -u tcp:192.168.1.252:2000 open:demo.tar.gz,create
```

#### 读写分流功能

socat 具有一个独特的读写分流功能，比如：可以实现一个假的 Web Server，客户端连过来之后就把 read.html 里面的内容传过去，同时把客户端的数据保存到 write.txt 里面。

```bash
socat open:read.html\!\!open:write.txt,create,append tcp-listen:8000,reuseaddr,fork
```

注意：!! 符号用于合并读写流，前面的用于读，后面的用于写。由于 ! 在 Shell 中是特殊字符，所以这里在命令行中使用 \ 对其进行了转义。



### 本地域套接字

监听一个 Unix Socket

```bash
socat unix-listen:/tmp/unix.socket -
```

向本地 Unix Socket 发送数据

```bash
echo "test" | socat - unix-connect:/tmp/unix.sock
```

监听本地 Unix Datagram Socket

```bash
socat unix-recvfrom:/tmp/unix.dg.sock -
```

向本地 Unix Datagram Socket 发送数据

```bash
echo "test" | socat - unix-sendto:/tmp/unix.dg.sock
```



### 其它功能

在目标机上弄一个 shell 代理

```bash
socat TCP-LISTEN:12345 EXEC:/bin/bash
```

将本地的 UNIX 域套接字转成 TCP socket 供局域网内的机器使用（当有多个 TCP 连上来那就 fork 一个去连接 UNIX 域套接字）

```bash
socat TCP-LISTEN:12345,reuseaddr,fork UNIX-CONNECT:/data/deCOREIDPS/unix.domain
```

将本地的 80 端口转到远程服务器的 80 端口

```bash
socat TCP-LISTEN:80,fork TCP:www.getiot.tech:80
```



