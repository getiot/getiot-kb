---
sidebar_position: 1
sidebar_label: 变量、常量与作用域
slug: /ruby-variables-constants-scope
---

# Ruby 变量、常量与作用域

Ruby 变量不需要声明类型。你可以直接给变量赋值，变量会指向某个对象。

```ruby
name = "Ruby"
age = 30
```

不过，Ruby 变量名的写法很重要，因为它会影响变量的作用域和含义。

## 局部变量

局部变量通常以小写字母或下划线开头：

```ruby
user_name = "Alice"
retry_count = 3
```

局部变量只在当前作用域内有效。

```ruby
def greet
  message = "hello"
  puts message
end

greet
# puts message 这里不能访问 message
```

方法内部的局部变量，方法外部不能直接访问。

## 常量

常量以大写字母开头：

```ruby
APP_NAME = "demo"
MAX_RETRY = 3
```

Ruby 允许重新给常量赋值，但会给出警告。你应该把常量当作不会变化的值使用。

常量也常用于类名和模块名：

```ruby
class User
end

module MyApp
end
```

## 实例变量

实例变量以 `@` 开头，属于某个对象：

```ruby
class User
  def initialize(name)
    @name = name
  end

  def greet
    "Hello, #{@name}"
  end
end
```

`@name` 保存在具体对象里。不同对象有自己的实例变量。

## 类变量和全局变量

类变量以 `@@` 开头：

```ruby
@@count = 0
```

全局变量以 `$` 开头：

```ruby
$debug = true
```

初学时你不需要频繁使用它们。全局变量尤其容易让程序难以维护，因为任何地方都可能修改它。

## 变量只是名字

看这段代码：

```ruby
a = "ruby"
b = a
b.upcase!

puts a
```

`a` 和 `b` 指向同一个字符串对象，所以通过 `b` 修改对象后，`a` 看到的内容也变了。理解“变量指向对象”很重要。

如果你想创建副本，可以使用：

```ruby
b = a.dup
```

## 常见错误

在方法内误以为能访问外部局部变量：

```ruby
name = "Alice"

def greet
  # puts name 这里访问不到外面的 name
end
```

如果方法需要数据，应该通过参数传入：

```ruby
def greet(name)
  puts "Hello, #{name}"
end
```

## 小练习

1. 定义 `APP_NAME` 常量并输出。
2. 写一个方法，接收 `name` 参数并返回问候语。
3. 试验字符串变量赋值和 `dup` 的区别。

## 小结

Ruby 变量不需要类型声明，但变量命名会表达作用域。局部变量最常用，常量用于固定值和类名，实例变量用于保存对象状态。

