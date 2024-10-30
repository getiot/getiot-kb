---
sidebar_label: pppd 命令
sidebar_position: 38
slug: /pppd
---

# pppd 命令 - 点对点协议守护进程



## 介绍

**pppd**（英文全拼：Point-to-Point Protocol Daemon）是 Linux 系统中用于建立和管理 PPP（点对点协议）连接的守护进程。pppd 支持多种身份验证方法，包括 PAP 和 CHAP 等。

:::tip

PPP 是一种用于在两个计算机之间建立点对点连接的协议，通常用于拨号连接、DSL 连接和串行线路连接。

:::

**语法**：

```bash
pppd [ options ]
```

**选项**：

- `<device>` ：通过指定的设备进行通信。
- `<speed>` ：将波特率设置为 `speed`（一个十进制数字）。
- `<loc>:<rem>` ：设置本地和/或远程接口 IP 地址。两者都可以省略，但冒号是必需的。IP 地址可以通过主机名来指定，也可以通过十进制点记法来指定，例如 `:10.1.2.3`。缺省本地地址是系统的第一个 IP 地址，除非提供了 `noipdefault` 选项。
- `asyncmap <n>` ：将 async 字符映射设置为 `n`（十六进制）。映射描述了哪些控制字符无法通过串行线路成功接收。
- `auth` ：在允许发送或接收网络数据包之前要求对等方证明自己的身份。
- `call <name>`：从文件 `/etc/ppp/peers/name` 中读取额外的选项。即使 pppd 不是由 root 运行，这个文件也可以包含诸如 `noauth` 之类的特权选项。注意，`name` 字符串不能以 `/` 开头，也不能包含 `..`。
- `connect <script>` ：使用由 `script` 指定的可执行文件或 shell 命令来设置串行线路。
- `crtscts` ：使用硬件流量控制（即 RTS/CTS）来控制串行端口上的数据流。
- `defaultroute` ：当 IPCP 协商成功完成时，向系统路由表添加一个缺省路由（使用对等方作为网关）。当 PPP 连接断开时，将删除此条目。如果指定了 `nodefaultroute` 选项，则此选项为特权选项。
- `file <name>` ：从文件 `name` 读取选项。如果此选项在命令行上或 `$HOME/.ppprc` 中使用，则该文件必须能够由调用 `pppd` 的用户读取。
- `modem` ：使用调制解调器控制线路。此选项为缺省选项。
- `mru <n>` ：将最大接收单元（Maximum Receive Unit, MRU）值设置为 `n`。pppd 要求对等方发送的包不要超过 n 个字节。最小 MRU 值为 128。缺省 MRU 值为 1500。对于慢速链路，建议使用值 296（40 字节的 TCP/IP 标头 + 256 字节的数据）。对于 IPv6，MRU 必须至少为 1280。
- `mtu <n>` ：将最大传输单元（Maximum Transmit Unit, MTU）值设置为 `n`。除非对等方通过 MRU 协商请求一个较小的值，否则，pppd 将要求内核联网代码通过 PPP 网络接口发送的数据包不要超过 n 个字节。对于 IPv6，MTU 必须至少为 1280。



## 示例

使用名为 provider 的配置文件来建立拨号连接（配置文件通常存储在 ` /etc/ppp/peers` 目录中）：

```bash
pppd call provider
```

建立连接时显示详细调试信息：

```bash
pppd call provider debug
```

建立连接时提供用户名和密码进行认证：

```bash
pppd call provider user your_username password your_password
```

指定串行端口和波特率来建立 PPP 连接：

```bash
pppd /dev/ttyS0 115200
```

使用 CHAP 认证方式建立连接（配置信息通常存储在 `/etc/ppp/chap-secrets` 文件）：

```bash
pppd call provider chap-secrets
```

使用 PAP 认证方式建立连接（配置信息通常存储在 `/etc/ppp/pap-secrets` 文件）：

```bash
pppd call provider pap-secrets
```

