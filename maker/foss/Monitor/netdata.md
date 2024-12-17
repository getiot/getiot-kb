---
sidebar_position: 3
slug: /netdata
---

# Netdata 性能实时监控工具



## 简介

Netdata 是一款 Linux 系统性能实时监控工具。是一个高度优化的 Linux 守护进程，可以对 Linux 系统、应用程序（包括但不限于 Web 服务器、数据库等）以及 SNMP 服务等提供实时的性能监控。

Netdata 用可视化的手段，将其被监控的信息展现出来，以便你清楚的了解到你的系统、程序、应用的实时运行状态，而且还可以与 Prometheus，Graphite，OpenTSDB，Kafka，Grafana 等相集成。

Netdata 是免费的开源软件，目前可在 Linux，FreeBSD 和 macOS 以及从它们衍生的其他系统（例如 Kubernetes 和 Docker）上运行。

![](https://static.getiot.tech/netdata-logo.png#center-400)

- GitHub 仓库：[https://github.com/netdata/netdata](https://github.com/netdata/netdata)
- Netdata 官网：[https://www.netdata.cloud](https://www.netdata.cloud)



### Netdata 特性

1. 友好、美观的可视化界面
2. 可自定义的控制界面
3. 安装快速且高效
4. 配置简单，甚至可零配置
5. 零依赖
6. 可扩展，自带插件 API
7. 支持多个系统平台



### Netdata 工作原理

Netdata 是一个高效，高度模块化的指标管理引擎。它的无锁设计使其非常适合对指标（度量标准）进行并发操作。Netdata 可以收集来自 200 多种流行服务和应用程序的指标，以及数十种与系统相关的指标，例如 CPU、内存、磁盘、文件系统、网络等。

Netdata 的大致工作流程如下图所示。

![](https://static.getiot.tech/netdata-how-it-works.png#center)



## 安装

### 自动化脚本安装

使用官方提供的安装脚本进行安装。

```shell
bash <(curl -Ss https://my-netdata.io/kickstart.sh)
```

该脚本可接收一些选项参数，例如 `--no-updates` 表示不启用自动更新（若不指定该参数，默认启用自动更新浏览器），`--stable-channel` 表示指定安装稳定版（若不指定该参数，默认安装最新版 bash）。例如：

```shell
bash <(curl -Ss https://my-netdata.io/kickstart.sh) --no-updates --stable-channel
```

执行上述命令，当看到如下提示表明安装成功。

```shell
 --- We are done! --- 

  ^
  |.-.   .-.   .-.   .-.   .-.   .  netdata                          .-.   .-
  |   '-'   '-'   '-'   '-'   '-'   is installed and running now!  -'   '-'  
  +----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+--->

  enjoy real-time performance and health monitoring...

 OK  
```

Netdata 的默认安装位置如下：

```shell
   - the daemon     at /usr/sbin/netdata
   - config files   in /etc/netdata
   - web files      in /usr/share/netdata
   - plugins        in /usr/libexec/netdata
   - cache files    in /var/cache/netdata
   - db files       in /var/lib/netdata
   - log files      in /var/log/netdata
   - pid file       at /var/run/netdata.pid
   - logrotate file at /etc/logrotate.d/netdata
```

检查 netdata 版本：

```shell
$ netdata -v
netdata v1.31.0-44-nightly
```



### Docker 安装

在 Docker 中运行 Netdata 的局限性，由于与宿主机环境隔离，在容器中运行 Netdata 可能会限制一部分功能。某些数据（例如主机 OS 的性能或状态）无法像在主机上直接运行 Netdata 那样访问或获取信息不够详细。

解决此问题的一种方法是向 Docker 容器提供特殊的挂载，以便代理可以查看宿主机内 OS 信息，例如 `/sys`、`/proc` 和 `/etc` 等文件夹。通过使用 `ENTRYPOINT` 指令而不是 `COMMAND` 指令启动 Docker 映像，并根据具体程序或服务调整启动脚本。

具体安装步骤：

- 获取镜像

  ```shell
  docker pull netdata/netdata:latest
  ```

- 启动容器

  ```shell
  docker run -d --name=netdata \
    -p 19999:19999 \
    -v $(pwd)/netdataconfig/netdata:/etc/netdata:ro \
    -v netdatalib:/var/lib/netdata \
    -v netdatacache:/var/cache/netdata \
    -v /etc/passwd:/host/etc/passwd:ro \
    -v /etc/group:/host/etc/group:ro \
    -v /proc:/host/proc:ro \
    -v /sys:/host/sys:ro \
    -v /etc/os-release:/host/etc/os-release:ro \
    --restart unless-stopped \
    --cap-add SYS_PTRACE \
    --security-opt apparmor=unconfined \
    netdata/netdata
  ```

  docker-compose.yml 配置文件如下：

  ```shell
  version: '3'
    services:
      netdata:
        image: netdata/netdata
        container_name: netdata
        hostname: example.com # 配置为主机的域名
        ports: 
          - 19999:19999
        restart: unless-stopped
        cap_add: 
          - SYS_PTRACE
        security_opt:
          - apparmor:unconfined
        volumes:
          - ./netdataconfig/netdata:/etc/netdata:ro
          - netdatalib:/var/lib/netdata
          - netdatacache:/var/cache/netdata
          - /etc/passwd:/host/etc/passwd:ro
          - /etc/group:/host/etc/group:ro
          - /proc:/host/proc:ro - /sys:/host/sys:ro
          - /etc/os-release:/host/etc/os-release:ro
  volumes:
    netdataconfig:
    netdatalib:
    netdatacache:
  ```

- 配置容器

  ```shell
  docker exec -it netdata bash
  cd /etc/netdata
  ./edit-config netdata.conf
  ```

  配置完成后需重启容器。

提示：由于 docker 挂载宿主机较为复杂，建议使用自动安装。



## 演示

Netdata 默认会监听主机全部 IP 的 19999 端口，例如在本机浏览器输入 `http://localhost:19999`，即可看到如下监控界面。

![](https://static.getiot.tech/netdata-interface-preview.gif#center)

Netdata 支持数百种集成监控，集合可以监控每个系统和应用程序，查看实时指标。点击此处可查看[所有支持项目](https://www.netdata.cloud/integrations/)。

可以通过如下命令，启用或禁用 netdata 服务：

- 启用

  ```shell
  systemctl start netdata
  ```

- 禁用

  ```shell
  systemctl stop netdata
  ```





## 参考

- [在树莓派4B上安装监控面板Netdata | 自由ネコ (jiyuuneko.com)](https://www.jiyuuneko.com/archives/3085)
- [Netdata 新一代实时监控系统（2） - 尚码园 (shangmayuan.com)](https://www.shangmayuan.com/a/d8330229d4334d918a318a29.html)

