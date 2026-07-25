---
sidebar_position: 11
slug: /java-abstraction
sidebar_label: Java 抽象类
---

# Java 抽象类（abstract）

抽象类是不能被实例化的类，用于定义子类的通用结构和行为。理解抽象类的使用是掌握面向对象设计的关键。本章将详细介绍 Java 中的抽象类。

## 抽象类的概念

### 什么是抽象类

**抽象类**（Abstract Class）是用 `abstract` 关键字修饰的类，不能直接实例化，只能被继承。

```java
// 抽象类
public abstract class Animal {
    protected String name;
    
    // 抽象方法
    public abstract void makeSound();
    
    // 普通方法
    public void eat() {
        System.out.println(name + " 正在吃东西");
    }
}

// 子类必须实现抽象方法
public class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("汪汪汪");
    }
}

// ❌ 错误：不能实例化抽象类
// Animal animal = new Animal();

// ✅ 正确：实例化子类
Animal animal = new Dog();
```

### 为什么需要抽象类

**抽象类用于**：

1. **定义通用结构**：为子类提供共同的属性和方法
2. **强制实现**：要求子类实现特定的方法
3. **代码复用**：提供通用的实现，子类可以复用
4. **多态支持**：作为多态的基础

## 抽象方法

### 什么是抽象方法

**抽象方法**（Abstract Method）是用 `abstract` 关键字修饰的方法，只有声明，没有实现。

```java
public abstract class Animal {
    // 抽象方法：只有声明，没有实现
    public abstract void makeSound();
    
    // 普通方法：有实现
    public void eat() {
        System.out.println("吃东西");
    }
}
```

### 抽象方法的规则

1. **只有声明，没有实现**：方法体为空
2. **必须在抽象类中**：只有抽象类可以有抽象方法
3. **子类必须实现**：非抽象子类必须实现所有抽象方法
4. **不能是 private**：抽象方法不能是 private
5. **不能是 static**：抽象方法不能是 static
6. **不能是 final**：抽象方法不能是 final

```java
public abstract class Animal {
    // ✅ 正确
    public abstract void makeSound();
    protected abstract void sleep();
    
    // ❌ 错误
    // private abstract void method1();  // 不能是 private
    // static abstract void method2();   // 不能是 static
    // final abstract void method3();    // 不能是 final
}
```

## 抽象类的使用

### 基本使用

```java
// 抽象类
public abstract class Shape {
    protected String name;
    
    public Shape(String name) {
        this.name = name;
    }
    
    // 抽象方法：计算面积
    public abstract double getArea();
    
    // 抽象方法：计算周长
    public abstract double getPerimeter();
    
    // 普通方法：显示信息
    public void display() {
        System.out.println("形状：" + name);
        System.out.println("面积：" + getArea());
        System.out.println("周长：" + getPerimeter());
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
    
    @Override
    public double getPerimeter() {
        return 2 * Math.PI * radius;
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
    
    @Override
    public double getPerimeter() {
        return 2 * (width + height);
    }
}

// 使用
Shape circle = new Circle(5);
circle.display();

Shape rectangle = new Rectangle(4, 6);
rectangle.display();
```

### 抽象类可以有构造方法

```java
public abstract class Animal {
    protected String name;
    protected int age;
    
    // 抽象类可以有构造方法
    public Animal(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    public abstract void makeSound();
}

public class Dog extends Animal {
    public Dog(String name, int age) {
        super(name, age);  // 调用父类构造方法
    }
    
    @Override
    public void makeSound() {
        System.out.println("汪汪汪");
    }
}
```

### 抽象类可以有普通方法

```java
public abstract class Animal {
    protected String name;
    
    // 抽象方法
    public abstract void makeSound();
    
    // 普通方法：子类可以直接使用
    public void eat() {
        System.out.println(name + " 正在吃东西");
    }
    
    // 普通方法：子类可以重写
    public void sleep() {
        System.out.println(name + " 正在睡觉");
    }
}

public class Dog extends Animal {
    public Dog(String name) {
        this.name = name;
    }
    
    @Override
    public void makeSound() {
        System.out.println("汪汪汪");
    }
    
    // 可以重写普通方法
    @Override
    public void sleep() {
        System.out.println(name + " 在狗窝里睡觉");
    }
}
```

## 抽象类 vs 普通类

### 对比表

| 特性 | 抽象类 | 普通类 |
|:----:|:------:|:------:|
| 实例化 | 不能 | 可以 |
| 抽象方法 | 可以有 | 不能有 |
| 普通方法 | 可以有 | 可以有 |
| 构造方法 | 可以有 | 可以有 |
| 继承 | 必须被继承 | 可以被继承 |

### 使用场景

**使用抽象类**：
- 需要定义通用结构
- 需要强制子类实现某些方法
- 需要提供部分实现

