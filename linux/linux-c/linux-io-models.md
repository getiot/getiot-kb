---
sidebar_position: 31
authors: [luhuadong]
---

# Linux I/O 模型



I/O 模型的选择在 Linux 网络编程中十分重要。通常，在 Unix/Linux 环境中提供了五种不同的基本 IO 模型。它们分别是：

- 阻塞 I/O（Blocking I/O）
- 非阻塞 I/O（Nonblocking I/O）
- I/O 多路复用（I/O Multiplexing）包括 select、poll 和 epoll
- 信号驱动 I/O（Signal driven I/O）
- 异步 I/O（Asynchronous I/O）

注：由于 signal driven I/O 在实际应用中较少，所以在此我只会简单介绍其他四种模型。



## 前言

在 I/O 流程中，一般分为两个不同的阶段：

1. 数据等待阶段。该阶段是在等待接受网络数据，一旦网络设备收到数据包，内核将会把包拷贝到内核缓冲区
2. 数据拷贝阶段。该阶段的数据包会被从内核缓冲区拷贝到应用缓冲区

通过以上对流程阶段的定义，又可将 I/O模型分为 synchronous I/O 和 asynchronous I/O：

- synchronous I/O 会 block 请求进程，直到 I/O 操作完成。不论这个 block 是发生在数据等待阶段还是数据拷贝阶段
- asynchronous I/O 不会 block 请求进程

所以依据定义，blocking I/O、nonblocking I/O、I/O multiplexing（ select、poll和epoll ）都是属于 synchronous I/O，因为它们都会在数据拷贝阶段 block 进程。

### Synchronous I/O

#### Blocking I/O

在 Linux 中，默认的所有 socket 都是 blocking 的，一个典型的读操作流程如下： 

