---
sidebar_position: 1
---

# Quectel EC20 在 Linux 上的使用



本文使用的 EC20 R2.1 Mini PCIe 是一款支持 PCI Express Mini Card 标准接口的 LTE 模块，采用 LTE 3GPP Rel.11 技术。模块介绍请看 [Quectel EC20](/iot-module/quectel-ec20/)。

![](https://static.getiot.tech/ec20-connect-via-ppp.png#center)



背景知识

- PPP
- GobiNet 驱动
- QMI_WWAN 驱动
- quectel-CM：Quectel Connect Manager
- RNDIS（Remote Network Driver Interface Specification，远程网络驱动接口规范）是一个通信协议。 它是微软公司的专利协议，被大多数Windows、Linux和Unix系统所支持。 它主要使用USB协议作为其下层传输，它向上层提供虚拟的以太网连接。



拨号工具

- pppd
- Gobinet +  QconnectManager
- modemmanager
- WvDial



网卡名称

- ppp0
- wwan0
- usb0



## 准备工作



### 硬件连接

在开始实验之前，先准备好 EC20 mini PCIe 模块，并通过 mini PCIe 转 USB 转接板连接到 Linux 主机。

![](https://static.getiot.tech/ec20-minipcie-to-usb.jpeg#center)

- **硬件描述：** EC20 模块封装成标准的 PCIe 接口，实际走的是 USB 信号，并虚拟出多个 ttyUSB 设备节点。
- **系统描述：** 本实验基于 Ubuntu 20.04（Linux 内核版本 5.8.0-55）进行。



### 内核配置

本文在 Ubuntu 20.04 进行测试，测试前请先确认当前内核已配置下列一些选项。

```bash
CONFIG_USB_SERIAL
CONFIG_USB_SERIAL_WWAN
CONFIG_USB_SERIAL_OPTION
CONFIG_USBNET
CONFIG_PPP
```

并检查内核是否已经加载相应模块。

```bash
lsmod | grep usb
lsmod | grep ppp
```

提示：新版的 Ubuntu 已经支持 EC20 4G 模块的驱动，连接之后就能自动识别，需要准备的只有应用层的 pppd 和 wvdial 等程序。



### 安装软件

如果没有 pppd 和 wvdial 命令，请执行如下命令进行安装。

```bash
sudo apt install ppp
sudo apt install wvdial
```

检查是否安装成功。

```bash
$ pppd --version
pppd version 2.4.7
$ wvdial --version
WvDial 1.61
Copyright (c) 1997-2005 Net Integration Technologies, Inc.
```

连接 EC20 模块，执行 lsusb 命令，如果出现如下内容则模块已经成功被 Linux 系统识别到。

```bash
Bus 002 Device 009: ID 2c7c:0125 Quectel Wireless Solutions Co., Ltd. EC25 LTE modem
```

其中，`0x2C7C` 和 `0x0125` 分别是 Quectel EC25/EC20 R2.0 的 VID 和 PID 编号。



## AT 功能

当连接模块并加载 USB 驱动成功后，在 /dev 目录下将会创建出几个 tty 设备节点。例如 /dev/ttyUSB2 是 AT 指令的控制端口。

```bash
$ ls -l /dev/ttyUSB*
crw-rw---- 1 root dialout 188, 0 6月  26 00:14 /dev/ttyUSB0
crw-rw---- 1 root dialout 188, 1 6月  26 00:13 /dev/ttyUSB1
crw-rw---- 1 root dialout 188, 2 6月  26 00:16 /dev/ttyUSB2
crw-rw---- 1 root dialout 188, 3 6月  26 00:14 /dev/ttyUSB3
```

其中 ttyUSB0 为模块的 DM 端口，ttyUSB1 为 GPS NMEA 数据输出端口，ttyUSB2 为 AT 指令通信端口，ttyUSB3 为 PPP 连接端口。

接下来，就可以通过 ttyUSB2 串口输入 AT 指令并接收返回数据。在 Linux 下最直接的方式就是使用 echo 和 cat 命令，分别打开两个终端，一边执行 echo 命令发送 AT 指令，一边执行 cat 命令等待数据。

```bash
cat /dev/ttyUSB2 & echo -e "ATI\r\n" > /dev/ttyUSB2
```

为了更好地交互，建议使用 [minicom](/linux-command/minicom/) 或 [microcom](/linux-command/microcom/) 这些串口调试工具进行测试。

执行 `AT+CPIN?` 命令查询 SIM 卡状态，如果返回 `+CPIN: READY` 表示 SIM 卡准备就绪，如果返回 `+CME ERROR: 10` 表示 SIM not inserted，如果返回 `+CME ERROR: 13` 表示 SIM failure。

可以通过下面 AT 指令来简单测试短信发送功能。

```bash
AT+CMGF=1
AT+CSCS="GSM"
AT+CMGS="your-phone-number"
> Hello World!
Ctrl-Z
```

在 `AT+CMGS` 后面的字串中填入接收信息的号码，收到 “>” 提示符后填入短信内容，按 Ctrl-Z 即可发送短信。




## Wvdial

wvdial 是 Linux 下的智能化拨号工具，利用 wvdial 和 ppp 可以实现 Linux 下的轻松上网。在整个过程中 wvdial 的作用是拨号并等待提示，并根据提示输入相应的用户名和密码等认证信息；ppp 的作用是与拨入方协商传输数据的方法并维持该连接。

### wvdial 及其相关配置

wvdial 的功能很强大，会试探着去猜测如何拨号及登录到服务器，同时它还会对常见的错误智能的进行处理，不需要你去写登录脚本。wvdial 只有一个配置文件 /etc/wvdial.conf。

wvdial 的启动过程是这样的：首先需要载入 wvdial.conf 配置文件，然后再初始化 modem 并拨号，拨号后等待拨入方的响应，收到拨入方响应后则启动 pppd。可以用 wvdialconf 程序自动生成 wvdial.conf 配置文件，运行该程序的格式为：

```bash
wvdialconf /etc/wvdial.conf
```

在执行该程序的过程中，程序会自动检测你的modem的相关配置，包括可用的设备文件名，modem 的波特率，初始化字符等相关的拨号信息，并根据这些信息自动生成 wvdial.conf 配置文件。如果 /etc/wvdial.conf 文件已经存在时，再次执行该命令只会改变其中的 Modem、Band、Init 等选项。一个典型的自动生成的配置文件可能是这样的：

```ini showLineNumbers
[Dialer Defaults]
Modem = /dev/ttyUSB0
Baud = 115200
Init1 = ATZ
Init2 = ATQ0 V1 E1 S0=0 &C1 &D2 S11=55 +FCLASS=0
; Phone =
; Username =
; Password =
```

生成 /etc/wvdial.conf 文件后，还需要根据您所使用的 SIM 卡运营商进行配置。我们可以添加一个 EC20 专用的 section，该 section 的相应选项配置将会覆盖 Defaults 的配置。

例如，移动或电信卡修改内容如下：

```ini showLineNumbers
[Dialer ec20]
Init1 = ATZ
Init2 = ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0
Modem Type = Analog Modem
Modem = /dev/ttyUSB3
Baud = 115200
New PPPD = yes
ISDN = 0
Phone = *99#
Username = card
Password = card
```

联通卡修改内容如下：

```ini showLineNumbers
[Dialer ec20]
Init1 = ATZ
Init2 = ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0
Init3 = at+cgdcont=1,"ip","uninet"
Modem Type = Analog Modem
Modem = /dev/ttyUSB3
Baud = 115200
New PPPD = yes
ISDN = 0
Phone = *99#
Password = card
Username = card
```



### wvdial 拨号

```bash
sudo wvdial ec20
```

连接成功

```bash
--> WvDial: Internet dialer version 1.61
--> Initializing modem.
--> Sending: ATZ
ATZ
OK
--> Sending: ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0
ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0
OK
--> Modem initialized.
--> Sending: ATDT*99#
--> Waiting for carrier.
ATDT*99#
CONNECT 150000000
--> Carrier detected.  Waiting for prompt.
--> Don't know what to do!  Starting pppd and hoping for the best.
--> Starting pppd at Sun Jun 27 22:38:16 2021
--> Pid of pppd: 271769
--> Using interface ppp0
--> local  IP address 10.197.68.69
--> remote IP address 10.64.64.64
--> primary   DNS address 221.179.38.7
--> secondary DNS address 120.196.165.7
```

如果想设置开机自动运行，可以在 /etc/rc.local 文件中添加下面一行命令：

```bash
/usr/bin/wvdial ec20 &
```

### 测试

EC20 拨号成功后，可以看到 ppp0 网卡

```bash
$ ifconfig ppp0
ppp0: flags=4305<UP,POINTOPOINT,RUNNING,NOARP,MULTICAST>  mtu 1500
        inet 10.116.222.105  netmask 255.255.255.255  destination 10.64.64.64
        ppp  txqueuelen 3  (点对点协议)
        RX packets 5  bytes 62 (62.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 38  bytes 5389 (5.3 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

指定 ppp0 网卡进行网络连通测试

```bash
$ ping -I ppp0 getiot.tech
PING getiot.tech (42.192.64.149) from 10.116.222.105 ppp0: 56(84) bytes of data.
64 比特，来自 42.192.64.149 (42.192.64.149): icmp_seq=1 ttl=54 时间=229 毫秒
64 比特，来自 42.192.64.149 (42.192.64.149): icmp_seq=2 ttl=54 时间=127 毫秒
64 比特，来自 42.192.64.149 (42.192.64.149): icmp_seq=3 ttl=54 时间=146 毫秒
64 比特，来自 42.192.64.149 (42.192.64.149): icmp_seq=4 ttl=54 时间=119 毫秒
```



### 自动化拨号和断开连接

实现自动化连接，涉及几个文件：

- /etc/wvdial.conf：wvdial 的配置文件
- /etc/ppp/options：pppd 的配置文件
- /etc/ppp/ppp-on：拨号自动化脚本
- /etc/ppp/ppp-off：断开连接自动化脚本

/etc/wvdial.conf 的配置沿用前面的修改，/etc/ppp/options 配置文件打开以下选项：

```bash
noipdefault         # ppp 将使用拨入方提供的 ip 地址
ipcp-accept-local   # ppp 将接受拨入方提供的 ip 地址
ipcp-accept-remote  # ppp 将使用拨入方自己的 ip 地址
defaultroute        # 设置缺省网关
noauth              # 在传输数据包之前，让拨入方先自我认证，注意一般的ISP都不包含该机制，故应选中noauth
crtscts             # 使用硬件流控制
debug               # 将拨号信息作日志
```

编写拨号自动化脚本 /etc/ppp/ppp-on

```bash
#!/bin/bash

# This script initiates the ppp connections by wvdial
wvdial ec20 &
```

编写断开连接自动化脚本 /etc/ppp/ppp-off

```bash
#!/bin/bash

# stop wvdial
killall wvdial

# If the ppp0 pid file is present then the program is running. Stop it
if [ -r /var/run/ppp0.pid ]; then
    kill -INT `cat /var/run/ppp0.pid`
    echo "PPP link to ppp0 terminated."
else
    echo "ERROR: PPP link is not active on ppp0"
    exit 0
fi

exit 1
```

为脚本添加执行权限

```bash
chmod +x /etc/ppp/ppp*
```

之后便可以运行 /etc/ppp/ppp-on 自动拨号，运行 /etc/ppp/ppp-off 自动断开连接。



## PPP 拨号

为了设置 PPP 拨号，下面文件是必需的。将 Quectel 官方提供的几个拨号脚本预置进 /etc 目录

| 文件                    | 存放路径       |
| ----------------------- | -------------- |
| ip-up                   | /etc/ppp       |
| quectel-chat-connect    | /etc/ppp/peers |
| quectel-chat-disconnect | /etc/ppp/peers |
| quectel-ppp             | /etc/ppp/peers |
| quectel-pppd.sh         | 非必须         |
| quectel-ppp-kill        | 非必须         |
| readme                  | 非必须         |

尽管 readme 文件中有讲到需要填写 APN、用户名及密码信息，**但实际上至少在我们国家完全可以忽略**，直接用默认的信息预置即可。

### 拨号脚本

#### quectel-ppp

```bash
#/etc/ppp/peers/quectel-ppp
# Usage:root>pppd call quectel-ppp
# Hide password in debug messages
hide-password
# The phone is not required to authenticate
noauth
# The chat script
connect '/usr/sbin/chat -E -s -v -f /etc/ppp/peers/quectel-chat-connect'
# The close script
disconnect '/usr/sbin/chat -E -s -v -f /etc/ppp/peers/quectel-chat-disconnect'
# Debug info from pppd
debug
# Serial Device to which the HSPDA phone is connected
# Modem path, like /dev/ttyUSB3,/dev/ttyACM0, it depends on your module.
# Exmaple given is with the modem mounted at /dev/ttyUSB3
/dev/ttyUSB3
# Serial port line speed
115200
# If you want to use the HSDPA link as your gateway
defaultroute
# pppd must not propose any IP address to the peer
noipdefault
# No ppp compression
novj
novjccomp
noccp
ipcp-accept-local
ipcp-accept-remote
local
# For sanity, keep a lock on the serial line
lock
dump
# Keep pppd attached to the terminal
# Comment this to get daemon mode pppd
nodetach
# Network access credenatials. 
# Set LTE_USERNAME and LTE_PASSWORD before executing pppd -C call
# Check with service provider for required details
user $LTE_USERNAME
password $LTE_PASSWORD
# Hardware flow control
crtscts
remotename 3gppp
ipparam 3gppp
# Ask the peer for up to 2 DNS server addresses
usepeerdns
```



#### quectel-chat-connect

```bash
ABORT "BUSY"
ABORT "NO CARRIER"
ABORT "NO DIALTONE"
ABORT "ERROR"
ABORT "NO ANSWER"
TIMEOUT 120
"" AT
OK ATE0
OK ATI
OK AT+CSQ
OK AT+CPIN?
OK AT+COPS?
OK AT+CGREG?
OK ATZ
# Connection to the network
# Set LTE_APN variable before executing chat -E ...
# Check with service provider for required details
OK AT+CGDCONT=1,"IP","$LTE_APN",,0,0
# Dial the number
OK ATDT*99#
CONNECT
```



#### quectel-chat-disconnect

```bash
ABORT "ERROR"
ABORT "NO DIALTONE"
SAY "\NSending break to the modem\n"
"" +++ATH
SAY "\nGood bye\n"
```



## GoBiNet 和 QMI WWAN

目前 4G 模块应用已经非常普及，跟之前的 3G 不同，3G 基本使用 ppp 拨号，usbserial 驱动，Linux 内核自带支持，此应用非常简单。而 4G 模块由于速率较高，usbserial 驱动性能满足不了，因此 4G 的拨号方式就发生了变化。基本方式有 PPP、NDIS、QMI 等。

本节介绍 QMI 方式，所谓 QMI 即 Qualcomm Message Interface，因此只限于使用高通芯片的 4G 模块。



## ECM 和 MBIM





## Quectel-CM

Quectel Connect Manager





## RNDIS

RNDIS（Remote Network Driver Interface Specification，远程网络驱动接口规范）是一个通信协议。 它是微软公司的专利协议，被大多数 Windows、Linux 和 Unix 系统所支持。 它主要使用 USB 协议作为其下层传输，它向上层提供虚拟的以太网连接。







```bash
USB_SERIAL=y
USB_SERIAL_WWAN=y
USB_SERIAL_OPTION=y

USB_USBNET=y
USB_NET_CDCETHER=y        # 用ECM  使能此项
USB_NET_RNDIS_HOST=y      # 用RNDIS 使能此项
```



## 补充说明

各运营商拨号上网设置：

|            运营商(ISP)            |  APN  |  拨号号码  |      账号       |     密码     |
| :-------------------------------: | :---: | :--------: | :-------------: | :----------: |
|  中国联通 WCDMA（China Unicom）   | 3GNET |   `*99#`   |       空        |      空      |
| 中国电信CDMA2000（China Telecom） |  空   |   `#777`   | ctnet@mycdma.cn |  vnet.mobi   |
|              1X网络               |  空   |   `#777`   |  card（CARD）   | card（CARD） |
| 中国移动 TD-SCDMA（China Mobile） | CMNET |  `*98*1#`  |       空        |      空      |
|   中国移动 CPRS（China Mobile）   | CMNET | `*99***1#` |       空        |      空      |





