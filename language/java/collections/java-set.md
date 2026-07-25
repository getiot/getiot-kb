---
sidebar_position: 4
slug: /java-set
sidebar_label: Java Set 集合
---

# Java Set 集合

Set 是 Java 集合框架中用于存储唯一元素的接口。理解 Set 的实现类和使用方法是处理不重复数据的基础。本章将详细介绍 Java 中的 Set 集合。

## Java Set 集合类型

HashSet、LinkedHashSet、TreeSet 是 Java 的三大 Set 集合类型，下面逐一介绍。

### HashSet

**`HashSet`** 是基于哈希表实现的，使用 HashMap 作为底层存储。

**特点**：
- **无序**：元素没有固定顺序
- **唯一性**：不允许重复元素
- **查找快**：平均时间复杂度 O(1)
- **线程不安全**：多线程环境下需要同步

```java
import java.util.HashSet;
import java.util.Set;

Set<String> set = new HashSet<>();
set.add("apple");
set.add("banana");
set.add("orange");
set.add("apple");  // 重复元素，不会添加

System.out.println(set);  // [banana, orange, apple]（顺序不确定）
System.out.println(set.size());  // 3
```

### LinkedHashSet

**`LinkedHashSet`** 是 HashSet 的子类，使用链表维护插入顺序。

**特点**：

- **有序**：保持插入顺序
- **唯一性**：不允许重复元素
- **查找快**：平均时间复杂度 O(1)
- **性能略低**：比 HashSet 略慢（需要维护链表）

```java
import java.util.LinkedHashSet;

Set<String> set = new LinkedHashSet<>();
set.add("apple");
set.add("banana");
set.add("orange");
set.add("apple");  // 重复元素，不会添加

System.out.println(set);  // [apple, banana, orange]（保持插入顺序）
```

### TreeSet

**`TreeSet`** 是基于红黑树实现的，元素按自然顺序或指定比较器排序。

**特点**：
- **有序**：元素自动排序
- **唯一性**：不允许重复元素
- **查找较慢**：时间复杂度 O(log n)
- **支持范围查询**：可以高效查询范围内的元素

```java
import java.util.TreeSet;

Set<String> set = new TreeSet<>();
set.add("orange");
set.add("apple");
set.add("banana");

System.out.println(set);  // [apple, banana, orange]（自动排序）
```

## 元素唯一性、排序与比较

### 元素唯一性

**Set 通过 `equals()` 和 `hashCode()` 判断元素是否重复**：

```java
public class Student {
    private String name;
    private int age;
    
    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    // 必须重写 equals 和 hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Student student = (Student) o;
        return age == student.age && Objects.equals(name, student.name);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(name, age);
    }
}

// 使用
Set<Student> students = new HashSet<>();
students.add(new Student("张三", 20));
students.add(new Student("李四", 22));
students.add(new Student("张三", 20));  // 不会添加（equals 返回 true）
System.out.println(students.size());  // 2
```

**重要规则**：
- 如果两个对象 `equals()` 返回 true，它们的 `hashCode()` 必须相等
- 如果两个对象 `hashCode()` 相等，它们不一定 `equals()`
- 重写 `equals()` 时必须重写 `hashCode()`

### 排序与比较

#### TreeSet 的自然排序

**元素必须实现 `Comparable` 接口**：

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
        return Integer.compare(this.score, other.score);  // 按成绩排序
    }
}

// 使用
Set<Student> students = new TreeSet<>();
students.add(new Student("张三", 85));
students.add(new Student("李四", 90));
students.add(new Student("王五", 78));
// 自动按成绩排序
```

#### TreeSet 的自定义排序

**使用 `Comparator` 指定排序规则**：

```java
// 按成绩降序排序
Set<Student> students = new TreeSet<>((s1, s2) -> 
    Integer.compare(s2.getScore(), s1.getScore()));

// 或使用 Comparator
Set<Student> students2 = new TreeSet<>(
    Comparator.comparing(Student::getScore).reversed()
);
```

## 示例：去重、排序集合

### 示例 1：去重

```java
import java.util.*;

public class DeduplicationExample {
    public static void main(String[] args) {
        // 使用 HashSet 去重
        List<String> list = Arrays.asList("apple", "banana", "apple", "orange", "banana");
        Set<String> uniqueSet = new HashSet<>(list);
        System.out.println("去重后：" + uniqueSet);
        
        // 保持顺序去重
        Set<String> linkedSet = new LinkedHashSet<>(list);
        System.out.println("保持顺序去重：" + linkedSet);
        
        // 去重并排序
        Set<String> sortedSet = new TreeSet<>(list);
        System.out.println("去重并排序：" + sortedSet);
    }
}
```

### 示例 2：集合操作

```java
import java.util.*;

public class SetOperations {
    public static void main(String[] args) {
        Set<Integer> set1 = new HashSet<>(Arrays.asList(1, 2, 3, 4, 5));
        Set<Integer> set2 = new HashSet<>(Arrays.asList(4, 5, 6, 7, 8));
        
        // 并集
        Set<Integer> union = new HashSet<>(set1);
        union.addAll(set2);
        System.out.println("并集：" + union);  // {1, 2, 3, 4, 5, 6, 7, 8}
        
        // 交集
        Set<Integer> intersection = new HashSet<>(set1);
        intersection.retainAll(set2);
        System.out.println("交集：" + intersection);  // {4, 5}
        
        // 差集
        Set<Integer> difference = new HashSet<>(set1);
        difference.removeAll(set2);
        System.out.println("差集：" + difference);  // {1, 2, 3}
    }
}
```

### 示例 3：TreeSet 排序

```java
import java.util.*;

