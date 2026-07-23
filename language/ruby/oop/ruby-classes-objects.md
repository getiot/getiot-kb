---
sidebar_position: 0
sidebar_label: 类与对象
slug: /ruby-classes-objects
---

# Ruby 类与对象

类是创建对象的模板，对象是实际运行时存在的实例。Ruby 是一门面向对象语言，你写的很多代码本质上都是“对象接收消息，然后执行方法”。

## 定义类

```ruby
class User
  def greet
    "Hello"
  end
end
```

类名使用大驼峰命名，例如 `User`、`UserProfile`。

## 创建对象

```ruby
user = User.new
puts user.greet
```

`User.new` 会创建一个 `User` 对象。`user.greet` 表示调用对象的 `greet` 方法。

## 对象有状态和行为

状态是对象保存的数据，行为是对象提供的方法。

```ruby
class Counter
  def initialize
    @value = 0
  end

  def increment
    @value += 1
  end

  def value
    @value
  end
end

counter = Counter.new
counter.increment
puts counter.value
```

`@value` 是实例变量，用来保存对象自己的状态。

## 对象能响应哪些方法

```ruby
user = User.new

puts user.class
puts user.respond_to?(:greet)
puts user.respond_to?(:missing_method)
```

`respond_to?` 很有 Ruby 味道：你不一定关心对象具体是什么类，更关心它能不能响应某个方法。

## 小练习

1. 定义一个 `Book` 类，提供 `title` 方法。
2. 定义一个 `Counter` 类，支持 `increment` 和 `value`。
3. 使用 `respond_to?` 判断对象是否有某个方法。

## 小结

Ruby 的类把数据和行为组织在一起。你要先掌握 `class`、`new`、实例方法和实例变量，再继续学习初始化、访问器和继承。

