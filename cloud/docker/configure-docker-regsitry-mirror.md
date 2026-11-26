---
sidebar_position: 3
slug: /configure-docker-regsitry-mirror
---

# Docker 修改镜像源

在中国大陆使用 Docker 时，访问 Docker Hub 镜像仓库常常会遇到连接超时或速度极慢的问题。为了解决这个问题，我们可以配置 Docker 使用国内镜像加速器。



## 常用国内镜像源

| 镜像服务提供商 | 加速地址                                |
| -------------- | --------------------------------------- |
| 阿里云         | `https://{your-id}.mirror.aliyuncs.com` |
| 网易云         | `https://hub-mirror.c.163.com`          |
| 腾讯云         | `https://mirror.ccs.tencentyun.com`     |
| 中科大         | `https://docker.mirrors.ustc.edu.cn`    |

👉 推荐使用阿里云，登录后可以在 阿里云镜像加速页面 获取专属地址。（参考 [https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors)）

:::warning

⛔ 由于监管要求，国内很多 Docker Hub 镜像源被关停（包括上述镜像源），因此出现大面积 Docker 镜像拉取失败的问题！

报错如下：（不是镜像源配置没生效，而是镜像源不提供服务了 💥）

```bash
Error response from daemon: Get "https://registry-1.docker.io/v2/": context deadline exceeded (Client.Timeout exceeded while awaiting headers)
```

下面是几个经测试还可以使用的镜像源：

- `https://docker.m.daocloud.io`
- `https://docker.xuanyuan.me`
- `https://docker.1ms.run`

:::



## 配置镜像源

#### Linux/macOS：

编辑 Docker 配置文件（没有则创建）：

```bash
sudo vi /etc/docker/daemon.json
```

加入如下内容（根据需要添加，可以添加多个）：

```json showLineNumbers title="/etc/docker/daemon.json"
{
  "registry-mirrors": [
    "https://docker.mirrors.ustc.edu.cn",
    "https://hub-mirror.c.163.com",
    "registry.docker-cn.com"
  ]
}
```

然后重启 Docker 服务：

```bash
# 重新加载配置文件
sudo systemctl daemon-reexec
# 或
sudo systemctl daemon-reload

# 重启 docker  服务
sudo systemctl restart docker
```

#### Windows：

在 Docker Desktop 设置界面中，找到 “Daemon” 或 “Docker Engine” 选项，添加 `"registry-mirrors"` 配置即可。



## 验证是否生效

重启 Docker 服务后，执行下面命令可以验证配置是否生效：

```bash
docker info | grep -i mirror
```

出现 mirror URL 表示配置成功，例如：

```bash
$ docker info | grep -i mirror
 Registry Mirrors:
  https://docker.mirrors.ustc.edu.cn/
  https://hub-mirror.c.163.com/
```

⚠️ 不过需要注意，上述方法只能**验证配置项是否生效**（是否写入 Docker 配置中），但**不能验证加速器实际是否可用或稳定**。

如果需要验证镜像源是否真正有效，可以拉取一个 Docker 镜像进行测试，例如：

```bash
docker pull busybox
```

拉取时观察下载速度是否明显提升，是否有如下特征：

- 输出中的镜像来源显示为镜像加速器（例如网易云、中科大等）；
- 下载过程快，无超时或断连。

验证完成后，可以通过以下命令删除测试镜像：

```bash
docker rmi busybox
```

如果该镜像已经被容器使用，会提示错误，你可以通过 `-f` 强制删除：

```bash
docker rmi -f busybox
```

