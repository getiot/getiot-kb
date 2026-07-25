---
sidebar_position: 7
slug: /java-inheritance
sidebar_label: Java 继承
---

# Java 继承（Inheritance）

继承是面向对象编程的核心特性之一，它允许子类继承父类的属性和方法，实现代码复用和建立类之间的层次关系。理解继承是掌握面向对象编程的关键。本章将详细介绍 Java 中的继承机制。

## 单继承与继承链

### 什么是继承

**继承**（Inheritance）是子类继承父类的属性和方法，实现代码复用。

**语法**：`class 子类 extends 父类`

```java
// 父类（基类、超类）
public class Animal {
    protected String name;
    protected int age;
    
    public void eat() {
        System.out.println(name + " 正在吃东西");
    }
    
    public void sleep() {
        System.out.println(name + " 正在睡觉");
    }
}

// 子类（派生类）
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

### Java 单继承

**Java 只支持单继承**，一个类只能继承一个父类。

```java
// ✅ 正确：单继承
public class Dog extends Animal { }

// ❌ 错误：不能多继承
// public class Dog extends Animal, Mammal { }
```

**为什么单继承**：
- 避免多重继承的复杂性
- 简化类层次结构
- 减少命名冲突

### 继承链

**继承可以形成链式结构**：

```java
// 第一层：动物
public class Animal {
    protected String name;
    
    public void eat() {
        System.out.println(name + " 吃东西");
    }
}

// 第二层：哺乳动物
public class Mammal extends Animal {
    public void giveBirth() {
        System.out.println(name + " 是胎生");
    }
}

// 第三层：狗
public class Dog extends Mammal {
    public void bark() {
        System.out.println(name + " 汪汪叫");
    }
}

// 继承链：Animal -> Mammal -> Dog
Dog dog = new Dog();
dog.name = "旺财";
dog.eat();        // 来自 Animal
dog.giveBirth();  // 来自 Mammal
dog.bark();       // 来自 Dog
```

### Object 类

**所有类都继承自 Object 类**（如果没有显式继承）。

```java
// 等价于：public class Student extends Object
public class Student {
    // ...
}

// Object 类的方法
Student student = new Student();
student.toString();  // 继承自 Object
student.equals(student);  // 继承自 Object
student.hashCode();  // 继承自 Object
```

## super 关键字

### super 的作用

**`super`** 用于引用父类的成员（属性、方法、构造方法）。

### 访问父类属性

```java
public class Animal {
    protected String name = "动物";
}

public class Dog extends Animal {
    private String name = "狗";
    
    public void display() {
        System.out.println(super.name);  // 父类的 name："动物"
        System.out.println(this.name);    // 子类的 name："狗"
    }
}
```

### 调用父类方法

```java
public class Animal {
    public void eat() {
        System.out.println("动物吃东西");
    }
}

public class Dog extends Animal {
    @Override
    public void eat() {
        super.eat();  // 调用父类方法
        System.out.println("狗吃骨头");
    }
}

// 使用
Dog dog = new Dog();
dog.eat();
// 输出：
// 动物吃东西
// 狗吃骨头
```

### 调用父类构造方法

**子类构造方法必须调用父类构造方法**。

```java
public class Animal {
    protected String name;
    protected int age;
    
    public Animal(String name, int age) {
        this.name = name;
        this.age = age;
    }
}

public class Dog extends Animal {
    private String breed;
    
    public Dog(String name, int age, String breed) {
        super(name, age);  // 必须调用父类构造方法
        this.breed = breed;
    }
}
```

**规则**：
- `super()` 必须是子类构造方法的第一条语句
- 如果没有显式调用，编译器会自动调用父类的无参构造方法
- 如果父类没有无参构造方法，必须显式调用有参构造方法

```java
public class Animal {
    private String name;
    
    // 只有有参构造方法
    public Animal(String name) {
        this.name = name;
    }
}

