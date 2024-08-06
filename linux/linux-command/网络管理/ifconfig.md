---
sidebar_position: 2
slug: /ifconfig
---

# ifconfig 命令



## 介绍

**ifconfig**（英文全拼：network interfaces configuring）命令用于配置和显示 Linux 内核中网络接口的网络参数。

ifconfig 命令由 net-tools 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install net-tools
```

注意，通过 ifconfig 命令配置的网卡信息是临时的，在网卡重启或机器重启后，配置就不存在。

**语法**：

```bash
ifconfig [-v] [-a] [-s] [interface]
ifconfig [-v] interface [aftype] options | address ...
```

**选项参数**：

- `add <地址>` ：设置网络设备 IPv6 的 ip 地址；
- `del <地址>` ：删除网络设备 IPv6 的 IP 地址；
- `down` ：关闭指定的网络设备；
- `hw <网络设备类型> <硬件地址>` ：设置网络设备的类型与硬件地址；
- `io_addr <I/O地址>` ：设置网络设备的 I/O 地址；
- `irq <IRQ地址>` ：设置网络设备的 IRQ；
- `media <网络媒介类型>` ：设置网络设备的媒介类型；
- `mem_start <内存地址>` ：设置网络设备在主内存所占用的起始地址；
- `metric <数目>` ：指定在计算数据包的转送次数时，所要加上的数目；
- `mtu <字节>` ：设置网络设备的 MTU；
- `netmask <子网掩码>` ：设置网络设备的子网掩码；
- `tunnel <地址>` ：建立 IPv4 与 IPv6 之间的隧道通信地址；
- `up` ：启动指定的网络设备；
- `-broadcast <地址>` ：将要送往指定地址的数据包当成广播数据包来处理；
- `-pointopoint <地址>` ：与指定地址的网络设备建立直接连线，此模式具有保密功能；
- `-promisc` ：关闭或启动指定网络设备的 promiscuous 模式；
- `address`：指定网络设备的 IP 地址；
- `interface` ：指定网络设备的名称。



## 示例

显示网络设备信息

```bash
ifconfig
```

启动关闭指定网卡

```bash
ifconfig eth0 down
ifconfig eth0 up 
```

为网卡配置和删除 IPv6 地址

```bash
ifconfig eth0 add 33ffe:3240:800:1005::2/64
ifconfig eth0 del 33ffe:3240:800:1005::2/64
```

修改网卡 MAC 地址（修改前须先关闭网卡）

```bash
ifconfig eth0 hw ether 00:AA:BB:CC:DD:EE
```

配置 IP 地址

```bash
ifconfig eth0 192.168.1.56
```

配置 IP 地址和子网掩码

```bash
ifconfig eth0 192.168.1.56 netmask 255.255.255.0
```

配置 IP 地址和子网掩码以及广播地址

```bash
ifconfig eth0 192.168.1.56 netmask 255.255.255.0 broadcast 192.168.1.255
```

