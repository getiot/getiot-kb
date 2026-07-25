---
sidebar_position: 12
slug: /java-interfaces
sidebar_label: Java 接口
---

# Java 接口（interface）

接口是 Java 中定义契约的机制，用于规范类的行为。理解接口的使用是掌握面向对象设计和多态的关键。本章将详细介绍 Java 中的接口。

## 接口的概念

### 什么是接口

**接口**（Interface）是用 `interface` 关键字定义的，用于定义类必须实现的方法。

```java
// 接口定义
public interface Animal {
    void makeSound();  // 接口方法（默认 public abstract）
    void eat();
}

// 实现接口
public class Dog implements Animal {
    @Override
    public void makeSound() {
        System.out.println("汪汪汪");
    }
    
    @Override
    public void eat() {
        System.out.println("狗吃骨头");
    }
}

// 使用
Animal animal = new Dog();
animal.makeSound();
```

### 接口的特点

1. **不能实例化**：接口不能直接创建对象
2. **方法默认 public abstract**：接口方法默认是公共抽象的
3. **变量默认 public static final**：接口变量默认是公共静态常量
4. **可以多实现**：一个类可以实现多个接口
5. **可以多继承**：接口可以继承多个接口

## 接口的定义

### 基本语法

```java
public interface InterfaceName {
    // 常量
    // 方法声明
    // 默认方法（Java 8+）
    // 静态方法（Java 8+）
    // 私有方法（Java 9+）
}
```

### 接口方法

**接口方法默认是 public abstract**：

```java
public interface Animal {
    // 以下两种写法等价
    void makeSound();  // 默认 public abstract
    public abstract void eat();  // 显式声明
}
```

### 接口常量

**接口变量默认是 public static final**：

```java
public interface Constants {
    // 以下两种写法等价
    int MAX_SIZE = 100;  // 默认 public static final
    public static final int MIN_SIZE = 10;  // 显式声明
}
```

## 接口的实现

### implements 关键字

**使用 `implements` 关键字实现接口**：

```java
public interface Animal {
    void makeSound();
    void eat();
}

public class Dog implements Animal {
    @Override
    public void makeSound() {
        System.out.println("汪汪汪");
    }
    
    @Override
    public void eat() {
        System.out.println("狗吃骨头");
    }
}
```

### 实现多个接口

**一个类可以实现多个接口**：

```java
public interface Flyable {
    void fly();
}

public interface Swimmable {
    void swim();
}

public class Duck implements Flyable, Swimmable {
    @Override
    public void fly() {
        System.out.println("鸭子飞");
    }
    
    @Override
    public void swim() {
        System.out.println("鸭子游泳");
    }
}
```

### 必须实现所有方法

**实现接口的类必须实现接口中的所有方法**：

```java
public interface Animal {
    void makeSound();
    void eat();
}

// ❌ 错误：没有实现所有方法
// public class Dog implements Animal {
//     public void makeSound() { }
//     // 缺少 eat() 方法
// }

// ✅ 正确：实现所有方法
public class Dog implements Animal {
    @Override
    public void makeSound() {
        System.out.println("汪汪汪");
    }
    
    @Override
    public void eat() {
        System.out.println("狗吃骨头");
    }
}
```

## 接口的继承

### 接口继承接口

**接口可以继承多个接口**：

```java
public interface Animal {
    void makeSound();
}

public interface Flyable {
    void fly();
}

// 接口继承多个接口
public interface Bird extends Animal, Flyable {
    void layEggs();
}

// 实现接口
public class Sparrow implements Bird {
    @Override
    public void makeSound() {
        System.out.println("啾啾啾");
    }
    
    @Override
    public void fly() {
        System.out.println("麻雀飞");
    }
    
    @Override
    public void layEggs() {
        System.out.println("麻雀下蛋");
    }
}
```

## Java 8+ 接口新特性

### 默认方法（Default Methods）

**Java 8 引入默认方法，接口可以提供默认实现**：

```java
public interface Animal {
    void makeSound();
    
    // 默认方法
    default void eat() {
        System.out.println("动物吃东西");
    }
    
    default void sleep() {
        System.out.println("动物睡觉");
    }
}

// 实现类可以选择实现或不实现默认方法
public class Dog implements Animal {
    @Override
    public void makeSound() {
        System.out.println("汪汪汪");
    }
    
    // 可以选择重写默认方法
    @Override
    public void eat() {
        System.out.println("狗吃骨头");
    }
    
    // 可以不实现 sleep()，使用默认实现
}
```

**默认方法的作用**：
- 向后兼容：可以在接口中添加新方法而不破坏现有实现
- 提供通用实现：多个实现类可以共享默认实现

### 静态方法（Static Methods）

**Java 8 引入静态方法，接口可以有静态方法**：