![img](https://xiaoxubeii.github.io/images/15311224188575.png#center)

简单的说 blocking I/O 在数据准备和拷贝阶段都是 block 进程的。

#### Nonblocking I/O

![img](https://xiaoxubeii.github.io/images/15311226124260.png#center)

可以将 socket 设置为 nonblocking，这会使得内核在无数据时返回 error，而不是 block 请求进程。如果有数据，在数据拷贝阶段`recvfrom`还是会 block 进程。

#### I/O Multiplexing

I/O Multiplexing 实际上是一种 I/O 复用技术，它使得单个进程可以管理多个网络连接。在 Linux 中，通常有 select、poll 和 epoll 这几种方式。

#### Select/Poll

Select/poll 会不断轮询所有负责的 socket（ socket 会被设置成 nonblocking ），直到某个 socket 有数据就返回。它的基本流程是： 

![img](https://xiaoxubeii.github.io/images/15311233858709.png#center)

我们的操作实际上 block 在调用 select/poll 的函数里，而不是 block 在数据准备阶段。以下示例代码可以清楚的说明该流程：

```c showLineNumbers
  while(1){
    FD_ZERO(&rset);
    for (i = 0; i< 5; i++ ) {
        FD_SET(fds[i],&rset);
    }
 
    puts("round again");
    
    select(max+1, &rset, NULL, NULL, NULL); // 等待数据返回
 
    for(i=0;i<5;i++) {
        if (FD_ISSET(fds[i], &rset)){
            memset(buffer,0,MAXBUF);
            read(fds[i], buffer, MAXBUF);
            puts(buffer);
        }
    }   
  }
  return 0;
}
```

#### Epoll

从以上示例代码可以看到，在每次调用 select 时都会将`rset`从用户空间拷贝到内核空间，并且在返回时，每次都需要遍历`fds`。为了避免以上问题，Linux 在2.6后引入了 epoll。epoll 实际上是在内核中维护了一个 context，它将以上任务分为了三步：

- 调用`epoll_create`在内核中创建 context
- 调用`epoll_ctl`增加或删除 fd
- 调用`epoll_wait`等待事件发生

示例代码如下：

```
struct epoll_event events[5];
  int epfd = epoll_create(10); // 创建 context
  ...
  ...
  for (i=0;i<5;i++) 
  {
    static struct epoll_event ev;
    memset(&client, 0, sizeof (client));
    addrlen = sizeof(client);
    ev.data.fd = accept(sockfd,(struct sockaddr*)&client, &addrlen);
    ev.events = EPOLLIN;
    epoll_ctl(epfd, EPOLL_CTL_ADD, ev.data.fd, &ev); // 添加 fd
  }
  
  while(1){
    puts("round again");
    nfds = epoll_wait(epfd, events, 5, 10000); // 等待数据返回
    
    for(i=0;i<nfds;i++) {
            memset(buffer,0,MAXBUF);
            read(events[i].data.fd, buffer, MAXBUF);
            puts(buffer);
    }
  }
```

这样的话 fd 只需在初始化时传递一次，并且在`epoll_wait`返回时也无需检查所有 fd。

由于无论是 select、poll 还是 epoll，它们都会 block 在`recvfrom`阶段，所以它们都称为 synchronous nonblocking I/O。

### Asynchronous I/O

Asynchronous I/O 是真正在各个阶段都实现了 nonblocking。当请求进程发起读操作时，内核会立刻返回，所以不会阻塞请求进程。内核在数据准备完成后，会将数据拷贝到用户空间，当所有这些工作全部完成，内核会通知请求进程，告诉它读操作已完成。 

![img](https://xiaoxubeii.github.io/images/15311251248123.png#center)

### I/O 模型的比较

下图清楚说明了各个 I/O 模型的异同：

![img](https://xiaoxubeii.github.io/images/15311253215928.png#center)

实际上，前四种模型的区别在于第一阶段，也就是数据准备阶段。在数据拷贝阶段，它们都是 block 进程的。而 Asynchronous I/O 在两个阶段均和以上四种模型不同。





### select 和 epoll 对比

|              | select                                         | epoll                            |
| ------------ | ---------------------------------------------- | -------------------------------- |
| 性能         | 随着连接数增加，性能急剧下降                   | 随着连接数增加，性能基本没有下降 |
| 连接数       | 连接数有限制（由 FD_SETSIZE 限定，默认为1024） | 连接数无限制                     |
| 内在处理机制 | 线性轮询                                       | 回调 callback                    |
| 开发复杂性   | 低                                             | 中                               |



---



## 阻塞和非阻塞

（1）阻塞block

所谓阻塞方式block，顾名思义，就是进程或是线程执行到这些函数时必须等待某个事件的发生，如果事件没有发生，进程或线程就被阻塞，函数不能立即返回。

例如socket编程中connect、accept、recv、recvfrom这样的阻塞程序。

再如绝大多数的函数调用、语句执行，严格来说，他们都是以阻塞方式执行的。

（2）非阻塞non-block

所谓非阻塞方式non-block，就是进程或线程执行此函数时不必非要等待事件的发生，一旦执行肯定返回，以返回值的不同来反映函数的执行情况，如果事件发生则与阻塞方式相同，若事件没有发生则返回一个代码来告知事件未发生，而进程或线程继续执行，所以效率较高。

比如程序语句：

```c showLineNumbers
int len = read(fd, buffer, BUFSIZE);
```

函数 read 只读一次，不管读到数据或是没有读到数据，它都返回结果。又如

```c showLineNumbers
while(1)
{
    len = read(fd, buffer, BUFSIZE);
    if (...)
        break;
}
```

虽然可以循环读取想要的数据，但它是非阻塞的，会大大地浪费系统资源。

备注：在socket编程中使用：fcntl(sockfd,F_SETFL,O_NONBLOCK)；会把sockfd设定为非阻塞模式，则之后的connect、accept、recv、recvfrom等函数便失去了阻塞功能，变成了非阻塞函数。

（3）select函数

```c showLineNumbers
int select(int maxfdp,fd_set *readfds,fd_set *writefds,fd_set *errorfds,struct timeval *timeout);
```

上面的非阻塞式的while循环显然是不可取的，而失去阻塞功能的connect等函数也需要改进，对于这两种情况，select函数便可以大显身手了。

关于select函数在这方面的使用，已经有两篇文章讲得十分清楚了：

http://blog.chinaunix.net/u/11557/showart_104967.html
http://blog.ednchina.com/thinkker/151601/message.aspx

关于select函数的使用，有几点需要注意的地方：

- maxfdp 为所有fd中的最大值加1.
- readfds 和 timeout 在每次执行select前都要重新初始化. 对于readfds，每次循环都要清空集合，否则不能检测描述符变化；而对于timeout，每次都要初始化其值，否则timeout被默认初始化为0.

正确使用select函数的典型示例(程序段)：

```c showLineNumbers
int Read(int fd, char *readbuf, int BUFSIZE)
{
  int len1,len2,nfds,select_ret;
  struct timeval timeout;
  fd_set readfds;
  FD_ZERO(&readfds);
  FD_SET(fd1, &readfds); 
  FD_SET(fd2, &readfds);
  nfds=fd1>fd2?(fd1+1):(fd2+1);
  timeout.tv_sec = 1;
  timeout.tv_usec = 500000;
  while ((select_ret = select(nfds, &readfds, NULL, NULL, &timeout)) > 0)
  {
    len1 += read(fd1, readbuf1 + len, BUFSIZE1 - len);
    len2 += read(fd2, readbuf2 + len, BUFSIZE2 - len);
    FD_ZERO(&readfds);
    FD_SET(fd1, &readfds); 
    FD_SET(fd2, &readfds);
    nfds=fd1>fd2?(fd1+1):(fd2+1);
    timeout.tv_sec = 0;
    timeout.tv_usec = 500000;
  }
  readbuf1[BUFSIZE1-1]='\0';
  readbuf2[BUFSIZE2-1]='\0';
  return len1+len2;
}
```





