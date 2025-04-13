---
sidebar_position: 14
slug: /typescript-symbols
---

# TypeScript - Symbol 符号类型

Symbol 是 TypeScript 中一种独特的原始数据类型，它在 ECMAScript 2015（也称为 ES6）中被引入。Symbol 类型的值是唯一的且不可变的，这使得它在某些特定场景下非常有用。



## 创建 Symbol

你可以使用 `Symbol()` 构造函数来创建 Symbol 类型的值。

```typescript
let testSymbol = Symbol();
```

你也可以传递一个描述字符串作为参数，这有助于调试时识别 Symbol。

```typescript
let keySymbol = Symbol("key-for-symbol");
```



## Symbol 的唯一性和不可变性

在 TypeScript 中，即使使用相同的描述字符串创建的 Symbol 也是唯一的。

```typescript
let firstSym = Symbol("sym");
let secondSym = Symbol("sym");
console.log(firstSym === secondSym); // 输出：false
```



## 使用 Symbol 作为对象属性键

Symbol 可以像字符串一样用作对象的属性键。你可以使用 symbol 来定义对象的键，从而创建“隐藏”的或不容易被意外覆盖的属性。例如：

```typescript
const sym = Symbol();

let obj = {
  [sym]: "value"
};

console.log(obj[sym]); // 输出: "value"
```

这种方式非常适合定义一些私有或框架内部使用的属性，因为 symbol 键不会被常规的 `for...in` 或 `Object.keys()` 枚举到。



## 在对象中隐藏属性

由于 symbol 属性不会出现在对象的常规枚举操作中，它们被认为是“不可枚举的”。请看下面示例：

```typescript
const secret = Symbol("secret");

let person = {
  name: "Tom",
  [secret]: "12345"
};

for (let key in person) {
  console.log(key); // 只会输出 "name"，不会输出 symbol 键
}

console.log(Object.keys(person)); // 同样只包含 "name"
```

如果你需要访问这些 symbol 属性，可以使用 `Object.getOwnPropertySymbols()`：

```typescript
console.log(Object.getOwnPropertySymbols(person)); // [ Symbol(secret) ]
```



## Symbol 与 switch-case 语句

由于每个 Symbol 都是唯一的，你可以将它们用作 switch-case 语句中的 case。

```typescript
switch (symbol) {
    case symbol1:
        break;
    case symbol2:
        break;
}
```

示例：

```typescript showLineNumbers
const symbol1 = Symbol();
const symbol2 = Symbol();

function printSymbol(symbol) {
    switch (symbol) {
        case symbol1:
            console.log("The case is symbol 1.");
            break;
        case symbol2:
            console.log("The case is symbol 2.");
            break;
        default:
            console.log("The case is default.");
    }
}

printSymbol(symbol1);
printSymbol(symbol2);
```

输出结果：

```bash
The case is symbol 1.
The case is symbol 2.
```



## 唯一 Symbol

在 TypeScript 中，你还可以使用 `unique symbol` 关键字来创建唯一 Symbol，这使得 Symbol 可以作为类型字面量使用。例如：

```typescript
const testSymbol: unique symbol = Symbol();

let symbol1: typeof testSymbol = testSymbol;
console.log("The value of symbol1 is " + typeof testSymbol);

class C {
    static readonly symb: unique symbol = Symbol("unique symbol");
}
```

输出结果：

```bash
The value of symbol1 is symbol
```



## 全局 Symbol 注册表

虽然通过 `Symbol()` 创建的 symbol 是唯一的，但有时候你可能希望复用某个 symbol，这时候可以使用全局 symbol 注册表（`Symbol.for` 和 `Symbol.keyFor`）。

示例：定义两个指向同一个全局 symbol 的引用

```typescript
let sym1 = Symbol.for("shared");
let sym2 = Symbol.for("shared");

console.log(sym1 === sym2); // 输出: true
```

如果你想获取某个全局 symbol 的 key，可以使用 `Symbol.keyFor()`：

```typescript
let sym = Symbol.for("registered");

console.log(Symbol.keyFor(sym)); // 输出: "registered"
```

需要注意的是，`Symbol.keyFor()` 只适用于使用 `Symbol.for()` 注册的全局 symbol，不适用于 `Symbol()` 创建的 symbol。



## 小结

Symbol 类型在 TypeScript 中提供了一种独特的、不可变的值，这使得它在需要唯一标识符的场景中非常有用。通过将 Symbol 用作对象的属性键，可以避免属性名冲突。此外，Symbol 还可以与 switch-case 语句结合使用，确保每个 case 都是唯一的。掌握 Symbol 的使用方法，可以帮助你在开发中创建更安全、更灵活的代码结构。
