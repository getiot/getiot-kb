---
sidebar_position: 17
slug: /kubeedge
---

# KubeEdge

![](https://static.getiot.tech/kubeedge-horizontal-color.png#center-200)

KubeEdge 是基于 kubernetes 之上将容器化应用的编排能力拓展到边缘主机或边缘设备，在云端和边缘端提供网络通信，应用部署、元数据同步等功能。同时支持 MQTT 协议，允许开发者在边缘端自定义接入边缘设备。

KubeEdge 即 Kube+Edge，顾名思义就是依托 K8s 的容器编排能力和调度能力，实现云边协同、计算下沉、海量设备的平滑接入。

**功能特性**

- 边缘计算：提供边缘节点自治能力，边缘节点数据处理能力。
- 便捷部署：开发者可以开发 http 或 mqtt 协议的应用，运行在云端和边缘端。
- k8s 原生支持：可以通过 k8s 管理和监控边缘设备和边缘节点。
- 丰富的应用类型：可以在边缘端部署机器学习、图片识别、事件处理等应用。

**项目链接**

- 项目官网：[https://kubeedge.io](https://kubeedge.io)
- GitHub：[https://github.com/kubeedge](https://github.com/kubeedge)



## 组件

### 云端

- [CloudHub](https://github.com/kubeedge/kubeedge/blob/master/docs/modules/cloud/cloudhub.md)：一个 web socket 服务器，负责监听云端的更新、缓存及向 EdgeHub 发送消息。
- [EdgeController](https://github.com/kubeedge/kubeedge/blob/master/docs/modules/cloud/controller.md)：一个扩展的 k8s 控制器，负责管理边缘节点和 pod 元数据，同步边缘节点的数据，是 k8s-apiserver 与 EdgeCore 的通信桥梁。
- [DeviceController](https://github.com/kubeedge/kubeedge/blob/master/docs/modules/cloud/device_controller.md)：一个扩展的 k8s 控制器，负责管理节点设备，同步云端和边缘端的设备元数据和状态。

### 边缘端

- [EdgeHub](https://github.com/kubeedge/kubeedge/blob/master/docs/modules/edge/edgehub.md)：一个 web socket 客户端，负责云端与边缘端的信息交互，其中包括将云端的资源变更同步到边缘端及边缘端的状态变化同步到云端。
- [Edged](https://github.com/kubeedge/kubeedge/blob/master/docs/modules/edge/edged.md)：运行在边缘节点，管理容器化应用的 agent，负责 pod 生命周期的管理，类似 kubelet。
- [EventBus](https://github.com/kubeedge/kubeedge/blob/master/docs/modules/edge/eventbus.md)：一个 MQTT 客户端，与 MQTT 服务端交互，提供发布/订阅的能力。
- ServiceBus：一个 HTTP 客户端，与 HTTP 服务端交互。为云组件提供 HTTP 客户端功能，以访问在边缘运行的 HTTP 服务器。
- [DeviceTwin](https://github.com/kubeedge/kubeedge/blob/master/docs/modules/edge/devicetwin.md)：负责存储设备状态并同步设备状态到云端，同时提供应用的接口查询。
- [MetaManager](https://github.com/kubeedge/kubeedge/blob/master/docs/modules/edge/metamanager.md)： Edged 和 EdgeHub 之间的消息处理器，负责向轻量数据库（SQLite）存储或查询元数据。



## 架构

KubeEdge 的架构主要是分了云、边、端三部分，云上边就是控制面，边就是边缘节点，端就是一些端侧设备。

![](https://static.getiot.tech/kubeedge_arch.png#center)

云上左边是一个 K8s 的 master，是没有做过改动的原生的 K8s 控制面，CloudCore 组件主要是会拿一些 K8s 控制面上的东西，通过 EdgeController 和 DeviceController 做一些处理，然后通过下边的 Cloud Hub 与边端通信，边端有个 EdgeHub 和 Cloud Hub 通信，然后把数据拿下来。

边端是主要做了一个应用管理和设备管理的能力，应用管理左边会有一个 Edged，右边有 DeviceTwin、EventBus，分别是应用管理和设备管理。另外，左边有个 DataStore，用于提供本地自治的能力。比如说某个应用或者设备的元素从云上分发下来，我们是先把它存到一个数据库里，然后再到它的 Edged 或者设备里边，这样就能保证云边网络断开或者边缘节点重启了以后，应用的 Edged 可以从数据库里把应用源数据拿出来，这样就能保证在故障的情况下业务可以正常恢复。





## 参考

- [KubeEdge架构解读：云原生的边缘计算平台-云社区-华为云 (huaweicloud.com)](https://bbs.huaweicloud.com/blogs/241350)
- [KubeEdge介绍 · Kubernetes 学习笔记 (huweihuang.com)](https://www.huweihuang.com/kubernetes-notes/kubeedge/kubeedge-arch.html)

