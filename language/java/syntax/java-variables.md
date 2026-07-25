---
sidebar_position: 3
slug: /java-variables
---

# Java 变量与常量

变量是程序中存储数据的基本单元，常量是不可改变的值。理解变量的类型、作用域和生命周期，是编写正确 Java 程序的关键。本章将详细介绍 Java 中变量的使用。

## 局部变量、成员变量、静态变量

### 变量的分类

Java 中的变量根据声明位置和修饰符，可以分为三类：

1. **局部变量（Local Variables）**：在方法、构造方法或代码块中声明
2. **成员变量（Instance Variables）**：在类中声明，属于对象实例
3. **静态变量（Class Variables）**：用 `static` 修饰，属于类

### 局部变量

**特点**：
- 在方法、构造方法或代码块中声明
- 只在声明它的代码块中有效
- 必须初始化后才能使用
- 不能使用访问修饰符

```java
public class Example {
    public void method() {
        // 局部变量
        int localVar = 10;
        String name = "Java";
        
        if (true) {
            // 代码块中的局部变量
            int blockVar = 20;
            System.out.println(blockVar);  // 可以访问
        }
        // System.out.println(blockVar);  // ❌ 错误：超出作用域
        
        System.out.println(localVar);  // ✅ 可以访问
    }
}
```

**注意事项**：
- 局部变量必须在使用前初始化
- 作用域仅限于声明它的代码块
- 不同代码块可以有同名局部变量

```java
public void example() {
    int x = 10;
    if (true) {
        int x = 20;  // ❌ 错误：不能与外部变量同名
    }
}

public void example2() {
    if (true) {
        int x = 10;
    }
    if (true) {
        int x = 20;  // ✅ 正确：不同代码块可以同名
    }
}
```

### 成员变量（实例变量）

**特点**：
- 在类中声明，不在方法中
- 属于对象实例，每个对象有独立的副本
- 有默认值（数值类型为 0，布尔为 false，引用为 null）
- 可以使用访问修饰符

```java
public class Student {
    // 成员变量（实例变量）
    private String name;      // 默认值：null
    private int age;          // 默认值：0
    private boolean active;   // 默认值：false
    
    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    public void display() {
        System.out.println("姓名：" + name + "，年龄：" + age);
    }
}
```

**使用示例**：

```java
Student student1 = new Student("张三", 20);
Student student2 = new Student("李四", 22);

// 每个对象有独立的成员变量
student1.display();  // 姓名：张三，年龄：20
student2.display();  // 姓名：李四，年龄：22
```

### 静态变量（类变量）

**特点**：
- 用 `static` 关键字修饰
- 属于类，所有对象共享
- 可以通过类名直接访问
- 在类加载时初始化

```java
public class Counter {
    // 静态变量（类变量）
    private static int count = 0;  // 所有对象共享
    
    // 成员变量（实例变量）
    private int id;
    
    public Counter() {
        count++;  // 每次创建对象，count 增加
        this.id = count;
    }
    
    public static int getCount() {
        return count;  // 静态方法访问静态变量
    }
    
    public int getId() {
        return id;
    }
}

// 使用
Counter c1 = new Counter();
Counter c2 = new Counter();
Counter c3 = new Counter();

System.out.println(Counter.getCount());  // 3（所有对象共享）
System.out.println(c1.getId());  // 1
System.out.println(c2.getId());  // 2
System.out.println(c3.getId());  // 3
```

**静态变量的常见用途**：
- 常量定义
- 计数器
- 共享配置

```java
public class Constants {
    // 静态常量
    public static final int MAX_SIZE = 100;
    public static final String DEFAULT_NAME = "Unknown";
    public static final double PI = 3.14159;
}
```

## final 常量定义与使用

### final 关键字

`final` 关键字用于声明常量，表示值不能被修改。

### final 变量

**特点**：
- 一旦赋值，不能修改
- 必须在声明时或构造方法中初始化
- 命名通常使用全大写

```java
public class Example {
    // final 成员变量
    private final int value = 10;  // 声明时初始化
    
    private final String name;
    
    public Example(String name) {
        this.name = name;  // 构造方法中初始化
    }
    
    public void method() {
        // final 局部变量
        final int localFinal = 20;
        // localFinal = 30;  // ❌ 错误：不能修改
    }
}
```

### final 常量

**静态常量**：使用 `static final` 组合

```java
public class Constants {
    // 静态常量（类常量）
    public static final int MAX_SIZE = 100;
    public static final String APP_NAME = "MyApp";
    public static final double PI = 3.14159;
    
    // 使用
    public void method() {
        int size = Constants.MAX_SIZE;
        System.out.println(Constants.APP_NAME);
    }
}
```

**命名规范**：
- 全大写字母
- 多个单词用下划线分隔
- 通常声明为 `public static final`

### final 的作用

1. **防止修改**：确保值不被意外修改
2. **提高可读性**：明确表示这是常量
3. **编译器优化**：编译器可以进行优化

## 变量作用域与生命周期

### 作用域（Scope）

**作用域**是变量可以访问的范围。

#### 1. 类作用域

成员变量和静态变量在整个类中都可以访问。

```java
public class Example {
    private int memberVar = 10;  // 类作用域
    private static int staticVar = 20;  // 类作用域
    
    public void method1() {
        System.out.println(memberVar);   // ✅ 可以访问
        System.out.println(staticVar);   // ✅ 可以访问
    }
    
    public void method2() {
        System.out.println(memberVar);   // ✅ 可以访问
        System.out.println(staticVar);   // ✅ 可以访问
    }
}
```

#### 2. 方法作用域

