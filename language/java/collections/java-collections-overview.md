---
sidebar_position: 1
slug: /java-collections-overview
sidebar_label: Java 集合框架概览
---

# Java 集合框架概览

Java 集合框架（Collections Framework）是 Java 中用于存储和操作对象组的统一架构。理解集合框架的层次结构和各类集合的特点，是高效使用 Java 集合的基础。本章将详细介绍 Java 集合框架的整体结构。

## Collection 与 Map 层次结构

### 集合框架的层次结构

Java 集合框架主要分为两个接口体系：

1. **Collection 接口**：存储单个元素的集合
2. **Map 接口**：存储键值对的映射

### Collection 接口层次

```
Collection
├── List（有序、可重复）
│   ├── ArrayList
│   ├── LinkedList
│   └── Vector（已过时）
├── Set（无序、不可重复）
│   ├── HashSet
│   ├── LinkedHashSet
│   └── TreeSet
└── Queue（队列）
    ├── PriorityQueue
    └── Deque
        └── ArrayDeque
```

### Map 接口层次

```
Map
├── HashMap
├── LinkedHashMap
├── TreeMap
└── Hashtable（已过时）
```

### 核心接口说明

#### Collection 接口

**所有集合类的根接口**，定义了集合的基本操作：

```java
public interface Collection<E> {
    // 基本操作
    boolean add(E e);
    boolean remove(Object o);
    boolean contains(Object o);
    int size();
    boolean isEmpty();
    void clear();
    
    // 批量操作
    boolean addAll(Collection<? extends E> c);
    boolean removeAll(Collection<?> c);
    boolean retainAll(Collection<?> c);
    
    // 遍历操作
    Iterator<E> iterator();
    Object[] toArray();
    <T> T[] toArray(T[] a);
}
```

#### Map 接口

**存储键值对的接口**：

```java
public interface Map<K, V> {
    // 基本操作
    V put(K key, V value);
    V get(Object key);
    V remove(Object key);
    boolean containsKey(Object key);
    boolean containsValue(Object value);
    int size();
    boolean isEmpty();
    void clear();
    
    // 视图操作
    Set<K> keySet();
    Collection<V> values();
    Set<Map.Entry<K, V>> entrySet();
}
```

## List / Set / Map / Queue 区别与特点

### List（列表）

**特点**：
- **有序**：元素按照插入顺序存储
- **可重复**：允许存储相同的元素
- **有索引**：可以通过索引访问元素

**实现类**：
- **ArrayList**：基于数组，随机访问快，插入删除慢
- **LinkedList**：基于链表，插入删除快，随机访问慢

```java
List<String> list = new ArrayList<>();
list.add("apple");
list.add("banana");
list.add("apple");  // 可以重复
System.out.println(list.get(0));  // "apple"（有索引）
```

### Set（集合）

**特点**：
- **无序**：元素没有固定顺序（TreeSet 除外）
- **不可重复**：不允许存储相同的元素
- **无索引**：不能通过索引访问

**实现类**：
- **HashSet**：基于哈希表，查找快，无序
- **LinkedHashSet**：基于哈希表+链表，保持插入顺序
- **TreeSet**：基于红黑树，有序，支持排序

```java
Set<String> set = new HashSet<>();
set.add("apple");
set.add("banana");
set.add("apple");  // 重复元素，不会添加
System.out.println(set.size());  // 2
```

### Map（映射）

**特点**：
- **键值对**：存储 key-value 对
- **键唯一**：每个 key 只能对应一个 value
- **值可重复**：不同的 key 可以对应相同的 value

**实现类**：
- **HashMap**：基于哈希表，查找快，无序
- **LinkedHashMap**：保持插入顺序
- **TreeMap**：基于红黑树，按键排序

```java
Map<String, Integer> map = new HashMap<>();
map.put("apple", 10);
map.put("banana", 20);
map.put("apple", 30);  // 覆盖之前的 value
System.out.println(map.get("apple"));  // 30
```

### Queue（队列）

