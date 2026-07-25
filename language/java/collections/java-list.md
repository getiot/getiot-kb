---
sidebar_position: 3
slug: /java-list
sidebar_label: Java List 集合
---

# Java List 集合

List 是 Java 集合框架中最常用的接口之一，用于存储有序、可重复的元素。理解 List 的实现类和使用方法是处理列表数据的基础。本章将详细介绍 Java 中的 List 集合。

## ArrayList 与 LinkedList 对比

### ArrayList

**`ArrayList`** 是基于数组实现的动态数组。

**特点**：
- **随机访问快**：通过索引访问元素，时间复杂度 O(1)
- **插入删除慢**：需要移动元素，时间复杂度 O(n)
- **内存连续**：元素在内存中连续存储
- **线程不安全**：多线程环境下需要同步

```java
import java.util.ArrayList;

List<String> list = new ArrayList<>();
list.add("apple");
list.add("banana");
list.add("orange");

// 随机访问
String first = list.get(0);  // "apple"（O(1)）

// 插入（中间位置）
list.add(1, "grape");  // O(n)，需要移动元素

// 删除
list.remove(0);  // O(n)，需要移动元素
```

### LinkedList

**`LinkedList`** 是基于双向链表实现的。

**特点**：

- **插入删除快**：在已知位置插入删除，时间复杂度 O(1)
- **随机访问慢**：需要遍历链表，时间复杂度 O(n)
- **内存不连续**：元素通过指针连接
- **线程不安全**：多线程环境下需要同步

```java
import java.util.LinkedList;

List<String> list = new LinkedList<>();
list.add("apple");
list.add("banana");
list.add("orange");

// 随机访问（慢）
String first = list.get(0);  // O(n)，需要遍历

// 插入（如果已知节点位置，O(1)）
list.add(1, "grape");

// 删除（如果已知节点位置，O(1)）
list.remove(0);
```

### 性能对比

| 操作 | ArrayList | LinkedList |
|:----:|:---------:|:----------:|
| 随机访问 | O(1) | O(n) |
| 插入（末尾） | O(1) | O(1) |
| 插入（中间） | O(n) | O(n) |
| 删除（末尾） | O(1) | O(1) |
| 删除（中间） | O(n) | O(n) |
| 内存占用 | 较小 | 较大（需要存储指针） |

### 选择建议

**使用 ArrayList**：
- 需要频繁随机访问
- 主要在末尾添加/删除元素
- 元素数量相对固定

**使用 LinkedList**：
- 需要频繁在中间插入/删除
- 不需要随机访问
- 元素数量变化较大

## 添加、删除、查找、遍历

### 添加元素

```java
List<String> list = new ArrayList<>();

// 在末尾添加
list.add("apple");        // 返回 true
list.add("banana");       // 返回 true

// 在指定位置插入
list.add(1, "orange");    // 在索引 1 处插入

// 批量添加
List<String> anotherList = Arrays.asList("grape", "mango");
list.addAll(anotherList);  // 添加所有元素
list.addAll(1, anotherList);  // 在指定位置插入所有元素
```

### 删除元素

```java
List<String> list = new ArrayList<>(Arrays.asList("apple", "banana", "orange"));

// 按索引删除
String removed = list.remove(0);  // 删除索引 0 的元素，返回 "apple"

// 按值删除
boolean removed2 = list.remove("banana");  // 删除第一个匹配的元素，返回 true

// 批量删除
List<String> toRemove = Arrays.asList("orange", "grape");
list.removeAll(toRemove);  // 删除所有匹配的元素

// 保留指定元素
list.retainAll(Arrays.asList("apple", "banana"));  // 只保留这些元素

// 清空
list.clear();  // 删除所有元素
```

### 查找元素

```java
List<String> list = new ArrayList<>(Arrays.asList("apple", "banana", "orange"));

// 检查是否包含
boolean contains = list.contains("apple");  // true

// 查找索引
int index = list.indexOf("banana");  // 1（第一个匹配的索引）
int lastIndex = list.lastIndexOf("banana");  // 查找最后一个匹配的索引

// 获取元素
String element = list.get(0);  // "apple"

// 检查是否为空
boolean empty = list.isEmpty();  // false

// 获取大小
int size = list.size();  // 3
```

