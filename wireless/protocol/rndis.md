---
sidebar_position: 16
---

# RNDIS 协议



RNDIS 是指 Remote NDIS，基于 USB 实现 RNDIS 实际上就是 TCP/IP over USB，就是在 USB 设备上跑 TCP/IP，让 USB 设备看上去像一块网卡。



## RNDIS（远程 NDIS）简介

远程 NDIS（RNDIS）是一种与总线无关的类规范，适用于动态即插即用上的以太网 PnP 总线（例如 USB、1394、蓝牙和自动限制）的以太网 802.3。 远程 NDIS 通过抽象控件和数据通道定义主机计算机和远程 NDIS 设备之间与总线无关的消息协议。 远程 NDIS 的精确度足以允许主机计算机上的远程 NDIS 设备具有与供应商无关的类驱动程序支持。

Windows XP 中的 Microsoft Windows 版本包括用于 USB 设备的远程 NDIS 驱动程序。 此 NDIS 微型端口驱动程序 Rndismp.sys 由 Microsoft 实现和维护，并作为所有受支持的 Windows 版本的一部分进行分发。 可以在 `%SystemRoot%\System32\drivers` 目录中找到该文件。

若要将此驱动程序与 USB 设备一起使用，IHV 必须提供遵循 [远程 NDIS INF 模板](https://docs.microsoft.com/zh-cn/windows-hardware/drivers/network/remote-ndis-inf-template)中的模板的 INF 文件。

远程 NDIS 消息从主机发送到远程 NDIS 设备，远程 NDIS 设备使用适当的完成消息进行响应。 消息也将以未经请求的方式从远程 NDIS 设备发送到主机。





