---
sidebar_position: 0
sidebar_label: RubyGems 与 gem
slug: /ruby-gems
---

# RubyGems 与 gem

Gem 是 Ruby 生态中分发库和工具的包格式，RubyGems 是管理 gem 的系统。你可以把 gem 理解成 Ruby 世界里的“可安装软件包”。

## gem 能解决什么问题

假设你要写一个 Web 应用、解析命令行参数、连接数据库或格式化 JSON。你不需要全部从零写起，可以安装社区已有 gem。

常见 gem 类型包括：

- library：给 Ruby 代码 `require` 后使用。
- command line tool：安装后提供命令行命令。
- framework：例如 Rails、Sinatra。
- development tool：例如 RuboCop、RSpec。

## 查看 gem 环境

```bash
gem -v
gem env
gem list
```

`gem env` 可以看到 gem 安装路径、Ruby 版本和配置。

## 安装 gem

```bash
gem install rake
```

安装后，如果它是库，可以在代码中加载：

```ruby
require "rake"
```

如果它提供命令，也可能可以直接运行对应命令。

## 卸载 gem

```bash
gem uninstall rake
```

## 全局安装和项目依赖

你可以用 `gem install` 全局安装工具，但真实项目的依赖不要只靠全局 gem。否则你的电脑能跑，别人电脑可能不能跑。

项目依赖应该写进 `Gemfile`，然后用 Bundler 管理。

## 常见错误

`cannot load such file`：通常是 gem 没安装，或当前运行环境没有加载对应依赖。

命令找不到：可能 gem 的可执行文件路径没有加入 `PATH`，或你当前 Ruby 版本不是安装该 gem 的版本。

版本冲突：不同项目需要不同 gem 版本，应该用 Bundler 隔离。

## 小练习

1. 运行 `gem env` 查看本机 gem 环境。
2. 安装一个小工具 gem，然后查看 `gem list`。
3. 思考为什么项目依赖不应该只靠全局安装。

## 小结

RubyGems 负责安装 gem，但项目级依赖应该交给 Bundler。你要区分“全局工具”和“项目依赖”。

