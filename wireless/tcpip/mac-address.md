---
sidebar_position: 3
---

# MAC 地址



MAC 地址（英语：Media Access Control Address），直译为媒体访问控制地址，也称为局域网地址（LAN Address），以太网地址（Ethernet Address）或物理地址（Physical Address），它是一个用来确认网络设备位置的地址。在 OSI 模型中，第三层网络层负责 IP 地址，第二层数据链接层则负责 MAC 地址。MAC 地址用于在网络中唯一标示一个网卡，一台设备若有一或多个网卡，则每个网卡都需要并会有一个唯一的 MAC 地址。



## 地址格式

MAC 地址共 48 位（6个字节），以十六进制表示。第 1 位为广播地址（0）/ 群播地址（1），第 2 为广域地址（0）/ 区域地址（1）。前 3~24 位由 IEEE 决定如何分配给每一家制造商，且不重复，后 24 位由实际生产该网络设备的厂商自行指定且不重复。

![](https://static.getiot.tech/Media-Access-Control-Address-MAC.png#center)

ff:ff:ff:ff:ff:ff 则作为广播地址。

01:xx:xx:xx:xx:xx 是多播地址，01:00:5e:xx:xx:xx 是 IPv4 多播地址。





## 如何获取 MAC 地址

IEEE 中国网站：[https://cn.ieee.org/mac/](https://cn.ieee.org/mac/)





