---
sidebar_position: 6
slug: /java-troubleshooting
sidebar_label: 常见 Java 问题与排错
---

# 常见 Java 问题与排错思路

理解常见问题和排错方法是解决实际开发问题的关键。本章将介绍常见 Java 问题与排错思路。

## 常见异常类型

### NullPointerException

**空指针异常**是最常见的异常。

```java
// 问题代码
String str = null;
int length = str.length();  // NullPointerException

// 解决方法
// 1. 检查 null
if (str != null) {
    int length = str.length();
}

// 2. 使用 Optional
Optional<String> optional = Optional.ofNullable(str);
optional.ifPresent(s -> System.out.println(s.length()));

// 3. 使用 Objects.requireNonNull
String str2 = Objects.requireNonNull(str, "字符串不能为null");
```

### ClassCastException

**类型转换异常**。

```java
// 问题代码
Object obj = "Hello";
Integer num = (Integer) obj;  // ClassCastException

// 解决方法
// 1. 使用 instanceof 检查
if (obj instanceof Integer) {
    Integer num = (Integer) obj;
}

// 2. 使用泛型
List<String> list = new ArrayList<>();
// 编译时类型安全
```

## 并发问题与死锁

### 并发问题

```java
// 问题：线程不安全
public class Counter {
    private int count = 0;
    
    public void increment() {
        count++;  // 非原子操作
    }
}

// 解决方法
// 1. 使用 synchronized
public synchronized void increment() {
    count++;
}

// 2. 使用原子类
private AtomicInteger count = new AtomicInteger(0);
public void increment() {
    count.incrementAndGet();
}
```

### 死锁

```java
// 问题：死锁
Thread thread1 = new Thread(() -> {
    synchronized (lock1) {
        synchronized (lock2) { }
    }
});

Thread thread2 = new Thread(() -> {
    synchronized (lock2) {
        synchronized (lock1) { }  // 可能死锁
    }
});

// 解决方法：按相同顺序获取锁
Thread thread2 = new Thread(() -> {
    synchronized (lock1) {  // 相同顺序
        synchronized (lock2) { }
    }
});
```

## 调试与日志分析

### 使用调试器

```java
// 设置断点
public void processData(String data) {
    int length = data.length();  // 断点
    String processed = process(data);
    System.out.println(processed);
}
```

### 日志分析

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DebugExample {
    private static final Logger logger = LoggerFactory.getLogger(DebugExample.class);
    
    public void processData(String data) {
        logger.debug("开始处理数据：{}", data);
        try {
            String result = process(data);
            logger.info("处理成功：{}", result);
        } catch (Exception e) {
            logger.error("处理失败：数据={}", data, e);
        }
    }
}
```

## 性能瓶颈排查

### 使用性能分析工具

```bash
# 使用 jstack 查看线程
jstack <pid>

# 使用 jmap 查看内存
jmap -heap <pid>

# 使用 jstat 查看 GC
jstat -gc <pid> 1000
```

### 代码分析

```java
// 使用 System.currentTimeMillis() 测量时间
long start = System.currentTimeMillis();
processData();
long end = System.currentTimeMillis();
System.out.println("耗时：" + (end - start) + "ms");

// 使用 System.nanoTime() 更精确
long start = System.nanoTime();
processData();
long end = System.nanoTime();
System.out.println("耗时：" + (end - start) / 1_000_000 + "ms");
```

## 小结

常见 Java 问题与排错要点：

- **NullPointerException**：检查 null，使用 Optional
- **ClassCastException**：使用 instanceof 检查
- **并发问题**：使用同步机制，使用原子类
- **死锁**：按相同顺序获取锁
- **调试**：使用调试器，分析日志
- **性能**：使用性能分析工具，测量代码执行时间

**关键要点**：
- 预防空指针异常
- 正确处理类型转换
- 注意并发安全
- 避免死锁
- 使用调试工具
- 分析性能瓶颈

理解了问题排错，你就能快速解决开发中的问题。恭喜你完成了第十一部分的学习！
