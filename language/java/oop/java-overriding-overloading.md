---
sidebar_position: 9
slug: /java-overriding-overloading
sidebar_label: Java 方法重写与重载
---

# Java 方法重写与重载

方法重写（Override）和方法重载（Overload）是 Java 中两个重要的概念，它们都涉及方法名相同但实现不同。理解它们的区别和使用场景是掌握面向对象编程的关键。本章将详细介绍方法重写与重载。

## 方法重写（Override）

### 什么是方法重写

**方法重写**（Override）是子类重新定义父类的方法，提供自己的实现。

```java
// 父类
public class Animal {
    public void makeSound() {
        System.out.println("动物发出声音");
    }
}

// 子类重写父类方法
public class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("汪汪汪");
    }
}
```

### 重写的规则

1. **方法签名相同**：方法名、参数列表必须完全相同
2. **返回类型兼容**：返回类型相同或是父类返回类型的子类
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
    // public static void method5() { }  // ❌ 不能重写 static 方法
}
```

### @Override 注解

**使用 `@Override` 注解标识重写的方法**：

```java
public class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("汪汪汪");
    }
}
```

**好处**：
- 编译器检查重写是否正确
- 代码更清晰
- 如果父类方法签名改变，会提示错误

## 方法重载（Overload）

### 什么是方法重载

**方法重载**（Overload）是同一个类中有多个同名方法，但参数列表不同。

```java
public class Calculator {
    // 重载：两个 int 参数
    public int add(int a, int b) {
        return a + b;
    }
    
    // 重载：三个 int 参数
    public int add(int a, int b, int c) {
        return a + b + c;
    }
    
    // 重载：double 参数
    public double add(double a, double b) {
        return a + b;
    }
}
```

### 重载的规则

1. **方法名相同**
2. **参数列表不同**：参数类型、个数、顺序不同
3. **返回类型可以不同**：但不能仅靠返回类型区分
4. **访问修饰符可以不同**

```java
public class Example {
    // ✅ 参数个数不同
    public void method(int a) { }
    public void method(int a, int b) { }
    
    // ✅ 参数类型不同
    public void method(int a) { }
    public void method(double a) { }
    
    // ✅ 参数顺序不同
    public void method(int a, String b) { }
    public void method(String a, int b) { }
    
    // ❌ 仅返回类型不同，不能重载
    // public int method() { }
    // public String method() { }  // 编译错误
}
```

## 重写 vs 重载对比

### 对比表

| 特性 | 重写（Override） | 重载（Overload） |
|:----:|:---------------:|:---------------:|
| 方法名 | 相同 | 相同 |
| 参数列表 | 必须相同 | 必须不同 |
| 返回类型 | 相同或子类 | 可以不同 |
| 访问修饰符 | 不能更严格 | 可以不同 |
| 发生位置 | 继承关系中 | 同一类中 |
| 调用时机 | 运行时决定 | 编译时决定 |
| 目的 | 提供不同实现 | 提供不同参数 |

### 代码示例

```java
// 父类
public class Animal {
    public void eat() {
        System.out.println("动物吃东西");
    }
    
    public void eat(String food) {  // 重载
        System.out.println("动物吃" + food);
    }
}

// 子类
public class Dog extends Animal {
    @Override
    public void eat() {  // 重写
        System.out.println("狗吃骨头");
    }
    
    @Override
    public void eat(String food) {  // 重写
        System.out.println("狗吃" + food);
    }
    
    public void eat(String food, int amount) {  // 重载（子类新方法）
        System.out.println("狗吃" + amount + "份" + food);
    }
}
```

## 实际示例

### 示例 1：重写示例

```java
// 父类：形状
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

// 子类：圆形（重写 getArea）
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

// 子类：矩形（重写 getArea）
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

### 示例 2：重载示例

