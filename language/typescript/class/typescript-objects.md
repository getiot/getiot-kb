---
sidebar_position: 2
slug: /typescript-objects
---

# TypeScript - 对象（Objects）

在 TypeScript 中，对象（Objects）是非常基础也是非常强大的数据结构。你可以把对象理解为键值对（key-value pair）的集合，用来表示一个实体的属性和行为。键值对也被称为对象的属性。属性的值可以是标量值、函数，甚至是其他对象的数组。如果属性的值是一个函数，那么这个属性被称为方法。

和 JavaScript 一样，你可以灵活地创建对象，但 TypeScript 增加了类型系统，这意味着你可以给对象加上明确的类型定义，从而让代码更加安全和易于维护。



## 创建对象

在 TypeScript 中，创建对象的基本语法如下：

```typescript
var object_name = {
   key1: "value1",
   key2: "value",
   key3: function() {
      // 方法体
   },
   key4: ["content1", "content2"]
};
```

对象可以包含标量值、函数、数组等结构。



## 类型注解

在 TypeScript 中，你可以为对象属性添加类型注解，以确保对象的结构符合预期。

### 示例 1：直接类型注解

```typescript
let person: { name: string; age: number } = {
   name: "Tom Hanks",
   age: 35
};
```

### 示例 2：使用接口

你也可以通过接口来定义对象的类型。

```typescript
interface PersonType {
   fullname: string;
   age: number;
}

let person: PersonType = {
   fullname: "Tom Hanks",
   age: 32
};
```



## 对象字面量表示法

对象字面量表示法是创建对象的最简单方式。使用大括号 `{}` 创建对象，每个属性由键（key）、冒号（`:`）和值（value）组成，属性之间用逗号分隔。

**示例**：

```typescript
var person: { firstName: string; lastName: string } = {
   firstName: "Tom",
   lastName: "Hanks"
};

console.log(person.firstName); // 输出：Tom
console.log(person.lastName); // 输出：Hanks
```

编译后的 JavaScript 代码：

```javascript
var person = {
   firstName: "Tom",
   lastName: "Hanks"
};

console.log(person.firstName);
console.log(person.lastName);
```



## 对象作为函数参数

对象可以作为函数的参数传递。

**示例**：

```typescript
var person = {
   firstname: "Tom",
   lastname: "Hanks"
};

function invokePerson(obj: { firstname: string; lastname: string }) {
   console.log("first name: " + obj.firstname);
   console.log("last name: " + obj.lastname);
}

invokePerson(person);
```

编译后的 JavaScript 代码：

```javascript
var person = {
   firstname: "Tom",
   lastname: "Hanks"
};

function invokePerson(obj) {
   console.log("first name: " + obj.firstname);
   console.log("last name: " + obj.lastname);
}

invokePerson(person);
```

输出结果：

```bash
first name: Tom
last name: Hanks
```



## 匿名对象

你可以创建并传递匿名对象。

**示例**：

```typescript
function invokePerson(obj: { firstname: string; lastname: string }) {
   console.log("first name: " + obj.firstname);
   console.log("last name: " + obj.lastname);
}

invokePerson({ firstname: "Sachin", lastname: "Tendulkar" });
```

编译后的 JavaScript 代码：

```javascript
function invokePerson(obj) {
   console.log("first name: " + obj.firstname);
   console.log("last name: " + obj.lastname);
}

invokePerson({ firstname: "Sachin", lastname: "Tendulkar" });
```

输出结果：

```bash
first name: Sachin
last name: Tendulkar
```



## 鸭子类型（Duck Typing）

在鸭子类型中，如果两个对象具有相同的属性集，它们就被认为是相同类型的。TypeScript 的编译器实现了鸭子类型系统，允许你在保持类型安全的同时动态创建对象。

**示例**：

```typescript
interface IPoint {
   x: number;
   y: number;
}

function addPoints(p1: IPoint, p2: IPoint): IPoint {
   var x = p1.x + p2.x;
   var y = p1.y + p2.y;
   return { x: x, y: y };
}

var newPoint = addPoints({ x: 3, y: 4 }, { x: 5, y: 1 });
var newPoint2 = addPoints({ x: 1 }, { x: 4, y: 3 }); // 这里会报错，因为第二个对象缺少 y 属性
```



:::tip “鸭子类型”的来由

“鸭子类型”（Duck Typing）这个名字来源于一个经典的说法：“如果它走起来像鸭子，叫起来像鸭子，那么它就是鸭子”。这个概念最早由美国诗人詹姆斯·惠特科姆·莱利提出，后来被引入到编程领域，用来描述一种动态类型风格。

在编程中，鸭子类型的核心思想是关注对象的行为，而不是它的具体类型。只要一个对象具备所需的方法或属性，就可以被视为具有某种类型，而无需显式地继承或实现特定的类或接口。

鸭子类型强调对象能做什么，而不是它是什么。例如，如果一个对象具有 `quack()` 方法，那么它就可以被视为“会叫的鸭子”，即使它并不是真正的鸭子。

:::



## 小结

TypeScript 的对象功能为处理复杂数据结构提供了强大的支持。通过对象字面量表示法，你可以快速创建和操作对象。类型注解和接口确保了代码的类型安全性，而鸭子类型则提供了灵活性。掌握对象的使用，可以让你的 TypeScript 代码更加模块化和专业。无论是简单的数据存储还是复杂的业务逻辑，对象都能帮助你更好地组织代码。
