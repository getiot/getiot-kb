---
sidebar_position: 5
sidebar_label: 自动化脚本实践
slug: /ruby-automation-scripts
---

# Ruby 自动化脚本实践

Ruby 很适合把重复操作自动化。这个项目会扫描日志文件，找出包含 `ERROR` 的行，并生成一个错误摘要。

## 目标

运行：

```bash
ruby scan_errors.rb app.log errors.txt
```

读取 `app.log`，把错误行写入 `errors.txt`。

## 完整代码

```ruby title="scan_errors.rb"
input = ARGV[0] || "app.log"
output = ARGV[1] || "errors.txt"

unless File.file?(input)
  warn "input file not found: #{input}"
  exit 1
end

matches = []

File.foreach(input).with_index(1) do |line, line_no|
  next unless line.include?("ERROR")

  matches << "#{line_no}: #{line}"
end

File.write(output, matches.join)

puts "found #{matches.count} error lines"
puts "written to #{output}"
```

## 自动化脚本原则

- 输入路径要校验。
- 危险操作先 dry-run。
- 错误提示要清楚。
- 输出结果要可复查。
- 尽量让脚本可重复运行。

## 可以继续改进

- 支持关键词参数。
- 支持正则匹配。
- 输出 JSON 摘要。
- 统计 ERROR/WARN/INFO 数量。
- 加入日志级别过滤。

## 小结

自动化脚本不一定复杂，但应该可靠。Ruby 的文件处理、字符串处理和命令行体验很适合这类工作。

