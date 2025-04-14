---
sidebar_position: 6
slug: /typescript-function-constructor
---

# TypeScript - 函数构造器

函数构造器（Function Constructor）是 TypeScript 中用于动态创建函数的一种方式。通过 `Function()` 构造器，你可以在运行时创建新的函数实例。虽然这种写法在现代开发中不太常用，但了解它依然很有价值，尤其是当你处理一些需要动态生成函数逻辑的高级场景时。



## 函数构造器语法

使用 `Function()` 构造器定义函数的语法如下：

```typescript
new Function ([arg1[, arg2[, ...argN]],] functionBody)
```

参数说明：

- `arg1, arg2, ..., argN`：可选参数，表示新函数的参数名，它们都是字符串类型。
- `functionBody`：必需参数，表示新函数的函数体，同样是一个字符串。

换句话说，你通过字符串的方式传递函数的参数和函数体，然后由构造器生成一个可调用的函数。



## 示例

### 示例 1：创建无参数的简单函数

```typescript
const greet = new Function("return 'Welcome to GetIoT.tech!'");
console.log(greet());
```

输出结果：

```bash
Welcome to GetIoT.tech!
```



### 示例 2：创建带参数的简单函数

```typescript
let myFunction = new Function("a", "b", "return a * b");

let result = myFunction(4, 3);
console.log(result);
```

输出结果：

```bash
12
```

在这个例子中，你创建了一个名为 `myFunction` 的新函数，它接受两个参数 `a` 和 `b`，并返回它们的乘积。这个函数就像是你用 `function` 关键字手动定义的一样，只不过是用 `Function` 构造器动态生成的。



### 示例 3：从函数表达式创建函数实例

```typescript
const add = new Function(
    "const sum = function (a, b) { return a + b }; return sum",
)();
console.log(add(2, 3));
```

输出结果：

```bash
5
```



### 示例 4：从函数声明创建函数实例

```typescript
const sayHello = new Function(
    "return function (name) { return `Hello, ${name}` }",
)();
console.log(sayHello("Rudy"));
```

输出结果：

```bash
Hello, Rudy
```



## 使用场景与注意事项

虽然函数构造器提供了创建函数的灵活方式，但在实际开发中它并不推荐频繁使用，原因包括：

- **可读性差**：函数体是字符串，不利于维护。
- **不利于调试**：调试器无法识别字符串形式的函数体。
- **安全隐患**：如果字符串内容来源不可靠，容易导致安全问题（如代码注入）。
- **性能问题**：动态构造函数会带来额外的解析成本。

因此，除非有明确的理由，比如需要根据运行时逻辑生成代码，否则你应该优先使用标准的函数声明或函数表达式。



## 小结

函数构造器是一种通过字符串动态创建函数的机制。在某些特定场景下，它可以提供强大的动态能力。不过，在大多数日常开发中，你更应该依赖常规的函数定义方式，以避免潜在的安全问题。除非你非常确定自己的用例，否则不建议频繁使用 `Function` 构造器。了解它的工作原理，有助于你更深入地掌握 JavaScript 和 TypeScript 的底层机制。
