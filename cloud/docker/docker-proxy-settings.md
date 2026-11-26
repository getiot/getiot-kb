---
sidebar_position: 4
slug: /docker-proxy-settings
---

# Docker 设置网络代理

在中国大陆即使设置了加速器（镜像源），也可能访问不了某些国外资源（如 Docker 官方 Registry）。此时可以通过配置 Docker 的网络代理来解决。



## 设置 HTTP/HTTPS 代理

#### 1. 创建配置文件

编辑 systemd 的 Docker 配置文件：

```bash
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo vi /etc/systemd/system/docker.service.d/http-proxy.conf
```

内容如下（替换为你自己的代理地址）：

```ini showLineNumbers
[Service]
Environment="HTTP_PROXY=http://127.0.0.1:7890"
Environment="HTTPS_PROXY=http://127.0.0.1:7890"
Environment="NO_PROXY=localhost,127.0.0.1"
```

#### 2. 重载配置并重启 Docker

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart docker
```

#### 3. 验证是否配置成功

```bash
docker info | grep -i proxy
```

或者验证环境变量：

```bash
sudo systemctl show --property=Environment docker
```

看到类似输出说明配置成功：

```bash
Environment=HTTP_PROXY=http://127.0.0.1:7890 HTTPS_PROXY=http://127.0.0.1:7890 NO_PROXY=localhost,127.0.0.1,::1
```



## 为构建阶段单独设置代理

如果你使用 `docker build` 构建镜像时也需要访问外网，可以在 `Dockerfile` 中传递构建参数：

```bash
docker build \
  --build-arg HTTP_PROXY=http://127.0.0.1:7890 \
  --build-arg HTTPS_PROXY=http://127.0.0.1:7890 \
  .
```

**💡 提示：**

- 使用 Clash、V2Ray 等工具时，代理端口一般是 7890（HTTP）或 1080（SOCKS5）；
- 若 Docker 使用 SOCKS5 代理，需要使用 [proxychains](https://github.com/rofl0r/proxychains-ng) 或将其转为 HTTP 代理。
