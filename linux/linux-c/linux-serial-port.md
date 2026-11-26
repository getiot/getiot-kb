---
sidebar_position: 42
authors: [luhuadong]
---

# Linux 串口编程



Linux 串口编程主要包含以下几步：

1. 打开串口
2. 配置串口
3. 读写串口
4. 关闭串口



## 打开串口

由于串口在 Linux 中被认为是一个文件，所以在操作之前应该先打开它。 

```c showLineNumbers
#include <fcntl.h>
int fd = open("/dev/ttyS0", O_RDWR | O_NOCTTY);
```

说明：

1. 在 Linux 中，通过串口终端设备文件访问串口设备，比如 /dev/ttyS0、/dev/ttyUSB0、/dev/ttyACM0；
2. 调用 open() 函数打开设备，open 是系统函数，负责打开某个节点。上面代码以可读可写的方式，尝试打开 `/dev/ttyS0` 这个串口，如果打开成功，返回一个非负值，这个值表示串口描述符，若失败，返回一个负数，即错误码。

open 标志

| 标志     | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| O_RDWR   | 可读可写                                                     |
| O_NOCTTY | This means that a terminal device is opened and the program will not become the control terminal of the port. If this flag is not used, a task input (eg: keyboard stop signal, etc.) will affect the process. |
| O_NDELAY | Indicates that you do not care about the state of the DCD signa l line (whether the other end of the port is activated or stopped). |

打开串行模块有那个和一些组件。 

1 > 调用open()函数打开串口，获取串口的设备文件描述符 

2 > 获取串口状态并判断是否被阻塞 

3 > 测试打开的文件描述符是终端设备吗？ 

示例：

```c showLineNumbers
/*****************************************************************
* Name: * UART0_Open
* Function: Open the serial port and return the description of the serial device file
* Entry parameter: fd File descriptor port: serial password (ttyS0,ttyS1,ttyS2)
* Export parameter: * Correct return to 1, error return to 0
*****************************************************************/

int UART0_Open(int fd, char* port)
{
    fd = open( port, O_RDWR|O_NOCTTY|O_NDELAY);
    if (FALSE == fd) {
        perror("Can't Open Serial Port");
        return(FASLE);
    }
    
    // Determine whether the state of the serial port is blocked or not.
    if(fcntl(fd, F_SETFL, 0) < 0) {
        printf("fcntl failed!\n");
        return(FALSE);
    }
    else {
        printf("fcntl=%d\n",fcntl(fd, F_SETFL,0));
    }
    
    //test Is it a terminal device?
    if(0 == isatty(STDIN_FILENO)) {
        
        printf("standard input is not a terminal device\n");
        return(FALSE);
    }
    else {
        printf("isatty success!\n");
    }
    printf("fd->open=%d\n",fd);
    return fd;
}
```





## 配置串口

成功打开串口后，还需要配置串口，设置波特率等参数。

```c showLineNumbers
int openUart()
{
    int fd = open("/dev/ttyS0", O_RDWR | O_NOCTTY);
    struct termios oldtio = { 0 };
    struct termios newtio = { 0 };
    tcgetattr(fd, &oldtio);
    // 设置波特率为115200
    newtio.c_cflag = B115200 | CS8 | CLOCAL | CREAD;
    newtio.c_iflag = 0; // IGNPAR | ICRNL
    newtio.c_oflag = 0;
    newtio.c_lflag = 0; // ICANON
    newtio.c_cc[VTIME] = 0;
    newtio.c_cc[VMIN] = 1;
    tcflush(fd, TCIOFLUSH);
    tcsetattr(fd, TCSANOW, &newtio);

    // 设置为非阻塞模式，这个在读串口的时候会用到
    fcntl(fd, F_SETFL, O_NONBLOCK);
    return fd;
}
```

以上是常见的串口配置，波特率 115200，8个数据位，1个停止位，无校验。

termios 结构体

