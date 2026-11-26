---
sidebar_position: 1
slug: /wio-terminal-bluetooth
---

# Wio Terminal 蓝牙使用教程

![](https://static.getiot.tech/wio-terminal-bluetooth-connect.png#center)

本文主要介绍[蓝牙](/bluetooth/)（Bluetooth）的基本知识，并演示如何在 Wio Terminal 上使用蓝牙功能。

Wio Terminal 配备的无线网卡是 Realtek RTL8720，它支持 Wi-Fi（802.11 b/g/n，2.4GHz）和蓝牙（BLE4.2）功能。在开始本次学习之前，请确保你已经阅读 [Wio Terminal 网卡固件更新](/wiot/wio-terminal-network-firmware/)，并完成固件更新和 Arduino 依赖库的安装。



## 安装依赖库

Wio Terminal 蓝牙连接需要依赖一些 Arduino 库。SeeedStudio 已经在 Arduino 库管理器中包含了 Wio Terminal 的所有无线相关库。因此，你只需在 Arduino IDE 中打开 Arduino 库管理器，输入下面的关键字就可以找到它们。

| 关键字           | Arduino 库                                                   |
| ---------------- | ------------------------------------------------------------ |
| seeed rpcble     | [Seeed_Arduino_rpcBLE](https://github.com/Seeed-Studio/Seeed_Arduino_rpcBLE) |
| seeed rpcunified | [Seeed_Arduino_rpcUnified](https://github.com/Seeed-Studio/Seeed_Arduino_rpcUnified) |



## 蓝牙基本概念

### 客户端与服务器

- 客户端（Client）向服务器（Server）发出数据通信请求，允许设备与其他蓝牙设备无线交换数据。
- 服务端（Server）向客户端（Client）提供数据服务，通过特征（Characteristic）封装数据，多个特征形成一个服务（Service），因此服务（Service）是一个基本的 BLE 应用程序。
- 客户端（Client）和服务器（Server）是通信关系，它们既可以作为 master 也可以作为 slave。

### UUID 标识

- UUID 通常用于标识需要在系统或其网络中唯一的信息。
- 所有 BLE 设备都有服务 UUID、特征 UUID 和描述符 UUID，所有产品的 UUID 都应该是唯一的，并且重复的概率低，这使得它们可用作数据库中的关联键和组织内物理硬件的标识符。

### Wio Terminal 的 BLE

带有低功耗蓝牙（BLE）的 Wio Terminal 可以充当服务器和客户端。BLE 服务器会向周围发射信号以通告其存在，可以被其他设备扫描发现，并且它包含客户端可以读取的数据。BLE 支持广播模式和 Mesh 网络两种模式。在广播模式下，服务器将数据传输到许多连接的客户端，在网状网络模式下，所有设备都连接在一起。

服务器和客户端都有一个“SERVICE UUID”来在服务器和客户端之间建立连接。在这个服务中，可以有几个由特征 UUID 定义的“特征”。我们使用两个特性 TX 和 RX 来向客户端发送数据和从客户端接收数据。Wio Terminal（充当服务器）通过 TX 特征 UUID “通知” 客户端，数据被发送到 Wio Terminal 并通过 RX 特征 UUID 接收。既然有发送和接收，那么 Wio Terminal 上的 TX 其实就是手机 App 上的 RX。

### nRF Connect 应用程序

在刚开始使用时，我们可能并不知道蓝牙设备的 UUID 和 MAC 地址。这时候可以使用 nRF connect（手机 App）来搜索附件的 BLE 设备，并显示 UUID 和 MAC 地址，当然它也可以与 BLE 设备进行通信。

- 首先下载 [**nRF Connect APP**](https://play.google.com/store/apps/details?id=no.nordicsemi.android.mcp&hl=en)，并安装到你的手机；
- 然后扫描 BLE 设备；
- 找出 BLE 设备并连接它，然后就会看到 UUID 和 MAC 地址；
- 接着可以发送或接收特性（Characteristic）上的数据。

左边的截图展示了 nRF Connect App 扫描的 BLE 设备。右边的截图展示 BLE 设备连接成功后看到的 UUID 和 MAC 地址，在特性（Characteristic）的条目上有一些箭头，向上箭头表示将数据发送到服务器，向下箭头表示从服务器接收数据。

![](https://static.getiot.tech/wio-terminal-nRF-device.png#center)

接口选项是根据设备的功能来选择的，比如我连接了一个功能简单的 Wio Terminal（服务器），所以只有一个 Service UUID。不同的 BLE 设备功能特性也不同，这取决于设备的复杂程度。



## 示例

- [Wio Terminal 蓝牙 BLE 客户端示例](/wiot/wio-terminal-bluetooth-ble-client/)
- [Wio Terminal 蓝牙 BLE 服务器示例](/wiot/wio-terminal-bluetooth-ble-server/)
- [手机客户端连接 Wio Terminal 示例](/wiot/wio-terminal-bluetooth-ble-demo/)

