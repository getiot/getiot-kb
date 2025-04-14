---
sidebar_position: 6
slug: /typescript-mapped-types
---

# TypeScript - 映射类型

在 TypeScript 中，**映射类型**（Mapped Types） 让你可以基于已有的类型创建出新的类型。映射类型通过遍历现有类型的每个属性（比如改变它们的可选性、只读性），并对其进行某种转换，从而生成新的类型。这使得你可以轻松地重用现有类型，并根据需要创建新的变体。



## 内置映射类型

TypeScript 提供了多种内置的映射类型，它们可以帮助你快速地对现有类型进行常见的转换：

- **`Partial<T>`**：将类型 `T` 的所有属性变为可选。
- **`Required<T>`**：将类型 `T` 的所有属性变为必选。
- **`Readonly<T>`**：将类型 `T` 的所有属性变为只读。
- **`Record<K, T>`**：创建一个对象类型，其键为 `K`，值为 `T`。
- **`Pick<T, K>`**：从类型 `T` 中选择指定的属性 `K`，构造一个新类型。
- **`Omit<T, K>`**：从类型 `T` 中排除指定的属性 `K`，构造一个新类型。
- **`Exclude<T, U>`**：从联合类型 `T` 中排除可分配给 `U` 的类型。
- **`Extract<T, U>`**：从联合类型 `T` 中提取可分配给 `U` 的类型。
- **`NonNullable<T>`**：从类型 `T` 中排除 `null` 和 `undefined`。



## 基础示例

### 示例：使用 `Partial` 类型

```typescript showLineNumbers
type Person = {
    name: string;
    age: number;
};

type PartialPerson = Partial<Person>;

const partialPerson: PartialPerson = {
    name: "John",
};

console.log(partialPerson);
```

输出结果：

```bash
{ name: 'John' }
```



### 示例：使用 `Readonly` 类型

```typescript showLineNumbers
type Person = {
    name: string;
    age: number;
};

type ReadonlyPerson = Readonly<Person>;

const readonlyPerson: ReadonlyPerson = {
    name: "John",
    age: 30,
};

// readonlyPerson.name = "Doe"; // 错误：无法分配到 'name'，因为它是只读属性。
console.log(readonlyPerson);
```

输出结果：

```bash
{ name: 'John', age: 30 }
```



### 示例：使用 `Pick` 类型

```typescript showLineNumbers
type Animal = {
    name: string;
    species: string;
    age: number;
};

type AnimalNameAndSpecies = Pick<Animal, 'name' | 'species'>;

const animalNameAndSpecies: AnimalNameAndSpecies = {
    name: 'Milo',
    species: 'Dog',
};

console.log(animalNameAndSpecies);
```

输出结果：

```bash
{ name: 'Milo', species: 'Dog' }
```



## 自定义映射类型

你可以通过以下语法创建自定义映射类型：

```typescript
type MyMappedType<T> = {
    [P in keyof T]: NewType;
};
```



### 示例：将所有属性转换为布尔类型

```typescript showLineNumbers
type Person = {
    name: string;
    age: number;
};

type Booleanify<T> = {
    [P in keyof T]: boolean;
};

const boolPerson: Booleanify<Person> = {
    name: true,
    age: true,
};

console.log(boolPerson);
```

输出结果：

```bash
{ name: true, age: true }
```



### 示例：将所有属性变为可选

```typescript showLineNumbers
type Animal = {
    name: string;
    legs: number;
};

type CustomAnimal = {
    [key in keyof Animal]?: Animal[key];
};

const customAnimal: CustomAnimal = {
    name: "Dog",
    legs: 4,
};

console.log(customAnimal);
```

输出结果：

```bash
{ name: 'Dog', legs: 4 }
```



## 小结

TypeScript 的映射类型能够帮助你以声明性的方式批量修改属性类型，比如添加只读、可选、去除修饰符等。掌握映射类型不仅能帮你减少重复代码，还能让你的类型系统更加健壮和灵活。
