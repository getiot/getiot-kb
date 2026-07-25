---
sidebar_position: 13
slug: /java-inner-classes
sidebar_label: Java 内部类
---

# Java 内部类

内部类是定义在另一个类内部的类。Java 支持多种类型的内部类，每种类型有不同的用途和特性。理解内部类的使用是掌握 Java 高级特性的关键。本章将详细介绍 Java 中的内部类。

## 内部类的类型

Java 中有四种类型的内部类：

1. **成员内部类（Member Inner Class）**
2. **静态内部类（Static Nested Class）**
3. **局部内部类（Local Inner Class）**
4. **匿名内部类（Anonymous Inner Class）**

## 成员内部类

### 定义

**成员内部类**是定义在类中的非静态内部类。

```java
public class Outer {
    private String outerField = "外部类字段";
    
    // 成员内部类
    public class Inner {
        private String innerField = "内部类字段";
        
        public void display() {
            System.out.println(outerField);  // 可以访问外部类成员
            System.out.println(innerField);
        }
    }
    
    public void createInner() {
        Inner inner = new Inner();  // 外部类中创建内部类
        inner.display();
    }
}

// 使用
Outer outer = new Outer();
Outer.Inner inner = outer.new Inner();  // 通过外部类实例创建
inner.display();
```

### 特点

1. **可以访问外部类所有成员**：包括私有成员
2. **不能有静态成员**：成员内部类不能有静态变量和静态方法（除非是常量）
3. **需要外部类实例**：创建内部类需要外部类实例

## 静态内部类

### 定义

**静态内部类**是用 `static` 修饰的内部类。

```java
public class Outer {
    private static String staticField = "静态字段";
    private String instanceField = "实例字段";
    
    // 静态内部类
    public static class StaticInner {
        public void display() {
            System.out.println(staticField);  // 可以访问静态成员
            // System.out.println(instanceField);  // ❌ 不能访问实例成员
        }
        
        public static void staticMethod() {
            System.out.println("静态内部类的静态方法");
        }
    }
}

// 使用：不需要外部类实例
Outer.StaticInner inner = new Outer.StaticInner();
inner.display();
Outer.StaticInner.staticMethod();
```

### 特点

1. **可以访问外部类静态成员**：不能访问实例成员
2. **可以有静态成员**：可以有静态变量和静态方法
3. **不需要外部类实例**：可以直接创建

## 局部内部类

### 定义

**局部内部类**是定义在方法或代码块中的类。

```java
public class Outer {
    private String outerField = "外部类字段";
    
    public void method() {
        final String localVar = "局部变量";  // 必须是 final 或 effectively final
        
        // 局部内部类
        class LocalInner {
            public void display() {
                System.out.println(outerField);  // 可以访问外部类成员
                System.out.println(localVar);     // 可以访问局部变量（必须是 final）
            }
        }
        
        LocalInner inner = new LocalInner();
        inner.display();
    }
}
```

### 特点

1. **作用域限制**：只能在定义它的方法或代码块中使用
2. **可以访问外部类成员**：包括私有成员
3. **可以访问局部变量**：但必须是 final 或 effectively final
4. **不能有访问修饰符**：局部内部类不能有 public、private 等修饰符

## 匿名内部类

### 定义

**匿名内部类**是没有名字的内部类，通常用于实现接口或继承类。

```java
// 接口
public interface Animal {
    void makeSound();
}

// 使用匿名内部类
Animal animal = new Animal() {
    @Override
    public void makeSound() {
        System.out.println("匿名内部类实现");
    }
};

animal.makeSound();
```

### 实现接口

```java
public interface Runnable {
    void run();
}

// 匿名内部类实现接口
Runnable task = new Runnable() {
    @Override
    public void run() {
        System.out.println("执行任务");
    }
};

task.run();
```

### 继承类

```java
public class Animal {
    public void makeSound() {
        System.out.println("动物发出声音");
    }
}

// 匿名内部类继承类
Animal animal = new Animal() {
    @Override
    public void makeSound() {
        System.out.println("匿名内部类重写方法");
    }
};

animal.makeSound();
```

### Lambda 表达式替代

**Java 8+ 可以使用 Lambda 表达式替代匿名内部类**：

```java
// 匿名内部类
Runnable task1 = new Runnable() {
    @Override
    public void run() {
        System.out.println("任务");
    }
};

// Lambda 表达式（更简洁）
Runnable task2 = () -> System.out.println("任务");
```

## 内部类的使用场景

### 1. 逻辑分组

**将相关的类组织在一起**：

```java
public class LinkedList {
    // 节点内部类
    private class Node {
        Object data;
        Node next;
        
        Node(Object data) {
            this.data = data;
        }
    }
    
    private Node head;
    // ...
}
```