public class TreeSetSortExample {
    public static void main(String[] args) {
        // 字符串自然排序
        Set<String> names = new TreeSet<>();
        names.add("Charlie");
        names.add("Alice");
        names.add("Bob");
        System.out.println("自然排序：" + names);  // [Alice, Bob, Charlie]
        
        // 自定义排序（降序）
        Set<String> namesDesc = new TreeSet<>(Collections.reverseOrder());
        namesDesc.add("Charlie");
        namesDesc.add("Alice");
        namesDesc.add("Bob");
        System.out.println("降序排序：" + namesDesc);  // [Charlie, Bob, Alice]
        
        // 对象排序
        Set<Student> students = new TreeSet<>((s1, s2) -> 
            Integer.compare(s2.getScore(), s1.getScore()));
        students.add(new Student("张三", 85));
        students.add(new Student("李四", 90));
        students.add(new Student("王五", 78));
        System.out.println("按成绩排序：");
        students.forEach(s -> System.out.println(s.getName() + ": " + s.getScore()));
    }
}
```

### 示例 4：Set 的常用操作

```java
import java.util.*;

public class SetOperationsExample {
    public static void main(String[] args) {
        Set<String> set = new HashSet<>();
        
        // 添加元素
        set.add("apple");
        set.add("banana");
        set.add("orange");
        
        // 检查是否包含
        boolean contains = set.contains("apple");  // true
        
        // 删除元素
        boolean removed = set.remove("banana");  // true
        
        // 获取大小
        int size = set.size();  // 2
        
        // 检查是否为空
        boolean empty = set.isEmpty();  // false
        
        // 清空
        set.clear();
        
        // 批量操作
        Set<String> set1 = new HashSet<>(Arrays.asList("a", "b", "c"));
        Set<String> set2 = new HashSet<>(Arrays.asList("b", "c", "d"));
        
        // 添加所有
        set1.addAll(set2);  // {a, b, c, d}
        
        // 保留交集
        set1.retainAll(set2);  // {b, c}
        
        // 删除所有
        set1.removeAll(set2);  // {}
    }
}
```

### 示例 5：TreeSet 范围查询

```java
import java.util.*;

public class TreeSetRangeQuery {
    public static void main(String[] args) {
        TreeSet<Integer> set = new TreeSet<>(Arrays.asList(1, 3, 5, 7, 9, 11, 13, 15));
        
        // 获取子集
        SortedSet<Integer> subset = set.subSet(5, 13);  // [5, 7, 9, 11]
        System.out.println("子集（5-13）：" + subset);
        
        // 获取头部子集
        SortedSet<Integer> headSet = set.headSet(10);  // [1, 3, 5, 7, 9]
        System.out.println("头部子集（<10）：" + headSet);
        
        // 获取尾部子集
        SortedSet<Integer> tailSet = set.tailSet(10);  // [11, 13, 15]
        System.out.println("尾部子集（>=10）：" + tailSet);
        
        // 获取第一个和最后一个
        Integer first = set.first();  // 1
        Integer last = set.last();    // 15
        
        // 获取小于指定元素的最大元素
        Integer lower = set.lower(10);  // 9
        
        // 获取大于指定元素的最小元素
        Integer higher = set.higher(10);  // 11
    }
}
```

## Set 的选择建议

#### 使用 HashSet

- 不需要顺序
- 需要快速查找
- 元素不需要排序

#### 使用 LinkedHashSet

- 需要保持插入顺序
- 需要快速查找
- 不需要排序

#### 使用 TreeSet

- 需要排序
- 需要范围查询
- 可以接受 O(log n) 的查找时间

## Set 的最佳实践

### 1. 重写 equals 和 hashCode

```java
public class Student {
    private String name;
    private int age;
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Student student = (Student) o;
        return age == student.age && Objects.equals(name, student.name);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(name, age);
    }
}
```

### 2. 使用合适的实现类

```java
// 不需要顺序：HashSet
Set<String> set1 = new HashSet<>();

// 需要保持顺序：LinkedHashSet
Set<String> set2 = new LinkedHashSet<>();

// 需要排序：TreeSet
Set<String> set3 = new TreeSet<>();
```

### 3. 利用 Set 去重

```java
// 快速去重
List<String> list = Arrays.asList("a", "b", "a", "c");
Set<String> unique = new LinkedHashSet<>(list);  // 保持顺序去重
List<String> uniqueList = new ArrayList<>(unique);
```

## 小结

Java Set 集合要点：

- **HashSet**：无序，查找快，基于哈希表
- **LinkedHashSet**：保持插入顺序，查找快
- **TreeSet**：自动排序，支持范围查询，基于红黑树
- **唯一性**：通过 equals 和 hashCode 判断
- **排序**：TreeSet 支持自然排序和自定义排序

**关键要点**：
- Set 不允许重复元素
- 使用 HashSet 需要重写 equals 和 hashCode
- LinkedHashSet 保持插入顺序
- TreeSet 自动排序，支持范围查询
- 根据需求选择合适的实现类

理解了 Set 集合，你就能处理不重复的数据。在下一章，我们将学习 Java 的 Map 集合。
