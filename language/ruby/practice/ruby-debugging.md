---
sidebar_position: 6
sidebar_label: 调试与排错
slug: /ruby-debugging
---

# Ruby 调试与排错

调试不是猜。你需要观察错误信息、变量状态、调用栈和输入数据，一步步缩小问题范围。

## 先读异常信息

Ruby 报错通常包含异常类型、错误消息和调用栈：

```text
NoMethodError: undefined method `name' for nil:NilClass
```

这句话告诉你：你对 `nil` 调用了 `name` 方法。

常见异常：

- `NoMethodError`：对象没有这个方法。
- `NameError`：变量或常量找不到。
- `ArgumentError`：参数不合法。
- `LoadError`：文件或 gem 加载失败。
- `Errno::ENOENT`：文件不存在。

## 使用 p 和 pp

`p` 输出对象的调试形式：

```ruby
p user
p user.class
p user.respond_to?(:name)
```

复杂数据可以使用 `pp`：

```ruby
require "pp"

pp data
```

## 缩小问题范围

不要在整个程序里乱改。你可以这样排查：

1. 确认错误发生在哪一行。
2. 输出这一行涉及的变量。
3. 查看变量类型和值。
4. 往前找变量从哪里来。
5. 写一个小测试固定问题。

## 使用 debug

Ruby 项目常用 `debug` 进行断点调试：

```ruby
binding.break
```

运行到这里时，程序会暂停，你可以查看变量、逐步执行。

具体命令和安装方式以 `debug` gem 文档为准。

## 常见错误排查示例

```ruby
user = nil
puts user.name
```

排查：

```ruby
p user
p user.class
```

你会看到 `user` 是 `nil`。真正要修的不是 `puts`，而是上游为什么没有得到用户对象。

## 小结

排错时先读错误信息，再看调用栈和变量状态。优秀的调试不是试运气，而是不断验证假设。

