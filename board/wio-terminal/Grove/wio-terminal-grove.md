---
sidebar_position: 1
slug: /wio-terminal-grove
---

# Wio Terminal Grove 接口规范



![](https://static.getiot.tech/Wio-Terminal-GROVE.jpeg#center)

Wio Terminal 配备了两个 Grove 接口：

- 数字 Grove 接口：将 Grove 接口连接到数字引脚；
- IIC Grove 接口： 将 Grove 接口连接到 IIC 引脚。

通过这两个 Grove 接口，Wio Terminal 可以简单、快速地连接 Grove 生态系统中的众多传感器和外设，帮助开发者更快地完成原型设计！



## Grove 生态系统

Grove 是 SeeedStudio 定义的一种规范的嵌入式开发套件连接接口，其目的是为了构建一个模块化的标准连接器原型系统。

Grove 采用积木式组装电子技术。与基于跳线或焊接的系统相比，Grove 的连接、试验和构建更容易，并简化了学习系统。同时，你也可以根据 Grove 的定义，构建自己的 Grove 接口设备，将更多物件连接起来，构建更大的 Grove 系统。

![](https://static.getiot.tech/wio-terminal-grove-product-line.png#center)

就 SeeedStudio 而言，Grove 系统由基本处理单元（树干）和具有标准化连接器的各种模块（树枝）组成。基本单元（通常为微处理器）允许从 Grove 模块轻松连接任何输入或输出。每个 Grove 模块通常都可以处理单个功能，例如简单的按钮或更复杂的心率传感器。

如果你使用的处理单元没有 Grove 接口，可以使用 Grove 转 Pin Header 转接线，从 Raspberry Pi 或 Arduino 的针脚连接到 Grove 模块。



## Grove 机械尺寸

Grove 接口有 4 个引脚，引脚间的距离是 2.0mm，因此它也是 PH 2.0 连接器中的一种。区别是 Grove 有机械卡扣，并且对引脚的定义和线缆的颜色制定了规范。

![Grove 接口规范](https://static.getiot.tech/seeedstudio-grove-definition.png#center)



## Grove 线缆规范

Grove 线缆有 4 种颜色：

| 引脚 | 颜色 | 备注                          |
| ---- | ---- | ----------------------------- |
| pin1 | 黄色 | 例如 I2C Grove 连接器上的 SCL |
| pin2 | 白色 | 例如 I2C Grove 连接器上的 SDA |
| pin3 | 红色 | 所有 Grove 接口的红色都是 VCC |
| pin4 | 黑色 | 所有 Grove 接口的黑色都是 GND |



## Grove 信号定义

Grove 接口是多功能的，主要有 4 种信号定义。

### 数字接口（Digital）

Grove 数字接口由 Grove 插头的四条标准线组成。两条信号线通常称为 D0 和 D1。大多数模块只使用D0，但有些（像 LED Bar Grove 显示屏）使用两者。

| 引脚 | 定义 | 描述             |
| ---- | ---- | ---------------- |
| pin1 | D0   | 第一个数字输入   |
| pin2 | D1   | 第二个数字输入   |
| pin3 | VCC  | 供电引脚 5V/3.3V |
| pin4 | GND  | 地               |



### 模拟接口（Analog）

Grove 模拟接口由 Grove 插头的四条标准线组成。两条信号线通常称为 A0 和 A1。

| 引脚 | 定义 | 描述             |
| ---- | ---- | ---------------- |
| pin1 | A0   | 第一个模拟输入   |
| pin2 | A1   | 第二个模拟输入   |
| pin3 | VCC  | 供电引脚 5V/3.3V |
| pin4 | GND  | 地               |



### UART 接口

The Grove UART 是特殊的一种数字输入输出接口。它使用 pin1 和 pin2 进行串行输入和发送。其中，pin1 是 Rx 线（用于接收数据），pin2 是 Tx 线（用于向 Grove 模块传输数据）。

提示：引脚方向的标注是相对于主机而言的。

**主机端定义**

| 引脚 | 定义 | 描述             |
| ---- | ---- | ---------------- |
| pin1 | M_RX | 主机接收         |
| pin2 | M_TX | 主机发送         |
| pin3 | VCC  | 供电引脚 5V/3.3V |
| pin4 | GND  | 地               |

**从机端定义**

| 引脚 | 定义 | 描述             |
| ---- | ---- | ---------------- |
| pin1 | S_TX | 从机发送         |
| pin2 | S_RX | 从机接收         |
| pin3 | VCC  | 供电引脚 5V/3.3V |
| pin4 | GND  | 地               |



### I2C 接口

有许多类型的 I2C Grove 传感器可用。大多数器件同时支持 5V 和 3.3V，但有少数只支持 3.3V 或只支持 5V。因此，在使用之前需要仔细检查电压参数！

| 引脚 | 定义 | 描述             |
| ---- | ---- | ---------------- |
| pin1 | SCL  | I2C时钟          |
| pin2 | SDA  | I2C数据          |
| pin3 | VCC  | 供电引脚 5V/3.3V |
| pin4 | GND  | 地               |

Grove I2C 连接器具有标准布局。pin1 是 SCL 信号，pin2 是 SDA 信号。电源和接地与其他连接器相同。可以认为是 Grove 数字接口（Digital）的一个特殊版本。

实际上，很多主控制器上的 I2C 总线（如 ESP8266、Raspberry Pi 和 Arduino）都会使用数字 I/O 引脚来模拟，即软件 I2C 总线。因此 Grove 数字接口也可以当作 I2C 接口使用。



## Grove 连接示例

* [Wio Terminal 外接 TDS 传感器示例](/wiot/wio-terminal-grove-tds-sensor/)
* [Wio Terminal 外接 OLED 显示器示例](/wiot/wio-terminal-grove-oled-display/)
* [Wio Terminal 外接 Temperature 传感器示例](/wiot/wio-terminal-grove-temp-sensor/)
* [Wio Terminal 外接 GPS 卫星定位示例](/wiot/wio-terminal-grove-gps-sensor/)