```c showLineNumbers
#include <termios.h>

struct termios {
	tcflag_t c_iflag;
	tcflag_t c_oflag;
	tcflag_t c_cflag;
	tcflag_t c_lflag;
	cc_t c_cc[NCCS];
	speed_t c_ispeed;
	speed_t c_ospeed;
};
```





## 读写串口

### 从串口读取

```c showLineNumbers
#include <fcntl.h>
unsigned char buffer[1024] = {0};
int ret = read(fd, buffer, sizeof(buffer));
```

`read` 是系统函数，它提供了读串口的功能，该函数需要三个参数：

- 第一个参数 是串口描述符，即打开串口步骤中 `open` 函数的返回值；
- 第二个参数 是缓冲区指针，用于保存读取的串口数据；
- 第三个参数 是缓冲区长度，也表示本次最多能读取多少个字节。

调用该函数，如果返回值大于0，表示有正确收到串口数据，且返回值等于读取到数据量的字节数。如果返回值小于或等于0， 表示有错误或者暂时没读到数据。

注意：`read`函数只是顺序读取串口收到的数据流，但不能保证一次就读取完整的数据。例如，短时间内，串口收到了 1000 个字节的数据，缓冲区的长度为 1024，虽然 1024 > 1000，但可能我们第一次 read 后仅读取了一部分数据，所以我们需要多次 read，才能保证数据读取完整。



### 往串口发送

```c showLineNumbers
#include <fcntl.h>
unsigned char buffer[4] = {0};
buffer[0] = 0x01;
buffer[1] = 0x02;
buffer[2] = 0x03;
buffer[3] = 0x04;
int ret = write(fd, buffer, sizeof(buffer));
```

`write` 是系统函数，它提供了发送串口的功能，该函数需要三个参数：

- 第一个参数 是串口描述符，即打开串口步骤中 `open` 函数的返回值；
- 第二个参数 是待发送缓冲区指针；
- 第三个参数 是待发送缓冲区长度。

调用该函数，如果返回值大于0，且返回值等于传递的第三个参数，表示发送成功。如果返回值小于或等于0，表示异常。



## 关闭串口

```c showLineNumbers
#include <fcntl.h>
close(fd);
```

`close` 是系统函数，需要的参数是串口描述符，即打开串口步骤中 `open` 函数的返回值。



## 综合使用

以下是一个简单的 Linux 串口编程的完整例子，上面提到的几个基本步骤都有用到。

```c showLineNumbers
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char** argv)
{
    int fd = open("/dev/ttyS0", O_RDWR | O_NOCTTY);
    if (fd < 0) {
        //打开串口失败，退出
        return -1;
    } 

    struct termios oldtio = { 0 };
    struct termios newtio = { 0 };
    tcgetattr(fd, &oldtio);

    newtio.c_cflag = B115200 | CS8 | CLOCAL | CREAD;
    newtio.c_iflag = 0; // IGNPAR | ICRNL
    newtio.c_oflag = 0;
    newtio.c_lflag = 0; // ICANON
    newtio.c_cc[VTIME] = 0;
    newtio.c_cc[VMIN] = 1;
    tcflush(fd, TCIOFLUSH);
    tcsetattr(fd, TCSANOW, &newtio);
    //设置为非阻塞模式
    fcntl(fd, F_SETFL, O_NONBLOCK);

    while (true) {
        unsigned char buffer[1024] = {0};
        int ret = read(fd, buffer, sizeof(buffer));
        if (ret > 0) {
            //依次将读取到的数据输出到日志
            for (int i = 0; i < ret; ++i)
                LOGD("收到%02x", buffer[i]);

            //当收到数据时，再将收到的数据原样发送
            int n = write(fd, buffer, ret);
            if (n != ret)
                LOGD("发送失败");

            //当收到0xFF时，跳出循环
            if (buffer[0] == 0xFF)
                break;
        } else {
            //没收到数据时，休眠50ms，防止过度消耗cpu
            usleep(1000 * 50);
        }
    }
    close(fd);
    return 0;
}
```





