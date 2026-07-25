---
sidebar_position: 5
slug: /java-map
sidebar_label: Java Map 集合
---

# Java Map 集合

Map 是 Java 集合框架中用于存储键值对的接口。理解 Map 的实现类和使用方法是处理映射关系的基础。本章将详细介绍 Java 中的 Map 集合。

## Java Map 集合类型

HashMap、LinkedHashMap、TreeMap 是 Java 的三大 Map 集合类型，下面逐一介绍。

### HashMap

**`HashMap`** 是基于哈希表实现的，使用数组+链表+红黑树（Java 8+）结构。

**特点**：
- **无序**：键值对没有固定顺序
- **键唯一**：每个 key 只能对应一个 value
- **查找快**：平均时间复杂度 O(1)
- **允许 null**：key 和 value 都可以为 null（但只能有一个 null key）
- **线程不安全**：多线程环境下需要同步

```java
import java.util.HashMap;
import java.util.Map;

Map<String, Integer> map = new HashMap<>();
map.put("apple", 10);
map.put("banana", 20);
map.put("orange", 30);

System.out.println(map);  // {banana=20, orange=30, apple=10}（顺序不确定）
System.out.println(map.get("apple"));  // 10
```

### LinkedHashMap

**`LinkedHashMap`** 是 HashMap 的子类，使用链表维护插入顺序。

**特点**：
- **有序**：保持插入顺序
- **键唯一**：每个 key 只能对应一个 value
- **查找快**：平均时间复杂度 O(1)
- **性能略低**：比 HashMap 略慢（需要维护链表）

```java
import java.util.LinkedHashMap;

Map<String, Integer> map = new LinkedHashMap<>();
map.put("apple", 10);
map.put("banana", 20);
map.put("orange", 30);

System.out.println(map);  // {apple=10, banana=20, orange=30}（保持插入顺序）
```

### TreeMap

**`TreeMap`** 是基于红黑树实现的，按键的自然顺序或指定比较器排序。

**特点**：
- **有序**：按键自动排序
- **键唯一**：每个 key 只能对应一个 value
- **查找较慢**：时间复杂度 O(log n)
- **支持范围查询**：可以高效查询范围内的键

```java
import java.util.TreeMap;

Map<String, Integer> map = new TreeMap<>();
map.put("orange", 30);
map.put("apple", 10);
map.put("banana", 20);

System.out.println(map);  // {apple=10, banana=20, orange=30}（按键排序）
```

## key-value 操作

### 添加和更新

```java
Map<String, Integer> map = new HashMap<>();

// 添加键值对
map.put("apple", 10);      // 添加新键值对
map.put("banana", 20);     // 添加新键值对
map.put("apple", 30);      // 更新已存在的键的值

// 如果不存在则添加
map.putIfAbsent("orange", 40);  // 如果 "orange" 不存在，则添加

// 批量添加
Map<String, Integer> anotherMap = new HashMap<>();
anotherMap.put("grape", 50);
anotherMap.put("mango", 60);
map.putAll(anotherMap);
```

### 获取值

```java
Map<String, Integer> map = new HashMap<>();
map.put("apple", 10);
map.put("banana", 20);

// 获取值
Integer value = map.get("apple");  // 10

// 获取值，如果不存在返回默认值
Integer value2 = map.getOrDefault("orange", 0);  // 0（不存在，返回默认值）

// 检查键是否存在
boolean containsKey = map.containsKey("apple");  // true

// 检查值是否存在
boolean containsValue = map.containsValue(10);  // true
```

### 删除

```java
Map<String, Integer> map = new HashMap<>();
map.put("apple", 10);
map.put("banana", 20);
map.put("orange", 30);

// 按键删除
Integer removed = map.remove("apple");  // 返回删除的值：10

// 按键值对删除（只有键和值都匹配才删除）
boolean removed2 = map.remove("banana", 25);  // false（值不匹配）
boolean removed3 = map.remove("banana", 20);  // true（键值都匹配）

// 清空
map.clear();  // 删除所有键值对
```

### 替换

```java
Map<String, Integer> map = new HashMap<>();
map.put("apple", 10);
map.put("banana", 20);

// 替换值
map.replace("apple", 15);  // 替换为 15

// 只有旧值匹配才替换
boolean replaced = map.replace("banana", 20, 25);  // true（旧值是 20，替换为 25）

// 替换所有值
map.replaceAll((key, value) -> value * 2);  // 所有值乘以 2
```

