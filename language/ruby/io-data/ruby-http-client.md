---
sidebar_position: 4
sidebar_label: HTTP 请求
slug: /ruby-http-client
---

# Ruby HTTP 请求

Ruby 标准库提供 `net/http`，可以发送 HTTP 请求。它适合理解 HTTP Client 的基本流程：构造 URL、发送请求、检查响应、解析数据。

实际项目也常使用 Faraday、HTTParty 等 gem，它们在超时、重试、middleware 和测试方面更方便。

## GET 请求

```ruby
require "net/http"
require "uri"

uri = URI("https://www.ruby-lang.org")
response = Net::HTTP.get_response(uri)

puts response.code
puts response.body[0, 120]
```

`response.code` 是字符串形式的状态码，例如 `"200"`。

## 检查响应状态

```ruby
if response.is_a?(Net::HTTPSuccess)
  puts "success"
else
  warn "request failed: #{response.code}"
end
```

不要只看有没有响应体。HTTP 请求可能返回 `404`、`500`，这时仍然可能有 body。

## 解析 JSON 响应

```ruby
require "json"
require "net/http"
require "uri"

uri = URI("https://api.example.com/data")
response = Net::HTTP.get_response(uri)

unless response.is_a?(Net::HTTPSuccess)
  abort "request failed: #{response.code}"
end

data = JSON.parse(response.body)
puts data
```

`abort` 会输出消息并以非零状态退出，适合简单脚本。

## 设置超时

网络请求不能无限等待。可以显式创建连接并设置超时：

```ruby
require "net/http"
require "uri"

uri = URI("https://www.ruby-lang.org")

Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https", open_timeout: 5, read_timeout: 10) do |http|
  response = http.get(uri.request_uri)
  puts response.code
end
```

## 常见错误

没有处理失败状态码：程序把错误响应当成正常数据继续解析。

没有设置超时：网络异常时脚本卡住很久。

没有处理 JSON 解析错误：服务返回 HTML 错误页时，`JSON.parse` 会失败。

## 小练习

1. 请求一个网页并打印状态码。
2. 对非 2xx 响应输出错误提示。
3. 给请求设置 `open_timeout` 和 `read_timeout`。

## 小结

`net/http` 能完成基础 HTTP 请求。真实项目中，你需要关注状态码、超时、重试、headers、JSON 解析错误和测试。

