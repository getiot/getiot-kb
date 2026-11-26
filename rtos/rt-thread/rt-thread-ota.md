---
sidebar_position: 8
authors: [luhuadong]
---

# RT-Thread OTA 固件升级



本文主要介绍在 RT-Thread 系统上进行固件升级的工具和方法。固件升级，通常也称为 OTA（Over the Air）升级或者 FOTA（Firmware Over-The-Air）升级，即固件通过空中下载进行升级的技术。



## 网络协议

**Ymodem 协议**

Ymodem 是一种文本传输协议，在 OTA 应用中为空中下载技术提供文件传输的支持。基于 Ymodem 协议的固件升级即为 OTA 固件升级的一个具体应用实例。

**HTTP 协议**

HTTP 是一种超文本传输协议，采用请求应答的通讯模式，可以基于通用 socket 实现极简客户端程序，广泛应用在互联网上。HTTP 请求应答的方式，及其很小的客户端代码量，也使其很方便地应用在物联网设备中，用于与服务器进行数据交互，以及 OTA 固件下载。



## Flash 分区

通常嵌入式系统程序是没有文件系统的，而是将 Flash 分成不同的功能区块，从而形成不同的功能分区。

要具备 OTA 固件升级能力，通常需要至少有两个程序运行在设备上。其中负责固件校验升级的程序称之为 bootloader，另一个负责业务逻辑的程序称之为 app。它们负责不同的功能，存储在 Flash 的不同地址范围，从而形成了 bootloader 分区 和 app 分区 。

但多数情况下嵌入式系统程序是运行在 Flash 中的，下载升级固件的时候不会直接向 app 分区写入新的固件，而是先下载到另外的一个分区暂存，这个分区就是 download 分区 ，也有称之为 app2 分区 ，这取决于 bootloader 的升级模式。

bootloader 分区、app 分区、download 分区及其他分区一起构成了分区表。分区表标识了该分区的特有属性，通常包含分区名、分区大小、分区的起止地址等。



## bootloader 升级模式

bootloader 的升级模式常见有以下两种：

**1、bootloader 分区 + app1 分区 + app2 分区模式**

该模式下，bootloader 启动后，检查 app1 和 app2 分区，哪个固件版本最新就运行哪个分区的固件。当有新版本的升级固件时，固件下载程序会将新的固件下载到另外的一个没有运行的 app 分区，下次启动的时候重新选择执行新版本的固件。

- 优点：无需固件搬运，启动速度快。
- 缺点：app1 分区和 app2 分区通常要大小相等，占用 Flash 资源；且 app1 和 app2 分区都只能存放 app 固件，不能存放其他固件（如 WiFi 固件）。

**2、bootloader 分区 + app 分区 + download 分区模式**

该模式下，bootloader 启动后，检查 download 分区是否有新版本的固件，如果 download 分区内有新版本固件，则将新版本固件从 download 分区搬运到 app 分区，完成后执行 app 分区内的固件；如果 download 分区内没有新版本的固件，则直接执行 app 分区内的固件。

当有新版本的升级固件时，固件下载程序会将新的固件下载到 download 分区内，重启后进行升级。

- 优点：download 分区可以比 app 分区小很多（使用压缩固件），节省 Flash 资源，节省下载流量；download 分区也可以下载其他固件，从而升级其他的固件，如 WiFi 固件、RomFs。
- 缺点：需要搬运固件，首次升级启动速度略慢。

RT-Thread OTA 使用的是 bootloader 升级模式 2，即 bootloader 分区 + app 分区 + download 分区的组合。



## 固件下载器

在嵌入式设备程序中实现的，具有从远端下载升级固件功能的代码块称之为**固件下载器**（OTA Downloader）。固件下载器的工作是把新版本的升级固件下载设备的 Flash 中，不同的协议以及不同的 OTA 固件托管平台会有不同的固件下载器，即不同的代码实现。

目前 RT-Thread 已经支持了多种固件下载器，如下所示：

- 基于 Ymodem 协议的 Ymodem OTA 固件下载器（可通过串口等方式升级固件）
- 基于 HTTP 协议的 HTTP OTA 固件下载器（可通过网络方式升级固件）
- 基于特定云平台的 OTA 固件下载器
  - RT-Cloud OTA 固件下载器（适配 RT-Cloud OTA 功能）
  - ali-iotkit 固件下载器（适配阿里云 LinkDevelop 平台和 LinkPlatform 平台的 OTA 功能）
  - Ayla 云 OTA 固件下载器（适配 Ayla 云平台的 OTA 功能）
  - 其他第三方 OTA 托管平台（其他平台请联系 RT-Thread 团队）



## RT-Thread OTA

RT-Thread OTA 是 RT-Thread 开发的跨 OS、跨芯片平台的固件升级技术，轻松实现对设备端固件的管理、升级与维护。
RT-Thread 提供的 OTA 固件升级技术具有以下优势：

- **固件防篡改**：自动检测固件签名，保证固件安全可靠；
- **固件加密**：支持 AES-256 加密算法，提高固件下载、存储安全性；
- **固件压缩**：高效压缩算法，降低固件大小，减少 Flash 空间占用，节省传输流量，降低下载时间；
- **差分升级**：根据版本差异生成差分包，进一步节省 Flash 空间，节省传输流量，加快升级速度；
- **断电保护**：断电后保护，重启后继续升级；
- **智能还原**：固件损坏时，自动还原至出厂固件，提升可靠性；
- **高度可移植**：可跨 OS、跨芯片平台、跨 Flash 型号使用；
- **多可用的固件下载器**：支持多种协议的 OTA 固件托管平台和物联网云平台。

RT-Thread OTA 框架图如下所示：

![RT-Thread OTA 框架图](https://static.getiot.tech/rt-thread-ota-framework.png#center)

从上面的 OTA 框架图可以发现，Ymodem 在 OTA 流程中充当的是 OTA Downloader（固件下载器）的角色，核心的 OTA 业务逻辑在 RT OTA 中，也就是封装到了 bootloader 固件里。OTA 业务逻辑与应用程序解耦，极大简化了 OTA 功能增加的难度。



## OTA 升级流程

在嵌入式系统方案里，要完成一次 OTA 固件远端升级，通常需要以下阶段：

1. 准备升级固件（RT-Thread OTA 使用特定的 rbl 格式固件），并上传 OTA 固件到固件托管服务器；
2. 设备端使用固件托管服务器对应的固件下载器下载 OTA 升级固件；
3. 新版本固件下载完成后，在适当的时候重启进入 bootloader；
4. bootloader 对 OTA 固件进行校验、解密和搬运（搬运到 app 分区）；
5. 升级成功，执行新版本 app 固件。

OTA 升级流程如下图所示：

![RT-Thread OTA 升级流程](https://static.getiot.tech/rt-thread-ota-process.png#center)



## 软件包

- [ota_downloader](http://packages.rt-thread.org/detail.html?package=ota_downloader)
- [abup_fota](http://packages.rt-thread.org/detail.html?package=abup_fota)



## 示例

- [潘多拉 RT-Thread Ymodem 协议固件升级](/pandora/rtt-pandora-ota-using-ymodem/)
- [潘多拉 RT-Thread HTTP 协议固件升级](/pandora/rtt-pandora-ota-using-http/)



