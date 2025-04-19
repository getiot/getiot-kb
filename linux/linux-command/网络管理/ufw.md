---
sidebar_label: ufw 命令
sidebar_position: 36
slug: /ufw
---

# Linux ufw 命令 - 防火墙配置管理工具



## 介绍

**ufw**（英文全拼：Uncomplicated Firewall）命令用于管理 Linux 系统防火墙服务。由于 Linux 系统早期使用的 [iptables](/linux-command/iptables/) 防火墙完全基于命令行工作，操作参数及配置方法特别复杂，因此 Ubuntu 系统率先发布了这款基于 iptables 之上的全新、简单防火墙服务管理工具。ufw 支持图形化界面操作，弥补了 iptables 防火墙只支持命令行配置的缺点，使用起来简单很多。

**语法**：

```bash
ufw <COMMAND>
```

**命令**：

- `enable`：启动防火墙。
- `disable`：关闭防火墙。
- `default ARG`：设置默认策略。
- `logging LEVEL`：设置日志等级为 `LEVEL`。
- `allow ARGS`：添加允许通过规则。
- `deny ARGS`：添加禁止通过规则。
- `reject ARGS`：添加拒绝规则。
- `limit ARGS`：添加限制规则。
- `delete RULE|NUM`：删除规则。
- `insert NUM RULE`：在 `NUM` 处插入规则。
- `route RULE`：添加路由规则。
- `route delete RULE|NUM`：删除路由规则。
- `route insert NUM RULE`：在 `NUM` 处插入路由规则。
- `reload`：重新加载防火墙配置。
- `reset`：重置配置防火墙。
- `status`：查看防火墙状态。
- `status numbered`：将防火墙状态显示为规则编号列表。
- `status verbose`：显示详细的防火墙状态。
- `show ARG`：显示防火墙报告。
- `version`：显示版本信息。

Application profile 命令：

- `app list`：列出应用程序配置文件（application profiles）。
- `app info PROFILE`：显示 `PROFILE` 的信息。
- `app update PROFILE`：更新 `PROFILE`。
- `app default ARG`：设置默认的应用程序策略（application policy）。



## 示例

查看防火墙状态及所有规则（需要 root 权限）：

```bash
sudo ufw status
```

查看防火墙状态、规则及其编号：

```bash
sudo ufw status numbered
```

启动 UFW 防火墙管理工具：

```bash
sudo ufw enable
```

禁用 UFW 防火墙管理工具：

```bash
sudo ufw disable
```

开放 UDP 端口 1234、开放 TCP 端口 1234（可同时开放）：

```bash
sudo ufw allow 1234/udp
sudo ufw allow 1234/tcp
```

删除上面设置的规则：

```bash
sudo ufw delete allow 1234/udp
sudo ufw delete allow 1234/tcp
```

通过编号（例如 2）删除特定规则：

```bash
sudo ufw delete 2
```

重启 UFW 防火墙管理工具（更新规则后可能需要执行）：

```bash
sudo ufw reload
```

重置 UFW 防火墙策略：

```bash
sudo ufw reset
```

显示 UFW 防火墙的报告信息：

```bash
sudo ufw show raw
```

