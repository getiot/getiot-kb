---
sidebar_position: 7
slug: /java-collections-iteration
sidebar_label: Java 集合遍历与排序
---

# Java 集合的遍历与排序

遍历和排序是集合操作中最常用的功能。理解不同的遍历方式和排序方法是高效处理集合数据的基础。本章将详细介绍 Java 中集合的遍历与排序。

## for-each 循环与迭代器

### for-each 循环

**增强的 for 循环**是最常用的遍历方式。

```java
List<String> list = Arrays.asList("apple", "banana", "orange");

// for-each 循环
for (String item : list) {
    System.out.println(item);
}
```

**适用场景**：
- 只需要读取元素
- 不需要修改集合
- 代码简洁

### 迭代器（Iterator）

**`Iterator`** 提供了更灵活的遍历方式。

```java
List<String> list = new ArrayList<>(Arrays.asList("apple", "banana", "orange"));

// 使用迭代器
Iterator<String> iterator = list.iterator();
while (iterator.hasNext()) {
    String item = iterator.next();
    System.out.println(item);
}
```

**迭代器的优势**：
- 可以在遍历时删除元素
- 支持并发修改检测
- 更灵活的控制

```java
// 使用迭代器删除元素
Iterator<String> iterator = list.iterator();
while (iterator.hasNext()) {
    String item = iterator.next();
    if (item.equals("banana")) {
        iterator.remove();  // 安全删除
    }
}
```

### ListIterator

**`ListIterator`** 是 Iterator 的子接口，支持双向遍历（仅 List）。

```java
List<String> list = new ArrayList<>(Arrays.asList("apple", "banana", "orange"));

// 正向遍历
ListIterator<String> listIterator = list.listIterator();
while (listIterator.hasNext()) {
    String item = listIterator.next();
    System.out.println(item);
}

// 反向遍历
while (listIterator.hasPrevious()) {
    String item = listIterator.previous();
    System.out.println(item);
}

// 在遍历时修改
while (listIterator.hasNext()) {
    String item = listIterator.next();
    if (item.equals("banana")) {
        listIterator.set("grape");  // 替换元素
        listIterator.add("mango");   // 添加元素
    }
}
```

## Stream API 遍历

### Stream 概述

**Stream API**（Java 8+）提供了函数式编程风格的集合操作。

### 基本遍历

```java
List<String> list = Arrays.asList("apple", "banana", "orange");

// 基本遍历
list.stream().forEach(item -> System.out.println(item));

// 使用方法引用
list.stream().forEach(System.out::println);
```

### 过滤和映射

```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

// 过滤：找出偶数
List<Integer> evens = numbers.stream()
    .filter(n -> n % 2 == 0)
    .collect(Collectors.toList());

// 映射：每个数乘以 2
List<Integer> doubled = numbers.stream()
    .map(n -> n * 2)
    .collect(Collectors.toList());

// 组合操作
List<Integer> result = numbers.stream()
    .filter(n -> n % 2 == 0)
    .map(n -> n * 2)
    .collect(Collectors.toList());
```

### 其他 Stream 操作

```java
List<String> list = Arrays.asList("apple", "banana", "orange", "grape");

// 排序
List<String> sorted = list.stream()
    .sorted()
    .collect(Collectors.toList());

// 去重
List<String> distinct = list.stream()
    .distinct()
    .collect(Collectors.toList());

// 限制数量
List<String> limited = list.stream()
    .limit(2)
    .collect(Collectors.toList());

// 跳过元素
List<String> skipped = list.stream()
    .skip(2)
    .collect(Collectors.toList());

// 查找
Optional<String> first = list.stream()
    .filter(s -> s.startsWith("a"))
    .findFirst();

// 匹配
boolean allMatch = list.stream().allMatch(s -> s.length() > 3);
boolean anyMatch = list.stream().anyMatch(s -> s.startsWith("a"));
boolean noneMatch = list.stream().noneMatch(s -> s.isEmpty());

// 统计
long count = list.stream().count();
Optional<String> max = list.stream().max(String::compareTo);
Optional<String> min = list.stream().min(String::compareTo);
```

## Comparator 与 Comparable 排序

### Comparable 接口

**`Comparable`** 用于定义对象的自然排序。

```java
public class Student implements Comparable<Student> {
    private String name;
    private int score;
    
    public Student(String name, int score) {
        this.name = name;
        this.score = score;
    }
    
    @Override
    public int compareTo(Student other) {
        // 按成绩升序排序
        return Integer.compare(this.score, other.score);
    }
    
    // Getter 方法
    public String getName() { return name; }
    public int getScore() { return score; }
}

// 使用
List<Student> students = new ArrayList<>();
students.add(new Student("张三", 85));
students.add(new Student("李四", 90));
students.add(new Student("王五", 78));

Collections.sort(students);  // 使用自然排序
```

