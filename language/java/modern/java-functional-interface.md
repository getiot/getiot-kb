---
sidebar_position: 2
slug: /java-functional-interface
sidebar_label: Java 函数式接口
---

# Java 函数式接口

函数式接口是 Lambda 表达式的基础。理解函数式接口的使用是掌握函数式编程的关键。本章将详细介绍 Java 中的函数式接口。

## @FunctionalInterface 注解

### 什么是函数式接口

**函数式接口**是只有一个抽象方法的接口，可以用 Lambda 表达式实现。

```java
@FunctionalInterface
public interface MyFunction {
    int apply(int x, int y);
}
```

### @FunctionalInterface 注解

**`@FunctionalInterface`** 注解用于标识函数式接口，不是必需的，但推荐使用。

**作用**：

- 明确标识函数式接口
- 编译时检查：如果不是函数式接口会报错
- 文档说明：表明接口的用途

```java
@FunctionalInterface
public interface Calculator {
    int calculate(int a, int b);
    
    // 可以有默认方法
    default void print() {
        System.out.println("计算器");
    }
    
    // 可以有静态方法
    static Calculator add() {
        return (a, b) -> a + b;
    }
}
```

## 四大核心函数式接口

`Predicate`、`Function`、`Consumer`、`Supplier` 是 Java 8 中 `java.util.function` 包下的四大核心函数式接口，它们分别代表了**判断**（接受参数返回布尔）、**转换**（接受参数返回不同类型结果）、**消费**（接受参数无返回值）和**供给**（不接受参数返回结果）这四种基本操作，极大地简化了函数式编程和 Lambda 表达式的应用，常见于流式操作 (Stream API)。 

### Predicate（断言）

**`Predicate<T>`** 用于判断条件，返回 boolean。

```java
import java.util.function.Predicate;

// 判断字符串是否为空
Predicate<String> isEmpty = s -> s.isEmpty();
boolean result = isEmpty.test("");  // true

// 判断数字是否大于 10
Predicate<Integer> greaterThan10 = n -> n > 10;
boolean result2 = greaterThan10.test(15);  // true

// 组合 Predicate
Predicate<Integer> greaterThan10 = n -> n > 10;
Predicate<Integer> lessThan20 = n -> n < 20;
Predicate<Integer> between10And20 = greaterThan10.and(lessThan20);
boolean result3 = between10And20.test(15);  // true
```

**常用方法**：
- `test(T t)`：测试条件
- `and(Predicate other)`：逻辑与
- `or(Predicate other)`：逻辑或
- `negate()`：逻辑非

### Function（函数）

**`Function<T, R>`** 用于转换，输入类型 T，返回类型 R。

```java
import java.util.function.Function;

// 字符串转整数
Function<String, Integer> parseInt = s -> Integer.parseInt(s);
Integer num = parseInt.apply("123");  // 123

// 整数转字符串
Function<Integer, String> toString = i -> String.valueOf(i);
String str = toString.apply(123);  // "123"

// 组合 Function
Function<String, Integer> parseInt = Integer::parseInt;
Function<Integer, Integer> doubleIt = n -> n * 2;
Function<String, Integer> parseAndDouble = parseInt.andThen(doubleIt);
Integer result = parseAndDouble.apply("5");  // 10
```

**常用方法**：
- `apply(T t)`：应用函数
- `compose(Function before)`：先执行 before，再执行当前函数
- `andThen(Function after)`：先执行当前函数，再执行 after

### Consumer（消费者）

**`Consumer<T>`** 用于消费数据，无返回值。

```java
import java.util.function.Consumer;

// 打印字符串
Consumer<String> printer = s -> System.out.println(s);
printer.accept("Hello");  // 输出：Hello

// 修改对象
Consumer<List<String>> addPrefix = list -> {
    for (int i = 0; i < list.size(); i++) {
        list.set(i, "前缀_" + list.get(i));
    }
};

List<String> names = new ArrayList<>(Arrays.asList("张三", "李四"));
addPrefix.accept(names);
// names 变为：["前缀_张三", "前缀_李四"]
```

**常用方法**：
- `accept(T t)`：消费数据
- `andThen(Consumer after)`：先执行当前，再执行 after

### Supplier（供应者）

**`Supplier<T>`** 用于提供数据，无参数，返回类型 T。

```java
import java.util.function.Supplier;

// 提供随机数
Supplier<Integer> randomInt = () -> new Random().nextInt(100);
Integer num = randomInt.get();  // 随机数

// 提供当前时间
Supplier<String> currentTime = () -> LocalDateTime.now().toString();
String time = currentTime.get();  // 当前时间字符串

// 提供默认值
Supplier<String> defaultValue = () -> "默认值";
String value = defaultValue.get();  // "默认值"
```

**常用方法**：
- `get()`：获取数据

## 示例：集合处理

### 示例 1：使用 Predicate 过滤

```java
import java.util.*;
import java.util.function.Predicate;
import java.util.stream.Collectors;

List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

// 过滤偶数
Predicate<Integer> isEven = n -> n % 2 == 0;
List<Integer> evens = numbers.stream()
    .filter(isEven)
    .collect(Collectors.toList());
// 结果：[2, 4, 6, 8, 10]

// 过滤大于 5 的数
Predicate<Integer> greaterThan5 = n -> n > 5;
List<Integer> greater = numbers.stream()
    .filter(greaterThan5)
    .collect(Collectors.toList());
// 结果：[6, 7, 8, 9, 10]

// 组合条件：偶数且大于 5
Predicate<Integer> evenAndGreater = isEven.and(greaterThan5);
List<Integer> result = numbers.stream()
    .filter(evenAndGreater)
    .collect(Collectors.toList());
// 结果：[6, 8, 10]
```

