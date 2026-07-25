---
sidebar_position: 5
slug: /java-performance
sidebar_label: Java 性能优化入门
---

# Java 性能优化入门

性能优化是 Java 开发中的重要课题。理解性能优化的方法可以提高应用的运行效率。本章将介绍 Java 性能优化的基础知识。

## 内存管理与垃圾回收

### 对象创建优化

```java
// ❌ 不推荐：频繁创建对象
for (int i = 0; i < 1000; i++) {
    String str = new String("Hello");  // 每次都创建新对象
}

// ✅ 推荐：重用对象
String str = "Hello";
for (int i = 0; i < 1000; i++) {
    // 使用 str
}

// ✅ 推荐：使用对象池
ObjectPool<Connection> pool = new ObjectPool<>();
Connection conn = pool.borrow();
// 使用连接
pool.returnObject(conn);
```

### 垃圾回收优化

```java
// 及时释放引用
public void processData() {
    List<Data> largeList = loadLargeData();
    // 处理数据
    process(largeList);
    largeList = null;  // 帮助 GC
}

// 使用 try-with-resources 自动释放
try (Connection conn = getConnection()) {
    // 使用连接
}  // 自动关闭
```

## String、集合与循环优化

### String 优化

```java
// ❌ 不推荐：使用 + 拼接
String result = "";
for (String str : strings) {
    result += str;  // 性能差
}

// ✅ 推荐：使用 StringBuilder
StringBuilder sb = new StringBuilder();
for (String str : strings) {
    sb.append(str);
}
String result = sb.toString();

// ✅ 推荐：使用 String.join（Java 8+）
String result = String.join("", strings);
```

### 集合优化

```java
// ✅ 推荐：指定初始容量
List<String> list = new ArrayList<>(1000);  // 避免扩容
Map<String, Object> map = new HashMap<>(16, 0.75f);

// ✅ 推荐：使用合适的集合类型
// 需要顺序：LinkedHashMap
// 需要排序：TreeMap
// 只需要键：HashSet

// ✅ 推荐：使用 Stream API（Java 8+）
List<String> filtered = list.stream()
    .filter(s -> s.length() > 5)
    .collect(Collectors.toList());
```

### 循环优化

```java
// ✅ 推荐：使用增强 for 循环
for (String item : list) {
    process(item);
}

// ✅ 推荐：避免在循环中调用方法
int size = list.size();  // 缓存大小
for (int i = 0; i < size; i++) {
    process(list.get(i));
}

// ✅ 推荐：使用并行流（大数据量）
list.parallelStream()
    .filter(condition)
    .forEach(this::process);
```

## 并发性能优化

### 线程池使用

```java
// ✅ 推荐：使用线程池
ExecutorService executor = Executors.newFixedThreadPool(10);
for (int i = 0; i < 100; i++) {
    executor.submit(() -> processTask());
}
executor.shutdown();

// ❌ 不推荐：创建大量线程
for (int i = 0; i < 100; i++) {
    new Thread(() -> processTask()).start();  // 开销大
}
```

### 并发集合

```java
// ✅ 推荐：使用并发集合
ConcurrentHashMap<String, Object> map = new ConcurrentHashMap<>();
BlockingQueue<String> queue = new LinkedBlockingQueue<>();

// ✅ 推荐：使用原子类
AtomicInteger counter = new AtomicInteger(0);
counter.incrementAndGet();  // 无锁操作
```

## JVM 参数调优

### 堆内存设置

```bash
# 设置初始堆大小和最大堆大小
java -Xms512m -Xmx2g MyApp

# 设置新生代大小
java -Xmn256m MyApp
```

### GC 参数

```bash
# 使用 G1 垃圾回收器
java -XX:+UseG1GC MyApp

# 设置 GC 日志
java -Xlog:gc*:file=gc.log MyApp
```

### 其他参数

```bash
# 设置元空间大小
java -XX:MetaspaceSize=256m MyApp

# 启用压缩指针
java -XX:+UseCompressedOops MyApp
```

## 小结

Java 性能优化要点：

- **内存管理**：减少对象创建，及时释放引用
- **String 优化**：使用 StringBuilder，避免频繁拼接
- **集合优化**：指定初始容量，选择合适的集合类型
- **循环优化**：使用增强 for 循环，避免重复计算
- **并发优化**：使用线程池，使用并发集合
- **JVM 调优**：设置堆内存，选择合适的 GC

**关键要点**：
- 减少对象创建
- 使用 StringBuilder 拼接字符串
- 合理使用集合
- 优化循环性能
- 使用线程池管理线程
- 根据应用特点调优 JVM

理解了性能优化，你就能提高应用性能。在下一章，我们将学习常见 Java 问题与排错思路。
