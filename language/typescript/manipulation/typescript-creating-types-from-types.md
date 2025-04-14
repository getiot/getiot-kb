---
sidebar_position: 1
slug: /typescript-creating-types-from-types
---

# TypeScript - 从类型创建类型

在 TypeScript 中，你可以通过现有类型创建自定义类型，这有助于提高代码的可维护性和减少错误。TypeScript 是一种静态类型语言，这意味着理想情况下，每个变量、函数参数和对象属性都应该明确指定类型。



## 联合类型

联合类型允许你定义一个可以存储多种数据类型的变量。联合操作符是 `|`，你可以用它来组合多个类型。

示例：

```typescript
// 定义联合类型
type StringOrNumber = string | number;

// 接受联合类型的函数
function processValue(value: StringOrNumber) {
    if (typeof value === "string") {
        console.log(`String: ${value}`);
    } else {
        console.log(`Number: ${value}`);
    }
}

processValue("hello"); // 输出：String: hello
processValue(123);     // 输出：Number: 123
```

输出结果：

```bash
String: hello
Number: 123
```



## 交叉类型

交叉类型允许你将多个类型组合成一个类型。交叉操作符是 `&`，你可以用它来组合多个类型。

示例：

```typescript
// 定义业务类型
interface Business {
    name: string;
    turnover: number;
}

// 定义联系详情类型
interface ContactDetails {
    email: string;
    phone: string;
}

// 组合两种类型
type BusinessContact = Business & ContactDetails;

// 创建业务联系对象
let contact: BusinessContact = {
    name: "GetIoT",
    turnover: 5000000,
    email: "getiot@gmail.com",
    phone: "1234567890"
};

console.log(contact);
```

输出结果：

```bash
{
  name: 'GetIoT',
  turnover: 5000000,
  email: 'getiot@gmail.com',
  phone: '1234567890'
}
```



## 工具类型

TypeScript 提供了许多工具类型，这些工具类型可以帮助你以动态和实用的方式操作类型，例如转换特定类型并创建新类型。以下是一些常用的工具类型：

- `Partial<T>`：将类型 `T` 的所有属性转换为可选属性。
- `Pick<T, K>`：从类型 `T` 中选取指定的属性 `K`，构造一个新类型。
- `Omit<T, K>`：从类型 `T` 中排除指定的属性 `K`，构造一个新类型。
- `ReturnType<T>`：由函数类型 `T` 的返回值类型构建一个新类型。
- `InstanceType<T>`：由构造函数类型 `T` 的实例类型来构建一个新类型。

下面着重介绍 Partial 和 Pick 工具类型的使用。



### Partial 工具类型

Partial 工具类型将接口或类型的所有属性变为可选。

示例：

```typescript
// 定义 Todo 接口
interface Todo {
    title: string;
    description: string;
}

// 使用 Partial 工具类型创建新类型
type OptionalTodo = Partial<Todo>;

// 创建 OptionalTodo 类型的对象
let todo: OptionalTodo = { title: "Buy milk" }; // 'description' 是可选的

console.log(todo);
```

输出结果：

```bash
{ title: 'Buy milk' }
```



### Pick 工具类型

Pick 工具类型允许你从现有类型中选择一个属性子集。

示例：

```typescript
// 定义 Todo 接口
interface Todo {
    title: string;
    description: string;
}

// 使用 Pick 工具类型创建新类型
type TodoPick = Pick<Todo, "title">;

let myTodo: TodoPick = { title: "Write a code" };

console.log(myTodo.title);
```

输出结果：

```bash
Write a code
```



## typeof 类型操作符

typeof 操作符用于获取特定变量的类型。你可以使用 typeof 变量来提取特定变量、对象、函数等的数据类型，并将其用于其他变量。

示例：

```typescript
// 定义 person 对象
const person = {
    name: "John",
    gender: "male"
};

// 使用 typeof 操作符获取 person 对象的类型
type Employee = typeof person;

// 定义 Employee 类型的对象
let employee1: Employee = {
    name: "Rudy",
    gender: "male"
};

console.log(employee1);
```

输出结果：

```bash
{ name: 'Rudy', gender: 'male' }
```



## 小结

通过使用联合类型、交叉类型、工具类型和 typeof 操作符，TypeScript 提供了强大的类型系统，使你能够从现有类型创建自定义类型。这些特性不仅提高了代码的可维护性，还减少了类型相关的错误。掌握这些类型操作，可以帮助你编写更加健壮和专业的 TypeScript 代码。
