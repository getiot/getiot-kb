---
sidebar_label: ethr 命令
sidebar_position: 34
slug: /ethr
---

# Linux ethr 命令 - 网络性能测试工具



## 介绍

**Ethr** 是一个用 golang 编写的跨平台网络性能测量工具。该项目的目标是提供本机工具，用于跨多种协议（如 TCP、UDP、HTTP、HTTPS 和跨多个平台）对带宽、连接、数据包、延迟、丢失进行全面的网络性能测量。

Ethr 从现有的开源网络性能工具中获取灵感，并以这些想法为基础。对于带宽测量，它类似于 iPerf3，用于 TCP 和 UDP 流量。iPerf3 有更多选项可用于执行限制测试，更丰富的功能集，而 Ethr 支持多线程，允许它扩展到 1024 甚至更高数量的连接，多个客户端与单个服务器通信等。用于延迟测量，它类似于 Windows 上的 latte 或 Linux 上的 sockperf。

GitHub 地址：[https://github.com/Microsoft/Ethr](https://github.com/Microsoft/Ethr)

**安装**：

有多种方式安装 ethr 工具

- 直接下载安装

  ```bash
  wget https://github.com/microsoft/ethr/releases/latest/download/ethr_linux.zip
  unzip ethr_linux.zip
  ```

  解压缩后将 ethr 放到 `$PATH` 中任一路径即可，比如 /usr/local/bin/ 目录。

- 源码编译安装

  ```bash
  git clone https://github.com/Microsoft/ethr.git
  cd ethr
  go build
  ```

- Docker 镜像安装

  ```bash
  docker build -t microsoft/ethr .
  docker run -e GOOS=linux -v $(pwd):/out microsoft/ethr make build-docker
  ```

- go get 安装

  ```bash
  go get github.com/Microsoft/ethr
  ```



## 示例

查看帮助

```bash
ethr -h
```

启动服务器

```bash
ethr -s
```

启动带文本 UI 的服务器

```bash
ethr -s -ui
```

启动客户端

```bash
ethr -c <server ip>
```

更多示例

```bash
# Start server
ethr -s

# Start client for default (bandwidth) test measurement using 1 thread
ethr -c localhost

# Start bandwidth test using 8 threads
ethr -c localhost -n 8

# Start connections/s test using 64 threads to server 10.1.0.11
ethr -c 10.1.0.11 -t c -n 64

# Run Ethr server on port 9999
ethr -s -port 9999

# Measure TCP connection setup latency to ethr server on port 9999
# Assuming Ethr server is running on server with IP address: 10.1.1.100
ethr -c 10.1.1.100 -p tcp -t pi -d 0 -4 -port 9999

# Measure TCP connection setup latency to www.github.com at port 443
ethr -x www.github.com:443 -p tcp -t pi -d 0 -4

# Measure TCP connection setup latency to www.github.com at port 443
# Note: Here port 443 is driven automatically from https
ethr -x https://www.github.com -p tcp -t pi -d 0 -4

# Measure ICMP ping latency to www.github.com
sudo ethr -x www.github.com -p icmp -t pi -d 0 -4

# Run measurement similar to mtr on Linux
sudo ethr -x www.github.com -p icmp -t mtr -d 0 -4

# Measure packets/s over UDP by sending small 1-byte packets
ethr -c 172.28.192.1 -p udp -t p -d 0
```