### 2. 访问控制

**内部类可以访问外部类的私有成员**：

```java
public class Outer {
    private String secret = "秘密";
    
    public class Inner {
        public void accessSecret() {
            System.out.println(secret);  // 可以访问私有成员
        }
    }
}
```

### 3. 回调函数

**使用匿名内部类实现回调**：

```java
public class Button {
    private OnClickListener listener;
    
    public void setOnClickListener(OnClickListener listener) {
        this.listener = listener;
    }
    
    public void click() {
        if (listener != null) {
            listener.onClick();
        }
    }
    
    public interface OnClickListener {
        void onClick();
    }
}

// 使用匿名内部类
Button button = new Button();
button.setOnClickListener(new Button.OnClickListener() {
    @Override
    public void onClick() {
        System.out.println("按钮被点击");
    }
});
```

## 实际示例

### 示例 1：成员内部类

```java
public class BankAccount {
    private double balance;
    
    // 成员内部类：交易记录
    public class Transaction {
        private String type;
        private double amount;
        private String timestamp;
        
        public Transaction(String type, double amount) {
            this.type = type;
            this.amount = amount;
            this.timestamp = java.time.LocalDateTime.now().toString();
        }
        
        public void display() {
            System.out.println("类型：" + type);
            System.out.println("金额：" + amount);
            System.out.println("余额：" + balance);  // 访问外部类成员
            System.out.println("时间：" + timestamp);
        }
    }
    
    public void deposit(double amount) {
        balance += amount;
        Transaction transaction = new Transaction("存款", amount);
        transaction.display();
    }
}

// 使用
BankAccount account = new BankAccount();
account.deposit(1000);
```

### 示例 2：静态内部类

```java
public class MathUtils {
    // 静态内部类：复数
    public static class Complex {
        private double real;
        private double imaginary;
        
        public Complex(double real, double imaginary) {
            this.real = real;
            this.imaginary = imaginary;
        }
        
        public Complex add(Complex other) {
            return new Complex(real + other.real, imaginary + other.imaginary);
        }
        
        @Override
        public String toString() {
            return real + " + " + imaginary + "i";
        }
    }
}

// 使用
MathUtils.Complex c1 = new MathUtils.Complex(1, 2);
MathUtils.Complex c2 = new MathUtils.Complex(3, 4);
MathUtils.Complex sum = c1.add(c2);
System.out.println(sum);
```

### 示例 3：匿名内部类

```java
public class EventHandler {
    public interface EventListener {
        void onEvent(String event);
    }
    
    private EventListener listener;
    
    public void setListener(EventListener listener) {
        this.listener = listener;
    }
    
    public void triggerEvent(String event) {
        if (listener != null) {
            listener.onEvent(event);
        }
    }
}

// 使用匿名内部类
EventHandler handler = new EventHandler();
handler.setListener(new EventHandler.EventListener() {
    @Override
    public void onEvent(String event) {
        System.out.println("事件：" + event);
    }
});

handler.triggerEvent("点击");
```

## 内部类的注意事项

### 1. 成员内部类不能有静态成员

```java
public class Outer {
    public class Inner {
        // ❌ 错误：不能有静态变量
        // private static int count;
        
        // ✅ 正确：可以有静态常量
        private static final int MAX = 100;
    }
}
```

### 2. 局部内部类访问的局部变量必须是 final

```java
public void method() {
    final int x = 10;  // 必须是 final
    // int y = 20;     // effectively final 也可以
    
    class LocalInner {
        public void display() {
            System.out.println(x);  // ✅ 可以访问
            // System.out.println(y);  // ✅ 也可以访问（effectively final）
        }
    }
}
```

### 3. 内部类编译后的文件

**内部类编译后会生成独立的 .class 文件**：

```
Outer.class
Outer$Inner.class          // 成员内部类
Outer$StaticInner.class    // 静态内部类
Outer$1LocalInner.class    // 局部内部类
Outer$1.class              // 匿名内部类
```

## 小结

Java 内部类要点：

- **四种类型**：成员内部类、静态内部类、局部内部类、匿名内部类
- **访问权限**：可以访问外部类成员，局部内部类访问局部变量需 final
- **使用场景**：逻辑分组、访问控制、回调函数
- **编译结果**：生成独立的 .class 文件

**关键要点**：
- 成员内部类需要外部类实例
- 静态内部类不需要外部类实例
- 局部内部类作用域受限
- 匿名内部类用于一次性实现
- Lambda 表达式可以替代某些匿名内部类

理解了内部类，你就能更好地组织代码结构。在下一章，我们将学习 Java 的枚举。
