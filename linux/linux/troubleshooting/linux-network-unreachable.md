---
sidebar_position: 4
sidebar_label: 网络不通怎么查
slug: /linux-network-unreachable
---

# Linux 网络不通怎么查

网络不通是一个很宽泛的说法。可能是没有 IP、路由错误、DNS 失败、端口没监听、防火墙拦截，也可能是服务本身坏了。

排查时要把问题拆开。

## 先定义“哪里不通”

请先明确你遇到的是哪一种：

- 本机不能访问外网。
- 本机能访问 IP，但不能访问域名。
- 别人不能访问本机服务。
- 本机不能访问某台服务器的某个端口。
- SSH 连不上。
- 浏览器打不开，但命令行能通。

不同现象对应不同方向。

## 本机不能上网

按顺序执行：

```bash
ip -br addr
ip route
ping -c 4 网关地址
ping -c 4 8.8.8.8
dig example.com
```

判断：

- 没有 IP：检查网卡、DHCP、网络管理器。
- 没有默认路由：检查网关配置。
- 网关不通：检查局域网连接。
- IP 能通但域名不通：检查 DNS。

## 域名解析失败

测试：

```bash
dig example.com
getent hosts example.com
```

查看 DNS 配置：

```bash
cat /etc/resolv.conf
```

现代发行版可能由 NetworkManager 或 systemd-resolved 管理 DNS，所以不要只手改 `/etc/resolv.conf`。需要根据发行版网络管理方式调整。

## 访问某个端口失败

先确认目标地址和端口：

```bash
curl -v http://example.com:8080
```

如果是本机服务，检查监听：

```bash
ss -tulpn | grep ":8080"
```

如果没有监听，先处理服务本身。

如果已经监听，再检查防火墙：

```bash
sudo ufw status
sudo iptables -L -n -v
```

云服务器还要检查云平台安全组。

## SSH 连不上

常见排查：

```bash
ping -c 4 服务器IP
ssh -v user@服务器IP
```

在服务器上检查：

```bash
ss -tulpn | grep ":22"
systemctl status ssh
journalctl -u ssh -n 50
```

有些发行版服务名是 `sshd`，需要按实际情况替换。

如果 SSH 端口不是 22，要显式指定：

```bash
ssh -p 2222 user@服务器IP
```

## 服务只监听 127.0.0.1

如果服务只监听 `127.0.0.1`，外部机器通常无法访问。

检查监听地址：

```bash
ss -tulpn | grep ":8080"
```

如果看到：

```text
127.0.0.1:8080
```

说明只监听本机。需要根据服务配置改为监听合适的地址，例如 `0.0.0.0` 或指定内网 IP。

:::warning
不要为了省事把所有服务都监听 `0.0.0.0`。这会让服务暴露到所有网络接口，应配合防火墙和认证机制。
:::

## 代理问题

如果命令行能访问一部分网站，另一部分失败，或公司网络需要代理，检查环境变量：

```bash
env | grep -i proxy
```

代理配置可以参考 [Linux 网络代理配置](../network/linux-network-configuration.md)。

## 小结

网络排错的核心是分层：

1. 本机有没有 IP。
2. 路由是否正确。
3. DNS 是否可用。
4. 目标端口是否监听。
5. 防火墙和安全组是否放行。
6. 应用服务是否正常。

按层次查，你就不会被“网络不通”这四个字困住。
