---
sidebar_position: 2
slug: /java-classes-objects
sidebar_label: Java 类与对象
---

# Java 类与对象

类是 Java 程序的基本组成单元，对象是类的实例。理解如何定义类、创建对象以及它们之间的关系，是掌握面向对象编程的基础。本章将详细介绍 Java 中类和对象的使用。

## 类定义、属性与方法

### 类定义

**语法**：
```java
[访问修饰符] class 类名 {
    // 属性（字段）
    // 方法
    // 构造方法
    // 内部类
}
```

**示例**：
```java
public class Student {
    // 类的内容
}
```

### 属性（字段）

**属性**是类的数据成员，用于描述对象的状态。

```java
public class Student {
    // 属性定义
    private String name;      // 姓名
    private int age;          // 年龄
    private String studentId; // 学号
    private double score;     // 成绩
}
```

**属性类型**：
- **实例变量**：每个对象有独立的副本
- **静态变量**：所有对象共享

```java
public class Student {
    // 实例变量
    private String name;
    private int age;
    
    // 静态变量（类变量）
    private static int totalStudents = 0;
}
```

### 方法

**方法**是类的行为，用于操作属性或执行功能。

```java
public class Student {
    private String name;
    private int age;
    
    // 方法：设置姓名
    public void setName(String name) {
        this.name = name;
    }
    
    // 方法：获取姓名
    public String getName() {
        return name;
    }
    
    // 方法：学习
    public void study() {
        System.out.println(name + " 正在学习");
    }
    
    // 方法：介绍自己
    public void introduce() {
        System.out.println("我是 " + name + "，今年 " + age + " 岁");
    }
}
```

### 完整的类定义示例

```java
public class Student {
    // ========== 属性 ==========
    private String name;
    private int age;
    private String studentId;
    private double score;
    
    // ========== 构造方法 ==========
    public Student(String name, int age, String studentId) {
        this.name = name;
        this.age = age;
        this.studentId = studentId;
        this.score = 0.0;
    }
    
    // ========== Getter 方法 ==========
    public String getName() {
        return name;
    }
    
    public int getAge() {
        return age;
    }
    
    public String getStudentId() {
        return studentId;
    }
    
    public double getScore() {
        return score;
    }
    
    // ========== Setter 方法 ==========
    public void setName(String name) {
        this.name = name;
    }
    
    public void setAge(int age) {
        if (age > 0 && age < 150) {
            this.age = age;
        }
    }
    
    public void setScore(double score) {
        if (score >= 0 && score <= 100) {
            this.score = score;
        }
    }
    
    // ========== 业务方法 ==========
    public void study() {
        System.out.println(name + " 正在学习");
    }
    
    public void takeExam(double examScore) {
        this.score = examScore;
        System.out.println(name + " 考试得分：" + examScore);
    }
    
    public void introduce() {
        System.out.println("姓名：" + name);
        System.out.println("年龄：" + age);
        System.out.println("学号：" + studentId);
        System.out.println("成绩：" + score);
    }
}
```

## 对象实例化

### 创建对象

**使用 `new` 关键字创建对象**：

```java
// 语法：类名 对象名 = new 类名();
Student student = new Student();
```

### 对象实例化过程

```java
// 1. 声明引用变量
Student student;

// 2. 创建对象（实例化）
student = new Student("张三", 20, "S001");

// 或者合并为一步
Student student = new Student("张三", 20, "S001");
```

**过程说明**：
1. **声明**：声明一个引用变量
2. **实例化**：使用 `new` 创建对象
3. **初始化**：调用构造方法初始化对象
4. **赋值**：将对象引用赋给变量

### 访问对象成员

```java
Student student = new Student("张三", 20, "S001");

// 访问方法
student.study();
student.introduce();

// 访问属性（如果可见）
// student.name;  // 如果 name 是 private，不能直接访问
String name = student.getName();  // 通过方法访问
```

### 多个对象

```java
// 创建多个对象
Student student1 = new Student("张三", 20, "S001");
Student student2 = new Student("李四", 22, "S002");
Student student3 = new Student("王五", 21, "S003");

// 每个对象有独立的属性
student1.study();  // 张三 正在学习
student2.study();  // 李四 正在学习
student3.study();  // 王五 正在学习
```

### 对象引用

```java
Student student1 = new Student("张三", 20, "S001");
Student student2 = student1;  // student2 和 student1 指向同一个对象

student2.setName("李四");
System.out.println(student1.getName());  // 李四（修改了同一个对象）
```

**注意**：Java 中对象变量存储的是引用，不是对象本身。

## 构造方法基本使用

### 什么是构造方法

**构造方法（Constructor）**是创建对象时自动调用的特殊方法，用于初始化对象。

**特点**：
- 方法名与类名相同
- 没有返回类型（连 void 也没有）
- 创建对象时自动调用
- 可以重载

### 默认构造方法

**如果没有定义构造方法，Java 会提供默认的无参构造方法**：

