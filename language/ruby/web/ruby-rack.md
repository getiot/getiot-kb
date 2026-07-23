---
sidebar_position: 1
sidebar_label: Rack 入门
slug: /ruby-rack
---

# Ruby Rack 入门

Rack 定义了 Ruby Web 应用和 Web Server 之间的接口。很多 Ruby Web 框架都建立在 Rack 之上。

## 最小 Rack 应用

创建 `config.ru`：

```ruby title="config.ru"
run ->(env) {
  [
    200,
    { "content-type" => "text/plain" },
    ["Hello Rack\n"]
  ]
}
```

运行：

```bash
rackup
```

然后访问：

```text
http://localhost:9292
```

## Rack 应用返回什么

Rack 应用返回一个三元素数组：

```ruby
[
  status,
  headers,
  body
]
```

含义：

- `status`：HTTP 状态码，例如 `200`。
- `headers`：响应头 Hash。
- `body`：响应体，通常是一个能逐个产出字符串的对象。

## env 是什么

`env` 是一个 Hash，包含请求信息：

```ruby title="config.ru"
run ->(env) {
  path = env["PATH_INFO"]

  [
    200,
    { "content-type" => "text/plain" },
    ["path=#{path}\n"]
  ]
}
```

访问不同路径，会看到不同 `PATH_INFO`。

## Rack 的意义

Rack 让 Web Server 和 Ruby Web 应用之间有了统一接口。框架可以专注于路由、参数、控制器等更高层能力。

## 小结

你不需要每天手写 Rack，但理解 Rack 能帮你看懂 Ruby Web 框架底层：请求变成 `env`，应用返回 `[status, headers, body]`。

