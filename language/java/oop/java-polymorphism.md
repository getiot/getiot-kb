---
sidebar_position: 8
slug: /java-polymorphism
sidebar_label: Java 多态
---

# Java 多态（Polymorphism）

多态是面向对象编程的核心特性之一，它允许同一接口有不同的实现方式。理解多态是掌握面向对象编程的关键。本章将详细介绍 Java 中的多态机制。

## 多态的概念

### 什么是多态

**多态**（Polymorphism）是指同一接口可以有多种不同的实现方式。

**核心思想**：
- **同一接口**：相同的方法调用
- **不同实现**：不同的类提供不同的实现
- **运行时决定**：根据实际对象类型调用对应的方法

### 多态的类型

Java 中的多态主要有两种形式：

1. **编译时多态**：方法重载（Overload）
2. **运行时多态**：方法重写（Override）

## 运行时多态（方法重写）

### 基本示例

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

### 多态的工作原理

**多态通过方法重写实现**：

```java
// 编译时：animal 的类型是 Animal
// 运行时：animal 指向的实际对象是 Dog
Animal animal = new Dog();
animal.makeSound();  // 运行时根据实际对象类型调用方法
```

**过程**：
1. 编译时：检查 `Animal` 类是否有 `makeSound()` 方法
2. 运行时：根据实际对象类型（`Dog`）调用对应的方法

## 多态的应用场景

### 1. 方法参数多态

**方法参数使用父类类型，可以接收任何子类对象**：

```java
public class Animal {
    public void eat() {
        System.out.println("动物吃东西");
    }
}

public class Dog extends Animal {
    @Override
    public void eat() {
        System.out.println("狗吃骨头");
    }
}

public class Cat extends Animal {
    @Override
    public void eat() {
        System.out.println("猫吃鱼");
    }
}

// 方法参数使用父类类型
public void feedAnimal(Animal animal) {
    animal.eat();  // 多态：根据实际对象类型调用方法
}

// 使用
feedAnimal(new Dog());  // 狗吃骨头
feedAnimal(new Cat());  // 猫吃鱼
```

### 2. 数组多态

**数组元素类型使用父类，可以存储任何子类对象**：

```java
Animal[] animals = new Animal[3];
animals[0] = new Dog();
animals[1] = new Cat();
animals[2] = new Animal();

// 统一处理
for (Animal animal : animals) {
    animal.eat();  // 多态：根据实际对象类型调用方法
}
```

### 3. 集合多态

**集合使用父类类型，可以存储任何子类对象**：

```java
List<Animal> animals = new ArrayList<>();
animals.add(new Dog());
animals.add(new Cat());
animals.add(new Animal());

// 统一处理
for (Animal animal : animals) {
    animal.eat();  // 多态
}
```

### 4. 返回值多态

**方法返回父类类型，可以返回任何子类对象**：

```java
public Animal createAnimal(String type) {
    if ("dog".equals(type)) {
        return new Dog();
    } else if ("cat".equals(type)) {
        return new Cat();
    } else {
        return new Animal();
    }
}

// 使用
Animal animal = createAnimal("dog");
animal.eat();  // 多态
```

## instanceof 运算符

### 类型检查

**`instanceof` 用于检查对象是否是某个类的实例**：

```java
Animal animal = new Dog();

// 检查类型
if (animal instanceof Dog) {
    System.out.println("是狗");
}

if (animal instanceof Animal) {
    System.out.println("是动物");
}

// 类型转换
if (animal instanceof Dog) {
    Dog dog = (Dog) animal;  // 安全转换
    dog.bark();
}
```

### 类型转换

**向上转型（Upcasting）**：子类转父类，自动转换

```java
Dog dog = new Dog();
Animal animal = dog;  // 向上转型，自动转换
```

**向下转型（Downcasting）**：父类转子类，需要强制转换

```java
Animal animal = new Dog();
Dog dog = (Dog) animal;  // 向下转型，需要强制转换
```

**安全转换**：

```java
Animal animal = new Dog();

// ❌ 不安全：可能抛出 ClassCastException
// Cat cat = (Cat) animal;

// ✅ 安全：先检查类型
if (animal instanceof Dog) {
    Dog dog = (Dog) animal;
    dog.bark();
}
```

## 多态的优势

### 1. 代码复用

**统一处理不同类型的对象**：

```java
// 不需要为每种类型写单独的方法
public void processAnimals(List<Animal> animals) {
    for (Animal animal : animals) {
        animal.eat();  // 统一处理
    }
}

// 而不是
// public void processDogs(List<Dog> dogs) { }
// public void processCats(List<Cat> cats) { }
```

### 2. 可扩展性

**添加新类型不需要修改现有代码**：

```java
// 现有代码
public void feedAnimal(Animal animal) {
    animal.eat();
}

// 添加新类型
public class Bird extends Animal {
    @Override
    public void eat() {
        System.out.println("鸟吃虫子");
    }
}

// 不需要修改 feedAnimal 方法
feedAnimal(new Bird());  // 直接使用
```

### 3. 灵活性

**运行时决定调用哪个方法**：

