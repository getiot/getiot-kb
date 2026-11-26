---
sidebar_position: 6
authors: [luhuadong]
---

# MQTT 客户端工具



一个好用的 MQTT 客户端工具可以极大地帮助开发者学习和调试 MQTT 协议与功能特性。发展至今，已经有许多来自世界各地的开发者制作出针对不同操作系统、运行平台的 MQTT 客户端测试工具。本文将从中选择一些优秀的工具进行介绍。

MQTT 客户端工具常用于建立与 MQTT 服务器的连接，进行主题订阅、消息收发等操作。一个 MQTT 客户端工具的功能特点可以从以下方面评估：

- 每个使用环节中工具需要尽可能提供全面的参数配置能力、使用到 MQTT 的全部特性，以便用户应对任何使用场景、使用方式的模拟测试。这部分特性包括支持客户端认证，支持配置证书及多种加密方式连接，支持 MQTT 连接、发布、订阅过程中多项参数的配置，支持 MQTT 5 等；
- 在功能全面的基础上提升用户的交互便捷性，且界面操作流畅；
- 提供其他拓展功能，如同时支持多个客户端连接、MQTT 协议调试；
- 跨平台，不同操作系统下都可以使用；
- 是否支持中/英文等多国语言；
- 是否支持 MQTT Payload 格式转换。

本文将结合每个客户端工具的特点，从以上几点进行测评介绍。



## 1. MQTT X

