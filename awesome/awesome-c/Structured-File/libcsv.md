---
sidebar_position: 3
slug: /libcsv
---

# libcsv 使用教程

**libcsv** 是用纯 ANSI C89 编写的小型、简单、快速的 CSV 库，可以读取和写入 CSV 文件、解析 CSV 数据。它提供了一个简单的接口，使用回调函数来处理解析的字段和行，并且可以解析不正确格式化的 CSV 文件。



## CSV 文件

CSV文件（Comma-separated values），就是逗号分隔的数据文件，常用于数据集成的数据交换部分标准部分。CSV 没有正式标准，但是国际互联网工程任务组（IETF）给推荐标准 RFC 4180 描述了 CSV 文件的结构。

```bash showLineNumbers title="CSV 格式"
Name,Age,City
John,25,New York
Alice,30,Los Angeles
Bob,28,Chicago
```





