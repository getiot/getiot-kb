---
sidebar_position: 0
sidebar_label: Block 与 yield
slug: /ruby-block-yield
---

# Ruby Block 与 yield

Block 是 Ruby 最有特色、也最重要的语法之一。你可以把 block 理解成“传给方法的一段代码”。方法可以在合适的时候执行这段代码。

如果你能理解 block，Ruby 的 `each`、`map`、文件打开、测试框架、Rails 路由等都会变得自然很多。

## 从 each 开始理解 block

```ruby
names = ["Alice", "Bob", "Carol"]

names.each do |name|
  puts "Hello, #{name}"
end
```

这里 `do ... end` 就是 block。它被传给了 `each` 方法。

`each` 做的事情可以理解成：

1. 从数组中取出一个元素。
2. 把元素交给 block。
3. 执行 block。
4. 重复直到数组结束。

`|name|` 是 block 参数，表示每次传进来的元素。

## do ... end 和花括号

多行 block 通常写成：

```ruby
numbers.each do |n|
  puts n * 2
end
```

单行 block 常写成：

```ruby
numbers.each { |n| puts n * 2 }
```

初学时可以记住一个简单规则：多行用 `do ... end`，单行用 `{ ... }`。

## yield：执行传入的 block

你也可以写一个接收 block 的方法。

```ruby
def around
  puts "before"
  yield
  puts "after"
end

around do
  puts "inside"
end
```

输出：

```text
before
inside
after
```

`yield` 的意思是：执行调用方法时传进来的 block。

## 给 block 传参数

```ruby
def repeat(times)
  times.times do |i|
    yield i
  end
end

repeat(3) do |i|
  puts "index=#{i}"
end
```

这里 `yield i` 会把 `i` 传给 block。

## 判断是否传入 block

如果方法里直接 `yield`，但调用时没有传 block，会报错。可以使用 `block_given?` 判断：

```ruby
def maybe_run
  if block_given?
    yield
  else
    puts "no block"
  end
end

maybe_run
maybe_run { puts "has block" }
```

## block 常见用途

资源管理：

```ruby
File.open("data.txt") do |file|
  puts file.read
end
```

Ruby 会在 block 执行后关闭文件。

延迟执行：

```ruby
def measure
  start = Time.now
  yield
  puts "cost: #{Time.now - start}s"
end

measure do
  sleep 1
end
```

## 常见错误

忘记 block 参数：

```ruby
[1, 2, 3].each do
  # 这里拿不到当前元素
end
```

在没有 block 的情况下调用 `yield`：

```ruby
def run
  yield
end

# run 会报错
```

## 小练习

1. 写一个 `twice` 方法，执行传入 block 两次。
2. 写一个 `with_log` 方法，在执行 block 前后输出日志。
3. 使用 `block_given?` 让方法在没有 block 时输出提示。

## 小结

Block 是 Ruby 表达“把一段逻辑交给方法”的方式。`yield` 让你在自己的方法中执行这段逻辑。掌握 block 后，你会更容易理解 Ruby 的集合处理和框架代码。

