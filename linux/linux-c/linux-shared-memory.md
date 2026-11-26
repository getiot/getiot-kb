---
sidebar_position: 12
authors: [luhuadong]
---

# Linux 共享内存



共享内存是一种高效的进程间通信方式，也是 Linux 系统提供的一种进程间通信方式，它允许多个进程访问同一块物理内存，从而实现进程间数据共享。



## 共享内存相关函数

Linux 系统提供了多个操作共享内存的接口函数，主要包括 shmget、shmctl、shmat、shmdt 四个函数，下面将详细介绍。另外，还有其他一些辅助函数，如 shm_open 和 shm_unlink 等，它们主要用于在文件系统中创建和删除共享内存对象。

### shmget

shmget 函数用于创建或获取共享内存标识符。

```c showLineNumbers
int shmget(key_t key, size_t size, int shmflg);
```

- 参数：
  - key：共享内存标识符。
  - size：共享内存大小。
  - shmflg：标志位，用于指定操作模式。
- 返回值：
  - 成功：共享内存标识符。
  - 失败：-1，错误码保存在 errno 中。

### shmctl

shmctl 函数用于控制共享内存，如删除共享内存、获取共享内存信息等。

```c showLineNumbers
int shmctl(int shmid, int cmd, struct shmid_ds *buf);
```

- 参数：
  - shmid：共享内存标识符。
  - cmd：控制命令。
  - buf：共享内存信息结构体指针。
- 返回值：
  - 成功：操作成功返回 0。
  - 失败：-1，错误码保存在 errno 中。

### shmat

shmat 函数将共享内存映射到进程的虚拟地址空间中。

```c showLineNumbers
void *shmat(int shmid, const void *shmaddr, int shmflg);
```

- 参数：
  - shmid：共享内存标识符。
  - shmaddr：映射地址，一般设置为 0。
  - shmflg：标志位，用于指定映射模式。
- 返回值：
  - 成功：返回共享内存的起始地址。
  - 失败：返回 `(void *)-1`，错误码保存在 errno 中。

### shmdt

shmdt 函数将共享内存从进程的虚拟地址空间中分离。

```c showLineNumbers
int shmdt(const void *shmaddr);
```

- 参数：
  - shmaddr：共享内存起始地址。
- 返回值：
  - 成功：操作成功返回 0。
  - 失败：-1，错误码保存在 errno 中。



## 共享内存示例程序

下面是一个 Linux 共享内存的示例程序，包括两个进程（一个是写进程，一个是读进程），这两个进程使用共享内存进行通信。这两个程序使用相同的共享内存标识符（1234）进行通信。写进程向共享内存中写入字符串，读进程从共享内存中读取字符串，并在终端上输出。

注意，共享内存必须在使用后手动删除，否则会占用系统资源。在该示例中，写进程先运行，创建共享内存并写入数据，读进程在读取完数据后删除了共享内存。

### 写进程

GitHub：[shm_writer.c](https://github.com/getiot/linux-c/blob/main/system/ipc/shared-memory/reader_writer/shm_writer.c)

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/shm.h>

#define SHM_SIZE 1024

int main()
{
    int shmid;
    char *shmaddr;
    char *msg = "Hello, shared memory!";
    
    // 创建共享内存
    shmid = shmget((key_t)1234, SHM_SIZE, 0666|IPC_CREAT);
    if(shmid == -1){
        perror("shmget");
        exit(1);
    }
    
    // 连接共享内存
    shmaddr = shmat(shmid, (void *)0, 0);
    if(shmaddr == (char *)-1){
        perror("shmat");
        exit(1);
    }
    
    // 向共享内存写入数据
    strcpy(shmaddr, msg);
    printf("Write: %s\n", shmaddr);
    
    // 分离共享内存
    if(shmdt(shmaddr) == -1){
        perror("shmdt");
        exit(1);
    }
    
    return 0;
}
```

### 读进程

GitHub：[shm_reader.c](https://github.com/getiot/linux-c/blob/main/system/ipc/shared-memory/reader_writer/shm_reader.c)

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/shm.h>

#define SHM_SIZE 1024

int main()
{
    int shmid;
    char *shmaddr;
    
    // 获取共享内存
    shmid = shmget((key_t)1234, SHM_SIZE, 0666|IPC_CREAT);
    if(shmid == -1){
        perror("shmget");
        exit(1);
    }
    
    // 连接共享内存
    shmaddr = shmat(shmid, (void *)0, 0);
    if(shmaddr == (char *)-1){
        perror("shmat");
        exit(1);
    }
    
    // 从共享内存读取数据
    printf("Read: %s\n", shmaddr);
    
    // 分离共享内存
    if(shmdt(shmaddr) == -1){
        perror("shmdt");
        exit(1);
    }
    
    // 删除共享内存
    if(shmctl(shmid, IPC_RMID, 0) == -1){
        perror("shmctl");
        exit(1);
    }
    
    return 0;
}
```



## 共享内存注意事项

在使用共享内存时，需要注意以下几个方面：

1. **共享内存的大小**：需要根据实际需求来设置共享内存的大小，过小可能导致数据不完整，过大则会浪费内存资源。
2. **共享内存的访问**：由于共享内存区域是被多个进程共享的，因此需要采取一些措施来避免不同进程之间的数据冲突，例如使用信号量或者互斥锁等同步机制。
3. **共享内存的生命周期**：共享内存区域的生命周期通常与创建它的进程相关联，因此需要考虑进程退出或异常终止的情况，并进行相应的处理，例如使用信号捕捉机制来处理进程退出信号。

总而言之，使用共享内存需要仔细考虑多进程之间的数据同步和内存管理等问题，确保程序的正确性和可靠性。

