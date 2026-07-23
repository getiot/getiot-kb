---
sidebar_position: 3
sidebar_label: HTTP API Client
slug: /ruby-api-client
---

# Ruby HTTP API Client

这个项目封装一个简单 API Client，用类组织 HTTP 请求和 JSON 解析。真实项目里，不要把 HTTP 请求代码散落在业务逻辑各处。

## 目标

我们希望业务代码能这样写：

```ruby
client = ApiClient.new("https://api.example.com/")
data = client.get_json("/devices")
```

## 完整代码

```ruby title="api_client.rb"
require "json"
require "net/http"
require "uri"

class ApiClient
  def initialize(base_url, open_timeout: 5, read_timeout: 10)
    @base_url = base_url
    @open_timeout = open_timeout
    @read_timeout = read_timeout
  end

  def get_json(path)
    uri = URI.join(@base_url, path)
    response = get(uri)

    unless response.is_a?(Net::HTTPSuccess)
      raise "request failed: #{response.code}"
    end

    JSON.parse(response.body)
  end

  private

  def get(uri)
    Net::HTTP.start(
      uri.host,
      uri.port,
      use_ssl: uri.scheme == "https",
      open_timeout: @open_timeout,
      read_timeout: @read_timeout
    ) do |http|
      http.get(uri.request_uri)
    end
  end
end
```

## 为什么封装成类

封装后，你可以集中处理：

- base URL
- 超时
- headers
- 状态码
- JSON 解析
- 错误格式
- 日志

业务代码只关心“我要哪个资源”。

## 可以继续改进

- 定义 `ApiError`。
- 支持 POST/PUT/DELETE。
- 添加 Authorization header。
- 为 `get_json` 写测试。
- 使用 Faraday 替代 `net/http`。

## 小结

API Client 的价值在于隔离网络细节。你应该把 HTTP 边界集中管理，不要让业务代码到处拼 URL、解析 JSON 和判断状态码。