### 遍历 List

#### 1. 传统 for 循环

```java
List<String> list = Arrays.asList("apple", "banana", "orange");

for (int i = 0; i < list.size(); i++) {
    System.out.println(list.get(i));
}
```

#### 2. 增强 for 循环

```java
for (String item : list) {
    System.out.println(item);
}
```

#### 3. 迭代器

```java
Iterator<String> iterator = list.iterator();
while (iterator.hasNext()) {
    String item = iterator.next();
    System.out.println(item);
}
```

#### 4. Lambda 表达式（Java 8+）

```java
list.forEach(item -> System.out.println(item));

// 或使用方法引用
list.forEach(System.out::println);
```

#### 5. Stream API（Java 8+）

```java
list.stream()
    .filter(item -> item.startsWith("a"))
    .forEach(System.out::println);
```

## 常用工具方法

### Collections.sort 方法

**对 List 进行排序**：

```java
import java.util.Collections;

List<Integer> list = new ArrayList<>(Arrays.asList(3, 1, 4, 1, 5, 9, 2, 6));

// 自然排序（升序）
Collections.sort(list);  // {1, 1, 2, 3, 4, 5, 6, 9}

// 自定义排序（降序）
Collections.sort(list, Collections.reverseOrder());

// 使用自定义比较器
Collections.sort(list, (a, b) -> b - a);  // 降序
```

### List 的 sort 方法（Java 8+）

```java
List<Integer> list = new ArrayList<>(Arrays.asList(3, 1, 4, 1, 5));

// 自然排序
list.sort(null);  // 或 list.sort(Comparator.naturalOrder())

// 自定义排序
list.sort((a, b) -> b - a);  // 降序
list.sort(Comparator.reverseOrder());  // 降序
```

### 其他常用方法

```java
// 反转
Collections.reverse(list);  // 反转列表顺序

// 打乱
Collections.shuffle(list);  // 随机打乱

// 填充
Collections.fill(list, 0);  // 用 0 填充所有元素

// 复制
List<Integer> dest = new ArrayList<>(Arrays.asList(0, 0, 0, 0, 0));
Collections.copy(dest, list);  // 复制 list 到 dest

// 交换
Collections.swap(list, 0, 4);  // 交换索引 0 和 4 的元素

// 旋转
Collections.rotate(list, 2);  // 向右旋转 2 个位置

// 最大最小值
Integer max = Collections.max(list);
Integer min = Collections.min(list);

// 频率统计
int frequency = Collections.frequency(list, 1);  // 1 出现的次数
```

## 实际示例

### 示例 1：ArrayList 基本操作

```java
import java.util.*;

public class ArrayListExample {
    public static void main(String[] args) {
        List<String> list = new ArrayList<>();
        
        // 添加元素
        list.add("apple");
        list.add("banana");
        list.add("orange");
        System.out.println("添加后：" + list);
        
        // 插入元素
        list.add(1, "grape");
        System.out.println("插入后：" + list);
        
        // 访问元素
        String first = list.get(0);
        System.out.println("第一个元素：" + first);
        
        // 查找元素
        int index = list.indexOf("banana");
        System.out.println("banana 的索引：" + index);
        
        // 删除元素
        list.remove("grape");
        System.out.println("删除后：" + list);
        
        // 遍历
        for (String item : list) {
            System.out.println(item);
        }
    }
}
```

### 示例 2：LinkedList 基本操作

```java
import java.util.*;

public class LinkedListExample {
    public static void main(String[] args) {
        List<String> list = new LinkedList<>();
        
        // 添加元素
        list.add("first");
        list.add("second");
        list.add("third");
        
        // 在开头添加
        ((LinkedList<String>) list).addFirst("zero");
        
        // 在末尾添加
        ((LinkedList<String>) list).addLast("fourth");
        
        // 获取第一个和最后一个
        String first = ((LinkedList<String>) list).getFirst();
        String last = ((LinkedList<String>) list).getLast();
        
        // 删除第一个和最后一个
        ((LinkedList<String>) list).removeFirst();
        ((LinkedList<String>) list).removeLast();
        
        System.out.println("列表：" + list);
    }
}
```

