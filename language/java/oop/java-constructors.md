---
sidebar_position: 3
slug: /java-constructors
sidebar_label: Java 构造方法
---

# Java 构造方法

构造方法是创建对象时自动调用的特殊方法，用于初始化对象的状态。理解构造方法的使用、重载和链式调用，是掌握对象创建的关键。本章将详细介绍 Java 构造方法的各个方面。

## 默认构造方法

### 什么是默认构造方法

**默认构造方法**是 Java 自动提供的无参构造方法，如果没有显式定义构造方法，编译器会自动添加。

```java
public class Student {
    private String name;
    private int age;
    
    // 没有定义构造方法
    // Java 自动提供：public Student() { }
}

// 可以使用默认构造方法
Student student = new Student();
```

### 默认构造方法的特点

1. **无参数**：不接受任何参数
2. **无方法体**：方法体为空
3. **公共访问**：如果类是 public，构造方法也是 public
4. **自动提供**：只有在没有定义任何构造方法时才提供

### 失去默认构造方法

**一旦定义了构造方法，默认构造方法就不再自动提供**：

```java
public class Student {
    private String name;
    
    // 定义了有参构造方法
    public Student(String name) {
        this.name = name;
    }
    
    // 此时没有默认构造方法
    // Student student = new Student();  // ❌ 编译错误
}

// 如果需要无参构造，需要显式定义
public class Student {
    private String name;
    
    // 有参构造
    public Student(String name) {
        this.name = name;
    }
    
    // 显式定义无参构造
    public Student() {
        this.name = "未知";
    }
}
```

## 带参构造方法

### 定义带参构造方法

**带参构造方法**可以接收参数来初始化对象。

```java
public class Student {
    private String name;
    private int age;
    private String studentId;
    
    // 带参构造方法
    public Student(String name, int age, String studentId) {
        this.name = name;
        this.age = age;
        this.studentId = studentId;
    }
}

// 使用
Student student = new Student("张三", 20, "S001");
```

### 构造方法的参数验证

```java
public class Student {
    private String name;
    private int age;
    
    public Student(String name, int age) {
        // 参数验证
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("姓名不能为空");
        }
        if (age < 0 || age > 150) {
            throw new IllegalArgumentException("年龄必须在 0-150 之间");
        }
        
        this.name = name;
        this.age = age;
    }
}
```

## 构造方法重载与链式调用

### 构造方法重载

**构造方法重载**：同一个类可以有多个构造方法，参数列表不同。

```java
public class Student {
    private String name;
    private int age;
    private String studentId;
    private String email;
    
    // 构造方法 1：无参
    public Student() {
        this("未知", 0, "N/A", "N/A");
    }
    
    // 构造方法 2：两个参数
    public Student(String name, int age) {
        this(name, age, "N/A", "N/A");
    }
    
    // 构造方法 3：三个参数
    public Student(String name, int age, String studentId) {
        this(name, age, studentId, "N/A");
    }
    
    // 构造方法 4：四个参数（主构造方法）
    public Student(String name, int age, String studentId, String email) {
        this.name = name;
        this.age = age;
        this.studentId = studentId;
        this.email = email;
    }
}

// 使用
Student s1 = new Student();                                    // 构造方法 1
Student s2 = new Student("张三", 20);                          // 构造方法 2
Student s3 = new Student("李四", 22, "S002");                 // 构造方法 3
Student s4 = new Student("王五", 21, "S003", "wang@example.com");  // 构造方法 4
```

### 构造方法链式调用

**使用 `this()` 调用其他构造方法**，避免代码重复。

```java
public class Student {
    private String name;
    private int age;
    private String studentId;
    private String email;
    
    // 无参构造：调用两参构造
    public Student() {
        this("未知", 0);
    }
    
    // 两参构造：调用三参构造
    public Student(String name, int age) {
        this(name, age, "N/A");
    }
    
    // 三参构造：调用四参构造
    public Student(String name, int age, String studentId) {
        this(name, age, studentId, "N/A");
    }
    
    // 主构造方法：完成实际初始化
    public Student(String name, int age, String studentId, String email) {
        this.name = name;
        this.age = age;
        this.studentId = studentId;
        this.email = email;
    }
}
```

**规则**：
- `this()` 必须是构造方法的第一条语句
- 不能形成循环调用
- 最终必须调用一个实际初始化的构造方法

### 构造方法调用顺序

```java
public class Student {
    private String name;
    private int age;
    
    {
        System.out.println("实例初始化块 1");
    }
    
    public Student() {
        this("默认", 0);
        System.out.println("无参构造方法");
    }
    
    public Student(String name, int age) {
        System.out.println("有参构造方法");
        this.name = name;
        this.age = age;
    }
    
    {
        System.out.println("实例初始化块 2");
    }
}

// 创建对象时的执行顺序：
// 1. 实例初始化块 1
// 2. 实例初始化块 2
// 3. 有参构造方法
// 4. 无参构造方法
```

## 构造方法的其他特性

### 1. 访问修饰符

```java
public class Student {
    // 公共构造方法
    public Student() { }
    
    // 包私有构造方法
    Student(String name) { }
    
    // 受保护构造方法
    protected Student(String name, int age) { }
    
    // 私有构造方法（单例模式）
    private Student(String name, int age, String id) { }
}
```

### 2. 静态工厂方法

**使用静态方法创建对象，而不是构造方法**：

```java
public class Student {
    private String name;
    private int age;
    
    private Student(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    // 静态工厂方法
    public static Student create(String name, int age) {
        return new Student(name, age);
    }
    
    public static Student createDefault() {
        return new Student("默认", 0);
    }
}

// 使用
Student student = Student.create("张三", 20);
```

