---
sidebar_position: 15
authors: [luhuadong]
---

# RT-Thread 软件包汇总



本文汇总了 RT-Thread 的软件包列表，包括 AI、IoT、Signal process、Language、Multimedia、Peripherals、Security、System、Tools、Misc 十大类别，六百多个软件包。

特别声明：数据使用 [rtthread_software_package_list_show](https://github.com/supperthomas/rtthread_software_package_list_show) 工具自动拉取和更新。



## iot

 | 包名 | 作者  | license   | 备注      |
| ------------------------------------------------------------ | ------------------- | -------------------- | ------------------------------------------------------------ |
| [RyanW5500](https://github.com/Ryan-CW-Code/RyanW5500) |Ryan-CW|Apache-2.0|W5500 BSD套接字实现。|
| [airkissOpen](https://github.com/heyuanjie87/airkissOpen) |heyuanjie87|Apache-2.0|腾讯airkiss协议解析库|
| [lssdp](https://github.com/RT-Thread-packages/lssdp.git) |RealThread|MIT|在 RT-Thread 上实现的 lssdp 协议，可以用于局域网设备自动发现|
| [capnp](https://github.com/wuhanstudio/capnp) |wuhanstudio|MIT|Cap'n 串行化协议，比 protobuf 更高效，更轻量级。|
| [pahomqtt](https://github.com/RT-Thread-packages/paho-mqtt) |RealThread|EPL-1.0|Eclipse 开源的 MQTT C/C++ 客户端|
| [bc28_mqtt](https://github.com/luhuadong/rtt-bc28-mqtt) |luhuadong|Apache-2.0|BC28 MQTT: 使用移远BC28模块连接阿里云IoT平台|
| [mymqtt](https://github.com/hichard/mymqtt) |hichard|EPL-1.0|Eclipse 开源的 MQTT C/C++ 客户端的一种高效、稳定的实现。|
| [cmux](https://github.com/RT-Thread-packages/cmux) |xiangxistu|Apache-2.0|在 RT_Thread 上实现的串口多路复用协议, 支持 GSM0710|
| [freemodbus](https://github.com/RT-Thread-packages/freemodbus) |flybreak|BSD|FreeModbus: 开源的 Modbus 主从协议栈|
| [netutils](https://github.com/RT-Thread-packages/netutils) |RealThread|Apache-2.0|RT-Thread 网络网络小工具集|
| [WebTerminal](https://github.com/armink-rtt-pkgs/WebTerminal) |armink|unknown|可以在浏览器上运行的终端|
| [smtp_client](https://github.com/WKJay/SMTP_CLIENT) |WKJay|LGPL-2.1|SMTP邮件发送软件包，简单易用，支持普通25端口及465/587加密端口|
| [RyanMqtt](https://github.com/Ryan-CW-Code/RyanMqtt) |Ryan-CW|Apache-2.0|RyanMqtt 实现了 MQTT3.1.1 协议的客户端。此库针对资源受限的嵌入式设备进行了优化。|
| [llsync_sdk_adapter](https://github.com/supperthomas/LLSync_sdk_adapter) |supperthomas|Apache-2.0|腾讯llsync sdk ble sdk sample|
| [nanopb](https://github.com/RT-Thread-packages/nanopb) |RealThread|Zlib|Protocol Buffers 解析器在嵌入式上的实现|
| [bsal](https://github.com/RT-Thread-packages/bsal) |supperthomas|Apache-2.0|蓝牙协议栈抽象层。|
| [ipmsg](https://github.com/heyuanjie87/ipmsg) |heyuanjie87|Apache-2.0|在 RT-Thread 上实现的 飞鸽传书|
| [zephyr_polling](https://github.com/bobwenstudy/RTT_PACKAGE_zephyr_polling) |bobwenstudy|Apache-2.0|zephyr_polling: 蓝牙BLE协议栈。|
| [tcpserver](https://github.com/Guozhanxin/tcpserver.git) |flybreak|Apache-2.0|一个支持多客户端的 TCP 服务器|
| [lora_pkt_sniffer](https://github.com/Forest-Rain/lora-pkt-sniffer) |forest-rain|Apache-2.0|lora_pkt_sniffer是一个lora(wan)数据包的抓包工具|
| [hm](https://github.com/Jackistang/HCI-Middleware) |Jackistang|Apache-2.0|一个通用的蓝牙 HCI 传输层|
| [rtt-matter-adaptation-layer](https://github.com/kurisaW/RTT-MATTER-Adaptation_Layer) |kurisaW|Apache-2.0|CSA联盟指导的Matter协议栈在RT-Thread的移植|
| [libcurl2rtt](https://github.com/liu2guang/libcurl2rtt) |liu2guang|Apache-2.0|基于 RT-Thread 移植的 curl 库|
| [at_device](https://github.com/RT-Thread-packages/at_device) |RealThread|LGPL-2.1|AT 组件在不同设备上的移植或示例|
| [tencent-iot-sdk](https://github.com/tencentyun/tencent-cloud-iot-package-for-rtthread) |yougaliu|MIT|连接腾讯物联网开发平台的软件包。|
| [GAgent](https://github.com/RT-Thread-packages/GAgent) |RealThread|LGPL-2.1|连接机智云的软件包|
| [azure-iot-sdk](https://github.com/RT-Thread-packages/azure-iot-sdk) |RealThread|MIT|微软 azure 云软件包，支持 MQTT 协议和 HTTP 协议，使用该软件包可轻松将设备连接至 azure 云平台|
| [ez_iot_os](https://github.com/Ezviz-OpenBiz/ez_iot_os.git) |EZVIZ IoT Team|Eclipse Public License v1.0|连接萤石云 IoT 平台的软件包|
| [onenet](https://github.com/RT-Thread-packages/onenet) |RealThread|LGPL-2.1|连接中国移动 OneNet 云的软件包|
| [jiot-c-sdk](https://github.com/jpush/JIoT-rtthread-package.git) |ouyangshengduo|MIT|连接极光IoT云的客户端软件包|
| [joylink](https://github.com/RT-Thread-packages/joylink) |RealThread|Apache-2.0|连接京东小京鱼 IOT 云平台的软件包|
| [iotsharp-c-sdk](https://github.com/IoTSharp/iotsharp-rtthread-package) |maikebing|MIT|IoTSharp的客户端软件|
| [ali-iotkit](https://github.com/RT-Thread-packages/ali-iotkit) |RealThread|Apache-2.0|连接阿里 IoT 云平台的软件包|
| [ucloud_iot_sdk](https://github.com/ucloud/ucloud-iot-rtthread-package.git) |ucloud|Apache-2.0|用于快速连接优刻得物联网平台的软件包。|
| [librws](https://github.com/RT-Thread-packages/librws) |RealThread|MIT|小型、跨平台websocket客户端C库。|
| [EmbeddedProto](https://github.com/wuhanstudio/EmbeddedProto) |wuhanstudio|GPL-3.0|EmbeddedProto: 嵌入式 C++ protobuf 针对 ARM Cortex-M 优化|
| [ota_downloader](https://github.com/RT-Thread-packages/ota_downloader) |RealThread|Apache-2.0|基于 RT-Thread OTA 组件的 固件下载器|
| [nmealib](https://github.com/ShineRoyal/nmealib) |ShineRoyal|LGPL-2.1|nmealib库在RT-Thread上的移植|
| [atsrv_socket](https://github.com/RT-Thread-packages/atsrv_socket) |RealThread|Apache-2.0|socket 相关指令的 AT 服务端|
| [nopoll](https://github.com/RT-Thread-packages/nopoll) |RealThread|LGPL-2.1|一款 C 实现的开源 WebSocket 软件包|
| [agile_modbus](https://github.com/loogg/agile_modbus) |loogg|Apache-2.0|轻量级 modbus 协议栈。|
| [dlt645](https://github.com/WKJay/DLT645) |WKJay|LGPL-2.1|基于DLT645协议的主机采集软件包|
| [zFTP](https://github.com/longtengmcu/zFTP.git) |longtengmcu|Apache-2.0|ligth weight FTP client|
| [kawaii-mqtt](https://github.com/jiejieTop/kawaii-mqtt) |jiejie|GPL-2.0|一个基于socket API之上的跨平台MQTT客户端，拥有非常简洁的API接口，以极少的资源实现QOS2的服务质量，并且无缝衔接了mbedtls加密库。|
| [small_modbus](https://github.com/cazure/small_modbus.git) |chenbin182|Apache-2.0|small modbus协议栈|
| [wiznet](https://github.com/RT-Thread-packages/wiznet) |RealThread|Apache-2.0|WIZNet TCP/IP 芯片（例如： W5500/W5100）的 SAL 框架对接实现|
| [wlan_cyw43012](https://github.com/Guozhanxin/cyw43012-RTT) |RealThread|Apache-2.0|CYW43012 的 wlan 驱动|
| [rw007](https://github.com/RT-Thread-packages/rw007) |RealThread|Apache-2.0|RT-Thread 的 RW007 驱动（SPI Wi-Fi 模式）|
| [wlan_wiced](https://github.com/RT-Thread-packages/wlan-wiced) |RealThread|GPL-2.0|WICED 的 wlan 驱动|
| [wlanmarvell](https://github.com/JianRuiqian/marvellwifi) |JianRuiqian|GPL-2.0|RT-Thread 的 Marvell wifi 驱动|
| [wayz_iotkit](https://github.com/wayz-iot/wayz_iotkit) |jianxiong.ye|GPL-2.0|wayz iot 定位软件包|
| [agile_ftp](https://github.com/loogg/agile_ftp) |loogg|LGPL-2.1|轻量级 ftp 服务器。|
| [coap](https://github.com/RT-Thread-packages/coap) |RealThread|BSD-2-Clause|一种 C 语言实现的 CoAP 协议|
| [webnet](https://github.com/RT-Thread-packages/webnet) |RealThread|GPL-2.0|RT-Thread 官方开源的、轻量级、可定制嵌入式 Web 服务器|
| [mongoose](https://github.com/armink-rtt-pkgs/mongoose) |armink|GPL-2.0|一款嵌入式 Web 服务器库|
| [net_server](https://github.com/WKJay/net-server) |WKJay|Apache-2.0|TCP/TLS 服务器，支持wolfssl。|
| [abup_fota](https://github.com/RayShen1018/Abup) |RayShen1018|Apache-2.0|基于 abup FOTA 组件的 固件下载器|
| [rt-link_hw](https://github.com/RT-Thread-packages/rt-link_hw) |RealThread|Apache-2.0|rt-link 组件的底层通信端口适配层|
| [agile_telnet](https://github.com/loogg/agile_telnet) |loogg|LGPL-2.1|以太网TCP调试。|
| [protobuf-c](https://github.com/wuhanstudio/protobuf-c) |wuhanstudio|MIT|Google 的 prototol buffer 一种轻便高效的数据存储格式|
| [NimBLE](https://github.com/RT-Thread-packages/nimble) |RealThread|Apache-2.0|Apache 开源蓝牙 5.0 协议栈在 RT-Thread 的移植|
| [pdulib](https://github.com/ShineRoyal/pdulib) |ShineRoyal|LGPL-2.1|一个用于PDU格式的短信文本解析库|
| [btstack](https://github.com/supperthomas/RTT_PACKAGE_BTSTACK.git) |supperthomas|non-commercial|软件包 btstack 用于BTSTACK在RT-THREAD中的使用|
| [umqtt](https://github.com/RT-Thread-packages/umqtt.git) |springcity|Apache-2.0|一个轻量级、功能强大、可定制、易于使用和可嵌入的RT-Thread mqtt客户端。|
| [lorawan_driver](https://github.com/zyk6271/LoRaWAN_Driver) |zyk6271|Apache-2.0|将LoRaWAN协议栈运行在RT-THREAD系统上|
| [lora_pkt_fwd](https://github.com/Forest-Rain/lora-pkt-fwd) |forest-rain|Apache-2.0|lora_pkt_fwd实现基于Semtech GWMP协议的LoRaWAN协议包转发|
| [lwip](https://github.com/RT-Thread-packages/lwip) |RT-Thread-packages|BSD|LwIP上游同步|
| [wol](https://github.com/WKJay/wol) |WKJay|Apache-2.0|实现网络唤醒功能|
| [ppp_device](https://github.com/RT-Thread-packages/ppp_device.git) |xiangxistu|Apache-2.0|lwIP PPP 功能针对蜂窝( 2G/3G/4G )模块移植和实现|
| [zb_coordinator](https://github.com/TaoYang0907/ZB_COORDINATOR_PACKAGE) |TaoYang0907|LGPL-2.1|AT命令在ZigBee协调器上的应用|
| [qxwz](https://github.com/RT-Thread-packages/qianxun.git) |daniel.chen|Apache-2.0|qxwz 高精度定位应用|
| [lorawan_ed_stack](https://github.com/Forest-Rain/lorawan-ed-stack) |Forest-Rain|Apache-2.0|lorawan_ed_stack是LoRaWAN终端设备协议栈的实现.|
| [mavlink](https://github.com/sogwms/mavlink) |sogwms|Apache-2.0|一非常轻量级的消息传输协议|
| [webclient](https://github.com/RT-Thread-packages/webclient) |RealThread|Apache-2.0|RT-Thread 官方开源的 http/https 协议客户端|

## signalprocess

 | 包名 | 作者  | license   | 备注      |
| ------------------------------------------------------------ | ------------------- | -------------------- | ------------------------------------------------------------ |
| [DigitalCtrl](https://github.com/xuzhuoyi/DigitalCtrl) |xuzhuoyi|MIT|数字闭环控制算法库|
| [ukal](https://github.com/wuhanstudio/ukal) |wuhanstudio|MIT|卡尔曼滤波算法|
| [qpid](https://github.com/qiyongzhong0/rt-thread-qpid) |qiyongzhong0| LGPL-2.1|一款快捷易用的PID自动控制算法包，支持增量式和位置式算法。|
| [CMSIS-DSP](https://github.com/RT-Thread-packages/CMSIS-DSP) |ARM-software|Apache-2.0|CMSIS-DSP嵌入式计算库（Cortex-M和Cortex-A）|
| [kissfft](https://github.com/mborgerding/kissfft) |mborgerding|BSD-3-Clause|简单、快速的FFT(快速傅里叶变换)算法软件包|
| [fire_pid_curve](https://github.com/LONGZR007/fire_pid_curve.git) |LONGZR007|LGPL-2.1|野火PID调试助手通讯协议软件包|

## misc

 | 包名 | 作者  | license   | 备注      |
| ------------------------------------------------------------ | ------------------- | -------------------- | ------------------------------------------------------------ |
| [hello](https://github.com/RT-Thread-packages/hello) |RealThread|LGPL-2.1|RT-Thread 软件包示例|
| [MultiButton](https://github.com/liu2guang/MultiButton) |0x1abin|MIT|一个小巧易用的事件驱动按钮驱动模块|
| [libcsv](https://github.com/liu2guang/libcsv) |liu2guang|LGPL-2.1|libcsv是用纯ANSI C89编写的小型、简单、快速的CSV库，支持读写CSV数据|
| [armv7m_dwt](https://github.com/sogwms/armv7m_dwt) |sogwms|Apache-2.0|armv7m_dwt 高精度计时与延时|
| [MFBD](https://github.com/smartmx/MFBD) |smartmx|Apache-2.0|多功能按键扫描程序，支持无限按键、多次连击|
| [miniLZO](https://github.com/RT-Thread-packages/miniLZO) |RealThread|GPL-2.0|LZO 是一个实时数据压缩库，而 miniLZO 是 LZO 压缩库的精简版本|
| [zlib](https://github.com/RT-Thread-packages/zlib) |RealThread|unknown|通用数据压缩库|
| [minizip](https://github.com/mysterywolf/minizip) |Meco Man|unknown|zip压缩解压库|
| [CanFestival](https://github.com/gbcwbz/canfestival-rtt) |gbcwbz|LGPL-2.1|Canfestival (开源的 CANopen 协议栈)在 RT-Thread 系统上的移植|
| [CorevMCU_CLI](https://github.com/Yaochenger/CorevMCU_CLI) |Yaochenger|LGPL-2.1|Core-V-MCU的CLI组件|
| [Controller](https://github.com/haodongnj/Controller) |hao.dong|MIT|比例积分, 比例谐振, 重复控制器库|
| [lzma](https://github.com/RiceChen0/lzma) |RiceChen|LGPL-2.1|高压缩率的压缩库|
| [get_irq_priority](https://github.com/wdfk-prog/rt-thread-get_irq_priority) |hly|LGPL-2.1|获取Cortex®-M内核的中断优先级.|
| [slcan2rtt](https://github.com/cazure/slcan2rtt.git) |cazure|Apache-2.0|串行线路CAN适配器 (slcan).|
| [cmatrix](https://github.com/wuhanstudio/cmatrix) |wuhanstudio|MIT|text flying in and out in a terminal like as seen in 'The Matrix' movie|
| [c2048](https://github.com/mysterywolf/c2048) |Meco Man|MIT|2048是一款益智类游戏，原版游戏运行在苹果手机上|
| [sl](https://github.com/wuhanstudio/sl) |wuhanstudio|MIT|sl奔跑的小火车命令|
| [threes](https://github.com/mysterywolf/threes) |Meco Man|MIT|threes是一款在2014年很火的益智类游戏，原版游戏运行在苹果手机上|
| [cal](https://github.com/mysterywolf/cal) |Meco Man|MIT|终端公历日历|
| [donut](https://github.com/mysterywolf/donut) |Meco Man|None|使用字符渲染的3D旋转甜甜圈|
| [aclock](https://github.com/mysterywolf/aclock) |Meco Man|Apache-2.0|终端钟表界面|
| [snake](https://github.com/mysterywolf/snake) |Meco Man|GPL-2.0|贪吃蛇游戏|
| [morse](https://github.com/zhkag/morse) |zhkag|None|摩尔斯电码|
| [tetris](https://github.com/volatile-static/rtt_tetris) |volatile-static|MIT|俄罗斯方块|
| [cowsay](https://github.com/wuhanstudio/cowsay) |wuhanstudio|MIT|linux cowsay 软件包|
| [heatshrink](https://github.com/liukangcc/heatshrink.git) |liukangcc|ISC License|用于嵌入式实时系统的数据压缩/解压缩库|
| [vi](https://github.com/RT-Thread-packages/vi) |RealThread|GPL-2.0|vi 编辑器在 RT-Thread 操作系统上的移植|
| [state_machine](https://github.com/redoccheng/state_machine) |redoccheng|LGPL-2.1|一个用C语言实现功能丰富但简单的有限状态机（FSM）。|
| [soem](https://github.com/lg28870983/soem) |lg28870983|Apache-2.0|开源 EtherCAT 主站 SOEM 在RT-Thread系统上的移植|
| [crclib](https://github.com/qiyongzhong0/crclib) |qiyongzhong0| LGPL-2.1|一个包含8位、16位、32位CRC校验计算的函数库|
| [qparam](https://github.com/qiyongzhong0/rt-thread-qparam) |qiyongzhong0| LGPL-2.1|一个快捷易用的参数管理组件，实现了参数保存、恢复、修改和快速存取功能.|
| [uparam](https://github.com/aeo123/uparam.git) |zpw|MIT|系统参数读写管理和持久化|
| [fastlz](https://github.com/RT-Thread-packages/fastlz) |RealThread|unknown|一款极速的压缩库|
| [filesystem_samples](https://github.com/RT-Thread-packages/filesystem-sample) |RealThread|Apache-2.0|RT-Thread 文件系统示例|
| [peripheral_samples](https://github.com/RT-Thread-packages/peripheral-sample) |RealThread|Apache-2.0|RT-Thread 外设示例|
| [network_samples](https://github.com/RT-Thread-packages/network-sample) |RealThread|Apache-2.0|RT-Thread 网络示例|
| [kernel_samples](https://github.com/RT-Thread-packages/kernel-sample) |RealThread|Apache-2.0|RT-Thread 内核示例|
| [lwgps](https://github.com/orange2348/lwgps2rtt) |orange2348|MIT|轻量级GPS NMEA协议解析器|
| [quicklz](https://github.com/RT-Thread-packages/quicklz) |RealThread|GPL-3.0|世界上速度最快的压缩库|
| [upacker](https://github.com/aeo123/upacker.git) |zpw|MIT|串行通信链路协议|
| [optparse](https://github.com/liu2guang/optparse) |liu2guang|Unlicense|基于 RT-Thread 的 Getopt 命令行解析器|
| [dstr](https://github.com/RT-Thread-packages/dstr) |RealThread|LGPL-2.1|用 C 编写的动态字符串库|
| [design_pattern](https://github.com/chenyingchun0312/design_pattern) |chenyingchun0312|Apache-2.0|嵌入式C设计模式实现。|
| [TinyFrame](https://github.com/XXXXzzzz000/TinyFrame) |XXXXzzzz000|MIT|应用于串口设备（如 UART / RS232)的构建或者解析的库|
| [kendryte-demo](https://github.com/BernardXiong/kendryte-demo) |BernardXiong|Apache-2.0|Kendryte k210 demo|
| [phase-locked-loop](https://github.com/haodongnj/PLL) |hao.dong|MIT|锁相环与锁频环算法|
| [FlexibleButton](https://github.com/murphyzhao/FlexibleButton) |MurphyZhao|Apache License 2.0|小巧灵活的按键驱动程序（事件驱动、无限按键数量、可用中断模式）|
| [ki](https://github.com/mysterywolf/ki) |Meco Man|GPL-2.0|ki是一个带有C/C++语法高亮的终端编辑器|

## tools

 | 包名 | 作者  | license   | 备注      |
| ------------------------------------------------------------ | ------------------- | -------------------- | ------------------------------------------------------------ |
| [armv7m_DWT](https://github.com/balanceTWK/armv7m_DWT.git) |BalanceTWK|MIT|armv7m_DWT: 基于 ARMV7M 架构的内存监控组件.|
| [ulog_file](https://github.com/RT-Thread-packages/ulog_file.git) |ChenYong|Apache-2.0|ulog_file: 基于文件系统的 ulog 后端插件。|
| [SEGGER_RTT](https://github.com/supperthomas/RTTHREAD_SEGGER_TOOL.git) |supperthomas|Apache-2.0|使用JLINK的RTT代替UART console输出|
| [logmgr](https://github.com/RT-Thread-packages/logmgr.git) |ChenYong|Apache-2.0|logmgr: 日志管理系统功能支持|
| [mem_sandbox](https://github.com/mysterywolf/mem_sandbox) |Meco Man|MIT|RT-Thread 内存隔离沙箱|
| [MemoryPerf](https://github.com/SummerLife/MemoryPerf) |我夏了夏天|MIT|ARM CPU 内存性能测试。|
| [adbd](https://github.com/heyuanjie87/adbd) |heyuanjie87|Apache-2.0|在 RT-Thread 上实现的 Android ADB daemon|
| [CoreMark](https://github.com/wuhanstudio/coremark) |wuhanstudio|apache|EEMBC 的单片机性能测试小工具|
| [cBox](https://github.com/enkiller/cbox) |enkiller|Apache-2.0|CBOX: C 语言小工具。|
| [fdt](https://github.com/RT-Thread-packages/fdt) |RealThread|LGPL-3.0|RT-Thread 设备树工具包|
| [lwlog](https://github.com/wuhanstudio/lwlog) |wuhanstudio|MIT|lwlog:单文件日志打印库|
| [Micro-XRCE-DDS-Client](https://github.com/JcZou/Micro-XRCE-DDS-Client) |JCZou|Apache-2.0|micro-ros的中间层组件，提供了ros2消息发布/订阅的能力。|
| [UrlEncode](https://github.com/jch12138/UrlEncode.git) |jch12138|LGPL-2.1|一个简单易用的Url编解码工具|
| [anv_trace](https://github.com/wuhanstudio/anv_trace) |wuhanstudio|MIT|帮助跟踪代码执行过程|
| [devmem](https://github.com/luanxg/devmem) |luanxueguang|GPL-2.0|读写内存/寄存器的工具|
| [gbk2utf8](https://github.com/Ghazigq/gbk2utf8) |Ghazigq|Apache-2.0|GBK与UTF8编码之间的转换。|
| [gan_zhi](https://github.com/XYX12306/gan_zhi.git) |XYX12306|MIT|是一个根据公历日期、时得到相应的天干地支的工具软件包。|
| [zdebug](https://github.com/beisongcrt/zdebug.git) |beisongcrt|Apache-2.0|方便的调试工具，随时控制打印 log，查看、设置变量数据，执行函数。|
| [CmBacktrace](https://github.com/armink-rtt-pkgs/CmBacktrace) |armink|MIT|ARM Cortex-M 系列 MCU 错误追踪库|
| [mbedtls_bench](https://github.com/xfan1024/rttpkg-mbedtls_bench) |xiaofan|MIT|mbedtls 性能测试|
| [bs8116a](https://github.com/illusionlee/bs8116a.git) |illusionlee|MIT|合泰的bs8116a-3的触摸按键芯片|
| [kdb](https://github.com/RT-Thread-packages/kdb) |enkiller|Apache-2.0|内核检测漏洞工具|
| [EasyLogger](https://github.com/armink-rtt-pkgs/EasyLogger) |armink|MIT|一款超轻量级(ROM < 1.6K, RAM < 0.3k)、高性能的 C/C++ 日志库|
| [nr_micro_shell](https://github.com/Nrusher/nr_micro_shell) |Nrusher|MIT|轻量的命令行交互工具。|
| [EasyFlash](https://github.com/armink-rtt-pkgs/EasyFlash) |armink|MIT|轻量级嵌入式 Flash 存储器库，让 Flash 成为小型 KV 数据库|
| [snowflake](https://github.com/2022alpha/snowflake) |2022alpha|MIT|雪花算法是一种分布式ID生成算法。|
| [regex](https://github.com/thread-liu/tiny-regex-c.git) |thread-liu|Unlicense|一个小巧的 C 语言正则表达式|
| [ulog_easyflash](https://github.com/armink-rtt-pkgs/ulog_easyflash) |armink|MIT|基于 EasyFlash 的 ulog 插件|
| [anv_testsuit](https://github.com/wuhanstudio/anv_testsuit) |wuhanstudio|MIT|单元测试框架|
| [gps_rmc](https://github.com/maplerian/gps_rmc) |maplerian|Apache-2.0|用于解析GPS模块的 $XXRMC 类型数据|
| [lunar_calendar](https://github.com/illusionlee/lunar_calendar.git) |illusionlee|MIT|将阳历日期转换为阴历的工具。|
| [wamr](https://github.com/bytecodealliance/wasm-micro-runtime.git) |alvkeke|Apache-2.0|运行于RT-Thread的WebAssembly Micro Runtime|
| [SystemView](https://github.com/RT-Thread-packages/SEGGER_SystemView) |RealThread|unknown|SEGGER 的 SystemView 移植|
| [hash-match](https://github.com/smartmx/hash-match) |smartmx|Apache-2.0|应用在单片机上快速匹配的哈希算法|
| [uMCN](https://github.com/JcZou/uMCN) |JCZou|Apache-2.0|uMCN是一个基于发布者/订阅者模式的轻量级且功能强大的跨线程/进程通信模块。|
| [lwrb2rtt](https://github.com/Jackistang/lwrb2rtt) |Jackistang|MIT|轻量级的 FIFO 环形缓冲区|
| [vconsole](https://github.com/enkiller/vconsole) |enkiller|Apache-2.0|一个虚拟控制台软件包。|
| [ChineseFontLibrary](https://github.com/lxzzzzzxl/Chinese_font_library) |lxzzzzzxl|LGPL-2.1|rt-thread中文字库软件包|
| [vofa_plus](https://github.com/xiaogeminghai/vofa_plus) |xiaogeminghai|GPL-2.0|配合vfoa+实现串口波形功能|
| [anv_bench](https://github.com/wuhanstudio/anv_bench) |wuhanstudio|MIT|函数性能快速测试软件包|
| [Dhrystone](https://github.com/wuhanstudio/dhrystone) |wuhanstudio|apache|Dhrystone 单片机性能测试小工具|
| [RT_Trace](https://github.com/Ruboom/RT_Trace) |liboran|Commercial License|使用 J-Link 实现事件监控|
| [cpu_usage](https://github.com/enkiller/cpu_usage) |enkiller|Apache-2.0|CPUU: CPU 使用率统计小工具。|
| [anv_memleak](https://github.com/wuhanstudio/anv_memleak) |wuhanstudio|MIT|检查是否存在内存泄漏|
| [rtt_auto_exe_cmd](https://github.com/supperthomas/RTT_AUTO_EXE_CMD.git) |supperthomas|Apache-2.0|该软件包用来自动执行finsh的命令，主要给CI机器人使用|
| [rdb](https://github.com/RT-Thread-packages/rdb) |RealThread|GPL-2.0|RT-Thread 调试桥|
| [solar_terms](https://github.com/XYX12306/solar_terms.git) |XYX12306|MIT|是一个根据公历日期判断与二十四节气关系的工具软件包。|
| [Adafruit-Si5351](https://github.com/adafruit/Adafruit_Si5351_Library) |adafruit|BSD-3-Clause|Adafruit Si5351 时钟发生器|
| [Adafruit-MFRC630](https://github.com/adafruit/Adafruit_MFRC630) |adafruit|MIT|Adafruit MFRC630 射频识别前端|
| [KalmanFilter](https://github.com/TKJElectronics/KalmanFilter) |TKJElectronics|GPL-2.0|卡尔曼滤波器Arduino库|
| [ArduinoJson](https://github.com/bblanchon/ArduinoJson) |bblanchon|MIT|精简且高效的嵌入式C++ JSON库|
| [Adafruit-SSD1306](https://github.com/RTduino-libraries/Adafruit_SSD1306) |adafruit|BSD-3-Clause|SSD1306 128x64 and 128x32 OLED Arduino驱动库|
| [Seeed-TM1637](https://github.com/Seeed-Studio/Grove_4Digital_Display) |Seeed-Studio|MIT|Seeed-TM1637 4位显示模块驱动|
| [TFT_eSPI](https://github.com/RTduino-libraries/TFT_eSPI) |Bodmer|MIT|TFT显示器Arduino图形驱动库|
| [U8g2_Arduino](https://github.com/olikraus/U8g2_Arduino) |olikraus|BSD-3-Clause|U8g2 Arduino版本|
| [Adafruit-GFX-Library](https://github.com/RTduino-libraries/Adafruit-GFX-Library) |Adafruit|BSD|Adafruit GFX 图像显示驱动库|
| [Adafruit-ILI9341](https://github.com/RTduino-libraries/Adafruit_ILI9341) |adafruit|MIT|Adafruit ILI9341 display Arduino driver|
| [U8glib_Arduino](https://github.com/RTduino-libraries/U8glib_Arduino) |olikraus|new-bsd|U8glib library for Arduino|
| [Adafruit-ST7735](https://github.com/adafruit/Adafruit-ST7735-Library) |Adafruit|MIT|Adafruit ST7735 and ST7789 SPI 显示屏驱动|
| [Adafruit-PN532](https://github.com/adafruit/Adafruit-PN532) |adafruit|BSD-3-Clause|Adafruit PN532 NFC/RFID驱动|
| [Adafruit-Si4713](https://github.com/adafruit/Adafruit-Si4713-Library) |adafruit|BSD-3-Clause|Adafruit Si4713 FM+RDS/RBDS驱动|
| [Adafruit-DS1841](https://github.com/adafruit/Adafruit_DS1841) |adafruit|BSD-3-Clause|Adafruit DS1841 数字电位器|
| [Seeed-PCF85063TP](https://github.com/Seeed-Studio/Grove_High_Precision_RTC_PCF85063TP) |Seeed-Studio|MIT|Seeed PCF85063TP 高精度RTC驱动|
| [Adafruit-DRV2605](https://github.com/adafruit/Adafruit_DRV2605_Library) |adafruit|MIT|Adafruit DRV2605 触觉马达驱动|
| [Adafruit-TPA2016](https://github.com/adafruit/Adafruit-TPA2016-Library) |adafruit|MIT|Adafruit TPA2016 D类放大器|
| [Adafruit-DS3502](https://github.com/adafruit/Adafruit_DS3502) |adafruit|BSD-3-Clause|Adafruit DS3502 数字电位计|
| [Adafruit-PCF8574](https://github.com/adafruit/Adafruit_PCF8574) |adafruit|BSD|Adafruit PCF8574 GPIO扩展器|
| [Adafruit-PCA9685](https://github.com/adafruit/Adafruit-PWM-Servo-Driver-Library) |adafruit|BSD|Adafruit PCA9685 16通道12位PWM/舵机驱动|
| [Seeed-MP503](https://github.com/Seeed-Studio/Grove_Air_quality_Sensor) |Seeed-Studio|MIT|Seeed MP503 空气质量传感器驱动|
| [Adafruit-MSA301](https://github.com/adafruit/Adafruit_MSA301) |adafruit|BSD-3-Clause|dafruit MSA301加速度传感器驱动|
| [Adafruit-SCD30](https://github.com/adafruit/Adafruit_SCD30) |adafruit|BSD-3-Clause|Adafruit SCD30 CO2及温湿度传感器驱动|
| [Adafruit-SensorLab](https://github.com/adafruit/Adafruit_SensorLab) |adafruit|BSD-3-Clause| Adafruit科学传感器数据读取融合与操作驱动|
| [Adafruit-TMP006](https://github.com/adafruit/Adafruit_TMP006) |adafruit|BSD-3-Clause|Adafruit TMP006 红外热堆传感器驱动|
| [Adafruit-EMC2101](https://github.com/adafruit/Adafruit_EMC2101) |adafruit|BSD|Adafruit EMC2101 风扇控制器和温度传感器|
| [Adafruit-AM2315](https://github.com/adafruit/Adafruit_AM2315) |adafruit|Unknown|Adafruit AM2315 温湿度传感器驱动|
| [Adafruit-INA260](https://github.com/adafruit/Adafruit_INA260) |adafruit|BSD|Adafruit INA260 电流传感器|
| [Adafruit-HTU21DF](https://github.com/adafruit/Adafruit_HTU21DF_Library) |adafruit|BSD|Adafruit HTU21DF 温度湿度传感器|
| [Seeed-BMP280](https://github.com/Seeed-Studio/Grove_BMP280) |Seeed-Studio|MIT|BMP280传感器Arduino驱动库|
| [Adafruit-FXOS8700](https://github.com/adafruit/Adafruit_FXOS8700) |adafruit|MIT|Adafruit-FXOS8700 加速度计和磁强计传感器|
| [Adafruit-BMP183](https://github.com/adafruit/Adafruit_BMP183_Library) |adafruit|BSD|Adafruit BMP183 大气压力及温度传感器|
| [Adafruit-MS8607](https://github.com/adafruit/Adafruit_MS8607) |adafruit|MIT|Adafruit MS8607压力温湿度传感器驱动|
| [Seeed-HDC1000](https://github.com/Seeed-Studio/HDC1000) |Seeed-Studio|MIT|Seeed HDC1000 温湿度传感器驱动|
| [Seeed-MMA7660](https://github.com/Seeed-Studio/Accelerometer_MMA7660) |Seeed-Studio|MIT|Seeed MMA7660 三轴数字加速度计|
| [Seeed-AT42QT1070](https://github.com/Seeed-Studio/Seeed_QTouch) |Seeed-Studio|MIT|Seeed AT42QT1070 电容触摸传感器驱动|
| [Seeed-LDC1612](https://github.com/Seeed-Studio/Seeed_LDC1612) |Seeed-Studio|MIT|Seeed LDC1612 电感数字转换器驱动|
| [Adafruit-LIS331](https://github.com/adafruit/Adafruit_LIS331) |adafruit|BSD|Adafruit LIS331 三轴加速度计传感器驱动|
| [Adafruit-VL6180X](https://github.com/adafruit/Adafruit_VL6180X) |adafruit|Unknown|Adafruit-VL6180X激光测距传感器|
| [Adafruit-AHTX0](https://github.com/adafruit/Adafruit_AHTX0) |adafruit|BSD-3-Clause|Adafruit AHT10 AHT20传感器|
| [Adafruit-LSM9DS0](https://github.com/adafruit/Adafruit_LSM9DS0_Library) |adafruit|BSD|Adafruit LSM9DS0三轴加速度计/磁强计/陀螺仪传感器驱动|
| [Adafruit-BNO08x-RVC](https://github.com/adafruit/Adafruit_BNO08x_RVC) |adafruit|BSD|Adafruit BNO08x RVC驱动|
| [Adafruit-BNO055](https://github.com/adafruit/Adafruit_BNO055) |adafruit|MIT|Adafruit BNO055绝对定向传感器驱动|
| [Adafruit-LSM303-Accel](https://github.com/adafruit/Adafruit_LSM303_Accel) |adafruit|BSD|Adafruit LSM303 加速度和电子罗盘传感器驱动|
| [Adafruit-LSM303DLH-Mag](https://github.com/adafruit/Adafruit_LSM303DLH_Mag) |adafruit|BSD|Adafruit LSM303DLH 磁力计传感器驱动|
| [Adafruit-HMC5883-Unified](https://github.com/adafruit/Adafruit_HMC5883_Unified) |adafruit|Unknown|Adafruit HMC5883 (Unified) 三轴磁场计|
| [Adafruit-BME680](https://github.com/adafruit/Adafruit_BME680) |adafruit|BSD|Adafruit BME680 和 BME688 湿度和压力传感器驱动|
| [Adafruit-HDC1000](https://github.com/adafruit/Adafruit_HDC1000_Library) |adafruit|Unknown|Adafruit HDC1000 温度湿度传感器|
| [Adafruit-LSM6DS](https://github.com/adafruit/Adafruit_LSM6DS) |adafruit|BSD|Adafruit LSM6DS六自由度加速度计和陀螺仪传感器驱动|
| [Adafruit-LTR390](https://github.com/adafruit/Adafruit_LTR390) |adafruit|BSD|Adafruit LTR390紫外线传感器驱动|
| [Adafruit-AS726x](https://github.com/adafruit/Adafruit_AS726x) |adafruit|MIT|Adafruit AS726x光谱传感器驱动|
| [Adafruit-BMP085](https://github.com/adafruit/Adafruit-BMP085-Library) |adafruit|BSD-3-Clause|Adafruit BMP085/BMP180压力温度传感器驱动|
| [sensor-device-drivers](https://github.com/RTduino/sensor-device-drivers) |RTduino|Apache-2.0|Arduino传感器库对接RT-Thread传感器设备驱动|
| [Adafruit-PM25AQI](https://github.com/adafruit/Adafruit_PM25AQI) |adafruit|BSD-3-Clause|Adafruit PM25AQI PM2.5空气质量传感器驱动|
| [Seeed-BBM150](https://github.com/Seeed-Studio/Grove_3_Axis_Compass_V2.0_BMM150) |Seeed-Studio|MIT|Seeed BBM150 数字罗盘传感器驱动|
| [Adafruit-ADXL345](https://github.com/adafruit/Adafruit_ADXL345) |adafruit|BSD|Adafruit ADXL345 3-Axis ±2g/±4g/±8g/±16g 加速度计|
| [Seeed-DRV2605L](https://github.com/Seeed-Studio/Grove_Haptic_Motor) |Seeed-Studio|MIT|Seeed DRV2605L 触觉电机传感器驱动|
| [Seeed-ADXL335](https://github.com/Seeed-Studio/Accelerometer_ADXL335) |Seeed-Studio|MIT|Seeed ADXL335三轴加速度计驱动|
| [Seeed-TCS3414CS](https://github.com/Seeed-Studio/Grove_I2C_Color_Sensor) |Seeed-Studio|LGPL-2.1|Seeed TCS3414CS I2C 颜色传感器驱动|
| [Adafruit-Sensor](https://github.com/adafruit/Adafruit_Sensor) |adafruit|Apache-2.0|Adafruit统一传感器框架|
| [Adafruit-BMP183-Unified](https://github.com/adafruit/Adafruit_BMP183_Unified_Library) |adafruit|MIT|Adafruit BMP183 (Unified) 大气压力及高度传感器|
| [Adafruit-PCF8591](https://github.com/adafruit/Adafruit_PCF8591) |adafruit|BSD|Adafruit PCF8591 Basic 4 x ADC + DAC驱动|
| [Adafruit-LIS3MDL](https://github.com/adafruit/Adafruit_LIS3MDL) |adafruit|BSD|Adafruit LIS3MDL三轴磁力计传感器驱动|
| [Adafruit-BMP280](https://github.com/adafruit/Adafruit_BMP280_Library) |adafruit|Unknown|Adafruit BMP280 气压、高度和温度传感器驱动|
| [Adafruit-SHT4X](https://github.com/adafruit/Adafruit_SHT4X) |adafruit|BSD-3-Clause|Adafruit SHT4X 温湿度传感器驱动|
| [Seeed-BMP085](https://github.com/Seeed-Studio/Grove_Barometer_Sensor) |Seeed-Studio|MIT|Seeed BMP085/BMP180 气压计传感器驱动|
| [Adafruit-MPRLS](https://github.com/adafruit/Adafruit_MPRLS) |adafruit|MIT|Adafruit MPRLS 压力传感器驱动|
| [Adafruit-FXAS21002C](https://github.com/adafruit/Adafruit_FXAS21002C) |adafruit|MIT|Adafruit FXOS8700 3轴加速度计和磁力计，以及 FXAS21002 3轴陀螺仪传感器驱动|
| [Adafruit-SGP30](https://github.com/adafruit/Adafruit_SGP30) |adafruit|BSD|Adafruit SGP30空气质量传感器驱动|
| [Adafruit-MAX31865](https://github.com/adafruit/Adafruit_MAX31865) |adafruit|BSD-3-Clause|MAX31865热电偶传感器驱动库|
| [Seeed-LIS3DHTR](https://github.com/Seeed-Studio/Seeed_Arduino_LIS3DHTR) |Seeed-Studio|MIT|LIS3DHTR Arduino驱动库|
| [Adafruit-VCNL4040](https://github.com/adafruit/Adafruit_VCNL4040) |adafruit|BSD|Adafruit VCNL4040接近和环境光传感器|
| [Adafruit-MAX31855](https://github.com/adafruit/Adafruit-MAX31855-library) |Adafruit|BSD-3-Clause|ADAFRUIT MAX31855热电偶放大器驱动|
| [Adafruit-MAX1704X](https://github.com/adafruit/Adafruit_MAX1704X) |Adafruit|BSD-3-Clause|Adafruit MAX17048/MAX17049锂电池管理芯片驱动|
| [Adafruit-LC709203F](https://github.com/adafruit/Adafruit_LC709203F) |adafruit|BSD|Adafruit LC709203F 电量计和电池监测传感器驱动|
| [Seeed-BME280](https://github.com/Seeed-Studio/Grove_BME280) |Seeed-Studio|MIT|Seeed BME280 温湿度和气压传感器驱动|
| [Adafruit-MLX90640](https://github.com/adafruit/Adafruit_MLX90640) |adafruit|BSD-3-Clause|Adafruit MLX90640 红外热成像相机驱动|
| [Adafruit-VEML6070](https://github.com/adafruit/Adafruit_VEML6070) |adafruit|BSD-3-Clause|Adafruit VEML6070高级紫外线(UV)光传感器|
| [Adafruit-ADXL375](https://github.com/adafruit/Adafruit_ADXL375) |adafruit|BSD|Adafruit ADXL375 3-Axis ±2g/±4g/±8g/±16g 加速度计|
| [Seeed-SHT35](https://github.com/Seeed-Studio/Seeed_SHT35) |Seeed-Studio|MIT|Seeed SHT35 温湿度传感器驱动|
| [Seeed-LSM303DLH](https://github.com/Seeed-Studio/Grove_6Axis_Accelerometer_And_Compass_v2) |Seeed-Studio|MIT|Seeed LSM303DLH 3轴加速度和磁传感器驱动|
| [Adafruit-DHT](https://github.com/adafruit/DHT-sensor-library) |adafruit|MIT|DHT11、DHT22温湿度传感器|
| [Adafruit-ADXL343](https://github.com/adafruit/Adafruit_ADXL343) |adafruit|BSD-3-Clause|ADXL343数字加速度计(+/-2/4/8/16g)驱动，同时支持SPI和I2C模式|
| [Adafruit-MCP9600](https://github.com/adafruit/Adafruit_MCP9600) |adafruit|BSD|Adafruit MCP9600 I2C热电偶ADC传感器驱动|
| [Adafruit-MMA8451](https://github.com/adafruit/Adafruit_MMA8451_Library) |adafruit|BSD-3-Clause|Adafruit MMA8451 加速度传感器驱动|
| [Seeed-HMC5883L](https://github.com/Seeed-Studio/Grove_3Axis_Digital_Compass_HMC5883L) |Seeed-Studio|Unknown|Seeed HMC5883L 三轴数字罗盘传感器驱动|
| [Adafruit-LSM9DS1](https://github.com/adafruit/Adafruit_LSM9DS1) |adafruit|BSD-3-Clause|Adafruit LSM9DS1三轴加速度计/磁强计/陀螺仪传感器|
| [Seeed-MCP9600](https://github.com/Seeed-Studio/Seeed_MCP9600) |Seeed-Studio|MIT|Seeed MCP9600 数字温度传感器驱动|
| [Adafruit-VL53L0X](https://github.com/adafruit/Adafruit_VL53L0X) |adafruit|MIT|Adafruit VL53L0X飞行时间距离传感器驱动|
| [Adafruit-TMP117](https://github.com/adafruit/Adafruit_TMP117) |adafruit|BSD|Adafruit TMP117 高精度数字温度传感器。|
| [Adafruit-DPS310](https://github.com/adafruit/Adafruit_DPS310) |adafruit|BSD-3-Clause|Adafruit DPS310压力传感器驱动|
| [Adafruit-BMP3XX](https://github.com/adafruit/Adafruit_BMP3XX) |adafruit|BSD-3-Clause|Adafruit BMP3XX 高精度压力/高度传感器驱动|
| [Seeed-ITG3200](https://github.com/Seeed-Studio/Grove_3_Axis_Digital_Gyro) |Seeed-Studio|LGPL-3.0|Seeed ITG3200 三轴数字陀螺仪驱动|
| [Adafruit-TSL2591-Library](https://github.com/adafruit/Adafruit_TSL2591_Library) |adafruit|BSD|Adafruit TSL2591数字光度(光)传感器。|
| [Adafruit-AMG88xx](https://github.com/adafruit/Adafruit_AMG88xx) |adafruit|MIT|Adafruit AMG88xx 热成像仪的驱动库|
| [Adafruit-LTR329-LTR303](https://github.com/adafruit/Adafruit_LTR329_LTR303) |adafruit|BSD-3-Clause|Adafruit LTR329 LTR303环境光传感器驱动|
| [Adafruit-VL53L1X](https://github.com/adafruit/Adafruit_VL53L1X) |adafruit|BSD-3-Clause|Adafruit VL53L0X飞行时间距离传感器驱动|
| [Seeed-LTC2941](https://github.com/Seeed-Studio/Seeed_LTC2941) |Seeed-Studio|MIT|Seeed LTC2941 库伦计数器传感器驱动|
| [Adafruit-AS7341](https://github.com/adafruit/Adafruit_AS7341) |adafruit|BSD-3-Clause|Adafruit AS7341 11通道光谱传感器。|
| [Seeed-PAJ7620](https://github.com/Seeed-Studio/Gesture_PAJ7620) |Seeed-Studio|MIT|Seeed PAJ7620 手势识别传感器驱动|
| [Adafruit-BME280](https://github.com/adafruit/Adafruit_BME280_Library) |adafruit|Unknown|Adafruit BME280温湿度和气压传感器驱动|
| [Seeed-LSM6DS3](https://github.com/Seeed-Studio/Seeed_Arduino_LSM6DS3) |Seeed-Studio|MIT|Seeed LSM6DS3 六轴加速度计陀螺仪|
| [Adafruit-LIS3DH](https://github.com/adafruit/Adafruit_LIS3DH) |adafruit|BSD|Adafruit LIS3DH 加速度计传感器驱动|
| [Adafruit-MLX90614](https://github.com/adafruit/Adafruit-MLX90614-Library) |adafruit|BSD|Adafruit MLX90614温度传感器驱动|
| [Adafruit-HTS221](https://github.com/adafruit/Adafruit_HTS221) |adafruit|BSD|Adafruit HTS221 温湿度传感器驱动|
| [Adafruit-LPS2X](https://github.com/adafruit/Adafruit_LPS2X) |adafruit|BSD|Adafruit LPS22 & LPS25 气压传感器驱动|
| [Adafruit-INA219](https://github.com/adafruit/Adafruit_INA219) |adafruit|BSD-3-Clause|Adafruit INA219直流电流传感器驱动|
| [Adafruit-VEML6075](https://github.com/adafruit/Adafruit_VEML6075) |adafruit|MIT|Adafruit VEML6075紫外线 (UV) 光传感器|
| [Adafruit-BNO08x](https://github.com/adafruit/Adafruit_BNO08x) |adafruit|BSD|Adafruit BNO08x 9自由度定向IMU驱动|
| [Adafruit-SHT31](https://github.com/adafruit/Adafruit_SHT31) |adafruit|BSD-3-Clause|Adafruit SHT31 温湿度驱动|
| [Adafruit-VEML7700](https://github.com/adafruit/Adafruit_VEML7700) |adafruit|BSD|Adafruit VEML7700环境光传感器|
| [Adafruit-MPL115A2](https://github.com/adafruit/Adafruit_MPL115A2) |adafruit|BSD-3-Clause|Adafruit MPL115A2 大气压力传感器驱动|
| [Seeed-VEML6070](https://github.com/Seeed-Studio/Seeed_VEML6070) |Seeed-Studio|MIT|Seeed VEML6070 先进紫外线(UV)光传感器|
| [Adafruit-MAX6675](https://github.com/adafruit/MAX6675-library) |adafruit|Unknown|MAX6675是一款精密的热电偶数字转换器,内置12位模数转换器(ADC)|
| [Adafruit-MPL3115A2](https://github.com/adafruit/Adafruit_MPL3115A2_Library) |adafruit|BSD|Adafruit MPL3115A2 压力/高度/温度传感器驱动|
| [Adafruit-LIS2MDL](https://github.com/adafruit/Adafruit_LIS2MDL) |adafruit|BSD|Adafruit LIS2MDL 磁力计传感器驱动|
| [Adafruit-TSL2561](https://github.com/adafruit/Adafruit_TSL2561) |adafruit|Unknown|Adafruit TSL2561环境光强度传感器。|
| [Adafruit-L3GD20](https://github.com/adafruit/Adafruit_L3GD20_U) |adafruit|BSD|Adafruit L3GD20 三轴陀螺仪传感器|
| [Adafruit-SGP40](https://github.com/adafruit/Adafruit_SGP40) |adafruit|BSD|Adafruit SGP40气体/空气质量I2C传感器驱动|
| [Adafruit-PCT2075](https://github.com/adafruit/Adafruit_PCT2075) |adafruit|BSD-3-Clause|Adafruit PCT2075温度传感器驱动|
| [Adafruit-SI1145](https://github.com/adafruit/Adafruit_SI1145_Library) |adafruit|BSD-3-Clause|Adafruit SI1145 紫外/红外/可见光传感器|
| [Adafruit-MCP9808](https://github.com/adafruit/Adafruit_MCP9808_Library) |adafruit|BSD|Adafruit MCP9808精密I2C温度传感器驱动|
| [Adafruit-MPU6050](https://github.com/adafruit/Adafruit_MPU6050) |adafruit|BSD-3-Clause|Adafruit MPU6050 六自由度加速度和陀螺仪传感器驱动|
| [Adafruit-MPR121](https://github.com/adafruit/Adafruit_MPR121) |adafruit|BSD-3-Clause|Adafruit MPR121 电容触摸传感器驱动|
| [Adafruit-BMP085-Unified](https://github.com/adafruit/Adafruit_BMP085_Unified) |adafruit|BSD|Adafruit BMP085 大气压力及温度传感器|
| [Adafruit-CAP1188](https://github.com/adafruit/Adafruit_CAP1188_Library) |adafruit|BSD-3-Clause|Adafruit CAP1188 8键电容式触摸传感器|
| [Seeed-TSL2561](https://github.com/Seeed-Studio/Grove_Digital_Light_Sensor) |Seeed-Studio|MIT|TSL2561/ISL29035 数字光传感器驱动|
| [Adafruit-MMC56x3](https://github.com/adafruit/Adafruit_MMC56x3) |adafruit|BSD-3-Clause|Adafruit MMC5603 或 MMC5613 磁力计传感器驱动|
| [Adafruit-LPS35HW](https://github.com/adafruit/Adafruit_LPS35HW) |adafruit|BSD|Adafruit LPS35HW/LPS33HW 防水型气压传感器驱动|
| [Adafruit-MCP4728](https://github.com/adafruit/Adafruit_MCP4728) |adafruit|BSD|Adafruit MCP4728 4通道12位I2C DAC驱动|
| [Adafruit-TMP007-Library](https://github.com/adafruit/Adafruit_TMP007_Library) |adafruit|BSD|Adafruit TMP007 非接触式热红外传感器|
| [Adafruit-Si7021](https://github.com/adafruit/Adafruit_Si7021) |adafruit|BSD-3-Clause|Adafruit-Si7021 温湿度传感器|
| [Seeed-HM3301](https://github.com/Seeed-Studio/Seeed_PM2_5_sensor_HM3301) |Seeed-Studio|MIT|Seeed HM3301 粉尘检测传感器驱动|
| [Seeed-H3LIS331DL](https://github.com/Seeed-Studio/Accelerometer_H3LIS331DL) |Seeed-Studio|MIT|Seeed H3LIS331DL 三轴线性加速度计驱动|
| [Adafruit-HTU31D](https://github.com/adafruit/Adafruit_HTU31D) |adafruit|BSD|Adafruit HTU31D 温度湿度传感器|
| [Adafruit-MLX90395](https://github.com/adafruit/Adafruit_MLX90395) |adafruit|MIT|Adafruit MLX90395 磁场传感器驱动|
| [Seeed-VL53L0X](https://github.com/Seeed-Studio/Grove-Ranging-sensor-VL53L0X) |Seeed-Studio|MIT|Seeed VL53L0X 飞行时间范围和手势检测传感器驱动|
| [Adafruit-NAU7802](https://github.com/adafruit/Adafruit_NAU7802) |adafruit|BSD-3-Clause|Adafruit NAU7802 I2C 24-bit ADC传感器驱动。|
| [Seeed-ADXL345](https://github.com/Seeed-Studio/Accelerometer_ADXL345) |Seeed-Studio|MIT|Seeed ADXL345三轴数字加速度计驱动|
| [Adafruit-TLA202x](https://github.com/adafruit/Adafruit_TLA202x) |adafruit|BSD-3-Clause|Adafruit TLA202x 模数转换驱动|
| [Adafruit-SHTC3](https://github.com/adafruit/Adafruit_SHTC3) |adafruit|BSD|Adafruit-SHTC3 温湿度传感器驱动|
| [Seeed-DHT](https://github.com/Seeed-Studio/Grove_Temperature_And_Humidity_Sensor) |Seeed-Studio|MIT|Seeed DHT11, DHT22, DHT21 & AM2301温湿度传感器驱动|
| [Adafruit-AM2320](https://github.com/adafruit/Adafruit_AM2320) |adafruit|unknown|Adafruit AM2320 温湿度传感器。|
| [Seeed-Si1145](https://github.com/Seeed-Studio/Grove_Sunlight_Sensor) |Seeed-Studio|MIT|Seeed Si1145 太阳光传感器驱动|
| [Seeed-HP20x](https://github.com/Seeed-Studio/Grove_Barometer_HP20x) |Seeed-Studio|MIT|Seeed HP20x 气压、高度计和温度传感器|
| [Adafruit-MAX31856](https://github.com/adafruit/Adafruit_MAX31856) |adafruit|BSD|Adafruit MAX31856热电偶传感器驱动库|
| [Adafruit-TSC2007](https://github.com/adafruit/Adafruit_TSC2007) |adafruit|BSD-3-Clause|Adafruit TSC2007电阻式触摸屏驱动程序。|
| [Adafruit-ADT7410](https://github.com/adafruit/Adafruit_ADT7410) |adafruit|BSD-3-Clause|Adafruit ADT7410精密I2C温度传感器驱动|
| [Adafruit-CCS811](https://github.com/adafruit/Adafruit_CCS811) |adafruit|Unknown|Adafruit CCS811 空气质量传感器|
| [Seeed-HighTemp](https://github.com/Seeed-Studio/Grove_HighTemp_Sensor) |Seeed-Studio|MIT|Seeed HighTemp K型热电偶温度传感器驱动|
| [Adafruit-ICM20X](https://github.com/adafruit/Adafruit_ICM20X) |adafruit|BSD License|Adafruit ICM20649/ICM20948 IMU运动传感器|
| [Adafruit-TCS34725](https://github.com/adafruit/Adafruit_TCS34725) |adafruit|BSD-3-Clause|Adafruit TCS34725 RGB 颜色传感器|
| [Adafruit-MLX90393](https://github.com/adafruit/Adafruit_MLX90393_Library) |adafruit|MIT|Adafruit MLX90393 磁场传感器驱动|
| [CapacitiveSensor](https://github.com/PaulStoffregen/CapacitiveSensor) |PaulStoffregen|Apache-2.0|软件电容触摸传感器|
| [Seeed-SHT31](https://github.com/Seeed-Studio/Grove_SHT31_Temp_Humi_Sensor) |Seeed-Studio|MIT|Seeed SHT31 温湿度传感器驱动|
| [RTClib](https://github.com/adafruit/RTClib) |adafruit|MIT|RTClib Arduino的实时时钟库|
| [MsTimer2](https://github.com/RTduino-libraries/MsTimer2) |RTduino-libraries|unknown|1ms级软件定时器Arduino库|
| [TaskScheduler](https://github.com/arkhipenko/TaskScheduler) |arkhipenko|BSD-3-Clause|Arduino多任务协程库|
| [Ticker](https://github.com/sstaub/Ticker) |sstaub|MIT|定时器回调式Arduino库，可用于代替delay函数|
| [Adafruit-AW9523](https://github.com/adafruit/Adafruit_AW9523) |adafruit|BSD-3-Clause|Adafruit AW9523 GPIO 拓展器和 LED 驱动库|
| [Adafruit-MCP4725](https://github.com/adafruit/Adafruit_MCP4725) |adafruit|BSD-3-Clause|Adafruit MCP4725 12位DAC驱动(I2C)|
| [Adafruit-ADS1X15](https://github.com/adafruit/Adafruit_ADS1X15) |adafruit|BSD|Adafruit ADS1015/1115 12/16位差分或单端ADCs(带PGA和比较器)驱动库|
| [Adafruit-MCP23017](https://github.com/adafruit/Adafruit-MCP23017-Arduino-Library) |adafruit|BSD-3-Clause|Adafruit MCP23XXX I2C and SPI GPIO 接口扩展器驱动|
| [Adafruit-BusIO](https://github.com/RTduino-libraries/Adafruit_BusIO) |adafruit|MIT|Adafruit总线库|
| [Adafruit-BD3491FS](https://github.com/adafruit/Adafruit_BD3491FS) |adafruit|BSD-3-Clause|Adafruit BD3491FS 音频处理器驱动|
| [Adafruit-MCP3008](https://github.com/adafruit/Adafruit_MCP3008) |adafruit|MIT|Adafruit MCP3008 8通道的10位ADC驱动(SPI)|
| [Adafruit-TCA8418](https://github.com/adafruit/Adafruit_TCA8418) |adafruit|BSD-3-Clause|Adafruit TCA8418 CPIO 拓展和矩阵键盘Arduino驱动库|
| [matlab-support-package](https://github.com/RTduino/matlab-support-package) |RTduino|Unknown|MATLAB/Simulink Support Package for RTduino Hardware|
| [Arduino-Sensor-Kit](https://github.com/RTduino/Arduino-Sensor-Kit) |RTduino|Apache-2.0|Arduino传感器套件库|
| [MsgQ-C-CPP-demo](https://github.com/RTduino/MsgQ-C-CPP-demo) |RTduino|Apache-2.0|本示例展示了如何在RTduino下，借助RT-Thread的消息队列通信机制，实现RTduino/Arduino C++代码，与RT-Thread C线程之间的数据通信。|
| [UltrasoundRadar](https://github.com/RTduino/UltrasoundRadar) |RTduino|Apache-2.0|Arduino超声波雷达项目|

## peripherals

 | 包名 | 作者  | license   | 备注      |
| ------------------------------------------------------------ | ------------------- | -------------------- | ------------------------------------------------------------ |
| [rs232](https://github.com/diskwu/RTTHREAD_RS232) |diskwu|LGPL-2.1|rs232驱动包。|
| [max7219](https://github.com/redocCheng/max7219) |redocCheng|Apache-2.0|本软件包是在数码管上应用 MAX7219 的驱动包|
| [nrfx](https://github.com/xckhmf/nrfx) |xckhmf|Unknown|Nordic SOC的独立外设驱动库|
| [rosserial](https://github.com/wuhanstudio/rt-rosserial) |wuhanstudio|BSD|机器人操作系统(ROS1) 软件包 rosserial 在 RT-Thread 的移植库|
| [i2c-tools](https://github.com/wuhanstudio/rt-i2c-tools) |wuhanstudio|MIT|I2C 调试时可以使用的小工具，可以扫描设备，读写寄存器|
| [agile_button](https://github.com/loogg/agile_button) |Longwei Ma|LGPL-2.1|一个灵活的button软件包。|
| [st7789](https://github.com/Vandoul/ST7789.git) |Vandoul|Apache-2.0|TFT-LCD ST7789 SPI 图形驱动|
| [sx12xx](https://github.com/XiaojieFan/sx12xx) |XiaojieFan|Apache-2.0|Semtech LoRa RF 芯片驱动库|
| [pca9685](https://github.com/greedyhao/pca9685) |greedyhao|Apache-2.0|通过I2C总线控制的16路PWM控制器|
| [io_input_filter](https://github.com/lizdDong/io_input_filter) |lizdDong|Apache-2.0|IO输入软件滤波模块|
| [stm32_sdio](https://github.com/RT-Thread-packages/stm32_sdio) |RealThread|LGPL-2.1|STM32 平台 SDIO 控制器驱动包|
| [lora_gw_driver_lib](https://github.com/Forest-Rain/lora-gw-driver-lib) |forest-rain|Apache-2.0|LoRa网关芯片(SX130x)驱动|
| [nrf24l01](https://github.com/sogwms/nrf24l01) |sogwms|Apache-2.0|单芯片 2.4GHz 无线收发器。|
| [sgm706](https://github.com/Prry/rtt-sgm706) |panrui|Apache-2.0|SGM706独立看门狗驱动软件包|
| [button](https://github.com/jiejieTop/rtpkg_button) |jiejieTop|GPL-3.0|C 实现的按键驱动，支持单击和双击，长按，长按释放|
| [ld3320](https://github.com/xqyjlj/ld3320) |xqyjlj|Apache-2.0|LD3320语音识别芯片|
| [mb85rs16](https://github.com/XiaojieFan/mb85rs16.git) |XiaojieFan|Apache-2.0|针对 铁电存储器 SPI 驱动软件包|
| [rx8900](https://github.com/Prry/rtt-rx8900) |panrui|Apache-2.0|rx8900 外置RTC驱动，支持实时时钟和闹钟功能|
| [ds3231](https://github.com/Prry/rtt-ds3231) |panrui|Apache-2.0|ds3231 外置RTC驱动|
| [spi-tools](https://github.com/vandoul/rt-spi-tools) |vandoul|MIT|SPI 调试时可以使用的小工具，可以初始化、配置spi总线设备，读写spi总线设备|
| [at24cxx](https://github.com/XiaojieFan/at24cxx) |XiaojieFan|Apache-2.0|eeprom at24cxx 的驱动库。|
| [ws2812b](https://github.com/maplerian/rt_ws2812b) |maplerian|Apache-2.0|用于 RT-Thread 的 ws2812b 软件驱动包，使用 SPI + DMA 方式驱动。|
| [LedBlink](https://github.com/aeo123/LedBlink.git) |zpw|GPL-2.0|简单易用led闪烁控制软件包|
| [dm9051](https://github.com/aozima/dm9051) |aozima|Apache-2.0|DM9051 SPI 接口以太网芯片驱动库|
| [lrf-nv7lidar](https://github.com/RT-Thread-packages/nv7lidar) |shenzan|LGPL-2.1|LRF-NV7激光测距模组|
| [wk2124](https://github.com/MrMichael/wk2124) |YaohongLi|Apache-2.0|wk2124 spi转四串口芯片的驱动库。|
| [rfm300](https://github.com/kylepengchn/rfm300.git) |kylepengchn|Apache-2.0|wk2124 spi转四串口芯片的驱动库。|
| [realtek_ameba](https://github.com/flyingcys/realtek_ameba) |flyingcys|LGPL-2.1|realtek 的 ameba 软件包在 RT-Thread 上的移植|
| [lora_radio_driver](https://github.com/Forest-Rain/lora-radio-driver) |Forest-Rain|Apache-2.0|lora芯片(SX126x\SX127x)驱动包|
| [multi_rtimer](https://github.com/Forest-Rain/multi-rtimer) |Forest-Rain|Apache-2.0|一个实时、低功耗软件定时器模块|
| [Misaka_AT24CXX](https://github.com/xqyjlj/Miaska_AT24CXX) |xqyjlj|Apache-2.0|御坂网络AT24CXX驱动包，提供了AT24CXX的全部功能|
| [ly68l6400](https://github.com/Ghazigq/ly68l6400) |Ghazigq|LGPL-2.1|ly68l6400芯片的驱动|
| [nuclei_sdk](https://github.com/Nuclei-Software/nuclei-sdk) |Huaqi Fang|Apache-2.0|芯来科技RISC-V处理器软件开发包|
| [micro_ros](https://github.com/wuhanstudio/micro_ros) |wuhanstudio|Apache-2.0|在 MCU 上运行 ROS2.|
| [rs485](https://github.com/qiyongzhong0/rt-thread-rs485) |qiyongzhong0| LGPL-2.1|rs485驱动包|
| [ESP-IDF](https://github.com/RT-Thread-packages/esp-idf) |supperthomas|Apache-2.0|ESP32C3 ESP-IDF软件包|
| [fingerprint](https://github.com/pk-ing/fingerprint) |pk-ing|GPL-3.0|指纹模块驱动|
| [beep](https://github.com/Sunwancn/rtt-pkgs-beep) |Sunwancn|Apache-2.0|基于 rt-thread 的 pin 和 pwm 驱动的蜂鸣器控制软件包，可以容易地驱动有源蜂鸣器或无源蜂鸣器，产生各种间隔长短的鸣叫声。|
| [MotionDriver2RTT](https://github.com/greedyhao/MotionDriver2RTT) |greedyhao|LGPL-2.1|移植 MotionDriver 到 RTT 的包|
| [aip650](https://github.com/Maihuanyi/aip650) |Chasel| LGPL-2.1|一个快捷易用的数码管和按键驱动包适用于aip650和tm1650。|
| [wm_libraries](https://github.com/WinnerMicro/rtpkg-wm_libraries) |Winner Micro|Apache-2.0|WinnerMicro 芯片软件支持包|
| [tmc51xx](https://github.com/apeng2012/tmc51xx) |apeng2012|MIT|TMC5160步进电机驱动。|
| [rda58xx](https://github.com/apeng2012/rda58xx) |apeng2012|MIT|RDA5820收音机芯片驱动。|
| [agile_led](https://github.com/loogg/agile_led) |Longwei Ma|LGPL-2.1|一个灵活的led软件包。|
| [mfoc](https://github.com/wuhanstudio/mfoc) |wuhanstudio|GPL-2.0|Mifare Classic 离线破解工具。|
| [K210-SDK](https://github.com/RT-Thread-packages/kendryte-k210-sdk) |RT-Thread-package|Apache-2.0|勘智 K210 处理器对应的外设驱动包|
| [kendryte-sdk](https://github.com/RT-Thread-packages/kendryte_sdk) |RealThread|unknown|勘智 K210 处理器对应的外设驱动包 (老版本，已废弃)|
| [stm32wb55_sdk](https://github.com/xupenghu/stm32wb55_sdk.git) |xph|Apache-2.0|stm32wb55_sdk 软件包|
| [ili9341](https://github.com/Rbb666/ILI9341.git) |Rbb666|Apache-2.0|TFT-LCD ILI9341 SPI 屏幕驱动的软件包|
| [bt_ecb02c](https://github.com/qiyongzhong0/rt-thread-bt_ecb02c) |qiyongzhong0| LGPL-2.1|蓝牙芯片ECB02C的设备驱动|
| [rplidar](https://github.com/wuhanstudio/rplidar) |wuhanstudio|MIT|RPLIDAR: 适用于机器人室内建图的低成本激光雷达|
| [littled](https://github.com/luhuadong/rtt-littled) |luhuadong|Apache-2.0|littled软件包: Littled LED Daemon 服务线程|
| [raspberrypi-pico-sdk](https://github.com/RT-Thread-packages/raspberrypi-pico-sdk) |RT-Thread-packages|BSD-3-Clause|Raspberry Pi Pico SDK|
| [SignalLed](https://github.com/WKJay/SignalLed) |WKJay|LGPL-2.1|信号灯软件包，支持自定义闪烁方式、周期，支持随时开启、关闭|
| [ssd1306](https://github.com/luhuadong/rtt-ssd1306) |luhuadong|Apache-2.0|基于 SSD1306、SH1106、SH1107 和 SSD1309 的 OLED 驱动，支持 I2C 和 SPI|
| [soft_serial](https://github.com/qiyongzhong0/rt-thread-soft-serial) |qiyongzhong0| LGPL-2.1|一个利用硬件定时器捕获/比较功能实现软件模拟串口的软件包|
| [can_ymodem](https://github.com/redocCheng/rt_can_ymodem) |redocCheng|Apache-2.0|连接can设备和ymodem的驱动包|
| [lora_modem_driver](https://github.com/Forest-Rain/lora-modem-driver) |forest-rain|Apache-2.0|lora_modem_driver是lora//lorawan modem的串口驱动。|
| [embARC_bsp](https://github.com/foss-for-synopsys-dwc-arc-processors/embarc_bsp) |Watson Zeng|Apache-2.0|Synopsys ARC 处理器 板级支持包|
| [Misaka_RGB_Bling](https://github.com/xqyjlj/Misaka_RGB_Bling) |xqyjlj|Apache-2.0|御坂网络RGB LED驱动包，提供了对于RGB LED灯的控制功能。|
| [uat](https://github.com/qiyongzhong0/rt-thread-uat) |qiyongzhong0| LGPL-2.1|微型AT设备驱动接口组件。|
| [agile_console](https://github.com/loogg/agile_console) |loogg|LGPL-2.1|简单易用的调试设备中间件。|
| [easyblink](https://github.com/Sunwancn/rtt-pkgs-easyblink) |Sunwancn|Apache-2.0|小巧轻便的 LED 控制软件包，可以容易地控制 LED 开、关、反转和各种间隔闪烁，占用 RAM 少，支持 RT-Thread 标准版和 Nano 版。|
| [pms_series](https://github.com/MrpYoung/pms_series) |MrpYoung|MIT|pms 数字式通用颗粒物浓度传感器驱动库|
| [as608](https://github.com/greedyhao/as608.git) |greedyhao|Apache-2.0|AS608 指纹模块的驱动|
| [quick_led](https://github.com/qiyongzhong0/rt-thread-qled) |qiyongzhong0| LGPL-2.1|一个快捷易用的led驱动包|
| [gy271](https://github.com/jch12138/gy271) |jch12138|Apache-2.0|gy271驱动库|
| [mlx90632](https://github.com/xupenghu/mlx90632.git) |xph|Apache-2.0|mlx90632 软件包|
| [adt74xx](https://github.com/IoTSharp/ADT74XX) |maikebing|LGPLv2.1|数字温度传感器 adt74xx 驱动软件包|
| [bmp180](https://github.com/Prry/rtt-bmp180) |panrui|Apache-2.0|这是 BMP180 传感器驱动软件包，支持：气压，温度|
| [as7341](https://github.com/RiceChen0/as7341) |RiceChen|Apache-2.0|AS7341可见光传感器，可测量8个波长的可见光。|
| [sht4x](https://github.com/flyingcys/sht4x) |flyingcys|Apache-2.0|数字湿度和温度传感器 sht4x 驱动软件包|
| [tsl4531](https://github.com/JellyYe/tsl4531pkgs.git) |ye guodong|Apache-2.0|tsl4531 是光感传感器,能读取环境亮度 lux。|
| [mpu6xxx](https://github.com/RT-Thread-packages/mpu-6xxx) |RealThread|Apache-2.0|兼容 mpu6000, mpu6050, mpu6500, mpu9250 等等型号的驱动库|
| [ap3216c](https://github.com/RT-Thread-packages/ap3216c) |RealThread|Apache-2.0|接近和光强传感器 ap3216c 的驱动库|
| [ad7746](https://github.com/wuhanstudio/rt-ad7746) |wuhanstudio|MIT|AD7746 高精度电容测量传感器驱动|
| [hdc1000](https://github.com/Forest-Rain/hdc1000) |Forest-Rain|Apache-2.0|TI温湿度传感器hdc1000软件包(RT-Thread Sensor架构)|
| [ms5805](https://github.com/schuck-wang/RTThread-MS5805) |schuck-wang|Apache-2.0|数字气压传感器 MS5805 驱动软件包|
| [isl29035](https://github.com/ShermanShao/isl29035) |Sherman|RENESAS SOFTWARE LICENSE TERMS|Renesas 环境光线传感器 isl29035 的驱动库|
| [sht3x](https://github.com/donghao2nanjing/sht3x) |hao.dong|LGPLv2.1|数字湿度和温度传感器 sht3x 驱动软件包|
| [rt3020](https://github.com/RichtekTechnology/RT3020) |Tank Wu|Apache-2.0|这是 RT3020 加速度传感器的驱动包。|
| [sht2x](https://github.com/RT-Thread-packages/sht2x) |RealThread|Apache-2.0|数字湿度和温度传感器 sht2x 驱动软件包|
| [lps22hb](https://github.com/RT-Thread-packages/lps22hb) |flybreak|other|LPS22HB 气压传感器的驱动包|
| [max30102](https://github.com/Jackistang/max30102_rtt) |Jackistang|Apache-2.0|[MAX30102]: 心率测量，血氧饱和度测量软件包|
| [lis2dh12](https://github.com/StackRyan/lis2dh12.git) |StackRyan|other| LIS2DH12 传感器驱动包，支持：加速度计，温度。|
| [sths34pf80](https://github.com/zyk6271/STHS34PF80) |rick|Apache-2.0|STHS34PF80 红外传感器的驱动包|
| [spl0601](https://github.com/RT-Thread-packages/spl0601) |gztss|other|数字气压传感器 SPL06-01 驱动软件包|
| [gp2y10](https://github.com/luhuadong/rtt-gp2y10) |luhuadong|Apache-2.0|GP2Y10 夏普公司的灰尘/空气颗粒物浓度传感器|
| [bmi088](https://github.com/gmyFighting/bmi088) |MYGuo|Apache-2.0|bmi088 软件包|
| [mmc3680kj](https://github.com/mumuge1/mmc3680kj) |mumuge1|other|mmc3680kj的驱动|
| [dhtxx](https://github.com/luhuadong/rtt-dhtxx) |luhuadong|Apache-2.0|DHTxx系列单总线数字温湿度传感器驱动|
| [qmp6989](https://github.com/kylepengchn/qmp6989.git) |kylepengchn|Apache-2.0|DHTxx系列单总线数字温湿度传感器驱动|
| [dht11](https://github.com/murphyzhao/dht11_rtt) |MurphyZhao|Apache-2.0|DHT11 单总线数字温湿度传感器|
| [mlx90397](https://github.com/lgnq/mlx90397) |lgnq|Apache-2.0|MLX90397 是来自迈来芯公司的一颗低功耗的3D磁位置传感器|
| [aht10](https://github.com/RT-Thread-packages/aht10) |RealThread|Apache-2.0|数字温湿度传感器 aht10 的驱动库|
| [pmsxx](https://github.com/luhuadong/rtt-pmsxx) |luhuadong|Apache-2.0|PMSxx 攀藤pms系列颗粒物浓度传感器|
| [mlx90393](https://github.com/lgnq/mlx90393) |lgnq|Apache-2.0|MLX90393 是来自迈来芯公司的一颗低功耗的3D磁位置传感器|
| [lsm303agr](https://github.com/RT-Thread-packages/lsm303agr) |flybreak|other|这是 LSM303AGR 传感器驱动包，支持：加速度计，磁力计|
| [max6675](https://github.com/JonasWen/max6675) |Jonas|Apache-2.0|数字温度传感器 max6675 的软件包|
| [icm20608](https://github.com/RT-Thread-packages/icm20608) |RealThread|Apache-2.0|三轴加速度与三轴陀螺仪 icm20608 的传感器驱动库|
| [PAJ7620](https://github.com/orange2348/paj7620) |orange2348|Apache-2.0|手势传感器PAJ7620的驱动包|
| [bh1750](https://github.com/sanjaywu/bh1750_sensor) |Sanjay_Wu|Apache-2.0|bh1750 传感器驱动包，支持：环境光照强度.|
| [balance](https://github.com/xiaogeminghai/balance) |xiaogeminghai|GPL-2.0|使用HX71XX及称重压力传感器测重|
| [sgp30](https://github.com/luhuadong/rtt-sgp30) |luhuadong|Apache-2.0|SGP30 空气检测传感器，可检测TVOC和CO2浓度|
| [bme680](https://github.com/luhuadong/rtt-bme680) |luhuadong|Apache-2.0|BME680 四合一 MEMS 环境传感器驱动软件包|
| [zmod4410](https://github.com/ShermanShao/zmod4410) |Sherman|RENESAS SOFTWARE LICENSE TERMS|Renesas 室内空气质量检测传感器 zmod4410 的驱动库|
| [ms5611](https://github.com/sogwms/ms5611) |sogwms|Apache-2.0|数字气压传感器 MS5611 驱动软件包|
| [da270](https://github.com/MiraMEMS-Wonderful/da270-RT-Thread) |Zhou DingHua|GPL-3.0|本软件包是 MiraMEMS DA270 加速度传感器在 RT-Thread 中的驱动包。|
| [bmp280](https://github.com/nfsq246/RTT_BMP280) |nfsq246|other|bmp280的iic驱动|
| [hts221](https://github.com/RT-Thread-packages/hts221) |flybreak|other|HTS221 传感器驱动包，支持：温度，湿度|
| [ina260](https://github.com/xupenghu/ina260.git) |xph|Apache-2.0|ina260 软件包|
| [max17048](https://github.com/aeo123/MAX17048.git) |zpw|MIT|电池监测芯片|
| [mlx90392](https://github.com/lgnq/mlx90392) |lgnq|Apache-2.0|MLX90392 是来自迈来芯公司的一颗低功耗的3D磁位置传感器|
| [ccs811](https://github.com/luhuadong/rtt-ccs811) |luhuadong|Apache-2.0|CCS811 气体检测传感器，可检测TVOC和CO2浓度|
| [sr04](https://github.com/alec-shan/hc-sr04) |alec-shan|Apache-2.0|对接RT-Thread Sensor框架的HC-SR04驱动软件包|
| [bma400](https://github.com/RT-Thread-packages/bma400) |flybreak|other|这是 BMA400 传感器驱动包，支持：加速度计，记步|
| [lsm6dsl](https://github.com/RT-Thread-packages/lsm6dsl) |flybreak|other|这是 LSM6DSL 传感器驱动包，支持：加速度计，陀螺仪，计步|
| [ds18b20](https://github.com/willianchanlovegithub/ds18b20) |WillianChan|Apache-2.0|数字温度传感器 ds18b20 的软件包|
| [bmi160_bmx160](https://github.com/RT-Thread-packages/bmi160_bmx160) |gztss|other|BMI160 6 轴传感器以及 BMX160 9 轴传感器的驱动包|
| [hmc5883](https://github.com/gmyFighting/hmc5883) |MYGuo|Apache-2.0|hmc5883 软件包|
| [vl53l0x](https://github.com/Prry/rtt-vl53l0x) |panrui|Apache-2.0|VL53L0X 飞行时间(TOF)传感器驱动软件包|
| [ina226](https://github.com/xupenghu/ina226.git) |xph|Apache-2.0|ina226 软件包|
| [df220](https://github.com/MiraMEMS-Wonderful/df220-RT-Thread.git) |Zhou DingHua|GPL-3.0|本软件包是 MiraMEMS df220 力传感器在 RT-Thread 中的驱动包。|
| [hs300x](https://github.com/Guozhanxin/hs300x) |flyboy|Apache-2.0|数字温湿度传感器 hs300x 的驱动库|
| [lsm6dsm](https://github.com/my-RT-packages/lsm6dsm.git) |zcj20080882|MIT|STMicroelectronics的LSM6DSM传感器驱动，支持加速度计/陀螺仪/计步/温度|
| [tmp1075](https://github.com/Prry/rtt-tmp1075) |panrui|Apache-2.0|TMP1075 数字温度传感器驱动软件包|
| [shtc1](https://github.com/nfsq246/RTT_SHTC1) |nfsq246|other|shtc1传感器驱动包，支持：温度，湿度|
| [hshcal001](https://github.com/lucaslsh/hshcal001.git) |lucalsh|Apache-2.0|hshcal001 传感器驱动包，支持：温度、湿度计算.|
| [bme280](https://github.com/RT-Thread-packages/bme280) |flybreak|other|这是 BME280 传感器驱动软件包，支持：气压，湿度|
| [max31865](https://github.com/SimpleInit/max31865) |SimpleInit|Apache-2.0|数字温度传感器 max31865 的软件包|
| [cw2015](https://github.com/qingehao/CW2015) |qingehao|Apache-2.0|锂电池电量计驱动|
| [kobuki](https://github.com/wuhanstudio/kobuki) |wuhanstudio|MIT|Kobuki 机器人串口通信驱动|
| [libnfc](https://github.com/wuhanstudio/libnfc) |wuhanstudio|LGPL-3.0|libnc 软件包|
| [tca9534](https://github.com/Prry/rtt-tca9534) |panrui|Apache-2.0|i2c接口8位I/O扩展芯片驱动软件包|
| [rc522](https://github.com/greedyhao/rc522_rtt) |greedyhao|Apache-2.0|rc522 rfid 模块驱动|
| [vsensor](https://github.com/RT-Thread-packages/vsensor) |RealThread|Apache-2.0|虚拟传感器设备|
| [lkdGui](https://github.com/guoweilkd/lkdGui) |guoweilkd|GPL-2.0|lkdGui是一款为单色显示屏制作的图形化界面，用于设计简单漂亮的图形界面。|
| [infrared](https://github.com/RT-Thread-packages/infrared_framework) |RealThread|Apache-2.0|基于 rt-thread 的 pin,pwm 和 hwtimer 驱动的红外框架。|
| [mcp23008](https://github.com/XiaojieFan/mcp23008.git) |XiaojieFan|Apache-2.0|针对 I2C 并行口扩展 8 位 I/O 软件包|
| [vdevice](https://github.com/RT-Thread-packages/vdevice) |stackRyan|Apache-2.0|适配于rt-thread device框架下的虚拟IO设备。|
| [nrf5x_sdk](https://github.com/supperthomas/nrf5x_sdk) |supperthomas|unknown|Nordic SDK软件开发包|
| [bluetrum_sdk](https://github.com/BLUETRUM/bluetrum_sdk) |BLUETRUM|MIT|bluetrum sdk|
| [gt9147](https://github.com/RT-Thread-packages/gt9147) |tyustli|Apache-2.0|这是 GT9147 触摸芯片的驱动包|
| [ft6236](https://github.com/liuduanfei/ft6236) |liuduanfei|Apache-2.0|这是 FT6236 触摸芯片的驱动包。|
| [ft5426](https://github.com/liuduanfei/ft5426) |liuduanfei|Apache-2.0|这是 FT5426 触摸芯片的驱动包。|
| [gt1151](https://github.com/Jackistang/GT1151) |Jackistang|Apache-2.0|gt1151 驱动|
| [ft6206](https://github.com/RT-Thread-packages/ft6206) |Willian Chan|Apache-2.0|这是 FT6206 触摸芯片的驱动包。|
| [gt917s](https://github.com/lilisheng411527/gt917s.git) |layson.li|LGPL-2.1| gt917s 驱动|
| [gt911](https://github.com/RiceChen0/gt911) |RiceChen|Apache-2.0|gt911 驱动。|
| [cst816x](https://github.com/Z8MAN8/cst816x) |Z8MAN8|Apache-2.0|cst816x 触摸芯片的驱动包。|
| [xpt2046](https://github.com/LeeChunHei/xpt2046_touch_rtt) |LeeChunHei|MIT|xpt2046 電阻觸摸屏驅動软件包|
| [nes](https://github.com/Ghazigq/nes) |Ghazigq|Apache-2.0|nes模拟器c库。|
| [pcf8574](https://github.com/RT-Thread-packages/pcf8574) |RealThread|Apache-2.0|针对 I2C 并行口扩展 8 位 I/O 软件包|
| [multi_infrared](https://github.com/jsrdczy/rt_thread_multi_infrared_frame) |jsrdczy|Apache-2.0|基于rt-thread的复数红外通道同时接收并解码的驱动框架。|
| [qkey](https://github.com/qiyongzhong0/rt-thread-qkey) |qiyongzhong0| LGPL-2.1|一个快捷易用的按键驱动包|

## security

 | 包名 | 作者  | license   | 备注      |
| ------------------------------------------------------------ | ------------------- | -------------------- | ------------------------------------------------------------ |
| [libhydrogen](https://github.com/wuhanstudio/libhydrogen) |wuhanstudio|ISC|一个轻量级，易用，适合嵌入式的密码学软件包|
| [trusted-firmware-m](https://github.com/RT-Thread-packages/trusted-firmware-m) |Trusted Firmware-M| BSD-3-Clause|Cortex M系列架构安全固件|
| [mbedtls](https://github.com/RT-Thread-packages/mbedtls) |RealThread|Apache-2.0|一个开源的、可移植的、易于使用的、可读的且灵活的 SSL 库|
| [yd_crypto](https://github.com/china-hai/yd_crypto) |china-hai|Apache-2.0|用于微控制器的加解密算法库，平台无关、算法独立、易移植、易使用。|
| [tinycrypt](https://github.com/RT-Thread-packages/tinycrypt) |RealThread| BSD-2-Clause|一个简小并且可配置的加解密软件包|
| [libsodium](https://github.com/RT-Thread-packages/libsodium-legacy) |RealThread|ISC|一个现代的、易用的加密库 (不推荐在 MCU 上使用，请用 libhydrogen 替代).|

## language

 | 包名 | 作者  | license   | 备注      |
| ------------------------------------------------------------ | ------------------- | -------------------- | ------------------------------------------------------------ |
| [Lua](https://github.com/liu2guang/Lua2RTT) |liu2guang|MIT|Lua 在 RT-Thread 上的移植|
| [jerryscript](https://github.com/RT-Thread-packages/jerryscript) |RealThread|Apache-2.0|针对 RT-Thread 的 JerryScript 移植|
| [LuatOS](https://github.com/openLuat/luatos-soc-rtt) |Dozingfiretruck|Apache-2.0|LuatOS : 面向物联网设备的强大嵌入式Lua引擎|
| [simple_xml](https://github.com/xfwangqiang/simple_xml) |xfwangqiang|MIT|基于C语言的XML解析器，开发本项目的目的在于开发一个能在多平台应用的代码。目前代码已经应用在WIN10、Linux、rt-thread、VxWorks等主流操作系统。|
| [ezXML](https://github.com/RT-Thread-packages/ezXML) |RealThread|MIT|一个用 C 语言描述的 XML 解析库，并且简单易用|
| [pikascript](https://github.com/pikasTech/pikascript) |lyon|MIT|极易定制的轻量级python脚本支持工具|
| [cJSON](https://github.com/RT-Thread-packages/cJSON) |RealThread|MIT|超轻量级的 C 语言 json 解析库|
| [parson](https://github.com/IoTSharp/parson) |maikebing|MIT|parson 是一个由kgabis用C写的轻量级json库|
| [agile_jsmn](https://github.com/loogg/agile_jsmn) |loogg|MIT|轻量级json解析器。|
| [rapidjson](https://github.com/wuhanstudio/rapidjson) |wuhanstudio|MIT|支持 SAX/DOM 的 C++ JSON 处理库|
| [rt_cjson_tools](https://github.com/maplerian/rt_cjson_tools) |maplerian|Apache-2.0|用于 RT-Thread 的 cJSON工具库|
| [ljson](https://github.com/qiaoqidui/ljson) |qiaoqidui|unknown|ANSI-C 标准的 JSON 解析器|
| [jsmn](https://github.com/RT-Thread-packages/jsmn) |RealThread|MIT|世界上最快 JSON 解析器或标记器|
| [micropython](https://github.com/RT-Thread-packages/micropython) |armink|MIT|MicroPython 在 RT-Thread 上的移植|
| [rtt_rust](https://github.com/vito-chl/rtt_rust.git) |chenhonglin|Apache-2.0|为rt-thread增加rust支持。|

## ai

 | 包名 | 作者  | license   | 备注      |
| ------------------------------------------------------------ | ------------------- | -------------------- | ------------------------------------------------------------ |
| [quest](https://github.com/wuhanstudio/QuEST) |wuhanstudio|MIT|嵌入式系统上的量子计算机模拟器|
| [libann](https://github.com/wuhanstudio/rt-libann) |wuhanstudio|MIT|轻量级 ANN 库，可以训练，保存和导入模型|
| [nnom](https://github.com/majianjia/nnom) |Jianjia Ma|Apache-2.0|轻量级的神经网络框架, 模型一键转换, 让MCU也神经一把|
| [ncnn](https://github.com/yc66542260/ncnn-rtthread) |yechang|BSD-3-Clause|ncnn静态库|
| [ulapack](https://github.com/wuhanstudio/ulapack) |wuhanstudio|MIT|嵌入式线性代数库|
| [elapack](https://github.com/wuhanstudio/elapack) |wuhanstudio|MIT|嵌入式线性代数库，兼容 matlab|
| [onnx-parser](https://github.com/wuhanstudio/rt-onnx-parser) |wuhanstudio|MIT|开源神经网络模型 onnx 解析库|
| [naxos](https://github.com/wuhanstudio/naxos) |wuhanstudio|LGPL-3.0|C++ Constraint Programming Library|
| [TensorflowLiteMicro](https://github.com/QingChuanWS/TensorflowLiteMicro) |QingChuanWS|LGPLv2.1|用于rt-thread操作系统的轻量级深度学习端侧推理框架Tensorflow Lite软件包。|
| [onnx-backend](https://github.com/wuhanstudio/onnx-backend) |wuhanstudio|MIT|开源神经网络模型 onnx 后端，支持几乎所有主流机器学习模型|
| [uCOSIII_Wrapper](https://github.com/mysterywolf/RT-Thread-wrapper-of-uCOS-III) |Meco Man|Apache-2.0|RT-Thread操作系统的uCOS-III兼容层：让基于uC/OS-III开发的应用层无感地迁移到RT-Thread操作系统|
| [uC_CRC](https://github.com/mysterywolf/uC-CRC-for-RT-Thread) |Meco Man|Apache-2.0|uC/CRC for RT-Thread|
| [uC_Common](https://github.com/mysterywolf/uC-Common-for-RT-Thread) |Meco Man|Apache-2.0|uC/Common for RT-Thread|
| [uC_Modbus](https://github.com/mysterywolf/uC-Modbus-for-RT-Thread) |Meco Man|Apache-2.0|uC/Modbus for RT-Thread|
| [uCOSII_Wrapper](https://github.com/mysterywolf/RT-Thread-wrapper-of-uCOS-II) |Meco Man|Apache-2.0|RT-Thread操作系统的uCOS-II兼容层：让基于uC/OS-II开发的应用层无感地迁移到RT-Thread操作系统|
| [uC_CLK](https://github.com/mysterywolf/uC-Clk-for-RT-Thread) |Meco Man|Apache-2.0|uC/Clk for RT-Thread|

## system

 | 包名 | 作者  | license   | 备注      |
| ------------------------------------------------------------ | ------------------- | -------------------- | ------------------------------------------------------------ |
| [LiteOS-SDK](https://github.com/RT-Thread-packages/LiteOS-SDK) |RT-Thread-packages|Apache-2.0|LiteOS SDK|
| [rti](https://github.com/RT-Thread-packages/rti) |RealThread|LGPL-2.1|RT-Thread 展示系统内部运行信息的组件，能够帮助分析系统内部情况|
| [lpm](https://github.com/RT-Thread-packages/lpm) |RealThread|Apache-2.0|逻辑分区管理，负责存储设备管理和分区管理。|
| [yaffs2](https://github.com/heyuanjie87/yaffs2_rtt_port) |heyuanjie87|GPL-2.0|yaffs2 移植到RT-Thread|
| [cairo](https://github.com/RT-Thread-packages/cairo) |RealThread|LGPL/MPL|适用于多平台的 2D 图形软件包|
| [ramdisk](https://github.com/majianjia/ramdisk) |majianjia|Apache-2.0|内存块设备|
| [thread_pool](https://github.com/armink-rtt-pkgs/thread_pool) |armink|MIT|基于 RT-Thread 的线程池实现|
| [agile_upgrade](https://github.com/loogg/agile_upgrade) |loogg|Apache-2.0|用于快速构建 bootloader 的中间件。|
| [minIni](https://github.com/hichard/minIni) |hichard|Apache-2.0|minIni 在 RT-Thread 上移植的软件包|
| [CherryUSB](https://github.com/sakumisu/CherryUSB) |sakumisu|Apache-2.0|小而美、可移植性高的 USB 主从协议栈。|
| [fal](https://github.com/RT-Thread-packages/fal) |RealThread| LGPL-2.1|Flash 抽象层的实现，负责管理 Flash 设备和 Flash 分区|
| [perf_counter](https://github.com/GorgonMeducer/perf_counter) |GorgonMeducer|Apache-2.0|Cortex-M systick 的专用计数器|
| [FreeRTOS_Wrapper](https://github.com/RT-Thread-packages/FreeRTOS-Wrapper) |RT-Thread-packages|Apache-2.0|RT-Thread操作系统的FreeRTOS兼容层：让基于FreeRTOS开发的应用层无感地迁移到RT-Thread操作系统|
| [tlsf](https://github.com/RT-Thread-packages/tlsf) |namexx|Apache-2.0|TLSF是一个可以预期执行时间、碎片化程度低的动态内存分配算法。|
| [TinyUSB](https://github.com/RT-Thread-packages/tinyusb) |tfx2001|MIT|用于嵌入式系统的开源跨平台USB协议栈|
| [mlibc](https://github.com/plctlab/mlibc) |plctlab|MIT|mbedded libc, especially for RISC-V|
| [FlashDB](https://github.com/armink/FlashDB) |armink|Apache-2.0|一款支持 KV 数据和时序数据的轻量级数据库|
| [CMSIS_5_AUX](https://github.com/RT-Thread-packages/CMSIS_5_AUX) |RT-Thread-packages|Apache-2.0|CMSIS_5软件包的辅助构建软件包（该软件包不需要用户选择）|
| [CMSIS_RTOS2](https://github.com/RT-Thread-packages/CMSIS_RTOS2) |RT-Thread-packages|Apache-2.0|RT-Thread的CMSIS-RTOS2标准兼容层|
| [CMSIS_5](https://github.com/ARM-software/CMSIS_5) |ARM-software|Apache-2.0|CMSIS-5|
| [CMSIS_RTOS1](https://github.com/RT-Thread-packages/CMSIS_RTOS1) |RT-Thread-packages|Apache-2.0|RT-Thread的CMSIS-RTOS1标准兼容层|
| [sys_load_monitor](https://github.com/armink-rtt-pkgs/sys_load_monitor) |armink|Apache-2.0|一款轻量级的系统负荷监视器|
| [kmulti_rtimer](https://github.com/kylepengchn/kmulti_rtimer.git) |kylepengchn|Apache-2.0|一款轻量级的系统负荷监视器|
| [uffs](https://github.com/RT-Thread-packages/uffs) |prife|LGPL-2|超低功耗的闪存文件系统|
| [sqlite](https://github.com/RT-Thread-packages/SQLite) |RealThread|unknown|SQLite 是一个完备、高度可靠、嵌入型、全功能、公共领域的 SQL 数据库引擎|
| [littlefs](https://github.com/RT-Thread-packages/littlefs) |geniusgogo|BSD-3-Clause|为微控制器设计的一个小型的且掉电安全的文件系统|
| [rt-robot](https://github.com/RT-Thread-packages/rt-robot) |wuhanstudio|MIT|RT-Thread 机器人平台|
| [openamp](https://github.com/bigmagic123/openamp.git) |RealThread|LGPL-2.1|RT-Thread OpenAMP软件包|
| [qpc](https://github.com/Zhyolo/qpc-rtthread) |Zhyolo|GPL-3.0|轻量级软件框架 QP/C|
| [sfdb](https://github.com/WKJay/sfdb) |WKJay|Apache-2.0|简单文件数据库|
| [partition](https://github.com/RT-Thread-packages/partition) |RealThread|LGPL-2.1|一个基于块设备的分区管理软件包|
| [qboot](https://github.com/qiyongzhong0/rt-thread-qboot) |qiyongzhong0| LGPL-2.1|qboot ：一个用于快速制作bootloader的组件|
| [TaskMsgBus](https://github.com/slyant/TaskMsgBus.git) |slyant|Apache-2.0|基于RT-Thread线程间同步和通讯的消息总线管理通用软件包|
| [Arm-2D](https://github.com/liuduanfei/Arm-2D) |liuduanfei|Apache-2.0|Arm-2D 图形库。|
| [lwext4](https://github.com/RT-Thread-packages/lwext4) |RealThread|GPL-2.0|适合微控制器的 ext2 / 3/4文件系统的实现|
| [Qfplib_M0_tiny](https://github.com/mysterywolf/Qfplib-M0-tiny) |Meco Man|GPL|Cortex-M0浮点运算汇编加速库(tiny版)|
| [Qfplib_M0_full](https://github.com/mysterywolf/Qfplib-M0-full) |Meco Man|GPL|Cortex-M0浮点运算汇编加速库(full版)|
| [Qfplib_M3](https://github.com/mysterywolf/Qfplib-M3) |Meco Man|GPL|Cortex-M3浮点运算汇编加速库|
| [tz-database](https://github.com/RT-Thread-packages/tz) |eggert|BSD-3-Clause|时区和夏令时数据库|
| [syswatch](https://github.com/qiyongzhong0/rt-thread-syswatch) |qiyongzhong0| LGPL-2.1|系统看守：一个用于保障系统长期正常运行的组件|
| [event_recorder](https://github.com/RT-Thread-packages/event_recorder) |armink|Apache-2.0|一款轻量级的事件记录器，支持事件的记录与回放|
| [EV](https://github.com/sogwms/EV) |sogwms|Apache-2.0|高效开发 vehicles(包括无人机) 的框架|
| [flash_blob](https://github.com/Aladdin-Wang/flash_blob.git) |kk|Apache-2.0|用于快速生成flash驱动文件的工具和flash抽象层。|
| [jffs2](https://github.com/RT-Thread-packages/jffs2) |prife|GPL-2.0|闪存日志型文件系统第 2 版|
| [TFDB](https://github.com/smartmx/TFDB) |smartmx|MIT|通用精简稳定的单片机flash存储数据方案|
| [mcuboot](https://github.com/iysheng/rt_mcuboot.git) |iysheng|Apache-2.0|一个针对微控制器的涉及 bootloader, flash layout 的通用框架。|
| [Ppool](https://github.com/mysterywolf/Ppool) |Meco Man|LGPL-2.1|基于pthread的线程池库|
| [rt_kprintf_threadsafe](https://github.com/mysterywolf/rt_kprintf_threadsafe) |Meco Man|Apache-2.0|线程安全版本的rt_kprintf|
| [rt_memcpy_cm](https://github.com/mysterywolf/rt_memcpy_cm) |Meco Man|Apache-2.0|rt_memcpy函数的Cortex-M内核汇编加速版|
| [rt_vsnprintf_full](https://github.com/mysterywolf/rt_vsnprintf_full) |Meco Man|Apache-2.0|rt_vsnprintf全功能版本|
| [plccore](https://github.com/hyafz/plccore) |hyafz|LGPL-2.1|plccore 在 RT-Thread 上移植的软件包|
| [pixman](https://github.com/RT-Thread-packages/pixman) |RealThread|MIT|提供低等级像素控制的库|

## multimedia

 | 包名 | 作者  | license   | 备注      |
| ------------------------------------------------------------ | ------------------- | -------------------- | ------------------------------------------------------------ |
| [PDFGen](https://github.com/mysterywolf/PDFGen) |Meco Man|Unlicense|PDF文档生成库|
| [NUemWin](https://github.com/wosayttn/NUemWin) |wosayttn|LGPL-2.1|NUemWin在RT-Thread上的移植|
| [touchgfx2rtt](https://github.com/Aladdin-Wang/touchgfx2rtt.git) |kk|LGPL-2.1|touchgfx在RT-Thread上的移植。|
| [STemWin](https://github.com/loogg/STemWin) |malongwei|LGPL-2.1|STemWin在RT-Thread上的移植|
| [LittlevGL2RTT](https://github.com/liu2guang/LittlevGL2RTT) |liu2guang|MIT|LittlevGL 图形库 (LVGL 7.x, 老版本)|
| [LVGL](https://github.com/lvgl/lvgl) |kisvegabor|MIT|LVGL轻量级通用型图形库（官方上游）|
| [gui_guider_demo](https://github.com/NXPmicro/gui-guider-demos.git) |Ting Liu|MIT|GUI Guider生成的LVGL演示示例|
| [lv_music_demo](https://github.com/RT-Thread-packages/lv_demo_music) |Meco Man|MIT|LVGL的播放器演示示例(RT-Thread版本)|
| [wavplayer](https://github.com/RT-Thread-packages/wavplayer) |RealThread|Apache-2.0|简洁的wav格式的音乐播放器，提供播放和录音功能|
| [AzureGUIX](https://github.com/HelloByeAll/AzureGUIX) |HelloByeAll|Apache-2.0|微软THREADX系统中间件 AzureGUIX|
| [TinyJPEG](https://github.com/StackRyan/TinyJPEG) |StackRyan|Apache-2.0|一个轻量的JPEG编码软件包|
| [mupdf](https://github.com/rtoslab/mupdf-rtt) |rtoslab|AGPL-3.0|轻量级PDF，XPS和电子书查看器|
| [gui_engine](https://github.com/RT-Thread-packages/gui_engine) |RealThread| LGPL-2.1|来自 RT-Thread 官方的 GUI 引擎|
| [termbox](https://github.com/mysterywolf/termbox) |Meco Man|MIT|轻量TUI图形库|
| [persimmon](https://github.com/RT-Thread-packages/persimmon) |RealThread|unknown|RT-Thread 的柿饼 UI|
| [mcurses](https://github.com/wuhanstudio/mcurses) |wuhanstudio|MIT|轻量级的 ncurses 控制台绘图库|
| [TJpgDec](https://github.com/RT-Thread-packages/TJpgDec) |RealThread|BSD|JPEG 解码库|
| [u8g2-official](https://github.com/olikraus/u8g2) |olikraus|BSD|u8g2 不同种类单色屏驱动库（上游官方版本）|
| [u8g2](https://github.com/wuhanstudio/rt-u8g2) |wuhanstudio|BSD|u8g2 不同种类单色屏驱动在 RT-Thread 移植库（老版本）|
| [mp3player](https://github.com/MrzhangF1ghter/mp3player) |MrzhangF1ghter|Apache-2.0|一个简易的mp3格式音乐播放器|
| [helix](https://github.com/liuduanfei/helix) |liuduanfei|AGPL-3.0|Helix,mp3 解码库|
| [3gpp_amrnb](https://github.com/myshowtogo/3gpp_amrnb) |myshow|Apache|3gpp amrnb 编解码库|
| [qrcode](https://github.com/RT-Thread-packages/qrcode) |RealThread|MIT|一个用于将字符串生成二维码的软件包|
| [ugui](https://github.com/xidongxu/ugui.git) |xidongxu|unknown|开源图形库ugui移植到rtthread。|
| [vt100](https://github.com/wuhanstudio/vt100) |wuhanstudio|MIT|串口终端绘图库，可以在 msh 下画图|
| [openmv](https://github.com/RT-Thread-packages-by-SummerGift/openmv) |SummerGift|MIT|openmv 在 RT-Thread 上的移植|