public class Dog extends Animal {
    public Dog(String name) {
        super(name);  // 必须显式调用
    }
    
    // ❌ 错误：如果没有 super(name)，会尝试调用 super()，但父类没有无参构造
}
```

## 方法重写（Override）

### 什么是方法重写

**方法重写**（Override）是子类重新定义父类的方法，提供自己的实现。

```java
public class Animal {
    public void makeSound() {
        System.out.println("动物发出声音");
    }
}

public class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("汪汪汪");
    }
}

// 使用
Animal animal = new Dog();
animal.makeSound();  // 汪汪汪（调用子类重写的方法）
```

### 重写的规则

1. **方法签名相同**：方法名、参数列表必须相同
2. **返回类型兼容**：返回类型相同或是子类
3. **访问修饰符不能更严格**：可以更宽松，不能更严格
4. **不能重写 private 方法**：private 方法不能被重写
5. **不能重写 final 方法**：final 方法不能被重写
6. **不能重写 static 方法**：static 方法不能被重写（可以隐藏）

```java
public class Animal {
    public void method1() { }
    protected void method2() { }
    private void method3() { }
    public final void method4() { }
    public static void method5() { }
}

public class Dog extends Animal {
    @Override
    public void method1() { }  // ✅ 可以重写
    
    @Override
    public void method2() { }  // ✅ 可以重写（访问修饰符更宽松）
    
    // @Override
    // private void method3() { }  // ❌ 不能重写 private 方法
    
    // @Override
    // public void method4() { }  // ❌ 不能重写 final 方法
    
    // @Override
    // public static void method5() { }  // ❌ 不能重写 static 方法（可以隐藏）
}
```

### @Override 注解

**`@Override` 注解**用于标识重写的方法，编译器会检查是否正确重写。

```java
public class Animal {
    public void eat() { }
}

public class Dog extends Animal {
    @Override
    public void eat() { }  // ✅ 正确重写
    
    // @Override
    // public void eat(String food) { }  // ❌ 编译错误：不是重写，是重载
}
```

**好处**：
- 编译器检查重写是否正确
- 代码更清晰
- 如果父类方法签名改变，会提示错误

### 重写 vs 重载

| 特性 | 重写（Override） | 重载（Overload） |
|:----:|:---------------:|:---------------:|
| 方法名 | 相同 | 相同 |
| 参数列表 | 相同 | 不同 |
| 返回类型 | 相同或子类 | 可以不同 |
| 访问修饰符 | 不能更严格 | 可以不同 |
| 发生位置 | 继承关系中 | 同一类中 |

```java
public class Animal {
    public void eat() { }
    public void eat(String food) { }  // 重载
}

public class Dog extends Animal {
    @Override
    public void eat() { }  // 重写父类的 eat()
    
    // 这是重载，不是重写
    public void eat(String food, int amount) { }
}
```

## 继承的访问控制

### 继承中的访问修饰符

```java
public class Animal {
    public String publicField;
    protected String protectedField;
    String defaultField;
    private String privateField;
    
    public void publicMethod() { }
    protected void protectedMethod() { }
    void defaultMethod() { }
    private void privateMethod() { }
}

public class Dog extends Animal {
    public void test() {
        publicField = "public";      // ✅ 可以访问
        protectedField = "protected"; // ✅ 可以访问（子类）
        defaultField = "default";     // ✅ 可以访问（同一包）
        // privateField = "private"; // ❌ 不能访问
        
        publicMethod();      // ✅ 可以访问
        protectedMethod();   // ✅ 可以访问（子类）
        defaultMethod();     // ✅ 可以访问（同一包）
        // privateMethod();  // ❌ 不能访问
    }
}
```

## 实际示例

### 示例 1：完整的继承示例

```java
// 父类：动物
public class Animal {
    protected String name;
    protected int age;
    
