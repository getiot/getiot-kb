---
sidebar_position: 7
sidebar_label: RuboCop 与格式规范
slug: /ruby-rubocop
---

# Ruby RuboCop 与格式规范

RuboCop 是 Ruby 常用的代码风格和静态检查工具。它能帮助团队保持一致风格，也能提醒一些容易出错或过于复杂的代码。

## 添加到项目

在 `Gemfile` 中加入：

```ruby title="Gemfile"
group :development do
  gem "rubocop", require: false
end
```

安装后运行：

```bash
bundle exec rubocop
```

## 自动修复

```bash
bundle exec rubocop -a
```

更激进的修复：

```bash
bundle exec rubocop -A
```

:::warning
自动修复前先确认 git 工作区干净，避免把大量格式变化和功能修改混在一起。
:::

## 配置文件

```yaml title=".rubocop.yml"
AllCops:
  NewCops: enable
```

团队可以在配置文件里约定行宽、启用或禁用规则。

## RuboCop 不是绝对真理

RuboCop 的建议大多有帮助，但不是所有规则都适合每个项目。你应该理解规则背后的意图，而不是机械服从。

如果某条规则不适合项目，可以在 `.rubocop.yml` 中调整。

## 小练习

1. 给项目添加 RuboCop。
2. 运行 `bundle exec rubocop` 查看问题。
3. 使用 `-a` 自动修复，再检查 diff。

## 小结

RuboCop 能让 Ruby 代码风格更一致。初学时把它当作老师的提醒，而不是惩罚器。

