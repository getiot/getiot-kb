---
sidebar_position: 8
sidebar_label: 元编程入门
slug: /ruby-metaprogramming-intro
---

# Ruby 元编程入门

元编程是“写能生成或改变代码行为的代码”。Ruby 的对象模型和动态特性让元编程很自然，但它也是最容易被滥用的部分。

初学者学习元编程的目标不是马上写框架，而是看懂 Ruby 生态里常见的动态写法。

## send 动态调用方法

```ruby
name = "ruby"

puts name.send(:upcase)
```

`send` 可以根据方法名动态调用方法。

```ruby
method_name = :reverse
puts "ruby".send(method_name)
```

如果方法名来自用户输入，要非常谨慎，避免调用不该调用的方法。

## define_method 动态定义方法

```ruby
class User
  [:name, :email].each do |attr|
    define_method(attr) do
      instance_variable_get("@#{attr}")
    end
  end

  def initialize(name, email)
    @name = name
    @email = email
  end
end

user = User.new("Alice", "alice@example.com")
puts user.name
puts user.email
```

`attr_reader`、`attr_accessor` 这类方法背后就有元编程思想。

## instance_variable_get

```ruby
user.instance_variable_get("@name")
```

它可以动态读取实例变量。日常业务代码不建议经常这样写，因为会绕过对象正常 API。

## method_missing

当对象收到不存在的方法时，Ruby 会调用 `method_missing`。

```ruby
class DynamicConfig
  def initialize(data)
    @data = data
  end

  def method_missing(name, *args)
    @data.fetch(name) { super }
  end

  def respond_to_missing?(name, include_private = false)
    @data.key?(name) || super
  end
end

config = DynamicConfig.new(host: "localhost")
puts config.host
```

如果重写 `method_missing`，通常也应该重写 `respond_to_missing?`，否则对象能力会变得难以判断。

## 元编程的使用原则

- 先写普通 Ruby。
- 重复模式非常稳定时，再考虑元编程。
- 给动态行为写测试。
- 保持方法来源可追踪。
- 不要为了炫技牺牲可读性。

## 小练习

1. 使用 `send` 动态调用字符串方法。
2. 用 `define_method` 为类生成两个 reader 方法。
3. 阅读 `attr_reader` 的行为，思考它和 `define_method` 的关系。

## 小结

元编程能减少重复，也能制造迷雾。初学者应该先理解 Ruby 对象模型，再谨慎使用 `send`、`define_method` 和 `method_missing`。

