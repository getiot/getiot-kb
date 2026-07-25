---
sidebar_position: 7
slug: /java-concurrency-utils
sidebar_label: Java 并发工具类
---

# Java 并发工具类（JUC）

Java 并发工具包（java.util.concurrent，JUC）提供了丰富的并发工具类。理解这些工具类的使用是进行高效并发编程的关键。本章将详细介绍 Java 中的并发工具类。

## 常用的并发工具

### CountDownLatch（倒计时门闩）

**`CountDownLatch`** 是一个非常实用的多线程控制工具类，用于等待一个或多个线程完成操作。

**特点**：
- 计数器只能减，不能增
- 计数器为 0 时，等待的线程被唤醒
- 一次性使用

```java
import java.util.concurrent.CountDownLatch;

public class CountDownLatchExample {
    public static void main(String[] args) throws InterruptedException {
        int threadCount = 5;
        CountDownLatch latch = new CountDownLatch(threadCount);
        
        // 创建多个线程
        for (int i = 0; i < threadCount; i++) {
            final int threadId = i;
            new Thread(() -> {
                try {
                    System.out.println("线程 " + threadId + " 开始执行");
                    Thread.sleep(2000);
                    System.out.println("线程 " + threadId + " 执行完成");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } finally {
                    latch.countDown();  // 计数减 1
                }
            }).start();
        }
        
        latch.await();  // 等待所有线程完成
        System.out.println("所有线程执行完成");
    }
}
```

### CyclicBarrier（循环屏障）

**`CyclicBarrier`** 用于多个线程相互等待，到达屏障点后继续执行。

**特点**：
- 可以重复使用
- 所有线程到达屏障点后继续执行
- 可以指定到达屏障点后的动作

```java
import java.util.concurrent.CyclicBarrier;

public class CyclicBarrierExample {
    public static void main(String[] args) {
        int threadCount = 3;
        CyclicBarrier barrier = new CyclicBarrier(threadCount, () -> {
            System.out.println("所有线程到达屏障点");
        });
        
        for (int i = 0; i < threadCount; i++) {
            final int threadId = i;
            new Thread(() -> {
                try {
                    System.out.println("线程 " + threadId + " 到达屏障点");
                    barrier.await();  // 等待其他线程
                    System.out.println("线程 " + threadId + " 继续执行");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();
        }
    }
}
```

### Semaphore（信号量）

**`Semaphore`** 用于控制同时访问资源的线程数量。

**特点**：
- 可以控制并发数
- 可以获取和释放许可
- 适合资源池场景

```java
import java.util.concurrent.Semaphore;

public class SemaphoreExample {
    public static void main(String[] args) {
        Semaphore semaphore = new Semaphore(3);  // 允许 3 个线程同时访问
        
        for (int i = 0; i < 10; i++) {
            final int threadId = i;
            new Thread(() -> {
                try {
                    semaphore.acquire();  // 获取许可
                    System.out.println("线程 " + threadId + " 获取许可");
                    Thread.sleep(2000);
                    System.out.println("线程 " + threadId + " 释放许可");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } finally {
                    semaphore.release();  // 释放许可
                }
            }).start();
        }
    }
}
```

### ConcurrentHashMap（并发哈希表）

**`ConcurrentHashMap`** 是线程安全的 HashMap。

**特点**：
- 线程安全
- 分段锁机制，性能好
- 支持并发读写

```java
import java.util.concurrent.ConcurrentHashMap;

ConcurrentHashMap<String, Integer> map = new ConcurrentHashMap<>();

// 线程安全的操作
map.put("key1", 1);
map.put("key2", 2);
Integer value = map.get("key1");

// 原子操作
map.putIfAbsent("key3", 3);
map.replace("key1", 1, 10);
map.compute("key1", (k, v) -> v + 1);
```

## 原子类（AtomicInteger 等）

### 原子类概述

**原子类**提供了无锁的线程安全操作，基于 CAS（Compare-And-Swap）实现。

**常用原子类**：
- `AtomicInteger`：原子整数
- `AtomicLong`：原子长整数
- `AtomicBoolean`：原子布尔值
- `AtomicReference`：原子引用

### AtomicInteger

```java
import java.util.concurrent.atomic.AtomicInteger;

public class AtomicIntegerExample {
    private final AtomicInteger count = new AtomicInteger(0);
    
    public void increment() {
        count.incrementAndGet();  // 原子操作
    }
    
    public void decrement() {
        count.decrementAndGet();
    }
    
    public int get() {
        return count.get();
    }
    
    // 其他常用方法
    public void add(int delta) {
        count.addAndGet(delta);
    }
    
    public boolean compareAndSet(int expect, int update) {
        return count.compareAndSet(expect, update);
    }
}
```

### 原子类的优势

**无锁编程**：
- 性能更好（无锁）
- 避免死锁
- 适合高并发场景

```java
// 使用 synchronized（有锁）
public class SynchronizedCounter {
    private int count = 0;
    
    public synchronized void increment() {
        count++;
    }
}

// 使用 AtomicInteger（无锁）
public class AtomicCounter {
    private final AtomicInteger count = new AtomicInteger(0);
    
    public void increment() {
        count.incrementAndGet();
    }
}
```

## 示例：并发任务协调

### 示例 1：CountDownLatch 协调