### 示例 2：使用 Function 转换

```java
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

List<String> names = Arrays.asList("张三", "李四", "王五");

// 转换为大写
Function<String, String> toUpperCase = String::toUpperCase;
List<String> upperNames = names.stream()
    .map(toUpperCase)
    .collect(Collectors.toList());
// 结果：["张三", "李四", "王五"]

// 获取长度
Function<String, Integer> length = String::length;
List<Integer> lengths = names.stream()
    .map(length)
    .collect(Collectors.toList());
// 结果：[2, 2, 2]

// 组合转换：先转大写，再获取长度
Function<String, Integer> upperThenLength = toUpperCase.andThen(length);
List<Integer> result = names.stream()
    .map(upperThenLength)
    .collect(Collectors.toList());
```

### 示例 3：使用 Consumer 处理

```java
import java.util.*;
import java.util.function.Consumer;

List<String> names = Arrays.asList("张三", "李四", "王五");

// 打印每个元素
Consumer<String> printer = System.out::println;
names.forEach(printer);

// 添加到另一个列表
List<String> result = new ArrayList<>();
Consumer<String> adder = result::add;
names.forEach(adder);
// result: ["张三", "李四", "王五"]

// 组合操作：先打印，再添加
Consumer<String> printAndAdd = printer.andThen(adder);
names.forEach(printAndAdd);
```

### 示例 4：使用 Supplier 生成

```java
import java.util.*;
import java.util.function.Supplier;
import java.util.stream.Stream;

// 生成随机数
Supplier<Integer> randomSupplier = () -> new Random().nextInt(100);
List<Integer> randomNumbers = Stream.generate(randomSupplier)
    .limit(10)
    .collect(Collectors.toList());

// 生成固定值
Supplier<String> fixedSupplier = () -> "固定值";
List<String> fixedValues = Stream.generate(fixedSupplier)
    .limit(5)
    .collect(Collectors.toList());
// 结果：["固定值", "固定值", "固定值", "固定值", "固定值"]
```

### 示例 5：综合使用

```java
import java.util.*;
import java.util.function.*;
import java.util.stream.Collectors;

public class FunctionalInterfaceExample {
    public static void main(String[] args) {
        List<Person> persons = Arrays.asList(
            new Person("张三", 25),
            new Person("李四", 20),
            new Person("王五", 30),
            new Person("赵六", 18)
        );
        
        // Predicate：过滤年龄大于 20 的人
        Predicate<Person> ageGreaterThan20 = p -> p.getAge() > 20;
        
        // Function：提取姓名
        Function<Person, String> getName = Person::getName;
        
        // Consumer：打印
        Consumer<String> printer = System.out::println;
        
        // 组合使用
        persons.stream()
            .filter(ageGreaterThan20)
            .map(getName)
            .forEach(printer);
        // 输出：张三、王五
    }
}

class Person {
    private String name;
    private int age;
    
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    public String getName() { return name; }
    public int getAge() { return age; }
}
```

## 其他常用函数式接口

### BiFunction

**`BiFunction<T, U, R>`**：接受两个参数，返回一个结果。

```java
import java.util.function.BiFunction;

BiFunction<Integer, Integer, Integer> add = (a, b) -> a + b;
Integer result = add.apply(3, 4);  // 7
```

### UnaryOperator

**`UnaryOperator<T>`**：接受一个参数，返回同类型结果（`Function<T, T>` 的特化）。

```java
import java.util.function.UnaryOperator;

UnaryOperator<String> toUpperCase = String::toUpperCase;
String result = toUpperCase.apply("hello");  // "HELLO"
```

### BinaryOperator

**`BinaryOperator<T>`**：接受两个同类型参数，返回同类型结果（`BiFunction<T, T, T>` 的特化）。

```java
import java.util.function.BinaryOperator;

BinaryOperator<Integer> add = (a, b) -> a + b;
Integer result = add.apply(3, 4);  // 7
```

## 自定义函数式接口

```java
@FunctionalInterface
public interface TriFunction<T, U, V, R> {
    R apply(T t, U u, V v);
}

// 使用
TriFunction<Integer, Integer, Integer, Integer> addThree = (a, b, c) -> a + b + c;
Integer result = addThree.apply(1, 2, 3);  // 6
```

## 小结

Java 函数式接口要点：

- **@FunctionalInterface**：标识函数式接口
- **Predicate**：判断条件，返回 boolean
- **Function**：转换函数，输入 T 返回 R
- **Consumer**：消费数据，无返回值
- **Supplier**：提供数据，无参数

**关键要点**：
- 函数式接口只有一个抽象方法
- 可以使用 @FunctionalInterface 注解
- 常用函数式接口：Predicate、Function、Consumer、Supplier
- 可以组合使用函数式接口
- 可以自定义函数式接口

理解了函数式接口，你就能更好地使用 Lambda 表达式。在下一章，我们将学习 Java Stream API。
