---
sidebar_position: 3
sidebar_label: JSON、CSV 与 YAML
slug: /ruby-json-csv-yaml
---

# Ruby JSON、CSV 与 YAML

JSON、CSV 和 YAML 是工程实践中非常常见的数据格式。Ruby 标准库已经提供了基础支持。

## JSON

JSON 常用于 Web API 和设备数据。

```ruby
require "json"

text = '{"device":"sensor-1","temperature":26.5}'
data = JSON.parse(text)

puts data["device"]
puts data["temperature"]
```

`JSON.parse` 默认返回 Hash，键通常是字符串。

生成 JSON：

```ruby
payload = {
  device: "sensor-1",
  temperature: 26.5
}

puts JSON.generate(payload)
```

## CSV

CSV 常用于表格数据和报表。

```ruby
require "csv"

CSV.foreach("data.csv", headers: true) do |row|
  puts "#{row["name"]}: #{row["value"]}"
end
```

写 CSV：

```ruby
require "csv"

CSV.open("report.csv", "w") do |csv|
  csv << ["name", "value"]
  csv << ["temperature", 26.5]
end
```

## YAML

YAML 常用于配置文件：

```yaml title="config.yml"
host: localhost
port: 3000
```

读取：

```ruby
require "yaml"

config = YAML.load_file("config.yml")

puts config["host"]
puts config["port"]
```

:::warning
不要随意加载不可信来源的 YAML。YAML 能表达复杂对象，处理外部输入时要使用安全加载方式并限制允许的类型。
:::

## 选择哪种格式

JSON：适合 API、设备数据、跨语言交换。

CSV：适合表格、报表、电子表格导入导出。

YAML：适合人手写配置，但不适合高风险外部输入。

## 常见错误

JSON parse 后用 Symbol 键访问：

```ruby
data = JSON.parse('{"name":"Ruby"}')
puts data[:name] # nil
puts data["name"] # Ruby
```

CSV 数字默认是字符串：

```ruby
row["amount"].to_f
```

## 小练习

1. 解析一段 JSON 并读取字段。
2. 读取 CSV，统计某列总和。
3. 写一个简单 YAML 配置文件并读取。

## 小结

JSON、CSV、YAML 分别适合不同场景。处理外部数据时，要特别注意键类型、数字转换和安全加载。

