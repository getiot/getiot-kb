---
sidebar_position: 4
---

# JavaScript typeof 操作符



由于 ECMAScript 是松散类型的，因此需要有一种手段来监测给定变量的数据类型 —— **typeof** 就是负责提供这方面信息的操作符。

使用示例：

```javascript showLineNumbers
> typeof a
'undefined'        /* 这个值未定义 */

> var a = true;
> typeof a
'boolean'          /* 这个值是布尔值 */

> var b = "hello";
> typeof b
'string'           /* 这个值是字符串 */

> var c = 1;
> typeof c
'number'           /* 这个值是数值 */

> var d = null;
> typeof d
'object'           /* null 是对象 */

> var e = Array();
> typeof d
'object'           /* Array 数组也是对象 */

> function f() {}
> typeof f
'function'         /* 这个值是函数 */
```