### 3. 构造方法与继承

```java
// 父类
public class Person {
    protected String name;
    protected int age;
    
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
}

// 子类
public class Student extends Person {
    private String studentId;
    
    // 子类构造方法必须调用父类构造方法
    public Student(String name, int age, String studentId) {
        super(name, age);  // 调用父类构造方法
        this.studentId = studentId;
    }
}
```

## 实际示例

### 示例 1：完整的构造方法使用

```java
public class BankAccount {
    private String accountNumber;
    private String ownerName;
    private double balance;
    private String accountType;
    
    // 无参构造
    public BankAccount() {
        this("N/A", "未知", "储蓄账户");
    }
    
    // 三参构造
    public BankAccount(String accountNumber, String ownerName, String accountType) {
        this(accountNumber, ownerName, 0.0, accountType);
    }
    
    // 四参构造（主构造方法）
    public BankAccount(String accountNumber, String ownerName, double balance, String accountType) {
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            throw new IllegalArgumentException("账户号不能为空");
        }
        if (ownerName == null || ownerName.trim().isEmpty()) {
            throw new IllegalArgumentException("户主姓名不能为空");
        }
        if (balance < 0) {
            throw new IllegalArgumentException("初始余额不能为负数");
        }
        
        this.accountNumber = accountNumber;
        this.ownerName = ownerName;
        this.balance = balance;
        this.accountType = accountType;
    }
    
    // Getter 方法
    public String getAccountNumber() { return accountNumber; }
    public String getOwnerName() { return ownerName; }
    public double getBalance() { return balance; }
    public String getAccountType() { return accountType; }
    
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    
    public void displayInfo() {
        System.out.println("账户号：" + accountNumber);
        System.out.println("户主：" + ownerName);
        System.out.println("余额：" + balance);
        System.out.println("账户类型：" + accountType);
    }
}

// 使用
public class BankDemo {
    public static void main(String[] args) {
        BankAccount account1 = new BankAccount();
        account1.displayInfo();
        
        BankAccount account2 = new BankAccount("123456", "张三", "储蓄账户");
        account2.displayInfo();
        
        BankAccount account3 = new BankAccount("789012", "李四", 1000.0, "支票账户");
        account3.displayInfo();
    }
}
```

### 示例 2：构造方法重载

```java
public class Rectangle {
    private double width;
    private double height;
    
    // 无参构造：创建默认正方形
    public Rectangle() {
        this(1.0, 1.0);
    }
    
    // 单参构造：创建正方形
    public Rectangle(double side) {
        this(side, side);
    }
    
    // 双参构造：创建矩形
    public Rectangle(double width, double height) {
        if (width <= 0 || height <= 0) {
            throw new IllegalArgumentException("宽度和高度必须大于 0");
        }
        this.width = width;
        this.height = height;
    }
    
    public double getArea() {
        return width * height;
    }
    
    public double getPerimeter() {
        return 2 * (width + height);
    }
}

// 使用
Rectangle r1 = new Rectangle();        // 1x1 正方形
Rectangle r2 = new Rectangle(5.0);    // 5x5 正方形
Rectangle r3 = new Rectangle(4.0, 6.0);  // 4x6 矩形
```

### 示例 3：构造方法链式调用

```java
public class Product {
    private String name;
    private double price;
    private String category;
    private String description;
    private int stock;
    
    // 无参构造
    public Product() {
        this("未知商品", 0.0);
    }
    
    // 两参构造
    public Product(String name, double price) {
        this(name, price, "未分类");
    }
    
    // 三参构造
    public Product(String name, double price, String category) {
        this(name, price, category, "无描述");
    }
    
    // 四参构造
    public Product(String name, double price, String category, String description) {
        this(name, price, category, description, 0);
    }
    
    // 主构造方法
    public Product(String name, double price, String category, String description, int stock) {
        this.name = name;
        this.price = price;
        this.category = category;
        this.description = description;
        this.stock = stock;
    }
    
    // Getter 方法
    public String getName() { return name; }
    public double getPrice() { return price; }
    public String getCategory() { return category; }
    public String getDescription() { return description; }
    public int getStock() { return stock; }
}
```

## 构造方法最佳实践

### 1. 参数验证

```java
public Student(String name, int age) {
    if (name == null || name.trim().isEmpty()) {
        throw new IllegalArgumentException("姓名不能为空");
    }
    if (age < 0) {
        throw new IllegalArgumentException("年龄不能为负数");
    }
    this.name = name;
    this.age = age;
}
```

### 2. 使用 this 区分参数和字段

```java
public Student(String name, int age) {
    this.name = name;  // this.name 是字段，name 是参数
    this.age = age;
}
```

### 3. 构造方法链式调用

```java
// 推荐：使用 this() 避免代码重复
public Student() {
    this("默认", 0);
}

public Student(String name, int age) {
    this.name = name;
    this.age = age;
}
```

### 4. 提供多个构造方法

```java
// 提供不同参数的构造方法，方便使用
public Student() { }
public Student(String name) { }
public Student(String name, int age) { }
```

## 小结

Java 构造方法要点：

- **默认构造方法**：自动提供，定义构造方法后消失
- **带参构造方法**：接收参数初始化对象
- **构造方法重载**：多个构造方法，参数不同
- **链式调用**：使用 `this()` 调用其他构造方法
- **参数验证**：在构造方法中验证参数有效性

**关键要点**：
- 构造方法名与类名相同
- 构造方法没有返回类型
- `this()` 必须是第一条语句
- 构造方法可以重载
- 使用链式调用避免代码重复

理解了构造方法，你就能灵活地创建和初始化对象。在下一章，我们将学习 Java 的访问修饰符。