    public Animal(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    public void eat() {
        System.out.println(name + " 正在吃东西");
    }
    
    public void sleep() {
        System.out.println(name + " 正在睡觉");
    }
    
    public void makeSound() {
        System.out.println(name + " 发出声音");
    }
    
    public void displayInfo() {
        System.out.println("姓名：" + name);
        System.out.println("年龄：" + age);
    }
}

// 子类：狗
public class Dog extends Animal {
    private String breed;
    
    public Dog(String name, int age, String breed) {
        super(name, age);  // 调用父类构造方法
        this.breed = breed;
    }
    
    @Override
    public void makeSound() {
        System.out.println(name + " 汪汪叫");
    }
    
    public void bark() {
        System.out.println(name + " 在叫");
    }
    
    @Override
    public void displayInfo() {
        super.displayInfo();  // 调用父类方法
        System.out.println("品种：" + breed);
    }
}

// 使用
Dog dog = new Dog("旺财", 3, "金毛");
dog.eat();        // 继承自父类
dog.makeSound();  // 重写的方法
dog.bark();       // 子类特有方法
dog.displayInfo();  // 重写的方法
```

### 示例 2：继承链

```java
// 第一层：交通工具
public class Vehicle {
    protected String brand;
    protected int speed;
    
    public Vehicle(String brand) {
        this.brand = brand;
        this.speed = 0;
    }
    
    public void start() {
        System.out.println(brand + " 启动");
    }
    
    public void stop() {
        speed = 0;
        System.out.println(brand + " 停止");
    }
}

// 第二层：汽车
public class Car extends Vehicle {
    private int doors;
    
    public Car(String brand, int doors) {
        super(brand);
        this.doors = doors;
    }
    
    public void drive() {
        speed = 60;
        System.out.println(brand + " 汽车行驶，速度：" + speed);
    }
}

// 第三层：跑车
public class SportsCar extends Car {
    private int maxSpeed;
    
    public SportsCar(String brand, int doors, int maxSpeed) {
        super(brand, doors);
        this.maxSpeed = maxSpeed;
    }
    
    @Override
    public void drive() {
        speed = 120;
        System.out.println(brand + " 跑车高速行驶，速度：" + speed);
    }
    
    public void race() {
        System.out.println(brand + " 参加比赛");
    }
}

// 使用
SportsCar car = new SportsCar("保时捷", 2, 300);
car.start();   // 来自 Vehicle
car.drive();   // 重写的方法
car.race();    // 子类特有方法
car.stop();    // 来自 Vehicle
```

### 示例 3：方法重写

```java
public class Shape {
    protected String name;
    
    public Shape(String name) {
        this.name = name;
    }
    
    public double getArea() {
        return 0;  // 默认实现
    }
    
    public void display() {
        System.out.println("形状：" + name);
        System.out.println("面积：" + getArea());
    }
}

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

// 使用
Shape circle = new Circle(5);
circle.display();  // 调用重写的 getArea()

Shape rectangle = new Rectangle(4, 6);
rectangle.display();  // 调用重写的 getArea()
```

## 继承的优缺点

### 优点

1. **代码复用**：子类自动拥有父类功能
2. **层次结构**：建立清晰的类层次
3. **多态基础**：为多态提供支持
4. **易于维护**：修改父类影响所有子类

### 缺点

1. **紧耦合**：子类依赖父类
2. **单继承限制**：不能多继承
3. **可能过度使用**：不是所有关系都适合继承

## 小结

Java 继承要点：

- **单继承**：一个类只能继承一个父类
- **继承链**：可以形成多级继承
- **super 关键字**：访问父类成员
- **方法重写**：子类重新定义父类方法
- **Object 类**：所有类的根类

**关键要点**：
- 使用 extends 关键字继承
- 子类构造方法必须调用父类构造方法
- 使用 @Override 注解标识重写
- super 访问父类成员
- 理解继承的访问控制

理解了继承，你就能建立类之间的层次关系。在下一章，我们将学习 Java 的多态。
