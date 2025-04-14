---
sidebar_position: 1
slug: /typescript-generics
---

# TypeScript - 泛型

在 TypeScript 中，泛型是一种允许创建可重用组件（如函数、类、接口等）的概念。它允许开发者创建可以处理多种数据类型的函数、类等，而不仅仅是一种数据类型。简而言之，它允许开发者编写可以处理多种数据类型的程序，并且这些程序具有长期的可扩展性。

:::tip

泛型就像占位符，可以在使用泛型代码时填充具体的类型。

:::



## 为什么需要泛型？

在深入了解 TypeScript 泛型之前，让我们先理解一些需要使用泛型的问题场景。

### 示例 1：打印变量值

假设你想要打印作为参数传递的变量的值。

```typescript showLineNumbers
function printVar(val: number) {
    console.log(val);
}
printVar(10);
```

输出结果：

```
10
```

如果你想扩展 `printVar()` 函数的用途，使其能够打印其他类型变量的值，比如字符串、布尔值等，一种方法是像下面的例子一样。

### 示例 2：联合类型参数

```typescript showLineNumbers
function printVar(val: number | string | boolean) {
    console.log(val);
}
printVar(true);
```

输出结果：

```
true
```

如果你想打印数组或对象的值呢？你需要扩展 `val` 参数的类型，这会让代码变得难以阅读。

另一种方法是使用 `any` 类型的参数，如下例所示。

### 示例 3：`any` 类型参数

```typescript showLineNumbers
function printVar(val: any) {
    console.log(val);
}
printVar("Hello world!");
```

输出结果：

```
Hello world!
```

上面代码的问题在于，函数内部无法知道变量的具体类型。无论你传递的是字符串、数字、布尔值、数组等，函数中的变量类型都是 `any`。

这时，泛型函数就派上用场了。



## 泛型语法

你可以使用以下语法在 TypeScript 中使用泛型变量与函数。

```typescript
function printVar<T>(val: T) {
    // 函数体
}
printVar(val);
```

- 开发者可以在函数名后的尖括号（`<>`）中使用类型变量。
- 之后，你可以在参数中使用类型变量 `T` 作为参数的类型。
- 这里，开发者可以用任何有效的标识符代替 `T`。
- 之后，你可以用任何数据类型的值调用该函数，函数会自动捕获变量的数据类型。



## 泛型示例

### 示例 1：泛型函数

在下面的示例中，`printVar()` 函数是一个通用函数，它将任何数据类型的值作为参数并打印它。

```typescript showLineNumbers
function printVar<T>(val: T) {
    console.log("data: ", val);
}
let arr = [1, 2, 3];
let obj = { name: "Rudy", age: 30 };

printVar(arr);
printVar(obj);
printVar(true);
```

输出结果：

```bash
data:  [ 1, 2, 3 ]
data:  { name: 'Rudy', age: 30 }
data:  true
```



### 示例 2：打印变量类型

在这段代码中，`printVar()` 函数是一个泛型函数，它接受传递的变量值的类型作为参数。在调用该函数时，我们传递了不同数据类型的值，用户可以在输出中观察每个变量的类型。

```typescript showLineNumbers
function printVar<T>(val: T) {
    console.log("data: ", typeof val);
}

printVar(2);
printVar("Hello");
printVar(true);
```

输出结果：

```bash
data:  number
data:  string
data:  boolean
```



### 示例 3：多类型参数

在下面的代码中，`concatenate()` 函数分别接受两个类型为 `T` 和 `U` 的参数。它使用扩展运算符将“第一个”和“第二个”参数的值连接起来。

```typescript showLineNumbers
function concatenate<T, U>(first: T, second: U): T & U {
    return {...first, ...second};
}

const resultString = concatenate("Hello, ", "World!");
console.log(resultString);

const resultArray = concatenate([1, 2, 3], [4, 5, 6]);
console.log(resultArray);
```

输出结果：

```bash
{
  '0': 'W',
  '1': 'o',
  '2': 'r',
  '3': 'l',
  '4': 'd',
  '5': '!',
  '6': ' '
}
{ '0': 4, '1': 5, '2': 6 }
```

上面示例代码执行没有错误，但是结果没有达到预期，将第一个和第二个参数连接起来。因为字符串和数组并非对象类型，而字符串和数组在使用展开运算符（spread operator）时会被展开成单个字符键值对，由于 key 重复，`second` 中的字符会覆盖 `first` 中相同位置的字符。

正确的代码应该是这样的：

```typescript showLineNumbers
function concatenate<T extends string | any[], U extends string | any[]>(first: T, second: U): T | U {
    return (first as any).concat(second);
}

const resultString = concatenate("Hello, ", "World!");
console.log(resultString);

const resultArray = concatenate([1, 2, 3], [4, 5, 6]);
console.log(resultArray);
```

输出结果：

```bash
Hello, World!
[ 1, 2, 3, 4, 5, 6 ]
```



## 泛型的好处

以下是使用泛型的一些好处：

- **类型安全**：泛型强制类型一致性，通过在编译时捕获错误来减少运行时错误。
- **代码可重用性**：开发者可以定义一个可以处理不同类型数据的泛型函数、类或接口。这减少了代码重复。
- **提高可读性**：使用泛型可以让代码更简洁、更易读。
- **提升性能**：通过避免不必要的类型转换和检查，泛型可以提升应用程序的性能。



## 小结

TypeScript 的泛型为编写可重用、类型安全的代码提供了强大的支持。通过泛型，你可以创建能够处理多种数据类型的函数、类和接口，从而提高代码的灵活性和可维护性。掌握泛型的使用，可以帮助你编写更加健壮和专业的 TypeScript 代码。
