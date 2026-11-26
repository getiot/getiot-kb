---
sidebar_position: 30
authors: [luhuadong]
---

# 判断 TCP 连接是否可用



在使用一个长连接的 TCP 时，如果 TCP 服务器端接收到 TCP 的客户端连接过来后，接着服务器端的TCP节点需要对这个客户端进行数据收发，收发时需要判断这个SOCKET是否可用用，判断方法有多种；

linux的5种方法,本人在使用modbus服务器端判断已经连接的设备或是gprs服务器对已经连接的GPRS设备判断，推荐使用方法

## 方法一：recv

当recv()返回值小于等于0时，socket连接断开。但是还需要判断 errno是否等于 EINTR，如果errno == EINTR 则说明recv函数是由于程序接收到信号后返回的，socket连接还是正常的，不应close掉socket连接。

## 方法二：getsockopt

```c showLineNumbers
struct tcp_info info;
int len = sizeof(info);
getsockopt(sock, IPPROTO_TCP, TCP_INFO, &info, (socklen_t *)&len);
if (info.tcpi_state == TCP_ESTABLISHED)  // 则说明未断开  else 断开
{
    /* do_something */
}
```

## 方法三：select

若使用了select等系统函数，若远端断开，则select返回1，recv返回0则断开。其他注意事项同法一。

## 方法四：keepalive

```c showLineNumbers
int keepAlive = 1;    // 开启keepalive属性
int keepIdle = 60;    // 如该连接在60秒内没有任何数据往来,则进行探测 
int keepInterval = 5; // 探测时发包的时间间隔为5 秒
int keepCount = 3;    // 探测尝试的次数.如果第1次探测包就收到响应了,则后2次的不再发.

setsockopt(rs, SOL_SOCKET, SO_KEEPALIVE, (void *)&keepAlive, sizeof(keepAlive));
setsockopt(rs, SOL_TCP, TCP_KEEPIDLE, (void*)&keepIdle, sizeof(keepIdle));
setsockopt(rs, SOL_TCP, TCP_KEEPINTVL, (void *)&keepInterval, sizeof(keepInterval));
setsockopt(rs, SOL_TCP, TCP_KEEPCNT, (void *)&keepCount, sizeof(keepCount));
```

设置后，若断开，则在使用该socket读写时立即失败，并返回**ETIMEDOUT**错误

## 方法五：自定义心跳包

自己实现一个心跳检测，一定时间内未收到自定义的心跳包则标记为已断开。



## 异常

**Transport endpoint is already connected**



**Operation now in progress**



**Connection reset by peer**



