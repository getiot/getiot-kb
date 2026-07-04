---
sidebar_position: 29
draft: true
---

# C 语言 - 错误处理



As such, C programming does not provide direct support for error handling but being a system programming language, it provides you access at lower level in the form of return values. Most of the C or even Unix function calls return -1 or NULL in case of any error and set an error code **errno**. It is set as a global variable and indicates an error occurred during any function call. You can find various error codes defined in `<error.h>` header file.

So a C programmer can check the returned values and can take appropriate action depending on the return value. It is a good practice, to set errno to 0 at the time of initializing a program. A value of 0 indicates that there is no error in the program.

## errno, perror(). and strerror()

The C programming language provides **perror()** and **strerror()** functions which can be used to display the text message associated with **errno**.

- The **perror()** function displays the string you pass to it, followed by a colon, a space, and then the textual representation of the current errno value.
- The **strerror()** function, which returns a pointer to the textual representation of the current errno value.

Let's try to simulate an error condition and try to open a file which does not exist. Here I'm using both the functions to show the usage, but you can use one or more ways of printing your errors. Second important point to note is that you should use **stderr** file stream to output all the errors.

```c showLineNumbers
#include <stdio.h>
#include <errno.h>
#include <string.h>

extern int errno ;

int main () {

   FILE * pf;
   int errnum;
   pf = fopen ("unexist.txt", "rb");
	
   if (pf == NULL) {
   
      errnum = errno;
      fprintf(stderr, "Value of errno: %d\n", errno);
      perror("Error printed by perror");
      fprintf(stderr, "Error opening file: %s\n", strerror( errnum ));
   } else {
   
      fclose (pf);
   }
   
   return 0;
}
```

When the above code is compiled and executed, it produces the following result −

```bash
Value of errno: 2
Error printed by perror: No such file or directory
Error opening file: No such file or directory
```

## Divide by Zero Errors

It is a common problem that at the time of dividing any number, programmers do not check if a divisor is zero and finally it creates a runtime error.

The code below fixes this by checking if the divisor is zero before dividing −

