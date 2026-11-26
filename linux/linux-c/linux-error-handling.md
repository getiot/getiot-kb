---
sidebar_position: 52
authors: [luhuadong]
---

# Linux 错误处理

在 Linux C 编程中，很多系统调用和标准库函数都会通过返回值来表示是否出错。但是，返回值只能告诉你“出错了”，却无法告诉你**为什么出错**，这时候你就需要使用全局变量错误号 `errno` 和 `perror()` 函数来获取和打印错误信息，帮助快速定位错误原因。

本文将带你了解：

- `errno` 是什么，怎么使用？
- `perror` 和 `strerror` 的区别与用法；
- 常见的错误码及其含义；
- 使用 `errno` 的注意事项；
- 一个完整的错误处理示例。



## 什么是 errno？

`errno` 是一个全局变量，用于存储最近一次错误的错误代码（错误号）。当你调用某个函数失败时，比如 `open()`、`read()`、`malloc()` 等，它们通常会设置 `errno` 为一个具体的错误编号。

这个编号是一个整数，例如：

- `2` 表示 `ENOENT`：文件不存在；
- `13` 表示 `EACCES`：权限不足；
- `12` 表示 `ENOMEM`：内存不足。

你可以在头文件中找到这些定义：

```c
#include <errno.h>
```

⚠️ 注意：`errno` 不是一个普通变量，而是一个“线程局部”的宏，底层通过 TLS（线程局部存储）实现。它对多线程是安全的。



## 使用 perror 打印错误信息

你可以使用 `perror()` 来根据当前的 `errno` 值打印一条标准错误信息，非常方便调试：

```c
#include <stdio.h>

perror("open");  // 输出类似 "open: No such file or directory"
```

这会输出你传入的字符串加上对应的错误信息，自动根据当前 `errno` 转换为人类可读的字符串。



## 使用 strerror 获取错误字符串

如果你想自己控制错误信息的格式，可以用 `strerror()`：

```c
#include <string.h>

printf("错误信息：%s\n", strerror(errno));
```

你也可以用它自定义日志输出：

```c
fprintf(stderr, "打开文件失败（错误号 %d）：%s\n", errno, strerror(errno));
```



## 示例：打开文件失败时的错误处理

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>

