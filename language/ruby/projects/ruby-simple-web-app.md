---
sidebar_position: 4
sidebar_label: 简单 Web 应用
slug: /ruby-simple-web-app
---

# Ruby 简单 Web 应用

这个项目使用 Sinatra 写一个最小 Web 应用：显示首页、返回当前时间，并提供一个简单 JSON API。

## Gemfile

```ruby title="Gemfile"
source "https://rubygems.org"

gem "sinatra"
```

安装依赖：

```bash
bundle install
```

## 应用代码

```ruby title="app.rb"
require "json"
require "sinatra"

get "/" do
  "Hello Ruby Web"
end

get "/time" do
  Time.now.strftime("%Y-%m-%d %H:%M:%S")
end

get "/api/status" do
  content_type :json

  {
    status: "ok",
    timestamp: Time.now.to_i
  }.to_json
end
```

## 运行

```bash
bundle exec ruby app.rb
```

访问：

```text
http://localhost:4567
http://localhost:4567/time
http://localhost:4567/api/status
```

## 你学到了什么

- `get` 定义路由。
- route block 返回响应内容。
- `params` 可以读取参数。
- `content_type :json` 设置响应类型。
- Ruby Hash 可以转成 JSON。

## 可以继续改进

- 添加页面模板。
- 添加 POST 路由。
- 读取配置文件。
- 加入日志。
- 写 Rack 测试。

## 小结

Sinatra 很适合作为 Ruby Web 入门项目。它让你快速看到路由、响应和 JSON API 的基本形状。

