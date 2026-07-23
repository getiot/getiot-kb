---
sidebar_position: 7
sidebar_label: 异常处理
slug: /ruby-exceptions
---

# Ruby 异常处理

Ruby 使用异常表示运行时错误。你可以用 `begin`、`rescue`、`ensure` 处理异常，也可以用 `raise` 主动抛出异常。

## 一个简单异常

```ruby
Integer("abc")
```

这会抛出 `ArgumentError`，因为 `"abc"` 不能转换成整数。

## rescue

```ruby
begin
  number = Integer("abc")
  puts number
rescue ArgumentError => e
  puts "转换失败: #{e.message}"
end
```

`rescue` 捕获指定异常。`e` 是异常对象。

## ensure

`ensure` 中的代码无论是否发生异常都会执行：

```ruby
file = File.open("data.txt")

begin
  puts file.read
ensure
  file.close
end
```

不过文件读写更推荐 block 形式：

```ruby
File.open("data.txt") do |file|
  puts file.read
end
```

Ruby 会在 block 结束后关闭文件。

## 主动 raise

```ruby
def divide(a, b)
  raise ArgumentError, "b must not be zero" if b == 0

  a / b
end
```

当参数不合法，或程序无法继续完成当前职责时，可以使用 `raise`。

## 自定义异常

```ruby
class ConfigError < StandardError
end

raise ConfigError, "missing host"
```

自定义异常通常继承 `StandardError`。

## 不要吞掉异常

不好的写法：

```ruby
begin
  do_something
rescue
end
```

这样会让错误消失，排查问题很痛苦。至少应该记录日志或给出明确处理。

## 小练习

1. 捕获 `Integer("abc")` 的异常并输出提示。
2. 写一个 `divide(a, b)`，当 `b == 0` 时抛出 `ArgumentError`。
3. 自定义一个 `ConfigError`。

## 小结

异常用于处理无法在当前路径正常完成的情况。你要捕获具体异常、避免吞错，并优先使用 block 形式管理文件等资源。