[ Live Demo](http://tpcg.io/lrHoIf)

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>

main() {

   int dividend = 20;
   int divisor = 0;
   int quotient;
 
   if( divisor == 0){
      fprintf(stderr, "Division by zero! Exiting...\n");
      exit(-1);
   }
   
   quotient = dividend / divisor;
   fprintf(stderr, "Value of quotient : %d\n", quotient );

   exit(0);
}
```

When the above code is compiled and executed, it produces the following result −

```bash
Division by zero! Exiting...
```

## Program Exit Status

It is a common practice to exit with a value of EXIT_SUCCESS in case of program coming out after a successful operation. Here, EXIT_SUCCESS is a macro and it is defined as 0.

If you have an error condition in your program and you are coming out then you should exit with a status EXIT_FAILURE which is defined as -1. So let's write above program as follows −

[ Live Demo](http://tpcg.io/wcYnG9)

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>

main() {

   int dividend = 20;
   int divisor = 5;
   int quotient;
 
   if( divisor == 0) {
      fprintf(stderr, "Division by zero! Exiting...\n");
      exit(EXIT_FAILURE);
   }
	
   quotient = dividend / divisor;
   fprintf(stderr, "Value of quotient : %d\n", quotient );

   exit(EXIT_SUCCESS);
}
```

When the above code is compiled and executed, it produces the following result −

```bash
Value of quotient : 4
```



## errno 原理



思考一个问题，每个系统调用失败后都会设置 errno，如果在多线程程序中，不同线程中的系统调用设置的 errno 会不会互相干扰呢？

如果 errno 是一个全局变量，答案是肯定的。如果真是这样的话，那系统调用的局限性也就太大了，总不能在每个系统调用之前都加锁保护吧。优秀的 Linux 肯定不会这么弱，那么，这个 errno 的问题又是怎么解决的呢？

根据 man 手册，要使用 errno，首先需要包含 errno.h 这个头文件。我们先看看 errno.h 里面有什么东西。

```c
#include <bits/errno.h>

/* The error code set by various library functions.  */
extern int *__errno_location (void) __THROW __attribute_const__;
# define errno (*__errno_location ())
```

根据官方提供的代码注释，bits/errno.h 中应该有一个 errno 的宏定义。如果没有，则会在外部变量中寻找一个名为 errno 的整数，它自然也就成了全局整数。否则，这个 errno 只是一个 per-thread 变量，每个线程都会拷贝一份。

关于 per-thread 变量更详细的信息，我们会在后面的课程中介绍。现在，你只需知道，这个 errno，每个线程都会独立拷贝一份，所以在多线程程序中使用它是不会相互影响的。

所以，在每个线程中获取和设置 errno 的时候，操作的是本线程内的一个变量，不会与其他线程相互干扰。



## errno 使用

errno 是一个包含在 `<errno.h>` 中的预定义的外部 int 变量，用于表示最近一个函数调用是否产生了错误。若为 0，则无错误，其它值均表示一类错误。

提示：需要先检查函数返回值，再检查 errno 的值。

### 查看 errno

perror() 和 strerror() 函数可以把 errno 的值转化为有意义的字符输出。

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <errno.h>
#include <string.h>

int main(void)
{
    errno = 0; // 先清零
    opendir("/tmp/getiot");

    /* 用法1：直接读取errno的值 */
    printf("%d\n", errno);

    /* 用法2：使用perror函数，把error的值转化为有意义的字符提示 */
    if(errno != 0){
        perror("opendir: ");
    }

    /* 用法3：类似用法2，但使用strerror函数 */
    if(errno != 0){
        printf("%s\n", strerror(errno));
    }

    return 0;
}
```

执行

```bash
2
opendir: : No such file or directory
No such file or directory
```



### 设置 errno



### 列出所有

以下程序用于显示所有的错误代码含义（经测试，目前的错误代码从0-133，其余未使用）

```c showLineNumbers
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
    for(int i = 0; i < 140; i++) {
        printf("%4d: %s\n", i, strerror(i));
    }

    return 0;
}
```

执行

```bash
   0: Success
   1: Operation not permitted
   2: No such file or directory
   3: No such process
   4: Interrupted system call
   5: Input/output error
   6: No such device or address
   7: Argument list too long
   8: Exec format error
   9: Bad file descriptor
  10: No child processes
  11: Resource temporarily unavailable
  12: Cannot allocate memory
  13: Permission denied
  14: Bad address
  15: Block device required
  16: Device or resource busy
  17: File exists
  18: Invalid cross-device link
  19: No such device
  20: Not a directory
  21: Is a directory
  22: Invalid argument
  23: Too many open files in system
  24: Too many open files
  25: Inappropriate ioctl for device
  26: Text file busy
  27: File too large
  28: No space left on device
  29: Illegal seek
  30: Read-only file system
  31: Too many links
  32: Broken pipe
  33: Numerical argument out of domain
  34: Numerical result out of range
  35: Resource deadlock avoided
  36: File name too long
  37: No locks available
  38: Function not implemented
  39: Directory not empty
  40: Too many levels of symbolic links
  41: Unknown error 41
  42: No message of desired type
  43: Identifier removed
  44: Channel number out of range
  45: Level 2 not synchronized
  46: Level 3 halted
  47: Level 3 reset
  48: Link number out of range
  49: Protocol driver not attached
  50: No CSI structure available
  51: Level 2 halted
  52: Invalid exchange
  53: Invalid request descriptor
  54: Exchange full
  55: No anode
  56: Invalid request code
  57: Invalid slot
  58: Unknown error 58
  59: Bad font file format
  60: Device not a stream
  61: No data available
  62: Timer expired
  63: Out of streams resources
  64: Machine is not on the network
  65: Package not installed
  66: Object is remote
  67: Link has been severed
  68: Advertise error
  69: Srmount error
  70: Communication error on send
  71: Protocol error
  72: Multihop attempted
  73: RFS specific error
  74: Bad message
  75: Value too large for defined data type
  76: Name not unique on network
  77: File descriptor in bad state
  78: Remote address changed
  79: Can not access a needed shared library
  80: Accessing a corrupted shared library
  81: .lib section in a.out corrupted
  82: Attempting to link in too many shared libraries
  83: Cannot exec a shared library directly
  84: Invalid or incomplete multibyte or wide character
  85: Interrupted system call should be restarted
  86: Streams pipe error
  87: Too many users
  88: Socket operation on non-socket
  89: Destination address required
  90: Message too long
  91: Protocol wrong type for socket
  92: Protocol not available
  93: Protocol not supported
  94: Socket type not supported
  95: Operation not supported
  96: Protocol family not supported
  97: Address family not supported by protocol
  98: Address already in use
  99: Cannot assign requested address
 100: Network is down
 101: Network is unreachable
 102: Network dropped connection on reset
 103: Software caused connection abort
 104: Connection reset by peer
 105: No buffer space available
 106: Transport endpoint is already connected
 107: Transport endpoint is not connected
 108: Cannot send after transport endpoint shutdown
 109: Too many references: cannot splice
 110: Connection timed out
 111: Connection refused
 112: Host is down
 113: No route to host
 114: Operation already in progress
 115: Operation now in progress
 116: Stale file handle
 117: Structure needs cleaning
 118: Not a XENIX named type file
 119: No XENIX semaphores available
 120: Is a named type file
 121: Remote I/O error
 122: Disk quota exceeded
 123: No medium found
 124: Wrong medium type
 125: Operation canceled
 126: Required key not available
 127: Key has expired
 128: Key has been revoked
 129: Key was rejected by service
 130: Owner died
 131: State not recoverable
 132: Operation not possible due to RF-kill
 133: Memory page has hardware error
 134: Unknown error 134
 135: Unknown error 135
 136: Unknown error 136
 137: Unknown error 137
 138: Unknown error 138
 139: Unknown error 139
