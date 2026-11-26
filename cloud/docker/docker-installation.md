---
sidebar_position: 2
slug: /docker-installation
---

# Docker 安装

本文以 Ubuntu 为例，介绍如何在 Linux 系统中安装 docker。



## Ubuntu 安装 docker

在新主机上首次安装 Docker 之前，需要设置 Docker 镜像库。之后，你就可以从镜像库安装和更新 Docker。

### 设置镜像库

1、更新 apt 包索引

```bash
$ sudo apt update
```

2、安装必要的软件

```bash
$ sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

3、添加 Docker 的官方 GPG 密钥

```bash
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

4、使用以下命令设置 **stable** 镜像库。要添加 **nightly** 或 **test** 的镜像库，请在以下命令中的单词 stable 之后添加单词 nightly 或 test。

```bash
$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```



### 安装 Docker

1、更新 apt 包索引

```bash
$ sudo apt update
```

2、安装最新版本的 docker，或者转到下一步安装特定版本

```bash
$ sudo apt-get install docker-ce docker-ce-cli containerd.io
```

> 如果启用了多个 Docker 镜像库，则在 `apt install` 或 `apt update` 命令中未指定版本的情况下将始终安装尽可能高的版本，这可能不适合稳定性需求。

3、要安装特定版本的 Docker ，需要列出可用版本，然后选择并安装

查询可用版本

```bash
$ apt-cache madison docker-ce

 docker-ce | 5:20.10.12~3-0~ubuntu-focal | https://download.docker.com/linux/ubuntu focal/stable amd64 Packages
 docker-ce | 5:20.10.11~3-0~ubuntu-focal | https://download.docker.com/linux/ubuntu focal/stable amd64 Packages
 docker-ce | 5:20.10.10~3-0~ubuntu-focal | https://download.docker.com/linux/ubuntu focal/stable amd64 Packages
```

使用第二列中的版本字符串安装特定版本，例如 `5:20.10.10~3-0~ubuntu-focal`

```bash
$ sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
```

### 验证测试

尝试拉取 `hello-world` 镜像，验证 Docker Engine 是否安装成功：

```bash
$ sudo docker image pull hello-world
$ sudo docker run hello-world
```

hello-world 是一个专门用于测试的 docker 镜像，第一次运行该命令会先拉取镜像，然后在终端打印如下内容。

```bash
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```



## 添加 docker 用户组

安装完 docker 之后，非 root 用户需要在命令前添加 sudo 才能执行 docker 命令。解决这个问题的办法是将当前用户添加到 docker 用户组，步骤如下。

1. 创建 docker 用户组（通常在安装时已经创建了）

   ```bash
   sudo groupadd docker
   ```

2. 将当前用户添加到 docker 用户组

   ```bash
   sudo usermod -aG docker ${USER}
   ```

3. 重启 docker 服务

   ```bash
   sudo systemctl restart docker
   ```

4. 重新登录用户账号（或者重启系统）

   ```bash
   su root          # 切换到root用户
   su ${USER}       # 再切换到原来的应用用户以上配置才生效
   ```