### Comparator 接口

**`Comparator`** 用于定义自定义排序规则。

```java
import java.util.Comparator;

List<Student> students = new ArrayList<>();
students.add(new Student("张三", 85));
students.add(new Student("李四", 90));
students.add(new Student("王五", 78));

// 使用 Comparator 排序
Collections.sort(students, new Comparator<Student>() {
    @Override
    public int compare(Student s1, Student s2) {
        return Integer.compare(s2.getScore(), s1.getScore());  // 降序
    }
});

// 使用 Lambda 表达式（Java 8+）
Collections.sort(students, (s1, s2) -> 
    Integer.compare(s2.getScore(), s1.getScore()));

// 使用方法引用（Java 8+）
Collections.sort(students, Comparator.comparing(Student::getScore).reversed());
```

### Comparator 的常用方法

```java
List<Student> students = new ArrayList<>();

// comparing：按属性排序
students.sort(Comparator.comparing(Student::getScore));  // 升序
students.sort(Comparator.comparing(Student::getScore).reversed());  // 降序

// thenComparing：多级排序
students.sort(Comparator
    .comparing(Student::getScore)
    .thenComparing(Student::getName));  // 先按成绩，再按姓名

// nullsFirst / nullsLast：处理 null
students.sort(Comparator.comparing(Student::getName, 
    Comparator.nullsFirst(String::compareTo)));

// naturalOrder / reverseOrder
students.sort(Comparator.comparing(Student::getScore, Comparator.reverseOrder()));
```

## 示例：按属性排序对象集合

### 示例 1：基本排序

```java
import java.util.*;

public class BasicSort {
    public static void main(String[] args) {
        // 整数排序
        List<Integer> numbers = new ArrayList<>(Arrays.asList(3, 1, 4, 1, 5, 9, 2, 6));
        Collections.sort(numbers);
        System.out.println("升序：" + numbers);
        
        Collections.sort(numbers, Collections.reverseOrder());
        System.out.println("降序：" + numbers);
        
        // 字符串排序
        List<String> names = new ArrayList<>(Arrays.asList("Charlie", "Alice", "Bob"));
        Collections.sort(names);
        System.out.println("字符串排序：" + names);
    }
}
```

### 示例 2：对象排序（Comparable）

```java
import java.util.*;

public class Student implements Comparable<Student> {
    private String name;
    private int score;
    
    public Student(String name, int score) {
        this.name = name;
        this.score = score;
    }
    
    @Override
    public int compareTo(Student other) {
        // 先按成绩降序，再按姓名升序
        int scoreCompare = Integer.compare(other.score, this.score);
        if (scoreCompare != 0) {
            return scoreCompare;
        }
        return this.name.compareTo(other.name);
    }
    
    public String getName() { return name; }
    public int getScore() { return score; }
    
    @Override
    public String toString() {
        return name + "(" + score + ")";
    }
}

// 使用
List<Student> students = new ArrayList<>();
students.add(new Student("张三", 85));
students.add(new Student("李四", 90));
students.add(new Student("王五", 78));
students.add(new Student("赵六", 90));

Collections.sort(students);
students.forEach(System.out::println);
// 输出：
// 李四(90)
// 赵六(90)
// 张三(85)
// 王五(78)
```

### 示例 3：对象排序（Comparator）

```java
import java.util.*;

public class ComparatorSort {
    public static void main(String[] args) {
        List<Student> students = new ArrayList<>();
        students.add(new Student("张三", 85, 20));
        students.add(new Student("李四", 90, 22));
        students.add(new Student("王五", 78, 21));
        
        // 按成绩降序
        students.sort(Comparator.comparing(Student::getScore).reversed());
        System.out.println("按成绩降序：");
        students.forEach(System.out::println);
        
        // 按年龄升序
        students.sort(Comparator.comparing(Student::getAge));
        System.out.println("按年龄升序：");
        students.forEach(System.out::println);
        
        // 多级排序：先按成绩降序，再按年龄升序
        students.sort(Comparator
            .comparing(Student::getScore).reversed()
            .thenComparing(Student::getAge));
        System.out.println("多级排序：");
        students.forEach(System.out::println);
    }
}
```

### 示例 4：Stream API 排序

