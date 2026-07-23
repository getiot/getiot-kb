---
sidebar_position: 4
sidebar_label: Minitest 测试
slug: /ruby-minitest
---

# Ruby Minitest 测试

Minitest 是 Ruby 标准库中的测试框架。它轻量、直接，适合初学者给小项目写测试。

## 为什么要写测试

测试能帮你确认代码行为是否符合预期。尤其当你修改代码时，测试能快速告诉你有没有破坏原有功能。

比如你写了一个统计行数的方法：

```ruby
module TextTool
  def self.line_count(text)
    text.lines.count
  end
end
```

你可以用测试固定它的行为。

## 最小测试

```ruby title="test/text_tool_test.rb"
require "minitest/autorun"

module TextTool
  def self.line_count(text)
    text.lines.count
  end
end

class TextToolTest < Minitest::Test
  def test_line_count
    assert_equal 2, TextTool.line_count("a\nb\n")
  end
end
```

运行：

```bash
ruby test/text_tool_test.rb
```

## 常用断言

```ruby
assert value
refute value
assert_equal expected, actual
assert_nil value
assert_includes list, item
```

`assert_equal expected, actual` 的顺序很重要：先写期望值，再写实际值。

## setup

如果多个测试需要相同准备，可以用 `setup`：

```ruby
class UserTest < Minitest::Test
  def setup
    @user = { name: "Alice" }
  end

  def test_name
    assert_equal "Alice", @user[:name]
  end
end
```

每个测试方法执行前都会运行 `setup`。

## 小练习

1. 给 `add(a, b)` 写测试。
2. 给字符串清理方法 `strip_name(name)` 写测试。
3. 写一个测试验证空数组长度为 0。

## 小结

Minitest 是 Ruby 初学者很好的测试入口。先给纯函数和小模块写测试，再逐步测试文件、命令行和网络边界。

