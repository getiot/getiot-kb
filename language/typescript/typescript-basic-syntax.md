---
sidebar_position: 3
slug: /typescript-basic-syntax
---

# TypeScript 基本语法

作为一名初学者，在开发 TypeScript 项目之前，你需要掌握 JavaScript 的基础知识。TypeScript 是 JavaScript 的超集，因此 JavaScript 的语法在 TypeScript 中都是合法的。下面我们来了解一些 TypeScript 的基本语法结构。



## 程序结构

一个 TypeScript 程序由以下几个部分组成：

- 模块（Modules）
- 函数（Functions）
- 语句与表达式（Statements & Expressions）
- 变量（Variables）
- 注释（Comments）



## Hello World 示例

让我们从一个简单的 “Hello World” 程序开始：

```typescript showLineNumbers
var message: string = "Hello World";
console.log(message);
```

当你编译这段代码时，它会生成以下 JavaScript 代码：

```javascript showLineNumbers
var message = "Hello World";
console.log(message);
```

- **第 1 行**：声明了一个名为 `message` 的变量。变量是程序中存储值的机制。
- **第 2 行**：将变量的值打印到控制台。`console` 指向终端窗口，`log()` 函数用于在屏幕上显示文本。



## 编译和运行 TypeScript 程序

让我们看看如何使用 Visual Studio Code 编译和运行 TypeScript 程序：

**步骤 1**：将文件保存为 `.ts` 扩展名。例如，我们将文件保存为 `Test.ts`。在保存时，代码编辑器会标记任何错误。

**步骤 2**：在 VS Code 的资源管理器窗格中，右键单击 TypeScript 文件，选择“在命令提示符中打开（Open in Command Prompt）”。

**步骤 3**：在终端窗口中使用以下命令编译文件：

```bash
tsc Test.ts
```

**步骤 4**：文件将被编译为 `Test.js`。要运行程序，请在终端中输入以下命令：

```bash
node Test.js
```

:::tip

可以一次编译多个文件，如下：

```bash
tsc file1.ts file2.ts file3.ts
```

:::



## 编译器标志

编译器标志允许你在编译过程中更改编译器的行为。以下是一些常见的 TSC 编译器标志：

| 序号 | 编译器标志                   | 描述                         |
| :--: | ---------------------------- | ---------------------------- |
|  1   | **`--help`**                 | 显示帮助手册                 |
|  2   | **`--module`**               | 加载外部模块                 |
|  3   | **`--target`**               | 设置目标 ECMA 版本           |
|  4   | **`--declaration`**          | 生成额外的 `.d.ts` 文件      |
|  5   | **`--removeComments`**       | 从输出文件中移除所有注释     |
|  6   | **`--out`**                  | 将多个文件编译为一个输出文件 |
|  7   | **`--sourcemap`**            | 生成源映射文件               |
|  8   | **`--module noImplicitAny`** | 禁止编译器推断 `any` 类型    |
|  9   | **`--watch`**                | 监视文件更改并实时重新编译   |



## TypeScript 中的标识符

标识符是程序中元素的名称，例如变量、函数等。标识符的规则如下：

- 标识符可以包含字母和数字，但不能以数字开头。
- 标识符不能包含特殊符号，除了下划线（`_`）或美元符号（`$`）。
- 标识符不能是关键字。
- 标识符必须唯一。
- 标识符是区分大小写的。
- 标识符不能包含空格。

以下是一些有效和无效标识符的例子：

| 有效标识符 ✅ | 无效标识符 ❌ |
| :----------: | :----------: |
|  firstName   |     Var      |
|  first_name  |  first name  |
|     num1     |  first-name  |
|   $result    |   1number    |



## TypeScript 关键字

关键字在语言中具有特殊含义。以下是一些 TypeScript 中的关键字：

|  关键字  |   关键字   |   关键字   |  关键字  |
| :------: | :--------: | :--------: | :------: |
|  break   |     as     |    any     |  switch  |
|   case   |     if     |   throw    |   else   |
|   var    |   number   |   string   |   get    |
|  module  |    type    | instanceof |  typeof  |
|  public  |  private   |    enum    |  export  |
| finally  |    for     |   while    |   void   |
|   null   |   super    |    this    |   new    |
|    in    |   return   |    true    |  false   |
|   any    |  extends   |   static   |   let    |
| package  | implements | interface  | function |
|   new    |    try     |   yield    |  const   |
| continue |     do     |   catch    |          |



## TypeScript 语句

### 空白和换行

TypeScript 忽略程序中的空格、制表符和换行符。你可以自由地在程序中使用空格、制表符和换行符，使代码整洁易读。



### TypeScript 是区分大小写的

TypeScript 是区分大小写的。这意味着它会区分大写字母和小写字母。



### 分号是可选的

每行指令称为一个**语句**。例如：

```typescript showLineNumbers
console.log("hello world");
console.log("We are learning TypeScript");
```

语句末尾的分号是可选的，但是如果一行中包含多个语句，则这些语句必须用分号分隔。



## TypeScript 注释

注释是提高程序可读性的一种方式。注释可以用来包含程序的额外信息，例如代码作者、函数提示等。编译器会忽略注释。

TypeScript 支持以下两种类型的注释：

- **单行注释（`//`）**：从 `//` 到行尾的文本被视为注释。
- **多行注释（`/* */`）**：这些注释可以跨越多行。

**示例**：

```typescript showLineNumbers
// 这是单行注释

/* 这是多行注释
   可以跨越多行
*/
```



## TypeScript 与面向对象编程

TypeScript 是面向对象的 JavaScript。面向对象是一种软件开发范式，它遵循现实世界的建模方式。面向对象将程序视为一组通过方法相互通信的对象。TypeScript 也支持这些面向对象的组件。

- **对象**（Object）：对象是任何实体的现实表示。每个对象必须具有以下三个特征：
  - **状态**（State）：由对象的属性描述。
  - **行为**（Behavior）：描述对象的行为。
  - **身份**（Identity）：一个独特的值，将对象与一组类似对象区分开来。
- **类**（Class）：在面向对象编程中，类是创建对象的蓝图。类封装了对象的数据。
- **方法**（Method）：方法是对象之间通信的机制。

**示例：TypeScript 与面向对象编程**

```typescript showLineNumbers
class Greeting {
   greet(): void {
      console.log("Hello World!!!");
   }
}
var obj = new Greeting();
obj.greet();
```

上述示例定义了一个名为 `Greeting` 的类。该类有一个名为 `greet()` 的方法。该方法在终端上打印字符串“Hello World!!!”。`new` 关键字创建类的一个对象（`obj`）。对象调用 `greet()` 方法。

编译后，它将生成以下 JavaScript 代码：

```javascript showLineNumbers
var Greeting = (function () {
   function Greeting() {
   }
   Greeting.prototype.greet = function () {
      console.log("Hello World!!!");
   };
	return Greeting;
}());

var obj = new Greeting();
obj.greet();
```

程序的输出如下：

```bash
Hello World!!!
```



## 总结

TypeScript 的基本语法为你的编程之旅奠定了基础。从变量声明到面向对象编程，TypeScript 提供了强大的工具和清晰的结构，帮助你编写更可靠、更易维护的代码。通过学习这些基本概念，你可以更快地掌握 TypeScript，并在实际项目中应用这些知识。记住，实践是掌握编程语言的最佳方式，所以不妨多写一些示例代码，亲身体验 TypeScript 的强大功能。
