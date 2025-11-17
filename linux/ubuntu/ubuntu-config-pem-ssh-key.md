---
sidebar_position: 15
---

# Ubuntu 生成 pem 证书连接服务器

在 Linux 系统中，使用 pem 私钥（公钥登录）是最安全、最推荐的 SSH 登录方式。本文给大家提供一个面向生产服务器（Ubuntu）的标准安全配置方案，包含完整步骤、命令、最佳实践。



## 实现目标

让 Linux 服务器的 SSH 登录变得更安全，做到不再使用密码登录（完全禁用密码）。

具体操作主要包括两步：① 将本地生成的 **私钥**（.pem） 保存到电脑上，② 服务器只保存另一半 **公钥**（authorized_keys）。



## 在本地生成 SSH 密钥

首先，需要在本地以 pem 方式生成 SSH 密钥。如果你使用 macOS / Linux 系统，可执行如下命令（以 `my_server` 命名为例）：

```bash
ssh-keygen -t rsa -b 4096 -m PEM -f ~/.ssh/my_server
```

说明：

| 文件            | 含义                             |
| --------------- | -------------------------------- |
| `my_server`     | 私钥（*.pem 文件）永远不要给别人 |
| `my_server.pub` | 公钥，可以放服务器               |

⚠ 

:::warning 

默认 `ssh-keygen` 会生成 OpenSSH 格式的私钥，如果你要严格使用 `.pem` 格式，请加上 `-m PEM`（上面命令已包含）。

:::



## 上传公钥到服务器

需要修改的 SSH 文件通常位于 `~/.ssh/authorized_keys`，我们推荐使用 `ssh-copy-id` 命令自动安装：

```bash
ssh-copy-id -i ~/.ssh/my_server.pub youruser@<ip_address>
```

如果服务器禁止密码登陆，你也可以手动创建：

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
```

然后复制公钥内容（my_server.pub）到：

```bash
vi ~/.ssh/authorized_keys
```

保存后执行：

```bash
chmod 600 ~/.ssh/authorized_keys
```



## 测试密钥登录

在本地执行：

```bash
ssh -i ~/.ssh/my_server youruser@<ip_address>
```

如果能成功登录服务器，说明 pem 证书已经生效。

你可以将 SSH 登录信息写在 `~/.ssh/config` 文件中，如下（假设 IP 地址为 10.138.150.88，用户名为 ubuntu）：

```bash showLineNumbers
Host my_server
	HostName 10.138.150.88
	User ubuntu
	IdentityFile ~/.ssh/my_server
```

现在，在本地执行下面命令就可以直接登录了。

```bash
ssh my_server
```



## 禁用密码登录

既然已经通过 pem 证书实现 SSH 登录了，那原来的密码登录就可以禁用了，这样才会更安全。

需要修改 `/etc/ssh/sshd_config` 配置文件：

```bash
sudo vi /etc/ssh/sshd_config
```

修改或添加以下内容：

```bash showLineNumbers
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM no
PubkeyAuthentication yes
PermitRootLogin no
PermitEmptyPasswords no
```

保存后重启 SSH 服务：

```bash
sudo systemctl restart ssh
```



## 更安全的附加措施

如果你需要更加安全的服务器环境，可以考虑一下以下措施。

### 修改 SSH 默认端口

在 `/etc/ssh/sshd_config` 中修改默认的 SSH 端口，例如改成 2345：

```bash
Port 2345
```

重启 SSH 服务后即生效，之后登录需要指定端口：

```bash
ssh -i ~/.ssh/my_server -p 2345 youruser@<ip_address>
```

或者在 `~/.ssh/config` 配置文件中增加端口配置：

```bash
Host my_server
	HostName 10.138.150.88
	User ubuntu
	IdentityFile ~/.ssh/my_server
	Port 2345
```



### 安装 Fail2ban 防暴力破解

Fail2Ban 是一个开源的入侵防御工具（用 Python 开发），用于保护 Linux 服务器免受暴力破解攻击（防止暴力破解系统密码）。它主要通过监控系统日志文件（如 `/var/log/auth.log`、`/var/log/apache/access.log`等）来生效，一旦发现恶意攻击的登录请求，它会封锁对方的 IP 地址，使得对方无法再发起请求。

也就是说，使用 Fail2Ban 可以防止有人反复尝试 SSH 密码登录你的服务器。但如果你已经禁用了 SSH 密码登录，使用 pem 密钥登录，那就不需要 Fail2Ban 来保护。

安装命令：

```bash
sudo apt install fail2ban -y
```

启动服务：

```bash
sudo systemctl enable --now fail2ban
```

查看状态：

```bash
sudo fail2ban-client status
```