**特点**：
- **FIFO**：先进先出（First In First Out）
- **特殊操作**：支持队列特有的操作（offer、poll、peek）

**实现类**：
- **LinkedList**：可以作为队列使用
- **PriorityQueue**：优先级队列，按优先级排序
- **ArrayDeque**：双端队列，可以作为栈或队列使用

```java
Queue<String> queue = new LinkedList<>();
queue.offer("first");
queue.offer("second");
System.out.println(queue.poll());  // "first"（先进先出）
```

## 案例对比：选择合适集合类型

### 场景 1：存储学生列表（有序、可重复）

**需求**：存储学生列表，需要按顺序访问，可能有重复

**选择**：`List`（ArrayList 或 LinkedList）

```java
List<Student> students = new ArrayList<>();
students.add(new Student("张三", 20));
students.add(new Student("李四", 22));
students.add(new Student("张三", 20));  // 可以重复

// 按顺序访问
for (int i = 0; i < students.size(); i++) {
    System.out.println(students.get(i));
}
```

### 场景 2：存储唯一标签（无序、不可重复）

**需求**：存储文章标签，标签不能重复，顺序不重要

**选择**：`Set`（HashSet）

```java
Set<String> tags = new HashSet<>();
tags.add("Java");
tags.add("Python");
tags.add("Java");  // 不会添加重复标签

System.out.println(tags.size());  // 2
```

### 场景 3：存储学生成绩（键值对）

**需求**：存储学生姓名和成绩的对应关系

**选择**：`Map`（HashMap）

```java
Map<String, Integer> scores = new HashMap<>();
scores.put("张三", 85);
scores.put("李四", 90);
scores.put("王五", 78);

System.out.println("张三的成绩：" + scores.get("张三"));  // 85
```

### 场景 4：任务队列（FIFO）

**需求**：处理任务队列，按顺序执行

**选择**：`Queue`（LinkedList 或 ArrayDeque）

```java
Queue<Task> tasks = new LinkedList<>();
tasks.offer(new Task("任务1"));
tasks.offer(new Task("任务2"));

while (!tasks.isEmpty()) {
    Task task = tasks.poll();  // 按顺序取出
    task.execute();
}
```

### 场景 5：需要排序的集合

**需求**：存储学生，按成绩排序

**选择**：`TreeSet` 或 `TreeMap`

```java
// 使用 TreeSet（需要实现 Comparable 或提供 Comparator）
TreeSet<Student> students = new TreeSet<>((s1, s2) -> 
    Integer.compare(s2.getScore(), s1.getScore()));
students.add(new Student("张三", 85));
students.add(new Student("李四", 90));

// 使用 TreeMap（按键排序）
TreeMap<String, Integer> scores = new TreeMap<>();
scores.put("张三", 85);
scores.put("李四", 90);
// 按键的字典序排序
```

### 场景 6：需要保持插入顺序

**需求**：存储访问记录，需要保持访问顺序

**选择**：`LinkedHashSet` 或 `LinkedHashMap`

```java
// 保持插入顺序的 Set
LinkedHashSet<String> visited = new LinkedHashSet<>();
visited.add("page1");
visited.add("page2");
visited.add("page3");
// 遍历时保持插入顺序

// 保持插入顺序的 Map
LinkedHashMap<String, Integer> cache = new LinkedHashMap<>();
cache.put("key1", 1);
cache.put("key2", 2);
// 遍历时保持插入顺序
```

## 集合选择指南

### 选择 List 的场景

- 需要按顺序存储元素
- 允许重复元素
- 需要通过索引访问
- 需要频繁按位置插入/删除（使用 LinkedList）
- 需要频繁随机访问（使用 ArrayList）

### 选择 Set 的场景

- 需要存储唯一元素
- 不需要顺序（HashSet）
- 需要保持插入顺序（LinkedHashSet）
- 需要排序（TreeSet）

### 选择 Map 的场景

- 需要键值对映射
- 需要根据 key 快速查找 value
- 不需要顺序（HashMap）
- 需要保持插入顺序（LinkedHashMap）
- 需要按键排序（TreeMap）