```java
Animal animal;
if (condition) {
    animal = new Dog();
} else {
    animal = new Cat();
}
animal.eat();  // 根据条件调用不同的方法
```

## 实际示例

### 示例 1：图形多态

```java
// 父类：图形
public abstract class Shape {
    protected String name;
    
    public Shape(String name) {
        this.name = name;
    }
    
    public abstract double getArea();
    
    public void display() {
        System.out.println("图形：" + name);
        System.out.println("面积：" + getArea());
    }
}

// 子类：圆形
public class Circle extends Shape {
    private double radius;
    
    public Circle(double radius) {
        super("圆形");
        this.radius = radius;
    }
    
    @Override
    public double getArea() {
        return Math.PI * radius * radius;
    }
}

// 子类：矩形
public class Rectangle extends Shape {
    private double width;
    private double height;
    
    public Rectangle(double width, double height) {
        super("矩形");
        this.width = width;
        this.height = height;
    }
    
    @Override
    public double getArea() {
        return width * height;
    }
}

// 多态使用
Shape[] shapes = {
    new Circle(5),
    new Rectangle(4, 6),
    new Circle(3)
};

// 统一处理
for (Shape shape : shapes) {
    shape.display();  // 多态：根据实际类型调用方法
}
```

### 示例 2：员工管理系统

```java
// 父类：员工
public class Employee {
    protected String name;
    protected double baseSalary;
    
    public Employee(String name, double baseSalary) {
        this.name = name;
        this.baseSalary = baseSalary;
    }
    
    public double calculateSalary() {
        return baseSalary;
    }
    
    public void displayInfo() {
        System.out.println("姓名：" + name);
        System.out.println("薪资：" + calculateSalary());
    }
}

// 子类：经理
public class Manager extends Employee {
    private double bonus;
    
    public Manager(String name, double baseSalary, double bonus) {
        super(name, baseSalary);
        this.bonus = bonus;
    }
    
    @Override
    public double calculateSalary() {
        return baseSalary + bonus;
    }
}

// 子类：销售
public class Salesperson extends Employee {
    private double commission;
    private double sales;
    
    public Salesperson(String name, double baseSalary, double commission, double sales) {
        super(name, baseSalary);
        this.commission = commission;
        this.sales = sales;
    }
    
    @Override
    public double calculateSalary() {
        return baseSalary + sales * commission;
    }
}

// 多态使用
List<Employee> employees = new ArrayList<>();
employees.add(new Employee("张三", 5000));
employees.add(new Manager("李四", 8000, 2000));
employees.add(new Salesperson("王五", 4000, 0.1, 50000));

// 统一计算薪资
for (Employee employee : employees) {
    employee.displayInfo();  // 多态：根据实际类型计算薪资
}
```

### 示例 3：支付系统

```java
// 接口：支付方式
public interface Payment {
    void pay(double amount);
}

// 实现类：信用卡支付
public class CreditCardPayment implements Payment {
    private String cardNumber;
    
    public CreditCardPayment(String cardNumber) {
        this.cardNumber = cardNumber;
    }
    
    @Override
    public void pay(double amount) {
        System.out.println("使用信用卡支付：" + amount);
    }
}

// 实现类：支付宝支付
public class AlipayPayment implements Payment {
    private String account;
    
    public AlipayPayment(String account) {
        this.account = account;
    }
    
    @Override
    public void pay(double amount) {
        System.out.println("使用支付宝支付：" + amount);
    }
}

// 多态使用
Payment payment1 = new CreditCardPayment("1234-5678");
Payment payment2 = new AlipayPayment("alipay@example.com");

// 统一处理
Payment[] payments = {payment1, payment2};
for (Payment payment : payments) {
    payment.pay(100.0);  // 多态：根据实际类型调用方法
}
```

## 多态的注意事项

### 1. 只能调用父类中定义的方法

```java
Animal animal = new Dog();
animal.makeSound();  // ✅ 可以调用（Animal 中有定义）
// animal.bark();    // ❌ 不能调用（Animal 中没有定义）
```

### 2. 属性没有多态

```java
public class Animal {
    public String name = "动物";
}

public class Dog extends Animal {
    public String name = "狗";
}

Animal animal = new Dog();
System.out.println(animal.name);  // "动物"（不是"狗"）
```

**原因**：属性访问在编译时确定，方法调用在运行时确定。

### 3. 静态方法没有多态

```java
public class Animal {
    public static void test() {
        System.out.println("Animal");
    }
}

public class Dog extends Animal {
    public static void test() {
        System.out.println("Dog");
    }
}

Animal animal = new Dog();
animal.test();  // "Animal"（不是"Dog"）
```

## 小结

Java 多态要点：

- **多态概念**：同一接口，不同实现
- **实现方式**：方法重写
- **应用场景**：方法参数、数组、集合、返回值
- **类型检查**：instanceof 运算符
- **优势**：代码复用、可扩展性、灵活性

**关键要点**：
- 多态通过方法重写实现
- 运行时根据实际对象类型调用方法
- 只能调用父类中定义的方法
- 属性没有多态
- 静态方法没有多态

理解了多态，你就能编写更灵活、可扩展的代码。在下一章，我们将学习方法重写与重载的区别。
