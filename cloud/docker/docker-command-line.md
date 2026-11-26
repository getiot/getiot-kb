---
sidebar_position: 5
slug: /docker-command-line
---

# Docker 基本命令



本文介绍 Docker 的基本命令，以及 Docker 服务的启动、关闭命令。Docker 命令可根据其三大核心概念进行划分，即镜像（Image）、容器（Container）和仓库（Repository）。



## Docker 服务

查看 Docker 版本信息：

```bash
docker version
```

查看 Docker 简要信息：

```bash
docker -v
```

启动 Docker：

```bash
systemctl start docker
```

关闭 Docker：

```bash
systemctl stop docker
```

设置开机启动：

```bash
systemctl enable docker
```



## 镜像

检索镜像：

```bash
docker search 关键字
```

拉取镜像：

```bash
docker pull [选项] [Docker Registry 地址[:端口号]/]仓库名[:标签]
```

列出镜像：

```bash
docker image ls
docker images     # 等效
```

删除镜像（指定镜像 ID）：

```bash
docker rmi <镜像ID>
```

导出镜像（将镜像保存为归档文件）：

```bash
docker save
```

导入镜像：

```bash
docker load
```

构建镜像（需要 Dockerfile）：

```bash
docker build
```

运行镜像（就是新建并运行一个容器）：

```bash
docker run [镜像ID]
```



## 容器

### 容器声明周期

启动容器有两种方式，一种是基于镜像新建一个容器并启动，另外一个是将在终止状态（stopped）的容器重新启动。

① 新建并启动容器：

```bash
docker run [镜像名/镜像ID]
```

② 启动已终止容器：

```bash
docker start [容器ID]
```

列出本机运行的容器：

```bash
docker ps
```

列出本机所有的容器（包括停止和运行）：

```bash
docker ps -a
```

停止正在运行的容器：

```bash
docker stop [容器ID]
```

杀死容器进程：

```bash
docker kill [容器ID]
```

重启容器：

```bash
docker restart [容器ID]
```

删除容器：

```bash
docker rm [容器ID]
```

清除所有已停止的容器：

```bash
docker container prune
```

如果你想要删除所有容器，不管它们的状态如何（包括运行中和已停止），可以使用以下命令：

```bash
docker rm -f $(docker ps -aq)
```

如果想要在容器退出后自动释放资源，可以在启动 docker 容器时加上 `--rm` 选项：

```bash
docker run --rm [镜像名/镜像ID]
```



### 进入容器

进入容器也有两种方式，一种是从 stdin 进入，另一种是交互式进入。

① 从 stdin 进入容器（如果从该 stdin 中 exit，会导致容器的停止）：

```bash
docker attach [容器ID]
```

② 交互式进入容器：

```bash
docker exec [容器ID]
```

通常使用第二种方式进入容器，`docker exec` 后面跟的常见参数如下：

- `-d, --detach`：在容器中后台执行命令
- `-i, --interactive=true|false`：打开标准输入接受用户输入命令

### 导出和导入

导出容器（导出一个已经创建的容器到一个文件）：

```bash
docker export [容器ID]
```

导入容器（导出的容器快照文件可以再导入为镜像）：

```bash
docker import [路径]
```



## 其他

### 查看信息

`docker info` 命令会列出 Docker 服务相关的配置信息，例如，你可以查看镜像存储位置：

```bash
$ docker info | grep "Docker Root Dir"
 Docker Root Dir: /var/lib/docker
```

### 查看日志

导出的容器快照文件可以再导入为镜像：

```bash
docker logs [容器ID]
```

这个命令有以下常用参数：

- `-f`：跟踪日志输出
- `--since`：显示某个开始时间的所有日志
- `-t`：显示时间戳
- `--tail`：仅列出最新 N 条容器日志

### 复制文件

从主机复制到容器：

```bash
sudo docker cp host_path containerID:container_path
```

从容器复制到主机：

```bash
sudo docker cp containerID:container_path host_path
```

