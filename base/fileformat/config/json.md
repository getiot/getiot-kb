---
sidebar_position: 1
slug: /json
---

# JSON 文件格式

**JSON** 全称 JavaScript Object Notation，即 JS对象简谱，是一种轻量级的数据格式。

它采用完全独立于编程语言的文本格式来存储和表示数据，语法简洁、层次结构清晰，易于人阅读和编写，同时也易于机器解析和生成，有效的提升了网络传输效率。

官方网站：[https://www.json.org](https://www.json.org)



## JSON 语法规则

JSON 对象是一个无序的 “名称/值” 键值对的集合：

- 以 `{` 开始，以 `}` 结束，允许嵌套使用；
- 每个名称和值成对出现，名称和值之间使用 `:` 分隔；
- 键值对之间用 `,` 分隔；
- 在这些字符前后允许存在无意义的空白符；

对于键值，可以有如下值：

- 一个新的 json 对象；
- 数组：使用 `[` 和 `]` 表示；
- 数字：直接表示，可以是整数，也可以是浮点数；
- 字符串：使用引号 `" "` 表示；
- 字面值：false、null、true 中的一个（必须是小写）；



## JSON 示例

```json showLineNumbers
{
    "name": "GetIoT",
    "url": "https://getiot.tech",
    "region": "Guangzhou",
    "subjects": ["iot", "linux", "c", "cpp", "python", "javascript"],
    "owner":
    {
        "count": 1,
        "name": "Rudy",
        "nationality": "China",
        "team": null,
    },
    "business": true
}
```