```java
public class MathUtils {
    // 重载：两个 int
    public static int add(int a, int b) {
        return a + b;
    }
    
    // 重载：三个 int
    public static int add(int a, int b, int c) {
        return a + b + c;
    }
    
    // 重载：两个 double
    public static double add(double a, double b) {
        return a + b;
    }
    
    // 重载：可变参数
    public static int add(int... numbers) {
        int sum = 0;
        for (int num : numbers) {
            sum += num;
        }
        return sum;
    }
}

// 使用
MathUtils.add(1, 2);           // 调用两个 int 的版本
MathUtils.add(1, 2, 3);        // 调用三个 int 的版本
MathUtils.add(1.0, 2.0);       // 调用两个 double 的版本
MathUtils.add(1, 2, 3, 4, 5);  // 调用可变参数的版本
```

### 示例 3：重写和重载结合

```java
// 父类
public class Animal {
    public void makeSound() {
        System.out.println("动物发出声音");
    }
    
    public void makeSound(int times) {  // 重载
        for (int i = 0; i < times; i++) {
            makeSound();
        }
    }
}

// 子类
public class Dog extends Animal {
    @Override
    public void makeSound() {  // 重写
        System.out.println("汪汪汪");
    }
    
    @Override
    public void makeSound(int times) {  // 重写（同时是重载）
        for (int i = 0; i < times; i++) {
            makeSound();  // 调用重写的方法
        }
    }
    
    public void makeSound(String message) {  // 重载（子类新方法）
        System.out.println("狗说：" + message);
    }
}

// 使用
Dog dog = new Dog();
dog.makeSound();           // 汪汪汪（重写的方法）
dog.makeSound(3);          // 汪汪汪 汪汪汪 汪汪汪（重写的方法）
dog.makeSound("你好");     // 狗说：你好（重载的方法）
```

## 常见错误

### 错误 1：误以为重写，实际是重载

```java
public class Animal {
    public void eat(String food) { }
}

public class Dog extends Animal {
    // ❌ 错误：这是重载，不是重写（参数不同）
    public void eat(int amount) { }
    
    // ✅ 正确：这是重写（参数相同）
    @Override
    public void eat(String food) { }
}
```

### 错误 2：仅返回类型不同

```java
public class Example {
    // ❌ 错误：仅返回类型不同，不能重载
    public int method() { return 1; }
    public String method() { return "1"; }  // 编译错误
}
```

### 错误 3：访问修饰符更严格

```java
public class Animal {
    public void method() { }
}

public class Dog extends Animal {
    // ❌ 错误：访问修饰符不能更严格
    // @Override
    // private void method() { }  // 编译错误
    
    // ✅ 正确：可以更宽松
    @Override
    public void method() { }
}
```

## 最佳实践

### 1. 使用 @Override 注解

```java
public class Dog extends Animal {
    @Override  // ✅ 推荐：使用注解
    public void makeSound() {
        System.out.println("汪汪汪");
    }
}
```

### 2. 重写时调用父类方法

```java
public class Dog extends Animal {
    @Override
    public void makeSound() {
        super.makeSound();  // 调用父类方法
        System.out.println("汪汪汪");
    }
}
```

### 3. 重载提供清晰的参数

```java
// ✅ 推荐：参数类型明确
public void process(int id) { }
public void process(String name) { }

// ❌ 不推荐：参数类型不明确
public void process(Object obj) { }
```

## 小结

Java 方法重写与重载要点：

- **方法重写**：子类重新定义父类方法，参数相同
- **方法重载**：同一类中同名方法，参数不同
- **区别**：发生位置、参数要求、调用时机不同
- **使用场景**：重写用于多态，重载用于不同参数

**关键要点**：
- 重写发生在继承关系中，重载发生在同一类中
- 重写参数必须相同，重载参数必须不同
- 使用 @Override 注解标识重写
- 重写是运行时决定，重载是编译时决定

理解了重写和重载，你就能正确使用多态和提供灵活的方法接口。在下一章，我们将学习 this 和 super 关键字。
