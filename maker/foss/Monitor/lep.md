---
sidebar_position: 2
slug: /lep
---

# LEP 性能剖析器



## 简介

LEP 的全称是 Linux Easy Profiling（Linux 易用剖析器），核心特点在于 Easy（简单），主要功能在乎 Profiling（剖析）。

LEP 的设计目标是：**便利 Linux 的程序员，以最快最直接的方式，定位到系统里面一些 bug 的源头，以及一些性能瓶颈的原因。**

- LEP 的网址是 [http://www.linuxep.com](http://www.linuxep.com)



### LEP 工作原理

Linux 有很多现成的调试和剖析工具，比如 top、vmstat、iotop、perf、valgrind、powertop、free、pmap、slabtop 等，这些工具通过读取 /proc、/sys，分析硬件的 PMU（Performance Monitor Unit）数据、监控内存的申请释放以及读写等手段，获知单一进程或者系统的运行状态，以及进行故障分析。LEP 除了在功能上是这些工具的超集以外，在可视、交互、深度分析、数据比对、场景贴合等角度对这些工具进行进一步的增强。

LEP 主要分为两部分

- **LEPD** —— 负责监控的服务守护 ：[https://github.com/linuxep/lepd](https://github.com/linuxep/lepd)
- **LEPV** —— Web 后台和前端展示 ：[https://github.com/linuxep/lepv](https://github.com/linuxep/lepv)



### LEP 技术架构

LEP 实际上是一个 all-in-one 的调试工具，它的软件架构如下图所示。与现有其他工具不同，被监控的服务器或开发板只需要部署 LEPD（LEP Daemon），该程序完全用 C 语言实现，只需要完成基本的数据采集功能，因此它能最小化对被监控系统本身的影响。数据的分析和处理，都移动到了 Web 服务 LEPV（LEP Viewer）和浏览器一端。

![](https://static.getiot.tech/lep-architecture.png#center)

LEPD 采集被监控目标的运行数据，这些数据被 Web 服务端 LEPV 通过 JSONRPC 请求获得，LEPV 以 Python 对从 LEPD 获得的原始数据进行有针对性的加工，再发送给浏览器，浏览器把经过 LEPV 加工的数据，以各种丰富的图形进行显示。 

这种架构的好处，LEPD 和 LEPV 分离，使得 LEPD 易于部署在资源贫乏的嵌入式设备上，而 LEPV 一般则运行在比较强壮的 x86 PC 上。当然，LEPD 和 LEPV 虽然分离，但在实际部署的时候，也可以部署于同一个 x86 PC，因此也可以用于非网络环境下的单机自身监控。



### LEP 数据流转

LEP 的数据流程是清晰、简单的。例如，运行于被监控系统的 LEPD 读取 /proc/loadavg 数据，这些数据没有格式，是原始的，类似 "2.58 2.25 2.31 ..."，LEPV 通过 JSONRPC 收到这些数据后，将其进行语义加工为 last1、last5、last15 这种过去 1 分钟、5 分钟、15 分钟系统平均负载，浏览器获取这些数据后，绘制为 3 条生动活泼的动感曲线。

![](https://static.getiot.tech/lep-dataflow.png#center)



## 安装

### 部署 LEPD

获取最新 LEPD 代码

```shell
git clone https://github.com/linuxep/lepd
```

编译

- 对于 x86 平台

  ```shell
  apt-get install libev-dev 
  apt-get install linux-tools-common linux-tools-generic linux-tools-`uname -r`
  apt-get install libncurses5-dev
  make ARCH=x86
  ```

- 对于 ARM 平台

  ```shell
  apt-get install gcc-arm-linux-gnueabi
  make ARCH=arm
  ```

运行

```shell
sudo ./lepd &
```



### 部署 LEPV

获取最新 LEPV 代码

```shell
git clone https://github.com/linuxep/lepv.git
```

运行脚本构建 Docker 镜像

```shell
./buildDockerImage.sh
```

启动 Docker 容器

```shell
./runDockerContainer.sh
```

现在，你可以在浏览器输入 `http://localhost:8889` 查看监控页面。