**使用普通类**：
- 可以直接实例化
- 不需要强制子类实现方法
- 提供完整实现

## 实际示例

### 示例 1：员工管理系统

```java
// 抽象类：员工
public abstract class Employee {
    protected String name;
    protected double baseSalary;
    
    public Employee(String name, double baseSalary) {
        this.name = name;
        this.baseSalary = baseSalary;
    }
    
    // 抽象方法：计算薪资（不同员工计算方式不同）
    public abstract double calculateSalary();
    
    // 普通方法：显示信息
    public void displayInfo() {
        System.out.println("姓名：" + name);
        System.out.println("基本薪资：" + baseSalary);
        System.out.println("总薪资：" + calculateSalary());
    }
}

// 子类：全职员工
public class FullTimeEmployee extends Employee {
    private double bonus;
    
    public FullTimeEmployee(String name, double baseSalary, double bonus) {
        super(name, baseSalary);
        this.bonus = bonus;
    }
    
    @Override
    public double calculateSalary() {
        return baseSalary + bonus;
    }
}

// 子类：兼职员工
public class PartTimeEmployee extends Employee {
    private int hours;
    private double hourlyRate;
    
    public PartTimeEmployee(String name, double baseSalary, int hours, double hourlyRate) {
        super(name, baseSalary);
        this.hours = hours;
        this.hourlyRate = hourlyRate;
    }
    
    @Override
    public double calculateSalary() {
        return baseSalary + hours * hourlyRate;
    }
}

// 使用
Employee[] employees = {
    new FullTimeEmployee("张三", 8000, 2000),
    new PartTimeEmployee("李四", 0, 20, 50)
};

for (Employee employee : employees) {
    employee.displayInfo();  // 多态
}
```

### 示例 2：数据库操作

```java
// 抽象类：数据库操作
public abstract class Database {
    protected String connectionString;
    
    public Database(String connectionString) {
        this.connectionString = connectionString;
    }
    
    // 抽象方法：连接数据库
    public abstract void connect();
    
    // 抽象方法：断开连接
    public abstract void disconnect();
    
    // 抽象方法：执行查询
    public abstract ResultSet executeQuery(String sql);
    
    // 普通方法：通用操作
    public void log(String message) {
        System.out.println("[" + getClass().getSimpleName() + "] " + message);
    }
}

// 子类：MySQL 数据库
public class MySQLDatabase extends Database {
    public MySQLDatabase(String connectionString) {
        super(connectionString);
    }
    
    @Override
    public void connect() {
        log("连接到 MySQL 数据库");
    }
    
    @Override
    public void disconnect() {
        log("断开 MySQL 数据库连接");
    }
    
    @Override
    public ResultSet executeQuery(String sql) {
        log("执行 MySQL 查询：" + sql);
        return null;  // 简化示例
    }
}

// 子类：PostgreSQL 数据库
public class PostgreSQLDatabase extends Database {
    public PostgreSQLDatabase(String connectionString) {
        super(connectionString);
    }
    
    @Override
    public void connect() {
        log("连接到 PostgreSQL 数据库");
    }
    
    @Override
    public void disconnect() {
        log("断开 PostgreSQL 数据库连接");
    }
    
    @Override
    public ResultSet executeQuery(String sql) {
        log("执行 PostgreSQL 查询：" + sql);
        return null;  // 简化示例
    }
}
```

## 抽象类 vs 接口

### 主要区别

| 特性 | 抽象类 | 接口 |
|:----:|:------:|:----:|
| 方法实现 | 可以有 | Java 8+ 可以有默认方法 |
| 变量 | 可以有实例变量 | 只能是常量 |
| 继承 | 单继承 | 多实现 |
| 构造方法 | 可以有 | 不能有 |
| 访问修饰符 | 任意 | 默认 public |

### 选择建议

**使用抽象类**：
- 需要提供部分实现
- 需要实例变量
- 需要构造方法
- 单继承关系

**使用接口**：
- 只需要定义契约
- 需要多实现
- 不需要实例变量
- 定义行为规范

## 小结

Java 抽象类要点：

- **抽象类定义**：用 abstract 修饰，不能实例化
- **抽象方法**：只有声明，没有实现，子类必须实现
- **使用场景**：定义通用结构，强制实现，代码复用
- **与普通类区别**：可以有抽象方法，不能实例化
- **与接口区别**：可以有实现，单继承

**关键要点**：
- 抽象类用 abstract 修饰
- 抽象方法只有声明，没有实现
- 子类必须实现所有抽象方法
- 抽象类可以有普通方法和构造方法
- 不能实例化抽象类

理解了抽象类，你就能设计更好的类层次结构。在下一章，我们将学习 Java 的接口。
