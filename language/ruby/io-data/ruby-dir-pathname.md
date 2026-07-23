---
sidebar_position: 1
sidebar_label: 目录与路径
slug: /ruby-dir-pathname
---

# Ruby 目录与路径

文件批处理、日志分析、构建脚本都会涉及目录和路径。Ruby 提供 `Dir`、`File` 和 `Pathname` 处理这些任务。

## 列出目录内容

```ruby
Dir.children(".").each do |name|
  puts name
end
```

`Dir.children(".")` 返回当前目录下的文件和目录名，不包含 `.` 和 `..`。

## 使用 glob 匹配文件

```ruby
Dir.glob("*.md").each do |path|
  puts path
end
```

递归匹配：

```ruby
Dir.glob("**/*.md").each do |path|
  puts path
end
```

`glob` 很适合批处理脚本。

## 判断路径类型

```ruby
path = "README.md"

puts File.exist?(path)
puts File.file?(path)
puts File.directory?(path)
```

## 拼接路径

```ruby
path = File.join("logs", "app.log")
puts path
```

不要手动拼接 `/`。使用 `File.join` 能让路径处理更稳。

## Pathname

```ruby
require "pathname"

path = Pathname.new("logs/app.log")

puts path.dirname
puts path.basename
puts path.extname
```

`Pathname` 把路径作为对象处理，适合稍复杂的路径操作。

## 创建目录

```ruby
require "fileutils"

FileUtils.mkdir_p("logs/archive")
```

`mkdir_p` 会创建多级目录，如果目录已存在也不会报错。

## 小练习

1. 列出当前目录下所有 `.md` 文件。
2. 判断某个路径是文件还是目录。
3. 使用 `FileUtils.mkdir_p` 创建多级目录。

## 小结

路径处理不要靠字符串硬拼。优先使用 `File.join`、`Dir.glob`、`Pathname` 和 `FileUtils`，代码会更可靠。