## 遍历 Map 方法

### 方法 1：遍历键

```java
Map<String, Integer> map = new HashMap<>();
map.put("apple", 10);
map.put("banana", 20);

// 遍历所有键
for (String key : map.keySet()) {
    System.out.println(key + " = " + map.get(key));
}

// 使用迭代器
Iterator<String> iterator = map.keySet().iterator();
while (iterator.hasNext()) {
    String key = iterator.next();
    System.out.println(key + " = " + map.get(key));
}
```

### 方法 2：遍历值

```java
// 遍历所有值
for (Integer value : map.values()) {
    System.out.println(value);
}
```

### 方法 3：遍历键值对（推荐）

```java
// 遍历所有键值对
for (Map.Entry<String, Integer> entry : map.entrySet()) {
    String key = entry.getKey();
    Integer value = entry.getValue();
    System.out.println(key + " = " + value);
}

// 使用迭代器
Iterator<Map.Entry<String, Integer>> iterator = map.entrySet().iterator();
while (iterator.hasNext()) {
    Map.Entry<String, Integer> entry = iterator.next();
    System.out.println(entry.getKey() + " = " + entry.getValue());
}
```

### 方法 4：Lambda 表达式（Java 8+）

```java
// 遍历键值对
map.forEach((key, value) -> {
    System.out.println(key + " = " + value);
});

// 或使用方法引用
map.forEach((key, value) -> System.out.println(key + " = " + value));
```

### 方法 5：Stream API（Java 8+）

```java
// 过滤和遍历
map.entrySet().stream()
    .filter(entry -> entry.getValue() > 15)
    .forEach(entry -> System.out.println(entry.getKey() + " = " + entry.getValue()));
```

## 示例：统计词频、计数器实现

### 示例 1：统计词频

```java
import java.util.*;

public class WordFrequency {
    public static Map<String, Integer> countWords(String text) {
        Map<String, Integer> frequency = new HashMap<>();
        
        // 分割单词
        String[] words = text.toLowerCase().split("\\s+");
        
        // 统计词频
        for (String word : words) {
            frequency.put(word, frequency.getOrDefault(word, 0) + 1);
        }
        
        return frequency;
    }
    
    public static void main(String[] args) {
        String text = "apple banana apple orange banana apple";
        Map<String, Integer> frequency = countWords(text);
        
        // 按频率排序
        frequency.entrySet().stream()
            .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
            .forEach(entry -> System.out.println(entry.getKey() + ": " + entry.getValue()));
    }
}
```

### 示例 2：计数器实现

```java
import java.util.*;

public class Counter {
    private Map<String, Integer> counts = new HashMap<>();
    
    public void increment(String key) {
        counts.put(key, counts.getOrDefault(key, 0) + 1);
    }
    
    public void decrement(String key) {
        counts.put(key, Math.max(0, counts.getOrDefault(key, 0) - 1));
    }
    
    public int getCount(String key) {
        return counts.getOrDefault(key, 0);
    }
    
    public void reset(String key) {
        counts.remove(key);
    }
    
    public void resetAll() {
        counts.clear();
    }
    
    public Map<String, Integer> getAllCounts() {
        return new HashMap<>(counts);
    }
    
    public static void main(String[] args) {
        Counter counter = new Counter();
        counter.increment("apple");
        counter.increment("apple");
        counter.increment("banana");
        
        System.out.println("apple 计数：" + counter.getCount("apple"));  // 2
        System.out.println("banana 计数：" + counter.getCount("banana"));  // 1
    }
}
```

### 示例 3：Map 基本操作

```java
import java.util.*;

public class MapExample {
    public static void main(String[] args) {
        Map<String, Integer> map = new HashMap<>();
        
        // 添加
        map.put("apple", 10);
        map.put("banana", 20);
        map.put("orange", 30);
        
        // 获取
        Integer appleCount = map.get("apple");
        Integer grapeCount = map.getOrDefault("grape", 0);
        
        // 检查
        boolean hasApple = map.containsKey("apple");
        boolean hasValue10 = map.containsValue(10);
        
        // 大小
        int size = map.size();
        boolean empty = map.isEmpty();
        
        // 遍历
        System.out.println("遍历键值对：");
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            System.out.println(entry.getKey() + " = " + entry.getValue());
        }
        
        // 删除
        Integer removed = map.remove("apple");
        map.clear();
    }
}
```

