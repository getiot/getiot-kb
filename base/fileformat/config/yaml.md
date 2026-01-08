---
sidebar_position: 4
sidebar_label: YAML 格式
slug: /yaml
---

# YAML 文件格式

**YAML**（YAML Ain't Markup Language）格式最早于 2001 年由 Clark Evans 等人设计，名称采用递归缩写强调其以数据为中心的特性 —— 直译为“YAML 不是标记语言”。YAML 以**缩进和换行**为语法核心，支持注释、锚点引用和复杂数据类型（时间戳、二进制）。可无缝转换为 JSON，凭借高可读性成为 Docker Compose、Kubernetes 和 Ansible 等工具的默认配置格式，但空格敏感特性易引发解析错误。



## YAML 简介

YAML（发音 /ˈjæməl/ ）是一种可读性高的数据格式，主要用于表达资料序列化的格式。YAML 由 Clark Evans 在 2001 年首次发表，它的设计参考了多种语言（包括 C、Python、Perl），并从 XML、电子邮件的数据格式（RFC 2822）中获得灵感。目前已经有多种编程语言和脚本语言支持解析 YAML。

YAML 的原意是 “Yet Another Markup Language”，即另一种标记语言。但为了强调 YAML 这种语言以数据为中心，而不是以标记语言为重点，后来采用了反向缩略语重命名 —— “YAML Ain't a Markup Language”（YAML 不是一种标记语言）。

下面是一个 YAML 文件示例：

```yaml showLineNumbers
---
 doe: "a deer, a female deer"
 ray: "a drop of golden sun"
 pi: 3.14159
 xmas: true
 french-hens: 3
 calling-birds:
   - huey
   - dewey
   - louie
   - fred
 xmas-fifth-day:
   calling-birds: four
   french-hens: 3
   golden-rings: 5
   partridges:
     count: 1
     location: "a pear tree"
   turtle-doves: two
```



## YAML 基本语法

### 大小写敏感

YAML 语法是对大小写敏感的，例如下面两个参数是不同的。

```yaml
One: 1
one: 2
```

### 用缩进表示层级关系

- 缩进**只能使用空格**，不能用 TAB 字符
- 缩进的**空格数量不重要**，但是**同一层级的元素左侧必须对齐**

```yaml
# YAML
one:
  two: 2
  three:
    four: 4
    five: 5
```

以上的内容转成 JSON 格式如下：

```json
"one": {
  "two": 2,
  "three": {
    "four": 4,
    "five": 5 
  }
}
```

### 用 # 表示注释

YAML 只支持单行注释，使用 `#` 表示。

```yaml
# 我是注释
# 我也是注释
```

### 一个文件中可以包含多个文件的内容

- 用 `---` 即**三个短横线**表示一份内容的**开始**
- 用 `...` 即**三个小数点**表示一份内容的**结束**（非必需）

```yaml
---
# 这是第一份内容
one: 1
# 其他内容...
...

---
# 这是第二份内容
two: 2
# 其他内容...
```

## 数据结构与类型

### 对象（Mapping）

表示以键值对（key: value）形式出现的数据

- 使用“**冒号+空格**”来分开**键**与**值**

  ```yaml
  # YAML
  key: value
  ```

  等效 JSON：

  ```json
  // JSON
  "key": "value"
  ```

- 支持多层嵌套（**用缩进表示层级关系**）

  ```yaml
  # YAML
  key:
    child-key1: value1
    child-key2: value2
  ```

  等效 JSON：

  ```json
  // JSON
  "key": {
    "child-key1": "value1",
    "child-key2": "value2",
  }
  ```

- 支持**流式风格（ Flow style）**的语法（用花括号包裹，用逗号加空格分隔，类似 JSON）

  ```yaml
  # YAML
  key: { child-key1: value1, child-key2: value2 }
  ```

  等效 JSON：

  ```json
  // JSON
  "key": { "child-key1": "value1", "child-key2": "value2" }
  ```

- 使用**问号“?”**声明一个复杂对象，允许你使用多个词汇（数组）来组成键

  ```yaml
  # YAML
  ?
    - keypart1
    - keypart2
  :
    - value1
    - value2
  ```



### 数组（Sequence）

- 一组以**区块格式（Block Format）（即“破折号+空格”）**开头的数据组成一个数组

  ```yaml
  # YAML
  values:
    - value1
    - value2
    - value3
  ```

  等效 JSON：

  ```json
  // JSON
  "values": [ "value1", "value2", "value3" ]
  ```

- 同时也支持**内联格式（Inline Format）**来表达（用方括号包裹，逗号加空格分隔，类似 JSON）

  ```yaml
  # YAML
  values: [value1, value2, value3]
  ```

  等效 JSON：

  ```json
  // JSON
  "values": [ "value1", "value2", "value3" ]
  ```

- 支持多维数组（**用缩进表示层级关系**）

  ```yaml
  # YAML
  values:
    -
      - value1
      - value2
    -
      - value3
      - value4
  ```

  等效 JSON：

  ```json
  // JSON
  "values": [ [ "value1", "value2"], ["value3", "value4"] ]
  ```

### 标量（Scalars）

表示 YAML 中最基本的数据类型。

### 字符串（String）

字符串**一般不需要用引号包裹**，但是如果字符串中**使用了反斜杠“\”开头的转义字符就必须使用引号包裹**。

```yaml
# YAML
strings:
  - Hello without quote # 不用引号包裹
  - Hello
   world # 拆成多行后会自动在中间添加空格
  - 'Hello with single quotes' # 单引号包裹
  - "Hello with double quotes" # 双引号包裹
  - "I am fine. \u263A" # 使用双引号包裹时支持 Unicode 编码
  - "\x0d\x0a is \r\n" # 使用双引号包裹时还支持 Hex 编码
  - 'He said: "Hello!"' # 单双引号支持嵌套"
```

