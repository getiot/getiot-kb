---
sidebar_position: 7
slug: /typescript-template-literal-types
---

# TypeScript - 模板字面量类型

从 TypeScript 4.1 开始，你可以使用一种非常强大的特性 —— **模板字面量类型**（Template Literal Types），它让你可以在类型层面上使用字符串模板。听起来是不是很酷？这个功能可以帮助你基于已有的字符串类型拼接出新的字符串类型，类似于你在 JavaScript 中使用的模板字符串 `${}`，但用在了类型定义上。



## 基本语法

模板字面量类型的语法与 JavaScript 的模板字符串类似，使用反引号定义，并通过 `${}` 结构插入动态值。例如：

```typescript
type Greeting = `Hello, ${string}`;
```

这表示 `Greeting` 类型可以是任何以 `"Hello, "` 开头、后面接任意字符串的类型，例如：

- `"Hello, Alice"`
- `"Hello, Bob"`
- `"Hello, 123"`

这些都是 `Greeting` 类型的有效值。



## 示例：与联合类型结合使用

你可以将模板字面量类型与联合类型结合，生成多个字符串组合：

```typescript showLineNumbers
type Colors = "red" | "blue";
type Shades = "light" | "dark";

type ColorShades = `${Shades}-${Colors}`;
```

这会得到如下联合类型：

```typescript
type ColorShades = 
  | "light-red"
  | "light-blue"
  | "dark-red"
  | "dark-blue";
```

非常适合用来生成样式类名、状态名等结构化字符串类型。



## 示例：条件字符串模式

模板字面量类型还可以和条件类型、映射类型等高级类型配合使用，实现更复杂的逻辑。例如：

```typescript showLineNumbers
type Status = "loading" | "success" | "error";
type StatusMessage<T extends Status> = `${T}Status`;

function printStatus<T extends Status>(status: T): StatusMessage<T> {
    return `${status} Status` as StatusMessage<T>;
}

const loadingMessage = printStatus("loading");
console.log(loadingMessage);
```

输出结果：

```bash
loading Status
```



## 示例：API 路由生成

你也可以嵌套模板字面量，或者将多个模板合并。这非常适合构建 RESTful API 路由类型。例如：

```typescript showLineNumbers
type Method = "get" | "post" | "delete";
type Entity = "user" | "post";

type ApiRoute = `/${Entity}/${Method}`;

function getRoute(entity: Entity, method: Method): ApiRoute {
    return `/${entity}/${method}` as ApiRoute;
}

const userRoute = getRoute("user", "post");
console.log(userRoute);
```

输出结果：

```bash
/user/post
```



## 示例：限制某些字符串结构

你甚至可以用模板字面量类型来限制某些变量的取值范围，比如 URL 前缀：

```typescript showLineNumbers
type HTTPSUrl = `https://${string}`;

let url1: HTTPSUrl = "https://example.com"; // ✅
let url2: HTTPSUrl = "http://example.com";  // ❌ 报错
```

这样可以让你在编译时就发现潜在的错误，提升代码的类型安全。



## 小结

模板字面量类型是 TypeScript 类型系统中的一个超强工具，它让你可以在类型层面对字符串进行组合、限制和约束。通过它，你可以生成更精确的类型，比如 API 路径、样式名、事件名等，尤其适合在大型项目中提升类型系统的表达能力。只要你理解了模板字符串的基础用法，就能轻松上手模板字面量类型。这个特性可以帮你把类型定义写得更清晰、更自动化，也更贴近真实的代码结构。
