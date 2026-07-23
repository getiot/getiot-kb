---
sidebar_position: 8
sidebar_label: 注释与代码风格
slug: /ruby-comments-style
---

# Ruby 注释与代码风格

Ruby 代码应该尽量自然可读。好的命名和结构比大量注释更重要。注释应该解释背景、原因和注意事项，而不是重复代码表面行为。

## 单行注释

```ruby
# 配置文件不存在时使用默认配置，避免脚本直接退出。
config = {}
```

这类注释说明了为什么这样做。

不太好的注释：

```ruby
# 把 1 赋值给 count
count = 1
```

这只是重复代码。

## 多行说明

Ruby 支持：

```ruby
=begin
这是一段多行注释。
=end
```

但实际项目里更常见的是连续单行注释：

```ruby
# 这里不能直接删除旧文件。
# 部分设备上传日志时可能还在写入，
# 所以先移动到归档目录，稍后再清理。
```

## 命名风格

局部变量和方法使用小写加下划线：

```ruby
user_name = "Alice"

def send_message
end
```

常量使用大写：

```ruby
MAX_RETRY = 3
```

类名和模块名使用大驼峰：

```ruby
class UserProfile
end
```

## 方法长度

如果一个方法里同时做了读取文件、解析数据、计算结果、输出报表，它可能太长了。你可以拆成几个方法：

```ruby
def read_text(path)
  File.read(path)
end

def count_words(text)
  text.split(/\s+/).reject(&:empty?).count
end
```

## RuboCop

Ruby 社区常用 RuboCop 检查风格：

```bash
bundle exec rubocop
```

它能提醒缩进、命名、复杂度等问题。初学时不必死背所有规则，但要学会读懂提示。

## 写给初学者的风格建议

- 不要为了省行数牺牲清晰。
- 条件复杂时，先提取有意义的变量名。
- 方法名要表达动作，例如 `load_config`、`send_message`。
- 返回布尔值的方法用 `?`，例如 `valid?`。
- 会修改对象的方法谨慎使用 `!`。

## 小练习

1. 把一段超过 20 行的方法拆成两个小方法。
2. 给一个复杂条件提取变量名。
3. 写一个以 `?` 结尾的布尔方法。

## 小结

Ruby 的优雅不是靠少写字符，而是靠清楚表达。命名、方法拆分和适量注释，是你写出可维护 Ruby 的基础。

