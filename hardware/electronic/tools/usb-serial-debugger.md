---
sidebar_position: 7
sidebar_label: "串口与调试器"
slug: /usb-serial-debugger
title: "USB 转串口与调试器：MCU 通信与烧录入门"
description: "介绍 USB-UART 转接板与 SWD/JTAG 调试器在嵌入式中的作用，说明接线、电平和常见排错方法。"
---

# USB 转串口与调试器：MCU 通信与烧录入门

做单片机时，你除了烙铁和电源，几乎每天都会碰到两类“电脑到板子的桥”：

1. **USB 转串口**：看日志、发命令  
2. **调试器/下载器（SWD、JTAG 等）**：烧录与单步调试  

把它们用顺，排错效率会高一个数量级。


## USB 转串口怎么接

常见芯片包括 CH340、CP2102、FT232 等。最小接线：

```bash
适配器 GND ↔ MCU GND
适配器 TX  ↔ MCU RX
适配器 RX  ↔ MCU TX
```

请记住：

- 必须共地  
- 核对 3.3V/5V 电平  
- 两端波特率一致  
- TX/RX 交叉接，不要接成 TX-TX  


### 电脑端自检

如果怀疑驱动或线材问题，可以把适配器 TX 与 RX 短接，用串口助手做回环：你打字应原样回显。回环失败时，先别急着骂 MCU。


## SWD / JTAG 调试器

如 ST-Link、J-Link、CMSIS-DAP 等，用于下载固件与调试。常见注意点：

- 至少连接 GND、SWDIO、SWCLK（复位脚视情况）  
- 目标板要供电，电平匹配  
- 接口类型与软件配置一致  


## 高频故障表

| 现象 | 你可以先查 |
| --- | --- |
| 串口乱码 | 波特率、电平、TX/RX 是否接反 |
| 找不到端口 | 驱动、线材、板子供电、USB 口 |
| 下载失败 | 接线、供电、接口选择、占用占用、目标芯片型号 |


## 和本专栏其他文章的关系

电气规则仍遵守 [高低电平](/circuit/logic-levels/) 与 [共地](/circuit/power-and-ground/)。协议波形可用 [逻辑分析仪](/circuit/logic-analyzer/) 核对。

接下来进入工艺：[焊台焊接与静电防护](/circuit/soldering-esd/)。
