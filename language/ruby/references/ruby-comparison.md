---
sidebar_position: 2
sidebar_label: Ruby 与其他语言对比
slug: /ruby-comparison
---

# Ruby 与 Python / JavaScript 对比

如果你学过 Python 或 JavaScript，可以用对比帮助理解 Ruby。但对比只是桥梁，最终你还是要按 Ruby 的方式写 Ruby。

## Ruby 和 Python

相似点：

- 都是动态语言。
- 都适合脚本、Web 和自动化。
- 都有丰富标准库和包管理生态。

差异点：

- Python 更强调显式和统一风格。
- Ruby 更强调表达力、对象消息调用和 block。
- Ruby 社区更常用 DSL 风格写法。

Ruby 写法示例：

```ruby
3.times { puts "hello" }
```

Python 通常会写成循环：

```python
for _ in range(3):
    print("hello")
```

## Ruby 和 JavaScript

相似点：

- 都是动态语言。
- 函数或可执行逻辑都可以被传递。
- 都适合 Web 相关开发。

差异点：

- JavaScript 深度绑定浏览器和事件循环生态。
- Ruby 更常见于服务端、脚本和 Rails 应用。
- Ruby 的 block、Module、Mixin 和对象模型有自己的风格。

## 从其他语言迁移时的提醒

从 Python 来：不要把所有 Ruby 都写成普通 `for` 循环，多学习 Enumerable。

从 JavaScript 来：不要把 Ruby block 完全等同于 JS callback，它们相似但语法和运行模型不同。

从 Java/C++ 来：不要一开始就过度设计继承层级，Ruby 更常用小对象和 Mixin。

## 小结

对比能帮助入门，但不要让旧语言习惯限制 Ruby。Ruby 的核心是对象、block、Enumerable、Module 和清晰命名。

