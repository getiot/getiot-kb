---
sidebar_position: 10
slug: /typescript-any
---

# TypeScript - Any 类型

`any` 类型是 TypeScript 中一种特殊的类型，它可以代表任何值。当你不确定变量的类型或者变量的类型尚未定义时，可以使用 `any` 类型。`any` 类型在将 JavaScript 代码转换为 TypeScript 时特别有用。

## 任何值的占位符

声明为 `any` 类型的变量可以存储任何数据类型的值。

```typescript
let x: any;
x = "Hello";
x = 23;
x = true;
```

这里，变量 `x` 被声明为 `any` 类型。这允许我们给变量分配任何值，如字符串、数字、布尔值等。

使用 `typeof` 操作符检查 `any` 类型变量的类型时，结果将是 `undefined`。

```typescript
let x: any;
console.log(typeof x); // undefined
```

编译后生成的 JavaScript 代码：

```javascript
let x;
console.log(typeof x);
```

输出结果：

```bash
undefined
```

让我们通过以下 TypeScript 示例来理解 `any` 类型：

```typescript
let x: any;
console.log(typeof x); // undefined
x = "Hello";
console.log(typeof x); // string
x = 23;
console.log(typeof x); // number
x = true;
console.log(typeof x); // boolean
```

在这个示例中，变量 `x` 被声明为 `any` 类型。然后我们给它分配了不同类型的值（字符串、数字和布尔值）。

编译后生成的 JavaScript 代码：

```javascript
let x;
console.log(typeof x);
x = "Hello";
console.log(typeof x);
x = 23;
console.log(typeof x);
x = true;
console.log(typeof x);
```

输出结果：

```bash
undefined
string
number
boolean
```

## 任何类型的函数参数

你也可以定义一个函数，使其参数为 `any` 类型。

```typescript
function func(para: any) {
}
```

这里，函数 `func` 可以接受任何类型的参数（数字、字符串、布尔值等）。

让我们来看一个示例：

```typescript
function greet(name: any): string {
    return `Hello Mr. ${name}`;
}
console.log(greet('Shahid'));
console.log(greet(123));
```

函数 `greet` 被定义为接受 `any` 类型的参数。因此，它可以接受任何类型的参数（数字、字符串等）。

我们调用了 `greet` 函数，传递了两个不同类型的值（字符串和数字）。你可以注意到，它对这两种类型的参数都有效。

编译后生成的 JavaScript 代码：

```javascript
function greet(name) {
    return `Hello Mr. ${name}`;
}
console.log(greet('Shahid'));
console.log(greet(123));
```

输出结果：

```bash
Hello Mr. Shahid
Hello Mr. 123
```

## 任何类型的对象

你也可以定义一个 `any` 类型的对象。这样的对象可以具有任何类型的属性。

```typescript
const student: any = {
    name: "John Doe",
    age: 32,
    isEnrolled: true,
};
```

这里，`student` 对象被声明为 `any` 类型。它包含三个不同类型的属性。

尝试以下示例：

```typescript
const student: any = {
    name: "John Doe",
    age: 32,
    isEnrolled: true,
};
console.log(student.name);
console.log(student.age);
console.log(student.isEnrolled);
```

编译后生成的 JavaScript 代码：

```javascript
const student = {
    name: "John Doe",
    age: 32,
    isEnrolled: true,
};
console.log(student.name);
console.log(student.age);
console.log(student.isEnrolled);
```

输出结果：

```bash
John Doe
32
true
```

## 为什么使用 `any` 类型？

使用 `any` 类型的一个原因是当你处理未进行类型检查的代码时。例如，如果你正在使用现有的 JavaScript 代码，`any` 类型在将 JavaScript 代码转换为 TypeScript 时非常有用。如果你正在使用一个不是用 TypeScript 编写的第三方库，你可能需要在 TypeScript 代码中为变量使用 `any` 类型。

另一个使用 `any` 类型的原因是当你不确定值的类型时。例如，一个接受用户输入的函数可以被定义为 `any` 类型，以处理用户提供的任何类型的数据。

在新的 TypeScript 代码中不鼓励使用 `any` 类型。建议在使用 `any` 类型时要小心。如果你过于频繁地使用 `any` 类型，你的代码将变得不那么类型安全。

## 类型断言

使用类型断言来缩小 `any` 变量的类型。

```typescript
let value: any = "hello world";
let lenStr: number = (value as string).length;
console.log(lenStr);
```

在上面的代码中，变量 `value` 被定义为 `any` 类型。然后它被缩小为字符串类型。

编译后生成的 JavaScript 代码：

```javascript
let value = "hello world";
let lenStr = value.length;
console.log(lenStr);
```

输出结果：

```bash
11
```

## 注意事项

如果不小心使用，`any` 类型可能会导致错误。

在下面的示例中，我们尝试访问一个不存在的属性 `enrYear`。这将导致运行时错误，因为我们已经将 `student` 对象定义为 `any` 类型。注意它不会显示编译时错误。

```typescript
const student: any = {
    name: "John Doe",
    age: 32,
    isEnrolled: true,
};
console.log(student.name);
console.log(student.age);
console.log(student.enrYear);
```

编译后生成的 JavaScript 代码：

```javascript
const student = {
    name: "John Doe",
    age: 32,
    isEnrolled: true,
};
console.log(student.name);
console.log(student.age);
console.log(student.enrYear);
```

输出结果：

```bash
John Doe
32
undefined
```

## any 和 unknown

当一个变量被声明为 `any` 类型时，你可以访问其不存在的属性。

**示例：声明为 `any` 的变量**

```typescript
let user: any;
user.isEnrolled;
```

上面的 TypeScript 代码在编译时不会显示任何错误。但它将在运行时抛出以下错误：

```bash
Cannot read properties of undefined (reading 'isEnrolled')
```

**示例：声明为 `unknown` 的变量**

```typescript
let user: unknown;
user.isEnrolled;
```

上面的代码将显示以下编译时错误：

```bash
'user' is of type 'unknown'.
```

## 小结

`any` 类型在 TypeScript 中是一个强大的工具，允许你在类型系统中保持灵活性。然而，过度使用 `any` 类型会削弱 TypeScript 提供的类型安全优势。在处理现有 JavaScript 代码或第三方库时，`any` 类型非常有用。但在新的 TypeScript 代码中，应尽量避免使用 `any` 类型，以保持代码的类型安全。当你需要使用 `any` 类型时，请谨慎操作，以避免潜在的运行时错误。