```java
public class Student {
    private String name;
    private int age;
    
    // 没有定义构造方法，Java 提供默认构造方法：
    // public Student() { }
}

// 使用默认构造方法
Student student = new Student();  // 调用默认构造方法
```

### 自定义构造方法

```java
public class Student {
    private String name;
    private int age;
    
    // 无参构造方法
    public Student() {
        this.name = "未知";
        this.age = 0;
    }
    
    // 有参构造方法
    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }
}

// 使用
Student student1 = new Student();              // 调用无参构造
Student student2 = new Student("张三", 20);   // 调用有参构造
```

### 构造方法重载

```java
public class Student {
    private String name;
    private int age;
    private String studentId;
    
    // 构造方法 1：无参
    public Student() {
        this("未知", 0, "N/A");
    }
    
    // 构造方法 2：两个参数
    public Student(String name, int age) {
        this(name, age, "N/A");
    }
    
    // 构造方法 3：三个参数
    public Student(String name, int age, String studentId) {
        this.name = name;
        this.age = age;
        this.studentId = studentId;
    }
}

// 使用
Student s1 = new Student();                           // 调用构造方法 1
Student s2 = new Student("张三", 20);                 // 调用构造方法 2
Student s3 = new Student("李四", 22, "S002");        // 调用构造方法 3
```

### this 关键字

**`this` 表示当前对象的引用**：

```java
public class Student {
    private String name;
    
    public Student(String name) {
        this.name = name;  // this.name 是成员变量，name 是参数
    }
    
    public void setName(String name) {
        this.name = name;  // 区分参数和成员变量
    }
}
```

**this 的用途**：
1. 区分参数和成员变量
2. 调用其他构造方法
3. 返回当前对象

## 实际示例

### 示例 1：完整的类定义

```java
public class BankAccount {
    // 属性
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
    
    // 业务方法
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            System.out.println("存款成功，余额：" + balance);
        } else {
            System.out.println("存款金额必须大于 0");
        }
    }
    
    public void withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            System.out.println("取款成功，余额：" + balance);
        } else {
            System.out.println("取款失败，余额不足或金额无效");
        }
    }
    
    public void displayInfo() {
        System.out.println("账户号：" + accountNumber);
        System.out.println("户主：" + ownerName);
        System.out.println("余额：" + balance);
    }
}

// 使用
public class BankDemo {
    public static void main(String[] args) {
        BankAccount account = new BankAccount("123456", "张三");
        account.displayInfo();
        account.deposit(1000);
        account.withdraw(300);
        account.displayInfo();
    }
}
```

### 示例 2：多个对象

```java
public class StudentDemo {
    public static void main(String[] args) {
        // 创建多个学生对象
        Student s1 = new Student("张三", 20, "S001");
        Student s2 = new Student("李四", 22, "S002");
        Student s3 = new Student("王五", 21, "S003");
        
        // 每个对象独立操作
        s1.takeExam(85);
        s2.takeExam(90);
        s3.takeExam(78);
        
        // 显示信息
        s1.introduce();
        s2.introduce();
        s3.introduce();
    }
}
```

### 示例 3：对象数组

```java
public class StudentArrayDemo {
    public static void main(String[] args) {
        // 创建学生数组
        Student[] students = new Student[3];
        
        // 初始化数组元素
        students[0] = new Student("张三", 20, "S001");
        students[1] = new Student("李四", 22, "S002");
        students[2] = new Student("王五", 21, "S003");
        
        // 遍历数组
        for (Student student : students) {
            student.introduce();
        }
    }
}
```

## 类与对象的关系总结

### 关系图

```
类（Class）
  ├─ 属性（Properties）
  ├─ 方法（Methods）
  └─ 构造方法（Constructors）
       ↓ 实例化
对象（Object）
  ├─ 具有具体的属性值
  └─ 可以调用方法
```

### 关键概念

| 概念 | 说明 | 示例 |
|:----:|:----:|:----:|
| 类 | 模板、蓝图 | `Student` 类 |
| 对象 | 类的实例 | `student1`、`student2` |
| 属性 | 对象的状态 | `name`、`age` |
| 方法 | 对象的行为 | `study()`、`introduce()` |
| 实例化 | 创建对象 | `new Student()` |
| 引用 | 指向对象的变量 | `Student student` |

## 小结

Java 类与对象要点：

- **类定义**：包含属性、方法、构造方法
- **对象实例化**：使用 `new` 关键字创建对象
- **构造方法**：初始化对象，可以重载
- **this 关键字**：引用当前对象
- **对象引用**：变量存储的是引用，不是对象本身

**关键要点**：
- 类是模板，对象是实例
- 每个对象有独立的属性值
- 所有对象共享类的方法
- 构造方法用于初始化对象
- 使用 this 区分参数和成员变量

理解了类和对象，你就能创建和使用对象了。在下一章，我们将深入学习构造方法的使用。
