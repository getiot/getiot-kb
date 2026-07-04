---
sidebar_position: 20
---

# JavaScript 数据类型转换



JavaScript 中有多种[数据类型](/js/javascript-data-types/)，不同数据类型之间经常需要转换，比如数字和字符串、字符串转数字等。本文就来介绍，在 JavaScript 中实现类型转换的各种方法。



## 转换为字符串

### 方式一：toString()

调用 `toString()` 方法可以将对象的值转成字符串，例如：

```javascript showLineNumbers
var num = 123;
num.toString();   // 返回字符串 '123'

var flag = true;
flag.toString();  // 返回字符串 'true'
```

### 方式二：String() 强制转换

`String()` 作为工具函数，可以将任何类型的值强制转换为字符串。

```javascript showLineNumbers
var num = 123;
String(num);      // 返回字符串 '123'

var flag = true;
String(flag);     // 返回字符串 'true'
```

### 方式三：加号拼接字符串

其他数据类型和字符串拼接的结果都是字符串，这种方式也称为**隐式转换**。

```javascript showLineNumbers
var num = 123;
console.log(num + 120);   // 输出数值 243
console.log(num + '120'); // 输出字符串 123120

var flag = true;
console.log(flag + '');   // 输出字符串 true
```



## 转换为数值型

### 方式一：parseInt()

将 String 字符串转换成整数数值，例如：

```javascript showLineNumbers
var myStr = '123';
var tmp = parseInt(myStr);  // 数字 123
typeof tmp  // 'number'
```

### 方式二：parseFloat()

将 String 字符串转换成浮点数数值，例如：

```javascript showLineNumbers
var myStr = '12.34';
var tmp = parseFloat(myStr);  // 数字 12.34
typeof tmp  // 'number'
```

### 方式三：Number() 强制转换

`Number()` 作为工具函数，可以将 String 字符串强制转换为数值型。


```javascript showLineNumbers
var str1 = '12.34';
var str2 = '12.3a';
var str3 = '12.b4';
var str4 = 'A12';
var str5 = '2e10';
Number(str1);  // 12.34
Number(str2);  // NaN
Number(str3);  // NaN
Number(str4);  // NaN
Number(str5);  // 20000000000
```

### 方式四：隐式转换

利用算术运算符（`-`、`*`、`/`）隐式转换为数值型。

```javascript showLineNumbers
console.log('12' + 2);    // 122
console.log('12' - 2);    // 10
console.log('12' - true); // 1
console.log('12' * 3);    // 36
console.log('12' / 3);    // 4
```



## 综合示例

下面是一个计算年龄的简单示例，涉及 Date 对象和类型转换的知识。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>年龄计算器</title>
    <script>
        const now = new Date();
        console.log(now);
        const bornYear = prompt('请输入你的出生年份');
        const age = now.getFullYear() - bornYear;
        alert('你今年已经 ' + age + ' 啦！');
    </script>
</head>
<body>
    <h1>年龄计算器</h1>
</body>
</html>
```

完整代码：[GitHub](https://github.com/getiot/javascript-courses)

