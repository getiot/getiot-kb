---
sidebar_label: jq 命令
sidebar_position: 22
slug: /jq
---

# Linux jq 命令 - JSON 数据处理器



## 介绍

**jq** 是一个轻量级的和灵活的命令行 JSON 处理器，用于解析、查询和转换 JSON 数据。它可以帮助用户在命令行中轻松地处理和操作 JSON 格式的数据。

jq 的一个常见的使用场景是处理 JSON 输入，设置过滤器应用于其 JSON 文本输入，并将过滤器的结果生成为新的 JSON 文本打印到标准输出。最简单的过滤器是 `.`，它将 jq 的输入未经修改地复制到其输出中（格式设置除外）。

另外，需要注意的是，jq 当前仅支持 64 位双精度浮点数（IEEE754）。

- 项目主页：[https://jqlang.github.io/jq](https://jqlang.github.io/jq)
- GitHub 仓库：[https://github.com/jqlang/jq](https://github.com/jqlang/jq)

**安装**：

使用前请确保你的系统上已经安装 jq 工具，如果未安装，可以参考下面安装方法：

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="apt" label="Debian/Ubuntu" default>

    ```bash
    sudo apt install jq
    ```
  </TabItem>
  <TabItem value="yum" label="CentOS/RHEL">

    ```bash
    sudo yum install jq
    ```
  </TabItem>
</Tabs>

**语法**：

```bash
jq [options] <jq filter> [file...]
jq [options] --args <jq filter> [strings...]
jq [options] --jsonargs <jq filter> [JSON_TEXTS...]
```

**选项**：

- `-c`：使用紧凑而不是漂亮的输出。
- `-n`：使用 `null` 作为单个输入值。
- `-e`：根据输出设置退出状态代码。
- `-s`：将所有输入读取（slurp）到数组中；对其应用过滤器。
- `-r`：输出原始字符串，而不是 JSON 文本。
- `-R`：读取原始字符串，而不是 JSON文本。
- `-C`：为 JSON 着色。
- `-M`：单色（不要为 JSON 着色）。
- `-S`：在输出上排序对象的键。
- `--tab`：使用制表符进行缩进。
- `--arg a v`：将变量 `$a` 设置为值 `<v>`。
- `--argjson a v`：将变量 `$a` 设置为 JSON 格式的值 `<v>`。
- `--slurpfile a f`：将变量 `$a` 设置为从 `<f>` 读取的 JSON 文本数组。
- `--rawfile a f`：将变量 `$a` 设置为包含 `<f>` 内容的字符串。
- `--args`：其余参数是字符串参数，而不是文件。
- `--jsonargs`：其余的参数是 JSON 参数，而不是文件。
- `--`：终止参数处理。



## 示例

以漂亮的方式输出全部 JSON 数据：

```bash
$ echo '{ "home": { "bedroom": { "temperature": 25.0 } } }' | jq '.'
{
  "home": {
    "bedroom": {
      "temperature": 25
    }
  }
}
```

以紧凑的方式输出全部 JSON 数据：

```bash
$ echo '{ "home": { "bedroom": { "temperature": 25.0 } } }' | jq -c '.'
{"home":{"bedroom":{"temperature":25}}}
```

获取一个键的值（可以试试 `.home`、`.home.bedroom`、`.home?` 等过滤条件）：

```bash
$ echo '{ "home": { "bedroom": { "temperature": 25.0 } } }' | jq '.home.bedroom.temperature'
25
```

数组运算（可以试试 `.[]`、`.[]?`、`.[2]`、`.[0:10]` 等过滤条件）： 

```bash
$ echo '[{"name":"bedroom1", "temp":22.0}, {"name":"bedroom2", "temp":28.0}]' | jq '.[1]'
{
  "name": "bedroom2",
  "temp": 28
}
```

构造一个数组/对象（通过 `[], {}`）：

```bash
$ echo '{"user":"stedolan","titles":["JQ Primer", "More JQ"]}' | jq '{user, title: .titles[]}'
{
  "user": "stedolan",
  "title": "JQ Primer"
}
{
  "user": "stedolan",
  "title": "More JQ"
}
```

计算一个值的长度（通过 `length`）：

```bash
$ echo '[[1,2], "string", {"a":2}, null]' | jq '.[] | length'
2
6
1
0
```

取出数组中的键（通过 `keys`）：

```bash
$ echo '{"abc": 1, "abcd": 2, "Foo": 3}' | jq 'keys'
[
  "Foo",
  "abc",
  "abcd"
]
```

使用多个过滤器（通过 `,`）：

```bash
$ echo '{ "foo": 42, "bar": "something else", "baz": true}' | jq '.foo, .bar'
42
"something else"
```

通过管道将一个过滤器的输出当做下一个过滤器的输入（通过 `|`）：

```bash
$ echo '[{"name":"bedroom1", "temp":22.0}, {"name":"bedroom2", "temp":28.0}]' | jq '.[] | .name'
"bedroom1"
"bedroom2"
```

通过 `select()` 选择器筛选，选出大于等于 3 的值：

```bash
$ echo '[1,5,3,2,0,4,7]' | jq 'map(select(. >= 3))'
[
  5,
  3,
  4,
  7
]
```

通过 `map()` 将每个输入的值加一：

```bash
$ echo '[1,2,3]' | jq 'map(.+1)'
[
  2,
  3,
  4
]
```

条件判断（`if-then-else-end`）：

```bash
$ echo '2' | jq 'if . == 0 then "zero" elif . == 1 then "one" else "many" end'
"many"
```

在字符串中插入值并进行运算（通过 `\()` 表达式）：

```bash
$ echo '12' | jq '"The input was \(.), which is one less than \(.+1)"'
"The input was 12, which is one less than 13"
```
