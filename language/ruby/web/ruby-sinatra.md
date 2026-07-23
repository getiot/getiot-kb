---
sidebar_position: 2
sidebar_label: Sinatra 入门
slug: /ruby-sinatra
---

# Ruby Sinatra 入门

Sinatra 是轻量级 Ruby Web 框架。它适合小型 Web 应用、内部工具和简单 API。相比 Rails，Sinatra 更少约定，代码更直接。

## 最小应用

创建 `Gemfile`：

```ruby title="Gemfile"
source "https://rubygems.org"

gem "sinatra"
```

创建 `app.rb`：

```ruby title="app.rb"
require "sinatra"

get "/" do
  "Hello Sinatra"
end
```

运行：

```bash
bundle install
bundle exec ruby app.rb
```

访问：

```text
http://localhost:4567
```

## 路由参数

```ruby
get "/hello/:name" do
  "Hello, #{params[:name]}"
end
```

访问 `/hello/Alice`，`params[:name]` 就是 `"Alice"`。

## 查询参数

```ruby
get "/search" do
  keyword = params[:q]
  "search: #{keyword}"
end
```

访问：

```text
http://localhost:4567/search?q=ruby
```

## 返回 JSON

```ruby
require "json"

get "/api/time" do
  content_type :json
  { time: Time.now.to_i }.to_json
end
```

## 小结

Sinatra 很适合理解 Web 基础：路由、参数、响应、JSON。它比 Rails 更轻，但大型业务应用需要你自己组织更多结构。

