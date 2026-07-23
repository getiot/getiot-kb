---
sidebar_position: 1
sidebar_label: initialize 与实例变量
slug: /ruby-initialize-instance-variables
---

# Ruby initialize 与实例变量

`initialize` 是对象创建时自动调用的方法。实例变量以 `@` 开头，用来保存对象自己的状态。

## initialize 的作用

```ruby
class User
  def initialize(name)
    @name = name
  end

  def greet
    "Hello, #{@name}"
  end
end

user = User.new("Alice")
puts user.greet
```

调用 `User.new("Alice")` 时，Ruby 会创建对象，并把 `"Alice"` 传给 `initialize`。

## 每个对象有自己的实例变量

```ruby
alice = User.new("Alice")
bob = User.new("Bob")

puts alice.greet
puts bob.greet
```

`alice` 和 `bob` 是两个不同对象，它们各自保存自己的 `@name`。

## 实例变量不用提前声明

Ruby 不要求你提前声明实例变量：

```ruby
class Device
  def set_id(id)
    @id = id
  end
end
```

但从可维护性角度，重要状态最好在 `initialize` 中建立，让对象从创建开始就是可用状态。

## 默认值

```ruby
class User
  def initialize(name, role = "guest")
    @name = name
    @role = role
  end
end
```

默认值适合可选属性。

## 常见错误

把局部变量和实例变量混淆：

```ruby
class User
  def initialize(name)
    name = name
  end

  def greet
    "Hello, #{@name}"
  end
end
```

这里没有设置 `@name`，所以 `greet` 里拿不到名字。正确写法是：

```ruby
@name = name
```

## 小练习

1. 定义一个 `Device` 类，初始化时接收 `id` 和 `type`。
2. 给 `User` 增加默认角色 `guest`。
3. 尝试忘记 `@`，观察程序行为。

## 小结

`initialize` 建立对象初始状态，实例变量保存对象状态。对象创建后最好处于可用、可理解的状态。

