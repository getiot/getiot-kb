---
sidebar_position: 3
slug: /typescript-type-inference
---

# TypeScript - 类型推断

在 TypeScript 中，类型推断（Type Inference）是其核心特性之一。通过类型推断，TypeScript 可以在没有显式类型注解的情况下，根据变量的初始值或上下文自动推断出其类型。这有助于减少冗余的类型声明，同时保持代码的类型安全性。

类型推断基于多种因素，包括：

- 变量的赋值类型
- 函数参数或传递给函数的参数类型
- 函数返回值类型
- 对象及其属性的类型



## 变量或成员初始化

在变量或成员初始化时，TypeScript 编译器会根据初始化值推断变量的类型。

请看下面示例代码：

```typescript
let x = 20;
let y = "Hello World!";
let z = true;
console.log("type of x: ", typeof x);
console.log("type of y: ", typeof y);
console.log("type of z: ", typeof z);
```

执行后的输出结果为：

```bash
type of x:  number
type of y:  string
type of z:  boolean
```

再看一个对象成员初始化示例：

```typescript
class Person {
  name = "Rudy";
  age = 30;
}
const p = new Person();

console.log(`${p.name}, ${p.age}`);
```

输出结果：

```bash
Rudy, 30
```



## 函数默认参数

当函数参数具有默认值时，TypeScript 编译器可以推断参数的类型。

```typescript
function add(x = 10, y = 30) {
   return x + y;
}
let res = add(2, 3);
console.log(res);
```

输出结果：

```bash
5
```

尝试传递字符串参数：

```typescript
let res2 = add('2', '3');
```

会报错：

```
Argument of type 'string' is not assignable to parameter of type 'number'.
```



## 函数返回类型

TypeScript 编译器会根据返回值的类型推断函数的返回类型。

```typescript
function add(x: number, y: number) {
   return x + y;
}
let res1: number = add(2, 3);
console.log(res1);
```

尝试将返回值赋给字符串类型变量：

```typescript
let res2: string = add(2, 3);
```

会报错：

```
Type 'number' is not assignable to type 'string'.
```



## 最佳公共类型：联合类型

当 TypeScript 从多个表达式推断类型时，会确定表达式的“最佳公共类型”。

```typescript
const a = [5, 10, "TypeScript"];
```

推断类型为 `(number | string)[]`。

尝试添加布尔值：

```typescript
a.push(true);
```

会报错：

```
Argument of type 'boolean' is not assignable to parameter of type 'string | number'.
```



## 上下文类型推断

上下文类型推断允许编译器根据变量、参数或表达式的使用上下文推断其类型。

```typescript
window.onmousedown = function (mouseEvent) {
  console.log(mouseEvent.button);
}
```

在上面的例子中，TypeScript 根据 `Window.onmousedown` 函数的类型推断 `mouseEvent` 参数的类型为 `MouseEvent`。



## 小结

TypeScript 的类型推断功能让你无需显式注解类型即可声明变量、函数或表达式。编译器会自动推断类型，提高代码的简洁性和可读性。类型推断基于多种因素，包括变量初始化、函数默认参数、返回值类型等。上下文类型推断进一步增强了代码的类型安全性，同时保持了代码的简洁性。掌握类型推断的规则，可以帮助你更高效地编写 TypeScript 代码，同时享受类型检查的好处。

