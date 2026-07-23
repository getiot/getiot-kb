---
sidebar_position: 9
sidebar_label: 正则表达式 Regexp
slug: /ruby-regexp
---

# Ruby 正则表达式 Regexp

正则表达式用于匹配文本模式。Ruby 对正则支持很好，适合日志分析、表单校验、文本提取和简单解析。

## 基本匹配

```ruby
text = "sensor-001"

if text.match?(/sensor-\d+/)
  puts "matched"
end
```

`/sensor-\d+/` 是一个 Regexp 对象。`\d+` 表示一个或多个数字。

## match 和 match?

`match?` 只返回布尔值：

```ruby
"abc123".match?(/\d+/)
```

`match` 会返回匹配结果对象：

```ruby
match = "abc123".match(/(\d+)/)
puts match[1] if match
```

## 捕获内容

```ruby
line = "temperature=26.5"

if match = line.match(/temperature=(\d+\.\d+)/)
  puts match[1]
end
```

括号会捕获内容，`match[1]` 表示第一个捕获组。

## 替换

```ruby
text = "error 404, error 500"
puts text.gsub(/\d+/, "CODE")
```

`gsub` 会替换所有匹配项。

## 常见模式

匹配数字：

```ruby
/\d+/
```

匹配单词字符：

```ruby
/\w+/
```

匹配空白：

```ruby
/\s+/
```

行首和行尾：

```ruby
/^ERROR/
/done$/
```

## 正则不要滥用

简单分隔文本时，`split` 更清楚：

```ruby
"a,b,c".split(",")
```

结构化数据应该使用对应解析器，例如 JSON 用 `JSON.parse`，CSV 用 `CSV`。

## 小练习

1. 判断字符串是否包含数字。
2. 从 `"id=123"` 中提取 `123`。
3. 把字符串中的连续空白替换成一个空格。

## 小结

Regexp 很强，但要用在真正需要模式匹配的地方。初学时先掌握 `match?`、`match`、捕获组和 `gsub`。

