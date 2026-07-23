---
sidebar_position: 8
sidebar_label: 时间与日期
slug: /ruby-time-date
---

# Ruby 时间与日期

Ruby 使用 `Time` 表示具体时间点，使用标准库 `date` 中的 `Date` 表示日期。时间处理看似简单，但涉及时区、格式和业务规则时很容易出错。

## Time

```ruby
now = Time.now

puts now
puts now.year
puts now.month
puts now.day
puts now.hour
puts now.min
puts now.sec
```

`Time.now` 返回当前时间。

## 格式化时间

```ruby
now = Time.now

puts now.strftime("%Y-%m-%d %H:%M:%S")
```

常见格式：

- `%Y`：四位年份
- `%m`：两位月份
- `%d`：两位日期
- `%H`：小时
- `%M`：分钟
- `%S`：秒

## Unix timestamp

```ruby
puts Time.now.to_i
```

`to_i` 返回 Unix timestamp，单位是秒。

## Date

使用 `Date` 需要加载标准库：

```ruby
require "date"

today = Date.today

puts today
puts today.next_day
puts today.prev_day
```

Date 更适合处理“某一天”，例如生日、账单日、排班日期。

## 解析日期

```ruby
require "date"

date = Date.parse("2026-07-23")
puts date
```

外部输入格式不稳定时，不要盲目信任 `parse`。更严格的解析可以使用指定格式的方法。

## 时区提醒

Ruby 标准库能处理基础时间，但复杂 Web 应用通常会依赖框架或库来管理时区。例如 Rails 有自己的时区配置。

:::warning
涉及订单、日志、设备数据、跨地区用户时，要明确使用本地时间还是 UTC。不要在系统里混用时间语义。
:::

## 小练习

1. 输出当前时间的年月日。
2. 使用 `strftime` 输出 `YYYY-MM-DD` 格式。
3. 使用 `Date.today.next_day` 得到明天日期。

## 小结

时间点用 `Time`，日期用 `Date`。处理格式、时区和外部输入时，要比普通字符串更谨慎。

