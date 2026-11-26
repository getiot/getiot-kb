---
sidebar_position: 2
slug: /deploy-answer-https
---

# 如何在 Apache Answer 上使用 HTTPS？

![](https://static.getiot.tech/answer-https.webp#center)

当你在一台服务器上部署完 Answer 后，你会发现你只能使用 HTTP 访问它。然而，如今 HTTPS 已成为互联网标配，要如何才能实现使用 HTTPS 访问 Answer 服务呢？

我发现很多人都有这个问题，部署 Answer 很简单，但使用 HTTPS 部署它有点困难。所以我决定写这篇文章来帮助大家使用 HTTPS 部署 Answer。



## 简单方法

事先说明，使用 HTTPS 部署网站的方法有很多，本教程旨在介绍使用 HTTPS 部署 Answer 的最简单方法 —— **我们将使用 Caddy 来为 Answer 部署 HTTPS**。

[Caddy](/foss/caddy/) 是一个功能强大、企业级、开源的 Web 服务器，使用 Go 语言编写，具有自动 HTTPS 功能。当然，你也可以使用其他工具为 Answer 部署 HTTPS，比如 Nginx 等。



## 准备工作

- 你可以按照安装指南安装 Answer。安装 Answer 后，你可以使用 HTTP 访问它。Answer 的默认端口是 `9080`。你可以在 [http://localhost:9080](http://localhost:9080/) 访问它。在接下来的步骤中，我们将使用 `9080` 作为 Answer 的默认端口。
- 你需要一个 DNS 解析已经配置指向你的服务器的域名（例如 `meta.getiot.tech`）。
- 在本教程中，我们将使用 `docker-compose` 安装 Caddy。因此我们需要 `docker` 和 `docker-compose`。你可以按照[官方指南](https://docs.docker.com/engine/install/)安装 docker 和 docker-compose。



## 部署步骤

### 步骤 1

登录服务器，创建一个工作空间，新建一个 `docker-compose.yml` 文件。

```bash
$ mkdir caddy-docker
$ cd caddy-docker
$ vim docker-compose.yml
```

打开 `docker-compose.yml` 文件，添加以下代码：

```yaml showLineNumbers title="docker-compose.yml"
services:
  caddy:
    image: caddy
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "443:443/udp"
    volumes:
      - ~/.caddy/Caddyfile:/etc/caddy/Caddyfile
      - ~/.caddy/caddy_data:/data
      - ~/.caddy/caddy_config:/config
    network_mode: host
```

### 步骤 2

`Caddyfile` 是 Caddy 的配置文件，用于配置 Caddy 如何提供你的网站服务。我们将该文件放在 `~/.caddy` 隐藏目录下，启动后将被挂载到容器中的 `/etc/caddy/Caddyfile` 位置。

创建项目文件和目录：

```bash
$ mkdir -p ~/.caddy/caddy_data ~/.caddy/caddy_config
$ vim ~/.caddy/Caddyfile
```

打开 `Caddyfile` 文件，添加以下代码：

```nginx showLineNumbers title="Caddyfile"
your.answer.domain {
    reverse_proxy 127.0.0.1:9080
}
```

注意：`your.answer.domain` 需要改成你所使用的域名，例如 `meta.getiot.tech`。

### 步骤 3

先启动 Answer，默认使用 `9080` 端口。然后运行以下命令启动 Caddy：

```bash
$ docker compose -f docker-compose.yml up -d
```

等待几秒钟，然后你就可以使用 HTTPS 访问 Answer 了。（首次启动需要申请 SSL 证书，时间可能长一点）

如果无法访问，你可以检查 Caddy 的日志。

```bash
$ docker compose logs
```



## 同时启动

如果你想同时启动 Answer 和 Caddy，可以将它们放在同一 docker compose 文件中。此时的 `docker-compose.yml` 文件内容如下：

```yaml showLineNumbers title="docker-compose.yml"
services:
  caddy:
    image: caddy
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "443:443/udp"
    volumes:
      - ~/.caddy/Caddyfile:/etc/caddy/Caddyfile
      - ~/.caddy/caddy_data:/data
      - ~/.caddy/caddy_config:/config
    network_mode: host
    depends_on:
      - answer
  answer:
    image: apache/answer
    ports:
      - "9080:80"
    restart: on-failure
    volumes:
      - answer-data:/data

volumes:
  answer-data:
```

`network_mode: host` 表示使用本地网络，因此 `Caddyfile` 还是反向代理到 `9080` 端口即可：

```nginx showLineNumbers title="Caddyfile"
your.answer.domain {
    reverse_proxy 127.0.0.1:9080
}
```

然后运行以下命令启动 Answer 和 Caddy：

```bash
$ docker compose -p answer -f docker-compose.yaml up -d
[+] up 4/4
 ✔ Network answer_default    Created                                                                                                      0.1s 
 ✔ Container answer-answer-1 Created                                                                                                      0.1s 
 ✔ Container answer-caddy-1  Created                                                                                                      0.1s 
 ! caddy                     Published ports are discarded when using host network mode
```

启动信息有一个警告，它表示当使用 `network_mode: host` 时，Docker 会忽略 `ports` 配置中的端口映射设置，因为:

- 在 host 网络模式下，容器直接使用宿主机的网络栈。
- 容器内监听的任何端口都会自动在宿主机上可用。
- 因此 `ports: ["80:80", "443:443"]` 这类映射配置变得多余。



## 高级配置

更安全的做法是使用 Docker 网络模式，而非 host 模式。删除 `docker-compose.yml` 中的 `network_mode: host`，增加一个 `answer-net` 网络，完整代码如下：

```yaml showLineNumbers title="docker-compose.yml"
services:
  caddy:
    image: caddy
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "443:443/udp"
    volumes:
      - ~/.caddy/Caddyfile:/etc/caddy/Caddyfile
      - ~/.caddy/caddy_data:/data
      - ~/.caddy/caddy_config:/config
    depends_on:
      - answer
    networks:
      - answer-net
  answer:
    image: apache/answer
    expose:
      - "80"
    restart: on-failure
    volumes:
      - answer-data:/data
    networks:
      - answer-net

volumes:
  answer-data:

networks:
  answer-net:
    driver: bridge
```

这样 Caddy 和 Answer 可以使用相同的网络。因此，你还需要修改 `Caddyfile` 文件，配置 Caddy 反向代理到 `answer:80`，而不是 `127.0.0.1:9080`。

```nginx showLineNumbers title="Caddyfile"
your.answer.domain {
    reverse_proxy answer:80
}
```

**重要修改说明**

1. 将 `ports: - '9080:80'` 改为 `expose: - '80'`：因为现在是通过 Caddy 代理访问，不需要将 Answer 直接暴露到宿主机端口。
2. 添加了自定义网络 `answer-net`：确保 Caddy 可以通过服务名 `answer` 访问到 Answer 服务。
3. 配置了 `depends_on`：确保先启动 Answer 服务。
4. Caddyfile 配置中使用 `answer:80` 作为反向代理目标：这是 Docker 网络中的服务名称。

现在，运行以下命令启动 Answer 和 Caddy：

```bash
$ docker compose -p answer -f docker-compose.yaml up -d
```

大功告成！



## 小结

本教程介绍如何使用 Caddy 来为 Apache Answer 部署 HTTPS，我们沿用 Answer 推荐的 Docker Compose 方式，逐步讲解并给出完整代码。当然，你也可以使用其他方法安装 Caddy，比如使用二进制文件等。或者使用其他工具为 Answer 部署 HTTPS，比如 Nginx 等，都是可以的。

总而言之，我希望你能按照这篇教程成功使用 HTTPS 部署 Answer。如果你有任何问题，请随时留言提问，我们将尽力帮助你。
