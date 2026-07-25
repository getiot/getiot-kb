---
sidebar_position: 1
slug: /java-lambda
sidebar_label: Java Lambda 表达式
---

# Java Lambda 表达式

Lambda 表达式是 Java 8 引入的重要特性，它简化了函数式编程，使代码更加简洁。理解 Lambda 表达式的使用是现代 Java 开发的基础。本章将详细介绍 Java 中的 Lambda 表达式。

## Lambda 基本语法

### 什么是 Lambda 表达式

**Lambda 表达式**是一个匿名函数，可以理解为一段可以传递的代码。

**基本语法**：
```java
(参数列表) -> { 方法体 }
```

### Lambda 表达式的形式

```java
// 1. 无参数
() -> System.out.println("Hello");

// 2. 单个参数（可以省略括号）
x -> x * 2
(x) -> x * 2

// 3. 多个参数
(x, y) -> x + y

// 4. 方法体多条语句
(x, y) -> {
    int sum = x + y;
    return sum;
}

// 5. 有返回值的 Lambda
(x, y) -> x + y
```

### Lambda 表达式示例

```java
// 传统方式：匿名内部类
Runnable r1 = new Runnable() {
    @Override
    public void run() {
        System.out.println("Hello");
    }
};

// Lambda 表达式
Runnable r2 = () -> System.out.println("Hello");

// 使用
r1.run();
r2.run();
```

## 函数式接口使用

### 什么是函数式接口

**函数式接口**是只有一个抽象方法的接口，Lambda 表达式可以替代函数式接口的实例。

```java
@FunctionalInterface
public interface MyFunction {
    int apply(int x, int y);
}

// 使用 Lambda 表达式
MyFunction add = (x, y) -> x + y;
MyFunction multiply = (x, y) -> x * y;

int result1 = add.apply(3, 4);        // 7
int result2 = multiply.apply(3, 4);    // 12
```

### 常见的函数式接口

```java
import java.util.function.*;

// Predicate<T>：判断条件
Predicate<String> isEmpty = s -> s.isEmpty();
boolean result = isEmpty.test("");  // true

// Function<T, R>：转换函数
Function<String, Integer> length = s -> s.length();
int len = length.apply("Hello");  // 5

// Consumer<T>：消费数据
Consumer<String> printer = s -> System.out.println(s);
printer.accept("Hello");  // 输出：Hello

// Supplier<T>：提供数据
Supplier<String> supplier = () -> "Hello";
String value = supplier.get();  // "Hello"
```

## 简化匿名内部类

### 对比示例

**传统方式（匿名内部类）**：

```java
// 1. Runnable
Thread thread1 = new Thread(new Runnable() {
    @Override
    public void run() {
        System.out.println("线程执行");
    }
});

// 2. Comparator
List<String> list = Arrays.asList("b", "a", "c");
Collections.sort(list, new Comparator<String>() {
    @Override
    public int compare(String s1, String s2) {
        return s1.compareTo(s2);
    }
});

// 3. ActionListener
button.addActionListener(new ActionListener() {
    @Override
    public void actionPerformed(ActionEvent e) {
        System.out.println("按钮被点击");
    }
});
```

**Lambda 表达式方式**：

```java
// 1. Runnable
Thread thread2 = new Thread(() -> System.out.println("线程执行"));

// 2. Comparator
Collections.sort(list, (s1, s2) -> s1.compareTo(s2));

// 3. ActionListener
button.addActionListener(e -> System.out.println("按钮被点击"));
```

### 实际示例

#### 示例 1：集合操作

```java
import java.util.*;

List<String> names = Arrays.asList("张三", "李四", "王五");

// 传统方式：遍历
for (String name : names) {
    System.out.println(name);
}

// Lambda 方式：forEach
names.forEach(name -> System.out.println(name));

// 方法引用（更简洁）
names.forEach(System.out::println);
```

#### 示例 2：事件处理

```java
// 传统方式
button.addActionListener(new ActionListener() {
    @Override
    public void actionPerformed(ActionEvent e) {
        String text = textField.getText();
        System.out.println("输入：" + text);
    }
});

// Lambda 方式
button.addActionListener(e -> {
    String text = textField.getText();
    System.out.println("输入：" + text);
});
```

#### 示例 3：线程创建

