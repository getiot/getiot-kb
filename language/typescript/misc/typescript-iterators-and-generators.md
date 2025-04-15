---
sidebar_position: 8
slug: /typescript-iterators-and-generators
---

# TypeScript - 迭代器与生成器

在 TypeScript 中，迭代器（Iterator）和生成器（Generator）为你提供了更灵活的方式来控制数据的迭代过程。通过这些工具，你可以以更高效、可读性更强的方式处理集合、流数据或自定义的序列。本章将带你了解如何在 TypeScript 中创建和使用迭代器与生成器。



## 迭代器（Iterator）

### 什么是迭代器？

迭代器用于遍历可迭代对象。它是一个特殊函数，返回一个包含 `next()` 方法的迭代器对象。`next()` 方法返回一个包含以下两个属性的对象：

- **value**：序列中下一个元素的值。
- **done**：一个布尔值，表示迭代器是否已到达序列末尾。

### 示例 1：使用 `values()` 方法

```typescript showLineNumbers
const fruits = ['apple', 'banana', 'mango', 'orange', 'strawberry'];

const iterator = fruits.values();

console.log(iterator.next().value); // apple
console.log(iterator.next().value); // banana
console.log(iterator.next().value); // mango
console.log(iterator.next().value); // orange
console.log(iterator.next().value); // strawberry
console.log(iterator.next().value); // undefined
```

### 示例 2：创建自定义迭代器

```typescript showLineNumbers
function createArrayIterator(array: number[]): { next: () => { value: number | null; done: boolean } } {
    let currentIndex = 0;

    return {
        next: function () {
            return currentIndex < array.length
                ? { value: array[currentIndex++], done: false }
                : { value: null, done: true };
        }
    };
}

const numbers = [10, 20, 30];
const iterator = createArrayIterator(numbers);

console.log(iterator.next().value); // 10
console.log(iterator.next().value); // 20
console.log(iterator.next().value); // 30
console.log(iterator.next().done);  // true
```



## 生成器（Generator）

### 什么是生成器？

生成器函数类似于迭代器，但它们逐个返回值，而不是一次性返回所有值。调用生成器函数时，它返回一个生成器对象，可以用来逐个获取值。

生成器函数使用 `function*` 语法定义，并通过 `yield` 关键字来返回值。每次调用生成器的 `next()` 方法，函数会从上一次暂停的地方继续执行。

### 示例 1：基本生成器函数

```typescript showLineNumbers
function* numberGenerator() {
    yield 10;
    yield 20;
    yield 30;
}

const gen = numberGenerator();

console.log(gen.next().value); // 10
console.log(gen.next().value); // 20
console.log(gen.next().value); // 30
console.log(gen.next().done);  // true
```

### 示例 2：创建范围生成器

```typescript showLineNumbers
function* range(start: number, end: number) {
    for (let i = start; i <= end; i++) {
        yield i;
    }
}

for (const num of range(1, 5)) {
    console.log(num);
}
```

输出结果：

```bash
1
2
3
4
5
```



## 使用 `for...of` 迭代生成器

你可以使用 `for...of` 循环来迭代生成器返回的值：

```typescript
function* numbers() {
  yield 1;
  yield 2;
  yield 3;
}

for (let num of numbers()) {
  console.log(num);
}
```

上述代码会依次输出 `1`、`2` 和 `3`。使用 `for...of` 循环可以简化对生成器的迭代操作。



## 迭代器与生成器的区别

| 特性           | 迭代器                                                   | 生成器                                                     |
| -------------- | -------------------------------------------------------- | ---------------------------------------------------------- |
| **定义**       | 遵循迭代器协议的对象，特别是实现 `next()` 方法。         | 可以暂停执行并恢复的函数，内部自动管理状态。               |
| **控制机制**   | 通过 `next()` 方法手动控制迭代，返回 `{ value, done }`。 | 使用 `yield` 暂停并返回值，使用 `next()` 恢复执行。        |
| **语法**       | 通常涉及创建具有 `next()` 方法的对象。                   | 使用 `function*` 语法定义，并包含一个或多个 `yield` 语句。 |
| **使用复杂度** | 较高，因为需要显式管理状态并实现自定义的 `next()` 方法。 | 较低，因为状态管理和迭代控制通过 `yield` 简化。            |
| **适用场景**   | 适用于需要显式控制的简单自定义迭代。                     | 适用于复杂序列、异步任务或需要利用惰性求值的场景。         |



## 小结

通过学习本章内容，你了解了如何在 TypeScript 中使用迭代器和生成器来控制数据的迭代过程。迭代器提供了一个标准的接口来遍历集合，而生成器则允许你定义可以暂停和恢复的函数，提供了更强大的控制能力。通过迭代器，你可以手动控制遍历过程，而生成器则简化了复杂序列的实现。
