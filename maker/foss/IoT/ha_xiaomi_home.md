# Home Assistant 米家集成

2024年12月，小米在 GitHub 开源了「Home Assistant 米家集成」，允许用户在 Home Assistant 中使用小米 IoT 智能设备！



## 项目简介

「米家集成」是一个由小米官方提供支持的 Home Assistant 的集成组件，它可以让你在 Home Assistant 中使用小米 IoT 智能设备。

目前，米家集成支持大部分米家设备品类，但仍有一小部分设备品类（蓝牙、红外及虚拟设备）并不支持。不过，相信以小米的作风，米家集成将会逐渐覆盖更多米家平台产品，无论是官方出品还是第三方制造。

米家集成允许用户同时登录多个小米账号，且不受地区限制。这意味着，你可以在同一 Home Assistant 系统中操作或设置来自不同账号、不同地区的米家设备。根据官方信息，米家集成的接口已在中国大陆、欧洲、印度、俄罗斯、新加坡和美国六个地区的机房部署，全球范围内均可使用。

:::tip
Home Assistant 是一个基于 Python 3 开发的用于家庭自动化的免费开源软件。它作为集成平台和智能家居中心，允许用户控制智能家居设备。该软件强调本地控制和隐私，设计独立于任何特定的物联网生态系统。
:::



## 控制方式

米家集成支持两种消息收发方式，一种是云端控制，另一种是本地控制。米家集成支持通过[小米中枢网关](https://www.mi.com/shop/buy/detail?product_id=15755)或内置中枢网关的米家设备实现本地化控制。如果没有小米中枢网关或其他带中枢网关功能的设备，那么所有控制指令都会通过小米云发送。

### 云端控制

![云端控制架构](https://static.getiot.tech/ha_xiaomi_home_cloud_control_zh.jpg#center-600)

米家集成向小米云 MQTT Broker 订阅关注的设备消息。当设备属性发生改变或产生设备事件时，设备向小米云发送上行消息， MQTT Broker 向米家集成推送订阅的设备消息。由于米家集成不需要向云端轮询以获取设备当前的属性值，因此米家集成能第一时间获知设备属性变化或事件发生。得益于消息订阅机制，米家集成只在配置完成时向云端查询一次所有的设备属性，对云端产生的访问压力很小。

米家集成需要控制设备时，通过小米云 HTTP 接口向设备发送控制消息。设备收到小米云发来的下行消息后做出响应。

### 本地控制

![本地控制架构](https://static.getiot.tech/ha_xiaomi_home_local_control_zh.jpg#center-600)

小米中枢网关内包含一个标准的 MQTT Broker ，实现了完整的订阅发布机制。米家集成向小米中枢网关订阅关注的设备消息。当设备属性发生改变或产生设备事件时，设备向小米中枢网关发送上行消息， MQTT Broker 向米家集成推送订阅的设备消息。

米家集成需要控制设备时，向 MQTT Broker 发布设备控制消息，再经由小米中枢网关转发给设备。设备收到小米中枢网关发来的下行消息后做出响应。



## 安装方式

小米官方提供了三种集成的安装方法，分别是 Git 安装、HACS、通过 [Samba](https://github.com/home-assistant/addons/tree/master/samba) 或 [FTPS](https://github.com/hassio-addons/addon-ftp) 手动安装。推荐使用第一种方法安装米家集成，这样当你想要更新至特定版本时，只需要切换至相应的 Tag，管理起来更方便。

使用 `git clone` 命令从 GitHub 下载并安装，命令如下：

```bash showLineNumbers
cd config
git clone https://github.com/XiaoMi/ha_xiaomi_home.git
cd ha_xiaomi_home
./install.sh /config
```

不过，无论使用哪一种方式安装，都需要先符合以下条件：

- Home Assistant Core 的版本 ≥ 2024.11.0；
- Home Assistant 操作系统的版本 ≥ 13.0。

安装完成后就可以配置了，使用小米账号登录，登录成功后，会弹出会话框“选择家庭与设备”，选择需要添加的米家家庭，将家庭内的所有设备将导入 Home Assistant 即可。



## 安全性

米家集成及其使用的云端接口由小米官方提供，使用时，你需要使用小米账号登录以获取设备列表。米家集成使用 OAuth 2.0 的登录方式，不会在 Home Assistant 中保存你的小米账号密码。但由于 Home Assistant 平台的限制，登录成功后，你的小米用户信息（包括设备信息、证书、 token 等）会明文保存在 Home Assistant 的配置文件中。因此，你需要保管好自己 Home Assistant 配置文件。一旦该文件泄露，其他人可能会冒用你的身份登录。



## 相关链接

- [Home Assistant 米家集成 GitHub 仓库](https://github.com/XiaoMi/ha_xiaomi_home)
- [【硬件】小米中枢网关](https://www.mi.com/shop/buy/detail?product_id=15755)
- [Home Assistant 项目官网](https://www.home-assistant.io)

