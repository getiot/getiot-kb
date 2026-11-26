---
sidebar_position: 27
authors: [luhuadong]
---

# Linux 设置 socket 状态



## setsockopt 函数介绍

在 Linux 系统中，可以使用 setsockopt 函数设置 socket 状态。其函数原型如下：

```c showLineNumbers
int setsockopt(int sockfd, int level, int optname,
               const void *optval, socklen_t optlen);
```

参数说明：

| 参数    | 描述                                                         |
| ------- | ------------------------------------------------------------ |
| sockfd  | 套接字描述符                                                 |
| level   | 将被设置的选项的级别，如果想要在套接字级别上设置选项则使用 `SOL_SOCKET` |
| optname | 指定准备设置的选项，optname 的选项取决于 level               |
| optval  | 指向存放选项值的缓冲区                                       |
| optlen  | optval 缓冲区长度                                            |

返回值说明：执行成功返回 0，失败返回 -1，并设置 errno 的值。如下：

- `EBADF`：sockfd 不是有效的文件描述词
- `EFAULT`：optval 指向的内存并非有效的进程空间
- `EINVAL`：在调用 setsockopt() 时，optlen 无效
- `ENOPROTOOPT`：指定的协议层不能识别选项
- `ENOTSOCK`：sockfd 描述的不是套接字

级别（level）和选项（optname）参数如下：

```c showLineNumbers
#define SOL_SOCKET    1
#define SO_ACCEPTCONN 30
#define SO_BROADCAST  6
#define SO_DONTROUTE  5
#define SO_ERROR      4
#define SO_KEEPALIVE  9
#define SO_LINGER     13
#define SO_OOBINLINE  10
#define SO_RCVBUF     8
#define SO_RCVLOWAT   18
#define SO_RCVTIMEO   20
#define SO_REUSEADDR  2
#define SO_SNDBUF     7
#define SO_SNDLOWAT   19
#define SO_SNDTIMEO   21
#define SO_TYPE       3

#define SOL_IP	0
#define IP_DEFAULT_MULTICAST_TTL        1
#define IP_DEFAULT_MULTICAST_LOOP       1
#define IP_MAX_MEMBERSHIPS              20

SOL_SOCKET, SOL_IP, SOL_IPV6, SOL_TCP
```



| 级别       | 选项名称      | 说明                   | 数据类型       |
| ---------- | ------------- | ---------------------- | -------------- |
| SOL_SOCKET | SO_BROADCAST  | 允许发送广播数据       | int            |
|            | SO_DEBUG      | 允许调试               | int            |
|            | SO_DONTROUTE  | 不查找路由             | int            |
|            | SO_ERROR      | 获得套接字错误         | int            |
|            | SO_KEEPALIVE  | 保持连接               | int            |
|            | SO_LINGER     | 延迟关闭连接           | struct linger  |
|            | SO_OOBINLINE  | 带外数据放入正常数据流 | int            |
|            | SO_RCVBUF     | 接收缓冲区大小         | int            |
|            | SO_SNDBUF     | 发送缓冲区大小         | int            |
|            | SO_RCVLOWAT   | 接收缓冲区下限         | int            |
|            | SO_SNDLOWAT   | 发送缓冲区下限         | int            |
|            | SO_RCVTIMEO   | 接收超时               | struct timeval |
|            | SO_SNDTIMEO   | 发送超时               | struct timeval |
|            | SO_REUSERADDR | 允许重用本地地址和端口 | int            |
|            | SO_TYPE       | 获得套接字类型         | int            |
|            | SO_BSDCOMPAT  | 与 BSD 系统兼容        | int            |
| IPPROTO_IP | IP_HDRINCL    | 在数据包中包含 IP 首部 | int            |
|            | IP_OPTINOS    | IP 首部选项            | int            |
|            | IP_TOS        | 服务类型               | int            |
|            | IP_TTL        | 生存时间               | int            |
| IPPRO_TCP  | TCP_MAXSEG    | TCP 最大数据段的大小   | int            |
|            | TCP_NODELAY   | 不使用 Nagle 算法      | int            |
|            |               |                        |                |
|            |               |                        |                |
|            |               |                        |                |



## 设置选项

### Keepalive 设置

- tcp_keepalive_time，在 TCP 保活打开的情况下，最后一次数据交换到 TCP 发送第一个保活探测包的间隔，即允许的持续空闲时长，或者说每次正常发送心跳的周期，默认值为 7200s（2h）。
- tcp_keepalive_probes 在 tcp_keepalive_time 之后，没有接收到对方确认，继续发送保活探测包次数，默认值为9（次）
- tcp_keepalive_intvl，在 tcp_keepalive_time 之后，没有接收到对方确认，继续发送保活探测包的发送频率，默认值为 75s。

