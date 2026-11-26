---
sidebar_position: 5
---

# 蓝牙协议栈 BlueZ



[BlueZ](https://github.com/bluez/bluez) 是 Linux 官方蓝牙协议栈。它是一个基于 GPL 发布的开源项目，从 Linux2.4.6 开始便成为 Linux 内核的一部分。其基础代码均是由就职于 Qualcomm 的 Maxim Krasnyansky 完成，包括 HCI、L2CAP、RFCOMM 和基本 socket 的实现。

## 安装

```shell
$ sudo apt install bluez
```

安装完 Bluez 协议栈后，系统会增加一些调试工具，包括 bluetootchctl、hciconfig、hcitool 和 gatttool。

本文我们将使用 `gatttool` 连接 Thunderboard 蓝牙设备对其进行操作，同时我们可以对其数据进行分析，找出这些控制指令。



## hciconfig

使用 `hciconfig` 命令可以查看当前能够识别的蓝牙设备，该命令类似 `ifconfig` 查看网卡设备。可以控制蓝牙设备的开启与关闭，在默认情况下，蓝牙设备在插入 host 时是不会自动开启的，所以我们在调试之前要先开启设备。

```shell
$ hciconfig 
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 74:E5:F9:FF:B0:CB  ACL MTU: 1021:4  SCO MTU: 96:6
	UP RUNNING PSCAN ISCAN 
	RX bytes:56591727 acl:245 sco:0 events:8083009 errors:0
	TX bytes:700294981 acl:8080058 sco:0 commands:2632 errors:0
```

会输出以上内容，我们可以看到蓝牙设备的编号为 `hci0`，这是 host 分配给设备的 ID，我们用来启动或关闭设备也是需要该 ID 来控制。

开启与关闭设备：

```shell
#设备打开
sudo hciconfig hci0 up
#设备关闭
sudo hciconfig hci0 down
```



## hcitool

在打开蓝牙设备以后，就可以使用 hcitool 工具集对蓝牙进行控制，工具集参数分为两部分，一为正常的蓝牙设备调试，二为低功耗即 BLE 设备， 工具参数如下：



搜索 BLE 设备：

```shell
$ sudo hcitool lescan
LE Scan ...
6B:FB:CD:E4:6E:FB (unknown)
6B:FB:CD:E4:6E:FB (unknown)
60:A4:23:C9:69:9C Thunderboard #27036
60:A4:23:C9:69:9C (unknown)
50:76:0F:FA:95:10 (unknown)
50:76:0F:FA:95:10 (unknown)
F8:31:68:A0:8C:06 SMI-M1
F8:31:68:A0:8C:06 (unknown)
```

可以看到 Thunderboard #27036 开发板对应的地址是 60:A4:23:C9:69:9C。（后面马上用上）



## gatttool


使用 interactive 方式（交互模式）连接设备：

```shell
gatttool -I
```

或直接带上 BT 地址：

```shell
gatttool -b 60:A4:23:C9:69:9C -I
```

查看帮助：

```shell
[60:A4:23:C9:69:9C][LE]> help
help                                           Show this help
exit                                           Exit interactive mode
quit                                           Exit interactive mode
connect         [address [address type]]       Connect to a remote device
disconnect                                     Disconnect from a remote device
primary         [UUID]                         Primary Service Discovery
included        [start hnd [end hnd]]          Find Included Services
characteristics [start hnd [end hnd [UUID]]]   Characteristics Discovery
char-desc       [start hnd] [end hnd]          Characteristics Descriptor Discovery
char-read-hnd   <handle>                       Characteristics Value/Descriptor Read by handle
char-read-uuid  <UUID> [start hnd] [end hnd]   Characteristics Value/Descriptor Read by UUID
char-write-req  <handle> <new value>           Characteristic Value Write (Write Request)
char-write-cmd  <handle> <new value>           Characteristic Value Write (No response)
sec-level       [low | medium | high]          Set security level. Default: low
mtu             <value>                        Exchange MTU for GATT/ATT
```

连接：

```shell
[60:A4:23:C9:69:9C][LE]> connect
Attempting to connect to 60:A4:23:C9:69:9C
Connection successful
```

查看设备提供的服务：

```shell
[60:A4:23:C9:69:9C][LE]> primary
attr handle: 0x0001, end grp handle: 0x0008 uuid: 00001801-0000-1000-8000-00805f9b34fb
attr handle: 0x0009, end grp handle: 0x000d uuid: 00001800-0000-1000-8000-00805f9b34fb
attr handle: 0x000e, end grp handle: 0x001a uuid: 0000180a-0000-1000-8000-00805f9b34fb
attr handle: 0x001b, end grp handle: 0x0024 uuid: 00001815-0000-1000-8000-00805f9b34fb
attr handle: 0x0025, end grp handle: 0x0028 uuid: 0000180f-0000-1000-8000-00805f9b34fb
attr handle: 0x0029, end grp handle: 0x002b uuid: ec61a454-ed00-a5e8-b8f9-de9ec026ec51
attr handle: 0x002c, end grp handle: 0x0034 uuid: f598dbc5-2f00-4ec5-9936-b3d1aa4f957f
attr handle: 0x0035, end grp handle: 0x003e uuid: a4e649f4-4be5-11e5-885d-feff819cdc9f
attr handle: 0x003f, end grp handle: 0x0047 uuid: 0000181a-0000-1000-8000-00805f9b34fb
attr handle: 0x0048, end grp handle: 0xffff uuid: 1d14d6ee-fd63-4fa1-bfa4-8f47b42119f0
```

查看特征

```shell
[60:A4:23:C9:69:9C][LE]> characteristics 
handle: 0x0002, char properties: 0x20, char value handle: 0x0003, uuid: 00002a05-0000-1000-8000-00805f9b34fb
handle: 0x0005, char properties: 0x02, char value handle: 0x0006, uuid: 00002b2a-0000-1000-8000-00805f9b34fb
handle: 0x0007, char properties: 0x0a, char value handle: 0x0008, uuid: 00002b29-0000-1000-8000-00805f9b34fb
handle: 0x000a, char properties: 0x0a, char value handle: 0x000b, uuid: 00002a00-0000-1000-8000-00805f9b34fb
handle: 0x000c, char properties: 0x02, char value handle: 0x000d, uuid: 00002a01-0000-1000-8000-00805f9b34fb
handle: 0x000f, char properties: 0x02, char value handle: 0x0010, uuid: 00002a29-0000-1000-8000-00805f9b34fb
handle: 0x0011, char properties: 0x02, char value handle: 0x0012, uuid: 00002a24-0000-1000-8000-00805f9b34fb
handle: 0x0013, char properties: 0x02, char value handle: 0x0014, uuid: 00002a25-0000-1000-8000-00805f9b34fb
handle: 0x0015, char properties: 0x02, char value handle: 0x0016, uuid: 00002a27-0000-1000-8000-00805f9b34fb
handle: 0x0017, char properties: 0x02, char value handle: 0x0018, uuid: 00002a26-0000-1000-8000-00805f9b34fb
handle: 0x0019, char properties: 0x02, char value handle: 0x001a, uuid: 00002a23-0000-1000-8000-00805f9b34fb
handle: 0x001c, char properties: 0x12, char value handle: 0x001d, uuid: 00002a56-0000-1000-8000-00805f9b34fb
handle: 0x0021, char properties: 0x0a, char value handle: 0x0022, uuid: 00002a56-0000-1000-8000-00805f9b34fb
handle: 0x0026, char properties: 0x12, char value handle: 0x0027, uuid: 00002a19-0000-1000-8000-00805f9b34fb
handle: 0x002a, char properties: 0x02, char value handle: 0x002b, uuid: ec61a454-ed01-a5e8-b8f9-de9ec026ec51
handle: 0x002d, char properties: 0x12, char value handle: 0x002e, uuid: f598dbc5-2f01-4ec5-9936-b3d1aa4f957f
handle: 0x0030, char properties: 0x12, char value handle: 0x0031, uuid: f598dbc5-2f02-4ec5-9936-b3d1aa4f957f
handle: 0x0033, char properties: 0x08, char value handle: 0x0034, uuid: f598dbc5-2f03-4ec5-9936-b3d1aa4f957f
handle: 0x0036, char properties: 0x10, char value handle: 0x0037, uuid: c4c1f6e2-4be5-11e5-885d-feff819cdc9f
handle: 0x0039, char properties: 0x10, char value handle: 0x003a, uuid: b7c4b694-bee3-45dd-ba9f-f3b5e994f49a
handle: 0x003c, char properties: 0x28, char value handle: 0x003d, uuid: 71e30b8c-4131-4703-b0a0-b0bbba75856b
handle: 0x0040, char properties: 0x02, char value handle: 0x0041, uuid: 00002a76-0000-1000-8000-00805f9b34fb
handle: 0x0042, char properties: 0x02, char value handle: 0x0043, uuid: c8546913-bfd9-45eb-8dde-9f8754f4a32e
handle: 0x0044, char properties: 0x02, char value handle: 0x0045, uuid: 00002a6e-0000-1000-8000-00805f9b34fb
handle: 0x0046, char properties: 0x02, char value handle: 0x0047, uuid: 00002a6f-0000-1000-8000-00805f9b34fb
handle: 0x0049, char properties: 0x08, char value handle: 0x004a, uuid: f7bf3564-fb6d-4e53-88a4-5e37e0326063
```

其中 handle 是特性的句柄，char properties 是特性的属性值，char value handle 是特性值的句柄，uuid 是特性的标识；

我想，可以把特性（characteristic）当作是设备特供的寄存器，寄存器会有属性，如只读、只写或可读可写，在蓝牙协议里面，还有 notify 的属性，当然，这个通知属性当作是寄存器的中断服务也是说得过去的；那么，第一个 handle 可以理解为寄存器的编号，第二个 handle 理解为寄存器的地址，properties 即是寄存器属性，如果是可读可写，那么直接读写操作寄存器的地址即可。

比如 LED 对应 Automation IO Service，其 characteristic 为：

```shell
handle: 0x0021, 
char properties: 0x0a, # 可读可写
char value handle: 0x0022, 
uuid: 00002a56-0000-1000-8000-00805f9b34fb
```

我们可以通过如下方式打开、关闭 LED

```shell
[60:A4:23:C9:69:9C][LE]> char-write-req 0x0022 01
Characteristic value was written successfully
[60:A4:23:C9:69:9C][LE]> char-write-req 0x0022 00
Characteristic value was written successfully
```

而 温度传感器 对应 Environment Service，其 characteristic 为：

```shell
handle: 0x0044, 
char properties: 0x02, # 只读
char value handle: 0x0045, 
uuid: 00002a6e-0000-1000-8000-00805f9b34fb
```

我们可以通过如下方式获取当前温度值：

```shell
[60:A4:23:C9:69:9C][LE]> char-read-hnd 0x0045
Characteristic value/descriptor: f9 08
```

`08 f9` 转换成十进制即 22.97 ℃


就这，是不是很简单？