```java
import java.util.*;
import java.util.stream.Collectors;

public class StreamSort {
    public static void main(String[] args) {
        List<Student> students = new ArrayList<>();
        students.add(new Student("张三", 85));
        students.add(new Student("李四", 90));
        students.add(new Student("王五", 78));
        
        // 使用 Stream 排序
        List<Student> sorted = students.stream()
            .sorted(Comparator.comparing(Student::getScore).reversed())
            .collect(Collectors.toList());
        
        sorted.forEach(System.out::println);
        
        // 过滤和排序
        List<Student> filtered = students.stream()
            .filter(s -> s.getScore() >= 80)
            .sorted(Comparator.comparing(Student::getScore).reversed())
            .collect(Collectors.toList());
    }
}
```

### 示例 5：Map 排序

```java
import java.util.*;
import java.util.stream.Collectors;

public class MapSort {
    public static void main(String[] args) {
        Map<String, Integer> map = new HashMap<>();
        map.put("apple", 30);
        map.put("banana", 10);
        map.put("orange", 20);
        
        // 按键排序
        Map<String, Integer> sortedByKey = map.entrySet().stream()
            .sorted(Map.Entry.comparingByKey())
            .collect(Collectors.toMap(
                Map.Entry::getKey,
                Map.Entry::getValue,
                (e1, e2) -> e1,
                LinkedHashMap::new
            ));
        System.out.println("按键排序：" + sortedByKey);
        
        // 按值排序
        Map<String, Integer> sortedByValue = map.entrySet().stream()
            .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
            .collect(Collectors.toMap(
                Map.Entry::getKey,
                Map.Entry::getValue,
                (e1, e2) -> e1,
                LinkedHashMap::new
            ));
        System.out.println("按值排序：" + sortedByValue);
    }
}
```

### 示例 6：综合遍历示例

```java
import java.util.*;
import java.util.stream.Collectors;

public class IterationExample {
    public static void main(String[] args) {
        List<String> list = new ArrayList<>(Arrays.asList("apple", "banana", "orange", "grape"));
        
        // 方法 1：for-each
        System.out.println("for-each 遍历：");
        for (String item : list) {
            System.out.println(item);
        }
        
        // 方法 2：迭代器
        System.out.println("迭代器遍历：");
        Iterator<String> iterator = list.iterator();
        while (iterator.hasNext()) {
            System.out.println(iterator.next());
        }
        
        // 方法 3：Lambda
        System.out.println("Lambda 遍历：");
        list.forEach(item -> System.out.println(item));
        
        // 方法 4：Stream API
        System.out.println("Stream 遍历：");
        list.stream()
            .filter(item -> item.length() > 5)
            .map(String::toUpperCase)
            .forEach(System.out::println);
        
        // 方法 5：带索引遍历（Java 8+）
        System.out.println("带索引遍历：");
        IntStream.range(0, list.size())
            .forEach(i -> System.out.println(i + ": " + list.get(i)));
    }
}
```

## 遍历和排序的最佳实践

### 1. 选择合适的遍历方式

```java
// 简单遍历：for-each
for (String item : list) { }

// 需要删除：迭代器
Iterator<String> it = list.iterator();
while (it.hasNext()) {
    if (condition) {
        it.remove();
    }
}

// 函数式操作：Stream API
list.stream()
    .filter(condition)
    .map(transformation)
    .collect(Collectors.toList());
```

### 2. 避免在遍历时修改集合

```java
// ❌ 错误：会抛出 ConcurrentModificationException
// for (String item : list) {
//     list.remove(item);
// }

// ✅ 正确：使用迭代器
Iterator<String> it = list.iterator();
while (it.hasNext()) {
    String item = it.next();
    if (shouldRemove(item)) {
        it.remove();
    }
}
```

### 3. 使用合适的排序方式

```java
// 自然排序：实现 Comparable
Collections.sort(list);

// 自定义排序：使用 Comparator
Collections.sort(list, Comparator.comparing(Student::getScore));

// Stream 排序：函数式风格
list.stream()
    .sorted(Comparator.comparing(Student::getScore))
    .collect(Collectors.toList());
```

## 小结

Java 集合遍历与排序要点：

- **遍历方式**：for-each、迭代器、Stream API
- **迭代器**：支持删除操作，更灵活
- **Stream API**：函数式编程风格，支持过滤、映射等操作
- **Comparable**：定义自然排序
- **Comparator**：定义自定义排序规则

**关键要点**：
- for-each 适合简单遍历
- 迭代器适合需要删除的场景
- Stream API 适合复杂的数据处理
- 实现 Comparable 定义自然排序
- 使用 Comparator 定义自定义排序
- 避免在遍历时直接修改集合

理解了集合的遍历与排序，你就能高效地处理集合数据。恭喜你完成了第五部分的学习！
