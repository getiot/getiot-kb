---
sidebar_position: 3
sidebar_label: self 与方法查找
slug: /ruby-self-method-lookup
---

# Ruby self 与方法查找

`self` 表示当前对象。理解 `self`，你才能理解 Ruby 方法到底调用到哪里，以及类方法和实例方法有什么区别。

## 实例方法中的 self

```ruby
class User
  def initialize(name)
    @name = name
  end

  def greet
    puts self.class
    "Hello, #{@name}"
  end
end

user = User.new("Alice")
puts user.greet
```

在实例方法中，`self` 是当前对象，也就是 `user`。

## 省略接收者

在对象内部调用自己的方法时，可以省略 `self`：

```ruby
class User
  def greet
    format_name
  end

  def format_name
    "Alice"
  end
end
```

`format_name` 等价于给当前 `self` 发送 `format_name` 消息。

## 类方法

```ruby
class User
  def self.guest
    new("Guest")
  end

  def initialize(name)
    @name = name
  end
end

user = User.guest
```

`def self.guest` 定义的是类方法。调用者是 `User` 这个类对象本身。

## 方法查找路径

当你调用：

```ruby
user.greet
```

Ruby 会从对象所属的类开始查找 `greet` 方法。如果类里找不到，会继续查找包含的模块和父类。

你可以查看祖先链：

```ruby
puts User.ancestors.inspect
```

## 常见错误

在实例方法里误调用类方法：

```ruby
class User
  def self.build
    new
  end

  def run
    # build 这里找的是实例方法，不是类方法
  end
end
```

需要明确调用：

```ruby
self.class.build
```

或者重新设计方法职责。

## 小练习

1. 在实例方法里输出 `self`。
2. 定义一个类方法 `User.guest`。
3. 使用 `ancestors` 查看一个类的方法查找链。

## 小结

看 Ruby 代码时，经常问一句：现在 `self` 是谁？方法调用会沿着哪个路径查找？这能帮你理解很多看似“魔法”的代码。

