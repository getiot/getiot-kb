---
sidebar_position: 56
authors: [luhuadong]
---

# Linux 单例程序

在 Linux 系统中，有时你希望某个程序在同一时间只能运行一个实例，避免多个进程同时执行带来的资源冲突或逻辑错误。本文将介绍实现程序单实例运行的常见方法，包括：

- 使用文件锁（`flock`）
- 使用进程 ID 文件（PID 文件）
- 使用 `ps` 命令检测已有实例

通过这些方法，你可以确保程序在系统中只运行一个实例。



## 使用文件锁（C 语言）

文件锁是一种常用的进程间同步机制，可以用来防止多个实例同时运行。

### 文件锁示例（使用 flock）

```c showLineNumbers
#include <sys/file.h>
#include <errno.h>

int pid_file = open("/var/run/whatever.pid", O_CREAT | O_RDWR, 0666);
int rc = flock(pid_file, LOCK_EX | LOCK_NB);
if(rc) {
    if(EWOULDBLOCK == errno)
        ; // another instance is running
}
else {
    // this is the first instance
}
```



### 文件锁示例（使用 lockf）

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

int main() {
    int fd = open("/tmp/my_program.lock", O_CREAT | O_RDWR, 0666);
    if (fd < 0) {
        perror("open");
        exit(EXIT_FAILURE);
    }

    // 尝试获取文件锁
    if (lockf(fd, F_TLOCK, 0) < 0) {
        printf("Another instance is running.\n");
        exit(EXIT_FAILURE);
    }

    // 程序主体逻辑
    printf("Program is running...\n");
    sleep(30); // 模拟程序运行

    // 释放文件锁
    close(fd);
    return 0;
}
```

在上述代码中，程序尝试对 `/tmp/my_program.lock` 文件加锁，如果加锁失败，说明已有实例在运行，程序将退出。



### flock 和 lockf 的区别

`lockf` 和 `flock` 都可以用来实现**文件加锁**，但它们在底层机制、行为特性、兼容性等方面存在明显区别。

- **所属 API 不同**
  - `flock()` 是 BSD 系统引入的，Linux 也支持；
  - `lockf()` 是对 `fcntl()` 的封装，是 POSIX 标准的一部分，更具可移植性。
- **加锁机制不同**
  - `flock` 加锁简单粗暴，**整个文件**都被锁定；
  - `lockf`（底层调用 `fcntl`）是文件级锁，但**按进程**生效（多个 fd 共享），适合数据库、日志等多进程并发写入部分区域的场景。
- **锁类型支持不同**
  - `lockf` 实际支持的是排他锁（写锁），并且是通过 `fcntl` 实现的。
- **子进程继承性不同**
  - 无论是 `flock` 还是 `lockf`，子进程都可以继承锁。但 `flock` 更依赖于文件描述符的存在（同描述符），如果 fd 被关闭，则锁立即释放；而 `lockf` 更依赖于进程的存在。

如果你需要在不同 Unix 系统或网络文件系统上使用，建议优先选择 `lockf` / `fcntl`。



## 使用进程 ID 文件（Shell 脚本）

PID 文件是一种记录程序运行状态的方式，程序启动时写入自身的进程 ID，退出时删除该文件。

示例代码：

```bash showLineNumbers
#!/bin/bash

PID_FILE="/tmp/my_program.pid"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p $PID > /dev/null 2>&1; then
        echo "Another instance is running."
        exit 1
    else
        echo $$ > "$PID_FILE"
    fi
else
    echo $$ > "$PID_FILE"
fi

# 程序主体逻辑
echo "Program is running..."
sleep 30 # 模拟程序运行

# 程序结束，删除 PID 文件
rm -f "$PID_FILE"
```

该脚本在启动时检查 PID 文件是否存在，并验证对应的进程是否仍在运行，以此判断是否已有实例在执行。



## 使用 ps 命令检测（Shell 脚本）

通过 `ps` 命令，可以检查系统中是否已有相同的程序在运行。

示例代码：

```bash showLineNumbers
#!/bin/bash

