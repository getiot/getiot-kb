---
sidebar_position: 2
sidebar_label: 数据类型概览
slug: /ruby-data-types
---

# Ruby 数据类型概览

Ruby 是动态类型语言。变量没有固定类型，但对象有类型。你写 Ruby 时，不需要先声明变量类型，但要知道对象支持哪些方法。

## 查看对象类型

```ruby
puts 42.class
puts 3.14.class
puts "hello".class
puts :name.class
puts [1, 2, 3].class
puts({ name: "Ruby" }.class)
puts nil.class
```

输出会显示这些对象所属的类，例如 `Integer`、`Float`、`String`、`Symbol`、`Array`、`Hash`。

## 常见类型

数字：

```ruby
age = 18
price = 19.99
```

字符串：

```ruby
name = "Ruby"
```

符号：

```ruby
status = :ok
```

数组：

```ruby
numbers = [1, 2, 3]
```

哈希：

```ruby
user = { name: "Alice", age: 18 }
```

布尔值和 nil：

```ruby
active = true
deleted = false
value = nil
```

## 类型判断

```ruby
value = "ruby"

puts value.is_a?(String)
puts value.respond_to?(:upcase)
```

`is_a?` 判断对象是否属于某个类或其子类。`respond_to?` 判断对象是否能响应某个方法。

在 Ruby 中，很多时候问“它能不能响应这个方法”比问“它是不是某个具体类”更有用。

## 类型转换

```ruby
"42".to_i
"3.14".to_f
42.to_s
:name.to_s
"name".to_sym
```

Ruby 不会在所有地方自动转换类型：

```ruby
# "age: " + 18 会报错
puts "age: " + 18.to_s
```

更常用字符串插值：

```ruby
age = 18
puts "age: #{age}"
```

## 强类型是什么意思

Ruby 是动态类型，但也是强类型。它不会偷偷把所有东西都转换成你想要的类型。

```ruby
# 不能直接把 String 和 Integer 相加
"1" + 2
```

这会报错。你需要明确转换：

```ruby
"1".to_i + 2
```

## 小练习

1. 在 IRB 中分别查看整数、字符串、数组、哈希的 `class`。
2. 用 `respond_to?` 判断字符串是否有 `upcase` 方法。
3. 把字符串 `"100"` 转成数字后加 20。

## 小结

Ruby 变量不固定类型，但对象有类型。写 Ruby 时，你要关注对象能响应哪些方法，并在需要时显式转换类型。

