---
sidebar_position: 4
slug: /an-introduction-to-letsencrypt
---

# Let's Encrypt 是什么？它是如何工作的？

![](https://static.getiot.tech/letsencrypt-banner.webp)

**Let’s Encrypt** 是一个开放且自动化的证书颁发机构（Certificate Authority，简称 CA），它使用 **ACME 协议**（Automatic Certificate Management Environment，自动证书管理环境）为兼容的客户端提供免费的 **TLS/SSL** 证书。

这些证书可以用于加密你的 Web 服务器与访问者之间的通信，从而实现 HTTPS。Let’s Encrypt 支持多种客户端工具，由不同的编程语言编写，并且可以与流行的服务、管理工具及服务器集成。

目前最流行的 Let’s Encrypt 客户端是 **Certbot**，它由 **Electronic Frontier Foundation（电子前沿基金会）** 负责开发。Certbot 不仅用于验证域名所有权和获取证书，还可以自动为 Apache 和 Nginx Web 服务器配置 TLS/SSL。



## 证书颁发机构是什么？

**证书颁发机构（CA）** 是一种通过加密签名来证明 TLS/SSL 证书真实性的实体。浏览器和操作系统维护一份受信任的 CA 列表，用来验证网站证书的有效性。

在 Let’s Encrypt 出现之前，大多数 CA 都是商业机构，它们通常对证书服务收费。而 Let’s Encrypt 则是一个非盈利机构，旨在推广 HTTPS 网络安全，它采用完全自动化的流程，并通过赞助和捐助来支持运行成本，因此能够为用户**免费**提供证书。简直是大善人，点赞点赞！



## Let’s Encrypt 的工作原理

Let’s Encrypt 使用的 **ACME 协议** 定义了客户端如何与 Let’s Encrypt 服务器通信来：

1. 请求证书；
2. 验证域名所有权；
3. 下载证书。

Let’s Encrypt 提供的是 **域名验证型证书**，意味着颁发证书前它要确认请求来自真正控制该域名的人。它通过以下方式来实现：

1. 向客户端发放一个唯一令牌（token）；
2. 客户端生成一个公钥，并将验证内容放在它所管理的 Web 服务器上；
3. Let’s Encrypt 的验证服务器访问该文件来检查是否正确；
4. 如果验证通过，就会签署并颁发证书。

ACME 协议定义了多种验证方式，最常用的有：

- **HTTP 验证**：客户端在 Web 服务器上创建一个特定路径的验证文件；
- **DNS 验证**：客户端在 DNS TXT 记录中设置验证内容。



## Certbot 客户端

**Certbot** 是目前最受欢迎的 Let’s Encrypt 客户端程序。它包括在大多数主要 Linux 发行版的软件仓库中，并提供方便的自动配置功能。

要使用 Certbot 获取证书并更新 Apache 配置，只需执行：

```bash
sudo certbot --apache -d www.example.com
```

将进入 Certbot 交互模式：

- 提示你回答一些问题；
- 运行域名验证；
- 下载证书；
- 更新 Web 服务器配置；
- 重新加载服务器。

成功后，你可以通过浏览器访问 `https://www.example.com`，此时浏览器地址栏会显示绿色锁标志，表示连接已加密且证书有效。 

Let’s Encrypt 颁发的证书有效期目前为 **90 天**，从 2028 年开始申请的 Let's Encrypt 证书有效期将缩短一半，从 90 天变为 **45 天**，因此设置自动续订非常重要。可以使用以下命令来续订服务器上的所有证书：

```bash
sudo certbot renew
```

建议将此命令加入到 **crontab（定时任务）** 中每天运行一次，这样证书将在到期前自动续订。对于使用 `--apache` 或 `--nginx` 安装的证书，Certbot 还会在续订 SSL 证书后自动重新加载服务器。不得不说，考虑真周到呀！



## 其他 ACME 客户端

由于 ACME 协议是开放且文档完善的，因此出现了许多替代客户端：

- 不同编程语言实现的客户端（例如 Go、Shell、Node.js 等）；
- 一些客户端可以在 **非 root 权限下** 运行；
- 支持自动通过 DNS API 创建 TXT 记录来完成挑战；
- 有的客户端直接集成到了 Web 服务器或反向代理中，使证书自动获取更简单。

一些受欢迎的 ACME 客户端示例包括：

- **[lego](https://github.com/xenolf/lego)**：用 Go 编写的单文件二进制客户端；
- **[acme.sh](https://github.com/Neilpang/acme.sh)**：使用 shell 脚本实现，可在非特权环境运行；
- **[Caddy](/foss/caddy/)**：一个完整的 Go 语言 Web 服务器，内置 Let’s Encrypt 支持。



## 小结

本文介绍了 Let’s Encrypt 的基本概念及其工作原理，并简要介绍了 Certbot 与其他 ACME 客户端。想要了解如何将 Let’s Encrypt 与特定软件结合使用（例如 Nginx 或 Apache），可以参考 GetIoT.tech 相应的教程示例。

<!--

## 示例

```bash
$ sudo snap install --classic certbot
snap "certbot" is already installed, see 'snap help refresh'

$ which certbot 
/snap/bin/certbot

$ sudo ln -s /snap/bin/certbot /usr/bin/certbot

$ which certbot 
/usr/bin/certbot

$ sudo certbot certonly --standalone
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Enter email address or hit Enter to skip.
 (Enter 'c' to cancel): hi@huggypig.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at:
https://letsencrypt.org/documents/LE-SA-v1.6-August-18-2025.pdf
You must agree in order to register with the ACME server. Do you agree?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: Y

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Would you be willing, once your first certificate is successfully issued, to
share your email address with the Electronic Frontier Foundation, a founding
partner of the Let's Encrypt project and the non-profit organization that
develops Certbot? We'd like to send you email about our work encrypting the web,
EFF news, campaigns, and ways to support digital freedom.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: Y
Account registered.
Please enter the domain name(s) you would like on your certificate (comma and/or
space separated) (Enter 'c' to cancel): vegexplore.com  
Requesting a certificate for vegexplore.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Could not bind TCP port 80 because it is already in use by another process on
this system (such as a web server). Please stop the program in question and then
try again.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(R)etry/(C)ancel: R

Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/vegexplore.com/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/vegexplore.com/privkey.pem
This certificate expires on 2026-03-17.
These files will be updated when the certificate renews.
Certbot has set up a scheduled task to automatically renew this certificate in the background.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
If you like Certbot, please consider supporting our work by:
 * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
 * Donating to EFF:                    https://eff.org/donate-le
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

-->

## 相关链接

- [https://letsencrypt.org/getting-started/](https://letsencrypt.org/getting-started/)
- [https://certbot.eff.org/instructions](https://certbot.eff.org/instructions)
