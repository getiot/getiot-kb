---
sidebar_position: 1
slug: /lua-web-programming
---

# Lua Web 编程

Lua 标准库本身不包含 HTTP server 或 Web 框架。实际做 Web 编程时，你通常会使用宿主环境或第三方框架。最有代表性的方案是 OpenResty，它把 Nginx、LuaJIT 和一组 Lua 库组合在一起，适合高性能网关、API 入口、缓存、鉴权、限流等场景。

这一节不是完整 OpenResty 教程，而是让你知道 Lua 在 Web 场景中怎么工作。

## 常见选择

| 方案 | 适合场景 |
| :--- | :--- |
| OpenResty | 高性能网关、API 层、Nginx 扩展 |
| lapis | 基于 OpenResty 的 Web 框架 |
| Sailor | 传统 MVC 风格 Web 应用 |
| LuaSocket | 学习 HTTP/TCP 基础，不适合生产 Web 服务 |
| 宿主应用内嵌 Lua | 游戏、设备、网关或自研服务中的脚本扩展 |

如果你已经熟悉 Nginx，OpenResty 是最值得优先了解的方向。

## OpenResty 最小示例

下面是一个最小 OpenResty 配置片段：

```nginx title="nginx.conf"
worker_processes  1;

events {
    worker_connections 1024;
}

http {
    server {
        listen 8080;

        location /hello {
            content_by_lua_block {
                ngx.say("Hello, OpenResty")
            }
        }
    }
}
```

启动后访问：

```bash
curl http://127.0.0.1:8080/hello
```

输出：

```text
Hello, OpenResty
```

这里的 `content_by_lua_block` 会在处理请求时执行 Lua 代码，`ngx.say()` 用于返回响应内容。

## 读取请求参数

```nginx title="nginx.conf"
location /echo {
    content_by_lua_block {
        local args = ngx.req.get_uri_args()
        local name = args.name or "Lua"

        ngx.say("Hello, ", name)
    }
}
```

访问：

```bash
curl 'http://127.0.0.1:8080/echo?name=GetIoT'
```

输出：

```text
Hello, GetIoT
```

## 返回 JSON

OpenResty 项目中常用 `cjson` 处理 JSON：

```nginx title="nginx.conf"
location /status {
    content_by_lua_block {
        local cjson = require("cjson.safe")

        ngx.header["Content-Type"] = "application/json"
        ngx.say(cjson.encode({
            ok = true,
            service = "getiot",
        }))
    }
}
```

输出类似：

```json
{"service":"getiot","ok":true}
```

不同 JSON 库对错误处理和编码细节略有差异，生产环境应阅读对应库文档。

## 不要阻塞事件循环

OpenResty 运行在 Nginx 事件模型中。你应该避免在请求处理中执行长时间阻塞操作，例如：

- 长时间 CPU 密集计算。
- 使用阻塞式 socket。
- 在请求路径中执行慢命令。
- 大量同步文件 I/O。

OpenResty 提供了自己的 cosocket、timer、shared dict 等机制来处理常见 Web 网关需求。深入使用时应学习 OpenResty 官方文档。

## 普通 Lua 能不能写 HTTP 服务

可以，但通常用于学习和简单工具。例如使用 LuaSocket 可以写一个非常小的 TCP 服务，但它不适合直接作为生产 Web server。

真实 Web 服务要考虑：

- 并发连接
- 超时
- HTTP 协议细节
- TLS
- 日志
- 进程管理
- 安全边界

这些问题交给 OpenResty、Nginx 或成熟框架更可靠。

## 小结

你需要掌握：

- Lua 标准库不自带 Web 框架。
- OpenResty 是 Lua Web 生态中非常重要的方案。
- `content_by_lua_block` 可以在 Nginx 请求处理阶段执行 Lua。
- Web 场景中要特别注意阻塞操作和安全输入。
- 深入 OpenResty 前，先把 Lua table、函数、模块和错误处理学扎实。
