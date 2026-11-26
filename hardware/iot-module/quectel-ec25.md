---
sidebar_position: 3
---

# Quectel EC25

![](https://static.getiot.tech/quectel-ec25-x.png#center)

## 简介

EC25 是移远通信专为 M2M 和 IoT 领域而设计的 LTE Cat 4 无线通信模块，采用 3GPP Rel. 11 LTE 技术，支持最大下行速率 150 Mbps 和最大上行速率 50 Mbps。同时，EC25 在封装上兼容移远通信多网络制式 LTE Standard EC21/EC20 R2.1/EG25-G/EG21-G/EC200T 模块和 UMTS/HSPA+ UC200T 模块，实现了从 3G 网络向 4G 网络的轻松平滑过渡。

EC25 系列包含 13 个版本： EC25-E、EC25-EU、EC25-EUX、EC25-J、EC25-A、EC25-V、EC25-AF、EC25-AFX、EC25-MX、EC25-AUT、EC25-AUTL、EC25-AU 和 EC25-AUX ；使其向后兼容现存的 EDGE 和 GSM/GPRS 网络，确保在缺乏 3G 和 4G 网络的偏远地区也能正常工作。

基于高通先进的 IZat™定位技术（Gen8C Lite），EC25 集成了多星座 GNSS 接收机，支持 GPS、GLONASS、BeiDou（Compass）、Galileo 和 QZSS 定位技术，能实现更快、更准、更可靠的定位。内置的 GNSS 也大大简化了客户应用的设计。

EC25 内置丰富的网络协议，集成多个工业标准接口，并支持多种驱动和软件功能（如 Windows 7/8/8.1/10、Linux、Android 等操作系统下的 USB 虚拟串口驱动，eCall* 等）；极大地拓展了其在 M2M 和 IoT 领域的应用范围，如工业级路由器、工业级 PDA、平板电脑、视频监控、数字标牌等。



### 特性

- 专为 M2M 和 IoT 应用而设计的 LTE Cat 4 无线通信模块
- 各网络制式的全面覆盖
- 集成多星座 GNSS 接收机，满足不同环境下对快速、精准定位的需求
- 支持 DFOTA、eCall*和 DTMF 功能
- MIMO 技术满足无线通信系统对数据速率和连接可靠性的要求
- 内嵌多种网络协议
- 支持 Quectel 增强型 AT 命令



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



### EC25 Mini PCIe

开发中常见的 EC25 模块是采用标准 PCI Express® 迷你卡外形的 Quectel EC25 Mini PCIe 系列。

![](https://static.getiot.tech/EC25_Mini_PCIe_Layered-1-1-600x450.png#center-400)

安装驱动后，在 Windows 环境下会虚拟出 3 个 COM 口，分别是 AT Port（用于 AT 指令的收发）、DM Port（用于烧录固件和 PPP 拨号）和 NMEA Port（用于 GPS NMEA 数据的接收）。

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

| 指令     | 功能                                                         |
| -------- | ------------------------------------------------------------ |
| AT       | 测试指令，返回 OK。                                          |
| ATE0     | 关闭回显，返回 OK。                                          |
| AT+CGMM  | 获取模块标识，返回 EC25。                                    |
| AT+CCLK? | 获取网络时间，返回格式详见参考手册。<br/>（注意此处返回的时间是基站本地时间，可能需要自己转换成北京时间） |
| AT+CPIN? | 查询 SIM 卡状态，返回 READY 表示该 SIM 没有设定锁定模式。    |
| AT+QCCID | 获取 SIM 卡号。返回格式详见参考手册。                        |
| AT+CIMI  | 获取 IMSI 号，即国际移动用户识别码。                         |
| AT+CSQ   | 获取信号强度，返回 0-31，返回 99 为无信号。                  |
| AT+QPOWD | 模块关机。                                                   |



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



### 发送短信

| 指令                  | 功能                                                        |
| --------------------- | ----------------------------------------------------------- |
| AT+CMGF=1             | 将消息格式设置为 Text mode。                                |
| AT+CSCS="GSM"         | 通知模块 TE 使用 GSM 默认字母字符集 。                      |
| AT+CMGS="13450231024" | 准备发送短信，收到 ">" 后填入短信内容，按 Ctrl-Z 发送短信。 |




## 资源下载

### QCOM 串口工具

- 官网下载：[QCOM_V1.6 | Quectel](https://www.quectel.com/download/qcom_v1-6/)
- 百度下载：[https://pan.baidu.com/s/19GosmNs_tZ7b2ri_j42XNw](https://pan.baidu.com/s/19GosmNs_tZ7b2ri_j42XNw)（提取码：ym3w）

### QFlash 烧录工具

- QFlash_V4.12：[https://pan.baidu.com/s/1DLUvNKaiFLSej4GJtKsf8A](https://pan.baidu.com/s/1DLUvNKaiFLSej4GJtKsf8A)（提取码：dh2m）

### Windows 驱动

- [Quectel_LTE&5G_Windows_USB_Driver_V2.2.4.zip](https://cnquectel-my.sharepoint.com/:u:/g/personal/ae-fae_quectel_com/ETP0iQqO4GZHhZWxc7hIA9EBwVMIdCAlWPUedcdBB95j9A?e=hx1GMb)



## 扩展阅读

- [Raspberry Pi 使用 4G 數據網路](https://newjerseystyle.github.io/zh-TW/2020/Raspberry-Pi-使用-4G-數據網路/)

