---
sidebar_position: 9
slug: /typescript-duck-typing
---

# TypeScript - Duck 类型

Duck 类型（Duck Typing）是一种根据对象的行为（如方法和属性）而不是其类来决定对象类型的编程理念。在 TypeScript 中，接口定义了对象必须具有的方法和属性，从而实现 Duck 类型。

Duck 类型强调通过对象的方法和属性来判断其是否适合某个任务，而不是其实际类型。例如，如果一个接口定义了一个方法 `myFunc()`，那么任何具有该方法的对象都可以被视为该接口的类型，无论其具体类是什么。



## Duck 类型的优势

Duck 类型的主要优势在于提高代码的灵活性和可重用性。代码可以与任何具有所需方法和属性的对象一起工作，而不仅仅限于特定类型的对象。这使得代码可以在多种情况下使用，而无需修改。Duck 类型还通过允许在单个代码库中互换使用不同类型的对象来提高代码的可重用性。



## Duck 类型示例

### 示例 1：定义接口并实现

```typescript showLineNumbers
interface Duck {
    quack(): void;
}

class MallardDuck implements Duck {
    quack(): void {
        console.log("Quack!");
    }
}

let duck: Duck = new MallardDuck();
duck.quack(); // 输出：Quack!
```



### 示例 2：不同类实现同一接口

```typescript showLineNumbers
interface Duck {
    quack(): void;
}

class RubberDuck implements Duck {
    quack(): void {
        console.log("Squeak!");
    }
}

let duck: Duck = new RubberDuck();
duck.quack(); // 输出：Squeak!
```

在上述示例中，`MallardDuck` 和 `RubberDuck` 类都实现了 `Duck` 接口，`duck` 变量可以被赋值为这两个类的实例。类型由接口中定义的行为（方法和属性）决定，而不是类本身。



### 示例 3：不同对象的互换使用

```typescript showLineNumbers
interface Flyable {
    fly(): void;
}

class Bird implements Flyable {
    fly(): void {
        console.log("Bird is flying");
    }
}

class Plane implements Flyable {
    fly(): void {
        console.log("Plane is flying");
    }
}

function goFly(flyable: Flyable) {
    flyable.fly();
}

let bird = new Bird();
let plane = new Plane();

goFly(bird);  // 输出：Bird is flying
goFly(plane); // 输出：Plane is flying
```



### 示例 4：Driveable 接口示例

```typescript showLineNumbers
interface Driveable {
    drive(): void;
}

class Car implements Driveable {
    drive(): void {
        console.log("Car is driving");
    }
}

class Truck implements Driveable {
    drive(): void {
        console.log("Truck is driving");
    }
}

function goDrive(driveable: Driveable) {
    driveable.drive();
}

let car = new Car();
let truck = new Truck();

goDrive(car);   // 输出：Car is driving
goDrive(truck); // 输出：Truck is driving
```



## Duck 类型的应用场景

以下是 Duck 类型的一些应用场景：

### 通用编程

- **函数参数灵活性**：编写一个函数，它接受任何具有特定方法的对象作为参数，而不关心对象的具体类型。例如，一个 `make_sound` 函数可以接受 `Duck` 对象、`Dog` 对象等，只要这些对象有 `quack()` 或 `bark()` 方法。
- **多态的实现**：通过 Duck 类型，可以实现类似多态的效果。例如，一个 `boot_device` 函数可以接受 `Car` 对象或 `Computer` 对象，只要它们都有 `start()` 方法。

### 文件处理

- **类文件对象**：创建一个类文件对象，只要它实现了文件对象的关键方法（如 `read()`、`write()` 等），就可以在需要文件接口的地方使用自定义的类文件对象。

### UI 组件

- **组件的统一接口**：为不同的 UI 组件定义一个通用接口，只要组件实现了该接口，就可以互换使用。例如，一个 `render` 函数可以接受任何实现了 `render()` 方法的 UI 组件对象。

### 数据处理

- **通用数据处理函数**：创建一个通用的数据处理函数，只要传入的对象具有 `getData()` 方法，就可以进行数据处理。例如，一个 `processData` 函数可以接受不同类型的对象，只要它们有 `getData()` 方法。

### 网络请求

- **不同网络请求库的互换**：定义一个接口，要求对象具有 `sendRequest()` 方法，这样不同的网络请求库可以互换使用。例如，一个 `AxiosRequest` 类和一个 `FetchRequest` 类都可以实现 `sendRequest()` 方法，从而可以被同一个函数调用。



## 小结

Duck 类型是一种强大的编程理念，它允许在 TypeScript 代码中互换使用不同类型的对象，只要它们具有相同的方法和属性。通过编写能够与具有所需方法和属性的任何对象一起工作的代码，而不是与特定对象一起工作的代码，可以使代码更加灵活和可重用。掌握 Duck 类型的使用，可以帮助你编写更加健壮和专业的 TypeScript 代码。
