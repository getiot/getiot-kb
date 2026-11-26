---
sidebar_position: 1
slug: /docker-intro
---

# Docker 简介

![Docker 教程](https://static.getiot.tech/docker-logo-2015-2017.png#center-600)

Docker 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的镜像中，然后发布到任何流行的 Linux 机器上。使用 Docker 可以让每个应用彼此相互隔离，在同一台机器上同时运行多个容器，他们彼此之间共享同一个操作系统。



## Docker 的优势

Docker 的优势在于，它可以在更细的粒度上进行资源的管理，比虚拟化技术性能更高，更加节约资源。下面是普通虚拟化技术和 Docker 的对比。

<img src="https://static.getiot.tech/docker-vs-vm.png" alt="Docker 的优势" width="600" />



## 核心概念

Docker 有 3 个核心概念，即镜像（images）、容器（containers）、仓库（repository）。

### 镜像

Docker 镜像是 Docker 容器运行时的只读模板，每一个镜像由一系列的层（layers）组成。我们可以把 Image 理解成 Windows 系统安装光盘，你不能对安装盘进行操作因为是只读的，只有安装好系统后才能保存和操作数据。

### 容器

容器是 Image 的一个实例，类似于面向对象编程中 new 一个实例的概念。容器类似于一个轻量级的沙盒，Docker 利用容器来运行和隔离应用。容器从 Image 启动时，Docker 会在镜像的最上层创建一个可写层，镜像本身保持不变。 

### 仓库

Docker 仓库是存放镜像的地方。不要把 Docker 的仓库和注册服务器 Registry 混淆。注册服务器是存放仓库的地方，每个仓库存放某一类不同标签 Tag 的镜像。

三者的关系如下图所示。

![Docker 三大核心概念](https://static.getiot.tech/docker-image-container-and-repository.png#center)

Docker 仓库也有公有和私有的概念。公有的 Docker 仓库名字是 Docker Hub。Docker Hub 提供了庞大的镜像集合供使用。这些镜像可以是自己创建，或者在别人的镜像基础上创建。如果你的镜像为私有镜像，不想发到公网上，可以自己在本地创建一个私有的镜像仓库。



## 相关链接

- 官方网址：[docker.com](https://www.docker.com)
- Docker Hub：[hub.docker.com](https://hub.docker.com/)