```java
public interface MathUtils {
    // 静态方法
    static int add(int a, int b) {
        return a + b;
    }
    
    static double multiply(double a, double b) {
        return a * b;
    }
}

// 使用：通过接口名调用
int sum = MathUtils.add(1, 2);
double product = MathUtils.multiply(3.0, 4.0);
```

### 私有方法（Private Methods）

**Java 9 引入私有方法，接口可以有私有方法**：

```java
public interface Animal {
    default void method1() {
        commonCode();  // 调用私有方法
    }
    
    default void method2() {
        commonCode();  // 调用私有方法
    }
    
    // 私有方法：供默认方法使用
    private void commonCode() {
        System.out.println("公共代码");
    }
}
```

## 接口 vs 抽象类

### 对比表

| 特性 | 接口 | 抽象类 |
|:----:|:----:|:------:|
| 方法实现 | Java 8+ 可以有默认方法 | 可以有 |
| 变量 | 只能是常量 | 可以有实例变量 |
| 继承 | 多继承接口 | 单继承类 |
| 构造方法 | 不能有 | 可以有 |
| 访问修饰符 | 默认 public | 任意 |
| 实例化 | 不能 | 不能 |

### 使用场景

**使用接口**：
- 定义行为契约
- 需要多实现
- 不需要实例变量
- 定义功能规范

**使用抽象类**：
- 需要提供部分实现
- 需要实例变量
- 需要构造方法
- 单继承关系

## 实际示例

### 示例 1：支付系统

```java
// 接口：支付方式
public interface Payment {
    void pay(double amount);
    void refund(double amount);
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
    
    @Override
    public void refund(double amount) {
        System.out.println("信用卡退款：" + amount);
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
    
    @Override
    public void refund(double amount) {
        System.out.println("支付宝退款：" + amount);
    }
}

// 使用多态
Payment[] payments = {
    new CreditCardPayment("1234-5678"),
    new AlipayPayment("alipay@example.com")
};

for (Payment payment : payments) {
    payment.pay(100.0);
}
```

### 示例 2：多个接口

```java
// 接口 1：可飞行
public interface Flyable {
    void fly();
}

// 接口 2：可游泳
public interface Swimmable {
    void swim();
}

// 接口 3：可奔跑
public interface Runnable {
    void run();
}

// 实现多个接口
public class Duck implements Flyable, Swimmable, Runnable {
    @Override
    public void fly() {
        System.out.println("鸭子飞");
    }
    
    @Override
    public void swim() {
        System.out.println("鸭子游泳");
    }
    
    @Override
    public void run() {
        System.out.println("鸭子跑");
    }
}

// 使用
Duck duck = new Duck();
duck.fly();
duck.swim();
duck.run();
```

### 示例 3：接口继承

```java
// 基础接口
public interface Animal {
    void makeSound();
    void eat();
}

// 扩展接口
public interface Flyable {
    void fly();
}

// 接口继承
public interface Bird extends Animal, Flyable {
    void layEggs();
}

// 实现接口
public class Sparrow implements Bird {
    @Override
    public void makeSound() {
        System.out.println("啾啾啾");
    }
    
    @Override
    public void eat() {
        System.out.println("麻雀吃虫子");
    }
    
    @Override
    public void fly() {
        System.out.println("麻雀飞");
    }
    
    @Override
    public void layEggs() {
        System.out.println("麻雀下蛋");
    }
}
```

## 接口的最佳实践

### 1. 接口命名

```java
// ✅ 推荐：使用形容词或名词
public interface Runnable { }
public interface Comparable { }
public interface Serializable { }

// ❌ 不推荐：使用动词
// public interface Run { }
```

### 2. 接口职责单一

```java
// ✅ 推荐：职责单一
public interface Flyable {
    void fly();
}

public interface Swimmable {
    void swim();
}

// ❌ 不推荐：职责过多
// public interface Animal {
//     void fly();
//     void swim();
//     void run();
// }
```

### 3. 使用默认方法提供通用实现

```java
public interface List {
    void add(Object item);
    
    // 默认方法：提供通用实现
    default void addAll(List other) {
        for (Object item : other) {
            add(item);
        }
    }
}
```

## 小结

Java 接口要点：

- **接口定义**：用 interface 关键字，定义行为契约
- **接口实现**：使用 implements 关键字，必须实现所有方法
- **多实现**：一个类可以实现多个接口
- **接口继承**：接口可以继承多个接口
- **新特性**：默认方法、静态方法、私有方法

**关键要点**：
- 接口方法默认 public abstract
- 接口变量默认 public static final
- 实现类必须实现所有方法
- 接口支持多继承
- Java 8+ 支持默认方法和静态方法

理解了接口，你就能设计更好的程序结构。在下一章，我们将学习 Java 的内部类。
