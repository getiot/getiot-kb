---
sidebar_position: 12
---

# Linux 安装 Caddy 服务

Caddy 是一个功能强大的、企业级的、开源的 Web 服务器，具有自动 HTTPS 功能。本文介绍在不同 Linux 发行版系统上安装 Caddy 的多种方法。

## 什么是 Caddy

Caddy 是一个现代化的 Web 服务器，主要特点包括：

- **自动 HTTPS**：自动为域名配置 SSL/TLS 证书
- **HTTP/2 和 HTTP/3**：支持最新的 HTTP 协议
- **反向代理**：强大的反向代理功能
- **易于配置**：简洁的 Caddyfile 配置语法
- **高性能**：基于 Go 语言开发，性能优异

## 安装方法

### 方法一：Debian/Ubuntu/Raspbian

Caddy 官方提供了 Debian/Ubuntu/Raspbian 的软件包，这是最推荐的安装方式。

#### 稳定版本

```bash
# 安装必要的工具
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl

# 添加 Caddy 官方 GPG 密钥
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

# 添加 Caddy 软件源
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

# 设置密钥和源文件权限
sudo chmod o+r /usr/share/keyrings/caddy-stable-archive-keyring.gpg
sudo chmod o+r /etc/apt/sources.list.d/caddy-stable.list

# 更新软件包列表
sudo apt update

# 安装 Caddy
sudo apt install caddy
```

#### 测试版本（包含 beta 和 RC 版本）

如果需要使用测试版本，可以使用以下命令：

```bash
# 安装必要的工具
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl

# 添加 Caddy 测试版 GPG 密钥
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/testing/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-testing-archive-keyring.gpg

# 添加 Caddy 测试版软件源
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/testing/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-testing.list

# 设置密钥和源文件权限
sudo chmod o+r /usr/share/keyrings/caddy-testing-archive-keyring.gpg
sudo chmod o+r /etc/apt/sources.list.d/caddy-testing.list

# 更新软件包列表
sudo apt update

# 安装 Caddy
sudo apt install caddy
```

**注意**：安装完成后，Caddy 会自动作为 systemd 服务启动并运行。服务名称为 `caddy`。

