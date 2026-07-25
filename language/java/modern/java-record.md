---
sidebar_position: 6
slug: /java-record
sidebar_label: Java 记录类
---

# Java 记录类（record）

记录类（record）是 Java 14 引入的预览特性，在 Java 16 中正式发布。记录类用于创建不可变的数据对象，简化了 POJO 的编写。本章将详细介绍 Java 中的记录类。

## record 定义与语法

### 什么是记录类

**记录类**（record）是一种特殊的类，用于表示不可变的数据对象。

**特点**：
- 自动生成构造函数、getter、equals、hashCode、toString
- 不可变（所有字段都是 final）
- 简洁的语法

### 基本语法

```java
// 传统 POJO
public class Person {
    private final String name;
    private final int age;
    
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    public String getName() { return name; }
    public int getAge() { return age; }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Person person = (Person) o;
        return age == person.age && Objects.equals(name, person.name);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(name, age);
    }
    
    @Override
    public String toString() {
        return "Person{name='" + name + "', age=" + age + "}";
    }
}

// 使用 record（简洁）
public record Person(String name, int age) {
}
```

### record 的组成部分

```java
public record Person(String name, int age) {
    // 1. 记录头：定义组件（components）
    // 2. 记录体：可以添加方法、构造函数等
}
```

## 不可变数据对象

### 不可变性

**记录类的所有字段都是 final 的，创建后不能修改**。

```java
public record Point(int x, int y) {
}

// 使用
Point p = new Point(10, 20);
// p.x = 30;  // 编译错误：不能修改

// 创建新对象
Point p2 = new Point(30, 40);
```

### 自动生成的方法

**记录类自动生成以下方法**：

```java
public record Person(String name, int age) {
}

Person person = new Person("张三", 25);

// 1. 构造函数
Person p = new Person("张三", 25);

// 2. 访问器方法（不是 getter，直接使用字段名）
String name = person.name();  // 不是 getName()
int age = person.age();       // 不是 getAge()

// 3. equals
Person p1 = new Person("张三", 25);
Person p2 = new Person("张三", 25);
boolean equal = p1.equals(p2);  // true

// 4. hashCode
int hash = person.hashCode();

// 5. toString
String str = person.toString();  
// 结果："Person[name=张三, age=25]"
```

## 示例：简化 POJO

### 示例 1：基本记录类

```java
public record Student(String name, int age, String major) {
}

// 使用
Student student = new Student("张三", 20, "计算机科学");
System.out.println(student.name());   // "张三"
System.out.println(student.age());    // 20
System.out.println(student.major());  // "计算机科学"
System.out.println(student);          // "Student[name=张三, age=20, major=计算机科学]"
```

### 示例 2：自定义构造函数

```java
public record Person(String name, int age) {
    // 紧凑构造函数（canonical constructor）
    public Person {
        if (age < 0) {
            throw new IllegalArgumentException("年龄不能为负数");
        }
        if (name == null || name.isEmpty()) {
            throw new IllegalArgumentException("姓名不能为空");
        }
    }
    
    // 或使用完整构造函数
    // public Person(String name, int age) {
    //     this.name = name;
    //     this.age = age;
    // }
}

// 使用
Person person = new Person("张三", 25);  // 正常
// Person person2 = new Person("", -1);  // 抛出异常
```

### 示例 3：添加方法

```java
public record Point(int x, int y) {
    // 添加实例方法
    public double distance() {
        return Math.sqrt(x * x + y * y);
    }
    
    // 添加静态方法
    public static Point origin() {
        return new Point(0, 0);
    }
    
    // 添加实例方法
    public Point move(int dx, int dy) {
        return new Point(x + dx, y + dy);
    }
}

// 使用
Point p = new Point(3, 4);
double dist = p.distance();  // 5.0
Point origin = Point.origin();
Point moved = p.move(1, 1);  // Point[x=4, y=5]
```

### 示例 4：嵌套记录

```java
public record Address(String street, String city, String zipCode) {
}

public record Person(String name, int age, Address address) {
}

// 使用
Address addr = new Address("中关村大街", "北京", "100000");
Person person = new Person("张三", 25, addr);
System.out.println(person.address().city());  // "北京"
```

