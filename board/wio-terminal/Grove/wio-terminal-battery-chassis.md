---
sidebar_position: 8
slug: /wio-terminal-battery-chassis
---

# Wio Terminal 电池底盘



为了方便使用，SeeedStudio 为 Wio Terminal 设计了一个锂电池扩展盒，内置 650mAh 锂离子电池，并提供了 6 个 Grove 接口。

![](https://static.getiot.tech/Wio-Terminal-Battery-Chassis.png#center)



## 功能特性

- 内置 650mAh 可充电锂聚合物电池
- 使用 USB Type-C 充电
- 支持过流保护（Overcurrent protection）
- 支持打嗝模式（Hiccup mode）和打嗝保护（Hiccup Protection）
- 提供 4 个 Grove 数字接口（Analog/Digital）
- 提供 1 个 Grove I2C 接口
- 提供 1 个 Grove UART 接口
- 外壳内含磁铁，以便将 Wio Terminal 粘在白板上



## 技术规格

- Wio Terminal 电池底盘可由 USB Type-C 接口或内部电池供电。其中，USB Type-C 最大输入电流为 2A，输入电压范围是 4.75V~5.25V。
- 内置电池为可充电锂聚合物电池，容量为 650mAh。电池输出电压为 3.7V，电池充电电压为 4.2V。电池只能通过 USB Type-C 接口充电，不能通过母头或 Grove 接口充电。
- Wio Terminal 电池底盘的待机电流小于 300uA。
- Wio Terminal 电池底盘通过 USB Type-C 接口供电时具有过流保护，过流保护的电流阈值为 2.5A。
- 当 Wio Terminal 电池底盘在电池供电模式下短路时，它将进入打嗝模式（hiccup mode）。短路解除后，会自动恢复正常供电模式。



## 接口概览

Wio Terminal 电池底盘共有 6 个 Grove 接口和 1 个 USB Type-C 接口。

![](https://static.getiot.tech/Wio-Terminal-battery-front.jpg#center)



## 注意事项

- Wio Terminal 电池底盘本身不能输出 3.3V 电压，只能输出 5V 电压。要输出 3.3V，它必须与 Wio Terminal 一起使用。
- 当 Wio Terminal 电池底盘从电池充电模式切换到电池供电模式时，会有 1.2s 的电压下降时间。
- 默认情况下，Wio Terminal 电池底盘在未连接到 USB Type-C 时由电池供电。插入 USB Type-C 之后，自动切换到 USB Type-C 供电。
- 当 Wio Terminal 电池底盘插入 USB Type-C 时，它将为电池和连接器上的 `RPI_5V` 引脚供电。 此时，电池将不供电。如果锂电池没有充满电，电量到 100% 后才会停止充电。



## 资源链接

- **[ZIP]** [Wio Terminal Battery Chassis Schematics Design File](https://files.seeedstudio.com/wiki/Wio-Terminal-Battery-Chassis/res/Wio%20Terminal%20Chassis%20-%20Battery_SCH.zip)

