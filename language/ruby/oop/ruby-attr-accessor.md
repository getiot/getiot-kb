---
sidebar_position: 2
sidebar_label: 属性访问器
slug: /ruby-attr-accessor
---

# Ruby 属性访问器 attr_accessor

实例变量属于对象内部。外部代码不能直接访问 `@name`，通常要通过方法读取或修改。

## 手写 reader

```ruby
class User
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

user = User.new("Alice")
puts user.name
```

`name` 方法返回 `@name`，这就是 reader。

## 手写 writer

```ruby
class User
  def name=(value)
    @name = value
  end
end
```

调用时看起来像赋值：

```ruby
user.name = "Bob"
```

实际是在调用 `name=` 方法。

## attr_reader、attr_writer、attr_accessor

Ruby 提供简写：

```ruby
class User
  attr_reader :name
  attr_writer :password
  attr_accessor :email

  def initialize(name, email)
    @name = name
    @email = email
  end
end
```

含义：

- `attr_reader`：生成读取方法。
- `attr_writer`：生成写入方法。
- `attr_accessor`：同时生成读取和写入方法。

## 不要无脑暴露所有属性

```ruby
class Account
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def deposit(amount)
    @balance += amount
  end
end
```

余额可以读，但不应该允许外部随意写：

```ruby
# account.balance = -999 不应该允许
```

这就是封装的意义。

## 小练习

1. 定义 `Book` 类，使用 `attr_reader` 暴露 `title`。
2. 定义 `User` 类，使用 `attr_accessor` 暴露 `email`。
3. 思考 `Account#balance` 为什么更适合只读。

## 小结

访问器是方法，不是直接暴露变量。`attr_accessor` 很方便，但你应该只暴露外部真正需要访问或修改的状态。

