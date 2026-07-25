---
sidebar_position: 8
slug: /java-thread-deadlock
sidebar_label: Java 死锁与并发问题
---

# Java 死锁与并发问题分析

死锁是多线程编程中的严重问题。理解死锁的产生条件和避免策略是编写可靠并发程序的关键。本章将详细介绍 Java 中的死锁问题。

## 死锁概念与条件

### 什么是死锁

**死锁**（Deadlock）是两个或多个线程相互等待对方释放资源，导致所有线程都无法继续执行。

### 死锁的四个必要条件

**同时满足以下四个条件才会发生死锁**：

1. **互斥条件**：资源不能被多个线程同时使用
2. **请求与保持**：线程持有资源的同时请求其他资源
3. **不可剥夺**：资源不能被强制释放
4. **循环等待**：存在循环等待链

### 死锁示例

```java
public class DeadlockExample {
    private static final Object lock1 = new Object();
    private static final Object lock2 = new Object();
    
    public static void main(String[] args) {
        Thread thread1 = new Thread(() -> {
            synchronized (lock1) {
                System.out.println("Thread1 获取 lock1");
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                synchronized (lock2) {  // 等待 lock2
                    System.out.println("Thread1 获取 lock2");
                }
            }
        });
        
        Thread thread2 = new Thread(() -> {
            synchronized (lock2) {
                System.out.println("Thread2 获取 lock2");
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                synchronized (lock1) {  // 等待 lock1
                    System.out.println("Thread2 获取 lock1");
                }
            }
        });
        
        thread1.start();
        thread2.start();
        
        // 可能发生死锁
    }
}
```

**死锁过程**：
1. Thread1 获取 lock1，Thread2 获取 lock2
2. Thread1 请求 lock2（被 Thread2 持有）
3. Thread2 请求 lock1（被 Thread1 持有）
4. 两个线程相互等待，形成死锁

## 检测与避免策略

### 死锁检测

#### 1. 使用 jstack 检测

```bash
# 获取 Java 进程 ID
jps

# 查看线程堆栈
jstack <pid>
```

**输出示例**：
```
Found one Java-level deadlock:
=============================
"Thread-1":
  waiting to lock monitor 0x...
  which is held by "Thread-2"
"Thread-2":
  waiting to lock monitor 0x...
  which is held by "Thread-1"
```

#### 2. 使用 JConsole 检测

- 打开 JConsole
- 选择线程标签
- 查看死锁检测

#### 3. 程序检测

```java
import java.lang.management.ManagementFactory;
import java.lang.management.ThreadMXBean;

public class DeadlockDetector {
    public static void detectDeadlock() {
        ThreadMXBean threadMX = ManagementFactory.getThreadMXBean();
        long[] deadlockedThreads = threadMX.findDeadlockedThreads();
        
        if (deadlockedThreads != null) {
            System.out.println("检测到死锁！");
            ThreadInfo[] threadInfos = threadMX.getThreadInfo(deadlockedThreads);
            for (ThreadInfo threadInfo : threadInfos) {
                System.out.println("死锁线程：" + threadInfo.getThreadName());
            }
        }
    }
}
```

### 避免死锁的策略

#### 1. 按相同顺序获取锁

**避免循环等待**：

```java
// ❌ 错误：不同顺序获取锁
public void method1() {
    synchronized (lock1) {
        synchronized (lock2) { }
    }
}

public void method2() {
    synchronized (lock2) {  // 不同顺序
        synchronized (lock1) { }
    }
}

// ✅ 正确：相同顺序获取锁
public void method1() {
    synchronized (lock1) {
        synchronized (lock2) { }
    }
}

public void method2() {
    synchronized (lock1) {  // 相同顺序
        synchronized (lock2) { }
    }
}
```

#### 2. 使用超时获取锁

**使用 `tryLock()` 避免无限等待**：

```java
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.TimeUnit;

private final ReentrantLock lock1 = new ReentrantLock();
private final ReentrantLock lock2 = new ReentrantLock();

public void method() {
    if (lock1.tryLock()) {
        try {
            if (lock2.tryLock(5, TimeUnit.SECONDS)) {
                try {
                    // 执行操作
                } finally {
                    lock2.unlock();
                }
            } else {
                // 获取 lock2 失败，释放 lock1
            }
        } finally {
            lock1.unlock();
        }
    }
}
```

