---
sidebar_position: 7
slug: /docker-compose
---

# Docker Compose 安装和使用

![](https://static.getiot.tech/docker-compose-banner.png#center)

Docker Compose 是 Docker 官方开源的容器编排（Orchestration）项目之一，用于快速部署分布式应用。本文将介绍 Docker Compose 的基本概念、安装流程，并通过一个完整示例演示如何使用。



## 简介

Compose 项目是 Docker 官方的开源项目，负责实现对 Docker 容器集群的快速编排。从功能上看，Docker Compose 和 OpenStack 中的 Heat 十分类似。

我们知道，使用 Dockerfile 模板文件可以让用户很方便的定义一个单独的应用容器。然而，在实践过程中，我们经常会遇到需要多个容器相互配合来完成某项任务的情况。例如要实现一个 Web 项目，除了 Web 服务容器本身，往往还需要再加上后端的数据库服务容器，甚至还包括负载均衡容器等。Compose 就是为了满足这样的需求而出现的。

Docker Compose 允许用户通过一个单独的 `docker-compose.yml` 模板文件（YAML 格式）来定义一组相关联的应用容器为一个项目（project）。这里有两个重要的概念 —— 服务和项目。

- 服务（service）：是指一个应用的容器，实际上可以包括若干运行相同镜像的容器实例。
- 项目（project）：是指由一组关联的应用容器组成的一个完整业务单元，在 `docker-compose.yml` 文件中定义。

其中，项目是 Compose 默认的管理对象，可通过子命令对项目中的一组容器进行生命周期管理。

:::tip

Compose 项目最早由 Python 编写，实现上调用了 Docker 服务提供的 API 来对容器进行管理。因此，只要所操作的平台支持 Docker API，就可以在其上利用 Compose 来进行编排管理。

后来 Docker 官方用 Go 语言重写了 Docker Compose，称为 `Compose V2`。并将其作为了 docker cli 的子命令，所以 V1 和 V2 版本的命令有一些区别（你需要将 `docker-compose` 命令替换为 `docker compose`）。

:::



## 安装

如果你在 Windows 或 Mac 上使用 [Docker Desktop](https://www.docker.com/products/docker-desktop)，则已经包含了 docker-compose，可以直接使用。如果你使用的是 Linux，则需要单独安装。下面以 Ubuntu 20.04 为例，介绍如何在 Linux 系统中安装 docker-compose。

首先，在 Compose 仓库的 [releases 页面](https://github.com/docker/compose/releases) 下载你的目标平台最新的 docker-compose 软件包，我们这里下载的是 `docker-compose-linux-x86_64`。

然后，将其复制/移动到系统安装目录（例如 `/usr/local/bin`）：

```bash
$ sudo mv ~/Downloads/docker-compose-linux-x86_64 /usr/local/bin/docker-compose
```

写这篇文章时最新的版本是 `2.26.1`，你可以通过下面命令一键下载并将其安装到系统目录：

```bash
$ sudo curl -L "https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-linux-$(uname -m)" -o /usr/local/bin/docker-compose
```

接着，你需要给 `docker-compose` 添加可执行权限，命令如下：

```bash
$ sudo chmod +x /usr/local/bin/docker-compose
```

完成后可通过 `docker-compose --version` 检查其版本信息，确认安装是否成功。

```bash
$ docker-compose --version
Docker Compose version v2.26.1
```

这样，docker-compose 就已经安装好了！



## 使用

下面通过一个实例来演示如何使用 Docker Compose 来快速启动一个项目。

### 创建 docker-compose.yml 文件

使用 Docker Compose 来启动项目的关键在于设置 `docker-compose.yml` 文件。为了更好地演示如何创建并设置 `docker-compose.yml`，我们将通过创建一个简单的 Web 服务来进行。在这是示例中，我们将使用 Docker Hub 上的 [Nginx 镜像](https://hub.docker.com/_/nginx)。

首先，在你的工作区创建一个新目录，例如 compose-demo，然后切换到该目录：

```bash
mkdir ~/compose-demo
cd ~/compose-demo
```

在此目录下，创建一个 app 目录作为 Nginx 的文件根目录：

```bash
mkdir app
```

使用你喜欢的文本编辑器，在 app 文件夹中创建一个 index.html 文件：

```bash
vim app/index.html
```

将以下内容复制到该文件中：

```bash showLineNumbers title="~/compose-demo/app/index.html"
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Docker Compose Demo</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/kognise/water.css@latest/dist/dark.min.css">
</head>
<body>

    <h1>This is a Docker Compose Demo Page.</h1>
    <p>This content is being served by an Nginx container.</p>
    <p>Powered by <a href="https://getiot.tech">GetIot.tech</a>.</p>

</body>
</html>
```

编辑完成后保存并关闭文件。

接着，在 compose-demo 目录创建一个 `docker-compose.yml` 文件：

```bash
vim docker-compose.yml
```

将以下内容复制到 `docker-compose.yml` 文件中：

```bash showLineNumbers title="docker-compose.yml"
version: '3.7'
services:
  web:
    image: nginx:alpine
    ports:
      - "8000:80"
    volumes:
      - ./app:/usr/share/nginx/html
```

docker-compose.yml 文件通常以 `version` 定义开始，目的是告诉 Docker Compose 你正在使用哪个配置版本。

然后，在 `services` 块设置属于此环境的服务。就这个示例来说，有一个名为 `web` 的服务。该服务使用 `nginx:alpine` 镜像，并使用 `ports` 指令设置端口重定向。主机机器（运行 Docker Compose 的系统）的端口 `8000` 上的所有请求都将被重定向到端口 `80` 上的 `web` 容器，Nginx 将在其中运行。

`volumes` 指令将在主机和容器之间创建一个[共享卷](https://docs.docker.com/compose/compose-file/#volumes)（shared volume）。这将与容器共享本地 `app` 文件夹，并且该卷将位于容器内的 `/usr/share/nginx/html`，然后它将覆盖 Nginx 的默认文档根目录。

设置完成后，保存并关闭该文件。

现在，你已经设置了一个演示页面和一个 `docker-compose.yml` 文件来创建为其提供服务的容器化 Web 服务器环境。 接下来，你将使用 Docker Compose 启动此环境。



### 运行 Docker Compose

准备好 docker-compose.yml 文件后，你就可以执行 Docker Compose 来启动它了。在 compose-demo 目录执行下面命令，将下载必要的 Docker 镜像、创建容器，并在后台模式下运行容器化环境。

```bash
docker-compose up -d
```

Docker Compose 将首先在本地系统上查找定义的 `nginx:alpine` 镜像，如果找不到该镜像，它将从 Docker Hub 下载该镜像。因此你会看到这样的打印信息：

```bash
[+] Running 9/9
 ✔ web Pulled                                                             32.4s 
   ✔ 4abcf2066143 Already exists                                          0.0s 
   ✔ 49890e937b90 Pull complete                                           4.6s 
   ✔ c4d1f9351edb Pull complete                                           2.4s 
   ✔ 20251c300f57 Pull complete                                           2.6s 
   ✔ c0bc9bec79d1 Pull complete                                           4.2s 
   ✔ 7e9a094d2fe0 Pull complete                                           4.1s 
   ✔ ce2fb8c57dca Pull complete                                           6.5s 
   ✔ e979eecfde62 Pull complete                                           23.4s 
[+] Running 2/2
 ✔ Network compose-demo_default  Created                                  0.0s 
 ✔ Container compose-demo-web-1  Started                                  0.3s
```

你的环境现已启动并在后台运行。你可以通过 `docker-compose ps` 命令验证容器是否处于活动状态，如下所示。

```bash
$ docker-compose ps
NAME                 IMAGE          COMMAND                   SERVICE   CREATED         STATUS         PORTS
compose-demo-web-1   nginx:alpine   "/docker-entrypoint.…"   web       3 minutes ago   Up 3 minutes   0.0.0.0:8000->80/tcp, :::8000->80/tcp
```

如果你在本地计算机上运行该实例，那么在浏览器输入 http://localhost:8000 即可访问演示应用程序。如果你在远程服务器上运行，则输入需要输入远程服务器的 IP 或域名，如 `your_server_domain_or_IP:8000` 来访问。

你将会看到如下网页内容：

![](https://static.getiot.tech/compose-demo-web-screenshot.png#center)

由于我们设置了共享卷，因此你对 app/index.html 文件的任何更改都会被同步到 Docker 容器，你可以自行尝试修改。



## 容器管理

前面已经学习了如何设置 docker-compose.yml 文件，并使用 `docker-compose up` 命令启动你的环境。那在启动之后，我们还需要了解如何使用 Docker Compose 命令管理容器化环境，这样形成一个闭环。

要检查 Nginx 容器生成的日志，可以使用 `logs` 子命令：

```bash
docker-compose logs
```

你会看到类似下面的打印信息：

```bash
web-1  | /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
web-1  | /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
web-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
web-1  | 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
web-1  | 10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
web-1  | /docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
web-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
web-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
web-1  | /docker-entrypoint.sh: Configuration complete; ready for start up
web-1  | 2024/04/20 08:53:09 [notice] 1#1: using the "epoll" event method
web-1  | 2024/04/20 08:53:09 [notice] 1#1: nginx/1.25.5
web-1  | 2024/04/20 08:53:09 [notice] 1#1: built by gcc 13.2.1 20231014 (Alpine 13.2.1_git20231014) 
web-1  | 2024/04/20 08:53:09 [notice] 1#1: OS: Linux 5.15.0-102-generic
web-1  | 2024/04/20 08:53:09 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
web-1  | 2024/04/20 08:53:09 [notice] 1#1: start worker processes
web-1  | 2024/04/20 08:53:09 [notice] 1#1: start worker process 30
web-1  | 2024/04/20 08:53:09 [notice] 1#1: start worker process 31
```

如果你想暂停环境执行，但不更改容器的当前状态，那么可以使用 `pause` 子命令：

```bash
docker-compose pause
```

如果想要在暂停后恢复执行，可以使用 `unpause` 子命令：

```bash
docker-compose unpause
```

`stop` 子命令用于终止容器执行，但它不会破坏与容器关联的任何数据：

```bash
docker-compose stop
```

如果要删除与此容器化环境关联的容器、网络和卷，可以使用 `down` 子命令：

```bash
docker-compose down
```

注意：`down` 命令不会删除 Docker Compose 用于启动你的环境的基础镜像（示例中为 `nginx:alpine`）。因此，当你再次执行 `docker-compose up` 启动环境时，启动过程会比第一次要快得多，因为镜像已经在你的系统上。

如果你还想从系统中删除基础镜像，那么可以使用下面命令：

```bash
docker image rm nginx:alpine
```



## 资源链接

- [Docker Compose GitHub 仓库](https://github.com/docker/compose)
- [Docker Hub 网站](https://hub.docker.com)

