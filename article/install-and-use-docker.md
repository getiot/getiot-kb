---
sidebar_position: 5
sidebar_label: 在 Linux 服务器上安装并使用 Docker
slug: /install-and-use-docker
---

# 在 Linux 服务器上安装并使用 Docker，配置 HTTPS 指南

Docker 是一个开源的容器化平台，它让开发者能把应用程序及其全部依赖（代码、运行时、库、配置、环境变量）打包进一个轻量、可移植的“容器”中。本文将介绍如何在新购买的 Linux 服务器上安装 Docker，构建并启动一个 Docker 镜像进行测试。



## 为什么使用 Docker？

时至今日，Docker 已经彻底改变了软件构建、交付和运行的方式。我们在一次活动调查发现，有超过 78% 的专业开发者日常使用 Docker，这意味着 Docker 不再是 IT 项目的“高级可选”，而是“基础必备”工具。

Docker 的核心是**操作系统级虚拟化**，通过轻量级的“容器”打包应用及其依赖环境，解决了“在我机器上能跑”的经典难题。

简单来说，Docker 具有以下三大核心价值：

1. **环境一致性 & 隔离**
   - 开发、测试、生产环境高度统一（“Build once, Run anywhere”）。
   - 容器间资源（CPU、内存、网络、磁盘）相互隔离，避免冲突。
2. **极致的轻量与高效**
   - 与笨重的虚拟机（VM）不同，容器共享主机操作系统内核，无需模拟硬件。
   - 秒级启动，资源消耗极低，显著提升服务器利用率和应用密度。
3. **标准化交付**
   - 以 **Docker 镜像**为交付单元，包含了运行应用所需的一切（代码、运行时、库、环境变量、配置）。
   - 镜像分层构建与复用，优化存储与传输效率。

也因为这些价值，Docker 已成为现代开发运维（DevOps）的事实标准，广泛应用于以下场景。

- **Web 应用部署**：前端（React/Vue）、后端（Node.js/Python/Go）、数据库（PostgreSQL/Redis）均可容器化。
- **微服务架构**：每个服务独立打包、独立伸缩，通过 API 通信。
- **持续集成 & 测试**：在干净容器中运行测试，避免“依赖污染”。
- **本地开发环境搭建**：`docker-compose up` 一键启动全套服务（数据库 + 缓存 + API），告别“配置一下午”。
- **边缘计算 & IoT**：在资源受限设备上轻量运行标准化应用。



## 安装 Docker（社区版）

我们最近购买了一台 Ubuntu 24.04 系统的阿里云服务器，下面将在这台服务器上进行安装、测试。

:::tip 温馨提示

如果你的服务器已经安装过 Docker，那么在安装新版 Docker 之前，需要先卸载所有已安装的 Docker 组件，以免出现潜在的冲突和兼容性问题。

```bash
# 删除 Docker 相关源
sudo rm -f /etc/apt/sources.list.d/*docker*.list
# 卸载 Docker 和相关的软件包
for pkg in docker.io docker-buildx-plugin docker-ce-cli docker-ce-rootless-extras docker-compose-plugin docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove -y $pkg; done
```

注意：卸载 Docker 不会自动移除镜像、容器、存储卷和网络，这些数据默认存储在 `/var/lib/docker/` 目录。

:::

我们安装的是 Docker 社区版本，安装命令如下：

```bash
# 更新包管理工具
sudo apt-get update

# 安装必要依赖工具
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common

# 添加 Docker 官方 GPG 密钥
sudo curl -fsSL http://mirrors.cloud.aliyuncs.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

# 添加 Docker 软件包源
sudo add-apt-repository -y "deb [arch=$(dpkg --print-architecture)] http://mirrors.cloud.aliyuncs.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

# 安装 Docker 社区版本，容器运行时 containerd.io，以及 Docker 构建和 Compose 插件
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

如果命令执行顺利的话，Docker 已经安装好了。你可以执行 `sudo docker --version` 命令验证安装情况。

```bash
$ sudo docker --version
Docker version 29.1.3, build f52814d
```

⚠️ 注意！对于非阿里云的服务器，需要将安装命令中的 `http://mirrors.cloud.aliyuncs.com` 链接替换为 `https://mirrors.aliyun.com`，否则无法添加 GPG 密钥。



## 设置 Docker

Docker 安装好之后正常来说是自启动的，如果没有启动，可以手动执行下面命令：

