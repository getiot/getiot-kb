---
sidebar_position: 2
sidebar_label: 查看网络状态
slug: /linux-network-diagnostics
---

# Linux 网络状态查看：ip、ping、ss、curl、dig

网络问题不要一上来就猜。你可以按层次排查：本机地址、路由、连通性、端口、DNS、应用响应。

本文介绍 [ip](/linux-command/ip/)、[ping](/linux-command/ping/)、[ss](/linux-command/ss/)、[curl](/linux-command/curl/) 和 [dig](/linux-command/dig/)。

## 第一步：看 IP 地址

```bash
ip addr
```

重点看当前使用的网卡是否有 `inet` 地址。

如果你只想看简洁输出：

```bash
ip -br addr
```

输出可能是：

```text
lo               UNKNOWN        127.0.0.1/8 ::1/128
eth0             UP             192.168.1.10/24
```

如果网卡没有 IP，可能是 DHCP 没拿到地址、网卡未连接，或网络管理配置有问题。

## 第二步：看路由

```bash
ip route
```

你需要关注是否有默认路由：

```text
default via 192.168.1.1 dev eth0
```

没有默认路由时，本机可能只能访问同网段，无法访问外网。

## 第三步：测试连通性

先测试网关：

```bash
ping -c 4 192.168.1.1
```

再测试公网 IP：

```bash
ping -c 4 8.8.8.8
```

如果网关能通，但公网 IP 不通，问题可能在路由器、上游网络或防火墙。

如果公网 IP 能通，但域名不通，问题更可能是 DNS。

:::note
有些服务器或网络会禁止 ICMP，所以 `ping` 不通不一定代表 TCP 服务不可达。它只是排查线索之一。
:::

## 第四步：检查 DNS

```bash
dig example.com
```

如果解析成功，你会看到 `ANSWER SECTION`。

只看解析结果：

```bash
dig +short example.com
```

如果没有 `dig`，可以用：

```bash
getent hosts example.com
```

DNS 失败时，检查 `/etc/resolv.conf` 或当前网络管理器配置。

## 第五步：检查端口监听

查看本机监听端口：

```bash
ss -tulpn
```

常见选项：

- `-t`：TCP。
- `-u`：UDP。
- `-l`：监听状态。
- `-p`：显示进程。
- `-n`：不解析名称，直接显示数字端口。

查看 22 端口：

```bash
ss -tulpn | grep ":22"
```

如果服务没有监听端口，客户端当然连不上。

## 第六步：测试应用响应

HTTP/HTTPS 服务可以用 `curl`：

```bash
curl -I https://example.com
```

`-I` 只请求响应头，适合快速检查服务是否可达。

查看详细连接过程：

```bash
curl -v https://example.com
```

`curl -v` 会显示 DNS、TCP、TLS、HTTP 等过程中的关键信息。

## 一套常用排查流程

当你发现“不能上网”时，可以按这个顺序：

```bash
ip -br addr
ip route
ping -c 4 网关地址
ping -c 4 8.8.8.8
dig example.com
curl -I https://example.com
```

当你发现“别人连不上我的服务”时，可以按这个顺序：

```bash
ss -tulpn
systemctl status 服务名
journalctl -u 服务名 -n 50
sudo ufw status
```

这里涉及 systemd 和防火墙，后续章节会展开。

## 小结

网络排错要按层次来：

- `ip addr` 看本机地址。
- `ip route` 看默认路由。
- `ping` 测连通性。
- `dig` 查 DNS。
- `ss` 看端口监听。
- `curl` 测应用响应。

不要只凭“能不能打开网页”判断问题。拆成一层层检查，你会更快定位原因。
