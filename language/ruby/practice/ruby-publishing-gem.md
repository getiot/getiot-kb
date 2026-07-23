---
sidebar_position: 8
sidebar_label: 发布 gem
slug: /ruby-publishing-gem
---

# 发布 Ruby gem

当你写了可复用的 Ruby library，可以把它打包成 gem 发布到 RubyGems.org。发布之前，你要先确认代码、文档、测试和版本号都足够清楚。

## gem 的基本结构

```text
my_tool/
├── lib/
│   ├── my_tool.rb
│   └── my_tool/version.rb
├── my_tool.gemspec
├── Gemfile
├── README.md
└── LICENSE
```

`lib/` 放代码，`.gemspec` 描述 gem 元数据。

## gemspec

```ruby title="my_tool.gemspec"
Gem::Specification.new do |spec|
  spec.name = "my_tool"
  spec.version = "0.1.0"
  spec.summary = "A simple Ruby tool"
  spec.authors = ["Your Name"]
  spec.files = Dir["lib/**/*.rb"]
  spec.required_ruby_version = ">= 3.2"
  spec.license = "MIT"
end
```

重要字段：

- `name`：gem 名称，发布到 RubyGems.org 后必须唯一。
- `version`：版本号。
- `summary`：简短说明。
- `files`：打包哪些文件。
- `required_ruby_version`：支持的 Ruby 版本。
- `license`：许可证。

## 构建 gem

```bash
gem build my_tool.gemspec
```

构建后会生成 `.gem` 文件。

## 本地安装测试

```bash
gem install ./my_tool-0.1.0.gem
```

先在本地确认 gem 能被正常安装和 `require`。

## 发布

```bash
gem push my_tool-0.1.0.gem
```

发布前需要 RubyGems.org 账号和 API key。

:::warning
发布出去的版本号不能随意覆盖。修复问题通常要提升版本号，例如 `0.1.0` 到 `0.1.1`。
:::

## 发布前检查清单

- README 说明用途和示例。
- 有基本测试。
- gem 名称不和别人冲突。
- 版本号符合语义化版本习惯。
- 不把敏感文件打包进去。
- 许可证明确。

## 小结

发布 gem 是把你的 Ruby 代码交给别人使用。不要只让它“能跑”，还要让别人知道怎么安装、怎么使用、支持什么环境。

