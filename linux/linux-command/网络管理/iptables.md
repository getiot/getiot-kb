---
sidebar_label: iptables 命令
sidebar_position: 35
slug: /iptables
---

# iptables 命令 - 配置 Linux 防火墙



## 介绍

**iptables** 是 Linux 系统常用的防火墙软件，是 netfilter 项目的一部分。可以直接配置，也可以通过许多前端和图形界面配置。实际上，iptables 只是一个应用层的网络配置工具，它需要内核的支持才能正常工作。

### 语法

```bash
iptables -t 表名 <-A/I/D/R> 规则链名 [规则号] <-i/o 网卡名> 
         -p 协议名 <-s 源IP/源子网> 
         --sport 源端口 <-d 目标IP/目标子网> 
         --dport 目标端口 
         -j 动作
```

### 工作机制

规则链名包括(也被称为五个钩子函数（hook functions）)：

- **`INPUT` 链** ：处理输入数据包。
- **`OUTPUT` 链** ：处理输出数据包。
- **`FORWARD` 链** ：处理转发数据包。
- **`PREROUTING` 链** ：用于目标地址转换（DNAT）。
- **`POSTOUTING` 链** ：用于源地址转换（SNAT）。

### 防火墙的策略

防火墙策略一般分为两种，一种叫“通”策略，一种叫“堵”策略，通策略，默认门是关着的，必须要定义谁能进。堵策略则是，大门是洞开的，但是你必须有身份认证，否则不能进。所以我们要定义，让进来的进来，让出去的出去，所以通，是要全通，而堵，则是要选择。当我们定义的策略的时候，要分别定义多条功能，其中：定义数据包中允许或者不允许的策略，filter 过滤的功能，而定义地址转换的功能的则是 nat 选项。为了让这些功能交替工作，我们制定出了“表”这个定义，来定义、区分各种不同的工作功能和处理方式。

我们现在用的比较多个功能有 3 个：

1. filter 定义允许或者不允许的，只能做在 3 个链上：`INPUT`、`FORWARD`、`OUTPUT`。
2. nat 定义地址转换的，也只能做在 3 个链上：`PREROUTING`、`OUTPUT`、`POSTROUTING`。
3. mangle 功能用于修改报文原数据，是 5 个链都可以做：`PREROUTING`、`INPUT`、`FORWARD`、`OUTPUT`、`POSTROUTING`。

我们修改报文原数据就是来修改 TTL 的。能够实现将数据包的元数据拆开，在里面做标记/修改内容的。而防火墙标记，其实就是靠 mangle 来实现的。

iptables/netfilter（这款软件）是工作在用户空间的，它可以让规则进行生效的，本身不是一种服务，而且规则是立即生效的。而我们 iptables 现在被做成了一个服务，可以进行启动、停止的。启动，则将规则直接生效，停止，则将规则撤销。

iptables 还支持自己定义链。但是自己定义的链，必须是跟某种特定的链关联起来的。在一个关卡设定，指定当有数据的时候专门去找某个特定的链来处理，当那个链处理完之后，再返回。接着在特定的链中继续检查。

注意：规则的次序非常关键，**谁的规则越严格，应该放的越靠前**，而检查规则的时候，是按照从上往下的方式进行检查的。

表名包括：

- **raw** ：高级功能，如：网址过滤。
- **mangle** ：数据包修改（QOS），用于实现服务质量。
- **nat** ：地址转换，用于网关路由器。
- **filter** ：包过滤，用于防火墙规则。

动作包括：

- **ACCEPT** ：接收数据包。
- **DROP** ：丢弃数据包。
- **REDIRECT** ：重定向、映射、透明代理。
- **SNAT** ：源地址转换。
- **DNAT** ：目标地址转换。
- **MASQUERADE** ：IP伪装（NAT），用于ADSL。
- **LOG** ：日志记录。
- **SEMARK** : 添加SEMARK标记以供网域内强制访问控制（MAC）



## 示例

**1、使用命令 iptables -L 测试**

```bash
$ sudo iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
```

**2、对 NAT 表做转发设定**

实际上，网关使用 iptables 的一个很重要的目的就是为了实现私网穿透，因此，需要设置 DNAT 和 SNAT 规则。DNAT（Destination Network Address Translation，目的地址转换）通常被叫做目的映射，而 SNAT（Source Network Address Translation，源地址转换）通常被称为源映射。

```bash
$ sudo iptables -t nat -A POSTROUTING -s 192.168.3.1 -o eth0 -j SNAT --to-source 6.24.34.22
$ sudo iptables -t nat -A PREROUTING -i eth0 -d 6.24.34.22 -p udp --dport 8507 -j DNAT --to-destination 192.168.3.1:10012
```

设置 NAT 转发规则后，可以通过如下命令查看规则：

```bash
$ sudo iptables -L -n -t nat
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination         
DNAT       udp  --  0.0.0.0/0            6.24.34.22           udp dpt:8507 to:192.168.3.1:10012
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         
Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         
Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination         
SNAT       all  --  192.168.3.1          0.0.0.0/0            to:6.24.34.22
```





