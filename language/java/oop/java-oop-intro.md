---
sidebar_position: 1
slug: /java-oop-intro
sidebar_label: Java 面向对象思想
---

# Java 面向对象思想

面向对象编程（Object-Oriented Programming，OOP）是一种编程范式，它将现实世界的事物抽象为对象，通过对象之间的交互来解决问题。理解面向对象思想是掌握 Java 编程的核心。

## OOP 核心思想：封装、继承、多态

### 什么是面向对象

**面向对象编程**是一种以对象为中心的编程思想，它将数据和操作数据的方法封装在一起，形成类（Class），然后通过创建对象（Object）来使用这些类。

**核心概念**：
- **类（Class）**：对象的模板，定义对象的属性和行为
- **对象（Object）**：类的实例，具有具体的属性值
- **封装（Encapsulation）**：隐藏实现细节，提供接口
- **继承（Inheritance）**：代码复用，建立类之间的关系
- **多态（Polymorphism）**：同一接口，不同实现

### 封装（Encapsulation）

**封装**是将数据和对数据的操作封装在一起，隐藏内部实现细节，只暴露必要的接口。

**目的**：
- 保护数据，防止外部直接访问
- 简化使用，隐藏复杂性
- 便于维护，修改内部实现不影响外部

**示例**：
```java
public class BankAccount {
    // 私有属性（封装）
    private double balance;
    
    // 公共方法（接口）
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    
    public void withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
        }
    }
    
    public double getBalance() {
        return balance;
    }
}
```

**优势**：
- 数据安全：不能直接修改 balance
- 控制访问：通过方法控制操作
- 易于维护：修改实现不影响使用

### 继承（Inheritance）

**继承**是子类继承父类的属性和方法，实现代码复用和扩展。

**目的**：
- 代码复用：避免重复编写相同代码
- 建立关系：表达"是一个"的关系
- 扩展功能：在父类基础上添加新功能

**示例**：
```java
// 父类
public class Animal {
    protected String name;
    
    public void eat() {
        System.out.println(name + " 正在吃东西");
    }
}

// 子类继承父类
public class Dog extends Animal {
    public void bark() {
        System.out.println(name + " 在叫");
    }
}

// 使用
Dog dog = new Dog();
dog.name = "旺财";
dog.eat();   // 继承自父类
dog.bark();  // 子类特有方法
```

**优势**：
- 代码复用：子类自动拥有父类功能
- 层次结构：建立清晰的类层次
- 多态基础：为多态提供支持

### 多态（Polymorphism）

**多态**是同一接口可以有多种不同的实现方式。

**形式**：
1. **方法重写（Override）**：子类重写父类方法
2. **方法重载（Overload）**：同名方法不同参数
3. **接口多态**：实现接口的不同类

**示例**：
```java
// 父类
public class Animal {
    public void makeSound() {
        System.out.println("动物发出声音");
    }
}

// 子类 1
public class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("汪汪汪");
    }
}

// 子类 2
public class Cat extends Animal {
    @Override
    public void makeSound() {
        System.out.println("喵喵喵");
    }
}

// 多态使用
Animal animal1 = new Dog();
Animal animal2 = new Cat();

animal1.makeSound();  // 汪汪汪（调用 Dog 的方法）
animal2.makeSound();  // 喵喵喵（调用 Cat 的方法）
```

**优势**：
- 灵活性：同一接口，不同行为
- 可扩展性：添加新类不影响现有代码
- 代码简洁：统一处理不同类型的对象

## 对象与类的关系

### 类（Class）

**类**是对象的模板或蓝图，定义了对象应该具有的属性和行为。

**类比**：
- 类 = 建筑设计图
- 对象 = 根据设计图建造的房子

```java
// 类定义
public class Student {
    // 属性（字段）
    private String name;
    private int age;
    
    // 方法（行为）
    public void study() {
        System.out.println(name + " 正在学习");
    }
    
    public void introduce() {
        System.out.println("我是 " + name + "，今年 " + age + " 岁");
    }
}
```

### 对象（Object）

**对象**是类的实例，具有具体的属性值。

```java
// 创建对象（实例化）
Student student1 = new Student();
student1.name = "张三";
student1.age = 20;

Student student2 = new Student();
student2.name = "李四";
student2.age = 22;

// 每个对象有独立的属性
student1.introduce();  // 我是 张三，今年 20 岁
student2.introduce();  // 我是 李四，今年 22 岁
```

### 类与对象的关系

| 概念 | 说明 | 示例 |
|:----:|:----:|:----:|
| 类 | 模板、蓝图 | `Student` 类 |
| 对象 | 类的实例 | `student1`、`student2` |
| 实例化 | 创建对象的过程 | `new Student()` |
| 属性 | 对象的状态 | `name`、`age` |
| 方法 | 对象的行为 | `study()`、`introduce()` |

**关系总结**：
- 一个类可以创建多个对象
- 每个对象有独立的属性值
- 所有对象共享类的方法
- 对象通过方法操作属性

## 面向对象的优势

### 1. 代码复用

**通过继承和组合实现代码复用**：

```java
// 基础类
public class Vehicle {
    protected String brand;
    
    public void start() {
        System.out.println(brand + " 启动");
    }
}

// 复用 Vehicle 的代码
public class Car extends Vehicle {
    public void drive() {
        start();  // 复用父类方法
        System.out.println("汽车行驶");
    }
}

public class Motorcycle extends Vehicle {
    public void ride() {
        start();  // 复用父类方法
        System.out.println("摩托车行驶");
    }
}
```

### 2. 模块化

**将功能封装在类中，形成独立的模块**：

```java
// 用户模块
public class User {
    private String username;
    private String password;
    // ...
}

// 订单模块
public class Order {
    private int orderId;
    private double amount;
    // ...
}

// 产品模块
public class Product {
    private String name;
    private double price;
    // ...
}
```