:::tip
如果由于网络问题无法通过 curl 下载 gpg.key 和 debian.deb.txt 文件，可以参考 [常见问题](#常见问题) 中的解决办法。
:::

### 方法二：Fedora/RedHat/CentOS

#### Fedora

```bash
# 安装 dnf5 插件
sudo dnf install dnf5-plugins

# 启用 Caddy COPR 仓库
sudo dnf copr enable @caddy/caddy

# 安装 Caddy
sudo dnf install caddy
```

#### CentOS/RHEL

```bash
# 安装 dnf 插件
sudo dnf install dnf-plugins-core

# 启用 Caddy COPR 仓库
sudo dnf copr enable @caddy/caddy

# 安装 Caddy
sudo dnf install caddy
```

**注意**：安装完成后，Caddy 的 systemd 服务文件已安装但默认未启用。需要手动启用和启动服务。

### 方法三：Arch Linux/Manjaro

```bash
# 更新软件包列表
sudo pacman -Syu

# 安装 Caddy
sudo pacman -S caddy
```

**注意**：Arch Linux 的 Caddy 包包含修改过的 systemd 服务文件，默认未启用。

### 方法四：Docker

使用 Docker 安装 Caddy 是最简单的方式之一：

```bash
# 拉取 Caddy 官方镜像
docker pull caddy

# 运行 Caddy 容器
docker run -d --name caddy \
  -p 80:80 -p 443:443 \
  -v $PWD/Caddyfile:/etc/caddy/Caddyfile \
  -v caddy_data:/data \
  -v caddy_config:/config \
  caddy
```

#### Docker Compose 配置

推荐使用 Docker Compose 来管理 Caddy：

```yaml
version: '3.8'

services:
  caddy:
    image: caddy:latest
    container_name: caddy
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "443:443/udp"
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config

volumes:
  caddy_data:
  caddy_config:
```

### 方法五：静态二进制文件

如果上述方法都不适用，可以下载静态二进制文件：

1. **从 GitHub 下载**：
   - 访问 [Caddy Releases](https://github.com/caddyserver/caddy/releases)
   - 下载对应架构的二进制文件
   - 参考 [验证资产签名](https://caddyserver.com/docs/signature-verification) 验证文件

2. **从下载页面获取**：
   - 访问 [Caddy 下载页面](https://caddyserver.com/download)

3. **安装到系统路径**：
   ```bash
   # 下载二进制文件
   wget https://github.com/caddyserver/caddy/releases/latest/download/caddy_2.7.6_linux_amd64.tar.gz
   
   # 解压
   tar -xzf caddy_2.7.6_linux_amd64.tar.gz
   
   # 移动到系统路径
   sudo mv caddy /usr/local/bin/
   
   # 设置执行权限
   sudo chmod +x /usr/local/bin/caddy
   ```

4. **配置为 systemd 服务**（推荐）：
   创建 `/etc/systemd/system/caddy.service` 文件：

   ```ini showLineNumbers title="caddy.service"
   [Unit]
   Description=Caddy
   Documentation=https://caddyserver.com/docs/
   After=network.target network-online.target
   Requires=network-online.target
   
   [Service]
   Type=notify
   User=caddy
   Group=caddy
   ExecStart=/usr/local/bin/caddy run --environ --config /etc/caddy/Caddyfile
   ExecReload=/usr/local/bin/caddy reload --config /etc/caddy/Caddyfile --force
   TimeoutStopSec=5s
   LimitNOFILE=1048576
   LimitNPROC=512
   PrivateTmp=true
   ProtectSystem=full
   AmbientCapabilities=CAP_NET_BIND_SERVICE
   CapabilityBoundingSet=CAP_NET_BIND_SERVICE
   
   [Install]
   WantedBy=multi-user.target
   ```

   然后启用并启动服务：

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable caddy
   sudo systemctl start caddy
   ```

## 验证安装

安装完成后，可以通过以下命令验证：

```bash
# 检查 Caddy 版本
caddy version

# 检查 Caddy 是否运行（如果使用 systemd）
sudo systemctl status caddy

# 测试 Caddy 是否响应
curl http://localhost
```

## 管理 Caddy 服务

如果 Caddy 作为 systemd 服务安装，可以使用以下命令管理：

```bash
# 启动服务
sudo systemctl start caddy

# 停止服务
sudo systemctl stop caddy

# 重启服务
sudo systemctl restart caddy

# 重新加载配置（不中断服务）
sudo systemctl reload caddy

# 查看服务状态
sudo systemctl status caddy

# 设置开机自启
sudo systemctl enable caddy

# 禁用开机自启
sudo systemctl disable caddy

# 查看日志
sudo journalctl -u caddy -f
```

## 配置文件

Caddy 的配置文件通常位于：

- **Caddyfile**：`/etc/caddy/Caddyfile`（使用包管理器安装）
- **JSON 配置**：`/etc/caddy/config.json`（高级配置）

### 基本 Caddyfile 示例

```nginx showLineNumbers title="Caddyfile"
# 静态文件服务
localhost {
    root * /var/www/html
    file_server
}

# 反向代理示例
example.com {
    reverse_proxy localhost:8080
}

# 自动 HTTPS
mysite.com {
    root * /var/www/mysite
    file_server
}
```

## 升级 Caddy

### 使用包管理器升级

**Debian/Ubuntu**：
```bash
sudo apt update
sudo apt upgrade caddy
```

**Fedora/CentOS**：
```bash
sudo dnf update caddy
```

**Arch Linux**：
```bash
sudo pacman -Syu caddy
```

### 升级静态二进制文件

```bash
# 使用 caddy upgrade 命令（如果可用）
caddy upgrade

# 或手动替换二进制文件
# 1. 下载新版本
# 2. 停止 Caddy 服务
sudo systemctl stop caddy
# 3. 替换二进制文件
sudo mv /usr/local/bin/caddy /usr/local/bin/caddy.old
sudo cp caddy /usr/local/bin/
# 4. 启动服务
sudo systemctl start caddy
```

## 常见问题

### 1. 中国大陆网络问题（Debian/Ubuntu）

在中国大陆，由于网络限制，可能无法直接执行 `curl` 命令下载 Caddy 的 GPG 密钥和软件源配置。有以下几种解决方案：

#### 方案一：使用国内地址替换原始 URL

可以使用我们提供的镜像地址替换原始 URL：

```bash
# 添加 Caddy 官方 GPG 密钥
curl -1sLf 'https://getiot.tech/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

# 添加 Caddy 软件源
curl -1sLf 'https://getiot.tech/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
```

#### 方案二：手动下载并上传文件

1. **在能访问外网的机器上下载文件**：

   ```bash
   # 下载 GPG 密钥
   curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' -o caddy-stable-archive-keyring.gpg
   
   # 下载软件源配置
   curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' -o caddy-stable.list
   ```

   或直接使用浏览器下载这两个文件，并修改文件名。

2. **将文件上传到服务器**：

   使用 `scp` 或其他方式将文件上传到服务器：

   ```bash
   scp caddy-stable-archive-keyring.gpg user@your-server:/tmp/
   scp caddy-stable.list user@your-server:/tmp/
   ```

3. **在服务器上安装**：

   ```bash
   # 安装必要的工具
   sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
   
   # 导入 GPG 密钥
   sudo gpg --dearmor < /tmp/caddy-stable-archive-keyring.gpg | sudo tee /usr/share/keyrings/caddy-stable-archive-keyring.gpg > /dev/null
   
   # 复制软件源配置
   sudo cp /tmp/caddy-stable.list /etc/apt/sources.list.d/caddy-stable.list
   
   # 设置权限
   sudo chmod o+r /usr/share/keyrings/caddy-stable-archive-keyring.gpg
   sudo chmod o+r /etc/apt/sources.list.d/caddy-stable.list
   
   # 更新软件包列表
   sudo apt update
   
   # 安装 Caddy
   sudo apt install caddy
   ```

### 2. 端口被占用

如果 80 或 443 端口被占用，可以：

```bash
# 检查端口占用
sudo netstat -tulpn | grep :80
sudo netstat -tulpn | grep :443

# 或使用 ss 命令
sudo ss -tulpn | grep :80
```

### 3. 权限问题

Caddy 需要绑定 80/443 端口，需要相应权限：

- 使用 `CAP_NET_BIND_SERVICE` 能力（推荐）
- 或使用 root 用户运行（不推荐）

### 4. 防火墙配置

确保防火墙允许 HTTP 和 HTTPS 流量：

```bash
# Ubuntu/Debian (ufw)
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# CentOS/RHEL (firewalld)
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```

## 参考资源

- [Caddy 官方文档](https://caddyserver.com/docs/)
- [Caddy 安装指南](https://caddyserver.com/docs/install)
- [Caddyfile 文档](https://caddyserver.com/docs/caddyfile)
- [Caddy GitHub](https://github.com/caddyserver/caddy)