发送频率 tcp_keepalive_intvl 乘以发送次数 tcp_keepalive_probes，就得到了从开始探测到放弃探测确定连接断开的时间

若设置，服务器在客户端连接空闲的时候，每90秒发送一次保活探测包到客户端，若没有及时收到客户端的 TCP Keepalive ACK 确认，将继续等待15秒*2=30秒。总之可以在90s+30s=120秒（两分钟）时间内可检测到连接失效与否。

以下改动，需要写入到 /etc/sysctl.conf 文件：

```shell
net.ipv4.tcp_keepalive_time=90
net.ipv4.tcp_keepalive_intvl=15
net.ipv4.tcp_keepalive_probes=2
```



### 端口重用

```c showLineNumbers
//1.closesocket（一般不会立即关闭而经历TIME_WAIT的过程）后想继续重用该socket：
bool opt=true;
setsockopt(socket,SOL_SOCKET ,SO_REUSEADDR,(const char*)&opt,sizeof(bool));
```



```c showLineNumbers
//2. 如果要已经处于连接状态的soket在调用closesocket后强制关闭，不经历TIME_WAIT的过程：
bool in= false;
setsockopt(socket,SOL_SOCKET,SO_DONTLINGER,(const char*)&in,sizeof(bool));
```



### 设置收发时限

在 send() 或 recv() 过程中有时由于网络状况等原因，发收不能预期进行，而设置收发时限：

```c showLineNumbers
int timeout=1000;//1秒
//发送时限
setsockopt(socket，SOL_S0CKET,SO_SNDTIMEO，(char *)&timeout,sizeof(int));
//接收时限
setsockopt(socket，SOL_S0CKET,SO_RCVTIMEO，(char *)&timeout,sizeof(int));
```



### 设置缓冲区大小

在 send() 的时候，返回的是实际发送出去的字节（同步）或发送到 socket 缓冲区的字节（异步），系统默认的状态发送和接收一次为 8688 字节（约为 8.5K）；在实际的过程中发送数据和接收数据量比较大，可以设置 socket 缓冲区，而避免了 send() 和 recv() 不断的循环收发：

```c showLineNumbers
// 接收缓冲区
int r_buf=32*1024;//设置为32K
setsockopt(s,SOL_SOCKET,SO_RCVBUF,(const char*)&r_buf,sizeof(int));
//发送缓冲区
int s_buf=32*1024;//设置为32K
setsockopt(s,SOL_SOCKET,SO_SNDBUF,(const char*)&s_buf,sizeof(int));
```

如果在发送数据的时，希望不经历由系统缓冲区到socket缓冲区的拷贝而影响程序的性能：

```c showLineNumbers
int n=0;
setsockopt(socket，SOL_S0CKET,SO_SNDBUF，(char *)&n,sizeof(n));
```

同上在 recv() 完成上述功能（默认情况是将 socket 缓冲区的内容拷贝到系统缓冲区）：

```c showLineNumbers
int n=0;
setsockopt(socket，SOL_S0CKET,SO_RCVBUF，(char *)&n,sizeof(int));
```



### 设置广播特性

一般在发送 UDP 数据报的时候，希望该 socket 发送的数据具有广播特性：

```c showLineNumbers
bool broadcast=true;
setsockopt(s,SOL_SOCKET,SO_BROADCAST,(const char*)&broadcast,sizeof(bool));
```



### 设置连接延时

在客户端连接服务器端过程中，如果处于非阻塞模式下的 socket 在 connect() 的过程中可以设置 connect() 延时，直到 accpet() 被呼叫（本函数设置只有在非阻塞的过程中有显著的作用，在阻塞的函数调用中作用不大）

```c showLineNumbers
bool acc=true;
setsockopt(s,SOL_SOCKET,SO_CONDITIONAL_ACCEPT,(const char*)&acc,sizeof(bool));
```



### 设置关闭拖延

如果在发送数据的过程中（send() 没有完成，还有数据没发送）而调用了 closesocket()，以前我们一般采取的措施是“从容关闭”（`shutdown(s,SD_BOTH)`），但是数据是肯定丢失了，如何设置让程序满足具体应用的要求，即让没发完的数据发送出去后再关闭 socket。

```c showLineNumbers
struct linger {
    u_short l_onoff;
    u_short l_linger;
};

linger m_sLinger;
m_sLinger.l_onoff = 1;  // 在closesocket()调用,但是还有数据没发送完毕的时候容许逗留
                        // 如果m_sLinger.l_onoff=0;则功能和 SO_DONTLINGER 作用相同;
m_sLinger.l_linger=5;   // 容许逗留的时间为5秒

setsockopt(s, SOL_SOCKET, SO_LINGER, (const char*)&m_sLinger, sizeof(linger));
```







