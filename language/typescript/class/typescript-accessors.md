---
sidebar_position: 8
slug: /typescript-accessors
---

# TypeScript - 存取器 Accessors

在 TypeScript 中，**存取器**（Accessors）是指对象属性的 *getter* 和 *setter* 方法。通过使用 `get` 和 `set` 关键字，你可以控制属性的读取和写入方式。这种机制可以帮助你封装类的内部数据，可以限制对类成员的直接访问，防止未经授权的访问，同时保留对属性的访问控制。

TypeScript 支持以下两种存取器：

- **getters**：用于访问类成员的值。
- **setters**：用于设置类成员的值。



## 存取器语法

在 TypeScript 中，`get` 用于定义一个属性的读取方法（getter），而 `set` 用于定义写入方法（setter）。它们的语法如下：

```typescript
class ClassName {
   private _property: type;

   get property(): type {
      // 读取逻辑
   }

   set property(value: type) {
      // 写入逻辑
   }
}
```

注意事项：

- `get` 方法不能带参数。
- `set` 方法必须带一个参数。



## 存取器示例

下面是一个使用存取器的示例：

```typescript
class Employee {
   private _fullName: string;

   get fullName(): string {
      return this._fullName;
   }

   set fullName(newName: string) {
      if (newName && newName.length > 0) {
         this._fullName = newName;
      } else {
         console.log("请输入有效的姓名");
      }
   }
}

let emp = new Employee();
emp.fullName = "阿基米东";
console.log(emp.fullName);  // 输出：阿基米东
```

在上面的例子中，你定义了一个类 `Employee`，其中包含一个私有属性 `_fullName`。通过 `get` 和 `set`，你为 `_fullName` 提供了公共接口，允许安全地访问和修改它的值。



## 带有访问控制的存取器

你也可以结合访问修饰符（如 `public`、`private`、`protected`）使用存取器，进一步增强封装性。

```typescript
class Student {
   private _age: number;

   get age(): number {
      return this._age;
   }

   set age(value: number) {
      if (value >= 0 && value <= 120) {
         this._age = value;
      } else {
         console.log("请输入有效的年龄");
      }
   }
}

let stu = new Student();
stu.age = 25;
console.log(stu.age); // 输出：25

stu.age = -5;         // 输出：请输入有效的年龄
```



## 存取器与编译选项

TypeScript 中使用存取器时，还需注意以下几点：

1. 如果你在 `tsconfig.json` 中将编译目标（`target`）设置为 `ES5` 或以上，存取器才会被正确地编译为 JavaScript。
2. 如果目标版本较低（如 `ES3`），TypeScript 会抛出错误，因为 ES3 不支持存取器。



## 与普通属性的区别

你可能会问，为什么不直接使用公开属性而要用存取器？原因在于：

- 存取器允许你添加额外逻辑（如验证、日志）；
- 更好地控制对象内部状态；
- 保持接口简洁，同时隐藏实现细节。



## 小结

通过使用存取器（Accessors），你可以为对象属性增加读写控制逻辑，实现更强的封装和验证。TypeScript 的 `get` 和 `set` 提供了一种简洁优雅的方式，让你能够在不改变接口的前提下，对属性进行有效管理（例如数据验证和格式转换）。这是类和对象封装中非常重要的一环，推荐你在需要的时候灵活使用。

