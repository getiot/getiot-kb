---
sidebar_position: 7
slug: /nodejs-console
---

# Node.js 控制台模块



Node.js 最常用的模块莫过于 **console**（控制台）模块，它提供了灵活的信息输出功能，通常用来将调试信息等内容写到控制台，以监视程序运行状态。

由于 console 模块经常使用，因此 Node.js 框架已经内置了 console 模块。这意味着，你不需要使用 `require()` 语句加载它就可以直接使用。



## console 模块成员函数

下面列出 console 控制台模块的一些可用函数。

### log

语法：

```javascript
console.log([data], [...]);
```

描述：用于将 `data` 数据写入控制台，`data` 变量可以是字符串或可解析为字符串的一个对象。支持 C 语言风格的占位符和可变参数。

示例：

```javascript
var num = 5;
var food = "cookies"
console.log("Here are %d %s", num, food);
// Output: Here are 5 cookies
```

### info

语法：

```javascript
console.info([data], [...]);
```

描述：与 `console.log` 相同。

### error

语法：

```javascript
console.error([data], [...]);
```

描述：与 `console.log` 相同。

### warn

语法：

```javascript
console.warn([data], [...]);
```

描述：与 `console.log` 相同。

### dir

语法：

```javascript
console.dir(obj);
```

描述：将一个 JavaScript 对象的字符串表示形式输出到控制台。

示例：

```javascript
console.dir({name:"GetIoT", age: 1});
// Output: { name: 'GetIoT', age: 1 }
```

### time

语法：

```javascript
console.time(label);
```

描述：将一个精度为毫秒的当前时间戳赋给一个字符串 label。配合 `console.timeEnd` 使用。


### timeEnd

语法：

```javascript
console.timeEnd(label);
```

描述：创建当前时间与赋给 label 的时间戳之间的差值，并输出结果。

示例：

```javascript
console.time("FileWrite");
f.write(data);
console.timeEnd("FileWrite");
```


### trace

语法：

```javascript
console.trace(label);
```

描述：将代码当前位置的栈跟踪的信息写到 stderr。

示例：

```javascript
console.trace("traceMark");
```


### assert

语法：

```javascript
console.assert(expression, [message]);
```

描述：如果 `expression` 的计算结果为 `false`，则把消息和栈跟踪信息输出到控制台。
