---
sidebar_position: 4
sidebar_label: 访问控制
slug: /ruby-access-control
---

# Ruby 访问控制

Ruby 使用 `public`、`private` 和 `protected` 控制方法可见性。访问控制的目的不是绝对安全，而是表达对象的使用边界。

## public

默认方法是 public，可以被外部调用：

```ruby
class User
  def name
    "Alice"
  end
end

puts User.new.name
```

public 方法组成对象对外提供的 API。

## private

private 方法只能在对象内部以隐式接收者调用，常用于拆分内部逻辑。

```ruby
class User
  def display_name
    normalize_name
  end

  private

  def normalize_name
    "Alice".downcase
  end
end
```

外部不能直接调用：

```ruby
# User.new.normalize_name
```

## protected

protected 方法比较少用。它允许同类或子类对象之间调用，适合某些对象比较场景。

```ruby
class Account
  def initialize(balance)
    @balance = balance
  end

  def richer_than?(other)
    balance > other.balance
  end

  protected

  attr_reader :balance
end
```

外部不能直接读 `balance`，但 `Account` 对象内部可以比较另一个 `Account` 的余额。

## 设计建议

一个对象公开的方法越少，越容易维护。你可以这样思考：

- 外部真的需要调用这个方法吗？
- 这个方法是否只是内部步骤？
- 这个方法名称是否构成稳定 API？

## 小练习

1. 给一个类添加 public 方法和 private 辅助方法。
2. 尝试从外部调用 private 方法，观察错误。
3. 思考哪些方法应该成为对象的公开 API。

## 小结

访问控制表达对象边界。public 是承诺，private 是内部细节。初学时先用好 public 和 private。

