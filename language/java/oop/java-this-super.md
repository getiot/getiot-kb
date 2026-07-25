---
sidebar_position: 10
slug: /java-this-super
sidebar_label: Java this 与 super
---

# Java this 与 super 关键字

`this` 和 `super` 是 Java 中两个重要的关键字，用于引用当前对象和父类对象。理解它们的使用是掌握面向对象编程的关键。本章将详细介绍 `this` 和 `super` 的用法。

## this 关键字

### this 的作用

**`this`** 表示当前对象的引用，用于：
1. 区分参数和成员变量
2. 调用其他构造方法
3. 返回当前对象
4. 传递当前对象

### 区分参数和成员变量

**最常见用法**：当参数名和成员变量名相同时，使用 `this` 区分。

```java
public class Student {
    private String name;
    private int age;
    
    public Student(String name, int age) {
        this.name = name;  // this.name 是成员变量，name 是参数
        this.age = age;    // this.age 是成员变量，age 是参数
    }
    
    public void setName(String name) {
        this.name = name;  // 区分参数和成员变量
    }
}
```

**不使用 this 的情况**：

```java
public class Student {
    private String name;
    
    public void setName(String studentName) {
        name = studentName;  // 参数名不同，不需要 this
    }
}
```

### 调用其他构造方法

**使用 `this()` 调用同一类的其他构造方法**：

```java
public class Student {
    private String name;
    private int age;
    private String studentId;
    
    // 无参构造
    public Student() {
        this("未知", 0, "N/A");  // 调用三参构造
    }
    
    // 两参构造
    public Student(String name, int age) {
        this(name, age, "N/A");  // 调用三参构造
    }
    
    // 三参构造（主构造方法）
    public Student(String name, int age, String studentId) {
        this.name = name;
        this.age = age;
        this.studentId = studentId;
    }
}
```

**规则**：
- `this()` 必须是构造方法的第一条语句
- 不能形成循环调用
- 不能和 `super()` 同时使用

### 返回当前对象

**方法返回 `this`，实现链式调用**：

```java
public class Student {
    private String name;
    private int age;
    
    public Student setName(String name) {
        this.name = name;
        return this;  // 返回当前对象
    }
    
    public Student setAge(int age) {
        this.age = age;
        return this;  // 返回当前对象
    }
}

// 链式调用
Student student = new Student()
    .setName("张三")
    .setAge(20);
```

### 传递当前对象

**将当前对象作为参数传递**：

```java
public class Student {
    private String name;
    
    public void register(Course course) {
        course.addStudent(this);  // 传递当前对象
    }
}
```

## super 关键字

### super 的作用

**`super`** 表示父类对象的引用，用于：
1. 访问父类的属性
2. 调用父类的方法
3. 调用父类的构造方法

### 访问父类属性

**当子类和父类有同名属性时，使用 `super` 访问父类属性**：

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

**使用 `super` 调用父类的方法**：

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

**应用场景**：
- 在重写方法中调用父类实现
- 扩展父类功能而不是完全替换

### 调用父类构造方法

**使用 `super()` 调用父类构造方法**：

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
        super(name, age);  // 调用父类构造方法
        this.breed = breed;
    }
}
```

**规则**：
- `super()` 必须是子类构造方法的第一条语句
- 如果没有显式调用，编译器会自动调用父类的无参构造方法
- 如果父类没有无参构造方法，必须显式调用有参构造方法
- 不能和 `this()` 同时使用

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

## this 和 super 的对比

### 对比表

| 特性 | this | super |
|:----:|:----:|:----:|
| 引用对象 | 当前对象 | 父类对象 |
| 调用构造方法 | this() | super() |
| 访问成员 | this.成员 | super.成员 |
| 使用位置 | 任何方法 | 子类中 |
| 调用限制 | 构造方法第一条语句 | 构造方法第一条语句 |

### 使用场景

```java
public class Animal {
    protected String name;
    
    public Animal(String name) {
        this.name = name;  // this：当前对象（Animal）
    }
    
    public void display() {
        System.out.println("动物：" + name);
    }
}

public class Dog extends Animal {
    private String name;
    
    public Dog(String animalName, String dogName) {
        super(animalName);  // super：调用父类构造方法
        this.name = dogName;  // this：当前对象（Dog）
    }
    
