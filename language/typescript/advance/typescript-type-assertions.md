---
sidebar_position: 3
slug: /typescript-type-assertions
---

# TypeScript - 类型断言

类型断言（Type Assertions）是 TypeScript 中的一种机制，用于在编译时告诉编译器变量的类型。如果你确信某个变量的类型与 TypeScript 推断的类型不同，可以使用类型断言来覆盖编译器的推断。类型断言不会改变代码的运行时行为，它只是在编译时给编译器提供关于变量类型的提示。



## 如何执行类型断言？

类型断言类似于类型转换，但它不会在运行时进行类型检查或数据重组。类型断言主要有三种方式：使用 `as` 操作符、使用 `<>` 操作符、使用对象进行类型断言。下面逐一介绍。



### 使用 `as` 操作符

`as` 操作符是 TypeScript 中用于类型断言的一种方式。

示例：

```typescript
let variable_unknown: unknown = "TypeScript";
console.log("variable_unknown value is: ", variable_unknown);
let variable_number: number = (variable_unknown as string).length;
console.log("Length of variable_unknown: ", variable_number);
```

输出结果：

```bash
variable_unknown value is: TypeScript
Length of variable_unknown: 10
```



### 使用 `<>` 操作符

`<>` 操作符是另一种执行类型断言的方式。

示例：

```typescript
let my_number: unknown = 12345;
console.log('my_number value is: ', my_number);
let num: number = <number>my_number;
console.log('typeof num is: ', typeof num);
```

输出结果：

```bash
my_number value is: 12345
typeof num is: number
```



### 使用对象进行类型断言

对象也可以用于类型断言，这种方式可以在一次性断言多个属性的类型。

示例：

```typescript
interface Info {
    name: string;
    value: string;
}

let my_obj = <Info>{};
my_obj.name = 'GetIoT';
my_obj.value = 'TypeScript';
console.log(my_obj);
```

输出结果：

```bash
{ name: 'GetIoT', value: 'TypeScript' }
```



## 小结

TypeScript 的类型断言为在编译时提供类型信息提供了强大的支持。通过 `as` 和 `<>` 操作符，你可以轻松地在代码中进行类型断言，从而提高代码的安全性和可维护性。类型断言不会影响运行时行为，它只是编译时的一个工具。掌握类型断言的使用，可以帮助你编写更加健壮和专业的 TypeScript 代码。
