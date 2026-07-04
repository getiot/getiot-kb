---
sidebar_position: 13
---

# JavaScript 数组 Array 对象



Array 对象提供存储和处理一组其他对象的一种手段。JavaScript 的数组可以存储数值、字符串或其他对象，并且同一个数组可以存储不同类型的数据。



## 创建数组

创建 JavaScript 数组有几种不同的方法，例如：

**版本一**

```javascript showLineNumbers
var arr = ["one", "two", "three"];
```

**版本二**

```javascript showLineNumbers
var arr = new Array();
arr[0] = "one";
arr[1] = "two";
arr[2] = "three";
```

**版本三**

```javascript showLineNumbers
var arr = new Array();
arr.push("one");
arr.push("two");
arr.push("three");
```



## 数组长度

要确定数组的长度，即数组中元素的个数，可以使用数组对象的 length 属性。例如：

```javascript showLineNumbers
var len = arr.length;
```



## 操作方法

JavaScript 的 Array 数组对象有许多内置的函数，可以帮助你访问和操作数组。下表列举一些常用的数组对象方法：

| 方法          | 说明                                                         |
| ------------- | ------------------------------------------------------------ |
| `concat`      | 返回一个数组和作为参数传递的数组的连续副本。                 |
| `indexOf`     | 返回数组中指定元素的索引，如果没有找到则返回 -1。            |
| `join`        | 把一个数组中的所有元素连接为由指定分隔符（separator）分隔的单个字符串，如果没有指定分隔符，则使用逗号作为分隔符。 |
| `lastIndexOf` | 返回数组中指定元素的最后一个索引，如果没有找到则返回 -1。    |
| `pop`         | 删除数组的最后一个元素，并返回该元素。                       |
| `push`        | 添加一个或多个新元素到数组的尾部，并返回数组的新长度。       |
| `reverse`     | 反转数组中所有元素的顺序。                                   |
| `shift`       | 移除（删除）数组的第一个元素，并返回该元素。                 |
| `slice`       | 返回参数 start 和 end 索引之间的元素。                       |
| `sort`        | 对数组的元素排序，可以指定排序方法。                         |
| `splice`      | 在指定的索引（index）处，删除指定的条目数（count），然后在 index 处插入作为参数传入的任意可选条目。 |
| `toString`    | 返回一个数组的字符串形式。                                   |
| `unshift`     | 将新元素添加到数组的开头，并返回新的长度。                   |
| `valueOf`     | 返回一个数组对象的原始值。                                   |



## 使用示例

```html
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Temperatures</title>
    <script>
        function showTemps() {
            let tempByHour = new Array();
            tempByHour[0] = 18.2;
            tempByHour[1] = 18.5;
            tempByHour[2] = 19;
            tempByHour[3] = 18.8;
            tempByHour[4] = 18.5;

            for (let i=0; i<tempByHour.length; i++) {
                let temp = tempByHour[i];
                let id = "temp" + i;
                let li = document.getElementById(id);

                if (i == 0) {
                    li.innerHTML = "The temperature at noon was " + temp;
                } else {
                    li.innerHTML = "The temperature at " + i + " was " + temp;
                }
            }
        }
        window.onload = showTemps;
    </script>
</head>
<body>
    <h1>Temperatures</h1>
    <ul>
        <li id="temp0"></li>
        <li id="temp1"></li>
        <li id="temp2"></li>
        <li id="temp3"></li>
        <li id="temp4"></li>
    </ul>
</body>
</html>
```

