---
sidebar_position: 16
---

# Ubuntu 安装 Jperf 工具



本文主要介绍如何在 Ubuntu 上安装 Jperf 工具。实际上，Jperf 是 iPerf 命令行图形化的 Java 程序，因此我们需要先安装 iperf 工具。

```bash
sudo apt install iperf
```

由于 Jperf 依赖 Java（1.5 及以上版本），所以在安装 Jperf 之前，我们还需要确保 Ubuntu 系统已经安装好了 Java 环境。你可以通过以下命令来检查是否满足要求：

```bash
$ java -version
openjdk version "11.0.13" 2021-10-19
OpenJDK Runtime Environment (build 11.0.13+8-Ubuntu-0ubuntu1.20.04)
OpenJDK 64-Bit Server VM (build 11.0.13+8-Ubuntu-0ubuntu1.20.04, mixed mode, sharing)
```

如果满足 Java 环境的要求，接下来我们就可以在 [xjperf Google CodePage](https://code.google.com/p/xjperf/downloads/list) 下载当前最新的 *jperf-2.0.2.zip* 安装包。

![Ubuntu 安装 Jperf 工具](https://static.getiot.tech/xjperf-Google-CodePage.png#center)

打开 Shell 终端，切换到 jperf-2.0.2.zip 文件所在目录，解压缩：

```bash
unzip jperf-2.0.2.zip
```

进入 jperf-2.0.2 目录

```bash
cd jperf-2.0.2/
```

为脚本添加执行权限

```bash
chmod +x jperf.sh
```

执行脚本

```bash
./jperf.sh
```

这样，我们就启动 Jperf 工具！

![Ubuntu 运行 Jperf 工具](https://static.getiot.tech/Jperf-on-Ubuntu.png#center)





