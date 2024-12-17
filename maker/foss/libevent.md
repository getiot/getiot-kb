---
sidebar_position: 30
slug: /libevent
---

# 高性能 I/O 框架库 libevent



Libevent 是一个高性能、跨平台的 C 语言网络库。

Libevent 是一款高性能的开源 I/O 框架库，具有如下特点：

- 跨平台支持
- 统一事件源
- 线程安全
- 基于 Reactor 模式的实现



Libevent 是基于 Reactor 模式的网络库，在 Reactor 模式中，通常都有一个事件循环(Event Loop)，在 Libevent 中，这个事件循环就是 `event_base` 结构体：

```c showLineNumbers
struct event_base *event_base_new(void);           // 创建事件循环
void event_base_free(struct event_base *base);     // 销毁事件循环
int event_base_dispatch(struct event_base *base);  // 运行事件循环
```



## 示例

### Hello World

下面是用 libevent 库实现的一个 "Hello World" 程序。

```c showLineNumbers
#include <sys/signal.h>
#include <event2/event.h>

void signal_cb(int fd, short event, void *argc)
{
    struct event_base* base = (event_base*)argc;
    struct timeval delay = {2, 0};
    printf("Caught an interrupt signal; exiting cleanly in two seconds....\n");
    event_base_loopexit(base, &delay);
}

void timeout_cb(int fd, short event, void* argc)
{
    printf("timeout\n");
}

int main(int argc, char const *argv[])
{
    struct event_base* base = event_base_new();
    struct event* signal_event = evsignal_new(base, SIGINT, signal_cb, base);
    event_add(signal_event, NULL);

    timeval tv = {1, 0};
    struct event* timeout_event = evtimer_new(base, timeout_cb, NULL);
    event_add(timeout_event, &tv);

    event_base_dispatch(base);

    event_free(timeout_event);
    event_free(signal_event);
    event_base_free(base);

    return 0;
}
```







## 参考

- [Libevent 编程指南](http://senlinzhan.github.io/2017/08/12/libevent/)
- [Linux高性能I/O框架库Libevent介绍](https://www.w3cschool.cn/article/7a2c98efb36b7c.html)