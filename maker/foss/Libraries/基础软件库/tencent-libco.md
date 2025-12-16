---
sidebar_position: 29
slug: /tencent-libco
---

# 腾讯 libco 协程库



## 简介

Libco 是微信后台大规模使用的 C/C++ 协程库，2013年至今稳定运行在微信后台的数万台机器上，使得微信后端服务能同时 hold 大量请求，被誉为微信服务器稳定性的基石。libco 在2013年的时候作为腾讯六大开源项目首次开源，GitHub 地址是 [https://github.com/Tencent/libco](https://github.com/Tencent/libco)。

libco 首先能解决 CPU 利用率与 IO 利用率不平衡，比用多线程解决 IO 阻塞 CPU 问题更高效。因为用户态协程切换比线程切换性能高：线程切换保存恢复的数据更多，需要用户态和内核态切换。 其次 libco 又避免了异步调用和回调分离导致的代码结构破碎。

libco 采用 epoll 多路复用使得一个线程处理多个 socket 连接，采用钩子函数hook住socket族函数，采用时间轮盘处理等待超时事件，采用协程栈保存、恢复每个协程上下文环境。



## 安装





## 参考

- [漫谈微信libco协程设计及实现](https://runzhiwang.github.io/2019/06/21/libco/)