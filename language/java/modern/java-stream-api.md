---
sidebar_position: 3
slug: /java-stream-api
sidebar_label: Java Stream API
---

# Java Stream API

Stream API 是 Java 8 引入的强大特性，用于处理集合数据。理解 Stream API 的使用是进行函数式编程的关键。本章将详细介绍 Java 中的 Stream API。

## Stream 流概念

### 什么是 Stream

**Stream**是一个数据流，用于对集合进行函数式操作。

**特点**：
- **不存储数据**：Stream 不存储元素
- **函数式编程**：支持函数式操作
- **惰性求值**：中间操作是惰性的
- **可消费性**：只能消费一次

### Stream 的创建

```java
import java.util.*;
import java.util.stream.*;

// 从集合创建
List<String> list = Arrays.asList("a", "b", "c");
Stream<String> stream1 = list.stream();

// 从数组创建
String[] array = {"a", "b", "c"};
Stream<String> stream2 = Arrays.stream(array);

// 使用 Stream.of
Stream<String> stream3 = Stream.of("a", "b", "c");

// 使用 Stream.generate
Stream<String> stream4 = Stream.generate(() -> "hello").limit(5);

// 使用 Stream.iterate
Stream<Integer> stream5 = Stream.iterate(0, n -> n + 2).limit(10);

// 从文件创建
Stream<String> lines = Files.lines(Paths.get("file.txt"));
```

## 常用 Stream 方法

### filter（过滤）

**`filter`** 用于过滤元素。

```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

// 过滤偶数
List<Integer> evens = numbers.stream()
    .filter(n -> n % 2 == 0)
    .collect(Collectors.toList());
// 结果：[2, 4, 6, 8, 10]

// 过滤大于 5 的数
List<Integer> greater = numbers.stream()
    .filter(n -> n > 5)
    .collect(Collectors.toList());
// 结果：[6, 7, 8, 9, 10]
```

### map（映射）

**`map`** 用于转换元素。

```java
List<String> names = Arrays.asList("张三", "李四", "王五");

// 转换为大写
List<String> upperNames = names.stream()
    .map(String::toUpperCase)
    .collect(Collectors.toList());
// 结果：["张三", "李四", "王五"]

// 获取长度
List<Integer> lengths = names.stream()
    .map(String::length)
    .collect(Collectors.toList());
// 结果：[2, 2, 2]
```

### reduce（归约）

**`reduce`** 用于将流归约为一个值。

```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

// 求和
Optional<Integer> sum = numbers.stream()
    .reduce((a, b) -> a + b);
// 结果：Optional[15]

// 求和（带初始值）
Integer sum2 = numbers.stream()
    .reduce(0, (a, b) -> a + b);
// 结果：15

// 求最大值
Optional<Integer> max = numbers.stream()
    .reduce(Integer::max);
// 结果：Optional[5]
```

### collect（收集）

**`collect`** 用于将流收集到集合中。

```java
import java.util.stream.Collectors;

List<String> names = Arrays.asList("张三", "李四", "王五");

// 收集到 List
List<String> list = names.stream()
    .collect(Collectors.toList());

// 收集到 Set
Set<String> set = names.stream()
    .collect(Collectors.toSet());

// 收集到 Map
Map<String, Integer> map = names.stream()
    .collect(Collectors.toMap(
        name -> name,
        String::length
    ));
// 结果：{"张三": 2, "李四": 2, "王五": 2}
```

## 并行流示例

### 并行流

**并行流**利用多核处理器并行处理数据。

```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

// 顺序流
long start1 = System.currentTimeMillis();
int sum1 = numbers.stream()
    .mapToInt(n -> n * n)
    .sum();
long end1 = System.currentTimeMillis();
System.out.println("顺序流耗时：" + (end1 - start1) + "ms");

// 并行流
long start2 = System.currentTimeMillis();
int sum2 = numbers.parallelStream()
    .mapToInt(n -> n * n)
    .sum();
long end2 = System.currentTimeMillis();
System.out.println("并行流耗时：" + (end2 - start2) + "ms");
```

### 并行流的注意事项

```java
// ⚠️ 注意：并行流不保证顺序
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

// 顺序流：保证顺序
numbers.stream()
    .forEachOrdered(System.out::println);
// 输出：1, 2, 3, 4, 5

// 并行流：不保证顺序
numbers.parallelStream()
    .forEach(System.out::println);
// 输出顺序可能不同
```

## Stream 的其他操作

### distinct（去重）

```java
List<Integer> numbers = Arrays.asList(1, 2, 2, 3, 3, 4, 5);

List<Integer> distinct = numbers.stream()
    .distinct()
    .collect(Collectors.toList());
// 结果：[1, 2, 3, 4, 5]
```

### sorted（排序）

```java
List<String> names = Arrays.asList("王五", "张三", "李四");

// 自然排序
List<String> sorted = names.stream()
    .sorted()
    .collect(Collectors.toList());
// 结果：["李四", "王五", "张三"]

// 自定义排序
List<String> customSorted = names.stream()
    .sorted((a, b) -> b.compareTo(a))  // 降序
    .collect(Collectors.toList());
```

### limit 和 skip

