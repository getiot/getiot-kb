---
sidebar_position: 1
sidebar_label: Proc 与 Lambda
slug: /ruby-proc-lambda
---

# Ruby Proc 与 Lambda

Block 通常是临时传给方法的一段代码。如果你想把这段代码保存到变量里、作为普通对象传递，就可以使用 `Proc` 或 lambda。

## Proc 是可调用对象

```ruby
printer = Proc.new do |name|
  puts "Hello, #{name}"
end

printer.call("Ruby")
```

`printer` 是一个对象，它保存了一段可执行逻辑。

## Lambda

lambda 的常见写法是：

```ruby
adder = ->(a, b) { a + b }

puts adder.call(2, 3)
```

也可以写成：

```ruby
adder = lambda { |a, b| a + b }
```

## Proc 和 lambda 的参数差异

lambda 对参数数量更严格：

```ruby
fn = ->(x) { x * 2 }

puts fn.call(10)
# fn.call 会报错，因为缺少参数
```

Proc 相对宽松：

```ruby
fn = Proc.new { |x| x.inspect }

puts fn.call
```

这种宽松有时方便，但也可能隐藏错误。

## return 行为差异

`return` 在 Proc 和 lambda 中行为不同。初学阶段不建议在 Proc 中随意使用 `return`。

你可以先遵守一个简单原则：

- 需要像函数一样保存逻辑时，优先用 lambda。
- 只是配合 Ruby API 传一段代码时，用 block。
- 遇到框架或库要求 Proc 时，再使用 Proc。

## 把 block 转成 Proc

方法参数中可以用 `&block` 捕获 block：

```ruby
def run_later(&block)
  block.call
end

run_later do
  puts "hello"
end
```

这里 `block` 是一个 Proc 对象。

## Symbol to Proc

Ruby 中常见简写：

```ruby
names = ["alice", "bob"]
puts names.map(&:upcase)
```

`&:upcase` 可以理解成“把每个元素都调用 `upcase`”。初学时先看懂即可，不必急着到处使用。

## 小练习

1. 创建一个 lambda，接收两个数并返回较大的数。
2. 写一个方法，用 `&block` 捕获 block 并调用。
3. 使用 `map(&:upcase)` 转换字符串数组。

## 小结

Block 是最常用的临时代码块；Proc 和 lambda 则把可执行逻辑变成对象。初学者先把 block 用熟，再理解 Proc 和 lambda 的差异。

