---
sidebar_position: 8
sidebar_label: 通过 SSH 密钥对登录 Linux
---

# 通过 SSH 密钥对（pem）登录 Linux 服务器

![](https://static.getiot.tech/linux-ssh-key-pair.png#center-large)

在日常运维或云端开发中，使用 SSH 密钥对（公钥 + 私钥）替代密码登录 Linux 服务器，不仅更加安全，也更方便自动化管理。本文将介绍如何通过 `.pem` 格式的私钥文件连接远程 Linux 服务器。

## 准备工作

**1. 放行 SSH 端口（22）**

确保服务器的防火墙或云服务的安全组已放行端口 **`22`**，这是 SSH 服务的默认端口。

- 云服务器：请在提供商后台配置防火墙（如安全组、网络 ACL）
- 本地服务器：请使用 `ufw`、`firewalld` 或 `iptables` 确保端口 22 是开放的

**2. 获取 SSH 私钥（.pem 文件）**

如果你已经生成密钥对，请跳过此步骤。

如果你还没有私钥，可以通过以下方式生成：

```bash
ssh-keygen -t rsa -b 2048 -f my-key
```

这将生成两个文件：

- `my-key`：私钥文件
- `my-key.pub`：公钥文件

将公钥内容 `my-key.pub` 添加到远程服务器的 `~/.ssh/authorized_keys` 文件中。

如果你是从云服务提供商处创建的服务器，也可能已经提供了 `.pem` 格式的私钥，直接下载保存即可。

🔒 **请妥善保存私钥文件，避免泄露。**



## 修改私钥文件权限

使用以下命令限制私钥文件权限：

```bash
chmod 400 my-key.pem
```

这是为了防止私钥被他人读取，SSH 连接时会强制检查权限是否安全。



## 使用 SSH 连接服务器

准备好以下信息：

- 服务器公网 IP 地址或域名
- 登录用户名（如 `root`、`ubuntu`、`centos` 等）
- `.pem` 私钥文件路径

连接命令如下：

```bash
ssh -i my-key.pem 用户名@服务器IP
```

例如：

```bash
ssh -i my-key.pem ubuntu@203.0.113.10
```

首次连接时会提示确认主机指纹，输入 `yes` 并回车即可继续。



## 修改 SSH 配置文件

如果你经常需要连接同一台服务器，或者管理多台服务器，可以通过配置 SSH 配置文件 `~/.ssh/config` 来简化连接命令，只需输入 `ssh myserver` 即可连接目标服务器。

**1. 编辑 SSH 配置文件**

打开或创建配置文件：

```bash
vi ~/.ssh/config
```

添加以下内容（根据实际情况修改）：

```ini
Host myserver
    HostName 203.0.113.10
    User ubuntu
    IdentityFile ~/.ssh/my-key.pem
```

说明：

- `Host`：你给该连接起的别名，之后用 `ssh myserver` 即可连接
- `HostName`：服务器的 IP 地址或域名
- `User`：登录用户名
- `IdentityFile`：对应的私钥文件路径（支持 `.pem`）

**2. 设置配置文件权限**

出于安全考虑，请将配置文件权限设置为 600：

```bash
chmod 600 ~/.ssh/config
```

**3. 测试连接**

执行以下命令即可一键连接：

```bash
ssh myserver
```

无需每次都指定 IP、用户名和私钥路径，极大提升使用体验。

**4. 支持多个服务器配置**

你可以在 `~/.ssh/config` 中配置多个服务器，例如：

```ini
Host web-server
    HostName 203.0.113.10
    User ubuntu
    IdentityFile ~/.ssh/web.pem

Host db-server
    HostName 203.0.113.11
    User root
    IdentityFile ~/.ssh/db.pem
```



## 常见问题排查

### 1. 权限错误

```bash
WARNING: UNPROTECTED PRIVATE KEY FILE!
Permissions 0644 for 'my-key.pem' are too open.
```

这是因为私钥权限过宽。解决方法：

```bash
chmod 400 my-key.pem
```

### 2. 无法连接（连接超时）

请确认以下几点：

- 服务器正在运行
- 网络连接正常
- 公网 IP 是否正确
- 端口 22 已开放（防火墙、安全组已放行）

### 3. 用户名错误

不同 Linux 发行版的默认用户名可能不同：

|    发行版     | 默认用户名 |
| :-----------: | :--------: |
|    Ubuntu     |   ubuntu   |
|    Debian     |   debian   |
| CentOS / RHEL |   centos   |
| Amazon Linux  |  ec2-user  |
|    Fedora     |   fedora   |
|    Alpine     |    root    |

如果连接失败，可以尝试更换用户名。



## 安全建议

- 不要将私钥上传到公共仓库或他人设备
- 每台机器建议使用不同的密钥对
- 若多人共用服务器，建议每人上传各自的公钥
- 设置 `.ssh/authorized_keys` 文件权限为 `600`，`.ssh` 目录权限为 `700`



## 附录：如何将公钥添加到服务器

云服务器会自动完成公钥添加，但是如果是自己生成的密钥对，则需要自行将公钥添加到 Linux 服务器。

在远程服务器上执行以下命令，将本地生成的公钥追加到 `~/.ssh/authorized_keys` 文件中：

```bash
mkdir -p ~/.ssh
cat my-key.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
```

通过上述步骤，你就可以使用 SSH 密钥对安全登录你的 Linux 服务器了。相比传统的密码登录，密钥对方式更加安全可靠，建议作为默认登录方式使用。
