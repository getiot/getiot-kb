---
sidebar_position: 7
slug: /typescript-date-object
---

# TypeScript - Date 对象

在 TypeScript 中，`Date` 对象是一个内建对象，用于创建和管理日期与时间。它直接继承自 JavaScript 的 `Date` 对象，因此拥有相同的方法和属性。不过，在 TypeScript 中使用时，你可以通过类型注解获得更好的类型检查和代码提示。



## 语法

你可以通过以下几种方式来创建 `Date` 对象：

```typescript
let date: Date = new Date(); // 当前日期和时间
date = new Date(milliseconds); // 通过毫秒数创建日期
date = new Date(dateString); // 通过日期字符串创建日期
date = new Date(year, month, day, hour, minute, second, millisecond); // 指定各个时间参数创建日期
```

请注意，月份参数是从 0 开始的，即 0 表示一月，11 表示十二月。



## 示例

下面是一些使用 `Date` 对象的示例：

```typescript
let date1: Date = new Date();
console.log("当前日期和时间:", date1);

let date2: Date = new Date(1000000000000);
console.log("通过毫秒数创建的日期:", date2);

let date3: Date = new Date("2025-04-15T09:30:51");
console.log("通过日期字符串创建的日期:", date3);

let date4: Date = new Date(2025, 3, 15, 9, 30, 51, 0);
console.log("指定各个时间参数创建的日期:", date4);
```



## 常用方法

`Date` 对象提供了多种方法来获取和设置日期与时间的各个部分。

### 获取日期和时间

```typescript
let date: Date = new Date();

console.log("年份:", date.getFullYear());
console.log("月份 (0-11):", date.getMonth());
console.log("日期 (1-31):", date.getDate());
console.log("小时 (0-23):", date.getHours());
console.log("分钟 (0-59):", date.getMinutes());
console.log("秒数 (0-59):", date.getSeconds());
console.log("毫秒 (0-999):", date.getMilliseconds());
```

### 设置日期和时间

```typescript
let date: Date = new Date();

date.setFullYear(2025);
date.setMonth(3); // 四月
date.setDate(15);
date.setHours(9);
date.setMinutes(30);
date.setSeconds(51);
date.setMilliseconds(0);

console.log("设置后的日期和时间:", date);
```



## 日期格式化

你可以使用以下方法将 `Date` 对象格式化为字符串：

```typescript
let date: Date = new Date();

console.log("toString():", date.toString());
console.log("toDateString():", date.toDateString());
console.log("toTimeString():", date.toTimeString());
console.log("toLocaleString():", date.toLocaleString());
console.log("toLocaleDateString():", date.toLocaleDateString());
console.log("toLocaleTimeString():", date.toLocaleTimeString());
console.log("toUTCString():", date.toUTCString());
console.log("toISOString():", date.toISOString());
```

这些方法可以根据需要将日期和时间转换为不同格式的字符串，方便显示和传输。



## 处理时区

可以使用 `Date.UTC()` 方法创建 UTC 日期，并使用 `toLocaleString()` 方法根据时区调整日期字符串。

```typescript
let utcDate = new Date(Date.UTC(2025, 3, 15, 9, 30, 51));
console.log(utcDate.toISOString());
console.log(utcDate.toLocaleString('en-US', { timeZone: 'America/New_York' })); // 美国纽约
console.log(utcDate.toLocaleString('zh-CN', { timeZone: 'Asia/Shanghai' }));    // 中国上海
```



## 时间戳

你可以使用以下方法获取自 1970 年 1 月 1 日以来的毫秒数：

```typescript
let date: Date = new Date();
let timestamp: number = date.getTime();
console.log("时间戳:", timestamp);
```

这在进行日期计算和比较时非常有用。



## 注意事项

- `Date` 对象中的月份是从 0 开始的，0 表示一月，11 表示十二月。
- `Date` 对象的方法返回的时间通常是本地时间，但也提供了以 UTC 为基准的方法，如 `getUTCFullYear()`、`getUTCMonth()` 等。
- 在进行日期和时间的比较或计算时，建议使用时间戳进行操作，以避免时区和夏令时等问题。



## 小结

在 TypeScript 中，`Date` 对象是处理日期和时间的强大工具。通过类型注解和丰富的方法，你可以方便地创建、操作和格式化日期与时间。掌握 `Date` 对象的使用，将有助于你在开发中更高效地处理与时间相关的需求。
