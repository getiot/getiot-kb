---
sidebar_position: 10
authors: [luhuadong]
---

# libmodbus 软件库



libmodbus 是一个优秀的跨平台 Modbus 开源软件库，遵循 LGPL-2.1 许可证。该库用 C 编写，支持 RTU（串行）和 TCP（以太网）通信模式，可根据 Modbus 协议发送和接收数据。

- 项目网址：[https://libmodbus.org](https://libmodbus.org)
- GitHub 仓库：[https://github.com/stephane/libmodbus](https://github.com/stephane/libmodbus)



## 软件框架

libmodbus 的目录结构如下图所示。其中，核心代码位于 src 目录，测试代码位于 tests 目录。另外，doc 目录存放 API 说明文档，m4 目录存放 GNU m4 文件。

![](https://static.getiot.tech/libmodbus-contents.png#center)

src 目录的内容及说明如下：

```shell
├── Makefile.am          # AutoTool 配置文件，用于生成 Makefile
├── modbus.c             # 实现 Modbus 协议层，定义消息发送和接收函数、各功能码对应的函数
├── modbus-data.c        # 实现数据处理的通用函数，如大小端、位交换等函数
├── modbus.h             # libmodbus 对外暴露的 API 头文件
├── modbus-private.h     # 内部使用的数据结构和函数定义
├── modbus-rtu.c         # 通信层实现，RTU 模式相关的函数定义（串口设置、连接、发送、接收等）
├── modbus-rtu.h         # RTU 模式对外提供的各 API 头文件
├── modbus-rtu-private.h # RTU 模式的私有定义
├── modbus-tcp.c         # 通信层实现，TCP 模式相关的函数定义（网络设置、连接、发送、接收等）
├── modbus-tcp.h         # TCP 模式对外提供的各 API 头文件
├── modbus-tcp-private.h # TCP 模式的私有定义
├── modbus-version.h.in  # 版本定义文件
└── win32                # 定义了在 Windows 下使用 Visual Studio 编译时的项目文件
```



## 类型与数据结构

### 常量定义

在 modbus.h 文件中，通过宏定义了 libmodbus 库目前支持的所有 Modbus 公共功能码。

```c showLineNumbers
/* Modbus function codes */
#define MODBUS_FC_READ_COILS                0x01
#define MODBUS_FC_READ_DISCRETE_INPUTS      0x02
#define MODBUS_FC_READ_HOLDING_REGISTERS    0x03
#define MODBUS_FC_READ_INPUT_REGISTERS      0x04
#define MODBUS_FC_WRITE_SINGLE_COIL         0x05
#define MODBUS_FC_WRITE_SINGLE_REGISTER     0x06
#define MODBUS_FC_READ_EXCEPTION_STATUS     0x07
#define MODBUS_FC_WRITE_MULTIPLE_COILS      0x0F
#define MODBUS_FC_WRITE_MULTIPLE_REGISTERS  0x10
#define MODBUS_FC_REPORT_SLAVE_ID           0x11
#define MODBUS_FC_MASK_WRITE_REGISTER       0x16
#define MODBUS_FC_WRITE_AND_READ_REGISTERS  0x17

#define MODBUS_BROADCAST_ADDRESS    0
```

除此之外，modbus.h 文件中还定义了各种常量。例如 Modbus 广播地址、最大可读/可写线圈数量、最大可读/可写寄存器数量，以及各种异常码。

```c showLineNumbers
/* Protocol exceptions */
enum {
    MODBUS_EXCEPTION_ILLEGAL_FUNCTION = 0x01,  /* 非法的功能码 */
    MODBUS_EXCEPTION_ILLEGAL_DATA_ADDRESS,     /* 非法的数据地址 */
    MODBUS_EXCEPTION_ILLEGAL_DATA_VALUE,       /* 非法的数据值 */
    MODBUS_EXCEPTION_SLAVE_OR_SERVER_FAILURE,  /* 从站设备故障 */
    MODBUS_EXCEPTION_ACKNOWLEDGE,              /* ACK 异常 */
    MODBUS_EXCEPTION_SLAVE_OR_SERVER_BUSY,     /* 从站设备忙 */
    MODBUS_EXCEPTION_NEGATIVE_ACKNOWLEDGE,     /* 否定应答 */
    MODBUS_EXCEPTION_MEMORY_PARITY,            /* 内存奇偶校验错误 */
    MODBUS_EXCEPTION_NOT_DEFINED,              /* 未定义 */
    MODBUS_EXCEPTION_GATEWAY_PATH,             /* 网关路径不可用 */
    MODBUS_EXCEPTION_GATEWAY_TARGET,           /* 目标设备未能回应 */
    MODBUS_EXCEPTION_MAX
};
```



### modbus_t 结构体

modbus_t 是 libmodbus 中最基本的数据结构，它是结构体 _modbus 的别名。

```c showLineNumbers
typedef struct _modbus modbus_t;
```

具体定义位于 modbus-private.h 头文件。

```c showLineNumbers
struct _modbus {
    int slave;  /* 从站设备地址 */
    int s;      /* TCP 模式下为 socket 套接字，RTU 模式下为串口文件描述符 */
    int debug;                          /* 是否启用 Debug 模式 */
    int error_recovery;                 /* 错误恢复模式 */
    struct timeval response_timeout;    /* 响应超时设置 */
    struct timeval byte_timeout;        /* 字节超时设置 */
    struct timeval indication_timeout;  /* 指示超时设置 */
    const modbus_backend_t *backend;    /* Modbus 后端，包括 TCP、RTU 两种模式 */
    void *backend_data;                 /* Modbus 后端特殊配置数据 */
};
```



### modbus_backend_t 结构体

modbus_backend_t 结构体包含了一系列的函数指针，例如数据通道的连接、关闭，消息的发送、接收等等。

```c showLineNumbers
typedef struct _modbus_backend {
    unsigned int backend_type;
    unsigned int header_length;
    unsigned int checksum_length;
    unsigned int max_adu_length;
    int (*set_slave) (modbus_t *ctx, int slave);
    int (*build_request_basis) (modbus_t *ctx, int function, int addr, int nb, uint8_t *req);
    int (*build_response_basis) (sft_t *sft, uint8_t *rsp);
    int (*prepare_response_tid) (const uint8_t *req, int *req_length);
    int (*send_msg_pre) (uint8_t *req, int req_length);
    ssize_t (*send) (modbus_t *ctx, const uint8_t *req, int req_length);
    int (*receive) (modbus_t *ctx, uint8_t *req);
    ssize_t (*recv) (modbus_t *ctx, uint8_t *rsp, int rsp_length);
    int (*check_integrity) (modbus_t *ctx, uint8_t *msg, const int msg_length);
    int (*pre_check_confirmation) (modbus_t *ctx, const uint8_t *req, const uint8_t *rsp, int rsp_length);
    int (*connect) (modbus_t *ctx);
    void (*close) (modbus_t *ctx);
    int (*flush) (modbus_t *ctx);
    int (*select) (modbus_t *ctx, fd_set *rset, struct timeval *tv, int msg_length);
    void (*free) (modbus_t *ctx);
} modbus_backend_t;
```

其中，backend_type 后端的类型有两种，函数指针根据后端的不同而不同。在 modbus-rtu.c 和 modbus-tcp.c 中进行指定。

```c showLineNumbers
typedef enum {
    _MODBUS_BACKEND_TYPE_RTU=0,
    _MODBUS_BACKEND_TYPE_TCP
} modbus_backend_type_t;
```



### modbus_mapping_t 结构体

还有一个重要的结构体是 modbus_mapping_t，定义在 modbus.h 头文件中。该结构体定义了 Modbus 中的 4 种寄存器，并进行了内存数据映射，以方便快速访问和读取各寄存器的值。

```c showLineNumbers
typedef struct _modbus_mapping_t {
    int nb_bits;                    /* 线圈状态寄存器的数量 */
    int start_bits;                 /* 线圈状态寄存器的起始地址 */
    int nb_input_bits;              /* 离散输入寄存器的数量 */
    int start_input_bits;           /* 离散输入寄存器的起始地址 */
    int nb_input_registers;         /* 输入寄存器的数量 */
    int start_input_registers;      /* 输入寄存器的起始地址 */
    int nb_registers;               /* 保持寄存器的数量 */
    int start_registers;            /* 保持寄存器的起始地址 */
    uint8_t *tab_bits;              /* 指向线圈状态寄存器的值 */
    uint8_t *tab_input_bits;        /* 指向离散输入寄存器的值 */
    uint16_t *tab_input_registers;  /* 指向输入寄存器的值 */
    uint16_t *tab_registers;        /* 指向保持寄存器的值 */
} modbus_mapping_t;
```

由于 C 语言基本数据类型中不存在 bit 类型，因此在 modbus_mapping_t 中使用 uint8_t 定义，而字操作对应 2 个字节（16 bits），因此使用 uint16_t 定义。



## API 说明

modbus.h 的接口函数大致可以分为 3 类：辅助接口函数、功能接口函数、数据处理相关函数。另外，在 modbus-rtu.h 和 modbus-tcp.h 中还定义了 RTU 和 TCP 模式的关联接口函数。

### 辅助接口函数

#### 设置从站地址

```c showLineNumbers
MODBUS_API int modbus_set_slave(modbus_t* ctx, int slave);
```

该函数用于设置 Modbus 从站地址，但是在不同传输方式下有不同的意义。

- 在 RTU 模式下，如果 libmodbus 应用于主站设备端，则相当于定义远端设备的 ID；如果应用于从站设备端，则相当于定义自身设备 ID。此时 slave 的取值范围为 0~247，其中 0 表示广播地址。
- 在 TCP 模式下，通常不需要使用该函数，默认值为 0xFF。只要在某些特殊场合，例如串行 Modbus 设备转换为 TCP 模式传输的情况下，才需要使用该函数。此时 slave 的取值范围与 RTU 模式一致。

#### 设置错误恢复模式

```c showLineNumbers
MODBUS_API int modbus_set_error_recovery(modbus_t *ctx, modbus_error_recovery_mode error_recovery);
```

该函数用于在连接失败或传输异常时，设置错误恢复模式。有三种错误恢复模式可选：

```c showLineNumbers
typedef enum
{
    MODBUS_ERROR_RECOVERY_NONE      = 0,      /* 不恢复 */
    MODBUS_ERROR_RECOVERY_LINK      = (1<<1), /* 链路层恢复 */
    MODBUS_ERROR_RECOVERY_PROTOCOL  = (1<<2)  /* 协议层恢复 */
} modbus_error_recovery_mode;
```

默认设置为不恢复模式，由应用程序自身处理错误；如果设置为链路层恢复，则由 libmodbus 内部自动尝试进行断开/连接；如果设置为协议层恢复，则在传输数据 CRC 错误或功能码错误时清除数据。

#### 设置 socket 或串口句柄

```c showLineNumbers
MODBUS_API int modbus_set_socket(modbus_t *ctx, int s);
```

该函数设置当前 socket 或串口句柄，主要用于多客户端连接到单一服务器场合。

#### 获取或设置超时

下面两个函数用于获取或设置响应超时，注意时间单位分别是秒和微秒。

```c showLineNumbers
MODBUS_API int modbus_get_response_timeout(modbus_t *ctx, uint32_t *to_sec, uint32_t *to_usec);
MODBUS_API int modbus_set_response_timeout(modbus_t *ctx, uint32_t to_sec, uint32_t to_usec);
```

下面两个函数用于获取或设置连续字节之间的超时时间，注意时间单位分别是秒和微秒。

```c showLineNumbers
MODBUS_API int modbus_get_byte_timeout(modbus_t *ctx, uint32_t *to_sec, uint32_t *to_usec);
MODBUS_API int modbus_set_byte_timeout(modbus_t *ctx, uint32_t to_sec, uint32_t to_usec);
```

#### 获取报文头长度

```c showLineNumbers
MODBUS_API int modbus_get_header_length(modbus_t *ctx);
```

#### 建立或关闭 Modbus 连接

```c showLineNumbers
MODBUS_API int modbus_connect(modbus_t *ctx);
MODBUS_API void modbus_close(modbus_t *ctx);
```

这两个函数在 RTU 和 TCP 模式下有不同意义。

- 在 RTU 模式下，modbus_connect 所做的操作是设置串口参数并打开串口，modbus_close 则关闭串口。
- 在 TCP 模式下，modbus_connect 所做的操作是设置 TCP socket 参数并进行连接，modbus_close 则关闭该 socket。

#### 释放 Modbus 对象

```c showLineNumbers
MODBUS_API void modbus_free(modbus_t *ctx);
```

该函数用于释放 modbus_t 结构体占用的内存，在应用程序结束之前，一定记得调用此函数。对应的内存申请操作位于 modbus_new_rtu 和 modbus_new_tcp 接口函数。

#### Debug 函数

```c showLineNumbers
MODBUS_API int modbus_set_debug(modbus_t *ctx, int flag);
MODBUS_API const char *modbus_strerror(int errnum);
```

modbus_set_debug 函数用于设置 DEBUG 模式，如果参数 flag 为 TRUE 则进入 DEBUG 模式，如果为 FALSE 则切换为非 DEBUG 模式。在 DEBUG 模式下，所有通信数据将按十六进制方式打印出来，以方便调试。

modbus_strerror 函数用于获取当前错误字符串。



### 功能接口函数

下面四个函数分别对应功能码 0x01、0x02、0x03 和 0x04，即读取线圈状态寄存器、读取离散量输入值、读取保持寄存器、读取输入寄存器。这几个函数的参数含义与用法类似，addr 为读取的起始地址，nb 为读取的个数，dest 存放读取的值（需要由应用程序保证空间足够大）。

```c showLineNumbers
MODBUS_API int modbus_read_bits(modbus_t *ctx, int addr, int nb, uint8_t *dest);
MODBUS_API int modbus_read_input_bits(modbus_t *ctx, int addr, int nb, uint8_t *dest);
MODBUS_API int modbus_read_registers(modbus_t *ctx, int addr, int nb, uint16_t *dest);
MODBUS_API int modbus_read_input_registers(modbus_t *ctx, int addr, int nb, uint16_t *dest);
```

下面四个函数分别对应功能码 0x05、0x06、0x0F 和 0x10，即写入单个线圈、写入单个保持寄存器、写入多个线圈、写入多个保持寄存器。

```c showLineNumbers
MODBUS_API int modbus_write_bit(modbus_t *ctx, int coil_addr, int status);
MODBUS_API int modbus_write_register(modbus_t *ctx, int reg_addr, const uint16_t value);
MODBUS_API int modbus_write_bits(modbus_t *ctx, int addr, int nb, const uint8_t *data);
MODBUS_API int modbus_write_registers(modbus_t *ctx, int addr, int nb, const uint16_t *data);
```

下面函数对应功能码 0x11，即报告从站 ID。

```c showLineNumbers
MODBUS_API int modbus_report_slave_id(modbus_t *ctx, int max_dest, uint8_t *dest);
```



### 数据处理相关函数

为了方便数据处理，modbus.h 中还定义了一系列数据处理宏，例如获取数据的高低字节宏定义。

```c showLineNumbers
#define MODBUS_GET_HIGH_BYTE(data) (((data) >> 8) & 0xFF)
#define MODBUS_GET_LOW_BYTE(data) ((data) & 0xFF)
```

对于浮点数等多字节数据，为了解决大小端存储的问题，还定义了下面一系列特殊函数。

```c showLineNumbers
MODBUS_API float modbus_get_float(const uint16_t *src);
MODBUS_API float modbus_get_float_abcd(const uint16_t *src);
MODBUS_API float modbus_get_float_dcba(const uint16_t *src);
MODBUS_API float modbus_get_float_badc(const uint16_t *src);
MODBUS_API float modbus_get_float_cdab(const uint16_t *src);

MODBUS_API void modbus_set_float(float f, uint16_t *dest);
MODBUS_API void modbus_set_float_abcd(float f, uint16_t *dest);
MODBUS_API void modbus_set_float_dcba(float f, uint16_t *dest);
MODBUS_API void modbus_set_float_badc(float f, uint16_t *dest);
MODBUS_API void modbus_set_float_cdab(float f, uint16_t *dest);
```



### RTU 关联接口函数

RTU 关联接口函数在 modbus-rtu.h 头文件中声明，但应用程序调用时只需要包含 modbus.h 头文件即可，因为在 modbus.h 末尾已经包含 modbus-rtu.h 和 modbus-tcp.h 两部分。

```c showLineNumbers
#include "modbus-tcp.h"
#include "modbus-rtu.h"
```

首先是 RTU 类型的 modbus_t 结构体创建函数。

```c showLineNumbers
MODBUS_API modbus_t* modbus_new_rtu(const char *device, int baud, char parity, int data_bit, int stop_bit);
```

该函数的参数说明如下：

| 参数     | 说明                                                         |
| -------- | ------------------------------------------------------------ |
| device   | 串口设备名称，如 "COM1"、"/dev/ttyUSB0" 等                   |
| baud     | 波特率，如 9600、19200、115200 等                            |
| parity   | 奇偶校验位，取值范围为：'N' 无奇偶校验、'E' 偶校验、'O' 奇校验 |
| data_bit | 数据位长度，取值范围为：5、6、7 或 8                         |
| stop_bit | 停止位长度，取值范围为：1 或 2                               |

下面是设置和获取串口模式函数，模式 mode 的值可以是 MODBUS_RTU_RS232 或 MODBUS_RTU_RS485。

```c showLineNumbers
MODBUS_API int modbus_rtu_set_serial_mode(modbus_t *ctx, int mode);
MODBUS_API int modbus_rtu_get_serial_mode(modbus_t *ctx);
```

以下函数只适用于 Linux 操作系统，RTS 是 Request To Send 的缩写，用来标明接收设备有没有准备好接收数据，也就是流控。

```c showLineNumbers
MODBUS_API int modbus_rtu_set_rts(modbus_t *ctx, int mode);
MODBUS_API int modbus_rtu_get_rts(modbus_t *ctx);
MODBUS_API int modbus_rtu_set_custom_rts(modbus_t *ctx, void (*set_rts) (modbus_t *ctx, int on));
MODBUS_API int modbus_rtu_set_rts_delay(modbus_t *ctx, int us);
MODBUS_API int modbus_rtu_get_rts_delay(modbus_t *ctx);
```



### TCP 关联接口函数

创建 TCP 类型的 modbus_t 结构体，其中参数 ip_address 为 IP 地址，port 为端口号。

```c showLineNumbers
MODBUS_API modbus_t* modbus_new_tcp(const char *ip_address, int port);
```

创建并监听一个 TCP 套接字，参数 nb_connection 代表最大的监听数量。

```c showLineNumbers
MODBUS_API int modbus_tcp_listen(modbus_t *ctx, int nb_connection);
```

接收一个 TCP 类型的连接请求，如果成功将进入数据接收状态。

```c showLineNumbers
MODBUS_API int modbus_tcp_accept(modbus_t *ctx, int *s);
```

另外，还有以下 3 个用于 TCP 独立协议（Protocol Independent）的接口函数。

```c showLineNumbers
MODBUS_API modbus_t* modbus_new_tcp_pi(const char *node, const char *service);
MODBUS_API int modbus_tcp_pi_listen(modbus_t *ctx, int nb_connection);
MODBUS_API int modbus_tcp_pi_accept(modbus_t *ctx, int *s);
```



## 安装

下面介绍如何从源码编译、安装 libmodbus 库。

下载源代码

```shell
git clone git@github.com:stephane/libmodbus.git
```

切换到 libmodbus 目录

```shell
cd libmodbus/
```

生成配置

```shell
./autogen.sh
```

配置项目（按默认配置，前缀 prefix 为 /usr/local）

```shell
./configure
```

编译项目

```shell
make
```

安装到系统

```shell
sudo make install
```

安装完成后，可以在 /usr/local/lib/ 目录找到 libmodbus 库

```shell
$ ls -l /usr/local/lib/libmodbus*
-rwxr-xr-x 1 root root    935 7月  16 09:11 /usr/local/lib/libmodbus.la
lrwxrwxrwx 1 root root     18 7月  16 09:11 /usr/local/lib/libmodbus.so -> libmodbus.so.5.1.0
lrwxrwxrwx 1 root root     18 7月  16 09:11 /usr/local/lib/libmodbus.so.5 -> libmodbus.so.5.1.0
-rwxr-xr-x 1 root root 201904 7月  16 09:11 /usr/local/lib/libmodbus.so.5.1.0
```

在 /usr/local/include/modbus/ 目录找到 libmodbus 的相关头文件

```shell
$ tree /usr/local/include/modbus/
/usr/local/include/modbus/
├── modbus.h
├── modbus-rtu.h
├── modbus-tcp.h
└── modbus-version.h

0 directories, 4 files
```

为了保证程序运行时能链接到 libmodbus 库，执行下列命令更新共享库缓存列表

```shell
sudo ldconfig
```



## 测试

下面是一个简单的 Modbus TCP 客户端示例。

```c showLineNumbers
#include <stdio.h>
#include <modbus.h>

int main(void) {
  modbus_t *mb;
  uint16_t tab_reg[32];

  mb = modbus_new_tcp("127.0.0.1", 1502);
  modbus_connect(mb);

  /* Read 5 registers from the address 0 */
  modbus_read_registers(mb, 0, 5, tab_reg);

  modbus_close(mb);
  modbus_free(mb);
}
```

实际上，tests 目录为我们提供了一些测试代码，当我们完成上一步的编译安装之后，可以在 tests 目录中找到 unit-test-server 和 unit-test-client 测试程序。

打开两个终端，分别运行服务端和客户端测试程序。

```shell
./unit-test-server
./unit-test-client
```

这时候，可以在终端看到 Modbus TCP 客户端与服务器端的通信过程。

```shell
Connecting to 127.0.0.1:1502
** UNIT TESTING **
1/1 No response timeout modification on connect: OK

TEST WRITE/READ:
[00][01][00][00][00][06][FF][05][01][30][FF][00]
Waiting for a confirmation...
<00><01><00><00><00><06><FF><05><01><30><FF><00>
1/2 modbus_write_bit: OK
[00][02][00][00][00][06][FF][01][01][30][00][01]
Waiting for a confirmation...
<00><02><00><00><00><04><FF><01><01><01>
2/2 modbus_read_bits: OK
OK
[00][03][00][00][00][0C][FF][0F][01][30][00][25][05][CD][6B][B2][0E][1B]
Waiting for a confirmation...
<00><03><00><00><00><06><FF><0F><01><30><00><25>
1/2 modbus_write_bits: OK
[00][04][00][00][00][06][FF][01][01][30][00][25]
Waiting for a confirmation...
...
```

