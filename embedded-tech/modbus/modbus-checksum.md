---
sidebar_position: 9
authors: [luhuadong]
---

# Modbus 差错校验



基于串行链路的 Modbus 通信需要进行差错校验，根据传输模式（ASCII 或 RTU）的不同，差错校验域采用不同的校验方法。

- **ASCII 模式** —— 校验字段由两个字符组成，其值是基于对全部报文内容执行 **LRC** 校验（Longitudinal Redundancy Check，纵向冗余校验）的计算结果。计算对象不包括起始的冒号（`:`）和回车换行符号（`CRLF`）。
- **RTU 模式** —— 校验字段由 16 个比特位（两个字节）组成，其值是基于对全部报文内容执行 **CRC** 校验（Cyclical Redundancy Check，循环冗余校验）的计算结果。计算对象包括校验域之前的所有字节。



## LRC 校验

LRC 校验比较简单，它在 ASCII 协议中使用，检测了消息域中除开始的冒号及结束的回车换行号外的内容。它仅仅是把每一个需要传输的数据按字节叠加（丢弃所有进位），然后对结果进行二进制补码操作。

下面是 LRC 校验的具体代码： 

```c showLineNumbers
unsigned char LRC(unsigned char *auchMsg, unsigned short usDataLen)
{
    unsigned char uchLRC = 0;
    while (usDataLen--)
        uchLRC += *auchMsg++;
    return ((unsigned char)(-((char)uchLRC)));
}
```

从算法本质来说，LRC 域本身仅占 1 个字节，但在 ASCII 模式传递消息帧时，LRC 值被编码为 2 个字节的 ASCII 字符。例如，计算得到的 LRC 值为 0xF3，那么在 ASCII 消息帧中表示为 'F' 和 '3' 两个字符。



## CRC 校验

CRC 域是两个字节，包含一个 16 位的二进制值。它由传输设备计算后加入到消息中。接收设备重新计算收到消息的 CRC，并与接收到的 CRC 域中的值比较，如果两值不同，则有误。 

CRC 是先调入一值是全“1”的 16 位寄存器，然后调用一过程将消息中连续的 8 位字节各当前寄存器中的值进行处理。仅每个字符中的 8 位数据对 CRC 有效，起始位和停止位以及奇偶校验位均无效。 CRC 产生过程中，每个 8 位字符都单独和寄存器内容相或（OR），结果向最低有效位方向移动，最高有效位以 0 填充。LSB 被提取出来检测，如果 LSB 为 1，寄存器单独和预置的值或一下，如果 LSB 为 0，则不进行。整个过程要重复 8 次。在最后一位（第 8 位）完成后，下一个 8 位字节又单独和寄存器的当前值相或。最终寄存器中的值，是消息中所有的字节都执行之后的 CRC 值。 

下面是 CRC 校验的具体代码： 

```c showLineNumbers
unsigned short CRC16(unsigned char *puchMsg, unsigned short usDataLen)
{
    int i, j;
    unsigned short usRegCRC = 0xFFFF;
    
    for (i=0; i<usDataLen; i++)
    {
        usRegCRC ^= *puchMsg++;
        for (j=0; j<8; j++)
        {
            if (usRegCRC & 0x0001)
                usRegCRC = usRegCRC >> 1 ^ 0xA001;
            else
                usRegCRC >>= 1;
        }
    }
    
    return usRegCRC;
}
```

在 Modbus RTU 模式中，规定了在消息帧传递时 CRC 校验值必须按低字节在前，高字节在后的顺序。例如，计算得到的 CRC 值为 0xCA31，那么发送顺序为 0x31、0xCA。

上面的 CRC16 计算方法并不是最优的，因为它需要大量的运算，只适用于对速度不敏感的场合。对运算速度有要求的，可以采用查表法得到校验值，是一种以空间换时间的策略。

