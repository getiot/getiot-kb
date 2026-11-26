---
sidebar_position: 47
authors: [luhuadong]
---

# Linux 定时器编程

在 Linux 系统中，如果你需要定时执行某些任务，比如定时检查某个条件、每隔几秒触发某个事件，就需要用到**定时器**。Linux 提供了多种实现定时器的方式，每种方式适用于不同的场景。

本文将带你了解常见的几种定时器机制：

- `alarm()` 和 `sleep()` 等简单定时函数；
- 基于 `setitimer()` 的定时器；
- 使用 `timerfd` 文件描述符（推荐）；
- POSIX 定时器 `timer_create()`；
- 基于信号、线程和 `epoll` 的定时处理。



## 基本的 sleep 和 alarm

这类函数是最简单的定时机制，但只能实现“延时”或“一次性定时”。例如：

```c showLineNumbers
#include <stdio.h>
#include <unistd.h>

int main() {
    printf("3 秒后退出...\n");
    sleep(3);  // 延时 3 秒
    printf("结束。\n");
    return 0;
}
```

你还可以使用 `alarm()` 设置一个秒级定时器，并通过信号处理函数捕获：

```c showLineNumbers
#include <stdio.h>
#include <unistd.h>
#include <signal.h>

void on_alarm(int signum) {
    printf("定时器触发了！\n");
}

int main() {
    signal(SIGALRM, on_alarm);
    alarm(5);  // 5 秒后触发 SIGALRM
    pause();   // 等待信号
    return 0;
}
```



## 使用 setitimer 实现周期定时器

如果你希望定时器周期性触发，可以使用 `setitimer()` 函数。例如：

```c showLineNumbers
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <sys/time.h>

void timer_handler(int signum) {
    static int count = 0;
    printf("定时器触发 %d 次\n", ++count);
}

int main() {
    signal(SIGALRM, timer_handler);

    struct itimerval timer;
    timer.it_interval.tv_sec = 1;  // 每 1 秒触发一次
    timer.it_interval.tv_usec = 0;
    timer.it_value.tv_sec = 1;     // 第一次延时 1 秒
    timer.it_value.tv_usec = 0;

    setitimer(ITIMER_REAL, &timer, NULL);

    while (1) {
        pause();  // 等待信号
    }
}
```

这个定时器会每秒发出一个 `SIGALRM` 信号。



## 使用 timerfd 创建文件描述符定时器

如果你在使用 `select/poll/epoll` 等 I/O 多路复用机制，那么你可以使用 `timerfd` 来创建一个可读的定时器文件描述符。

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/timerfd.h>
#include <string.h>
#include <stdint.h>
#include <time.h>

int main() {
    int tfd = timerfd_create(CLOCK_REALTIME, 0);
    if (tfd == -1) {
        perror("timerfd_create");
        exit(1);
    }

    struct itimerspec ts;
    ts.it_value.tv_sec = 2;        // 第一次延迟 2 秒
    ts.it_value.tv_nsec = 0;
    ts.it_interval.tv_sec = 1;     // 每隔 1 秒触发一次
    ts.it_interval.tv_nsec = 0;

    timerfd_settime(tfd, 0, &ts, NULL);

    while (1) {
        uint64_t expirations;
        read(tfd, &expirations, sizeof(expirations));
        printf("定时器触发了 %llu 次\n", expirations);
    }

    close(tfd);
    return 0;
}
```

你可以将 `tfd` 与 `epoll` 结合使用，让定时器和 socket/管道等一起处理，非常适合写事件驱动程序。



## POSIX 定时器（timer_create）

POSIX 定时器提供了比 `setitimer` 更灵活的控制。你可以通过 `timer_create()` 创建多个定时器，每个定时器都可以设置不同的处理方式。

```c showLineNumbers
#include <stdio.h>
#include <signal.h>
#include <time.h>
#include <string.h>

void timer_handler(union sigval sv) {
    printf("POSIX 定时器触发了，用户数据: %d\n", *(int*)sv.sival_ptr);
}

int main() {
    struct sigevent sev;
    struct itimerspec ts;
    timer_t timerid;
    int user_data = 123;

    memset(&sev, 0, sizeof(sev));
    sev.sigev_notify = SIGEV_THREAD;   // 创建一个线程处理
    sev.sigev_notify_function = timer_handler;
    sev.sigev_value.sival_ptr = &user_data;

    timer_create(CLOCK_REALTIME, &sev, &timerid);

    ts.it_value.tv_sec = 2;    // 2 秒后触发
    ts.it_value.tv_nsec = 0;
    ts.it_interval.tv_sec = 3; // 每 3 秒重复
    ts.it_interval.tv_nsec = 0;

    timer_settime(timerid, 0, &ts, NULL);

    while (1) pause(); // 等待触发
}
```

使用这种方式，你可以为每个定时器绑定不同的数据和处理逻辑。



## 几种定时器对比

|      类型      |  精度  | 是否支持周期 | 是否支持多路复用 |            优点            |
| :------------: | :----: | :----------: | :--------------: | :------------------------: |
| `sleep/alarm`  |  秒级  |      否      |        否        |          简单易用          |
|  `setitimer`   | 毫秒级 |      是      |  否（基于信号）  |      适合简单定时任务      |
|   `timerfd`    | 纳秒级 |      是      |   是（epoll）    |   高效、适合事件驱动编程   |
| `timer_create` | 纳秒级 |      是      | 支持多种通知方式 | 灵活，支持线程、信号通知等 |



## 小结

在本教程中，你了解了 Linux 中常见的定时器机制，包括：

- 使用 `sleep()` 和 `alarm()` 实现简单延时；
- 使用 `setitimer()` 创建周期定时器；
- 利用 `timerfd` 创建适用于 epoll 的高效定时器；
- 使用 POSIX 定时器 `timer_create()` 实现多定时器管理和线程处理；

每种方式都有其适用场景。一般建议你在现代应用中优先使用 **`timerfd`** 或 **POSIX 定时器**，它们更强大、灵活，并且适配多线程或事件驱动模型。

