---
sidebar_position: 12
authors: [luhuadong]
---

# FreeModbus 软件库



FreeModbus 是针对通用的 Modbus 协议栈在嵌入式系统中应用的一个实现。

Modbus 协议是一个在工业制造领域中得到广泛应用的一个网络协议。一个 Modbus 通信协议栈包括两层：定义了数据结构和功能 Modbus 应用协议和网络层。

在 FreeModbus 的当前版本中，提供了 Modbus Application Protocol v1.1a 的实现并且支持在 Modbus over serial line specification 1.0 中定义的 RTU/ASCII 传输模式。从 0.7 版本开始，FreeModbus 也支持在 TCP defined in Modbus Messaging on TCP/IP Implementation Guide v1.0a 中定义的 TCP 传输。FreeModbus 遵循 BSD 开源许可，这意味着本协议栈的实现代码可以应用于商业用途。目前版本的 FreeModbus 支持如下的功能码：

- 读输入寄存器 (0x04)
- 读保持寄存器 (0x03)
- 写单个寄存器 (0x06)
- 写多个寄存器 (0x10)
- 读/写多个寄存器 (0x17)
- 读取线圈状态 (0x01)
- 写单个线圈 (0x05)
- 写多个线圈 (0x0F)
- 读输入状态 (0x02)
- 报告从机标识 (0x11)

本实现基于最新的标准并且与标准完全兼容。接收和传输Modbus RTU/ASCII数据帧是通过一个由硬件提取层的调用来驱动状态机来实现的。这就使得该协议非常容易移植到其他的平台之上。当收到一个完整的数据帧后，该数据帧被传入Modbus应用层，数据帧的内容在该层得到解析。为例方便增加新的Modbus功能，Freemodbus在应用层通提供了Hooks。

如果用到了Modbus TCP协议，那么当准备处理一个新数据帧的时候，移植层就必须首先向协议栈发送一个事件标志。然后，协议栈调用一个返回值为接收到的Modbus TCP数据帧的函数，并且开始处理这个数据帧。如果数据有效，则相应的Modbus反馈帧将提供给移植层生成反馈帧。最后，该反馈被发送到客户端。



