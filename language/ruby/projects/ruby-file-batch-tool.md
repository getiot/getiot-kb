---
sidebar_position: 1
sidebar_label: 文件批处理工具
slug: /ruby-file-batch-tool
---

# Ruby 文件批处理工具

这个项目会批量重命名当前目录下的 `.txt` 文件，为它们添加前缀。批量文件操作很实用，也很危险，所以我们会先加入 dry-run 模式。

## 需求

运行：

```bash
ruby rename_txt.rb old --dry-run
```

输出计划重命名的文件，但不真正执行。

去掉 `--dry-run` 后才真正重命名。

## 完整代码

```ruby title="rename_txt.rb"
prefix = ARGV[0]
dry_run = ARGV.include?("--dry-run")

unless prefix
  warn "usage: ruby rename_txt.rb <prefix> [--dry-run]"
  exit 1
end

paths = Dir.glob("*.txt")

if paths.empty?
  puts "no .txt files found"
  exit 0
end

paths.each do |path|
  new_path = "#{prefix}_#{path}"

  if File.exist?(new_path)
    warn "skip: #{new_path} already exists"
    next
  end

  puts "#{path} -> #{new_path}"
  File.rename(path, new_path) unless dry_run
end
```

## 为什么需要 dry-run

批量重命名、删除、移动文件都可能造成数据损失。dry-run 先打印计划，让你确认没有问题后再执行。

:::warning
真实批处理脚本建议先在测试目录运行，并确认 git 或备份状态。
:::

## 可以继续改进

- 支持递归目录。
- 支持正则替换。
- 写入操作日志。
- 添加撤销文件。
- 使用 `OptionParser` 管理参数。

## 小结

Ruby 写批处理脚本很顺手，但越是短脚本越要注意安全边界。先 dry-run，再执行，这是好习惯。