局部变量只在声明它的方法中有效。

```java
public class Example {
    public void method1() {
        int localVar = 10;  // 方法作用域
        System.out.println(localVar);  // ✅ 可以访问
    }
    
    public void method2() {
        // System.out.println(localVar);  // ❌ 错误：不能访问
    }
}
```

#### 3. 代码块作用域

在代码块中声明的变量只在代码块中有效。

```java
public class Example {
    public void method() {
        int x = 10;
        
        if (true) {
            int y = 20;  // 代码块作用域
            System.out.println(x);  // ✅ 可以访问外部变量
            System.out.println(y);  // ✅ 可以访问
        }
        
        // System.out.println(y);  // ❌ 错误：超出作用域
        System.out.println(x);  // ✅ 可以访问
    }
}
```

### 生命周期（Lifetime）

**生命周期**是变量存在的时间。

#### 1. 局部变量的生命周期

- **开始**：变量声明时
- **结束**：方法执行完毕或代码块结束
- **存储**：栈内存

```java
public void method() {
    int x = 10;  // 生命周期开始
    // 使用 x
}  // 生命周期结束，x 被销毁
```

#### 2. 成员变量的生命周期

- **开始**：对象创建时
- **结束**：对象被垃圾回收时
- **存储**：堆内存

```java
Student student = new Student();  // 成员变量生命周期开始
// 使用 student
student = null;  // 对象可以被垃圾回收，成员变量生命周期可能结束
```

#### 3. 静态变量的生命周期

- **开始**：类加载时
- **结束**：程序结束或类被卸载
- **存储**：方法区（元空间）

```java
public class Example {
    static int count = 0;  // 类加载时初始化，程序结束时销毁
}
```

### 变量遮蔽（Variable Shadowing）

当局部变量与成员变量同名时，局部变量会遮蔽成员变量。

```java
public class Example {
    private int value = 10;  // 成员变量
    
    public void method() {
        int value = 20;  // 局部变量遮蔽成员变量
        System.out.println(value);  // 输出：20（局部变量）
        System.out.println(this.value);  // 输出：10（成员变量）
    }
}
```

**使用 `this` 访问成员变量**：

```java
public class Student {
    private String name;
    
    public Student(String name) {
        this.name = name;  // this.name 是成员变量，name 是参数
    }
}
```

## 实际示例

### 示例 1：变量类型对比

```java
public class VariableExample {
    // 静态变量（类变量）
    private static int classCount = 0;
    
    // 成员变量（实例变量）
    private int instanceId;
    private String name;
    
    public VariableExample(String name) {
        this.name = name;
        classCount++;
        this.instanceId = classCount;
    }
    
    public void method() {
        // 局部变量
        int localVar = 100;
        System.out.println("局部变量：" + localVar);
        System.out.println("成员变量 name：" + this.name);
        System.out.println("成员变量 instanceId：" + this.instanceId);
        System.out.println("静态变量 classCount：" + classCount);
    }
    
    public static void main(String[] args) {
        VariableExample obj1 = new VariableExample("对象1");
        VariableExample obj2 = new VariableExample("对象2");
        
        obj1.method();
        obj2.method();
        
        System.out.println("类变量（所有对象共享）：" + VariableExample.classCount);
    }
}
```

### 示例 2：常量使用

```java
public class Circle {
    // 常量
    public static final double PI = 3.14159;
    private static final int DEFAULT_RADIUS = 1;
    
    private final int radius;  // final 成员变量
    
    public Circle(int radius) {
        this.radius = radius > 0 ? radius : DEFAULT_RADIUS;
    }
    
    public double getArea() {
        return PI * radius * radius;
    }
    
    public double getCircumference() {
        return 2 * PI * radius;
    }
    
    public static void main(String[] args) {
        Circle circle = new Circle(5);
        System.out.println("面积：" + circle.getArea());
        System.out.println("周长：" + circle.getCircumference());
        System.out.println("PI 值：" + Circle.PI);
    }
}
```

### 示例 3：作用域示例

```java
public class ScopeExample {
    private int x = 10;  // 成员变量，类作用域
    
    public void method1() {
        int y = 20;  // 局部变量，方法作用域
        
        if (true) {
            int z = 30;  // 局部变量，代码块作用域
            System.out.println("x = " + x);  // ✅ 可以访问成员变量
            System.out.println("y = " + y);  // ✅ 可以访问方法变量
            System.out.println("z = " + z);  // ✅ 可以访问代码块变量
        }
        
        // System.out.println(z);  // ❌ 错误：z 超出作用域
        System.out.println("x = " + x);  // ✅ 可以访问成员变量
        System.out.println("y = " + y);  // ✅ 可以访问方法变量
    }
    
    public void method2() {
        System.out.println("x = " + x);  // ✅ 可以访问成员变量
        // System.out.println(y);  // ❌ 错误：y 在 method1 中，不能访问
    }
}
```

## 小结

Java 变量与常量要点：

- **变量类型**：局部变量、成员变量、静态变量
- **常量定义**：使用 `final` 关键字，通常 `static final`
- **作用域**：变量可以访问的范围
- **生命周期**：变量存在的时间
- **变量遮蔽**：局部变量可以遮蔽成员变量

**关键要点**：
- 局部变量必须初始化，作用域限于代码块
- 成员变量属于对象，有默认值
- 静态变量属于类，所有对象共享
- 使用 `final` 定义常量，防止修改
- 使用 `this` 访问被遮蔽的成员变量

理解了变量的类型和作用域，你就能正确地使用变量。在下一章，我们将学习 Java 的包装类。
