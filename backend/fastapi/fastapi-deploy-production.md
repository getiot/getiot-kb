---
sidebar_position: 17
sidebar_label: FastAPI 项目部署
slug: /fastapi-deploy-production
---

# FastAPI 项目部署与上线

开发完成后，将 FastAPI 项目部署到服务器并对外提供服务是最后一步。本文将介绍几种常见的部署方式，包括使用 **Uvicorn + Gunicorn** 部署到 Linux 服务器、配置 **Nginx 反向代理** 以及启用 **HTTPS（SSL）证书**。你将学会如何将本地开发好的项目稳定、安全地上线运行。



## 部署准备

在部署前，请确保你已经完成以下准备：

- 项目已通过本地测试，结构清晰；
- 拥有一台可用的 Linux 服务器（推荐 Ubuntu 20.04+）；
- 已设置好 Python 虚拟环境；
- 已具备域名和 SSL 证书（建议使用免费的 Let's Encrypt）。



## 安装部署依赖

```bash showLineNumbers
sudo apt update
sudo apt install python3-pip python3-venv nginx -y
```

在你的项目根目录创建虚拟环境并安装依赖：

```bash showLineNumbers
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install fastapi uvicorn[standard] gunicorn
```



## 创建 Gunicorn 启动脚本

新建文件 `start.sh`（可放在根目录）：

```bash showLineNumbers title="start.sh"
#!/bin/bash
source venv/bin/activate
exec gunicorn main:app \
    --workers 4 \
    --worker-class uvicorn.workers.UvicornWorker \
    --bind 127.0.0.1:8000
```

给脚本执行权限：

```bash showLineNumbers
chmod +x start.sh
```

你也可以使用 `systemd` 创建服务，确保项目随系统启动。



## 配置 Nginx 反向代理

编辑 Nginx 配置（路径可能为 `/etc/nginx/sites-available/your-site.conf`）：

```nginx showLineNumbers
server {
    listen 80;
    server_name yourdomain.com;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

启用配置：

```bash showLineNumbers
sudo ln -s /etc/nginx/sites-available/your-site.conf /etc/nginx/sites-enabled/
sudo nginx -t  # 检查语法
sudo systemctl restart nginx
```



## 启用 HTTPS（推荐）

启用 HTTPS 有很多好处，包括提高安全性、保护用户隐私、避免中间人攻击，以及提高 SEO 排名等。现代浏览器强烈要求启用 HTTPS，否则网站会被标记为“不安全”。因此建议你的网站也要启用 HTTPS。

但是启用 HTTPS 需要提前申请一张 SSL 证书，推荐使用 **Certbot** 工具进行 SSL 证书配置和管理。它可以帮你完成以下事情：

- 向 Let's Encrypt 申请一个免费的 SSL 证书；
- 自动配置你的 Nginx（或 Apache）服务器启用 HTTPS；
- 自动续期，防止证书过期（默认 90 天有效）。

具体操作流程如下：

- 安装 Certbot：

  ```bash
  sudo apt install certbot python3-certbot-nginx -y
  ```

- 申请证书并自动配置 HTTPS：

  ```bash
  sudo certbot --nginx
  ```

- 设置自动续期：

  ```bash
  sudo certbot --nginx
  ```

配置过程中，系统会提示你选择域名（已配置到服务器的），并自动修改 Nginx 配置文件。Certbot 配置后的文件位置如下表所示。

| 类型                   | 路径示例                                             |
| ---------------------- | ---------------------------------------------------- |
| 证书文件（.pem）       | `/etc/letsencrypt/live/yourdomain.com/fullchain.pem` |
| 私钥文件               | `/etc/letsencrypt/live/yourdomain.com/privkey.pem`   |
| Nginx 配置（自动改写） | `/etc/nginx/sites-available/yourdomain.com.conf`     |

:::tip

**[Certbot](https://certbot.eff.org)** 是一个由 **EFF**（电子前哨基金会）开发的开源工具，用于自动申请和安装 **Let's Encrypt 免费 SSL 证书**。

[**Let's Encrypt**](https://letsencrypt.org/) 是一个由非营利组织 ISRG 发起的 **免费 SSL 证书颁发机构**，目前已被主流浏览器和操作系统广泛支持。你可以通过 Certbot 快速申请它的证书，无需付费。

:::



## 适合独立开发者的部署方式

|        用途        | 推荐平台                                                     |
| :----------------: | ------------------------------------------------------------ |
|  FastAPI 服务部署  | Railway / Render / Fly.io                                    |
|       数据库       | PostgreSQL（内置于 Render/Railway），或 MongoDB Atlas（云托管） |
|    前端（可选）    | Vercel（React、Next.js 静态站）或 Docusaurus                 |
| 自定义域名 + HTTPS | Railway、Render、Fly.io 等都支持免费 HTTPS                   |

建议：

- **如果你想部署完整项目（后端 + 数据库）**，首选 **Railway** 或 **Render**，界面友好、支持 Git 自动部署、本地调试方便。
- **如果你熟悉 Docker 或希望获得更多控制权**，可以选择 **Fly.io** 或 DigitalOcean。
- **如果只是学习/原型开发**，你也可以从 Replit、Deta Space 开始尝试，免费又简单。
- **如果你使用 Vercel 部署前端（如 React）**，后端 FastAPI 推荐部署在独立平台，然后通过 API 域名连接。



## 推荐部署方式总结

|            方式             |         优点         |       适用场景       |
| :-------------------------: | :------------------: | :------------------: |
|       Uvicorn（开发）       |      轻量、快速      |    本地测试或调试    |
|  Gunicorn + UvicornWorker   |   稳定、支持多进程   |   推荐用于生产环境   |
|      Nginx + Gunicorn       | 支持 HTTPS、静态资源 |   推荐用于正式部署   |
|         Docker 部署         |      可移植性强      | 多人协作、自动化部署 |
| 云平台（如 Vercel、Render） |       快速上线       |    简单项目或 API    |



## 小结

将 FastAPI 项目部署上线需要几个关键步骤：准备 Python 环境、使用 Gunicorn 运行项目、配置 Nginx 反向代理、启用 HTTPS。整个过程不复杂，但建议你一步步操作并测试结果，确保服务稳定可靠。完成部署后，你的 API 就可以安全、稳定地向用户提供服务了。
