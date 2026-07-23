---
sidebar_position: 3
sidebar_label: 项目结构
slug: /ruby-project-structure
---

# Ruby 项目结构

Ruby 可以写单文件脚本，也可以组织成完整项目。项目结构的目标不是复杂，而是让入口、业务逻辑、测试和依赖各就各位。

## 一个常见结构

```text
my_tool/
├── bin/
│   └── my_tool
├── lib/
│   ├── my_tool.rb
│   └── my_tool/version.rb
├── test/
│   └── my_tool_test.rb
├── Gemfile
├── Rakefile
└── README.md
```

各部分作用：

- `bin/`：可执行入口，负责读取参数和调用核心逻辑。
- `lib/`：主要 Ruby 代码，应该可复用、可测试。
- `test/`：Minitest 测试。
- `spec/`：RSpec 测试，项目使用 RSpec 时常见。
- `Gemfile`：依赖声明。
- `Rakefile`：常用任务。

## 入口文件

```ruby title="bin/my_tool"
#!/usr/bin/env ruby

require_relative "../lib/my_tool"

filename = ARGV[0]
abort "usage: my_tool <file>" unless filename

puts MyTool.count_lines(filename)
```

入口文件应该尽量薄。它负责接收输入、输出结果和处理命令行边界。

## lib 文件

```ruby title="lib/my_tool.rb"
module MyTool
  def self.count_lines(path)
    File.foreach(path).count
  end
end
```

核心逻辑放在 `lib/` 后，你就可以在测试里直接调用它。

## 测试文件

```ruby title="test/my_tool_test.rb"
require "minitest/autorun"
require_relative "../lib/my_tool"

class MyToolTest < Minitest::Test
  def test_count_lines
    assert_equal 3, MyTool.count_lines("sample.txt")
  end
end
```

实际测试里会使用临时文件，避免依赖不稳定的本地文件。

## 从脚本演进成项目

你可以这样演进：

1. 先写 `script.rb` 解决问题。
2. 把可复用逻辑提取成方法。
3. 把方法移动到 `lib/`。
4. 给 `lib/` 中的逻辑写测试。
5. 把命令行入口放进 `bin/`。

## 小结

好的项目结构让代码更容易测试和复用。Ruby 项目不需要一开始复杂，但当脚本开始变长时，要及时拆出 `bin/`、`lib/` 和测试。