### 选择 Queue 的场景

- 需要 FIFO 队列
- 需要优先级队列（PriorityQueue）
- 需要双端队列（ArrayDeque）

## 性能对比

### List 实现类性能

| 操作 | ArrayList | LinkedList |
|:----:|:---------:|:----------:|
| 随机访问 | O(1) | O(n) |
| 插入（末尾） | O(1) | O(1) |
| 插入（中间） | O(n) | O(n) |
| 删除 | O(n) | O(n) |

### Set 实现类性能

| 操作 | HashSet | LinkedHashSet | TreeSet |
|:----:|:-------:|:-------------:|:-------:|
| 添加 | O(1) | O(1) | O(log n) |
| 查找 | O(1) | O(1) | O(log n) |
| 删除 | O(1) | O(1) | O(log n) |
| 有序 | 否 | 插入顺序 | 排序 |

### Map 实现类性能

| 操作 | HashMap | LinkedHashMap | TreeMap |
|:----:|:-------:|:-------------:|:-------:|
| 添加 | O(1) | O(1) | O(log n) |
| 查找 | O(1) | O(1) | O(log n) |
| 删除 | O(1) | O(1) | O(log n) |
| 有序 | 否 | 插入顺序 | 排序 |

## 实际示例

### 示例 1：综合使用

```java
import java.util.*;

public class CollectionExample {
    public static void main(String[] args) {
        // List：存储有序列表
        List<String> list = new ArrayList<>();
        list.add("apple");
        list.add("banana");
        list.add("apple");
        System.out.println("List：" + list);
        
        // Set：存储唯一元素
        Set<String> set = new HashSet<>();
        set.add("apple");
        set.add("banana");
        set.add("apple");
        System.out.println("Set：" + set);
        
        // Map：存储键值对
        Map<String, Integer> map = new HashMap<>();
        map.put("apple", 10);
        map.put("banana", 20);
        System.out.println("Map：" + map);
        
        // Queue：队列
        Queue<String> queue = new LinkedList<>();
        queue.offer("first");
        queue.offer("second");
        System.out.println("Queue：" + queue.poll());
    }
}
```

### 示例 2：选择合适的集合

```java
public class CollectionSelector {
    // 场景 1：存储购物车商品（有序、可重复）
    public static List<Product> shoppingCart() {
        List<Product> cart = new ArrayList<>();
        cart.add(new Product("商品1"));
        cart.add(new Product("商品2"));
        cart.add(new Product("商品1"));  // 可以重复
        return cart;
    }
    
    // 场景 2：存储用户 ID（唯一）
    public static Set<String> userIds() {
        Set<String> userIds = new HashSet<>();
        userIds.add("user1");
        userIds.add("user2");
        userIds.add("user1");  // 不会重复
        return userIds;
    }
    
    // 场景 3：存储用户信息（键值对）
    public static Map<String, User> userMap() {
        Map<String, User> users = new HashMap<>();
        users.put("user1", new User("张三"));
        users.put("user2", new User("李四"));
        return users;
    }
    
    // 场景 4：任务队列
    public static Queue<Task> taskQueue() {
        Queue<Task> tasks = new LinkedList<>();
        tasks.offer(new Task("任务1"));
        tasks.offer(new Task("任务2"));
        return tasks;
    }
}
```

## 小结

Java 集合框架概览要点：

- **Collection 接口**：存储单个元素（List、Set、Queue）
- **Map 接口**：存储键值对
- **List**：有序、可重复，有索引
- **Set**：无序、不可重复，无索引
- **Map**：键值对，键唯一
- **Queue**：FIFO 队列

**关键要点**：
- 根据需求选择合适的集合类型
- 理解各集合的特点和性能
- List 用于有序可重复的场景
- Set 用于唯一元素的场景
- Map 用于键值对映射的场景
- Queue 用于队列场景

理解了集合框架的概览，你就能选择合适的集合类型。在下一章，我们将学习 Java 的泛型。
