---
sidebar_position: 10
sidebar_label: CSV 格式
slug: /csv
---

# CSV 格式（结构化数据）

**CSV**（Comma-Separated Values，逗号分隔值）起源于 1970 年代大型机数据交换需求，以纯文本形式存储表格数据。每行表示一条记录，字段间用逗号分隔（可扩展为其他符号），支持 Excel 等工具直接读写。其特点是结构简单、体积小，但缺乏数据类型定义和复杂关系描述能力，适用于数据导入导出和基础统计分析。



## 格式简介

CSV 是一种用纯文本形式存储表格数据的文件格式，由 RFC 4180 标准定义。虽然名为"逗号分隔值"，但实际上可以使用多种分隔符，包括逗号（`,`）、分号（`;`）、制表符（`\t`）等。CSV 格式被广泛用于数据交换，特别是在电子表格、数据库和应用程序之间传输数据。

CSV 文件没有固定的 MIME 类型，常见的有 `text/csv`、`text/plain` 或 `application/csv`。文件扩展名通常为 `.csv`。



## 技术特点

### 基本规则

1. **记录分隔**：每行表示一条记录（行结束符为 `\n` 或 `\r\n`）
2. **字段分隔**：字段之间使用分隔符（通常是逗号）分隔
3. **引号处理**：包含分隔符、换行符或引号的字段需要用双引号包裹
4. **转义规则**：字段内的双引号需要用两个连续的双引号（`""`）表示

### 编码支持

CSV 文件通常使用 UTF-8 编码，但也可以使用其他编码（如 GBK、Latin-1 等）。为了确保兼容性，建议在文件开头添加 BOM（Byte Order Mark）或明确声明编码方式。

### 分隔符变体

虽然标准使用逗号，但不同地区可能使用不同分隔符：

- **逗号（`,`）**：英语地区标准，RFC 4180 推荐
- **分号（`;`）**：欧洲地区常用，因为逗号用作小数分隔符
- **制表符（`\t`）**：TSV（Tab-Separated Values）格式
- **管道符（`|`）**：某些系统使用



## 文件结构

CSV 文件的基本结构如下：

```csv showLineNumbers
[可选标题行]
字段1,字段2,字段3
值1,值2,值3
值4,值5,值6
...
```

### 示例

**简单 CSV 文件：**

```csv showLineNumbers
姓名,年龄,城市
张三,25,北京
李四,30,上海
王五,28,广州
```

**包含特殊字符的 CSV 文件：**

```csv showLineNumbers
姓名,描述,价格
商品A,"这是一个包含,逗号的描述",99.99
商品B,"包含""引号""的描述",199.99
商品C,"多行
描述",299.99
```



## 使用场景

### 适用场景

- **数据导入导出**：数据库、电子表格之间的数据交换
- **数据分析**：统计分析、数据挖掘的原始数据格式
- **日志记录**：结构化日志数据的存储
- **配置管理**：简单的配置数据存储
- **API 数据交换**：RESTful API 的数据响应格式之一

### 优缺点

**优点：**

- 格式简单，易于生成和解析
- 人类可读，可直接用文本编辑器查看
- 体积小，传输效率高
- 广泛支持，几乎所有数据处理工具都支持
- 跨平台兼容性好

**缺点：**

- 缺乏数据类型定义，所有值都是字符串
- 无法表示复杂的数据结构（嵌套、数组等）
- 没有标准化的元数据（编码、分隔符等）
- 处理大文件时性能较差
- 容易出现编码和分隔符不一致的问题



## 代码示例

### Python 读取 CSV

```python showLineNumbers
import csv

# 读取 CSV 文件
with open('data.csv', 'r', encoding='utf-8') as f:
    reader = csv.reader(f)
    for row in reader:
        print(row)

# 使用 pandas 读取
import pandas as pd
df = pd.read_csv('data.csv', encoding='utf-8')
print(df)
```

### Python 写入 CSV

```python showLineNumbers
import csv

# 写入 CSV 文件
data = [
    ['姓名', '年龄', '城市'],
    ['张三', 25, '北京'],
    ['李四', 30, '上海']
]

with open('output.csv', 'w', encoding='utf-8', newline='') as f:
    writer = csv.writer(f)
    writer.writerows(data)
```

### JavaScript 解析 CSV

```javascript showLineNumbers
// 简单的 CSV 解析
function parseCSV(text) {
    const lines = text.split('\n');
    const headers = lines[0].split(',');
    const data = [];
    
    for (let i = 1; i < lines.length; i++) {
        const values = lines[i].split(',');
        const obj = {};
        headers.forEach((header, index) => {
            obj[header] = values[index];
        });
        data.push(obj);
    }
    
    return data;
}
```



## 相关工具

- **电子表格软件**：Microsoft Excel、Google Sheets、LibreOffice Calc
- **命令行工具**：`csvkit`、`xsv`（Rust 编写的高性能 CSV 工具）
- **在线工具**：各种 CSV 查看器、转换器
- **编程库**：
  - Python: `csv`（标准库）、`pandas`
  - JavaScript: `PapaParse`、`csv-parse`
  - Java: `OpenCSV`、`Apache Commons CSV`



## 参考

- [CSV 格式规范](https://tools.ietf.org/html/rfc4180)
- [Pandas CSV 文档](https://pandas.pydata.org/docs/reference/api/pandas.read_csv.html)
- [CSV - Wikipedia](https://en.wikipedia.org/wiki/Comma-separated_values)
