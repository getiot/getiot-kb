---
sidebar_position: 1
sidebar_label: Bundler 依赖管理
slug: /ruby-bundler
---

# Ruby Bundler 依赖管理

Bundler 用来按项目管理 gem 依赖。它解决的问题是：这个项目到底需要哪些 gem、这些 gem 分别是什么版本、怎样让别人也安装同样的依赖。

## Gemfile

`Gemfile` 描述项目依赖：

```ruby title="Gemfile"
source "https://rubygems.org"

gem "json"
gem "rake"
```

安装依赖：

```bash
bundle install
```

Bundler 会解析依赖并生成 `Gemfile.lock`。

## Gemfile.lock

`Gemfile` 描述你想要什么，`Gemfile.lock` 记录实际解析出的精确版本。

应用项目通常应该提交 `Gemfile.lock`，这样团队和部署环境能使用一致依赖。

library gem 是否提交 `Gemfile.lock` 要看项目约定，但初学阶段你可以先按应用项目理解。

## bundle exec

运行项目中的工具命令时，常用：

```bash
bundle exec rake test
bundle exec rubocop
```

`bundle exec` 的作用是：在当前项目的依赖环境中运行命令，避免误用全局其他版本。

## 分组依赖

```ruby title="Gemfile"
group :development, :test do
  gem "rubocop"
  gem "rspec"
end
```

开发和测试工具可以放到对应 group。

## 加载 Bundler 环境

在脚本中可以写：

```ruby
require "bundler/setup"
require "json"
```

这样脚本会使用 Bundler 解析后的依赖环境。

## 常见错误

忘记运行 `bundle install`：项目找不到依赖。

忘记 `bundle exec`：命令使用了全局 gem 版本，结果和项目不一致。

随意删除 `Gemfile.lock`：依赖版本可能重新解析，导致行为变化。

## 小练习

1. 创建一个 `Gemfile`，添加 `rake`。
2. 运行 `bundle install` 并观察生成的 `Gemfile.lock`。
3. 使用 `bundle exec` 运行一个项目命令。

## 小结

Bundler 是 Ruby 项目的依赖地基。只要项目依赖 gem，就应该理解 `Gemfile`、`Gemfile.lock` 和 `bundle exec`。

