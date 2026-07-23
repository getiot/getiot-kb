---
sidebar_position: 1
sidebar_label: 常见错误
slug: /ruby-common-errors
---

# Ruby 常见错误

读懂错误信息，是学习 Ruby 的基本功。不要一看到报错就慌，先看异常类型、第一行错误消息和调用栈中最靠近你代码的位置。

## NoMethodError

```text
undefined method `name' for nil:NilClass
```

意思是：你对 `nil` 调用了 `name` 方法。

排查：

```ruby
p user
p user.class
```

真正要找的是：为什么这里的 `user` 是 `nil`？

## NameError

```text
undefined local variable or method
```

常见原因：

- 变量名拼错。
- 变量不在当前作用域。
- 方法没有定义。
- 常量没有加载。

## ArgumentError

```text
wrong number of arguments
```

常见原因：

- 方法参数数量不对。
- 关键字参数名称写错。
- 传入的数据格式不合法。

## LoadError

```text
cannot load such file
```

常见原因：

- `require` 的文件名写错。
- gem 没安装。
- 没有运行 `bundle install`。
- 没有使用 `bundle exec`。

## Errno::ENOENT

```text
No such file or directory
```

文件不存在或路径错误。先输出当前工作目录：

```ruby
puts Dir.pwd
```

再确认文件路径。

## SyntaxError

常见原因：

- 少写 `end`。
- 字符串引号没闭合。
- 括号不匹配。

## 排错顺序

1. 看异常类型。
2. 看第一行错误消息。
3. 看调用栈中你的文件和行号。
4. 输出相关变量。
5. 写一个最小复现。
6. 修复后补测试。

## 小结

Ruby 错误信息通常已经给了很多线索。你要训练自己读错误，而不是随机修改代码。