```

定义 include/uapi/asm-generic/errno-base.h

```c showLineNumbers
/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
#ifndef _ASM_GENERIC_ERRNO_BASE_H
#define _ASM_GENERIC_ERRNO_BASE_H

#define EPERM            1      /* Operation not permitted */
#define ENOENT           2      /* No such file or directory */
#define ESRCH            3      /* No such process */
#define EINTR            4      /* Interrupted system call */
#define EIO              5      /* I/O error */
#define ENXIO            6      /* No such device or address */
#define E2BIG            7      /* Argument list too long */
#define ENOEXEC          8      /* Exec format error */
#define EBADF            9      /* Bad file number */
#define ECHILD          10      /* No child processes */
#define EAGAIN          11      /* Try again */
#define ENOMEM          12      /* Out of memory */
#define EACCES          13      /* Permission denied */
#define EFAULT          14      /* Bad address */
#define ENOTBLK         15      /* Block device required */
#define EBUSY           16      /* Device or resource busy */
#define EEXIST          17      /* File exists */
#define EXDEV           18      /* Cross-device link */
#define ENODEV          19      /* No such device */
#define ENOTDIR         20      /* Not a directory */
#define EISDIR          21      /* Is a directory */
#define EINVAL          22      /* Invalid argument */
#define ENFILE          23      /* File table overflow */
#define EMFILE          24      /* Too many open files */
#define ENOTTY          25      /* Not a typewriter */
#define ETXTBSY         26      /* Text file busy */
#define EFBIG           27      /* File too large */
#define ENOSPC          28      /* No space left on device */
#define ESPIPE          29      /* Illegal seek */
#define EROFS           30      /* Read-only file system */
#define EMLINK          31      /* Too many links */
#define EPIPE           32      /* Broken pipe */
#define EDOM            33      /* Math argument out of domain of func */
#define ERANGE          34      /* Math result not representable */

#endif
```





## 参考

- [errno的基本用法_jediael_lu的专栏-CSDN博客_打印errno](https://blog.csdn.net/jediael_lu/article/details/8589194)
- [errno 的多线程问题_Coulson的博客-CSDN博客_errno 多线程](https://blog.csdn.net/weixin_35695879/article/details/89530417)
- [errno全局变量及使用细则，C语言errno全局变量完全攻略 (biancheng.net)](http://c.biancheng.net/c/errno/)

