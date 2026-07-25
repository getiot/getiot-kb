---
sidebar_position: 6
slug: /java-encapsulation
sidebar_label: Java 封装
---

# Java 封装（Encapsulation）

封装是面向对象编程的核心特性之一，它将数据和对数据的操作封装在一起，隐藏内部实现细节，只暴露必要的接口。理解封装是编写高质量 Java 代码的基础。本章将详细介绍 Java 中的封装机制。

## 封装定义

### 什么是封装

**封装**（Encapsulation）是将数据和对数据的操作封装在类中，通过访问控制隐藏内部实现细节，只提供必要的接口供外部使用。

**核心思想**：
- **隐藏实现**：内部细节对外不可见
- **提供接口**：通过公共方法访问数据
- **保护数据**：防止外部直接修改数据
- **简化使用**：使用者不需要了解内部实现

### 封装的实现

**通过访问修饰符实现封装**：

```java
public class BankAccount {
    // 私有属性：隐藏数据
    private String accountNumber;
    private String ownerName;
    private double balance;
    
    // 公共方法：提供接口
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    
    public double getBalance() {
        return balance;
    }
}
```

## private 属性 + getter/setter

### 私有属性

**使用 `private` 修饰属性，隐藏数据**：

```java
public class Student {
    // 私有属性：外部不能直接访问
    private String name;
    private int age;
    private double score;
}
```

### Getter 方法

**Getter** 用于获取私有属性的值。

```java
public class Student {
    private String name;
    private int age;
    private double score;
    
    // Getter 方法：获取姓名
    public String getName() {
        return name;
    }
    
    // Getter 方法：获取年龄
    public int getAge() {
        return age;
    }
    
    // Getter 方法：获取成绩
    public double getScore() {
        return score;
    }
}
```

**命名规范**：
- 方法名：`get` + 属性名（首字母大写）
- 布尔类型：`is` + 属性名

```java
public class Student {
    private boolean active;
    
    // 布尔类型的 Getter
    public boolean isActive() {
        return active;
    }
}
```

### Setter 方法

**Setter** 用于设置私有属性的值，可以在方法中添加验证逻辑。

```java
public class Student {
    private String name;
    private int age;
    private double score;
    
    // Setter 方法：设置姓名
    public void setName(String name) {
        if (name != null && !name.trim().isEmpty()) {
            this.name = name;
        } else {
            throw new IllegalArgumentException("姓名不能为空");
        }
    }
    
    // Setter 方法：设置年龄（带验证）
    public void setAge(int age) {
        if (age > 0 && age < 150) {
            this.age = age;
        } else {
            throw new IllegalArgumentException("年龄必须在 0-150 之间");
        }
    }
    
    // Setter 方法：设置成绩（带验证）
    public void setScore(double score) {
        if (score >= 0 && score <= 100) {
            this.score = score;
        } else {
            throw new IllegalArgumentException("成绩必须在 0-100 之间");
        }
    }
}
```

**命名规范**：
- 方法名：`set` + 属性名（首字母大写）
- 返回类型：`void`
- 参数：属性类型

### 完整的封装示例

```java
public class BankAccount {
    // 私有属性
    private String accountNumber;
    private String ownerName;
    private double balance;
    
    // 构造方法
    public BankAccount(String accountNumber, String ownerName) {
        this.accountNumber = accountNumber;
        this.ownerName = ownerName;
        this.balance = 0.0;
    }
    
    // Getter 方法
    public String getAccountNumber() {
        return accountNumber;
    }
    
    public String getOwnerName() {
        return ownerName;
    }
    
    public double getBalance() {
        return balance;
    }
    
    // Setter 方法（只读属性不需要 Setter）
    // accountNumber 和 ownerName 是只读的，不提供 Setter
    
    // 业务方法：存款
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            System.out.println("存款成功，余额：" + balance);
        } else {
            System.out.println("存款金额必须大于 0");
        }
    }
    
    // 业务方法：取款
    public void withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            System.out.println("取款成功，余额：" + balance);
        } else {
            System.out.println("取款失败，余额不足或金额无效");
        }
    }
    
    // 业务方法：显示信息
    public void displayInfo() {
        System.out.println("账户号：" + accountNumber);
        System.out.println("户主：" + ownerName);
        System.out.println("余额：" + balance);
    }
}
```

## 封装的好处

### 1. 数据保护

**防止外部直接修改数据，保证数据完整性**：

```java
// ❌ 不封装：数据可能被破坏
public class Student {
    public int age;  // 外部可以直接修改
}

Student student = new Student();
student.age = -10;  // 无效数据

// ✅ 封装：数据受到保护
public class Student {
    private int age;
    
    public void setAge(int age) {
        if (age > 0 && age < 150) {
            this.age = age;
        } else {
            throw new IllegalArgumentException("年龄无效");
        }
    }
}

Student student = new Student();
student.setAge(-10);  // 抛出异常，数据得到保护
```

### 2. 隐藏实现细节

**内部实现可以改变，但接口不变**：

```java
public class Calculator {
    // 内部实现可以改变
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

// 外部使用不受影响
Calculator calc = new Calculator();
int result = calc.add(5, 3);  // 无论内部如何实现，结果都是 8
```

### 3. 简化使用

**使用者不需要了解内部实现**：