### 3. 易于维护

**修改内部实现不影响外部使用**：

```java
public class Calculator {
    // 内部实现可以改变，但接口不变
    public int add(int a, int b) {
        // 实现方式 1：直接相加
        // return a + b;
        
        // 实现方式 2：使用位运算（内部改变，外部不受影响）
        while (b != 0) {
            int carry = a & b;
            a = a ^ b;
            b = carry << 1;
        }
        return a;
    }
}
```

### 4. 易于扩展

**通过继承和多态轻松扩展功能**：

```java
// 基础支付类
public abstract class Payment {
    protected double amount;
    
    public abstract void pay();
}

// 扩展：信用卡支付
public class CreditCardPayment extends Payment {
    @Override
    public void pay() {
        System.out.println("使用信用卡支付：" + amount);
    }
}

// 扩展：支付宝支付
public class AlipayPayment extends Payment {
    @Override
    public void pay() {
        System.out.println("使用支付宝支付：" + amount);
    }
}
```

### 5. 模拟现实世界

**用对象模拟现实世界的事物**：

```java
// 现实世界：学生、课程、成绩
public class Student {
    private String name;
    private List<Course> courses;
}

public class Course {
    private String name;
    private int credits;
}

public class Grade {
    private Student student;
    private Course course;
    private double score;
}
```

### 6. 团队协作

**不同开发者可以独立开发不同的类**：

```java
// 开发者 A：用户管理模块
public class UserManager {
    // ...
}

// 开发者 B：订单管理模块
public class OrderManager {
    // ...
}

// 开发者 C：整合使用
public class Application {
    private UserManager userManager;
    private OrderManager orderManager;
    // ...
}
```

## 面向对象 vs 面向过程

### 面向过程

**以过程为中心，关注"怎么做"**：

```java
// 面向过程：关注步骤
public class ProceduralExample {
    public static void main(String[] args) {
        String name = "张三";
        int age = 20;
        
        // 直接操作数据
        System.out.println("姓名：" + name);
        System.out.println("年龄：" + age);
    }
}
```

### 面向对象

**以对象为中心，关注"谁做什么"**：

```java
// 面向对象：关注对象
public class Student {
    private String name;
    private int age;
    
    public void display() {
        System.out.println("姓名：" + name);
        System.out.println("年龄：" + age);
    }
}

public class OOPExample {
    public static void main(String[] args) {
        Student student = new Student();
        student.name = "张三";
        student.age = 20;
        student.display();  // 对象自己显示信息
    }
}
```

### 对比

| 特性 | 面向过程 | 面向对象 |
|:----:|:--------:|:--------:|
| 关注点 | 过程、步骤 | 对象、数据 |
| 代码组织 | 函数 | 类和方法 |
| 数据访问 | 全局变量 | 对象属性 |
| 复用性 | 函数复用 | 类复用 |
| 维护性 | 较难 | 较易 |
| 适用场景 | 简单程序 | 复杂系统 |

## 实际示例

### 示例 1：完整的面向对象设计

```java
// 类：汽车
public class Car {
    // 属性
    private String brand;
    private String color;
    private int speed;
    
    // 构造方法
    public Car(String brand, String color) {
        this.brand = brand;
        this.color = color;
        this.speed = 0;
    }
    
    // 方法
    public void accelerate(int increment) {
        speed += increment;
        System.out.println(brand + " 加速到 " + speed + " km/h");
    }
    
    public void brake(int decrement) {
        speed = Math.max(0, speed - decrement);
        System.out.println(brand + " 减速到 " + speed + " km/h");
    }
    
    public void displayInfo() {
        System.out.println("品牌：" + brand + "，颜色：" + color + "，速度：" + speed);
    }
}

// 使用
public class CarDemo {
    public static void main(String[] args) {
        Car car = new Car("丰田", "红色");
        car.displayInfo();
        car.accelerate(50);
        car.brake(20);
    }
}
```

### 示例 2：封装、继承、多态综合

```java
// 父类：动物（封装）
public class Animal {
    protected String name;
    
    public Animal(String name) {
        this.name = name;
    }
    
    public void eat() {
        System.out.println(name + " 正在吃东西");
    }
    
    public void makeSound() {
        System.out.println(name + " 发出声音");
    }
}

// 子类：狗（继承）
public class Dog extends Animal {
    public Dog(String name) {
        super(name);
    }
    
    // 多态：重写父类方法
    @Override
    public void makeSound() {
        System.out.println(name + " 汪汪叫");
    }
    
    public void bark() {
        System.out.println(name + " 在叫");
    }
}

// 子类：猫（继承）
public class Cat extends Animal {
    public Cat(String name) {
        super(name);
    }
    
    // 多态：重写父类方法
    @Override
    public void makeSound() {
        System.out.println(name + " 喵喵叫");
    }
}

// 使用多态
public class AnimalDemo {
    public static void main(String[] args) {
        Animal[] animals = {
            new Dog("旺财"),
            new Cat("咪咪")
        };
        
        // 多态：同一接口，不同实现
        for (Animal animal : animals) {
            animal.eat();
            animal.makeSound();
        }
    }
}
```

## 小结

Java 面向对象思想要点：

- **核心思想**：封装、继承、多态
- **类与对象**：类是模板，对象是实例
- **优势**：代码复用、模块化、易维护、易扩展
- **设计原则**：关注对象，而非过程

**关键要点**：
- 封装保护数据，提供接口
- 继承实现代码复用
- 多态提供灵活性
- 类定义结构，对象是实例
- 面向对象适合复杂系统

理解了面向对象思想，你就能设计出更好的程序结构。在下一章，我们将学习如何定义类和使用对象。