### 示例 5：实现接口

```java
public interface Drawable {
    void draw();
}

public record Circle(int radius) implements Drawable {
    @Override
    public void draw() {
        System.out.println("绘制半径为 " + radius + " 的圆");
    }
}

// 使用
Circle circle = new Circle(10);
circle.draw();  // "绘制半径为 10 的圆"
```

### 示例 6：与集合结合

```java
import java.util.*;

public record Student(String name, int score) {
}

// 使用
List<Student> students = Arrays.asList(
    new Student("张三", 85),
    new Student("李四", 90),
    new Student("王五", 80)
);

// 排序
students.sort(Comparator.comparing(Student::score).reversed());

// 过滤
List<Student> highScores = students.stream()
    .filter(s -> s.score() >= 85)
    .toList();

// 分组
Map<Integer, List<Student>> byScore = students.stream()
    .collect(Collectors.groupingBy(Student::score));
```

### 示例 7：模式匹配（Java 16+）

```java
public record Point(int x, int y) {
}

// 使用 instanceof 模式匹配
Object obj = new Point(10, 20);
if (obj instanceof Point p) {
    System.out.println("x = " + p.x() + ", y = " + p.y());
}

// 使用 switch 表达式（Java 17+）
String result = switch (obj) {
    case Point p -> "点: (" + p.x() + ", " + p.y() + ")";
    case String s -> "字符串: " + s;
    default -> "其他";
};
```

## 记录类 vs 传统类

### 对比

| 特性 | 记录类 | 传统类 |
|:----:|:------:|:------:|
| 不可变性 | 自动 | 需要手动实现 |
| 构造函数 | 自动生成 | 需要手动编写 |
| getter | 自动生成（使用字段名） | 需要手动编写 |
| equals/hashCode | 自动生成 | 需要手动编写 |
| toString | 自动生成 | 需要手动编写 |
| 继承 | 不能继承其他类 | 可以继承 |
| 可变性 | 不可变 | 可以可变 |

### 何时使用记录类

**适合使用记录类**：
- 不可变数据对象
- 数据传输对象（DTO）
- 值对象（Value Object）
- 简单的数据容器

**不适合使用记录类**：
- 需要继承的类
- 需要可变状态的类
- 复杂的业务逻辑类

## 记录类的最佳实践

### 1. 使用记录类表示值对象

```java
// ✅ 推荐：使用 record 表示值对象
public record Money(double amount, String currency) {
    public Money {
        if (amount < 0) {
            throw new IllegalArgumentException("金额不能为负数");
        }
    }
}
```

### 2. 添加验证逻辑

```java
public record Email(String address) {
    public Email {
        if (address == null || !address.contains("@")) {
            throw new IllegalArgumentException("无效的邮箱地址");
        }
    }
}
```

### 3. 添加便利方法

```java
public record Point(int x, int y) {
    public Point move(int dx, int dy) {
        return new Point(x + dx, y + dy);
    }
    
    public double distanceTo(Point other) {
        int dx = x - other.x;
        int dy = y - other.y;
        return Math.sqrt(dx * dx + dy * dy);
    }
}
```

### 4. 使用嵌套记录

```java
public record Address(String street, String city) {
}

public record Person(String name, Address address) {
}

// 使用
Person person = new Person("张三", 
    new Address("中关村大街", "北京"));
```

## 小结

Java 记录类要点：

- **record 语法**：`public record Name(components) { }`
- **不可变性**：所有字段都是 final
- **自动生成**：构造函数、访问器、equals、hashCode、toString
- **简化代码**：大幅减少样板代码
- **适用场景**：不可变数据对象、DTO、值对象

**关键要点**：
- record 用于创建不可变数据对象
- 自动生成常用方法
- 可以添加自定义构造函数和方法
- 不能继承其他类，但可以实现接口
- 适合表示值对象和 DTO

理解了记录类，你就能编写更简洁的数据类。恭喜你完成了第九部分的学习！
