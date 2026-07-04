---
sidebar_position: 18
---

# JavaScript Date 对象



JavaScript 内置对象 Date 用于处理日期和时间。



## 创建日期

可以通过 new 关键词来定义 Date 对象，下面的代码定义了名为 myDate 的 Date 对象。

```javascript showLineNumbers
var myDate = new Date();
```

有四种方式初始化日期：

```javascript showLineNumbers
new Date() // 当前日期和时间
new Date(milliseconds) // 参数 milliseconds 是从1970年1月1日开始的毫秒数
new Date(dateString)   // 日期字符串，例如 "1997-07-01 06:30:00"
new Date(year, month, day, hours, minutes, seconds, milliseconds)
```

上面的参数大多数都是可选的，在不指定的情况下，默认参数是 0。下面是一些 Date 对象的实例化示例：

```javascript showLineNumbers
var today = new Date();
var d1 = new Date("October 25, 2020 11:13:00");
var d2 = new Date(2020, 5, 23);
var d3 = new Date(2020, 5, 23, 07, 25, 0);
```



## 操作方法

Date 对象提供了一系列 `get` 和 `set` 方法，用于获取或设置 Date 对象某些方面的值。

### get 类方法

- `getTime()`：返回距离1970年1月1日 00:00:00 的毫秒数，等同于 `valueOf` 方法。
- `getDate()`：返回实例对象对应每个月的几号（从 1 开始）。
- `getDay()`：返回星期几，星期日为 0，星期一为 1，以此类推。
- `getYear()`：返回距离 1900 的年数。
- `getFullYear()`：返回四位的年份。
- `getMonth()`：返回月份（0 表示 1 月，11 表示 12 月）。
- `getHours()`：返回小时（0 - 23）。
- `getMilliseconds()`：返回毫秒（0 - 999）。
- `getMinutes()`：返回分钟（0 - 59）。
- `getSeconds()`：返回秒（0 - 59）。
- `getTimezoneOffset()`：返回当前时间与 UTC 的时区差异，以分钟表示，返回结果考虑到了夏令时因素。

所有这些 `get` 方法返回的都是整数，不同方法返回值的范围不一样。

- 分钟和秒：0 到 59
- 小时：0 到 23
- 星期：0（星期天）到 6（星期六）
- 日期：1 到 31
- 月份：0（一月）到 11（十二月）
- 年份：距离 1900 年的年数



### set 类方法

- `setDate(date)`：设置实例对象对应的每个月的几号（1 - 31），返回改变后毫秒时间戳。
- `setYear(year)`：设置距离 1900 年的年数。
- `setFullYear(year [, month, date])`：设置四位年份。
- `setHours(hour [, min, sec, ms])`：设置小时（0 - 23）。
- `setMilliseconds()`：设置毫秒（0 - 999）。
- `setMinutes(min [, sec, ms])`：设置分钟（0 - 59）。
- `setMonth(month [, date])`：设置月份（0 - 11）。
- `setSeconds(sec [, ms])`：设置秒（0 - 59）。
- `setTime(milliseconds)`：设置毫秒时间戳。

这些方法基本是跟 `get` 方法一一对应的，但是没有 `setDay` 方法，因为星期几是计算出来的，而不是设置的。另外，需要注意的是，凡是涉及到设置月份，都是从 0 开始算的，即 `0` 是 1 月，`11` 是 12 月。



## 日期比较

Date 对象也可用于比较两个日期，下面的代码将当前日期与2020年12月1日做了比较：

```javascript showLineNumbers
var x = new Date();
x.setFullYear(2020, 11, 1);
var today = new Date();

if (x > today) {
    console.log("今天是2020年12月1日之前");
} else {
    console.log("今天是2020年12月1日之后");
}
```



