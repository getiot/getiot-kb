---
sidebar_position: 15
authors: [luhuadong]
---

# Linux 调试 Modbus



## 硬件模块

本实验使用如下一款 4 路 Modbus 继电器模块，通过 USB 转 RS485 模块连接电脑，演示如何在 Linux 进行 Modbus 调试。

![](https://static.getiot.tech/modbus-4-way-relays-module.png#center)

购买链接：[Modbus 4 路继电器模块](https://s.click.taobao.com/t?e=m%3D2%26s%3Dcw3iUU2lxikcQipKwQzePOeEDrYVVa64LKpWJ%2Bin0XLjf2vlNIV67rOAJuQ%2BdLnm7km9mWjOCUanFi3wFBXvYUtYIXyQ5%2BdaGX93X4IFTwPx%2FVncyXNiWXW0BscCR%2FBjdZr7RBnLmJomXO35yxsacbyGcEM3cwmWgjebZb7tu%2FEZUoCobRT8GngUQmPrY5Yy&scm=null&pvid=null&app_pvid=59590_33.8.119.65_672_1626696018368&ptl=floorId%3A17741&originalFloorId%3A17741&app_pvid%3A59590_33.8.119.65_672_1626696018368&union_lens=lensId%3APUB%401626695942%4021051faa_07b9_17abea24004_93f4%40021ITIf4XBUGAqn12JyRbH01)

该模块使用 12 V 直流电源供电，串口波特率为 9600（8 NONE 1），支持 MODBUS-RTU 通讯，默认地址为 1。如果需要接入多个设备，可以通过如下指令设置从站设备地址。

| 指令          | 请求                    | 响应                    |
| ------------- | ----------------------- | ----------------------- |
| 设置地址为 01 | 00 06 40 00 00 01 5c 1b | 01 06 00 00 00 01 48 0A |
| 设置地址为 02 | 00 06 40 00 00 02 1c 1a | 02 06 00 00 00 02 08 38 |
| 读取地址      | 00 03 40 00 00 01 90 1b |                         |



```c showLineNumbers
/*******************************************************************/
[1号地址]
//--------------------------------------------
0号继电器开启 : 01 05 00 00 FF 00 8C 3A
0号继电器关闭 : 01 05 00 00 00 00 CD CA
//--------------------------------------------
1号继电器开启 : 01 05 00 01 FF 00 DD FA
1号继电器关闭 : 01 05 00 01 00 00 9C 0A
//-------------------------------------------
2号继电器开启 : 01 05 00 02 FF 00 2D FA
2号继电器关闭 : 01 05 00 02 00 00 6C 0A
//-------------------------------------------
3号继电器开启 : 01 05 00 03 FF 00 7C 3A
3号继电器关闭 : 01 05 00 03 00 00 3D CA
单一翻转指令：
0号继电器翻转：01 05 00 00 55 00 F2 9A
1号继电器翻转：01 05 00 01 55 00 A3 5A
2号继电器翻转：01 05 00 02 55 00 53 5A
3号继电器翻转：01 05 00 03 55 00 02 9A
全关闭：01 05 00 ff 00 00 fd fa
全开启：01 05 00 ff ff ff fc 4a
全翻转：01 05 00 ff 5a 00 c7 5a
/**********************************************************************/
读取0号继电器状态：01 01 00 00 00 01 FD CA
读取1号继电器状态：01 01 00 01 00 01 AC 0A
读取2号继电器状态：01 01 00 02 00 01 5C 0A
读取3号继电器状态：01 01 00 03 00 01 0D CA
```





## 使用 echo 命令





## 使用 modpoll 工具

```shell
wget https://www.modbusdriver.com/downloads/modpoll.tgz
```

打开线圈（闭合继电器）

```shell
$ ./modpoll -m rtu -0 -1 -a 1 -r 1 -c 1 -b 9600 -p none -t 0 /dev/ttyUSB1 1
modpoll 3.10 - FieldTalk(tm) Modbus(R) Master Simulator
Copyright (c) 2002-2021 proconX Pty Ltd
Visit https://www.modbusdriver.com for Modbus libraries and tools.

Protocol configuration: Modbus RTU, FC5
Slave configuration...: address = 1, start reference = 1 (PDU), count = 1
Communication.........: /dev/ttyUSB1, 9600, 8, 1, none, t/o 1.00 s, poll rate 1000 ms
Data type.............: discrete output (coil)

Written 1 reference.
```

关闭线圈（断开继电器）

```shell
$ ./modpoll -m rtu -0 -1 -a 1 -r 1 -c 1 -b 9600 -p none -t 0 /dev/ttyUSB1 0
modpoll 3.10 - FieldTalk(tm) Modbus(R) Master Simulator
Copyright (c) 2002-2021 proconX Pty Ltd
Visit https://www.modbusdriver.com for Modbus libraries and tools.

Protocol configuration: Modbus RTU, FC5
Slave configuration...: address = 1, start reference = 1 (PDU), count = 1
Communication.........: /dev/ttyUSB1, 9600, 8, 1, none, t/o 1.00 s, poll rate 1000 ms
Data type.............: discrete output (coil)

Written 1 reference.
```



## 手撕代码

```shell
$ sudo ./mbpoll-relay /dev/ttyUSB1
Opening /dev/ttyUSB1 at 9600 bauds (N, 8, 1)
Connection successed
[01][05][00][00][FF][00][8C][3A]
Waiting for a confirmation...
<01><05><00><00><FF><00><8C><3A>
[01][05][00][01][FF][00][DD][FA]
Waiting for a confirmation...
<01><05><00><01><FF><00><DD><FA>
[01][05][00][02][FF][00][2D][FA]
Waiting for a confirmation...
<01><05><00><02><FF><00><2D><FA>
[01][05][00][03][FF][00][7C][3A]
Waiting for a confirmation...
<01><05><00><03><FF><00><7C><3A>
[01][05][00][00][00][00][CD][CA]
Waiting for a confirmation...
<01><05><00><00><00><00><CD><CA>
[01][05][00][01][00][00][9C][0A]
Waiting for a confirmation...
<01><05><00><01><00><00><9C><0A>
[01][05][00][02][00][00][6C][0A]
Waiting for a confirmation...
<01><05><00><02><00><00><6C><0A>
[01][05][00][03][00][00][3D][CA]
Waiting for a confirmation...
<01><05><00><03><00><00><3D><CA>
```