#### 3. 避免嵌套锁

**尽量减少锁的嵌套**：

```java
// ❌ 不推荐：深层嵌套
synchronized (lock1) {
    synchronized (lock2) {
        synchronized (lock3) {
            // 容易死锁
        }
    }
}

// ✅ 推荐：减少嵌套
// 重构代码，减少锁的嵌套
```

#### 4. 使用锁超时

**设置锁的超时时间**：

```java
private final ReentrantLock lock = new ReentrantLock();

public void method() {
    try {
        if (lock.tryLock(5, TimeUnit.SECONDS)) {
            try {
                // 执行操作
            } finally {
                lock.unlock();
            }
        } else {
            // 超时未获取到锁
            System.out.println("获取锁超时");
        }
    } catch (InterruptedException e) {
        Thread.currentThread().interrupt();
    }
}
```

#### 5. 使用无锁数据结构

**使用原子类和并发集合**：

```java
// 使用原子类替代锁
private final AtomicInteger count = new AtomicInteger(0);

public void increment() {
    count.incrementAndGet();  // 无锁操作
}

// 使用并发集合
private final ConcurrentHashMap<String, Integer> map = new ConcurrentHashMap<>();
```

## 示例：简单死锁演示

### 示例 1：经典死锁

```java
public class ClassicDeadlock {
    private static final Object lock1 = new Object();
    private static final Object lock2 = new Object();
    
    public static void main(String[] args) {
        Thread thread1 = new Thread(() -> {
            synchronized (lock1) {
                System.out.println("Thread1 持有 lock1");
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                synchronized (lock2) {
                    System.out.println("Thread1 持有 lock2");
                }
            }
        });
        
        Thread thread2 = new Thread(() -> {
            synchronized (lock2) {
                System.out.println("Thread2 持有 lock2");
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                synchronized (lock1) {
                    System.out.println("Thread2 持有 lock1");
                }
            }
        });
        
        thread1.start();
        thread2.start();
        
        // 可能发生死锁
    }
}
```

### 示例 2：避免死锁（相同顺序）

```java
public class AvoidDeadlock {
    private static final Object lock1 = new Object();
    private static final Object lock2 = new Object();
    
    public static void main(String[] args) {
        Thread thread1 = new Thread(() -> {
            synchronized (lock1) {
                System.out.println("Thread1 持有 lock1");
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                synchronized (lock2) {  // 先 lock1，后 lock2
                    System.out.println("Thread1 持有 lock2");
                }
            }
        });
        
        Thread thread2 = new Thread(() -> {
            synchronized (lock1) {  // 相同顺序：先 lock1
                System.out.println("Thread2 持有 lock1");
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                synchronized (lock2) {  // 后 lock2
                    System.out.println("Thread2 持有 lock2");
                }
            }
        });
        
        thread1.start();
        thread2.start();
        
        // 不会死锁
    }
}
```

### 示例 3：使用 tryLock 避免死锁

```java
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.TimeUnit;

public class TryLockDeadlockAvoidance {
    private static final ReentrantLock lock1 = new ReentrantLock();
    private static final ReentrantLock lock2 = new ReentrantLock();
    
    public static void method1() {
        boolean lock1Acquired = false;
        boolean lock2Acquired = false;
        
        try {
            lock1Acquired = lock1.tryLock(5, TimeUnit.SECONDS);
            if (lock1Acquired) {
                lock2Acquired = lock2.tryLock(5, TimeUnit.SECONDS);
                if (lock2Acquired) {
                    // 执行操作
                    System.out.println("method1 执行");
                }
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        } finally {
            if (lock2Acquired) {
                lock2.unlock();
            }
            if (lock1Acquired) {
                lock1.unlock();
            }
        }
    }
    
    public static void method2() {
        boolean lock1Acquired = false;
        boolean lock2Acquired = false;
        
        try {
            lock1Acquired = lock1.tryLock(5, TimeUnit.SECONDS);
            if (lock1Acquired) {
                lock2Acquired = lock2.tryLock(5, TimeUnit.SECONDS);
                if (lock2Acquired) {
                    // 执行操作
                    System.out.println("method2 执行");
                }
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        } finally {
            if (lock2Acquired) {
                lock2.unlock();
            }
            if (lock1Acquired) {
                lock1.unlock();
            }
        }
    }
}
```

