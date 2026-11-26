---
sidebar_position: 31
authors: [luhuadong]
---

# Arduino Nano 33 BLE Sense



## 概述

Arduino Nano 33 BLE Sense 是一款基于 nRF52840 SoC ARM 32 位处理器的微型开发板，其主控芯片集成了蓝牙低功耗（BLE）。NANO 33 BLE 不仅保留了与经典款 NANO 同样的尺寸与管脚，且在此基础上配有多种高性能传感器（角速度，加速度，压力，温湿度，距离，光感，姿态）等，在实现完全兼容的条件下增加了无限多种的组合玩法，可以迅速实现并验证转瞬即逝的灵感火花，是一款所有创客都梦寐以求的伴侣。

![](https://static.getiot.tech/arduino-nano-33-ble-sense-main.jpeg#center)



### 功能特点

Arduino 系列的开发板可以分为入门级和进阶级，其中 Nano 33 BLE Sense 毫无疑问是进阶系列中最受创客喜爱的开发板。它不仅继承了 Arduino 家族中近乎完美的生态基因，而且在保留硬件小巧轻便的基础上，提升了板卡的性能，可延展性与互动性，因此绝对是一款可以陪伴所有电子创客走得最长，最远，最久的伙伴。以下我们列举了 Nano 33 的几个亮点：

- 首屈一指的 Arduino 开源硬件生态，可以最快速完成原型搭建，验证和测试；
- 具有多种物理传感器，能感应加速度，角速度，磁场，温湿度，距离，压强；
- 带有语音，颜色，手势等识别功能，可用于机器学习项目的开发；
- 可实现蓝牙低功耗无线通讯；
- DIP 加邮票孔封装，同时满足面包板和扩展板搭配的使用需求。



### 板载资源

| 资源             | 描述  |
| --------------------------- | ------------------------------------------------------------ |
| 微控制器             | nRF52840 [(datasheet)](https://content.arduino.cc/assets/Nano_BLE_MCU-nRF52840_PS_v1.1.pdf) |
| 工作电压         | 3.3V                                                         |
| 输入电压（上限） | 21V                                                          |
| I/O 引脚最大电流 | 15 mA                                                        |
| 时钟频率               | 64MHz                                                        |
| Flash 容量            | 1MB (nRF52840)                                               |
| SRAM 容量                     | 256KB (nRF52840)                                             |
| EEPROM                      | none                                                         |
| 数字输入输出引脚 | 14                                                           |
| PWM 引脚                    | all digital pins                                             |
| UART                        | 1                                                            |
| SPI                         | 1                                                            |
| I2C                         | 1                                                            |
| 模拟输入引脚       | 8 (ADC 12 bit 200 ksamples)                                  |
| 模拟输出引脚      | Only through PWM (no DAC)                                    |
| 外部中断       | 所有数字引脚                                        |
| LED_BUILTIN                 | 13                                                           |
| USB                         | Native in the nRF52840 Processor                             |
| IMU 传感器                     | LSM9DS1 ([datasheet](https://content.arduino.cc/assets/Nano_BLE_Sense_lsm9ds1.pdf)) |
| Microphone 传感器             | MP34DT05 ([datasheet](https://content.arduino.cc/assets/Nano_BLE_Sense_mp34dt05-a.pdf)) |
| Gesture, light, proximity 传感器 | APDS9960 ([datasheet](https://content.arduino.cc/assets/Nano_BLE_Sense_av02-4191en_ds_apds-9960.pdf)) |
| Barometric pressure 传感器     | LPS22HB ([datasheet](https://content.arduino.cc/assets/Nano_BLE_Sense_lps22hb.pdf)) |
| Temperature, humidity 传感器   | HTS221 ([datasheet](https://content.arduino.cc/assets/Nano_BLE_Sense_HTS221.pdf)) |
| 长度                      | 45 mm                                                        |
| 宽度                     | 18 mm                                                        |
| 重量                      | 5 gr（包含针座）                                      |

备注：

- DC Current per I/O Pin 表示“单一 I/O口（pin 脚）最大能够供给（承受）的电流”
- DC Current VCC and GND Pins 表示“一组 VCC & GND 可以供给（承受）的总电流”



### 资源分布

![](https://static.getiot.tech/arduino-nano33-ble-sensor-layout.jpg#center)



## 控制器

nRF52840 NINR B306 蓝牙模组



## 传感器

| 型号       | 类型                   | 示例                                                         |
| ---------- | ---------------------- | ------------------------------------------------------------ |
| HTS221     | 温湿度传感器           | [Arduino_HTS221](https://github.com/arduino-libraries/Arduino_HTS221) |
| LSM9DS1    | 九轴加速度重力传感器   | [Arduino_LSM9DS1](https://github.com/arduino-libraries/Arduino_LSM9DS1) |
| APDS9960   | 距离、颜色、姿态传感器 | [Arduino_APDS9960](https://github.com/arduino-libraries/Arduino_APDS9960) |
| MP34DT05-A | 数字麦克风             | [PDM](https://www.arduino.cc/en/Reference/PDM)               |
| LPS22HB    | 气压传感器             | [Arduino_LPS22HB](https://github.com/arduino-libraries/Arduino_LPS22HB) |



## 引脚定义

![](https://static.getiot.tech/arduino-nano33-ble-sense-pinout.png#center)

下载 [完整引脚定义图 PDF](https://content.arduino.cc/assets/Pinout-NANOsense_latest.pdf)



