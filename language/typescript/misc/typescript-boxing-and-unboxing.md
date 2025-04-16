---
sidebar_position: 11
slug: /typescript-boxing-and-unboxing
---

# TypeScript - 装箱与拆箱

在 TypeScript 中，装箱（Boxing）和拆箱（Unboxing）是处理原始类型与对象类型之间转换的机制。当你需要在原始类型上使用对象的方法或属性时，TypeScript 会自动将其“装箱”为对应的对象类型；反之，当需要将对象类型转换回原始类型时，则进行“拆箱”。



## 什么是装箱（Boxing）？

装箱是指将原始类型（如 `number`、`string`、`boolean`）转换为其对应的对象类型（如 `Number`、`String`、`Boolean`）。这使得你可以在原始类型上调用对象的方法。

示例：

```typescript
let num: number = 42;
let obj: Object = num; // 装箱
```

在这个例子中，变量 `num` 是一个原始类型的数字，通过赋值给 `obj`，它被自动装箱为 `Number` 对象。



## 什么是拆箱（Unboxing）？

拆箱是指将对象类型转换回其对应的原始类型。这通常通过类型断言或方法调用来实现。

示例：

```typescript
let obj: Object = 42; // 装箱
let num: number = <number>obj; // 拆箱
```

这里，`obj` 是一个对象类型，通过类型断言 `<number>`，我们将其拆箱回原始类型的数字。



## 装箱与拆箱的应用场景

在 TypeScript 中，装箱和拆箱主要用于以下场景：

- 当你需要在原始类型上调用对象的方法时，TypeScript 会自动进行装箱。例如：

  ```typescript
  let str: string = "hello";
  let length: number = str.length; // 自动装箱为 String 对象
  ```

- 在将对象类型转换回原始类型时，需要进行拆箱。例如：

  ```typescript
  let obj: Object = new Number(100);
  let num: number = (obj as Number).valueOf(); // 拆箱
  ```

在这个例子中，我们使用 `valueOf()` 方法从 `Number` 对象中获取原始的数字值。



## 注意事项

- 虽然 TypeScript 支持装箱和拆箱，但在实际开发中，建议尽量使用原始类型，避免不必要的装箱操作，以提高性能。
- 在进行拆箱时，确保对象确实是对应的包装类型，否则可能会导致运行时错误。



## 小结

装箱和拆箱是 TypeScript 中处理原始类型与对象类型之间转换的机制。通过装箱，你可以在原始类型上使用对象的方法；通过拆箱，你可以从对象类型中获取原始值。理解和正确使用装箱与拆箱，有助于你更好地掌握 TypeScript 的类型系统。