```java
public class DatabaseConnection {
    private String url;
    private String username;
    private String password;
    private Connection connection;
    
    // 封装复杂的连接逻辑
    public void connect() {
        // 复杂的连接代码
        // 使用者不需要知道如何连接
    }
    
    public void disconnect() {
        // 复杂的断开连接代码
    }
}

// 使用简单
DatabaseConnection db = new DatabaseConnection();
db.connect();  // 不需要知道内部如何连接
```

### 4. 便于维护

**修改内部实现不影响外部代码**：

```java
public class Student {
    // 原来：使用数组存储课程
    // private String[] courses;
    
    // 现在：改为使用 List（内部改变）
    private List<String> courses;
    
    // 接口不变
    public void addCourse(String course) {
        courses.add(course);
    }
    
    public List<String> getCourses() {
        return new ArrayList<>(courses);  // 返回副本，保护内部数据
    }
}
```

### 5. 提高代码质量

**通过封装实现更好的代码组织**：

```java
public class BankAccount {
    private double balance;
    
    // 封装业务逻辑
    public void deposit(double amount) {
        validateAmount(amount);
        balance += amount;
        logTransaction("DEPOSIT", amount);
        notifyUser("存款成功");
    }
    
    // 私有方法：内部使用
    private void validateAmount(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("金额必须大于 0");
        }
    }
    
    private void logTransaction(String type, double amount) {
        // 记录交易日志
    }
    
    private void notifyUser(String message) {
        // 通知用户
    }
}
```

## 封装的最佳实践

### 1. 属性使用 private

```java
public class Student {
    // ✅ 推荐：私有属性
    private String name;
    private int age;
    
    // ❌ 不推荐：公共属性
    // public String name;
}
```

### 2. 提供 Getter/Setter

```java
public class Student {
    private String name;
    
    // ✅ 提供 Getter
    public String getName() {
        return name;
    }
    
    // ✅ 提供 Setter（如果需要修改）
    public void setName(String name) {
        this.name = name;
    }
}
```

### 3. 在 Setter 中添加验证

```java
public class Student {
    private int age;
    
    public void setAge(int age) {
        // ✅ 添加验证
        if (age > 0 && age < 150) {
            this.age = age;
        } else {
            throw new IllegalArgumentException("年龄无效");
        }
    }
}
```

### 4. 返回集合的副本

```java
public class Student {
    private List<String> courses = new ArrayList<>();
    
    // ✅ 返回副本，保护内部数据
    public List<String> getCourses() {
        return new ArrayList<>(courses);
    }
    
    // ❌ 不推荐：直接返回内部集合
    // public List<String> getCourses() {
    //     return courses;  // 外部可以修改内部数据
    // }
}
```

## 实际示例

### 示例 1：完整的封装实现

```java
public class Employee {
    // 私有属性
    private String id;
    private String name;
    private double salary;
    private String department;
    
    // 构造方法
    public Employee(String id, String name, double salary, String department) {
        setId(id);
        setName(name);
        setSalary(salary);
        setDepartment(department);
    }
    
    // Getter 方法
    public String getId() {
        return id;
    }
    
    public String getName() {
        return name;
    }
    
    public double getSalary() {
        return salary;
    }
    
    public String getDepartment() {
        return department;
    }
    
    // Setter 方法（带验证）
    public void setId(String id) {
        if (id != null && !id.trim().isEmpty()) {
            this.id = id;
        } else {
            throw new IllegalArgumentException("ID 不能为空");
        }
    }
    
    public void setName(String name) {
        if (name != null && !name.trim().isEmpty()) {
            this.name = name;
        } else {
            throw new IllegalArgumentException("姓名不能为空");
        }
    }
    
    public void setSalary(double salary) {
        if (salary >= 0) {
            this.salary = salary;
        } else {
            throw new IllegalArgumentException("薪资不能为负数");
        }
    }
    
    public void setDepartment(String department) {
        if (department != null && !department.trim().isEmpty()) {
            this.department = department;
        } else {
            throw new IllegalArgumentException("部门不能为空");
        }
    }
    
    // 业务方法
    public void raiseSalary(double percentage) {
        if (percentage > 0) {
            salary += salary * percentage / 100;
        }
    }
    
    public void displayInfo() {
        System.out.println("员工 ID：" + id);
        System.out.println("姓名：" + name);
        System.out.println("薪资：" + salary);
        System.out.println("部门：" + department);
    }
}
```

### 示例 2：只读属性

```java
public class Circle {
    // 只读属性：半径（通过构造方法设置）
    private final double radius;
    
    public Circle(double radius) {
        if (radius > 0) {
            this.radius = radius;
        } else {
            throw new IllegalArgumentException("半径必须大于 0");
        }
    }
    
    // 只提供 Getter，不提供 Setter
    public double getRadius() {
        return radius;
    }
    
    // 计算面积
    public double getArea() {
        return Math.PI * radius * radius;
    }
    
    // 计算周长
    public double getCircumference() {
        return 2 * Math.PI * radius;
    }
}
```

## 小结

Java 封装要点：

- **封装定义**：隐藏实现，提供接口
- **实现方式**：private 属性 + getter/setter
- **好处**：数据保护、隐藏细节、简化使用、便于维护
- **最佳实践**：属性私有、提供访问方法、添加验证

**关键要点**：
- 使用 private 隐藏数据
- 通过 getter/setter 访问数据
- 在 setter 中添加验证逻辑
- 返回集合时返回副本
- 只读属性不提供 setter

理解了封装，你就能编写更安全、更易维护的代码。在下一章，我们将学习 Java 的继承。
