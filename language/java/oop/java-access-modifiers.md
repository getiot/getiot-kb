---
sidebar_position: 4
slug: /java-access-modifiers
sidebar_label: Java 访问修饰符
---

# Java 访问修饰符与权限控制

访问修饰符用于控制类、属性、方法的访问范围。理解访问修饰符的使用是掌握 Java 封装和模块化的关键。本章将详细介绍 Java 的四种访问级别。

## 访问修饰符概述

Java 提供四种访问修饰符（public / private / protected / default），控制类成员的可见性：

| 修饰符 | 同一类 | 同一包 | 子类 | 不同包 |
|:------:|:------:|:------:|:----:|:-----:|
| private | ✅ | ❌ | ❌ | ❌ |
| default | ✅ | ✅ | ❌ | ❌ |
| protected | ✅ | ✅ | ✅ | ❌ |
| public | ✅ | ✅ | ✅ | ✅ |

### private（私有）

**最严格的访问级别**，只能在当前类内访问。

```java
public class Student {
    // 私有属性
    private String name;
    private int age;
    
    // 私有方法
    private void validateAge(int age) {
        if (age < 0 || age > 150) {
            throw new IllegalArgumentException("年龄无效");
        }
    }
    
    // 公共方法访问私有属性
    public void setAge(int age) {
        validateAge(age);  // 可以访问私有方法
        this.age = age;   // 可以访问私有属性
    }
    
    public int getAge() {
        return age;  // 可以访问私有属性
    }
}

// 其他类
public class Test {
    public static void main(String[] args) {
        Student student = new Student();
        // student.name;  // ❌ 错误：不能访问私有属性
        // student.validateAge(20);  // ❌ 错误：不能访问私有方法
        student.setAge(20);  // ✅ 正确：通过公共方法访问
    }
}
```

**使用场景**：
- 隐藏实现细节
- 保护数据不被外部直接访问
- 内部辅助方法

### default（包私有）

**默认访问级别**，不使用任何修饰符，同一包内可以访问。

```java
// 文件：com.example.Student.java
package com.example;

class Student {  // 默认访问（包私有）
    String name;  // 默认访问
    int age;      // 默认访问
    
    void study() {  // 默认访问
        System.out.println("学习");
    }
}

// 同一包内的类可以访问
package com.example;

public class Teacher {
    public void test() {
        Student student = new Student();  // ✅ 可以访问
        student.name = "张三";            // ✅ 可以访问
        student.study();                  // ✅ 可以访问
    }
}

// 不同包的类不能访问
package com.other;

import com.example.Student;

public class Test {
    public void test() {
        // Student student = new Student();  // ❌ 错误：不能访问包私有类
    }
}
```

**使用场景**：
- 包内共享的辅助类
- 包内工具类

### protected（受保护）

**受保护访问级别**，同一包内和子类可以访问。

```java
package com.example;

public class Animal {
    protected String name;  // 受保护属性
    protected int age;      // 受保护属性
    
    protected void eat() {  // 受保护方法
        System.out.println(name + " 正在吃东西");
    }
}

// 同一包内的类
package com.example;

public class Dog extends Animal {
    public void test() {
        name = "旺财";  // ✅ 可以访问（子类）
        eat();          // ✅ 可以访问（子类）
    }
}

// 不同包的子类
package com.other;

import com.example.Animal;

public class Cat extends Animal {
    public void test() {
        name = "咪咪";  // ✅ 可以访问（子类）
        eat();          // ✅ 可以访问（子类）
    }
}

// 不同包的非子类
package com.other;

import com.example.Animal;

public class Test {
    public void test() {
        Animal animal = new Animal();
        // animal.name;  // ❌ 错误：不能访问受保护属性
        // animal.eat();  // ❌ 错误：不能访问受保护方法
    }
}
```

**使用场景**：
- 希望子类可以访问，但外部不能访问
- 包内共享，包外受限

### public（公共）

**最宽松的访问级别**，任何地方都可以访问。

```java
package com.example;

public class Student {
    public String name;  // 公共属性
    public int age;      // 公共属性
    
    public void study() {  // 公共方法
        System.out.println("学习");
    }
}

// 任何地方都可以访问
package com.other;

import com.example.Student;

public class Test {
    public void test() {
        Student student = new Student();
        student.name = "张三";  // ✅ 可以访问
        student.study();        // ✅ 可以访问
    }
}
```

**使用场景**：
- 对外提供的 API
- 需要被广泛使用的类和方法

## 类、属性、方法访问范围

### 类的访问修饰符

**类的访问修饰符**：
- `public`：任何地方都可以访问
- `default`（无修饰符）：同一包内可以访问
- 不能使用 `private` 和 `protected` 修饰外部类

```java
// 公共类
public class PublicClass { }

// 包私有类
class PackagePrivateClass { }

// ❌ 错误：不能使用 private 或 protected
// private class PrivateClass { }
// protected class ProtectedClass { }
```

**内部类可以使用所有访问修饰符**：

```java
public class Outer {
    // 公共内部类
    public class PublicInner { }
    
    // 私有内部类
    private class PrivateInner { }
    
    // 受保护内部类
    protected class ProtectedInner { }
    
    // 包私有内部类
    class PackagePrivateInner { }
}
```

### 属性的访问修饰符

```java
public class Student {
    // 私有属性（推荐）
    private String name;
    
    // 包私有属性
    String studentId;
    
    // 受保护属性
    protected int age;
    
    // 公共属性（不推荐，破坏封装）
    public double score;
}
```

**最佳实践**：
- **推荐**：使用 `private`，通过 getter/setter 访问
- **避免**：使用 `public` 暴露属性

