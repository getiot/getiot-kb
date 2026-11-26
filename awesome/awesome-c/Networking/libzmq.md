---
sidebar_position: 8
slug: /libzmq
sidebar_label: libzmq 使用教程
---

# libzmq 使用教程（ZeroMQ）

**libzmq**（ZeroMQ，亦写为 ØMQ）是一个高性能、异步消息传递库，用于实现分布式应用程序中的消息队列、请求-回复模式和发布-订阅模式等通信模式。它提供了简单而强大的套接字抽象，使得开发者能够轻松地构建分布式系统，而无需过多关注底层网络细节。

:::tip

本教程完整示例代码可在 [GitHub](https://github.com/getiot/linux-c/tree/main/message-bus/zeromq/libzmq) 获取。

:::



## 接口说明

这里介绍 libzmq 库中几个常用的 API 接口函数，包括初始化、绑定、接收、发送等接口。

### 上下文的创建和销毁

#### zmq_ctx_new

`zmq_ctx_new()` 函数用于创建一个新的 ØMQ 上下文。在新版本中，该函数取代了已弃用的函数 `zmq_init()`。

函数原型：

```c
void *zmq_ctx_new ();
```

返回值：如果成功，`zmq_ctx_new()` 函数应返回新创建的上下文句柄 `context`。否则，它将返回 `NULL` 并设置 errno 的值。

#### zmq_ctx_destroy

当不再需要该 ØMQ 上下文时，可以使用 `zmq_ctx_destroy()` 函数销毁它。其函数原型如下：

```c
int zmq_ctx_destroy (void *context);
```

参数 `context` 是要销毁的上下文句柄。

返回值：如果成功，`zmq_ctx_destroy()` 函数返回 0。否则，它将返回 -1，并设置 errno 的值。

注意：如果在 context 上下文中打开的套接字正在进行阻塞操作，那么调用 `zmq_ctx_destroy()` 函数时会立即返回，并返回错误码 `ETERM`。除了 `zmq_close()` 函数之外，所有在基于 *context* 创建的 socket 上的任何进一步的操作都会失败，并返回错误代码 `ETERM`。



### 套接字的创建和关闭

#### zmq_socket

`zmq_socket()` 函数用于创建一个 ØMQ 套接字（socket）。

函数原型：

```c
void *zmq_socket (void *context, int type);
```

参数说明：

- `context` 参数是创建 socket 的上下文环境；
- `type` 参数指明了要创建的 socket 的类型，这个类型决定了在进行传输时在 socket 上执行的语义。

返回值：如果成功，`zmq_socket()` 函数应返回新创建的套接字的不透明句柄。否则，它应返回 NULL，并设置 errno 的值。

:::tip

与传统套接字中面向连接的可靠字节流（SOCK_STREAM）和无连接的不可靠数据报（SOCK_DGRAM）模式不同。ZeroMQ 在此基础上定义了新的套接字类型，实现了多种工作模式，包括请求-回复模式、发布-订阅模式、管道模式、独立对模式等。

这些模式对应的 `type` 参数类型如下：

- **请求-回复模式**
  - `ZMQ_REQ` 类型：从一个客户端向一个服务端发送请求，并从这个服务端获取回复。
  - `ZMQ_REP` 类型：套接字作为服务端用来接收户端的请求并进行回复。
- **发布-订阅模式**
  - `ZMQ_PUB` 类型：该类型套接字用来使发布者分发数据，消息会以扇出的方式被发送到所有连接上来的对端上。
  - `ZMQ_SUB` 类型：该类型套接字用来订阅发布者分发下来的数据。接收数据前需要使用 `zmq_setsockopt()` 函数的 `ZMQ_SUBSCRIBE` 属性来指定要订阅哪些消息。
- **管道模式**
  - `ZMQ_PUSH` 类型：该类型套接字被一个管道节点用来向管道的下游发送消息。
  - `ZMQ_PULL` 类型：该类型套接字用来从管道的上游节点中接收消息。
- **独立对模式**
  - `ZMQ_PAIR` 类型的套接字在每一时刻只能连接到一个对端上。独立对模式用来精确的连接另一个对端，此模式通过 IPC 方式进行通信，不会有消息被路由。

:::



#### zmq_close

`zmq_close()` 函数用于关闭 ØMQ 套接字。

函数原型：

```c
int zmq_close (void *socket);
```

返回值：如果成功，`zmq_close()` 函数应返回 0。否则，它将返回 -1，并设置 errno 的值。



### 套接字绑定

`zmq_bind()` 函数用于将套接字绑定到本地端点（endpoint），然后接受该端点上的传入连接。

函数原型：

```c
int zmq_bind (void *socket, const char *endpoint);
```

参数说明：

- `socket` 参数是将要绑定的套接字。
- `endpoint` 参数是绑定的本地端点，它是一个由 `transport ://` 后跟地址组成的字符串。其中，`transport` 是指定要使用的底层协议，包括 `tcp`、`ipc`、`inproc`、`pgm`、`vmci` 等。一个完整的端点字符串如 `"tcp://*:5555"`。

返回值：如果成功，`zmq_bind()` 函数返回 0。否则，它将返回 -1，并设置 errno 的值。



### 数据接收和发送

#### zmq_recv

`zmq_recv()` 函数用于从指定套接字接收消息并将其存储在 buf 参数引用的缓冲区中。

函数原型：

```c
int zmq_recv (void *socket, void *buf, size_t len, int flags);
```

参数说明：

- `socket` 参数是要操作的套接字。
- `buf` 参数是消息存储空间，如果 len 为零，该参数可以为 NULL。
- `len` 参数是接收的消息长度，任何超过 len 参数指定长度的字节都将被截断。
- `flags` 参数是标志的组合，例如 `ZMQ_DONTWAIT` 标志设定工作在非阻塞模式。默认为阻塞模式，即如果指定套接字上没有可用消息，则 `zmq_recv()` 函数将阻塞，直到请求得到满足。

返回值：如果成功，`zmq_recv()` 函数应返回消息中的字节数。请注意，如果消息被截断，该值可能会超过 len 参数的值。如果不成功，该函数应返回 -1，并设置 errno 的值。



#### zmq_send

`zmq_send()` 函数用于在套接字上发送消息。

函数原型：

```c
int zmq_send (void *socket, void *buf, size_t len, int flags);
```

参数说明：

- `socket` 参数是要操作的套接字。
- `buf` 参数是发送缓冲区。
- `len` 参数是发送消息的大小，不能超过缓冲区的大小。
- `flags` 参数是标志的组合。例如 `ZMQ_DONTWAIT` 设置为非阻塞执行，如果消息无法在套接字上排队，则 `zmq_send()` 函数将失败，并将 errno 设置为 `EAGAIN`。如果设置了 `ZMQ_SNDMORE`，表示正在发送的消息是多部分消息，并且后面还有更多消息部分。

返回值：如果成功，`zmq_send()` 函数将返回消息中的字节数。否则，它将返回 -1，并设置 errno 的值。



## 示例程序

首先编写一个 Hello World 服务端，将创建一个类型为 response 的套接字（使用 request-response 模型），将其绑定到端口 5555，然后等待消息。

```c showLineNumbers title="helloworld_server.c"
//  Hello World server
#include <zmq.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <assert.h>

int main (void)
{
    //  Socket to talk to clients
    void *context = zmq_ctx_new ();
    void *responder = zmq_socket (context, ZMQ_REP);
    int rc = zmq_bind (responder, "tcp://*:5555");
    assert (rc == 0);

    while (1) {
        char buffer [10];
        zmq_recv (responder, buffer, 10, 0);
        printf ("Received Hello\n");
        sleep (1);          //  Do some 'work'
        zmq_send (responder, "World", 5, 0);
    }
    return 0;
}

```

客户端创建一个类型为 request 的套接字，连接并开始发送消息。

```c showLineNumbers title="helloworld_client.c"
//  Hello World client
#include <zmq.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

int main (void)
{
    printf ("Connecting to hello world server ...\n");
    void *context = zmq_ctx_new ();
    void *requester = zmq_socket (context, ZMQ_REQ);
    zmq_connect (requester, "tcp://localhost:5555");

    int request_nbr;
    for (request_nbr = 0; request_nbr != 10; request_nbr++) {
        char buffer [10];
        printf ("Sending Hello %d ...\n", request_nbr);
        zmq_send (requester, "Hello", 5, 0);
        zmq_recv (requester, buffer, 10, 0);
        printf ("Received World %d\n", request_nbr);
    }
    zmq_close (requester);
    zmq_ctx_destroy (context);
    return 0;
}
```

执行 `make` 编译后生成 `helloworld_server` 和 `helloworld_client` 两个可执行文件。分别在两个终端执行 server 和 client 程序（先启动那个程序都行），可以看到如下打印。

Client 端输出：

```bash showLineNumbers
$ ./helloworld_client 
Connecting to hello world server ...
Sending Hello 0 ...
Received World 0
Sending Hello 1 ...
Received World 1
Sending Hello 2 ...
Received World 2
Sending Hello 3 ...
Received World 3
```

Server 端输出：

```bash showLineNumbers
$ ./helloworld_server 
Received Hello
Received Hello
Received Hello
...
```



## 相关链接

- [ZeroMQ 官网](https://zeromq.org)
- [libzmq 代码仓库](https://github.com/zeromq/libzmq)
