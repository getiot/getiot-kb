---
sidebar_position: 3
sidebar_label: 运算符与表达式
slug: /ruby-operators-expressions
---

# Ruby 运算符与表达式

Ruby 的运算符看起来像符号，本质上很多也是方法调用。比如 `1 + 2` 可以理解成对 `1` 调用 `+` 方法，并把 `2` 作为参数。

## 算术运算符

```ruby
puts 1 + 2
puts 5 - 3
puts 2 * 4
puts 10 / 3
puts 10 % 3
puts 2**3
```

注意整数除法：

```ruby
puts 10 / 3   # 3
puts 10 / 3.0 # 3.3333333333333335
```

只要有一边是浮点数，结果就会是浮点计算。

## 比较运算符

```ruby
puts 3 > 2
puts 3 >= 3
puts 3 == 3
puts 3 != 4
```

比较表达式会返回 `true` 或 `false`。

## 逻辑运算符

```ruby
logged_in = true
admin = false

puts logged_in && admin
puts logged_in || admin
puts !admin
```

`&&` 表示并且，`||` 表示或者，`!` 表示取反。

Ruby 还有 `and` 和 `or`，但它们优先级较低。初学时优先使用 `&&` 和 `||`，更不容易踩坑。

## 赋值运算

```ruby
count = 0
count += 1
count -= 1
```

Ruby 没有 `++` 和 `--`：

```ruby
# count++ 不是 Ruby 写法
count += 1
```

## 条件赋值

常见写法：

```ruby
name ||= "Guest"
```

它的意思是：如果 `name` 当前是假值，就赋值为 `"Guest"`。Ruby 中只有 `nil` 和 `false` 是假值。

## 表达式返回值

Ruby 中赋值、条件判断、方法调用都会产生值：

```ruby
message = if Time.now.hour < 12
            "Good morning"
          else
            "Hello"
          end
```

你可以利用这一点写出简洁代码，但不要为了简洁牺牲可读性。

## 小练习

1. 试验 `10 / 3` 和 `10 / 3.0` 的区别。
2. 写一个表达式判断年龄是否大于等于 18。
3. 使用 `||=` 给变量设置默认值。

## 小结

Ruby 运算符自然易读，但要注意整数除法、`&&`/`||` 优先级和 `||=` 的真值规则。