```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

// 取前 5 个
List<Integer> first5 = numbers.stream()
    .limit(5)
    .collect(Collectors.toList());
// 结果：[1, 2, 3, 4, 5]

// 跳过前 5 个
List<Integer> skip5 = numbers.stream()
    .skip(5)
    .collect(Collectors.toList());
// 结果：[6, 7, 8, 9, 10]
```

### flatMap（扁平化）

```java
List<List<Integer>> lists = Arrays.asList(
    Arrays.asList(1, 2, 3),
    Arrays.asList(4, 5, 6),
    Arrays.asList(7, 8, 9)
);

// 扁平化
List<Integer> flat = lists.stream()
    .flatMap(List::stream)
    .collect(Collectors.toList());
// 结果：[1, 2, 3, 4, 5, 6, 7, 8, 9]
```

### 终端操作

```java
List<String> names = Arrays.asList("张三", "李四", "王五");

// forEach：遍历
names.stream().forEach(System.out::println);

// count：计数
long count = names.stream().count();  // 3

// anyMatch：任意匹配
boolean hasZhang = names.stream()
    .anyMatch(s -> s.startsWith("张"));  // true

// allMatch：全部匹配
boolean allLength2 = names.stream()
    .allMatch(s -> s.length() == 2);  // true

// noneMatch：无匹配
boolean noZhao = names.stream()
    .noneMatch(s -> s.startsWith("赵"));  // true

// findFirst：查找第一个
Optional<String> first = names.stream()
    .findFirst();  // Optional["张三"]

// findAny：查找任意一个
Optional<String> any = names.stream()
    .findAny();
```

## 实际示例

### 示例 1：数据处理

```java
import java.util.*;
import java.util.stream.Collectors;

List<Person> persons = Arrays.asList(
    new Person("张三", 25, "男"),
    new Person("李四", 20, "女"),
    new Person("王五", 30, "男"),
    new Person("赵六", 18, "女")
);

// 过滤年龄大于 20 的人
List<Person> adults = persons.stream()
    .filter(p -> p.getAge() > 20)
    .collect(Collectors.toList());

// 获取所有姓名
List<String> names = persons.stream()
    .map(Person::getName)
    .collect(Collectors.toList());

// 按年龄分组
Map<Integer, List<Person>> byAge = persons.stream()
    .collect(Collectors.groupingBy(Person::getAge));

// 按性别分组
Map<String, List<Person>> byGender = persons.stream()
    .collect(Collectors.groupingBy(Person::getGender));
```

### 示例 2：统计操作

```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

// 求和
int sum = numbers.stream()
    .mapToInt(Integer::intValue)
    .sum();  // 55

// 平均值
OptionalDouble avg = numbers.stream()
    .mapToInt(Integer::intValue)
    .average();  // OptionalDouble[5.5]

// 最大值
OptionalInt max = numbers.stream()
    .mapToInt(Integer::intValue)
    .max();  // OptionalInt[10]

// 最小值
OptionalInt min = numbers.stream()
    .mapToInt(Integer::intValue)
    .min();  // OptionalInt[1]

// 统计信息
IntSummaryStatistics stats = numbers.stream()
    .mapToInt(Integer::intValue)
    .summaryStatistics();
// stats.getCount() = 10
// stats.getSum() = 55
// stats.getAverage() = 5.5
// stats.getMax() = 10
// stats.getMin() = 1
```

### 示例 3：字符串处理

```java
List<String> words = Arrays.asList("hello", "world", "java", "stream");

// 转换为大写并连接
String result = words.stream()
    .map(String::toUpperCase)
    .collect(Collectors.joining(", "));
// 结果："HELLO, WORLD, JAVA, STREAM"

// 过滤长度大于 4 的单词
List<String> longWords = words.stream()
    .filter(s -> s.length() > 4)
    .collect(Collectors.toList());
// 结果：["hello", "world", "stream"]
```

## Stream 的最佳实践

### 1. 使用链式调用

```java
// ✅ 推荐：链式调用
List<String> result = list.stream()
    .filter(s -> s.length() > 3)
    .map(String::toUpperCase)
    .sorted()
    .collect(Collectors.toList());
```

### 2. 避免副作用

```java
// ❌ 不推荐：在 Stream 中产生副作用
List<String> result = new ArrayList<>();
list.stream()
    .filter(s -> s.length() > 3)
    .forEach(result::add);

// ✅ 推荐：使用 collect
List<String> result2 = list.stream()
    .filter(s -> s.length() > 3)
    .collect(Collectors.toList());
```

### 3. 合理使用并行流

```java
// 大数据量时使用并行流
List<Integer> largeList = // ... 大量数据
List<Integer> result = largeList.parallelStream()
    .filter(n -> n % 2 == 0)
    .collect(Collectors.toList());
```

## 小结

Java Stream API 要点：

- **Stream 概念**：数据流，函数式操作
- **filter**：过滤元素
- **map**：转换元素
- **reduce**：归约为一个值
- **collect**：收集到集合
- **并行流**：利用多核并行处理

**关键要点**：
- Stream 不存储数据，只能消费一次
- 中间操作是惰性的
- 使用链式调用处理数据
- 合理使用并行流提高性能
- 避免在 Stream 中产生副作用

理解了 Stream API，你就能高效地处理集合数据。在下一章，我们将学习 Java Optional 的使用。
