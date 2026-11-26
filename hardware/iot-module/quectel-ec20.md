---
sidebar_position: 2
---

# Quectel EC20



![](https://static.getiot.tech/ec20-r2-1-quectel-4g-lte-gsm-gprs-module-500x500.png#center-300)



## 简介

EC20 是移远通信推出的 LTE Cat 4 无线通信模块，采用 LTE 3GPP Rel.11 技术，支持最大下行速率 150Mbps 和最大上行速率 50Mbps。能在 LTE-FDD、LTE-TDD、DC-HSPA+、WCDMA、EDGE 及 GPRS 等多种网络制式中进行数据通信；同时在封装上兼容移远通信 UMTS/HSPA+ UC200T 系列模块以及多网络制式 LTE Standard EC20 R2.1/EG25-G/ EG21-G/EC21 系列/EC25 系列/EC200T 系列模块，实现了 3G 网络与 4G 网络之间的无缝切换。

EC20 系列模块包含 EC20-A、EC20-C、EC20-CE 和 EC20-E 四个版本，使其能够向后兼容现存的 EDGE 和 GSM/GPRS 网络，以确保在缺乏 3G 和 4G 网络的偏远地区也能正常工作。

EC20 支持多输入多输出技术（MIMO），即在发射端和接收端分别使用多个发射天线和接收天线，使信号通过发射端与接收端的多个天线传送和接收，从而降低误码率，改善通信质量。同时，它结合了高速无线连接与内置多星座高精度定位 GPS+GLONASS 接收器。

EC20 内置丰富的网络协议，集成多个工业标准接口，并支持多种驱动和软件功能（如 Windows XP，Windows Vista， Windows 7/8/8.1/10，Linux，Android 等操作系统下的 USB 驱动，eCall* 等），极大地拓展了其在 M2M 领域的应用范 围，如 CPE、路由器、数据卡、平板电脑、车载、安防以及工业级 PDA 等。



### 特性

- 各网络制式的全面覆盖
- 紧凑尺寸的 SMT 封装形式满足小型终端产品对空间的需求
- MIMO 技术满足无线通信系统对数据速率和连接可靠性的要求
- 内置多星座 GNSS 接收机，满足不同环境条件下对快速、精准 定位的需求
- 轻松实现 3G 与 4G 网络之间的无缝切换



### 驱动支持

| 驱动          | 支持平台                                                     |
| ------------- | ------------------------------------------------------------ |
| USB 串口驱动  | Windows 7/ 8/ 8.1/ 10,  Linux 2.6~5.4,  Android 4.x/ 5.x/ 6.x/7.x/9.x |
| GNSS 驱动     | Android 4.x/ 5.x/ 6.x/ 7.x/8.x/9.x                           |
| RIL 驱动      | Android 4.x/ 5.x/ 6.x/ 7.x/8.x/9.x                           |
| NDIS 驱动     | Windows 7/ 8/ 8.1/ 10                                        |
| MBIM 驱动     | Windows 8/ 8.1/ 10, Linux 3.8~5.4                            |
| GobiNet 驱动  | Linux 2.6~5.4                                                |
| QMI_WWAN 驱动 | Linux 3.4~5.4                                                |



### EC20 Mini PCIe

开发中常见的 EC20 模块是采用标准 PCI Express® 迷你卡外形的 Quectel EC20 Mini PCIe 系列。虽然物理接口是 PCIe，但实现走的信号是 USB，因此在 Linux 上使用非常方便。

![](https://static.getiot.tech/EC20_Mini_PCIe_Layered-1-600x450.png#center-400)

安装驱动后，在 Windows 环境下会虚拟出 3 个 COM 口，分别是 AT Port（用于 AT 指令的收发）、DM Port（用于烧录固件）和 NMEA Port（用于 GPS NMEA 数据的接收）。

![](https://static.getiot.tech/quectel-ec25-virtual-com.png#center)

在 Linux 环境下会虚拟出 4 个 ttyUSB 串口设备节点，串口对应功能如下：

- ttyUSB0 → DM
- ttyUSB1 → For GPS NMEA message output
- ttyUSB2 → For AT command communication
- ttyUSB3 → For PPP connections or AT command communication

```bash
$ ls -l /dev/ttyUSB*
crw-rw---- 1 root dialout 188, 0 6月  23 09:26 /dev/ttyUSB0
crw-rw---- 1 root dialout 188, 1 6月  23 09:26 /dev/ttyUSB1
crw-rw---- 1 root dialout 188, 2 6月  23 09:26 /dev/ttyUSB2
crw-rw---- 1 root dialout 188, 3 6月  23 09:26 /dev/ttyUSB3
```



## 使用

### 通用 AT 指令

| 指令        | 功能                                                         |
| ----------- | ------------------------------------------------------------ |
| AT          | 测试指令，返回 OK。                                          |
| ATE0        | 关闭回显，返回 OK。（ATE1 为开启模块回显）                   |
| AT+CGMM     | 查询模块型号，返回 EC20。                                    |
| AT+CGMR     | 查询软件版本号，返回如 EC20CEQAR02A03E2G_BETA1126。          |
| AT+CGSN     | 查询产品 IMEI 序列号，返回如 864977045287475。               |
| AT+CPAS     | 查询当前状态，0 表示 Ready，3 表示 Ringing，4表示 Call hold。 |
| AT+CCLK?    | 获取网络时间，返回格式详见参考手册。<br/>（注意此处返回的时间是基站本地时间，可能需要自己转换成北京时间） |
| AT+CPIN?    | 查询 SIM 卡状态，返回 READY 表示该 SIM 没有设定锁定模式。    |
| AT+QCCID    | 获取 SIM 卡号。返回格式详见参考手册。                        |
| AT+CIMI     | 获取 IMSI 号，即国际移动用户识别码。                         |
| AT+CSQ      | 获取信号强度，返回 0-31，返回 99 为无信号。                  |
| AT+QPOWD    | 模块关机。                                                   |
| AT+CFUN=1,1 | 重启模块。                                                   |



### 网络连接 AT 指令

| 指令                                             | 功能                                                         |
| ------------------------------------------------ | ------------------------------------------------------------ |
| AT+CREG?                                         | 查询网络是否注册成功，成功返回 OK。                          |
| AT+QICSGP=xxx                                    | 配置 TCP/IP 环境，成功返回 OK。                              |
| AT+QIACT=1                                       | 激活 TCP/IP 环境，成功返回 OK。                              |
| AT+QIOPEN=1,0,"TCP","ip",port,0,2                | 建立 TCP 连接（透传模式），连接成功返回 CONNECT。            |
| AT+QIOPEN=1,2,"UDP SERVICE","127.0.0.1",0,3030,1 | 创建 UDP 服务器。成功返回 OK。                               |
| AT+QISEND=2,len,"ip",port                        | UDP 准备发送数据指令，收到 ">" 后将数据发送出去，发送成功收到 SEND OK。 |
| AT+QICLOSE=0/2                                   | 关闭连接（此处的0/2是连接号，由之前的 AT+QIOPEN 指令开启）。 |



### 短信收发

| 指令                  | 功能                                                         |
| --------------------- | ------------------------------------------------------------ |
| AT+CPMS?              | 查询短信存储区。                                             |
| AT+CNMI=1,2,0,1,0     | 选择如何接收短信息。                                         |
| AT+CSCA?              | 查询短信服务中心地址。                                       |
| AT+CMGF=1             | 设置短信发送为文本格式（Text mode），如果设为 0，则表示 PDU 编码格式。 |
| AT+CSCS="GSM"         | 通知模块 TE 使用 GSM 默认字母字符集 。                       |
| AT+CMGS="13450231024" | 准备发送短信，收到 ">" 后填入短信内容，按 Ctrl-Z（0x1A）发送短信，取消发送按 Ctrl+ESC（0x1B）。 |
| AT+CMGR=0             | 读取相对应序号的短信。                                       |
| AT+CMGD=1             | 删除短信，只能逐条删除。                                     |




## 资源下载

### QCOM 串口工具

- 官网下载：[QCOM_V1.6 | Quectel](https://www.quectel.com/download/qcom_v1-6/)
- 百度下载：[https://pan.baidu.com/s/19GosmNs_tZ7b2ri_j42XNw](https://pan.baidu.com/s/19GosmNs_tZ7b2ri_j42XNw)（提取码：ym3w）

### QFlash 烧录工具

- QFlash_V4.12：[https://pan.baidu.com/s/1DLUvNKaiFLSej4GJtKsf8A](https://pan.baidu.com/s/1DLUvNKaiFLSej4GJtKsf8A)（提取码：dh2m）

### Windows 驱动

- [Quectel_LTE&5G_Windows_USB_Driver_V2.2.4.zip](https://cnquectel-my.sharepoint.com/:u:/g/personal/ae-fae_quectel_com/ETP0iQqO4GZHhZWxc7hIA9EBwVMIdCAlWPUedcdBB95j9A?e=hx1GMb)



## 扩展阅读

- [物联网基础：移远EC20固件升级](https://www.codenong.com/cs107076548/)