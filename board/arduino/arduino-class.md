---
sidebar_position: 11
authors: [luhuadong]
---

# Arduino 类库



Arduino 包含两种库：标准库和第三方库，当然也可以自己写类库。标准库安装 Arduino IDE 后就已经导入，只需要直接调用就行，第三方类库则需要先导入再调用。



## 标准库

| 名称                  | 描述                                      | 备注 |
| --------------------- | ----------------------------------------- | ---- |
| EEPROM                | 对“永久存储器”进行读和写                  |      |
| Ethernet              | 用于通过 Arduino 以太网扩展板连接到互联网 |      |
| Firmata               | 与电脑上应用程序通信的标准串行协议        |      |
| LiquidCrystal      | 控制液晶显示屏（LCD） ||
| SD                    | 对 SD 卡进行读写操作 |      |
| Servo                 | 控制伺服电机 |      |
| SPI                   | 与使用的串行外设接口（SPI）总线的设备进行通信 |      |
| SoftwareSerial        | 使用任何数字引脚进行串行通信 |      |
| Stepper               | 控制步进电机 |      |
| WiFi                  | 用于通过 Aduino 的 WiFi 扩展板连接到互联网 |      |
| Wire                  | 双总线接口（TWI/I2C）通过网络对设备或者传感器发送和接收数据 |      |
| PWM Frequency Library | 自定义 PWM 频率 |      |
|                       |                                           |      |
|                       |                                           |      |



## 第三方库

| 名称     | 描述                                 | 备注 |
| -------- | ------------------------------------ | ---- |
| IRremote | 红外控制                             |      |
| DS3231   | 时钟芯片                             |      |
| Timer    | 利用 `millis()` 函数来模拟多线程等等 |      |



## 类库结构

- examples
- keywords.txt
- xxx.cpp
- xxx.h