    @Override
    public void display() {
        super.display();  // super：调用父类方法
        System.out.println("狗：" + this.name);  // this：当前对象的属性
    }
}
```

## 实际示例

### 示例 1：this 的完整使用

```java
public class Student {
    private String name;
    private int age;
    private String studentId;
    
    // 构造方法中使用 this
    public Student() {
        this("未知", 0, "N/A");  // 调用其他构造方法
    }
    
    public Student(String name, int age, String studentId) {
        this.name = name;        // 区分参数和成员变量
        this.age = age;
        this.studentId = studentId;
    }
    
    // 链式调用
    public Student setName(String name) {
        this.name = name;
        return this;  // 返回当前对象
    }
    
    public Student setAge(int age) {
        this.age = age;
        return this;
    }
    
    // 传递当前对象
    public void register(Course course) {
        course.addStudent(this);  // 传递当前对象
    }
    
    public void display() {
        System.out.println("姓名：" + this.name);
        System.out.println("年龄：" + this.age);
    }
}

// 使用
Student student = new Student()
    .setName("张三")
    .setAge(20);
```

### 示例 2：super 的完整使用

```java
// 父类
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
        System.out.println("基本薪资：" + baseSalary);
    }
}

// 子类
public class Manager extends Employee {
    private double bonus;
    
    public Manager(String name, double baseSalary, double bonus) {
        super(name, baseSalary);  // 调用父类构造方法
        this.bonus = bonus;
    }
    
    @Override
    public double calculateSalary() {
        return super.calculateSalary() + bonus;  // 调用父类方法
    }
    
    @Override
    public void displayInfo() {
        super.displayInfo();  // 调用父类方法
        System.out.println("奖金：" + bonus);
        System.out.println("总薪资：" + calculateSalary());
    }
}

// 使用
Manager manager = new Manager("张三", 8000, 2000);
manager.displayInfo();
```

### 示例 3：this 和 super 结合使用

```java
public class Animal {
    protected String name;
    protected int age;
    
    public Animal(String name, int age) {
        this.name = name;  // this：当前对象
        this.age = age;
    }
    
    public void eat() {
        System.out.println(name + " 正在吃东西");
    }
}

public class Dog extends Animal {
    private String name;  // 与父类同名属性
    private String breed;
    
    public Dog(String animalName, String dogName, int age, String breed) {
        super(animalName, age);  // super：调用父类构造方法
        this.name = dogName;     // this：当前对象的属性
        this.breed = breed;
    }
    
    @Override
    public void eat() {
        super.eat();  // super：调用父类方法
        System.out.println(name + " 吃骨头");
    }
    
    public void display() {
        System.out.println("父类 name：" + super.name);  // super：父类属性
        System.out.println("子类 name：" + this.name);   // this：子类属性
        System.out.println("品种：" + this.breed);
    }
}

// 使用
Dog dog = new Dog("动物", "旺财", 3, "金毛");
dog.display();
dog.eat();
```

## 注意事项

### 1. this 和 super 不能同时使用

```java
public class Dog extends Animal {
    public Dog() {
        // ❌ 错误：不能同时使用
        // this("默认");
        // super("默认");
        
        // ✅ 正确：只能使用一个
        super("默认");
    }
}
```

### 2. 必须在第一条语句

```java
public class Dog extends Animal {
    public Dog() {
        // ❌ 错误：必须在第一条语句
        // System.out.println("创建狗");
        // super("默认");
        
        // ✅ 正确：super 在第一条
        super("默认");
        System.out.println("创建狗");
    }
}
```

### 3. 静态方法中不能使用

```java
public class Example {
    private String name;
    
    public static void test() {
        // ❌ 错误：静态方法中不能使用 this
        // this.name = "test";
        
        // ❌ 错误：静态方法中不能使用 super
        // super.method();
    }
}
```

## 小结

Java this 与 super 要点：

- **this**：引用当前对象，区分参数和成员变量，调用其他构造方法
- **super**：引用父类对象，访问父类成员，调用父类构造方法
- **使用规则**：必须在构造方法第一条语句，不能同时使用
- **应用场景**：this 用于当前对象操作，super 用于父类操作

**关键要点**：
- this 区分参数和成员变量
- this() 调用其他构造方法
- super 访问父类成员
- super() 调用父类构造方法
- 必须在第一条语句，不能同时使用

理解了 this 和 super，你就能正确操作当前对象和父类对象。在下一章，我们将学习 Java 的抽象类。
