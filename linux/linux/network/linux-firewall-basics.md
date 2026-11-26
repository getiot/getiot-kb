---
sidebar_position: 5
sidebar_label: 防火墙基础
slug: /linux-firewall-basics
---

# Linux 防火墙基础：ufw、firewalld、iptables

防火墙用于控制网络流量。它可以允许 SSH 进入，也可以阻止不该暴露的端口。学习 Linux 网络服务时，你至少要知道如何查看防火墙状态，以及如何谨慎放行端口。

## 防火墙解决什么问题

假设你在服务器上启动了一个 Web 服务，监听 8080 端口。别人能不能访问它，取决于多件事：

- 服务是否正在运行。
- 服务是否监听正确地址和端口。
- 操作系统防火墙是否放行。
- 云平台安全组是否放行。
- 中间网络是否允许访问。

防火墙只是其中一层，但它很关键。

## ufw：Ubuntu 常见工具

Ubuntu 上常见的是 [ufw](/linux-command/ufw/)，也就是 Uncomplicated Firewall。

查看状态：

```bash
sudo ufw status
```

放行 SSH：

```bash
sudo ufw allow ssh
```

或明确放行 22 端口：

```bash
sudo ufw allow 22/tcp
```

放行 HTTP 和 HTTPS：

```bash
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

启用防火墙：

```bash
sudo ufw enable
```

:::warning
远程服务器上启用防火墙前，务必先确认 SSH 端口已经放行，否则你可能把自己锁在服务器外面。
:::

## firewalld：Fedora/RHEL 常见工具

Fedora、RHEL、CentOS Stream、Rocky Linux 等系统常见 firewalld。它的命令行工具是 `firewall-cmd`。

查看状态：

```bash
sudo firewall-cmd --state
```

查看当前开放服务：

```bash
sudo firewall-cmd --list-all
```

临时放行 HTTP：

```bash
sudo firewall-cmd --add-service=http
```

永久放行 HTTP：

```bash
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload
```

如果你的系统没有 `firewall-cmd`，说明可能没有安装或没有使用 firewalld。

## iptables 和 nftables

[iptables](/linux-command/iptables/) 是传统 Linux 防火墙管理工具。现代系统底层更多转向 nftables，但很多资料、脚本和旧系统仍然使用 iptables。

查看规则：

```bash
sudo iptables -L -n -v
```

初学阶段不建议直接手写复杂 iptables 规则。优先使用发行版推荐的上层工具，例如 `ufw` 或 firewalld。

## 检查端口是否监听

放行防火墙前，先确认服务是否监听：

```bash
ss -tulpn | grep ":8080"
```

如果没有任何输出，说明服务可能根本没有监听 8080 端口。此时修改防火墙也解决不了问题。

## 云服务器还要检查安全组

很多云平台在操作系统之外还有安全组、防火墙策略或网络 ACL。即使 Linux 内部已经放行，云平台外层没有放行，外部仍然连不上。

排查远程访问时，要同时检查：

- Linux 防火墙。
- 云平台安全组。
- 服务监听地址。
- 客户端访问的公网 IP 和端口是否正确。

## 小结

你需要掌握：

- `sudo ufw status` 查看 Ubuntu 防火墙状态。
- `sudo ufw allow 端口/tcp` 放行端口。
- `firewall-cmd --list-all` 查看 firewalld 规则。
- `iptables -L -n -v` 查看传统规则。
- 放行端口前先用 `ss -tulpn` 确认服务正在监听。

防火墙配置要谨慎，尤其是在远程服务器上。先放行 SSH，再启用或调整规则。
