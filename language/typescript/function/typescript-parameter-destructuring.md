---
sidebar_position: 8
slug: /typescript-parameter-destructuring
---

# TypeScript - 参数解构

在 TypeScript 中，**参数解构**（Parameter Destructuring） 是一种方便的语法糖，允许你直接从对象或数组中“解包”出需要的字段并作为函数参数使用。这种方式不仅让代码更简洁，也更具可读性。

如果你熟悉 ES6 中的解构赋值，那么这个语法对你来说应该很容易上手。



## 语法

参数解构的基本语法如下：

```typescript
function getObjValues({ key1, key2 }: { key1: string; key2: number }) {
   // 使用 key1 和 key2 作为变量
}

// 调用函数时传入对象
getObjValues({ key1: "Hello", key2: 20 });
```

在上面的例子中，我们通过解构的方式，将传入对象的 `key1` 和 `key2` 属性直接提取为函数参数中的变量。



## 示例

### 示例 1：基本对象解构

下面是一个简单的例子，展示了如何在函数参数中解构对象：

```typescript showLineNumbers
function printObjValues({ key1, key2 }: { key1: string; key2: number }) {
   console.log("The value of key1 is " + key1);
   console.log("The value of key2 is " + key2);
}

printObjValues({ key1: "Hello", key2: 20 });
printObjValues({ key1: "TypeScript", key2: 50 });
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
function printObjValues(_a) {
   var key1 = _a.key1, key2 = _a.key2;
   console.log("The value of key1 is " + key1);
   console.log("The value of key2 is " + key2);
}

printObjValues({ key1: "Hello", key2: 20 });
printObjValues({ key1: "TypeScript", key2: 50 });
```

输出结果：

```bash
The value of key1 is Hello
The value of key2 is 20
The value of key1 is TypeScript
The value of key2 is 50
```



### 示例 2：带有默认值的解构

在参数解构中，你可以为参数设置默认值。如果调用函数时没有传入相应的属性，将使用默认值：

```typescript showLineNumbers
function getParams({
   param1,
   param2 = "default",
}: {
   param1: boolean;
   param2?: string;
}) {
   console.log("The value of param1 is " + param1);
   console.log("The value of param2 is " + param2);
}

getParams({ param1: true, param2: "value" });
getParams({ param1: false });
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
function getParams(_a) {
   var param1 = _a.param1, _b = _a.param2, param2 = _b === void 0 ? "default" : _b;
   console.log("The value of param1 is " + param1);
   console.log("The value of param2 is " + param2);
}

getParams({ param1: true, param2: "value" });
getParams({ param1: false });
```

输出结果：

```bash
The value of param1 is true
The value of param2 is value
The value of param1 is false
The value of param2 is default
```



### 示例 3：所有参数可选并设置默认对象

你可以为整个参数对象设置默认值，这样即使调用函数时不传入任何参数，函数也能正常运行：

```typescript showLineNumbers
function sample_function(
   {
      value1,
      value2,
      value3,
   }: {
      value1?: number;
      value2?: number;
      value3?: number;
   } = { value1: 20, value2: 30, value3: 40 }
): number {
   let sum = value1 + value2 + value3;
   return sum;
}

console.log("The sum of default values is " + sample_function());
console.log(
   "The sum of 10000, 20302, and value3 is " +
   sample_function({ value1: 10000, value2: 20302 })
);
console.log(
   "The sum of 10, 20, and 25 is " +
   sample_function({ value1: 10, value2: 20, value3: 25 })
);
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
function sample_function(_a) {
   var _b = _a === void 0 ? { value1: 20, value2: 30, value3: 40 } :
    _a, value1 = _b.value1, value2 = _b.value2, value3 = _b.value3;
   var sum = value1 + value2 + value3;
   return sum;
}
console.log("The sum of default values is " + sample_function());
console.log("The sum of 10000, 20302, and value3 is " + sample_function({ value1: 10000, value2: 20302 }));
console.log("The sum of 10, 20, and 25 is " + sample_function({ value1: 10, value2: 20, value3: 25 }));
```

输出结果：

```bash
The sum of default values is 90
The sum of 10000, 20302, and value3 is NaN
The sum of 10, 20, and 25 is 55
```

**注意**：在第二个调用中，由于没有传入 `value3`，而默认对象中 `value3` 的值为 40，但传入的 `value1` 和 `value2` 是 10000 和 20302，所以 `value3` 仍然是 40。然而，由于 `value1` 和 `value2` 的值非常大，`value3` 的值相对可以忽略，但实际计算时仍然是 10000 + 20302 + 40 = 30342。上面的输出结果可能存在错误，正确的输出应该是：

```bash
The sum of default values is 90
The sum of 10000, 20302, and value3 is 30342
The sum of 10, 20, and 25 is 55
```



### 示例 4：接口与解构

你可以结合接口来定义参数的类型，使代码更加类型安全：

```typescript showLineNumbers
interface Lock {
   lock_id?: string;
   isDurable?: boolean;
}

let lockObj: Lock = {
   lock_id: "4523fdr0",
   isDurable: true,
};

function callLockFunc(obj: Lock) {
   let { lock_id, isDurable } = obj;
   console.log("The destructured lock_id value is " + lock_id);
   console.log("The destructured isDurable value is " + isDurable);
}

callLockFunc(lockObj);

lockObj.isDurable = false;
lockObj.lock_id = "eredf";
callLockFunc(lockObj);
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
var lockObj = {
   lock_id: "4523fdr0",
   isDurable: true
};
function callLockFunc(obj) {
   var lock_id = obj.lock_id, isDurable = obj.isDurable;
   console.log("The destructured lock_id value is " + lock_id);
   console.log("The destructured isDurable value is " + isDurable);
}

callLockFunc(lockObj);
lockObj.isDurable = false;
lockObj.lock_id = "eredf";
callLockFunc(lockObj);
```

输出结果：

```bash
The destructured lock_id value is 4523fdr0
The destructured isDurable value is true
The destructured lock_id value is eredf
The destructured isDurable value is false
```



## 小结

TypeScript 的参数解构功能允许你在函数参数中直接解构对象或数组，从而提取出所需的值。这不仅让代码更加简洁，还提高了可读性。通过为参数设置默认值，你可以使函数更加灵活，能够处理不同情况的输入。结合接口使用参数解构，可以进一步增强代码的类型安全性。掌握参数解构后，你将能够写出更加优雅和高效的 TypeScript 代码。