### 示例 4：死锁检测工具

```java
import java.lang.management.ManagementFactory;
import java.lang.management.ThreadMXBean;
import java.lang.management.ThreadInfo;

public class DeadlockDetector {
    private static final ThreadMXBean threadMX = ManagementFactory.getThreadMXBean();
    
    public static void detectAndPrintDeadlocks() {
        long[] deadlockedThreads = threadMX.findDeadlockedThreads();
        if (deadlockedThreads != null) {
            System.out.println("检测到死锁！");
            ThreadInfo[] threadInfos = threadMX.getThreadInfo(deadlockedThreads);
            for (ThreadInfo threadInfo : threadInfos) {
                System.out.println("死锁线程：" + threadInfo.getThreadName());
                System.out.println("等待锁：" + threadInfo.getLockInfo());
            }
        } else {
            System.out.println("未检测到死锁");
        }
    }
    
    public static void main(String[] args) throws InterruptedException {
        // 启动可能死锁的线程
        // ...
        
        Thread.sleep(2000);
        detectAndPrintDeadlocks();
    }
}
```

## 其他并发问题

### 活锁（Livelock）

**活锁**：线程不断改变状态，但无法继续执行。

```java
// 活锁示例：两个线程相互让路
public class LivelockExample {
    private boolean flag = true;
    
    public void method1() {
        while (flag) {
            Thread.yield();  // 让出 CPU
        }
    }
    
    public void method2() {
        while (!flag) {
            Thread.yield();  // 让出 CPU
        }
    }
}
```

### 饥饿（Starvation）

**饥饿**：线程长时间无法获取资源。

**原因**：
- 线程优先级过低
- 锁竞争激烈
- 资源分配不公平

### 竞态条件（Race Condition）

**竞态条件**：多个线程访问共享资源，结果依赖于执行顺序。

```java
// 竞态条件示例
public class RaceCondition {
    private int count = 0;
    
    public void increment() {
        count++;  // 不是原子操作
    }
}
```

## 避免并发问题的最佳实践

### 1. 使用线程安全的数据结构

```java
// ✅ 推荐
ConcurrentHashMap<String, Integer> map = new ConcurrentHashMap<>();
AtomicInteger count = new AtomicInteger(0);

// ❌ 不推荐
// HashMap<String, Integer> map = new HashMap<>();
// int count = 0;
```

### 2. 最小化同步范围

```java
// ✅ 推荐：只同步必要的代码
synchronized (lock) {
    // 需要同步的代码
}

// ❌ 不推荐：同步整个方法
// public synchronized void method() { }
```

### 3. 使用不可变对象

```java
// ✅ 推荐：不可变对象，线程安全
public final class ImmutableValue {
    private final int value;
    
    public ImmutableValue(int value) {
        this.value = value;
    }
    
    public int getValue() {
        return value;
    }
}
```

### 4. 避免共享可变状态

```java
// ✅ 推荐：使用局部变量
public void method() {
    int local = 0;  // 局部变量，线程安全
    local++;
}

// ❌ 不推荐：共享可变状态
// private int shared = 0;  // 需要同步
```

## 小结

Java 死锁与并发问题要点：

- **死锁条件**：互斥、请求与保持、不可剥夺、循环等待
- **检测方法**：jstack、JConsole、程序检测
- **避免策略**：相同顺序、超时获取、减少嵌套、无锁数据结构
- **其他问题**：活锁、饥饿、竞态条件

**关键要点**：
- 死锁需要四个条件同时满足
- 按相同顺序获取锁避免死锁
- 使用 tryLock 设置超时
- 使用工具检测死锁
- 避免共享可变状态

理解了死锁与并发问题，你就能编写更可靠的并发程序。恭喜你完成了第七部分的学习！
