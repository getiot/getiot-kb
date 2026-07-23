---
sidebar_position: 0
sidebar_label: 命令行工具实战
slug: /ruby-cli-project
---

# Ruby 命令行工具实战

这一节做一个简单命令行工具：读取文本文件，并统计行数、单词数和字节数。它类似简化版 `wc`。

你会用到：

- `ARGV`
- `File.foreach`
- 字符串切分
- 错误处理
- 格式化输出

## 需求

命令格式：

```bash
ruby mini_wc.rb README.md
```

输出类似：

```text
       12       80      520 README.md
```

三列分别是行数、单词数、字节数。

## 完整代码

```ruby title="mini_wc.rb"
filename = ARGV[0]

unless filename
  warn "usage: ruby mini_wc.rb <file>"
  exit 1
end

unless File.file?(filename)
  warn "file not found: #{filename}"
  exit 1
end

lines = 0
words = 0
bytes = 0

File.foreach(filename) do |line|
  lines += 1
  words += line.split(/\s+/).reject(&:empty?).count
  bytes += line.bytesize
end

puts "%8d %8d %8d %s" % [lines, words, bytes, filename]
```

## 为什么逐行读取

你可以用 `File.read(filename)` 一次性读取整个文件，但大文件会占用更多内存。逐行读取更适合命令行工具。

## 可以继续改进

- 支持多个文件。
- 支持从标准输入读取。
- 使用 `OptionParser` 添加 `--help`。
- 给统计逻辑写 Minitest 测试。
- 区分文本编码错误。

## 小结

这个小项目把 Ruby 基础能力串起来了：命令行参数、文件读取、字符串处理和错误提示。Ruby 很适合写这类可靠的小工具。

