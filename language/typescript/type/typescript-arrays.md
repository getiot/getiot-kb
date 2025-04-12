---
sidebar_position: 7
sidebar_label: TypeScript - 数组
slug: /typescript-arrays
---

# TypeScript - Array 数组

在 TypeScript 中，数组是一种用于存储多个值的数据结构。数组中的元素可以是相同类型或不同类型的值。数组提供了方便的方式来组织和操作一组相关的值。



## 数组的特点

- **顺序存储**：数组中的元素按顺序存储在内存中。
- **静态大小**：一旦初始化，数组的大小不能改变。
- **索引访问**：通过索引可以快速访问数组中的元素。
- **类型安全**：数组中的元素可以是特定类型，TypeScript 提供类型检查。



## 声明和初始化数组

在 TypeScript 中，你可以使用以下语法声明和初始化数组。

声明数组：

```typescript
let arrayName: dataType[]; 
// 或者 
let arrayName: Array<dataType>;
```

初始化数组：

```typescript
arrayName = [value1, value2, ..., valuen];
```

**示例**：声明和初始化数组

```typescript
let numbers: number[] = [1, 2, 3, 4];
console.log(numbers[0]); // 输出：1
console.log(numbers[1]); // 输出：2
```



## 使用数组构造函数

你可以使用 `Array` 构造函数来创建数组：

```typescript
let arr: number[] = new Array(4); // 创建一个大小为4的数组
for (let i = 0; i < arr.length; i++) {
    arr[i] = i * 2;
    console.log(arr[i]);
}
```

输出结果：

```bash
0
2
4
6
```

### 示例：使用逗号分隔值初始化数组

```typescript
let names: string[] = new Array("Mary", "Tom", "Jack", "Jill");
for (let i = 0; i < names.length; i++) {
    console.log(names[i]);
}
```

输出结果：

```bash
Mary
Tom
Jack
Jill
```



## 数组方法

以下是数组对象的一些常用方法：

| 方法名          | 描述                                                      |
| --------------- | --------------------------------------------------------- |
| `concat()`      | 返回一个新数组，由当前数组与其他数组或值连接而成          |
| `every()`       | 检查数组中的每个元素是否都满足测试函数的条件              |
| `filter()`      | 创建一个新数组，包含所有满足过滤函数条件的元素            |
| `forEach()`     | 对数组中的每个元素调用一次函数                            |
| `indexOf()`     | 返回数组中第一个等于指定值的元素的索引，未找到则返回 -1   |
| `join()`        | 将数组的所有元素连接成一个字符串                          |
| `lastIndexOf()` | 返回数组中最后一个等于指定值的元素的索引，未找到则返回 -1 |
| `map()`         | 创建一个新数组，包含调用提供的函数对每个元素的结果        |
| `pop()`         | 移除数组的最后一个元素并返回该元素                        |
| `push()`        | 向数组末尾添加一个或多个元素，并返回数组的新长度          |
| `reduce()`      | 从左到右对数组的每个元素应用函数，将其简化为一个值        |
| `reduceRight()` | 从右到左对数组的每个元素应用函数，将其简化为一个值        |
| `reverse()`     | 反转数组中元素的顺序                                      |
| `shift()`       | 移除数组的第一个元素并返回该元素                          |
| `slice()`       | 提取数组的一部分并返回一个新数组                          |
| `some()`        | 检查数组中是否至少有一个元素满足测试函数的条件            |
| `sort()`        | 对数组的元素进行排序                                      |
| `splice()`      | 向/从数组中添加和/或删除元素                              |
| `toString()`    | 返回表示数组及其元素的字符串                              |
| `unshift()`     | 向数组开头添加一个或多个元素，并返回数组的新长度          |



## 数组解构

数组解构允许你将数组中的元素解构为单独的变量：

```typescript
let arr: number[] = [12, 13];
let [x, y] = arr;
console.log(x); // 输出：12
console.log(y); // 输出：13
```



## 使用 `for...in` 遍历数组

你可以使用 `for...in` 循环来遍历数组：

```typescript
let nums: number[] = [1001, 1002, 1003, 1004];
for (let index in nums) {
    console.log(nums[index]);
}
```

输出结果：

```bash
1001
1002
1003
1004
```



## 小结

TypeScript 中的数组是一种强大的数据结构，用于存储和操作多个值。你可以通过索引快速访问数组元素，并使用多种方法来操作数组。掌握数组的声明、初始化和常用方法，可以帮助你更高效地编写 TypeScript 代码。数组的类型检查确保了代码的安全性和可维护性，建议在实际项目中充分利用这些特性。