### 示例 4：TreeMap 排序

```java
import java.util.*;

public class TreeMapExample {
    public static void main(String[] args) {
        // 自然排序
        Map<String, Integer> map = new TreeMap<>();
        map.put("orange", 30);
        map.put("apple", 10);
        map.put("banana", 20);
        System.out.println("自然排序：" + map);  // {apple=10, banana=20, orange=30}
        
        // 自定义排序（降序）
        Map<String, Integer> mapDesc = new TreeMap<>(Collections.reverseOrder());
        mapDesc.put("orange", 30);
        mapDesc.put("apple", 10);
        mapDesc.put("banana", 20);
        System.out.println("降序排序：" + mapDesc);  // {orange=30, banana=20, apple=10}
        
        // 按值排序
        Map<String, Integer> map2 = new HashMap<>();
        map2.put("apple", 30);
        map2.put("banana", 10);
        map2.put("orange", 20);
        
        // 转换为 List 排序
        List<Map.Entry<String, Integer>> list = new ArrayList<>(map2.entrySet());
        list.sort(Map.Entry.comparingByValue());
        System.out.println("按值排序：" + list);
    }
}
```

### 示例 5：Map 的视图操作

```java
import java.util.*;

public class MapViews {
    public static void main(String[] args) {
        Map<String, Integer> map = new HashMap<>();
        map.put("apple", 10);
        map.put("banana", 20);
        map.put("orange", 30);
        
        // 键视图
        Set<String> keys = map.keySet();
        System.out.println("所有键：" + keys);
        
        // 值视图
        Collection<Integer> values = map.values();
        System.out.println("所有值：" + values);
        
        // 键值对视图
        Set<Map.Entry<String, Integer>> entries = map.entrySet();
        System.out.println("所有键值对：" + entries);
        
        // 注意：视图的修改会影响原 Map
        keys.remove("apple");  // 从视图中删除，原 Map 也会删除
        System.out.println("删除后：" + map);  // {banana=20, orange=30}
    }
}
```

## Map 的选择建议

#### 使用 HashMap

- 不需要顺序
- 需要快速查找
- 键不需要排序

#### 使用 LinkedHashMap

- 需要保持插入顺序
- 需要快速查找
- 键不需要排序

#### 使用 TreeMap

- 需要按键排序
- 需要范围查询
- 可以接受 `O(log n)` 的查找时间

## Map 的最佳实践

### 1. 使用合适的实现类

```java
// 不需要顺序：HashMap
Map<String, Integer> map1 = new HashMap<>();

// 需要保持顺序：LinkedHashMap
Map<String, Integer> map2 = new LinkedHashMap<>();

// 需要排序：TreeMap
Map<String, Integer> map3 = new TreeMap<>();
```

### 2. 使用 getOrDefault

```java
// ✅ 推荐：使用 getOrDefault
int count = map.getOrDefault("key", 0);

// ❌ 不推荐：手动检查
// Integer value = map.get("key");
// int count = value != null ? value : 0;
```

### 3. 遍历时使用 entrySet

```java
// ✅ 推荐：使用 entrySet（性能更好）
for (Map.Entry<String, Integer> entry : map.entrySet()) {
    // ...
}

// ❌ 不推荐：使用 keySet + get（性能较差）
// for (String key : map.keySet()) {
//     Integer value = map.get(key);
// }
```

### 4. 注意视图的修改

```java
// 视图的修改会影响原 Map
Set<String> keys = map.keySet();
keys.remove("key");  // 原 Map 也会删除
```

## 小结

Java Map 集合要点：

- **HashMap**：无序，查找快，基于哈希表
- **LinkedHashMap**：保持插入顺序，查找快
- **TreeMap**：按键排序，支持范围查询，基于红黑树
- **基本操作**：put、get、remove、containsKey 等
- **遍历方法**：keySet、values、entrySet

**关键要点**：
- Map 存储键值对，键唯一
- 使用 entrySet 遍历性能更好
- 根据需求选择合适的实现类
- 注意视图的修改会影响原 Map
- 使用 getOrDefault 简化代码

理解了 Map 集合，你就能处理键值对映射关系。在下一章，我们将学习 Java 的 Queue 和 Deque。