```bash
# 启动 Docker
sudo systemctl start docker
# 设置 Docker 守护进程在系统启动时自动启动
sudo systemctl enable docker
```

将当前用户添加到 `docker` 组，可以避免每次执行 `docker` 命令都要在前面添加 `sudo`：

```bash
# 将当前用户添加到 docker 组
sudo usermod -aG docker $USER
# 使用户组生效
newgrp docker
```

另外，由于运营商网络原因，导致从 Docker Hub 拉取镜像会失败。因此必须配置镜像加速器解决该问题！

如果使用阿里云，可以登录[容器镜像服务控制台](https://cr.console.aliyun.com)，在左侧导航栏选择 *镜像工具 > 镜像加速器*，在 *镜像加速器* 页面获取 *加速器地址*。或者使用其他第三方的 Docker 镜像加速器，例如 `https://docker.mirrors.ustc.edu.cn`。

编辑 Docker 配置文件 `/etc/docker/daemon.json`：（若文件不存在，先创建）

```bash
# /etc/docker/daemon.json
{
    "registry-mirrors": ["<加速器地址>"]
}
```

重启 Docker 服务应用新配置：

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```



## 快速部署一个 Web 应用

现在 Docker 已经准备就绪，我们来构建一个 Hello World 镜像看看！

首先拉取 Nginx 镜像：

```bash
sudo docker pull nginx:latest
```

然后创建一个工作目录（如 hello-world），在里面新建一个 Dockerfile 文件，输入以下内容：

```dockerfile showLineNumbers title="Dockerfile"
FROM nginx:latest
RUN echo 'Hello World!' > /usr/share/nginx/html/index.html
```

表示该镜像以 Nginx 作为基础镜像，并在 Web 服务器的根目录创建一个显示 `Hello World!` 的 index.html 文件。

接下来就可以构建镜像了！在 Dockerfile 所在目录执行以下命令，将生成名为 hello-world 的镜像：

```bash
sudo docker build . -t hello-world:latest
```

使用 `hello-world` 镜像启动一个名为 `hello-world` 的容器：

```bash
sudo docker run -d -p 80:80 --name hello-world hello-world:latest
```

执行 `curl http://localhost` 命令，验证 Web 程序是否正确显示 `Hello World!`。



## 设置 HTTPS 访问

如果你的云服务器已经配置好了域名和 SSL 证书，希望通过域名访问该 Web 服务，那么可以在宿主机使用 Nginx 作为 HTTPS 反向代理。

具体来说，首先需要停止并删除当前容器，改用非冲突端口暴露服务，例如 `8080` 端口：

```bash
sudo docker stop hello-world
sudo docker rm hello-world

# 改为映射到宿主机的 8080（或其他未占用端口），容器内部仍用 80
sudo docker run -d -p 8080:80 --name hello-world hello-world:latest
```

此时宿主机 `localhost:8080` 可访问该服务，测试 `curl http://localhost:8080` 应返回 `Hello World!`。

然后修改宿主机的 Nginx 配置，例如 `/etc/nginx/sites-enabled/default`：

```nginx showLineNumbers
server {
	listen 80 default_server;
	listen [::]:80 default_server;

	# SSL configuration
	listen 443 ssl default_server;
	listen [::]:443 ssl default_server;

	# ......
	
	location / {
		proxy_pass http://127.0.0.1:8080;  # 转发到容器
		proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;  # 告知后端是 HTTPS
	}

	# ......
}
```

启用配置并重载 Nginx：

```bash
# 检查配置语法
sudo nginx -t
# 重启
sudo systemctl reload nginx
```

确保云服务器端口管理中开放了 80 和 443 端口，并且正确配置 SSL 证书。浏览器打开你的域名（例如 `https://example.com`），可以看到 `Hello World!`。

:::info

你可以在容器内配置 HTTPS，此时你需要把 SSL 证书打包进镜像或挂载，证书更新稍微麻烦一点，并且多个服务需要多份证书。

相对而言，在宿主机使用 Nginx 反向代理是比较推荐的方式，因为它可以复用现有 SSL 配置、可以集中管理证书，并且支持多个服务。

对于多容器、微服务架构，还可以使用 [Traefik](/foss/traefik/) / [Caddy](/foss/caddy/) 等自动 HTTPS 网关，可以实现更高级的自动化运维（如 Let's Encrypt 自动续签），但同时也增加了复杂度。

:::