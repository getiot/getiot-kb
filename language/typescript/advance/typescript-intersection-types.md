---
sidebar_position: 1
slug: /typescript-intersection-types
---

# TypeScript - 交叉类型

交叉类型（Intersection Types）是 TypeScript 中一种强大的类型系统特性，它允许你将多个类型合并成一个类型。通过使用 `&` 运算符，你可以创建一个包含所有指定类型属性的新类型。这种类型在需要组合多个接口或类型时特别有用。



## 语法

简单来说，交叉类型就是多个类型的集合体。你可以通过 `&` 运算符把多个类型“交叉”在一起，结果是一个同时具备所有类型属性的新类型。交叉类型的语法如下：

```typescript
type InterseptedType = Type1 & Type2 [ & Type3 ... ];
```



## 示例

### 示例 1：合并两个接口

```typescript
interface Book {
    book_id: number;
    book_name: string;
}

interface Author {
    author_id: number;
    author_name: string;
}

type IntersectedType = Book & Author;

let object1: IntersectedType = {
    book_id: 101,
    book_name: 'Typescript is Awesome',
    author_id: 202,
    author_name: 'GetIoT!',
};

console.log('Book Id: ' + object1.book_id);
console.log('Book name: ' + object1.book_name);
console.log('Author Id: ' + object1.author_id);
console.log('Author name: ' + object1.author_name);
```

输出结果：

```bash
Book Id: 101
Book name: Typescript is Awesome
Author Id: 202
Author name: GetIoT!
```



### 示例 2：交叉类型的交换律和结合律

交叉类型具有交换律和结合律，这意味着合并类型的顺序不会影响最终结果。

```typescript
interface Student {
    student_id: number;
    student_name: string;
}

interface Class {
    class_id: number;
    class_name: string;
}

interface Subject {
    subject_id: number;
    subject_name: string;
}

type IntersectedType1 = (Student & Class) & Subject;
type IntersectedType2 = Student & (Class & Subject);

let intersectedTypeObject1: IntersectedType1 = {
    student_id: 101,
    student_name: 'Typescript',
    class_id: 10,
    class_name: 'Math',
    subject_id: 1,
    subject_name: 'Science'
};

let intersectedTypeObject2: IntersectedType2 = {
    student_id: 102,
    student_name: 'Typescript2',
    class_id: 11,
    class_name: 'English',
    subject_id: 2,
    subject_name: 'History'
};

console.log(typeof intersectedTypeObject1 === typeof intersectedTypeObject2);
```

输出结果：

```bash
true
```



### 示例3：不兼容属性的交叉

```typescript
interface A {
   id: number;
}

interface B {
   id: string;
}

type C = A & B; // 报错：id 类型冲突
```

在这个例子中，`A` 和 `B` 中的 `id` 属性类型不同，无法交叉合并，TypeScript 会抛出错误。



## 使用场景

交叉类型在需要组合多个接口或类型时非常有用，比如：

- 表示一个对象拥有多种身份或能力；
- 用于混合类型构建组件；
- 构建复杂的数据模型时简化逻辑结构。



## 注意事项

- 交叉类型的结果类型将包含所有参与类型的属性，因此在赋值时必须满足所有字段要求。
- 如果多个类型中有重名属性，类型需要兼容，否则会报错。



## 小结

TypeScript 的交叉类型提供了一种灵活的方式来组合多个类型，创建具有所有指定属性的新类型。通过 `&` 运算符，你可以轻松地合并接口或类型，从而提高代码的可读性和可维护性。交叉类型的交换律和结合律确保了合并类型的顺序不会影响最终结果，这使得交叉类型在复杂的类型系统中非常有用。
