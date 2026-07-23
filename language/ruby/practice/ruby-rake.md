---
sidebar_position: 2
sidebar_label: Rake 任务
slug: /ruby-rake
---

# Ruby Rake 任务

Rake 是 Ruby 常用任务工具。你可以用它把测试、构建、清理、生成文件等常用操作写成项目命令。

## 最小 Rakefile

创建 `Rakefile`：

```ruby title="Rakefile"
task :hello do
  puts "Hello from Rake"
end
```

运行：

```bash
rake hello
```

如果项目用 Bundler：

```bash
bundle exec rake hello
```

## 默认任务

```ruby title="Rakefile"
task default: :test

task :test do
  ruby "test/my_tool_test.rb"
end
```

运行：

```bash
rake
```

会执行默认任务。

## desc 描述任务

```ruby
desc "Run tests"
task :test do
  puts "running tests"
end
```

查看任务列表：

```bash
rake -T
```

## 任务依赖

```ruby
task build: [:clean] do
  puts "build"
end

task :clean do
  puts "clean"
end
```

运行 `rake build` 时会先执行 `clean`。

## Rake 适合什么

- 运行测试
- 清理临时文件
- 生成文档
- 批量处理资源
- 封装常用开发命令

## 小练习

1. 写一个 `hello` 任务。
2. 写一个默认任务，让 `rake` 自动执行测试。
3. 使用 `desc` 并运行 `rake -T` 查看说明。

## 小结

Rake 把项目常用操作变成可重复命令。它不只是构建工具，也是 Ruby 项目的自动化入口。

