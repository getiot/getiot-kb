---
sidebar_position: 14
---

# JavaScript 数组 map() 方法



JavaScript 的 Array 数组对象有一个 `map()` 方法，它可以对数组的每个元素进行操作，并返回一个新的数组。



## map() 方法介绍

假设有一个数组 arr，那么 `map()` 方法的语法如下：

```javascript showLineNumbers
arr.map(callbackfn[, thisArg]);
```

其中，参数 `callbackfn` 是必须的，它是包含了操作数组 array 元素的回调函数；参数 `thisArg` 是可选的，表示 callbackfn 函数中 this 关键字的可引用对象。

回调函数的语法如下：

```javascript showLineNumbers
function callbackfn (element, index, array);
```

其中，参数 `element` 表示当前数组元素；`index` 表示数组元素的数字索引；`array` 包含该元素的整个数组对象。



## 使用示例

下面通过几个示例来加深对 Array 数组 map() 方法的理解。

### 示例 1

```javascript showLineNumbers
let arr = [1, 2, 3, 4, 5, 6];

let arr2 = arr.map(function(element) {
    return element * 2;
});

console.log(arr2);  // 输出 [ 2, 4, 6, 8, 10, 12 ]
```

上述代码相当于使用 for 循环将数据 arr 的元素乘以 2，如下：

```javascript showLineNumbers
let arr = [1, 2, 3, 4, 5, 6];
let arr2 = new Array();

for (let i = 0; i < arr.length; i++) {
    arr2[i] = arr[i] * 2;
}

console.log(arr2);  // 输出 [ 2, 4, 6, 8, 10, 12 ]
```



### 示例 2

假设有一个对象数组，里面存储你的朋友的 `firstName` 和 `lastName`，如下所示：

```javascript showLineNumbers
let users = [
    {firstName : "Susan", lastName: "Steward"},
    {firstName : "Daniel", lastName: "Longbottom"},
    {firstName : "Jacob", lastName: "Black"}
];
```

那么，你可以使用 `map()` 方法遍历数组，将 `firstName` 和 `lastName`的值拼接起来。如下所示：

```javascript showLineNumbers
let users = [
    {firstName : "Susan", lastName: "Steward"},
    {firstName : "Daniel", lastName: "Longbottom"},
    {firstName : "Jacob", lastName: "Black"}
];

let userFullnames = users.map(function(element) {
    return `${element.firstName} ${element.lastName}`;
})

console.log(userFullnames);
// 输出 [ 'Susan Steward', 'Daniel Longbottom', 'Jacob Black' ]
```



