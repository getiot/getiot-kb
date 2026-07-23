---
sidebar_position: 5
sidebar_label: 脚本与项目结构
slug: /ruby-script-project
---

# Ruby 脚本与项目结构

Ruby 很适合从一个脚本开始。你可以先写一个 `.rb` 文件解决问题，等代码变长、逻辑变复杂，再把它整理成项目。

## 单文件脚本

创建 `greet.rb`：

```ruby title="greet.rb"
name = ARGV[0] || "Ruby"
puts "Hello, #{name}!"
```

运行：

```bash
ruby greet.rb Alice
```

输出：

```text
Hello, Alice!
```

`ARGV` 是命令行参数数组。`ARGV[0]` 表示第一个参数。

## 脚本什么时候该拆分

如果脚本只有十几行，放在一个文件里很正常。但出现下面情况时，就应该考虑拆分：

- 文件超过几十行，滚动阅读很费劲。
- 同一段逻辑要在多个地方复用。
- 你想给核心逻辑写测试。
- 命令行参数、文件处理、业务计算混在一起。

拆分不是为了显得高级，而是为了让代码更容易理解和修改。

## 一个小项目结构

```bash
my_tool/
├── bin/
│   └── my_tool
├── lib/
│   └── my_tool.rb
├── test/
│   └── my_tool_test.rb
├── Gemfile
└── README.md
```

常见约定是：

- `bin/` 放可执行入口。
- `lib/` 放主要功能代码。
- `test/` 或 `spec/` 放测试。
- `Gemfile` 描述依赖。
- `README.md` 说明项目用途和用法。

## 入口和逻辑分离

`bin/my_tool` 可以负责读取命令行参数：

```ruby title="bin/my_tool"
#!/usr/bin/env ruby

require_relative "../lib/my_tool"

name = ARGV[0] || "Ruby"
puts MyTool.greet(name)
```

`lib/my_tool.rb` 放可测试的核心逻辑：

```ruby title="lib/my_tool.rb"
module MyTool
  def self.greet(name)
    "Hello, #{name}!"
  end
end
```

这样做的好处是：以后你可以单独测试 `MyTool.greet`，而不是只能手动运行整个脚本。

## require 和 require_relative

同一个项目内引用相对路径，常用：

```ruby
require_relative "../lib/my_tool"
```

加载标准库或 gem，常用：

```ruby
require "json"
```

## 小结

Ruby 项目可以从脚本自然长大。初学时不要急着设计复杂目录，但要尽早养成“入口负责协调，核心逻辑放到可复用文件”的习惯。