PROGRAM_NAME=$(basename "$0")
INSTANCE_COUNT=$(ps -ef | grep "$PROGRAM_NAME" | grep -v grep | wc -l)

if [ "$INSTANCE_COUNT" -gt 1 ]; then
    echo "Another instance is running."
    exit 1
fi

# 程序主体逻辑
echo "Program is running..."
sleep 30 # 模拟程序运行
```

该脚本通过统计当前运行的同名程序数量，判断是否已有实例在执行。



## 基于 UDP 端口绑定检测（C++）

下面示例代码实现了一个基于 UDP 端口绑定 的进程单例检测机制。它不是通过常见的 `flock` 或 `lockf` 锁定文件来判断程序是否已经运行，而是利用操作系统对 UDP 端口绑定（`bind()`）的唯一性约束 实现“同一时间只能运行一个实例”的效果。

调用示例：

```cpp showLineNumberspp title="main.cpp"
int main()
{
   SingletonProcess singleton(5555); // pick a port number to use that is specific to this app
   if (!singleton())
   {
     cerr << "process running already. See " << singleton.GetLockFileName() << endl;
     return 1;
   }
    
   // 执行主逻辑...

    pause(); // 或者主程序循环
    return 0;
}
```

SingletonProcess 类实现：

```cpp showLineNumberspp title="SingletonProcess.hpp"
#include <netinet/in.h>

class SingletonProcess
{
public:
    // 构造函数，传入一个端口号 port0
    SingletonProcess(uint16_t port0)
            : socket_fd(-1)  // socket_fd 初始化为 -1，表示尚未创建 socket
              , rc(1)        // rc 是绑定结果的返回值，初始设为 1（失败）
              , port(port0)
    {
    }

    // 析构时自动关闭 socket，释放绑定的端口
    ~SingletonProcess()
    {
        if (socket_fd != -1) {
            close(socket_fd);
        }
    }

    bool operator()()
    {
        if (socket_fd == -1 || rc) {
            socket_fd = -1;
            rc = 1;

            // 创建一个 UDP socket
            if ((socket_fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
                throw std::runtime_error(std::string("Could not create socket: ") +  strerror(errno));
            } else {
                struct sockaddr_in name;
                name.sin_family = AF_INET;
                name.sin_port = htons (port);
                name.sin_addr.s_addr = htonl (INADDR_ANY);
                rc = bind (socket_fd, (struct sockaddr *) &name, sizeof (name));
            }
        }
        return (socket_fd != -1 && rc == 0);
    }

    // 返回一个描述性的字符串
    std::string GetLockFileName()
    {
        return "port " + std::to_string(port);
    }

private:
    int socket_fd = -1;
    int rc;
    uint16_t port;
};
```

这种方法具有以下优点：

- **无需文件锁**：不会依赖文件系统，天然跨平台（Unix 风格系统中）。
- **简单可靠**：操作系统会强制端口唯一性。
- **避免 NFS 锁文件等问题**：适合在分布式系统或容器中。

:::tip 核心原理

在 Linux 系统中，如果一个进程成功 `bind()` 到某个 UDP 端口，那么其他进程无法再绑定该端口。

:::



## 小结

本文介绍了在 Linux 系统中实现程序单实例运行的四种常见方法：

1. **文件锁（flock）**：通过对特定文件加锁，防止多个实例同时运行。
2. **进程 ID 文件（PID 文件）**：记录程序的进程 ID，启动时检查，退出时删除。
3. **`ps` 命令检测**：通过系统进程列表，判断是否已有相同程序在运行。
4. **socket 端口绑定**：谁先成功绑定端口，谁就是“唯一运行的实例”。

根据具体需求和程序类型，你可以选择合适的方法来确保程序的单实例运行，避免资源冲突和逻辑错误。