### 方法的访问修饰符

```java
public class Student {
    // 私有方法：内部辅助方法
    private void validateAge(int age) {
        if (age < 0) {
            throw new IllegalArgumentException("年龄无效");
        }
    }
    
    // 包私有方法：包内共享
    void internalMethod() { }
    
    // 受保护方法：子类可以访问
    protected void protectedMethod() { }
    
    // 公共方法：对外接口
    public void publicMethod() { }
}
```

## 包与访问控制

### 包的概念

**包（Package）**用于组织类和命名空间。

```java
// 文件：com/example/Student.java
package com.example;

public class Student {
    private String name;
    
    public String getName() {
        return name;
    }
}
```

### 包与访问修饰符的关系

```java
// 包 com.example
package com.example;

public class Student {
    public String publicField;
    protected String protectedField;
    String defaultField;  // 包私有
    private String privateField;
}

// 同一包内的类
package com.example;

public class Teacher {
    public void test() {
        Student student = new Student();
        student.publicField = "public";      // ✅ 可以访问
        student.protectedField = "protected"; // ✅ 可以访问
        student.defaultField = "default";     // ✅ 可以访问
        // student.privateField = "private"; // ❌ 不能访问
    }
}

// 不同包的类
package com.other;

import com.example.Student;

public class Test {
    public void test() {
        Student student = new Student();
        student.publicField = "public";      // ✅ 可以访问
        // student.protectedField = "protected"; // ❌ 不能访问（非子类）
        // student.defaultField = "default";     // ❌ 不能访问
        // student.privateField = "private";     // ❌ 不能访问
    }
}
```

### 子类与访问控制

```java
// 父类
package com.example;

public class Animal {
    public String publicField;
    protected String protectedField;
    String defaultField;
    private String privateField;
}

// 子类（同一包）
package com.example;

public class Dog extends Animal {
    public void test() {
        publicField = "public";      // ✅ 可以访问
        protectedField = "protected"; // ✅ 可以访问
        defaultField = "default";     // ✅ 可以访问
        // privateField = "private"; // ❌ 不能访问
    }
}

// 子类（不同包）
package com.other;

import com.example.Animal;

public class Cat extends Animal {
    public void test() {
        publicField = "public";      // ✅ 可以访问
        protectedField = "protected"; // ✅ 可以访问（子类）
        // defaultField = "default";  // ❌ 不能访问
        // privateField = "private";  // ❌ 不能访问
    }
}
```

## 访问控制最佳实践

### 1. 属性使用 private

```java
public class Student {
    // ✅ 推荐：私有属性
    private String name;
    private int age;
    
    // 提供公共访问方法
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
}
```

### 2. 方法根据需求选择

```java
public class Student {
    // 公共方法：对外接口
    public void study() { }
    
    // 受保护方法：子类可以重写
    protected void internalProcess() { }
    
    // 私有方法：内部辅助
    private void validate() { }
}
```

### 3. 类使用 public 或 default

```java
// 公共类：对外提供
public class Student { }

// 包私有类：内部使用
class StudentHelper { }
```

## 实际示例

### 示例 1：完整的访问控制

```java
package com.example;

public class BankAccount {
    // 私有属性：保护数据
    private String accountNumber;
    private String ownerName;
    private double balance;
    
    // 包私有属性：包内共享
    String bankCode;
    
    // 受保护属性：子类可以访问
    protected String accountType;
    
    // 公共常量
    public static final double MIN_BALANCE = 0.0;
    
    // 构造方法
    public BankAccount(String accountNumber, String ownerName) {
        this.accountNumber = accountNumber;
        this.ownerName = ownerName;
        this.balance = 0.0;
    }
    
    // 公共方法：对外接口
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    
    public double getBalance() {
        return balance;
    }
    
    // 受保护方法：子类可以重写
    protected void validateWithdrawal(double amount) {
        if (amount > balance) {
            throw new IllegalArgumentException("余额不足");
        }
    }
    
    // 包私有方法：包内共享
    void internalProcess() { }
    
    // 私有方法：内部辅助
    private void logTransaction(String type, double amount) {
        System.out.println(type + ": " + amount);
    }
}
```

### 示例 2：继承中的访问控制

```java
package com.example;

public class Animal {
    public String publicField = "public";
    protected String protectedField = "protected";
    String defaultField = "default";
    private String privateField = "private";
    
    public void publicMethod() {
        System.out.println("公共方法");
    }
    
    protected void protectedMethod() {
        System.out.println("受保护方法");
    }
    
    void defaultMethod() {
        System.out.println("包私有方法");
    }
    
    private void privateMethod() {
        System.out.println("私有方法");
    }
}

// 同一包的子类
package com.example;

public class Dog extends Animal {
    public void test() {
        // 所有非私有成员都可以访问
        System.out.println(publicField);
        System.out.println(protectedField);
        System.out.println(defaultField);
        // System.out.println(privateField);  // ❌ 不能访问
        
        publicMethod();
        protectedMethod();
        defaultMethod();
        // privateMethod();  // ❌ 不能访问
    }
}
```

## 小结

Java 访问修饰符要点：

- **四种级别**：private、default、protected、public
- **访问范围**：从严格到宽松
- **使用原则**：属性用 private，方法根据需求选择
- **包的作用**：影响 default 和 protected 的访问范围

**关键要点**：
- private：最严格，仅当前类
- default：同一包内
- protected：同一包和子类
- public：任何地方
- 属性推荐使用 private
- 通过方法控制访问

理解了访问修饰符，你就能控制类的封装性。在下一章，我们将学习 Java 的包和 import。