```java
import java.util.concurrent.CountDownLatch;

public class CountDownLatchCoordinator {
    public static void main(String[] args) throws InterruptedException {
        int taskCount = 5;
        CountDownLatch startLatch = new CountDownLatch(1);
        CountDownLatch finishLatch = new CountDownLatch(taskCount);
        
        // 创建多个任务
        for (int i = 0; i < taskCount; i++) {
            final int taskId = i;
            new Thread(() -> {
                try {
                    startLatch.await();  // 等待开始信号
                    System.out.println("任务 " + taskId + " 执行");
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } finally {
                    finishLatch.countDown();
                }
            }).start();
        }
        
        System.out.println("准备开始...");
        Thread.sleep(1000);
        startLatch.countDown();  // 发出开始信号
        
        finishLatch.await();  // 等待所有任务完成
        System.out.println("所有任务完成");
    }
}
```

### 示例 2：CyclicBarrier 协调

```java
import java.util.concurrent.CyclicBarrier;

public class CyclicBarrierCoordinator {
    public static void main(String[] args) {
        int threadCount = 3;
        CyclicBarrier barrier = new CyclicBarrier(threadCount, () -> {
            System.out.println("所有线程完成第一阶段");
        });
        
        for (int i = 0; i < threadCount; i++) {
            final int threadId = i;
            new Thread(() -> {
                try {
                    // 第一阶段
                    System.out.println("线程 " + threadId + " 第一阶段");
                    barrier.await();
                    
                    // 第二阶段
                    System.out.println("线程 " + threadId + " 第二阶段");
                    barrier.await();
                    
                    // 第三阶段
                    System.out.println("线程 " + threadId + " 第三阶段");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();
        }
    }
}
```

### 示例 3：Semaphore 控制并发

```java
import java.util.concurrent.Semaphore;

public class SemaphoreCoordinator {
    public static void main(String[] args) {
        Semaphore semaphore = new Semaphore(3);  // 最多 3 个并发
        
        for (int i = 0; i < 10; i++) {
            final int taskId = i;
            new Thread(() -> {
                try {
                    semaphore.acquire();
                    System.out.println("任务 " + taskId + " 开始执行");
                    Thread.sleep(2000);
                    System.out.println("任务 " + taskId + " 执行完成");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } finally {
                    semaphore.release();
                }
            }).start();
        }
    }
}
```

### 示例 4：ConcurrentHashMap 使用

```java
import java.util.concurrent.ConcurrentHashMap;

public class ConcurrentHashMapExample {
    public static void main(String[] args) {
        ConcurrentHashMap<String, Integer> map = new ConcurrentHashMap<>();
        
        // 多线程写入
        for (int i = 0; i < 10; i++) {
            final int value = i;
            new Thread(() -> {
                map.put("key" + value, value);
            }).start();
        }
        
        // 原子操作
        map.compute("key1", (k, v) -> v == null ? 1 : v + 1);
        map.merge("key2", 1, Integer::sum);
        
        // 线程安全的遍历
        map.forEach((k, v) -> System.out.println(k + " = " + v));
    }
}
```

### 示例 5：原子类使用

```java
import java.util.concurrent.atomic.AtomicInteger;

public class AtomicExample {
    private static final AtomicInteger counter = new AtomicInteger(0);
    
    public static void main(String[] args) throws InterruptedException {
        // 多个线程并发增加
        Thread[] threads = new Thread[10];
        for (int i = 0; i < 10; i++) {
            threads[i] = new Thread(() -> {
                for (int j = 0; j < 1000; j++) {
                    counter.incrementAndGet();
                }
            });
            threads[i].start();
        }
        
        // 等待所有线程完成
        for (Thread thread : threads) {
            thread.join();
        }
        
        System.out.println("最终计数：" + counter.get());  // 10000
    }
}
```

### 示例 6：综合使用

```java
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;

public class ConcurrencyUtilsExample {
    private static final AtomicInteger taskCounter = new AtomicInteger(0);
    private static final ConcurrentHashMap<String, Integer> results = new ConcurrentHashMap<>();
    
    public static void main(String[] args) throws InterruptedException {
        int threadCount = 5;
        CountDownLatch latch = new CountDownLatch(threadCount);
        Semaphore semaphore = new Semaphore(3);  // 最多 3 个并发
        
        ExecutorService executor = Executors.newFixedThreadPool(threadCount);
        
        for (int i = 0; i < threadCount; i++) {
            final int taskId = i;
            executor.submit(() -> {
                try {
                    semaphore.acquire();
                    int taskNum = taskCounter.incrementAndGet();
                    System.out.println("任务 " + taskId + " 执行（任务编号：" + taskNum + "）");
                    Thread.sleep(2000);
                    results.put("task" + taskId, taskId * 10);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } finally {
                    semaphore.release();
                    latch.countDown();
                }
            });
        }
        
        latch.await();
        System.out.println("所有任务完成，结果：" + results);
        executor.shutdown();
    }
}
```

## 并发工具类的选择

### CountDownLatch

- 等待一个或多个线程完成
- 一次性使用
- 主线程等待子线程

### CyclicBarrier

- 多个线程相互等待
- 可以重复使用
- 分阶段执行

### Semaphore

- 控制并发数
- 资源池场景
- 限流

### ConcurrentHashMap

- 线程安全的 Map
- 高并发读写
- 替代 Hashtable

### 原子类

- 无锁编程
- 高并发计数
- 简单操作

## 小结

Java 并发工具类要点：

- **CountDownLatch**：等待线程完成，一次性使用
- **CyclicBarrier**：线程相互等待，可重复使用
- **Semaphore**：控制并发数，资源池
- **ConcurrentHashMap**：线程安全的 Map
- **原子类**：无锁线程安全操作

**关键要点**：
- CountDownLatch 用于等待
- CyclicBarrier 用于同步
- Semaphore 用于限流
- ConcurrentHashMap 替代 Hashtable
- 原子类提供无锁操作

理解了并发工具类，你就能高效地协调并发任务。在下一章，我们将学习死锁与并发问题分析。
