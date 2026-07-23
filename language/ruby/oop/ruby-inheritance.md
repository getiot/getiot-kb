---
sidebar_position: 5
sidebar_label: 继承
slug: /ruby-inheritance
---

# Ruby 继承

继承让一个类复用另一个类的行为。Ruby 使用 `<` 表示继承。

## 基本继承

```ruby
class Animal
  def speak
    "..."
  end
end

class Dog < Animal
  def speak
    "woof"
  end
end

puts Dog.new.speak
```

`Dog` 继承自 `Animal`，并重写了 `speak` 方法。

## 继承方法

```ruby
class Animal
  def alive?
    true
  end
end

class Cat < Animal
end

puts Cat.new.alive?
```

`Cat` 没有定义 `alive?`，Ruby 会沿着父类查找方法。

## super

`super` 用来调用父类同名方法。

```ruby
class User
  def initialize(name)
    @name = name
  end
end

class Admin < User
  def initialize(name, level)
    super(name)
    @level = level
  end
end
```

`super(name)` 明确把 `name` 传给父类的 `initialize`。

如果写 `super` 不带括号和参数，Ruby 会把当前方法接收到的参数继续传给父类同名方法。

## 查看继承链

```ruby
puts Admin.ancestors.inspect
```

`ancestors` 会显示方法查找路径，包括类、模块和父类。

## 继承的适用场景

继承适合表达“是一种”的关系。例如 `Admin < User` 可以表示 Admin 是一种 User。

如果你只是想复用某种能力，比如“可记录日志”“可序列化成 JSON”，Module/Mixin 往往更合适。

## 常见错误

继承层级太深：

```text
BaseUser -> StaffUser -> AdminUser -> SuperAdminUser
```

层级越深，方法来源越难追踪。Ruby 项目中常用组合和 Mixin 替代复杂继承。

## 小练习

1. 定义 `Animal` 和 `Dog`，让 `Dog` 重写 `speak`。
2. 使用 `super` 扩展父类初始化逻辑。
3. 使用 `ancestors` 查看方法查找链。

## 小结

继承表达“是一种”的关系。Ruby 支持继承，但 Ruby 代码并不鼓励把所有复用都放进继承层级。

