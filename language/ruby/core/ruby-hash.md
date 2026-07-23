---
sidebar_position: 5
sidebar_label: 哈希 Hash
slug: /ruby-hash
---

# Ruby 哈希 Hash

Hash 用来保存键值对。它适合表示配置、用户属性、统计结果、JSON-like 数据等。

## 创建 Hash

常见写法：

```ruby
user = {
  name: "Alice",
  age: 18,
  admin: false
}
```

这里的键是 Symbol，`name: "Alice"` 等价于 `:name => "Alice"`。

也可以使用字符串键：

```ruby
user = {
  "name" => "Alice",
  "age" => 18
}
```

两种键不要随意混用。

## 读取值

```ruby
user = { name: "Alice", age: 18 }

puts user[:name]
puts user[:email]
```

不存在的键默认返回 `nil`。

如果你希望键不存在时明确报错，可以用 `fetch`：

```ruby
puts user.fetch(:name)
puts user.fetch(:email, "unknown")
```

## 写入和更新

```ruby
user[:age] = 19
user[:city] = "Shanghai"
```

Hash 可以动态增加键值对。

## 遍历 Hash

```ruby
user.each do |key, value|
  puts "#{key}: #{value}"
end
```

获取所有键和值：

```ruby
puts user.keys.inspect
puts user.values.inspect
```

## 默认值

```ruby
counts = Hash.new(0)

counts[:error] += 1
counts[:warn] += 1

puts counts
```

`Hash.new(0)` 表示读取不存在的键时返回 `0`。

:::warning
如果默认值是数组或哈希这类可变对象，要特别小心 `Hash.new([])`。多个键可能共享同一个默认对象。遇到这种情况，应使用 block 形式。
:::

安全写法：

```ruby
groups = Hash.new { |hash, key| hash[key] = [] }
groups[:a] << 1
groups[:b] << 2
```

## 常见错误

混用字符串键和 Symbol 键：

```ruby
user = { name: "Alice" }
puts user["name"] # nil
```

忘记处理缺失键：

```ruby
email = user[:email]
# email.downcase 可能报错，因为 email 是 nil
```

## 小练习

1. 创建一个保存设备信息的 Hash，包括 `id`、`type`、`online`。
2. 使用 `fetch` 读取一个可能不存在的键，并设置默认值。
3. 使用 Hash 统计数组中每个单词出现次数。

## 小结

Hash 是 Ruby 表达结构化数据的核心工具。你要掌握 Symbol 键、`fetch`、遍历、默认值，并避免字符串键和 Symbol 键混用。

