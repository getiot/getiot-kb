---
sidebar_position: 5
authors: [luhuadong]
---

# Modbus 开发环境



学习 Modbus 协议最快的方法就是动手实践，为了降低操作门槛，我们可以通过软件来模拟，而不需要真实的 Modbus 设备。在 Windows 上，我们可以安装 Modbus Poll 和 Modbus Slave，以及 Visual Serial Port Driver（即 VSPD）软件。

![](https://static.getiot.tech/modbus-tools.png#center)

这三个工具的功能分别如下：

- Modbus Poll —— Modbus 主站设备；
- Modbus Slave —— Modbus 从站设备；
- Visual Serial Port Driver —— 虚拟串口软件，允许用户模拟多串口，支持所有的串口设置和信号线。

通过实操，可以加深对 Modbus 协议的理解，为后续调试真实设备打下良好基础 。

下载地址：

- [https://www.modbustools.com/download.html](https://www.modbustools.com/download.html)
- [https://www.eltima.com/products/vspdxp/](https://www.eltima.com/products/vspdxp/)



## VSPD 虚拟串口

下载并安装 VSPD 软件，打开软件，可以看到如下窗口。

![](https://static.getiot.tech/virtual-serial-port-driver-pro.png#center)

点击 “Pair” 创建一对相互连接的虚拟串口，例如 COM1 和 COM2。

![](https://static.getiot.tech/virtual-serial-port-driver-pro-create-a-new-pair.png#center)

此时，如果打开两个串口终端，分别连接 COM1 和 COM2，即可相互通信。但我们的目标是搭建 Modbus 开发环境，因此还需要安装 Modbus Poll 和 Modbus Slave 作为主站设备和从站设备。大致工作框架如下图所示。

![](https://static.getiot.tech/vspd-with-2-com.png#center)



## Modbus Poll

Modbus Poll 是 Modbus 主站设备仿真器，可以用于测试和调试 Modbus 从站设备，便于观察 Modbus 通信过程中的各种报文数据。该软件支持多种 Modbus 协议模式：

- Modbus RTU
- Modbus ASCII
- Modbus TCP/IP
- Modbus RTU Over TCP/IP
- Modbus ASCII Over TCP/IP
- Modbus UDP/IP
- Modbus RTU Over UDP/IP
- Modbus ASCII Over UDP/IP

Modbus Poll 主画面窗口如下。

![](https://static.getiot.tech/mbpoll.png#center)

按 F1 打开帮助，按 F3 进入连接设置页面。

![](https://static.getiot.tech/mbpoll-connection-setup.png#center)

按 F8 进入协议定义页面。例如，你要读取 20 个保持寄存器的值，起始地址为 40011（10），那么设置参数如下：

![](https://static.getiot.tech/mbpoll-read-write-definition.png#center)

- Slave ID ：输入从站设备 ID
- Function ：03 功能码（Read Holding Registers）
- Address ：10（Protocol address）
- Quantity ：20
- Scan Rate ：1000（将会每 1000ms 轮询一次数据）

在菜单栏 Functions 可以找到一些功能码的单独操作页面，例如写线圈状态寄存器、写保持寄存器等。

![](https://static.getiot.tech/mbpoll-function-05.png#center)



## Modbus Slave

Modbus Slave 是 Modbus 从站设备仿真器，用于接收主站设备的命令包，并回送数据包，便于观察 Modbus 通信过程中的各种报文数据。

Modbus Slave 最多可以在 32 个子窗口中模拟多达 32 个 Modbus 从站设备。用户界面与 Modbus Poll 相同，支持 01、02、03、04、05、06、15、16、22 和 23 等功能码，可用于监视串口或者网络通信数据。

![](https://static.getiot.tech/mbslave.png#center)

按 F8 打开从站定义窗口，可以设置从站 ID、功能码、寄存器起始地址、寄存器数量，以及 Modbus Slave 窗口的显示格式等。

![](https://static.getiot.tech/mbslave-definition.png#center)

Modbus Poll 和 Modbus Slave 仿真软件的用法就是这么简单，但由于它们都是商业软件，因此如果想长期使用，需要购买正版 License。



## 附录

### Modbus Poll

```markdown
------------------------------------------------------------------------------------
                       Modbus Poll
         Copyright (c) 2002-2021. Witte Software.
------------------------------------------------------------------------------------


Getting started:
-----------------------------
1. Press F3 to setup a connection.
2. Press F8 to setup protocol definition.
3. To change a value just start typing or double click the cell.

Note: You can always press F1 for help.

Warning:
-----------------------------
The use of RTS controlled RS232/RS485 converters should be avoided if possible.
It is difficult to determine the exact time when to switch off the transmitter
with non real-time operating systems like Windows and Linux. If it is switched
off to early characters might still sit in the FIFO or the transmit register of
the UART and these characters will be lost. Hence the slave will not recognize
the message. On the other hand if it is switched off too late then the slave's
message is corrupted and the master will not recognize the message.


Modbus Poll overview:
-----------------------------
Modbus Poll is a powerful, easy to use, master simulating
tool. Modbus Poll will run on all 32/64-bit Windows versions
in use today - 7, 8, 8.1 and 10.

With Modbus Poll you can monitor and test your modbus
slave devices. Some of the features:
- Supports Modbus/TCP, RTU and ASCII modes.
- Test Center for modbus slave developers.
- OLE Automation for interfacing with Visual Basic
  Excel etc. To interpret and show the modbus data
  according to your specific requirements. E.g. edit
  data in Excel and then send to your slave!
- Multiple windows for monitoring of multiple
  slaves/data areas.
- Monitoring of serial traffic.
- Data logging to a text file.
- Data logging to MS Excel.
- Multi threated for best performance.
- Print preview etc.
- 16 Display formats.
- Real time charting.

Press F2 or double click to edit or just start typing a new value.


Order information:
-----------------------------
Visit https://www.modbustools.com

Technical Support:
-----------------------------
Your feedback is very important for the further development
of Modbus Poll. For bug reports, comments, suggestions or
complaints, please find contact information at
https://www.modbustools.com
```



### Modbus Slave

```markdown
------------------------------------------------------------------------------------
                       Modbus Slave
         Copyright (c) Witte Software. 2002-2021.
------------------------------------------------------------------------------------


Getting started:
-----------------------------
1. Press F3 to setup a connection.
2. Press F8 to setup protocol definition.
   Example:
   You want to simulate 20 holding registers from address 40011 (10).
   - Slave ID  = The ID of your device
   - Function  = 03 Read Holding Registers
   - Address   = 10 (Protocol address)
   - Quantity  = 20

3. To change a value just start typing.

Note: You can always press F1 for help.



Modbus Slave overview:
-----------------------------
Modbus Slave is a powerful, easy to use, slave simulating
tool. Modbus Slave will run on all 32/64-bit Windows versions
in use today - XP, Vista, 7, 8, 8.1 and 10.

You can open up to 32 windows each containing a slave/data
area. A window can simulate up to 4096 coils or 2048
registers.
OLE Automation for interfacing with Visual Basic
Excel etc. See included example how to edit data with Excel.




Note:
In Windows it is not possible to measure the 3.5 character
idle time between two Modbus frames. That means that it may not
be possible to use Modbus Slave in parallel with another
slave device unless you are sure that the delay in the slave
is > 20ms.



Order information:
--------------------------
Visit https://www.modbustools.com

If not registered you are allowed to use the software
in a 30 days trial period.


Technical Support:
--------------------------
Your feedback is very important for the further development
of Modbus Slave. For bug reports, comments, suggestions or
complaints, please find contact information at
https://www.modbustools.com


```





