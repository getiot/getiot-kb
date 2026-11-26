---
sidebar_position: 8
---

# SIMCom A7600C



A7600C 模块可支持 GSM、WCDMA、LTE-TDD 和 LTE-FDD。用户可以灵活选用不同型号的模块以满足多样化的市场需求。

九联科技推出的UMA201 LTE Cat4 通信模组采用了海思Balong711芯片平台，支持TCP/UDP/PPP/FTP/NTP/PING/CMUX等数据传输协议及3GPP标准AT指令、增强的AT扩展指令。



## Linux 驱动集成

模组支持 ECM、NCM、RNDIS 三种 usb 传输协议。

```shell
CONFIG_USB_USBNET=y 
CONFIG_NETDEVICES=y 
CONFIG_USB_NET_CDCETHER=y 
CONFIG_USB_NET_RNDIS_HOST=y
```



| 驱动                 | 支持系统                                                     |
| -------------------- | ------------------------------------------------------------ |
| USB 驱动             | Windows7/10、Linux2.6及以上、Android4.0及以上、WinCE5.0/6.0/7.0* |
| RIL 驱动             | Android4.0及以上*                                            |
| NDIS 驱动            | Windows7/8/8.1/10*                                           |
| WWAN 驱动            | Windows7                                                     |
| ECM、NCM、RNDIS 驱动 | Windows7/10、Linux2.6及以上                                  |



### PPP 配置





### USB 端口说明

| 端口说明         | Linux 设备节点名 | PC 设备管理器中名称                              |
| ---------------- | ---------------- | ------------------------------------------------ |
| AT 端口          | /dev/ttyUSB0     | HUAWEI Mobile Connect - PC UI Interface          |
| 3G 数据调试端口  | /dev/ttyUSB1     | HUAWEI Mobile Connect - 3G Application Interface |
| 数据调试端口     | /dev/ttyUSB2     | HUAWEI Mobile Connect - GPS Interface            |
| LTE 数据调试端口 | /dev/ttyUSB3     | HUAWEI Mobile Connect - Application Interface    |
| Modem 端口       | /dev/ttyUSB4     | HUAWEI Mobile Connect – Netword Card             |



## 九联模块 - UMA201 Mini PCIe

UMA201 Mini PCIe是一款支持TDD-LTE/FDD-LTE/ WCDMA /GSM 的无线通信模组。支持 TDD-LTE、FDD-LTE 网络数据连接，并向下兼容 WCDMA 的 DC-HSPA+网络数据连接，可为客户提供数字语音（PCM)、短信等功能。 

UMA201 Mini PCIe 采用先进的高度集成设计方案，将射频、基带集成在一块 PCB 上，完成无线接收、发射、基带信号处理和音频信号处理功能。采用双面布局方式，支持 TCP/UDP/PPP/FTP/PING/CMUX 等数据传输协议及 3GPP 标准 AT 指令、增强的 AT 扩展指令。具有丰富的外围接口，可与众多终端设备、传感器进行连接使用，满足物联网的应用需求，广泛应用于安防监控、工业路由、车载视讯、工控板、CPE、路由器、PDA 等领域。 

UMA201 Mini PCIe 集成了 TD1030 定位芯片，支持 BeiDou/GPS/GLONASS 等主流定位系统，可为客户提供精确的定位服务。 

UMA201 Mini PCIe 模组采用 Mini PCIe 标准封装。尺寸为 30.0mm×50.95mm×4.9mm。

UMA201 Mini PCIe 复位方式有两种：硬件复位、AT 命令复位。





UMA201 是一款 LTE Cat4 多模无线通信模组，支持最大下行速率150Mbps和最大上行速率50Mbps，兼容WCDMA、 TD-SCDMA、GSM等网络，确保不同网络制式覆盖情况下的顺畅通信。

UMA201模组采用海思Balong711平台，支UDP/TCP/IP/PPP/FTP/NTP/HTTP/HTTPS/PING/CMUX/SSL/MQTT等数据传输协议及3GPP标准AT指令、增强的AT扩展指令。具有丰富的外围接口，可与众多终端设备、传感器进行连接使用，满足物联网的应用需求，广泛应用于安防监控、工业路由、车载视讯、工控板、路由器、PDA等领域。

UMA201模组是LCC+LGA封装的贴片式模组，144个引脚，其中80个为LCC引脚，另外64个为 LGA 引脚。尺寸仅有28.9mm×31.9mm×2.4mm。



UMA201 Mini PCIe 是一款LTE Cat4多模无线通信模组，支持最大下行速率150Mbps和最大上行速率50Mbps，兼容WCDMA、 TD-SCDMA、GSM等网络，确保不同网络制式覆盖情况下的顺畅通信，集成GNSS定位功能，支持BeiDou、GPS、GLONAS，具有高灵敏度和高定位精度，满足不同场景下的定位需求。

UMA201 Mini PCIe 模组采用海思Balong711平台，支持UDP/TCP/IP/PPP/FTP/NTP/HTTP/HTTPS/PING/CMUX/SSL/MQTT等数据传输协议及3GPP标准AT指令、增强的AT扩展指令。具有丰富的外围接口，可与众多终端设备、传感器进行连接使用，满足物联网的应用需求，广泛应用于安防监控、工业路由、车载视讯、工控板、路由器、PDA等领域。

UMA201 Mini PCIe 模组尺寸为30.0mm×50.0mm×4.9mm。





## 参考

- [喜讯！九联科技携手华为海思推出UMA201 LTE Cat4 通信模组成功入库中国电信！-九联科技 (unionman.com.cn)](http://www.unionman.com.cn/newsshow-11-293-1.html)

