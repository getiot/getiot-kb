---
sidebar_position: 10
slug: /typescript-utility-types
---

# TypeScript - 工具类型

在 TypeScript 中，工具类型（Utility Types）是预定义的泛型类型，用于基于已有类型创建新类型。它们可以帮助你更高效地进行类型转换、增强代码的可读性，并减少重复代码。这些工具类型广泛应用于大型项目中，特别是在处理复杂类型结构时。



## Partial 类型

`Partial<T>` 类型将类型 `T` 的所有属性变为可选。这在你需要部分更新对象时非常有用。

在下面的示例中，我们创建了包含一些可选属性的 `Type`。之后，我们使用 `Partial` 工具类型创建了一个 `partialType` 对象。可以看到，我们尚未初始化 `partialType` 对象的所有属性，因为所有属性都是可选的。

```typescript showLineNumbers
type Type = {
    prop1: string;
    prop2: string;
    prop3: number;
    prop4?: boolean;
};

let partialType: Partial<Type> = {
    prop1: "Default",
    prop4: false,
};

console.log("The value of prop1 is " + partialType.prop1);
console.log("The value of prop2 is " + partialType.prop2);
```

输出结果：

```bash
The value of prop1 is Default
The value of prop2 is undefined
```



## Required 类型

`Required<T>` 类型将类型 `T` 的所有可选属性变为必选。

在下面示例中，`Type` 包含 *prop3* 可选属性。使用 `Required` 工具类型转换 `Type` 后，*prop3* 也变为必需属性。如果我们在创建对象时未为 *prop3* 赋值，则会生成编译错误。

```typescript showLineNumbers
type Type = {
    prop1: string;
    prop2: string;
    prop3?: number;
};

let requiredType: Required<Type> = {
    prop1: "Default",
    prop2: "Hello",
    prop3: 40,
};

console.log("The value of prop1 is " + requiredType.prop1);
console.log("The value of prop2 is " + requiredType.prop2);
```

输出结果：

```bash
The value of prop1 is Default
The value of prop2 is Hello
```



## Pick 类型

`Pick<T, K>` 类型允许你从类型 `T` 中选择特定的属性 `K`，构造一个新类型。

在下面的示例中，我们从 `Type1` 中选择了 *color* 和 *id* 属性，并使用 `Pick` 工具类型创建了新类型。可以看到，当我们尝试访问 *newObj* 的 *size* 属性时会报错，因为 *newObj* 对象的类型不包含 *size* 属性。

```typescript showLineNumbers
type Type1 = {
    color: string;
    size: number;
    id: string;
};

let newObj: Pick<Type1, "color" | "id"> = {
    color: "#00000",
    id: "5464fgfdr",
};

console.log(newObj.color);
```

输出结果：

```bash
#00000
```



## Omit 类型

`Omit<T, K>` 类型从类型 `T` 中排除属性 `K`，构造一个新类型。

在下面示例中，我们使用 `Omit` 工具类型省略了 `Type1` 中的 *color* 和 *id* 属性，并创建了 *omitObj* 对象。当我们尝试访问 *omitObj* 的 *color* 和 *id* 属性时，将会生成错误。

```typescript showLineNumbers
type Type1 = {
    color: string;
    size: number;
    id: string;
};

let omitObj: Omit<Type1, "color" | "id"> = {
    size: 20,
};

console.log(omitObj.size);
```

输出结果：

```bash
20
```



## Readonly 类型

`Readonly<T>` 类型将类型 `T` 的所有属性变为只读。

在下面示例中，`KeyboardType` 包含三个不同的属性。我们使用了 `Readonly` 工具类型，将键盘对象的所有属性设置为只读。只读属性意味着我们可以访问它来读取值，但不能修改或重新赋值。

```typescript showLineNumbers
type KeyboardType = {
    keys: number;
    isBackLight: boolean;
    size: number;
};

let keyboard: Readonly<KeyboardType> = {
    keys: 70,
    isBackLight: true,
    size: 20,
};

console.log("Is there backlight in the keyboard? " + keyboard.isBackLight);
console.log("Total keys in the keyboard are " + keyboard.keys);
```

输出结果：

```bash
Is there backlight in the keyboard? true
Total keys in the keyboard are 70
```



## ReturnType 类型

`ReturnType<T>` 类型用于获取函数的返回类型。

在下面示例中，我们创建了 `func()` 函数，它接受一个字符串作为参数并返回相同的字符串。我们在 `ReturnType` 工具类中使用了 `typeof` 运算符来标识函数的返回类型。

```typescript showLineNumbers
function func(param1: string): string {
    return param1;
}

let result: ReturnType<typeof func> = func("Hello");
console.log("The value of the result variable is " + result);
```

输出结果：

```bash
The value of the result variable is Hello
```



## Record 类型

`Record<K, T>` 类型用于创建一个对象，其键为 `K`，值为 `T`。

在下面的示例中，我们定义了 `Employee` 类型。之后，我们使用 `Record` 工具类型创建一个 `newEmployee` 对象。可以看到，`Record` 工具类在 `newEmployee` 对象中创建了 `Employee` 类型的 *Emp1* 和 *Emp2* 对象。

```typescript showLineNumbers
type Employee = {
    id: string;
    experience: number;
    emp_name: string;
};

let newEmployee: Record<"Emp1" | "Emp2", Employee> = {
    Emp1: {
        id: "12345",
        experience: 4,
        emp_name: "Rudy",
    },
    Emp2: {
        id: "12346",
        experience: 2,
        emp_name: "Tina",
    },
};

console.log(newEmployee.Emp1.emp_name);
console.log(newEmployee.Emp2.emp_name);
```

输出结果：

```bash
Rudy
Tina
```



## NonNullable 类型

`NonNullable<T>` 类型用于从类型 `T` 中排除 `null` 和 `undefined`。

在下面的示例中，我们创建了 `VarType` 联合类型，它也可以为 `null` 或 `undefined`。之后，我们将 `VarType` 与 `NonNullable` 工具类结合使用，可以观察到我们不能将 `null` 或 `undefined` 赋给该变量。

```typescript showLineNumbers
type VarType = number | boolean | null | undefined;

let variable2: NonNullable<VarType> = false;
let variable3: NonNullable<VarType> = 30;

console.log("The value of variable2 is " + variable2);
console.log("The value of variable3 is " + variable3);
```

输出结果：

```bash
The value of variable2 is false
The value of variable3 is 30
```



## 小结

TypeScript 的工具类型为你提供了强大的类型转换功能，使得在处理复杂类型时更加灵活和高效。通过合理使用这些工具类型，你可以提高代码的可读性、可维护性，并减少重复代码。掌握这些工具类型，将有助于你在 TypeScript 项目中编写更健壮的代码。
