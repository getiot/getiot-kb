---
sidebar_position: 19
sidebar_label: Caddy
slug: /caddy
---

# Caddy：把 HTTPS 变成默认选项的现代 Web 服务器

![](https://static.getiot.tech/caddy-reverse-proxy.webp)

## Caddy 是什么？

**Caddy** 是一个现代化的 Web 服务器、反向代理和自动 HTTPS 平台。如果只用一句话来形容 —— **Caddy 是“把 HTTPS 当成默认行为”的 Web 服务器。**

和 Nginx、Apache 不同，Caddy 从诞生之初就围绕一个核心理念设计：**安全应该是默认的，而不是额外配置的。**

因此，使用 Caddy，你甚至可以在几乎零配置的情况下，直接上线一个带 HTTPS 的网站。



## Caddy 解决了什么问题？

在传统 Web 服务器时代，一个“最小可用上线流程”通常是：

1. 写服务器配置文件
2. 配域名
3. 申请证书（Let’s Encrypt / 其他 CA）
4. 配 HTTPS
5. 设置自动续期
6. 确保重启不翻车

这些步骤对新手不友好，对独立开发者也很耗精力。

**Caddy 的目标很明确：**

- ❌ 不让你纠结 HTTPS
- ❌ 不让你写冗长配置
- ❌ 不让你维护证书脚本
- ✅ 专注写业务



## Caddy 的主要特性

### 自动 HTTPS（Auto HTTPS）

自动 HTTPS 是 Caddy 的招牌能力。你只需要将你的域名（如 `example.com`）指向了服务器 IP 地址，Caddy 会自动完成：

- 申请证书
- 配置 HTTPS
- 自动续期
- 安全加固（合理的 TLS 默认值）

你不需要显式配置 Let’s Encrypt，甚至不需要知道 ACME 的细节。因为，在 Caddy 的世界里：**HTTP 是“例外”，HTTPS 是“常态”。**



### 极简但强大的 Caddyfile

Caddy 使用一种非常直观的配置文件格式：**`Caddyfile`**。

示例：

```nginx showLineNumbers
example.com {
    root * /var/www/html
    file_server
}
```

就这么几行，你已经拥有了：

- HTTPS 网站
- 静态文件服务
- 自动证书

相比之下，Nginx 的等价配置往往要长得多。



### 内置反向代理能力

Caddy 可不仅仅是静态服务器哦，它还是一个完整的**反向代理**：

```nginx showLineNumbers
example.com {
    reverse_proxy localhost:3000
}
```

常见用途包括：

- Web API 反向代理
- 前后端分离项目
- 单体服务的统一入口



### 模块化架构（Plugins）

Caddy 采用模块化设计：

- 核心功能精简
- 高级功能通过模块扩展
- 可以定制自己的 Caddy 构建版本

这让它在保持“简单”的同时，又不失扩展能力。



### 现代协议支持

Caddy 原生支持：

- HTTP/2
- HTTP/3（QUIC）
- WebSocket
- TLS 1.3

而且这些通常是**默认开启**的，而不是“高级选项”。



## Caddy 的典型使用场景

**① 个人网站 / 技术博客**：这类型网站是 Caddy 的“主场”，只需要简单的配置，几乎零运维负担，非常适合独立开发者、个人站长。

**② 小型后端服务 / API**：对于单体应用、少量微服务、简单反向代理需求，Caddy 的反向代理能力足够用，而且非常省心。

**⚠️ 不太适合的场景**：

- 大规模复杂微服务（Traefik / Envoy 更合适）
- 需要深度 Lua/脚本定制（OpenResty 更强）
- 已经有成熟 Nginx 运维体系的大型团队



## Caddy、Traefik、Nginx 快速对比

|      对比项       |     Caddy     |     Traefik     | Nginx / OpenResty |
| :---------------: | :-----------: | :-------------: | :---------------: |
|     核心定位      |  Web 服务器   | 云原生反向代理  |   通用反向代理    |
|    HTTPS 体验     | ⭐⭐⭐⭐⭐（自动） |      ⭐⭐⭐⭐       |        ⭐⭐         |
|    配置复杂度     |     极低      |       低        |      中～高       |
|     服务发现      |       ❌       |        ✅        |         ❌         |
| Docker/K8s 友好度 |      ⭐⭐⭐      |      ⭐⭐⭐⭐⭐      |        ⭐⭐         |
|     适合人群      |  独立开发者   | 小团队 / 云原生 | 传统 Web / 高定制 |

一个非常实用的选择建议：

- 个人网站 / 简单 API → Caddy
- Docker / 微服务 → Traefik
- 高性能 / 深度定制 → OpenResty



## 相关链接

- [Caddy 官方网站](https://caddyserver.com)
- [Caddy 文档中心](https://caddyserver.com/docs/)
- [Caddy GitHub 仓库](https://github.com/caddyserver/caddy)