int main() {
    int fd = open("not_exist.txt", O_RDONLY);
    if (fd == -1) {
        // 方法一：用 perror 打印
        perror("打开文件失败");

        // 方法二：用 strerror 打印
        fprintf(stderr, "错误号 %d：%s\n", errno, strerror(errno));
        return 1;
    }

    close(fd);
    return 0;
}
```

运行结果（假设文件不存在）可能是：

```bash
打开文件失败: No such file or directory
错误号 2：No such file or directory
```



## 使用 errno 的注意事项

- ⚠️ **不要手动清零 errno**，也不要依赖它的初始值。
- errno 只有在出错时才有意义，函数成功不会重置它；
- 多线程程序中，`errno` 是线程安全的；
- 某些库函数不会设置 errno，因此具体使用要看文档；
- 如果你要在调用失败后马上用 `errno`，**中间不要调用其他函数**，以免被覆盖。



## errno 错误码列表

完整的 Linux 错误代码及其含义如下表所示。常见的错误有 `ENOENT`、`EACCES`、`ENOMEM`、`EAGAIN`、`EBADF`、`EEXIST`、`EINVAL`、`ECONNREFUSED` 等等，你也可以通过 `man 3 errno` 查看详细文档。

| 宏名 | errno | 描述               | 含义                 |
| :-----: | :---: | :-----------------------: | :------------------: |
| EPERM   | 1     | Operation not permitted   | 操作不允许           |
| ENOENT  | 2     | No such file or directory | 文件或目录不存在 |
| ESRCH   | 3     | No such process           | 没有这样的过程       |
| EINTR   | 4     | Interrupted system call   | 系统调用被中断       |
| EIO     | 5     | I/O error                 | I/O 错误             |
| ENXIO   | 6     | No such device or address | 设备或地址不存在 |
| E2BIG   | 7     | Arg list too long         | 参数列表太长         |
| ENOEXEC | 8     | Exec format error         | 执行格式错误         |
| EBADF   | 9     | Bad file number           | 坏的文件描述符       |
| ECHILD  | 10    | No child processes        | 没有子进程           |
| EAGAIN  | 11    | Try again                 | 资源暂时不可用（非阻塞 I/O） |
| ENOMEM  | 12    | Out of memory             | 内存溢出（内存不足）       |
| EACCES |13|Permission denied|拒绝许可（权限不够）|
| EFAULT |14|Bad address|错误的地址|
| ENOTBLK |15|Block device required|块设备请求|
| EBUSY |16|Device or resource busy|设备或资源忙|
| EEXIST |17|File exists|文件已存在|
| EXDEV |18|Cross-device link|无效的交叉链接|
| ENODEV |19|No such device|设备不存在|
| ENOTDIR |20|Not a directory|不是一个目录|
| EISDIR |21|Is a directory|是一个目录|
| EINVAL |22|Invalid argument|无效的参数|
| ENFILE |23|File table overflow|打开太多的文件系统|
| EMFILE |24|Too many open files|打开的文件过多|
| ENOTTY |25|Not a tty device|不是 tty 设备|
| ETXTBSY |26|Text file busy|文本文件忙|
| EFBIG |27|File too large|文件太大|
| ENOSPC |28|No space left on device|设备上没有空间|
| ESPIPE |29|Illegal seek|非法移位|
| EROFS |30|Read-only file system|只读文件系统|
| EMLINK |31|Too many links|太多的链接|
| EPIPE |32|Broken pipe|管道破裂|
| EDOM |33|Math argument out of domain|数值结果超出范围|
| ERANGE |34|Math result not representable|数值结果不具代表性|
| EDEADLK |35|Resource deadlock would occur|资源死锁错误|
| ENAMETOOLONG |36|Filename too long|文件名太长|
| ENOLCK |37|No record locks available|没有可用锁|
| ENOSYS |38|Function not implemented|功能没有实现|
| ENOTEMPTY |39|Directory not empty|目录不空|
| ELOOP |40|Too many symbolic links encountered|符号链接层次太多|
| EWOULDBLOCK |41|Same as EAGAIN|和 EAGAIN 一样|
| ENOMSG |42|No message of desired type|没有期望类型的消息|
| EIDRM |43|Identifier removed|标识符删除|
| ECHRNG |44|Channel number out of range|频道数目超出范围|
| EL2NSYNC |45|Level 2 not synchronized|2级不同步|
| EL3HLT |46|Level 3 halted|3级中断|
| EL3RST |47|Level 3 reset|3级复位|
| ELNRNG |48|Link number out of range|链接数超出范围|
| EUNATCH |49|Protocol driver not attached|协议驱动程序没有连接|
| ENOCSI |50|No CSI structure available|没有可用CSI结构|
| EL2HLT |51|Level 2 halted|2级中断|
| EBADE |52|Invalid exchange|无效的交换|
| EBADR |53|Invalid request descriptor|请求描述符无效|
| EXFULL |54|Exchange full|交换全|
| ENOANO |55|No anode|没有阳极|
| EBADRQC |56|Invalid request code|无效的请求代码|
| EBADSLT |57|Invalid slot|无效的槽|
| EDEADLOCK |58|Same as EDEADLK|和 EDEADLK 一样|
| EBFONT |59|Bad font file format|错误的字体文件格式|
| ENOSTR |60|Device not a stream|设备不是字符流|
| ENODATA |61|No data available|无可用数据|
| ETIME |62|Timer expired|计时器过期|
| ENOSR |63|Out of streams resources|流资源溢出|
| ENONET |64|Machine is not on the network|机器不上网|
| ENOPKG |65|Package not installed|没有安装软件包|
| EREMOTE |66|Object is remote|对象是远程的|
| ENOLINK |67|Link has been severed|联系被切断|
| EADV |68|Advertise error|广告的错误|
| ESRMNT |69|Srmount error|srmount 错误|
| ECOMM |70|Communication error on send|发送时的通讯错误|
| EPROTO |71|Protocol error|协议错误|
| EMULTIHOP |72|Multihop attempted|多跳尝试|
| EDOTDOT |73|RFS specific error|RFS 特定的错误|
| EBADMSG |74|Not a data message|非数据消息|
| EOVERFLOW |75|Value too large for defined data type|值太大，对于定义数据类型|
| ENOTUNIQ |76|Name not unique on network|名不是唯一的网络|
| EBADFD |77|File descriptor in bad state|文件描述符在坏状态|
| EREMCHG |78|Remote address changed|远程地址改变了|
| ELIBACC |79|Cannot access a needed shared library|无法访问必要的共享库|
| ELIBBAD |80|Accessing a corrupted shared library|访问损坏的共享库|
| ELIBSCN |81|A .lib section in an .out is corrupted|.out 中的 .lib 段发生损坏|
| ELIBMAX |82|Linking in too many shared libraries|试图链接太多的共享库|
| ELIBEXEC |83|Cannot exec a shared library directly|不能直接执行一个共享库|
| EILSEQ |84|Illegal byte sequence|无效的或不完整的多字节或宽字符|
| ERESTART |85|Interrupted system call should be restarted|应该重新启动中断的系统调用|
| ESTRPIPE |86|Streams pipe error|流管错误|
| EUSERS |87|Too many users|用户太多|
| ENOTSOCK |88|Socket operation on non-socket|套接字操作在非套接字上|
| EDESTADDRREQ |89|Destination address required|需要目标地址|
| EMSGSIZE |90|Message too long|消息太长|
| EPROTOTYPE |91|Protocol wrong type for socket|socket 协议类型错误|
| ENOPROTOOPT |92|Protocol not available|协议不可用|
| EPROTONOSUPPORT |93|Protocol not supported|不支持的协议|
| ESOCKTNOSUPPORT |94|Socket type not supported|套接字类型不受支持|
| EOPNOTSUPP |95|Operation not supported on transport|不支持的操作|
| EPFNOSUPPORT |96|Protocol family not supported|不支持的协议族|
| EAFNOSUPPORT |97|Address family not supported by protocol|协议不支持的地址|
| EADDRINUSE |98|Address already in use|地址已在使用|
| EADDRNOTAVAIL |99|Cannot assign requested address|无法分配请求的地址|
| ENETDOWN |100|Network is down|网络瘫痪|
| ENETUNREACH |101|Network is unreachable|网络不可达|
| ENETRESET |102|Network dropped|网络连接丢失|
| ECONNABORTED |103|Software caused connection|软件导致连接中断|
| ECONNRESET |104|Connection reset by|连接被重置|
| ENOBUFS |105|No buffer space available|没有可用的缓冲空间|
| EISCONN |106|Transport endpoint|传输端点已经连接|
| ENOTCONN |107|Transport endpoint|传输终点没有连接|
| ESHUTDOWN |108|Cannot send after transport|传输后无法发送|
| ETOOMANYREFS |109|Too many references|太多的参考|
| ETIMEDOUT |110|Connection timed|连接超时|
| ECONNREFUSED |111|Connection refused|连接被拒绝|
| EHOSTDOWN |112|Host is down|主机已关闭|
| EHOSTUNREACH |113|No route to host|没有主机的路由|
| EALREADY |114|Operation already|已运行|
| EINPROGRESS |115|Operation now in|正在运行|
| ESTALE |116|Stale NFS file handle|陈旧的 NFS 文件句柄|
| EUCLEAN |117|Structure needs cleaning|结构需要清洗|
| ENOTNAM |118|Not a XENIX-named|不是 XENIX 命名的|
| ENAVAIL |119|No XENIX semaphores|没有 XENIX 信号量|
| EISNAM |120|Is a named type file|是一个命名的文件类型|
| EREMOTEIO |121|Remote I/O error|远程输入/输出错误|
| EDQUOT |122|Quota exceeded|超出磁盘配额|
| ENOMEDIUM |123|No medium found|没有磁盘被发现|
| EMEDIUMTYPE |124|Wrong medium type|错误的媒体类型|
| ECANCELED |125|Operation Canceled|取消操作|
| ENOKEY |126|Required key not available|所需键不可用|
| EKEYEXPIRED |127|Key has expired|关键已过期|
| EKEYREVOKED |128|Key has been revoked|关键被撤销|
| EKEYREJECTED    | 129 |Key was rejected by service|关键被拒绝服务|
| EOWNERDEAD |130|Owner died|所有者死亡|
| ENOTRECOVERABLE |131|State not recoverable|状态不可恢复|
| ERFKILL |132|Operation not possible due to RF-kill|由于 RF-kill 而无法操作|



## 小结

通过这篇教程，你了解了：

- `errno` 是 Linux 下错误处理的核心变量；
- `perror()` 和 `strerror()` 都可以把错误号转换为人类可读的信息；
- 如何正确地使用 `errno` 来进行健壮的错误处理。

掌握好错误处理不仅能让你的程序更健壮，还能帮助你快速定位 bug。如果你正在开发底层系统程序、网络应用或者驱动接口，`errno` 的使用是你必须掌握的基本功。

