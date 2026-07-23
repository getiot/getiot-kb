---
sidebar_position: 6
sidebar_label: 方法定义与参数
slug: /ruby-methods
---

# Ruby 方法定义与参数

方法用于把一段逻辑命名并复用。Ruby 用 `def` 定义方法，用 `end` 结束方法。

## 定义方法

```ruby
def greet(name)
  "Hello, #{name}"
end

puts greet("Ruby")
```

Ruby 方法会返回最后一个表达式的值。上面的 `greet` 没有写 `return`，但仍然返回字符串。

## return 什么时候用

你可以显式使用 `return`：

```ruby
def divide(a, b)
  return nil if b == 0

  a / b
end
```

`return` 常用于提前返回。方法最后一行通常不必写 `return`。

## 默认参数

```ruby
def greet(name = "Ruby")
  "Hello, #{name}"
end

puts greet
puts greet("Alice")
```

默认参数适合给可选值提供兜底。

## 关键字参数

```ruby
def create_user(name:, age:)
  {
    name: name,
    age: age
  }
end

user = create_user(name: "Alice", age: 18)
puts user
```

关键字参数让调用处更清楚，特别适合参数较多的方法。

## 可变参数

```ruby
def sum(*numbers)
  numbers.sum
end

puts sum(1, 2, 3)
```

`*numbers` 会把多个位置参数收集成数组。

关键字参数也可以收集：

```ruby
def print_options(**options)
  puts options
end

print_options(debug: true, port: 3000)
```

## 方法命名约定

返回布尔值的方法常以 `?` 结尾：

```ruby
def adult?(age)
  age >= 18
end
```

有副作用或更危险的方法可能以 `!` 结尾：

```ruby
def normalize_name!(user)
  user[:name] = user[:name].strip.downcase
end
```

## 常见错误

参数数量不匹配：

```ruby
def greet(name)
  "Hello, #{name}"
end

# greet 会报错，因为缺少参数
```

关键字参数名称写错：

```ruby
def connect(host:, port:)
end

# connect(hostname: "localhost", port: 3000) 会报错
```

## 小练习

1. 写一个 `square(number)` 方法，返回平方。
2. 写一个 `adult?(age)` 方法，判断是否成年。
3. 写一个使用关键字参数的 `connect(host:, port:)` 方法。

## 小结

Ruby 方法简洁灵活。初学时重点掌握普通参数、默认参数、关键字参数和最后表达式返回值。

