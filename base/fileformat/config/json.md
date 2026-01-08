---
sidebar_position: 1
sidebar_label: JSON 格式
slug: /json
---

# JSON 文件格式

**JSON**（JavaScript Object Notation，JavaScript 对象表示法）是一种轻量级的数据格式，由 Douglas Crockford 于 2001 年规范并命名，源于 JavaScript 的对象字面量语法。采用**轻量级键值树形结构**，语法简洁、层次结构清晰，同时也易于机器解析和生成，有效的提升了网络传输效率。现为 ECMA-404 国际标准，是 RESTful API 和 NoSQL 数据库的主流数据交换格式。

虽然 JSON 格式起源于 JavaScript，但它采用完全独立于编程语言的文本格式来存储和表示数据，因此得到广泛的应用。



## 格式简介

JSON 是一种轻量级的数据交换格式，采用完全独立于语言的文本格式，但使用了类似于 C 语言家族（包括 C、C++、C#、Java、JavaScript、Perl、Python 等）的习惯。这些特性使 JSON 成为理想的数据交换语言。

JSON 文件扩展名通常为 `.json`，MIME 类型为 `application/json`。JSON 格式现已成为 Web 开发中最常用的数据交换格式之一。



## 技术特点

### 基本语法规则

JSON 对象是一个无序的 "名称/值" 键值对的集合：

- 以 `{` 开始，以 `}` 结束，允许嵌套使用
- 每个名称和值成对出现，名称和值之间使用 `:` 分隔
- 键值对之间用 `,` 分隔
- 在这些字符前后允许存在无意义的空白符

对于值，可以有如下类型：

- **对象**：一个新的 JSON 对象，使用 `{}` 包裹
- **数组**：使用 `[` 和 `]` 表示的有序值列表
- **数字**：直接表示，可以是整数或浮点数
- **字符串**：使用双引号 `" "` 表示
- **布尔值**：`true` 或 `false`（必须小写）
- **空值**：`null`（必须小写）

### 编码支持

JSON 文件必须使用 UTF-8 编码，这是 JSON 规范的要求。JSON 字符串可以包含 Unicode 字符，使用 `\uXXXX` 转义序列表示。

### JSON 标准

- **RFC 7159**：JSON 数据交换格式标准（2014）
- **ECMA-404**：JSON 数据交换标准（2017）
- **RFC 8259**：JSON 文本格式标准（2017，更新 RFC 7159）



## 文件结构

JSON 文件的基本结构：

```json showLineNumbers
{
    "key1": "value1",
    "key2": 123,
    "key3": true,
    "key4": null,
    "key5": {
        "nestedKey": "nestedValue"
    },
    "key6": [1, 2, 3]
}
```

### JSON 示例

**简单对象：**

```json showLineNumbers
{
    "name": "GetIoT",
    "url": "https://getiot.tech",
    "region": "Guangzhou",
    "subjects": ["iot", "linux", "c", "cpp", "python", "javascript"],
    "owner": {
        "count": 1,
        "name": "Rudy",
        "nationality": "China",
        "team": null
    },
    "business": true
}
```

**数组示例：**

```json showLineNumbers
[
    {"id": 1, "name": "项目A"},
    {"id": 2, "name": "项目B"},
    {"id": 3, "name": "项目C"}
]
```



## 使用场景

### 适用场景

- **API 数据交换**：RESTful API 的请求和响应格式
- **配置文件**：应用程序配置文件（如 `package.json`、`tsconfig.json`）
- **数据存储**：NoSQL 数据库（如 MongoDB）的文档格式
- **日志记录**：结构化日志数据
- **前后端通信**：Web 应用前后端数据交换
- **序列化**：对象序列化和反序列化

### 优缺点

**优点：**

- 语法简洁，易于阅读和编写
- 解析速度快，体积小
- 广泛支持，几乎所有编程语言都有 JSON 库
- 人类可读，便于调试
- 支持嵌套结构，表达能力强

**缺点：**

- 不支持注释（某些实现支持）
- 数据类型有限（无日期、函数等）
- 不支持循环引用
- 大文件解析可能较慢
- 没有模式验证（需要 JSON Schema）



## 代码示例

### Python 处理 JSON

```python showLineNumbers
import json

# 读取 JSON 文件
with open('data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
    print(data)

# 写入 JSON 文件
data = {
    "name": "GetIoT",
    "url": "https://getiot.tech"
}

with open('output.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

# JSON 字符串解析
json_string = '{"name": "GetIoT", "url": "https://getiot.tech"}'
data = json.loads(json_string)
print(data)
```

### JavaScript 处理 JSON

```javascript showLineNumbers
// 解析 JSON 字符串
const jsonString = '{"name": "GetIoT", "url": "https://getiot.tech"}';
const data = JSON.parse(jsonString);
console.log(data);

// 转换为 JSON 字符串
const obj = {
    name: "GetIoT",
    url: "https://getiot.tech"
};
const jsonString = JSON.stringify(obj, null, 2);
console.log(jsonString);

// 读取 JSON 文件（Node.js）
const fs = require('fs');
const data = JSON.parse(fs.readFileSync('data.json', 'utf8'));
```

### Java 处理 JSON

```java showLineNumbers
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;

// 读取 JSON
ObjectMapper mapper = new ObjectMapper();
MyObject obj = mapper.readValue(new File("data.json"), MyObject.class);

// 写入 JSON
mapper.writeValue(new File("output.json"), obj);
```



## 相关工具

- **在线工具**：
  - [JSON 格式化工具](https://getiot.tech/webtools/json-formatter/)
  - JSONLint：JSON 验证和格式化
  - JSON Formatter：JSON 格式化工具
  - JSON Editor Online：在线 JSON 编辑器
- **编程库**：
  - Python: `json`（标准库）、`ujson`（高性能）
  - JavaScript: `JSON`（内置）、`json5`（支持注释）
  - Java: `Jackson`、`Gson`、`org.json`
  - C++: `nlohmann/json`、`rapidjson`
  - Go: `encoding/json`（标准库）



## 相关链接

- [JSON 官方网站](https://www.json.org)
- [RFC 8259 - JSON 文本格式](https://tools.ietf.org/html/rfc8259)
- [ECMA-404 JSON 标准](https://www.ecma-international.org/publications-and-standards/standards/ecma-404/)



## 参考

- [JSON - Wikipedia](https://en.wikipedia.org/wiki/JSON)
- [JSON Schema](https://json-schema.org/)
- [JSON 最佳实践](https://jsonapi.org/)

