---
sidebar_position: 15
---

# JavaScript 字符串 String 对象



String 对象是迄今为止在 JavaScript 中最常用的对象。实际上，在你定义一个字符串类型的变量时，JavaScript 引擎就自动为你创建了一个 String 对象。

```javascript showLineNumbers
var myStr = "I will be with you 24 hours a day";
```



## 操作方法

JavaScript 的 String 字符串对象有许多内置的函数，可以帮助你访问和操作字符串。下表列举一些常用的操作方法： 

| 方法           | 说明                                                         |
| -------------- | ------------------------------------------------------------ |
| `charAt`       | 返回指定索引处的字符。                                       |
| `charCodeAt`   | 返回指定索引处的字符的 Unicode 值。                          |
| `concat`       | 连接两个或多个字符串，返回连接后的字符串的副本。             |
| `fromCharCode` | 将 Unicode 值转换成实际的字符。                              |
| `indexOf`      | 返回指定的子串（subString）第一次出现的位置，如果没有找到则返回 -1。 |
| `lastIndexOf`  | 返回指定的子串（subString）最后一次出现的位置，如果没有找到则返回 -1。 |
| `match`        | 搜索字符串，并返回正则表达式的所有匹配。                     |
| `replace`      | 搜索字符串的字符串或正则表达式匹配，并用新的子串替换匹配的子串。 |
| `search`       | 基于正则表达式搜索字符串，并返回第一个匹配的位置。           |
| `slice`        | 返回字符串的 start 和 end（不含）位置之间的部分的一个新字符串。 |
| `split`        | 根据分隔符或正则表达式，把字符串分割为子字符串数组。可选的 limit 参数定义从头开始执行分割的最大数量。 |
| `substr`       | 从字符串指定的位置开始，并按照指定的字符长度提取字符。       |
| `substring`    | 返回字符索引在 from 与 to（不含）之间的子串。                |
| `toLowerCase`  | 将字符串转换为小写。                                         |
| `toUpperCase`  | 将字符串转换为大写。                                         |
| `valueOf`      | 返回原始字符串值。                                           |



## 使用示例

### 合并字符串

可以使用 `+` 操作或使用第一个字符串上的 `concat()` 函数将多个字符串合并。例如：

```javascript showLineNumbers
var word1 = "Today ";
var word2 = "is ";
var word3 = "another ";
var word4 = "day.";
var sentence1 = word1 + word2 + word3 + word4;
var sentence2 = word1.concat(word2, word3, word4);
```

上述代码中，sentence1 和 sentence2 将是相同的。



### 搜索子串

要确定一个字符串是否是另一个字符串的子字符串，可以使用 `indexOf()` 方法。例如：

```javascript showLineNumbers
var myStr = "I think, therefore I am.";
if (myStr.indexOf("think") != -1) {
    console.log(myStr);
}
```

上述代码中，只有当字符串包含单词 think 时，才会输出其内容。



### 替换单词

要想用另一个子串替换 String 对象中原有的子串，可以使用 `replace()` 方法。例如：

```javascript showLineNumbers
var username = "Rudy";
var output = "<username> please enter your password: ";
output.replace("<username>", username);
```

上述代码中，将用变量 username 的值替换文本 `<username>`。



### 分割字符串

对于字符串，一个非常常见的任务是使用分隔符将它们分割成数组。例如：

```javascript showLineNumbers
var t = "12:10:36";
var tArr = t.split(":");
var hour = tArr[0];
var minute = tArr[1];
var second = tArr[2];
```

上述代码中，使用分隔符 `:` 分割字符串并转换成一个数组。

