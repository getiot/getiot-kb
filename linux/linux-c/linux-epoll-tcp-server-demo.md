---
sidebar_position: 36
sidebar_label: Linux epoll TCP 服务器实现
authors: [luhuadong]
---

# Linux epoll 完整 TCP 服务器实现

本文我们将在 Linux 上用 C 语言实现一个完整的 TCP 服务器。我们假定你有 C 编程经验，知道在 Linux 上如何编译和运行程序，并能够在 Man 手册查看用到的各种 C 函数。



## 示例代码

当你使用水平触发模式时，如果数据可读， `epoll_wait` 会总是返回准备好的事件。如果数据没有读完，再次调用 `epoll_wait` ，它会再次返回这个描述符的准备好的事件，因为数据可读。而边缘触发模式中，只能得到一次准备就绪通知。如果你没有读取全部数据，然后再次调用 `epoll_wait` 来查看该描述符，它将阻塞，因为准备就绪事件已经发送过了。

传递给 `epoll_ctl` 的 `epoll` 事件结构如下。每个被观察的描述符可以关联一个整型变量或指针作为用户数据。

```c showLineNumbers
typedef union epoll_data {
    void        *ptr;
    int          fd;
    uint32_t     u32;
    uint64_t     u64;
} epoll_data_t;

struct epoll_event {
    uint32_t     events;      /* Epoll events */
    epoll_data_t data;        /* User data variable */
};
```

现在让我们开始写代码。我们将实现一个微型服务器，它将打印所有发送到套接字的数据到标准输出。我们将从写一个创建并绑定 TCP 套接字的函数 `create_and_bind` 开始：

```c showLineNumbers
static int create_and_bind (char *port)
{
    struct addrinfo hints;
    struct addrinfo *result, *rp;
    int s, sfd;
    
    memset (&hints, 0, sizeof (struct addrinfo));
    hints.ai_family = AF_UNSPEC;     /* Return IPv4 and IPv6 choices */
    hints.ai_socktype = SOCK_STREAM; /* We want a TCP socket */
    hints.ai_flags = AI_PASSIVE;     /* All interfaces */
    
    s = getaddrinfo (NULL, port, &hints, &result);
    if (s != 0) {
        fprintf (stderr, "getaddrinfo: %s\n", gai_strerror (s));
        return -1;
    }

    for (rp = result; rp != NULL; rp = rp->ai_next) {
        sfd = socket (rp->ai_family, rp->ai_socktype, rp->ai_protocol);
        if (sfd == -1)
            continue;
        
        s = bind (sfd, rp->ai_addr, rp->ai_addrlen);
        if (s == 0) {
            /* We managed to bind successfully! */
            break;
        }
        close (sfd);
    }
    
    if (rp == NULL) {
        fprintf (stderr, "Could not bind\n");
        return -1;
    }
    
    freeaddrinfo (result);
    return sfd;
}
```

`create_and_bind` 包括了一段可移植的获取 IPv4 或 IPv6 套接字的标准代码块。它以字符串形式接受一个端口参数，可以用 `argv[1]` 来传递。 `getaddrinfo` 函数返回一串和 `hints` 参数兼容的 `addrinfo` 结构。

`addrinfo` 结构如下：

```c showLineNumbers
struct addrinfo {
    int              ai_flags;
    int              ai_family;
    int              ai_socktype;
    int              ai_protocol;
    size_t           ai_addrlen;
    struct sockaddr *ai_addr;
    char            *ai_canonname;
    struct addrinfo *ai_next;
};
```

我们逐个遍历这些结构，尝试用它们创建套接字。如果成功， `create_and_bind` 函数返回套接字描述符，否则返回 -1。

接下来，我们写一个函数将套接字修改为非阻塞。 `make_socket_non_blocking` 函数设置描述符的 `O_NONBLOCK` 标志：

```c showLineNumbers
static int make_socket_non_blocking (int sfd)
{
    int flags, s;
    
    flags = fcntl (sfd, F_GETFL, 0);
    if (flags == -1) {
        perror ("fcntl");
        return -1;
    }
    
    flags |= O_NONBLOCK;
    s = fcntl (sfd, F_SETFL, flags);
    if (s == -1) {
        perror ("fcntl");
        return -1;
    }
    
    return 0;
}
```

现在再来看 main 函数，它包含事件循环，是程序的主体：

