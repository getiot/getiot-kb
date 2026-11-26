---
sidebar_position: 11
authors: [luhuadong]
---

# Linux 消息队列

在进程间通信（IPC）的多种方式中，**消息队列**（Message Queue）是一种功能强大、结构清晰的通信机制。相比管道只能传输字节流，消息队列支持结构化数据和消息优先级，非常适合用于多个进程之间有序、安全的数据交换。本文将带你了解 Linux 消息队列的基本原理，并通过示例掌握其使用方法。



## 什么是消息队列？

**消息队列**是一个内核对象，它提供了一种从一个进程向另一个进程发送一个数据块的方法。每个数据块都被认为含有一个类型，接收进程可以独立地接收含有不同类型的数据结构。你可以通过发送消息来避免命名管道的同步和阻塞问题。但是消息队列与命名管道一样，每个数据块都有一个最大长度的限制。Linux 用宏 `MSGMAX` 和 `MSGMNB` 来限制一条消息的最大长度和一个队列的最大长度。

消息队列具有以下特点：

- 消息可以带有类型（整型标识符），支持有选择地接收。
- 消息是有边界的，写入和读取都是一条一条的，而不是字节流。
- 消息队列保存在内核中，直到被删除或系统关闭。
- 支持多个写入进程和多个读取进程。



## 相关系统调用

你可以使用 `<sys/ipc.h>` 和 `<sys/msg.h>` 中定义的函数对消息队列进行操作：

|   函数名   | 作用                         |
| :--------: | ---------------------------- |
| `msgget()` | 创建或打开一个消息队列       |
| `msgsnd()` | 发送消息                     |
| `msgrcv()` | 接收消息                     |
| `msgctl()` | 控制消息队列（删除、设置等） |



## 结构体定义

消息队列中的每条消息通常通过如下结构体表示：

```c
struct msgbuf {
    long mtype;      // 消息类型，必须 > 0
    char mtext[256]; // 消息正文
};
```

你可以根据实际需要定义结构体内容，但第一个字段必须是 `long` 类型的 `mtype`。



## 消息队列通信示例

下面是一个简单的发送进程和接收进程的示例。

### sender.c（发送进程）

```c showLineNumbers title="sender.c"
#include <stdio.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <string.h>

struct msgbuf {
    long mtype;
    char mtext[100];
};

int main() {
    key_t key = ftok("msgqueue", 65);
    int msgid = msgget(key, 0666 | IPC_CREAT);

    struct msgbuf message;
    message.mtype = 1;
    strcpy(message.mtext, "Hello from sender");

    msgsnd(msgid, &message, sizeof(message.mtext), 0);
    printf("Sent: %s\n", message.mtext);

    return 0;
}
```

### receiver.c（接收进程）

```c showLineNumbers title="receiver.c"
#include <stdio.h>
#include <sys/ipc.h>
#include <sys/msg.h>

struct msgbuf {
    long mtype;
    char mtext[100];
};

int main() {
    key_t key = ftok("msgqueue", 65);
    int msgid = msgget(key, 0666 | IPC_CREAT);

    struct msgbuf message;
    msgrcv(msgid, &message, sizeof(message.mtext), 1, 0);

    printf("Received: %s\n", message.mtext);

    msgctl(msgid, IPC_RMID, NULL); // 删除消息队列
    return 0;
}
```

编译运行：

```bash
gcc sender.c -o sender
gcc receiver.c -o receiver
./sender
./receiver
```



## 注意事项

- `mtype` 必须大于 0，可以用于区分不同类型的消息。
- 消息队列是**内核资源**，使用完后应通过 `msgctl()` 删除。
- 同一个 `key` 可以被多个进程访问，通常使用 `ftok()` 生成。
- 消息大小有限（通常几 KB），不适合传输大量数据。



## 小结

通过本文学习，你了解了 Linux 消息队列的基本概念、使用方法以及关键的系统调用。消息队列支持有序、结构化的数据传输，适用于多个进程之间的异步通信。在后续学习中，你还可以进一步探索消息队列的非阻塞操作、权限控制和性能优化等内容。掌握这一工具，将大大提升你进行进程间通信的灵活性和能力。

