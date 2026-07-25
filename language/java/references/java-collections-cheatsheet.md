---
sidebar_position: 3
slug: /java-collections-cheatsheet
sidebar_label: Java 集合对照表
---

# Java 集合对照表

Java 集合框架提供了丰富的数据结构。本章提供集合的快速对照参考。

## List / Set / Map / Queue 对照

### List（有序，可重复）

| 实现类 | 特点 | 适用场景 |
|:------:|:----:|:--------:|
| ArrayList | 数组实现，随机访问快 | 频繁访问，较少插入删除 |
| LinkedList | 链表实现，插入删除快 | 频繁插入删除 |
| Vector | 线程安全，已过时 | 不推荐使用 |
| Stack | 栈，继承 Vector | 使用 Deque 替代 |

### Set（无序，不可重复）

| 实现类 | 特点 | 适用场景 |
|:------:|:----:|:--------:|
| HashSet | 哈希表实现，无序 | 快速查找，不需要顺序 |
| LinkedHashSet | 哈希表+链表，保持插入顺序 | 需要保持插入顺序 |
| TreeSet | 红黑树实现，有序 | 需要排序 |

### Map（键值对）

| 实现类 | 特点 | 适用场景 |
|:------:|:----:|:--------:|
| HashMap | 哈希表实现，无序 | 快速查找，不需要顺序 |
| LinkedHashMap | 哈希表+链表，保持插入顺序 | 需要保持插入顺序 |
| TreeMap | 红黑树实现，有序 | 需要排序 |
| Hashtable | 线程安全，已过时 | 使用 ConcurrentHashMap |

### Queue（队列）

| 实现类 | 特点 | 适用场景 |
|:------:|:----:|:--------:|
| LinkedList | 双向队列 | 队列和栈 |
| PriorityQueue | 优先级队列 | 需要优先级 |
| ArrayDeque | 数组实现的双端队列 | 高效的双端队列 |

## 常用实现类对比

### ArrayList vs LinkedList

```java
// ArrayList：随机访问快
List<String> list1 = new ArrayList<>();
list1.get(0);                    // O(1)
list1.add(0, "item");           // O(n)

// LinkedList：插入删除快
List<String> list2 = new LinkedList<>();
list2.get(0);                    // O(n)
list2.add(0, "item");           // O(1)
```

### HashMap vs TreeMap

```java
// HashMap：无序，O(1) 查找
Map<String, Integer> map1 = new HashMap<>();
map1.put("key", 1);             // O(1)
map1.get("key");                // O(1)

// TreeMap：有序，O(log n) 查找
Map<String, Integer> map2 = new TreeMap<>();
map2.put("key", 1);             // O(log n)
map2.get("key");                // O(log n)
```

### HashSet vs TreeSet

```java
// HashSet：无序，O(1) 查找
Set<String> set1 = new HashSet<>();
set1.add("item");               // O(1)
set1.contains("item");          // O(1)

// TreeSet：有序，O(log n) 查找
Set<String> set2 = new TreeSet<>();
set2.add("item");               // O(log n)
set2.contains("item");          // O(log n)
```

## 适用场景说明

### 选择 List

- 需要保持元素顺序
- 允许重复元素
- 需要按索引访问

```java
List<String> names = new ArrayList<>();
names.add("张三");
names.add("李四");
String first = names.get(0);    // "张三"
```

### 选择 Set

- 不需要重复元素
- 需要快速查找
- 不需要顺序（或需要排序）

```java
Set<String> uniqueNames = new HashSet<>();
uniqueNames.add("张三");
uniqueNames.add("张三");         // 不会重复
```

### 选择 Map

- 需要键值对映射
- 需要快速查找
- 不需要顺序（或需要排序）

```java
Map<String, Integer> scores = new HashMap<>();
scores.put("张三", 90);
scores.put("李四", 85);
int score = scores.get("张三");  // 90
```

### 选择 Queue

- 需要 FIFO（先进先出）
- 需要优先级
- 需要双端操作

```java
Queue<String> queue = new LinkedList<>();
queue.offer("任务1");
queue.offer("任务2");
String task = queue.poll();      // "任务1"
```

## 性能对比

| 操作 | ArrayList | LinkedList | HashMap | TreeMap |
|:----:|:---------:|:----------:|:-------:|:-------:|
| 添加 | O(1) | O(1) | O(1) | O(log n) |
| 删除 | O(n) | O(1) | O(1) | O(log n) |
| 查找 | O(1) | O(n) | O(1) | O(log n) |
| 排序 | 需要排序 | 需要排序 | 无序 | 已排序 |

## 小结

Java 集合对照要点：

- **List**：有序可重复，ArrayList 和 LinkedList
- **Set**：无序不重复，HashSet 和 TreeSet
- **Map**：键值对，HashMap 和 TreeMap
- **Queue**：队列，LinkedList 和 PriorityQueue

**关键要点**：
- 根据需求选择合适的集合
- 了解各集合的性能特点
- 注意线程安全性
- 使用泛型保证类型安全

这是 Java 集合的快速对照参考，帮助你选择合适的集合类型。