等效 JSON：

```json
// JSON
"strings":
  [ "Hello without quote",
    "Hello world",
    "Hello with single quotes",
    "Hello with double quotes",
    "I am fine. ☺",
    "\r\n is \r\n",
    "He said: 'Hello!'" ]
```

对于多行的文字，YAML 提供了两种特殊的语法支持。

**保留换行(Newlines preserved)**

> 使用**竖线符 `|`** 来表示该语法，每行的缩进和行尾空白都会被去掉，而额外的缩进会被保留。

```yaml
# YAML
lines: |
  我是第一行
  我是第二行
    我是第三行
      我是第四行
  我是第五行
```

等效 JSON：

```json
// JSON
"lines": "我是第一行\n我是第二行\n  我是第三行\n     我是第四行\n我是第五行"
```

**折叠换行(Newlines folded)**

> 使用**右尖括号 `>`** 来表示该语法，只有空白行才会被识别为换行，原来的换行符都会被转换成空格。

```yaml
# YAML
lines: >
  我是第一行
  我也是第一行
  我仍是第一行
  我依旧是第一行

  我是第二行
  这么巧我也是第二行
```

等效 JSON：

```json
// JSON
"lines": "我是第一行 我也是第一行 我仍是第一行 我依旧是第一行\n我是第二行 这么巧我也是第二行"
```



### 布尔值（Boolean）

- “true”、“True”、“TRUE”、“yes”、“Yes”和“YES”皆为**真**
- “false”、“False”、“FALSE”、“no”、“No”和“NO”皆为**假**

```yaml
# YAML
boolean:
  - true # True、TRUE
  - yes # Yes、YES
  - false # False、FALSE
  - no # No、NO
```

### 整数（Integer）

YAML 支持二进制表示。

```yaml
# YAML
int:
  - 666
  - 0001_0000 # 二进制表示
```

等效 JSON：

```json
// JSON
"int": [ 666, 4096 ]
```



### 浮点数（Floating Point）

YAML 支持科学计数法。

```yaml
# YAML
float:
  - 3.14
  - 6.8523015e+5 # 使用科学计数法
```

等效 JSON：

```json
// JSON
"float": [ 3.14, 685230.15 ]
```



### 空（Null）

“null”、“Null”和“~”都是空，不指定值默认也是空。

```yaml
# YAML
nulls:
  - null
  - Null
  - ~
  -
```

等效 JSON：

```json
// JSON
"nulls": [ null, null, null, null ]
```



### 时间戳（Timestamp）

YAML 也支持 **ISO 8601** 格式的时间数据。

```yaml
# YAML
date1: 2020-05-26
date2: 2020-05-26T01:00:00+08:00
dete3: 2020-05-26T02:00:00.10+08:00
date4: 2020-05-26 03:00:00.10 +8
```

### 类型转换

YAML 支持使用**严格类型标签 `!!`**（双感叹号+目标类型）来强制转换类型。

```yaml
# YAML
a: !!float '666' # !! 为严格类型标签
b: '666' # 其实双引号也算是类型转换符
c: !!str 666 # 整数转为字符串
d: !!str 666.66 # 浮点数转为字符串
e: !!str true # 布尔值转为字符串
f: !!str yes # 布尔值转为字符串
```

等效 JSON：

```json
// JSON
"a": 666,
"b": "666",
"c": "666",
"d": "666.66",
"e": "true"
"f": "yes"
```



### 其他高级类型

除了前面介绍的数据类型，YAML 也可以使用一些更高级的类型，包括**集合（Sets）**、**有序映射（Ordered Map）**、**十六进制数据（Hexdecimal）**和**二进制数据（Binary）**。但需要注意，并不是所有解析器都支持/兼容这些高级数据类型。



## 数据重用与合并

为了保持内容的简洁，避免过多重复的定义，YAML 提供了由**锚点标签 `&`** 和**引用标签 `\*`** 组成的语法，利用这套语法可以快速引用相同的一些数据。

```yaml
# YAML
a: &anchor # 设置锚点
  one: 1
  two: 2
  three: 3
b: *anchor # 引用锚点
```

等效 JSON：

```json
// JSON
"a": {
  "one": 1,
  "two": 2,
  "three": 3
},
"b": {
  "one": 1,
  "two": 2,
  "three": 3
}
```

配合**合并标签 `<<`** 使用可以与任意数据进行合并，你可以把这套操作想象成面向对象语言中的继承。

```yaml
# YAML
human: &base    # 添加名为 base 的锚点
    body: 1
    hair: 999
singer:
    <<: *base   # 引用 base 锚点，实例化时会自动展开
    skill: sing # 添加额外的属性
programer:
    <<: *base   # 引用 base 锚点，实例化时会自动展开
    hair: 6     # 覆写 base 中的属性
    skill: code # 添加额外的属性
```

等效 JSON：

```json
{
    "human": { "body": 1, "hair": 999 },
    "singer": { "body": 1, "hair": 999, "skill": "sing" },
    "programer": { "body": 1, "hair": 6, "skill": "code" }
}
```





## 参考

- [YAML | 维基百科](https://zh.wikipedia.org/wiki/YAML)
- [YAML Tutorial: Everything You Need to Get Started in Minutes](https://www.cloudbees.com/blog/yaml-tutorial-everything-you-need-get-started)
- [一文看懂 YAML](https://zhuanlan.zhihu.com/p/145173920)

