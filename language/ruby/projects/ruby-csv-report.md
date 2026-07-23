---
sidebar_position: 2
sidebar_label: CSV 报表生成器
slug: /ruby-csv-report
---

# Ruby CSV 报表生成器

这个项目读取订单 CSV，统计订单数量、总金额和平均金额，并生成一个新的报表文件。

## 输入文件

```csv title="orders.csv"
id,amount
1,19.9
2,30.1
3,10.0
```

## 完整代码

```ruby title="report.rb"
require "csv"

input = ARGV[0] || "orders.csv"
output = ARGV[1] || "summary.csv"

unless File.file?(input)
  warn "input file not found: #{input}"
  exit 1
end

count = 0
total = 0.0

CSV.foreach(input, headers: true) do |row|
  amount = Float(row.fetch("amount"))
  total += amount
  count += 1
end

average = count.zero? ? 0 : total / count

CSV.open(output, "w") do |csv|
  csv << ["metric", "value"]
  csv << ["count", count]
  csv << ["total", format("%.2f", total)]
  csv << ["average", format("%.2f", average)]
end

puts "report written to #{output}"
```

## 运行

```bash
ruby report.rb orders.csv summary.csv
```

## 你学到了什么

- 使用 `CSV.foreach` 读取表格。
- 使用 `Float()` 严格转换数字。
- 处理空数据。
- 使用 `CSV.open` 写报表。

## 可以继续改进

- 按日期分组统计。
- 按商品分类统计。
- 处理金额格式错误。
- 输出 Markdown 或 HTML 报表。

## 小结

CSV 报表是 Ruby 很适合处理的任务。重点是明确输入格式、处理类型转换、给错误数据留出口。