```c showLineNumbers
#define MAXEVENTS 64

int main (int argc, char *argv[])
{
    int sfd, s;
    int efd;
    struct epoll_event event;
    struct epoll_event *events;
    
    if (argc != 2) {
        fprintf (stderr, "Usage: %s [port]\n", argv[0]);
        exit (EXIT_FAILURE);
    }
    
    sfd = create_and_bind (argv[1]);
    if (sfd == -1)
        abort ();
    
    s = make_socket_non_blocking (sfd);
    if (s == -1)
        abort ();
    
    s = listen (sfd, SOMAXCONN);
    if (s == -1) {
        perror ("listen");
        abort ();
    }
    
    efd = epoll_create1 (0);
    if (efd == -1) {
        perror ("epoll_create");
        abort ();
    }
    
    event.data.fd = sfd;
    event.events = EPOLLIN | EPOLLET;
    s = epoll_ctl (efd, EPOLL_CTL_ADD, sfd, &event);
    if (s == -1) {
        perror ("epoll_ctl");
        abort ();
    }
    
    /* Buffer where events are returned */
    events = calloc (MAXEVENTS, sizeof event);
    
    /* The event loop */
    while (1) {
        int n, i;
        n = epoll_wait (efd, events, MAXEVENTS, -1);
        for (i = 0; i < n; i++)
        {
            if ((events[i].events & EPOLLERR) ||
                (events[i].events & EPOLLHUP) ||
                (!(events[i].events & EPOLLIN)))
            {
                /* An error has occured on this fd, or the socket is not
                   ready for reading (why were we notified then?) */
                fprintf (stderr, "epoll error\n");
                close (events[i].data.fd);
                continue;
            }
            
            else if (sfd == events[i].data.fd) {
                /* We have a notification on the listening socket, which
                   means one or more incoming connections. */
                while (1) {
                    struct sockaddr in_addr;
                    socklen_t in_len;
                    int infd;
                    char hbuf[NI_MAXHOST], sbuf[NI_MAXSERV];
                    
                    in_len = sizeof in_addr;
                    infd = accept (sfd, &in_addr, &in_len);
                    if (infd == -1) {
                        if ((errno == EAGAIN) || (errno == EWOULDBLOCK)) {
                            /* We have processed all incoming connections. */
                            break;
                        } else {
                            perror ("accept");
                            break;
                        }
                    }
                    
                    s = getnameinfo(&in_addr, in_len, hbuf, sizeof(hbuf),
                                    sbuf, sizeof(sbuf), NI_NUMERICHOST | NI_NUMERICSERV);
                    if (s == 0) {
                        printf("Accepted connection on descriptor %d "
                               "(host=%s, port=%s)\n", infd, hbuf, sbuf);
                    }
                    
                    /* Make the incoming socket non-blocking and add it to the
                       list of fds to monitor. */
                    s = make_socket_non_blocking (infd);
                    if (s == -1)
                        abort ();
                    
                    event.data.fd = infd;
                    event.events = EPOLLIN | EPOLLET;
                    s = epoll_ctl (efd, EPOLL_CTL_ADD, infd, &event);
                    if (s == -1) {
                        perror ("epoll_ctl");
                        abort ();
                    }
                }
                continue;
            } else {
                /* We have data on the fd waiting to be read. Read and
                   display it. We must read whatever data is available
                   completely, as we are running in edge-triggered mode
                   and won't get a notification again for the same data. */
                int done = 0;
                while (1) {
                    ssize_t count;
                    char buf[512];
                    
                    count = read (events[i].data.fd, buf, sizeof buf);
                    if (count == -1) {
                        /* If errno == EAGAIN, that means we have read all
                           data. So go back to the main loop. */
                        if (errno != EAGAIN) {
                            perror ("read");
                            done = 1;
                        }
                        break;
                    } else if (count == 0) {
                        /* End of file. The remote has closed the connection. */
                        done = 1;
                        break;
                    }
                    
                    /* Write the buffer to standard output */
                    s = write (1, buf, count);
                    if (s == -1) {
                        perror ("write");
                        abort ();
                    }
                }

                if (done) {
                    printf ("Closed connection on descriptor %d\n", events[i].data.fd);
                    /* Closing the descriptor will make epoll remove it
                       from the set of descriptors which are monitored. */
                    close (events[i].data.fd);
                }
            }
        }
    }

    free(events);
    close(sfd);
    return EXIT_SUCCESS;
}
```



## 代码说明

`main` 函数首先调用 `create_and_bind` 函数来建立套接字。然后将套接字设置为非阻塞，然后调用 `listen` 函数。接下来创建一个 `epoll` 实例 `efd` ，以边缘触发模式向它添加监听套接字 `sfd` 来观察输入事件。

外面的 `while` 循环是主事件循环。调用 `epoll_wait` 函数阻塞线程来等待事件。当有事件发生时， `epoll_wait` 函数通过 `events` 参数返回事件。

当我们添加新的要观察的连接，以及移除已经终止的连接时， `epoll` 实例在事件循环中不断更新。

当有事件发生时，有三种类型：

- 出错。当一个错误条件发生时，或者事件不是一个有关数据可读的通知，关闭关联的描述符。关闭描述符会自动将它从 `epoll` 实例的观察集合中移除。
- 新连接。当监听描述符 `sfd` 可读时，意味着有一个或多个新的连接到达。调用 `accept` 函数接受这些连接，打印一条消息，然后将套接字修改为非阻塞并将它添加到 `epoll` 实例的观察集合中。
- 客户端数据。当任何客户端描述符上有数据可读时，我们使用 `read` 函数读取数据。我们必须读取全部可读数据，因为在边缘触发模式下只产生一个事件。读取的数据用 `write` 函数写到标准输出。如果 `read` 函数返回0，代表遇到 `EOF` ，可以关闭客户端连接了。如果为-1并且 `errno` 为 `EAGAIN` ，表示这个事件的所有数据都已经读完，可以回到主循环。

就是这样。不断循环，向观察集合中添加和删除描述符。

