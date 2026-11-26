---
sidebar_position: 4
slug: /web-format-csv
---

# CSV 格式



CSV 是一种在互联网中常见的数据交换格式，如果你使用过 Excel 表格，那应该会对它有印象。



## 数据格式

CSV 是 Comma-Separated Values 的缩写，即“逗号分隔值”。顾名思义，它使用逗号分隔每一项数据。实际上，除了使用逗号，CSV 也允许你使用其他分隔字符，只要该字符不包含在数据内容里面即可。

```javascript
Rudy;male;26,Tina;female;26,Terry;male;8
```



## 优缺点

CSV 格式的好处是轻量（占用少量空间），也很容易解析。例如，JavaScript 的字符串对象有一个 `split()` 方法，能把字符串分割成数组元素。

```javascript
var str = "Rudy;male;26,Tina;female;26,Terry;male;8";
var data = str.split(",");

console.log(data[0]);
console.log(data[1]);
console.log(data[2]);
```

CSV 格式的缺点是，有时我们无法从字面上看出每个元素所代表的意义。相对来说，代码也没那么好阅读和维护。假如要在 CSV 文本中插入其他数据，那么可能会影响整体结构，同时相应的程序也要一并修改，否则可能会产生意想不到的效果。

