---
sidebar_position: 17
slug: /data-structure-alignment-and-endianness
---

# 大小端和字节对齐



## 问题背景

在嵌入式开发中，我们经常需要处理各种网络协议，比如我们自定义一套下位机（Sensor）和上位机的通信协议，它们可能通过以太网、串口（UART）、SPI、I2C 等总线进行传输，实现多端通信。

![](https://static.getiot.tech/Sensor-to-Host-Communication.png#center)

在 C/C++ 编程中，通常会使用 struct 结构体或者 class 类来定义协议格式。举个例子，假设我们的协议需要传输 Sensor 采集的数据到上位机进行显示，那么我们会将数据塞到 Packet 数据包中，为了增加数据包的可解释性和安全性，我们通常还会为其增加数据包头（Header）和包尾（Tail）。现在，假设我们制定了如下协议：

| 区域       | 字段           | 字节    |
| ---------- | -------------- | ------- |
| **Header** | Distance       | 2 字节  |
|            | Azimuth        | 2 字节  |
|            | Elevation      | 2 字节  |
|            | Intensity      | 1 字节  |
|            | Reserved       | 2 字节  |
| **Block**  | Unit1          | 9 字节  |
|            | Unit2          | 9 字节  |
|            | ......         | ......  |
|            | Unit32         | 9 字节  |
| **Tail**   | CRC            | 4 字节  |
|            | FunctionSafety | 17 字节 |

其中包头（Header）部分一共 9 个字节；包体（Block）一共包含 32 个 Unit 单元，每个单元占用 9 个字节，共计 288 字节；包尾（Tail）包含 CRC 校验码和功能安全（FunctionSafety）信息，共计 21 字节。因此，整个 Packet 的大小是 9 + 288 + 21 = 318 字节。

如果用结构体来定义，类似于下面这样：

```cpp showLineNumbers
typedef struct
{
    uint16_t sob;
    uint16_t pkgLen;
    uint32_t frameID;
    uint8_t  version;
} DemoHeader;

typedef struct
{
    uint16_t distance;
    uint16_t azimuth;
    uint16_t elevation;
    uint8_t  intensity;
    uint16_t reserved;
} DemoUnit;

typedef struct
{
    DemoUnit units[32];
} DemoBlock;

typedef struct
{
    uint32_t crc;
    uint8_t  functionSafety[17];
} DemoTail;

typedef struct
{
    DemoHeader header;
    DemoBlock block;
    DemoTail tail;
} DemoPacket;
```

看起来很棒，现在我们来计算一下包的大小，添加如下代码：

```cpp showLineNumbers
#include <stdio.h>
#include <stdint.h>

/* 结构体定义，忽略 */

int main(void)
{
    DemoPacket packet;

    printf("Size of DemoPacket = %lu\n", sizeof(packet));
    printf("Size of DemoPacket.Header = %lu\n", sizeof(packet.header));
    printf("Size of DemoPacket.Block  = %lu\n", sizeof(packet.block));
    printf("Size of DemoPacket.Tail   = %lu\n", sizeof(packet.tail));

    return 0;
}
```

运行程序，输出结果如下：

```bash showLineNumbers
Size of DemoPacket = 356
Size of DemoPacket.Header = 12
Size of DemoPacket.Block  = 320
Size of DemoPacket.Tail   = 24
```

咦。。。怎么跟协议里规定的 318 个字节对不上？



## 字节对齐

这种现象其实是“字节对齐”的原因造成的。我们知道，CPU 在内存中寻址的最小单位是 byte（字节），一个 byte 通常等于 8 个比特（bit）。为了提高 CPU 在内存中存取数据的效率，CPU 会按块操作，块的大小可能是 2 字节、4 字节、8 字节或者 16 字节等等。这个大小就是字节对齐的边界，会直接影响到数据在内存中的存储方式。

至于块的大小到底是多少，则由操作系统和编译器来决定。通常来说，在 32 位系统中，默认按 4 字节对齐；在 64 位系统中，默认按 8 字节对齐。也就是说，编译器会按默认的字节对齐为单位分配存储空间，如果不足，会自动补充空白的字节。因此出现了 Packet 大小与协议的大小不一致的现象。

```bash showLineNumbers
Size of DemoPacket = 356
Size of DemoPacket.Header = 12
Size of DemoPacket.Block  = 320
Size of DemoPacket.Tail   = 24
```

仔细观察，你会发现 Block 的大小是 320 字节，一共包含 32 个单元，也就是说每个 Unit 的大小是 10 字节。这么一算，其实它并没有按 4 字节或 8 字节对齐，而是按结构体中的最大类型 `uint16_t` 来对齐了。正是因为这种不确定性，所以在进行网络传输时一定要特别注意字节对齐的问题，不能寄希望于操作系统和编译器来帮我们保证！

解决办法是不要使用编译器默认的字节对齐方式，而是明确定义以 1 字节对齐的方式存储数据。在 C/C++ 中，我们可以通过 `#pragma pack` 语法来达到这个目的。将需要明确字节对齐方式的数据用 `#pragma` 预处理指令包裹，例如使用 1 字节对齐：

```cpp showLineNumbers
#pragma pack(push, 1)
typedef struct
{
    uint16_t sob;
    uint16_t pkgLen;
    uint32_t frameID;
    uint8_t  version;
} DemoHeader;
#pragma pack(pop)
```

为示例中的所有结构体添加 `#pragma pack` 指令，重新编译运行程序，输出结果如下：

```bash showLineNumbers
Size of DemoPacket = 318
Size of DemoPacket.Header = 9
Size of DemoPacket.Block  = 288
Size of DemoPacket.Tail   = 21
```

Packet 的大小等于 318 字节，包头、包体、包尾的大小也都对了！



## 字节顺序

虽然数据包的大小对了，但是数据包里的字段还存在一个问题 —— 字节顺序。

字节顺序又称“大小端”问题，是指多字节类型的数据在内存中的存放顺序。简单来说就是：到底是先存放高字节数据，还是先存放低字节数据？

- 小端字节序（Little-endian）：低字节数据存放在内存低地址处，高字节数据存放在内存的高地址处；
- 大端字节序（Big-endian）：高字节数据存放在内存低地址处，低字节数据存放在内存的高地址处。

例如，一个值为 0x0A0B0C0D 的整型数，采用小端序和大端序时在内存中的存储情况如下图所示。

![](https://static.getiot.tech/Endianness-example.png#center)

在现代计算机系统中，字节顺序可以由 CPU、操作系统或者编译器来决定。因此在网络数据传输中，也需要注意字节顺序的问题，这样才能保证在网络中传输的字节流与协议中规定的顺序一致，保证不同平台产品的互通。

大小端的争吵从十八世纪就开始了，小说《格列佛游记》中描述到，小人国为水煮蛋该从大的一端（Big-End）剥开还是小的一端（Little-End）剥开而争论，争论的双方分别被称为“大端派”和“小端派”。

为了解决这个纷争，TCP/IP 协议中规定了网络字节序为大端序，从而保证数据在网络中传输的一致性。因此在程序中发数据包时，对于多字节数据，需要将主机字节序转换为网络字节序。同样，接收数据包的一端则要将网络字节序转换为主机字节序。

实际上，POSIX 标准 C 库函数中已经提供了相关的转换函数，包括 `htonl`、`htons`、`ntohl` 和 `ntohs` 四个 API。

```c showLineNumbers
#include <arpa/inet.h>

uint32_t htonl(uint32_t hostlong);
uint16_t htons(uint16_t hostshort);
uint32_t ntohl(uint32_t netlong);
uint16_t ntohs(uint16_t netshort);
```

另外 `endian.h` 中还定义了更通用的 16、32、64 字节数据的大小端转换函数，包括 `htobe16`、`htole16`、`be16toh`、`le16toh`、`htobe32`、`htole32`、`be32toh`、`le32toh`、`htobe64`、`htole64`、`be64toh`、`le64toh` 等一组函数。

```c showLineNumbers
uint16_t htobe16(uint16_t host_16bits);
uint16_t htole16(uint16_t host_16bits);
uint16_t be16toh(uint16_t big_endian_16bits);
uint16_t le16toh(uint16_t little_endian_16bits);

uint32_t htobe32(uint32_t host_32bits);
uint32_t htole32(uint32_t host_32bits);
uint32_t be32toh(uint32_t big_endian_32bits);
uint32_t le32toh(uint32_t little_endian_32bits);

uint64_t htobe64(uint64_t host_64bits);
uint64_t htole64(uint64_t host_64bits);
uint64_t be64toh(uint64_t big_endian_64bits);
uint64_t le64toh(uint64_t little_endian_64bits);
```



## 相关链接

- 参考资料：[字节顺序 - 人人都懂物联网](/computerbasics/endianness/)
- 完整代码：[format_struct.c - GitHub](https://github.com/getiot/linux-c/blob/main/datatype/alignment/format_struct.c)
- 参考手册：[Linux 常用 C 函数](https://getiot.tech/manual/linux-c-functions/index.html)