[MQTT X](https://mqttx.app/zh) 是由杭州映云科技有限公司（也就是 EMQ）开源的一款跨平台 MQTT 5.0 桌面客户端工具，它支持 macOS、Linux 和 Windows，是目前为止市面上最漂亮的 MQTT 客户端工具。

MQTT X 采用了 Electron 跨平台技术，以消息聊天的交互形式收发消息，允许同时建立多个客户端连接并自由切换互相通信，有较好的交互性，大大提高了 MQTT 开发测试的效率。

MQTT X 功能较全面，用户可以快速测试 MQTT/TCP、MQTT/TLS、MQTT/WebSocket 的连接/发布/订阅功能及其他 MQTT 协议特性。

**功能特性**

- 支持 MQTT v3.1.1 以及 MQTT v5.0 协议
- 单/双向 SSL 认证：支持 CA、自签名证书，以及单、双向 SSL 认证
- 支持 Light、Dark、Night 三种主题切换
- 支持 WebSocket 连接至 MQTT 服务器
- 支持 Hex, Base64, JSON, Plaintext
- 支持简体中文以及英文
- 订阅 Topic 支持自定义颜色标记
- 点击已订阅 topic 可进行消息过滤
- 存储 MQTT 服务器信息并可进行下拉选择

![](https://static.getiot.tech/mqtt-client-mqttx.png#center)

**下载链接**

- 项目官网：[MQTT X 官网](https://mqttx.app/zh)
- 下载地址：[MQTT X GitHub](https://github.com/emqx/MQTTX/releases)



## 2. Mosquitto CLI

Mosquitto 是一个开源（EPL/EDL 许可证）的消息代理，Mosquitto 安装之后默认提供了 [mosquitto_pub](https://mosquitto.org/man/mosquitto_pub-1.html) 和 [mosquitto_sub](https://mosquitto.org/man/mosquitto_sub-1.html) 两个命令行 MQTT 客户端工具。

Mosquitto CLI 有多个配置选项，支持 TLS 证书连接、通过代理服务器连接，支持 debug 模式，在 debug 模式下可以获取更详细的消息信息。

它的使用也非常简便，默认使用环境只需提供少许参数即可使用：

```shell
## 开启 DEBUG 模式订阅 testtopic/# 主题
$ mosquitto_sub -t "testtopic/#" -d
Client mosqsub/66418-wivwiv-ma sending CONNECT
Client mosqsub/66418-wivwiv-ma received CONNACK
Client mosqsub/66418-wivwiv-ma sending SUBSCRIBE (Mid: 1, Topic: testtopic/#, QoS: 0)
Client mosqsub/66418-wivwiv-ma received SUBACK
Subscribed (mid: 1): 0
Client mosqsub/66418-wivwiv-ma received PUBLISH (d0, q0, r0, m0, 'testtopic/1', ... (5 bytes))
Hello

## 发布一条消息到 testtopic/1 主题
mosquitto_pub -t "testtopic/1" -m "Hello, GetIoT.tech"
```

**功能特性**

- 轻量级命令行工具，支持 debug 模式，便于安装
- 支持加密及非加密连接至 MQTT 服务器
- 便于在远程服务器测试

**下载链接**

- 项目地址：[Github Mosquitto](https://github.com/eclipse/mosquitto)
- 下载地址：[Mosquitto 官网](https://mosquitto.org/)



## 3. MQTT.fx

MQTT.fx 是 [Jens Deters](https://www.jensd.de/) 个人开发的、目前主流的 MQTT 客户端，可以快速验证是否可以与 IoT Hub 服务交互发布或订阅消息，MQTT.fx 适用 Apache License 2.0 协议但并未提供源码。

MQTT.fx 是一个老牌的 MQTT 客户端工具，Azure IoT Hub、AWS IoT、阿里云 IoT 等云服务提供商相关产品文档教程均以 MQTT.fx 为例。MQTT.fx 使用 JavaFX 技术开发，由于 Java 虚拟机的关系可能在某些老旧机器上会有卡顿的体验。

基础功能上 MQTT .fx 可以保存多个连接配置，支持多种类型 TCL 加密方式，指定多种类型的证书。创建连接时可以指定使用 HTTP 代理服务器，连接成功后整个发布、订阅功能使用相对来说比较合理流畅，`Topics Collector` 功能可以发现通过其他方式如 Broker 端代理订阅订阅的主题是一个功能亮点。MQTT.fx 还支持 Google Cloud Iot 的连接测试。

高级功能中 MQTT.fx 有最大的亮点支持执行 JavaScript 功能脚本，借助 Nashorn Engine 用户编写的 JavaScript 代码可以访问 Java 方法与字段实现功能扩展，熟悉 MQTT.fx 相关 API 后用户可以编写出适应业务的测试脚本，模拟传感器上报数据，甚至是性能测试工具等更多强大的功能。

如果您使用的是 Mosquitto，MQTT.fx 提供专门的一个选项卡，通过订阅系统主题（用于发布 Broker 运行信息的主题）实现 Broker 状态可视化查看，可即时获取到 Broker 的版本、时间等系统信息和客户端数量、消息数量网络流量和负载状况等运行信息。

总的来说 MQTT.fx 有丰富且成熟的功能，支持了 TCP 连接中所有可能遇到的配置项，除了交互性略差，界面卡顿，用户同一时间只能建立一个连接，不能满足同时使用多个测试连接的需求。另外它没有实现对 WebSocket 的支持，在 MQTT over WebSockets 的测试场景中无法使用。

**功能特性**

- 预定义消息模板
- 通过系统主题 `$SYS` 获取 Broker 状态
- 记忆最近使用主题的
- 通过 Nashorn Engine ，支持 JavaScript 脚本
- 支持日志显示，显示连接中的日志信息
- 跨平台桌面，支持 Windows、MacOS 和 Linux

![](https://static.getiot.tech/mqtt-client-mqttfx.png#center)

**下载链接**

- 下载地址：[https://mqttfx.jensd.de/index.php/download](https://mqttfx.jensd.de/index.php/download)



## 4. MQTT Explorer

MQTT Explorer 是一个全面且易于使用的 MQTT 客户端，是目前比较流行的 MQTT 桌面测试客户端之一，基于它提供有关 MQTT Topics 的结构化预览展示，并使其在对 MQTT Broker 上的设备/服务的使用变得非常简单。目前基于 CC BY-NC-ND 4.0 协议开源，用户可随意查看源码和使用。

对 Topics 进行可视化展示和垂直分层的展示并动态预览是 MQTT-Explorer 的一大亮点，分层视图使此工具易于使用，并将 MQTT Explorer 与其他出色的 MQTT 桌面客户端区分开来；自定义订阅可以限制 MQTT Explorer 需要处理的消息量，可以在高级连接设置中管理订阅；用户还可以对接收到的 payload 消息进行差异对比的视图展示。缺点是只能创建一个单一的客户端连接，不能多客户端同时连接在线。

**功能特性**

- 可视化 Topics 和 Topic 变化的动态预览
- 删除保留的 Topics
- 搜索/过滤 Topics
- 递归删除 Topics
- 当前和以前收到的消息的差异视图
- 发布 Toipcs
- 绘制数字 Topics
- 保留每个 Topic 的历史记录
- Dark/Light 主题

![](https://static.getiot.tech/mqtt-client-mqtt-explorer.png#center)

**下载链接**

- 项目地址：[Github MQTT-Explorer](https://github.com/thomasnordquist/MQTT-Explorer)
- 下载地址：[https://mqtt-explorer.com](https://mqtt-explorer.com)



## 5. MQTT Box

MQTT Box 是 Sathya Vikram 个人开发的 MQTT 客户端工具，最初仅在 [Chrome](https://chrome.google.com/webstore/detail/mqtt-client-tcp-and-ws/kaajoficamnjijhkeomgfljpicifbkaf?utm_source=chrome-ntp-launcher) 上使用，作为浏览器拓展安装使用， 后经重写开源成为桌面端跨平台独立软件。

MQTT Box 同样采用了 Electron 跨平台技术，界面简单直接，支持多个客户端同时在线，但客户端之间的切换、互发消息等交互还是有一定不便。MQTT Box 借助 Chrome 有很强大的跨平台特性，结合简单的负载测试功能，是一款值得尝试的 MQTT 客户端工具。

**功能特性**

- 通过支持 Chrome OS，Linux，macOS，Windows 的 Chrome 存储易于安装，支持 Linux、macOS、Windows 独立安装
- 支持 MQTT、MQTT over WebSocket，多种 TCP 加密方式的连接
- 保存发送的历史记录
- 复制/粘贴历史记录中的消息
- 保存订阅消息历史记录
- 简单的性能测试，对 Broker 的负载做出测试并通过图表可视化查看测试结果

![](https://static.getiot.tech/mqtt-client-mqtt-box.png#center)

**下载链接**

- 项目地址：[GitHub MQTTBox](https://github.com/workswithweb/MQTTBox)
- 下载地址：[https://workswithweb.com/mqttbox.html](https://workswithweb.com/mqttbox.html)



## 6. mqtt-spy

mqtt-spy 是 Eclipse Paho 和 Eclipse IoT 的一部分，它通过直接启动 JAR 文件在 Java 8 和 JavaFX 之上运行，mqtt-spy 有一种很好的交互方式来展现基本的 MQTT发布/订阅机制。

mqtt-spy 没有提供独立的安装包，使用前需要用户自行安装 Java 运行环境。但是启动后 mqtt-spy 拥有友好的上手体验，启动引导功能让人眼前一亮，MQTT 新手可以轻松的使用 mqtt-spy 连接到公共 MQTT Broker 进行探索。mqtt-spy 的功能界面略显复杂，但熟悉每个部件的功能后它将成为开发调试利器。还有有一点不得不提的是 mqtt-spy 的性能和稳定性有所欠缺，也有可能是笔者使用的版本为最新 Beta 版，连接多个 Broker 后频频出现卡顿和假死。

**功能特性**

- 支持 MQTT 和 MQTT over WebSocket
- 交互方便，可以同时发布和订阅，在不同选项卡连接多个 Broker
- 可以关闭 pub/sub窗口的不同区域（发布，新订阅，订阅和消息），以便为当前使用的空间腾出空间
- 搜索功能允许查找常用 MQTT 消息，支持将发布/订阅消息输出到标准输出或记录到文件中以供后续分析

![](https://static.getiot.tech/mqtt-client-mqtt-spy.png#center)

![](https://static.getiot.tech/mqtt-client-mqtt-spy-2.png#center)

**下载链接**

- 项目地址：[GitHub mqtt-spy](https://github.com/eclipse/paho.mqtt-spy)
- 下载地址：[https://github.com/eclipse/paho.mqtt-spy/releases](https://github.com/eclipse/paho.mqtt-spy/releases)



## 7. MQTT Lens

MQTT Lens 是有一个 Chrome 拓展工具，可以通过 Chrome 网上应用商店安装。MQTT Lens 界面非常简洁，提供基础的发布订阅功能。

MQTT Lens 足够简单，但是提供了基础的 MQTT 和 MQTT over WebSocket 连接功能，可以快速满足入门探索使用。

**功能特性**

- 同时接受与多个 MQTT 服务器的连接，采用不同颜色关联
- 订阅，发布和查看所有收到的消息的界面非常简单且易于掌握
- 支持 MQTT 和 MQTT over WebSocket

![](https://static.getiot.tech/mqtt-client-mqtt-lens.jpg#center)

**下载链接**

- 下载地址：[Chrome Web Store](https://chrome.google.com/webstore/detail/mqttlens/hemojaaeigabkbcookmlgmdigohjobjm)



## 8. MQTT WebSocket Toolkit

[MQTT WebSocket Toolkit](https://www.emqx.com/zh/mqtt/mqtt-websocket-toolkit) 是一款简单易用的在线 MQTT 客户端测试工具，它基于浏览器端使用，只支持 MQTT over WebSocket 连接，提供了基础的 MQTT 配置连接设置。

MQTT WebSocket Toolkit 的界面和交互沿用了 [MQTT X](https://mqttx.app/zh) 的设计和使用风格，以消息聊天的交互形式收发消息，允许同时建立多个客户端连接并自由切换互相通信，提高了 MQTT 开发测试的效率；当需要测试 MQTT WebSocket 连接时，不需下载安装多余的工具，快捷可用。

**功能特性**

- 线上快速访问，免安装，界面简洁易用
- 支持 WebSocket 连接至 MQTT 服务器
- 支持创建多个客户端，并能保存客户端信息至下次访问

![](https://static.getiot.tech/mqtt-client-mqtt-websocket-toolkit.png#center)

**下载链接**

- 在线地址：[MQTT WebSocket Toolkit](http://tools.emqx.io/)
- 项目地址：[MQTT WebSocket Toolkit GitHub](https://github.com/emqx/MQTT-Web-Toolkit)



## 9. MqttDesk

需要付费使用，提供 15 天免费试用。



