---
sidebar_position: 0
sidebar_label: 文件读写
slug: /ruby-file-io
---

# Ruby 文件读写

Ruby 很适合写文件处理脚本。你可以用标准库中的 `File` 读取、写入和追加文件内容。

## 读取整个文件

```ruby
content = File.read("data.txt")
puts content
```

这种方式简单直接，适合小文件。文件较大时，一次性读入内存可能不合适。

## 逐行读取

```ruby
File.foreach("data.txt") do |line|
  puts line.chomp
end
```

`File.foreach` 会逐行读取，适合处理日志、CSV-like 文本等较大文件。

`line` 通常包含换行符，所以常配合 `chomp`。

## 写入文件

```ruby
File.write("output.txt", "Hello, Ruby\n")
```

`File.write` 会创建文件；如果文件已经存在，会覆盖原内容。

:::warning
写入文件前一定确认路径正确。批处理脚本建议先提供 dry-run 模式，只打印计划操作，不直接修改文件。
:::

## 追加内容

```ruby
File.open("output.txt", "a") do |file|
  file.puts "new line"
end
```

模式 `"a"` 表示 append，也就是追加。

## 使用 block 自动关闭文件

```ruby
File.open("data.txt", "r") do |file|
  puts file.read
end
```

block 结束后，Ruby 会自动关闭文件。这比手动 `close` 更安全。

## 处理错误

```ruby
begin
  content = File.read("missing.txt")
  puts content
rescue Errno::ENOENT
  warn "文件不存在"
rescue Errno::EACCES
  warn "没有权限读取文件"
end
```

文件操作经常失败：路径不存在、权限不足、文件被占用、磁盘问题都可能发生。

## 小练习

1. 读取一个文本文件并输出行号。
2. 把用户输入追加到 `notes.txt`。
3. 捕获文件不存在错误并输出友好提示。

## 小结

小文件可以用 `File.read`，大文件优先逐行处理。写文件前要明确覆盖还是追加，并认真处理文件路径和错误。