### 示例 3：List 排序

```java
import java.util.*;

public class ListSortExample {
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
        
        // 对象排序（需要实现 Comparable 或提供 Comparator）
        List<Student> students = new ArrayList<>();
        students.add(new Student("张三", 85));
        students.add(new Student("李四", 90));
        students.add(new Student("王五", 78));
        
        // 按成绩排序
        Collections.sort(students, (s1, s2) -> 
            Integer.compare(s2.getScore(), s1.getScore()));
        System.out.println("按成绩排序：");
        students.forEach(s -> System.out.println(s.getName() + ": " + s.getScore()));
    }
}
```

### 示例 4：List 工具方法

```java
import java.util.*;

public class ListUtilsExample {
    public static void main(String[] args) {
        List<Integer> list = new ArrayList<>(Arrays.asList(1, 2, 3, 4, 5));
        
        // 反转
        Collections.reverse(list);
        System.out.println("反转后：" + list);
        
        // 打乱
        Collections.shuffle(list);
        System.out.println("打乱后：" + list);
        
        // 最大最小值
        System.out.println("最大值：" + Collections.max(list));
        System.out.println("最小值：" + Collections.min(list));
        
        // 频率统计
        List<Integer> list2 = new ArrayList<>(Arrays.asList(1, 2, 2, 3, 2, 4));
        System.out.println("2 出现的次数：" + Collections.frequency(list2, 2));
        
        // 创建不可变列表
        List<Integer> unmodifiable = Collections.unmodifiableList(list);
        // unmodifiable.add(6);  // 会抛出 UnsupportedOperationException
    }
}
```

### 示例 5：List 转换

```java
import java.util.*;

public class ListConversion {
    public static void main(String[] args) {
        // 数组转 List
        String[] array = {"a", "b", "c"};
        List<String> list = Arrays.asList(array);
        // 注意：返回的 List 是固定大小的，不能添加/删除
        
        // List 转数组
        List<String> list2 = new ArrayList<>(Arrays.asList("a", "b", "c"));
        String[] array2 = list2.toArray(new String[0]);
        
        // 转换为其他集合
        Set<String> set = new HashSet<>(list2);
        Queue<String> queue = new LinkedList<>(list2);
    }
}
```

## List 的最佳实践

### 1. 选择合适的实现类

```java
// 需要随机访问：使用 ArrayList
List<String> list1 = new ArrayList<>();

// 需要频繁插入删除：使用 LinkedList
List<String> list2 = new LinkedList<>();
```

### 2. 指定初始容量（ArrayList）

```java
// 如果知道大概大小，指定初始容量
List<String> list = new ArrayList<>(100);  // 初始容量 100
```

### 3. 使用泛型

```java
// ✅ 推荐：使用泛型
List<String> list = new ArrayList<>();

// ❌ 不推荐：使用原始类型
// List list = new ArrayList();
```

### 4. 遍历时避免修改

```java
List<String> list = new ArrayList<>(Arrays.asList("a", "b", "c"));

// ❌ 错误：在遍历时修改会抛出 ConcurrentModificationException
// for (String item : list) {
//     list.remove(item);
// }

// ✅ 正确：使用迭代器删除
Iterator<String> iterator = list.iterator();
while (iterator.hasNext()) {
    String item = iterator.next();
    if (item.equals("b")) {
        iterator.remove();  // 使用迭代器删除
    }
}
```

## 小结

Java List 集合要点：

- **ArrayList**：基于数组，随机访问快，插入删除慢
- **LinkedList**：基于链表，插入删除快，随机访问慢
- **基本操作**：添加、删除、查找、遍历
- **工具方法**：Collections.sort、reverse、shuffle 等
- **选择建议**：根据使用场景选择合适的实现类

**关键要点**：
- ArrayList 适合随机访问
- LinkedList 适合频繁插入删除
- 使用泛型保证类型安全
- 遍历时避免直接修改集合
- 利用 Collections 工具类简化操作

理解了 List 集合，你就能高效地处理列表数据。在下一章，我们将学习 Java 的 Set 集合。