```java
// 传统方式
new Thread(new Runnable() {
    @Override
    public void run() {
        for (int i = 0; i < 10; i++) {
            System.out.println(i);
        }
    }
}).start();

// Lambda 方式
new Thread(() -> {
    for (int i = 0; i < 10; i++) {
        System.out.println(i);
    }
}).start();
```

#### 示例 4：条件过滤

```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

// 传统方式：过滤偶数
List<Integer> evens = new ArrayList<>();
for (Integer num : numbers) {
    if (num % 2 == 0) {
        evens.add(num);
    }
}

// Lambda 方式（使用 Stream API）
List<Integer> evens2 = numbers.stream()
    .filter(n -> n % 2 == 0)
    .collect(Collectors.toList());
```

#### 示例 5：排序

```java
List<Person> persons = Arrays.asList(
    new Person("张三", 25),
    new Person("李四", 20),
    new Person("王五", 30)
);

// 传统方式：按年龄排序
Collections.sort(persons, new Comparator<Person>() {
    @Override
    public int compare(Person p1, Person p2) {
        return Integer.compare(p1.getAge(), p2.getAge());
    }
});

// Lambda 方式
Collections.sort(persons, (p1, p2) -> Integer.compare(p1.getAge(), p2.getAge()));

// 方法引用（更简洁）
Collections.sort(persons, Comparator.comparing(Person::getAge));
```

## Lambda 表达式的类型推断

### 类型推断

Java 编译器可以根据上下文推断 Lambda 表达式的类型。

```java
// 显式类型
Function<String, Integer> f1 = (String s) -> s.length();

// 类型推断
Function<String, Integer> f2 = s -> s.length();

// 复杂类型推断
Map<String, List<Integer>> map = new HashMap<>();
map.computeIfAbsent("key", k -> new ArrayList<>());
```

## Lambda 表达式的变量捕获

### 局部变量捕获

Lambda 表达式可以访问外部变量，但有规则：

```java
int x = 10;

// 可以访问 final 或 effectively final 的局部变量
Runnable r = () -> System.out.println(x);  // x 必须是 final 或 effectively final

// ❌ 错误：不能修改外部变量
// int y = 10;
// Runnable r2 = () -> y++;  // 编译错误

// ✅ 正确：使用 final
final int z = 10;
Runnable r3 = () -> System.out.println(z);
```

### 实例变量和静态变量

```java
public class LambdaScope {
    private int instanceVar = 10;
    private static int staticVar = 20;
    
    public void test() {
        // 可以访问和修改实例变量
        Runnable r1 = () -> {
            instanceVar = 100;  // 可以修改
            System.out.println(instanceVar);
        };
        
        // 可以访问和修改静态变量
        Runnable r2 = () -> {
            staticVar = 200;  // 可以修改
            System.out.println(staticVar);
        };
    }
}
```

## Lambda 表达式的最佳实践

### 1. 使用方法引用

```java
// ✅ 推荐：方法引用
list.forEach(System.out::println);

// ⚠️ 可以：Lambda 表达式
list.forEach(s -> System.out.println(s));
```

### 2. 保持简洁

```java
// ✅ 推荐：简洁的 Lambda
list.sort((a, b) -> a.compareTo(b));

// ❌ 不推荐：过于复杂
list.sort((a, b) -> {
    if (a == null && b == null) return 0;
    if (a == null) return -1;
    if (b == null) return 1;
    return a.compareTo(b);
});
```

### 3. 避免副作用

```java
// ⚠️ 注意：避免在 Lambda 中产生副作用
List<String> result = new ArrayList<>();
list.forEach(s -> result.add(s.toUpperCase()));  // 不推荐

// ✅ 推荐：使用 Stream API
List<String> result2 = list.stream()
    .map(String::toUpperCase)
    .collect(Collectors.toList());
```

## 小结

Java Lambda 表达式要点：

- **基本语法**：`(参数) -> { 方法体 }`
- **函数式接口**：只有一个抽象方法的接口
- **简化代码**：替代匿名内部类
- **类型推断**：编译器自动推断类型
- **变量捕获**：可以访问外部变量（有限制）

**关键要点**：
- Lambda 表达式是匿名函数
- 只能用于函数式接口
- 简化了匿名内部类
- 使用方法引用更简洁
- 注意变量捕获的规则

理解了 Lambda 表达式，你就能编写更简洁的代码。在下一章，我们将学习 Java 函数式接口。
