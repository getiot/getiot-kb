---
sidebar_label: networkctl 命令
sidebar_position: 45
slug: /networkctl
---

# Linux networkctl 命令 - 查询控制网络状态



## 介绍

**networkctl**（英文全拼：network control）用于查询和控制 Linux 网络子系统，比如查看网络设备及其连接状态的摘要。

networkctl 是新版本 systemd 命令集中的命令之一，对应 systemd-networkd 服务。

**语法**：

```bash
networkctl [OPTIONS...] COMMAND [LINK...]
```

**命令**：

- `list [PATTERN...]` ：列出存在的连接及其状态。若未指定连接(LINK)则显示所有连接， 否则仅显示指定的连接。
- `status [PATTERN...]` ：显示连接的各种信息，包括类型、状态、内核模块、MAC 地址、IP 地址、DNS 服务器等等。
- `lldp [PATTERN...]` ：显示已发现的 LLDP（Link Layer Discovery Protocol）邻居。若未指定连接，则显示所有连接上发现的邻居，否则仅显示指定连接上发现的邻居。
- `label` ：显示以数字形式表示的地址标签，可用于地址选择。
- `delete DEVICES...` ：删除虚拟网卡设备。
- `renew DEVICES...` ：更新动态配置。
- `reconfigure DEVICES...` ：重新配置接口。
- `reload` ：重新加载 .network 和 .netdev 文件。

**选项**：

- `--no-pager` ：不将程序的输出内容（通过 pipe）给分页程序。
- `--no-legend` ：不输出列标题，也就是不在输出列表的头部和尾部显示字段的名称。
- `-a`, `--all` ：显示所有连接的状态。
- `-s`, `--stats` ：显示详细的链接统计信息。
- `-l`, `--full` ：不要省略输出。
- `-n`, `--lines=INTEGER` ：要显示的日记数目。
- `-h`, `--help` ：显示帮助信息。
- `--version` ：显示 systemd 软件包的版本信息。



## 示例

列出所有连接及其状态，相当于 `networkctl list` 或 `networkctl -a`

```bash
$ networkctl
IDX LINK TYPE     OPERATIONAL SETUP
  1 lo   loopback carrier     unmanaged
  2 eth0 ether    routable    unmanaged
  3 eth1 ether    no-carrier  unmanaged
  4 ppp0 ppp      routable    unmanaged

4 links listed.
```

显示连接的状态信息

```bash
$ networkctl status
*   State: routable
  Address: 192.168.31.223 on eth0
           10.106.236.134 on ppp0
           fe80::a897:4bff:fe16:c0a6 on eth0
  Gateway: 192.168.30.1 on eth0
```

显示网络接口 eth0 的各种信息

```bash
$ networkctl status eth0
* 2: eth0
             Link File: n/a
          Network File: n/a
                  Type: ether
                 State: routable (unmanaged)
                  Path: platform-30be0000.ethernet
                Driver: fec
            HW Address: aa:97:4b:16:c0:a6
                   MTU: 1500 (min: 68, max: 1500)
  Queue Length (Tx/Rx): 3/3
      Auto negotiation: yes
                 Speed: 100Mbps
                Duplex: full
                  Port: mii
               Address: 192.168.31.223
                        fe80::a897:4bff:fe16:c0a6
               Gateway: 192.168.30.1
```



