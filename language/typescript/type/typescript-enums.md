---
sidebar_position: 9
slug: /typescript-enums
---

# TypeScript - Enum 枚举

枚举（Enums）是 TypeScript 中一种用于定义一组命名常量的数据类型。枚举允许你为一组数值或字符串赋予更友好的名称。每个枚举成员都有一个与之关联的值，该值可以是常量或计算值。使用枚举不仅提高了代码的可读性，也使得管理这些常量更加方便。

TypeScript 支持三种类型的枚举：

- 数字枚举（Numeric Enums）
- 字符串枚举（String Enums）
- 异构枚举（Heterogeneous Enums）



## 数字枚举

数字枚举是 TypeScript 中默认的枚举类型，其成员被赋予数值。默认情况下，枚举成员从 0 开始递增。你也可以手动指定起始值，后续成员将自动递增。

### 默认数字枚举

在默认情况下，枚举的第一个成员被赋予值 `0`，后续成员依次递增 `1`。

```typescript
enum Weekday {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
}

console.log(Weekday.Monday);    // 输出：0
console.log(Weekday.Tuesday);   // 输出：1
console.log(Weekday.Wednesday); // 输出：2
console.log(Weekday.Thursday);  // 输出：3
console.log(Weekday.Friday);    // 输出：4
```

### 初始化数字枚举

你可以为枚举的第一个成员指定一个值，后续成员将自动递增。

```typescript
enum Color {
  Red = 10,
  Yellow,
  Green,
}

console.log(Color.Red);    // 输出：10
console.log(Color.Yellow); // 输出：11
console.log(Color.Green);  // 输出：12
```

### 完全初始化数字枚举

你也可以为枚举的所有成员指定值。

```typescript
enum HttpStatus {
  Success = 200,
  NotFound = 404,
  InternalServerError = 500,
}

console.log(HttpStatus.Success);             // 输出：200
console.log(HttpStatus.NotFound);            // 输出：404
console.log(HttpStatus.InternalServerError); // 输出：500
```

## 字符串枚举

字符串枚举与数字枚举类似，但其成员的值是字符串而不是数字。字符串枚举没有自动递增行为，所以你需要为每个成员设置一个值。这种类型的枚举在需要明确的字符串表示时非常有用。

```typescript
enum Status {
  Success = 'SUCCESS',
  Error = 'ERROR'
}

console.log(Status.Success); // 输出: 'SUCCESS'
console.log(Status.Error);   // 输出: 'ERROR'
```

## 异构枚举

异构枚举又称“混合枚举”，是指枚举成员的值既包含数字也包含字符串。不过，虽然 TypeScript 中可以使用异构枚举，但通常建议避免使用，以保持代码的一致性。

```typescript
enum Result {
  No = 0,
  Yes = 'YES'
}

console.log(Result.No);  // 输出: 0
console.log(Result.Yes); // 输出: 'YES'
```

## 枚举在运行时的行为

枚举在运行时是真实存在的对象。以下示例展示了如何将枚举作为对象传递给函数：

```typescript
enum Enum {
  x,
  y,
  z,
}

function func(obj: { y: number }) {
  return obj.y;
}
console.log(func(Enum));  // 输出：1
console.log(typeof Enum); // 输出：object
```

## 枚举在编译时的行为

当 TypeScript 枚举被编译时，它们会被转换为 JavaScript 对象。数字枚举成员在编译后会与运行时对象属性双向映射，而字符串枚举成员则只会单向映射。

```typescript
enum Enum {
  Name = 'John Doe',
  Age = 32,
}
```

编译后的 JavaScript 代码：

```javascript
var Enum;
(function (Enum) {
    Enum["Name"] = "John Doe";
    Enum[Enum["Age"] = 32] = "Age";
})(Enum || (Enum = {}));
```

### 常量枚举

常量枚举是特殊的枚举，在编译过程中会被完全移除，不会出现在编译后的 JavaScript 输出中。

### 反向映射

数字枚举成员在编译后会与运行时对象属性双向映射。

```typescript
enum Weekday {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
}

console.log(Weekday.Monday);  // 输出：0
console.log(Weekday[0]);      // 输出: 'Monday'
console.log(Weekday[1]);      // 输出: 'Tuesday'
```

## 外部枚举

外部枚举用于描述已经存在的枚举类型的形状。外部枚举不会生成任何 JavaScript 代码。

```typescript
declare enum Fruit {
  Apple,
  Orange,
  Banana,
}
```

## 对象与枚举

在现代 TypeScript 中，你可以使用带有 `as const` 的对象来替代枚举。

```typescript
enum EWeekend {
  Saturday,
  Sunday,
}
console.log(EWeekend.Saturday); // 输出：0

const OWeekend = {
    Saturday: 0,
    Sunday: 1,
} as const;
console.log(OWeekend.Saturday); // 输出：0
```

## 使用枚举作为函数参数

你可以将枚举作为函数参数使用。

```typescript
enum Color {
  Red,
  Green,
  Blue,
}

function printColor(color: Color): void {
  console.log(color);
}

printColor(Color.Red); // 输出：0
```

## 小结

TypeScript 的枚举类型提供了一种为一组值定义命名常量的方式。数字枚举成员在编译后会与运行时对象属性双向映射，而字符串枚举成员则只会单向映射。常量枚举在编译过程中会被移除，不会出现在最终的 JavaScript 代码中。在现代 TypeScript 中，你也可以使用带有 `as const` 的对象来替代枚举。掌握枚举的使用方法，可以帮助你在代码中提高可读性和可维护性。
