---
sidebar_position: 4
slug: /java-thread-synchronization
sidebar_label: Java 线程同步与锁
---

# Java 线程同步与锁机制

多线程环境下，共享资源的访问需要同步机制来保证线程安全。理解同步和锁机制是编写正确并发程序的关键。本章将详细介绍 Java 中的线程同步机制。

## synchronized 关键字

### synchronized 方法

**使用 `synchronized` 修饰方法**，锁对象是当前实例（`this`）。

```java
public class Counter {
    private int count = 0;
    
    // 同步方法
    public synchronized void increment() {
        count++;
    }
    
    public synchronized int getCount() {
        return count;
    }
}
```

**等价于**：

```java
public void increment() {
    synchronized (this) {
        count++;
    }
}
```

### synchronized 代码块

**使用 `synchronized` 代码块**，可以指定锁对象。

```java
public class Counter {
    private int count = 0;
    private final Object lock = new Object();
    
    public void increment() {
        synchronized (lock) {  // 使用指定对象作为锁
            count++;
        }
    }
}
```

### 静态同步方法

**静态同步方法**的锁对象是类对象（`Class` 对象）。

```java
public class Counter {
    private static int count = 0;
    
    // 静态同步方法
    public static synchronized void increment() {
        count++;
    }
}
```

**等价于**：

```java
public static void increment() {
    synchronized (Counter.class) {
        count++;
    }
}
```

### synchronized 的特点

**特点**：
- **可重入**：同一线程可以多次获取同一把锁
- **互斥**：同一时刻只有一个线程可以执行
- **自动释放**：方法执行完毕或异常时自动释放锁
- **不可中断**：获取锁的过程不可中断

```java
public class ReentrantExample {
    public synchronized void method1() {
        System.out.println("method1");
        method2();  // 可以调用，因为可重入
    }
    
    public synchronized void method2() {
        System.out.println("method2");
    }
}
```

## Lock（显示锁）

Lock 提供了一种无条件的、可轮询的、定时的以及可中断的锁获取操作，所有加锁和解锁的方法都是显示的。

### ReentrantLock（可重入锁）

**`ReentrantLock`** 是 Java 5 引入的显示锁，功能比 `synchronized` 更强大。它实现了 Lock 接口，并提供了与 synchronized 相同的互斥性和内存可见性，因此又称为可重入锁。

```java
import java.util.concurrent.locks.ReentrantLock;

public class Counter {
    private int count = 0;
    private final ReentrantLock lock = new ReentrantLock();
    
    public void increment() {
        lock.lock();  // 获取锁
        try {
            count++;
        } finally {
            lock.unlock();  // 释放锁（必须在 finally 中）
        }
    }
}
```

### ReentrantLock 的特性

#### 1. 可重入

```java
private final ReentrantLock lock = new ReentrantLock();

public void method1() {
    lock.lock();
    try {
        method2();  // 可以调用，因为可重入
    } finally {
        lock.unlock();
    }
}

public void method2() {
    lock.lock();
    try {
        // ...
    } finally {
        lock.unlock();
    }
}
```

#### 2. 可中断

```java
try {
    lock.lockInterruptibly();  // 可中断的获取锁
    try {
        // ...
    } finally {
        lock.unlock();
    }
} catch (InterruptedException e) {
    // 处理中断
}
```

#### 3. 尝试获取锁

```java
// 尝试获取锁，立即返回
if (lock.tryLock()) {
    try {
        // ...
    } finally {
        lock.unlock();
    }
}

// 尝试获取锁，指定超时时间
if (lock.tryLock(5, TimeUnit.SECONDS)) {
    try {
        // ...
    } finally {
        lock.unlock();
    }
} catch (InterruptedException e) {
    // 处理中断
}
```

#### 4. 公平锁

```java
// 公平锁：按照等待时间分配锁
ReentrantLock fairLock = new ReentrantLock(true);

// 非公平锁：默认
ReentrantLock unfairLock = new ReentrantLock(false);
```

### ReadWriteLock（读写锁）

**`ReadWriteLock`** 提供读写分离的锁。

```java
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

public class ReadWriteExample {
    private int value = 0;
    private final ReadWriteLock lock = new ReentrantReadWriteLock();
    
    // 读操作：可以并发
    public int read() {
        lock.readLock().lock();
        try {
            return value;
        } finally {
            lock.readLock().unlock();
        }
    }
    
    // 写操作：互斥
    public void write(int newValue) {
        lock.writeLock().lock();
        try {
            value = newValue;
        } finally {
            lock.writeLock().unlock();
        }
    }
}
```

## synchronized vs Lock 比较

### 对比表

| 特性 | synchronized | Lock |
|:----:|:------------:|:----:|
| 使用方式 | 关键字 | 接口 |
| 自动释放 | ✅ | ❌（需手动） |
| 可中断 | ❌ | ✅ |
| 尝试获取 | ❌ | ✅ |
| 公平锁 | ❌ | ✅ |
| 读写分离 | ❌ | ✅（ReadWriteLock） |
| 性能 | 较好 | 更好（高并发） |

### 选择建议

**使用 synchronized**：
- 简单场景
- 不需要高级功能
- 代码简洁

**使用 Lock**：
- 需要可中断
- 需要尝试获取锁
- 需要公平锁
- 需要读写分离
- 高并发场景

## 示例：线程安全计数器

### 示例 1：使用 synchronized

```java
public class SynchronizedCounter {
    private int count = 0;
    
    public synchronized void increment() {
        count++;
    }
    
    public synchronized void decrement() {
        count--;
    }
    
    public synchronized int getCount() {
        return count;
    }
    
    public static void main(String[] args) throws InterruptedException {
        SynchronizedCounter counter = new SynchronizedCounter();
        
        Thread t1 = new Thread(() -> {
            for (int i = 0; i < 10000; i++) {
                counter.increment();
            }
        });
        
        Thread t2 = new Thread(() -> {
            for (int i = 0; i < 10000; i++) {
                counter.increment();
            }
        });
        
        t1.start();
        t2.start();
        t1.join();
        t2.join();
        
        System.out.println("计数：" + counter.getCount());  // 20000
    }
}
```

### 示例 2：使用 ReentrantLock

```java
import java.util.concurrent.locks.ReentrantLock;

public class LockCounter {
    private int count = 0;
    private final ReentrantLock lock = new ReentrantLock();
    
    public void increment() {
        lock.lock();
        try {
            count++;
        } finally {
            lock.unlock();
        }
    }
    
    public void decrement() {
        lock.lock();
        try {
            count--;
        } finally {
            lock.unlock();
        }
    }
    
    public int getCount() {
        lock.lock();
        try {
            return count;
        } finally {
            lock.unlock();
        }
    }
}
```

### 示例 3：使用原子类（无锁）

```java
import java.util.concurrent.atomic.AtomicInteger;

public class AtomicCounter {
    private final AtomicInteger count = new AtomicInteger(0);
    
    public void increment() {
        count.incrementAndGet();
    }
    
    public void decrement() {
        count.decrementAndGet();
    }
    
    public int getCount() {
        return count.get();
    }
}
```

### 示例 4：读写锁示例

```java
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

public class ReadWriteCounter {
    private int count = 0;
    private final ReadWriteLock lock = new ReentrantReadWriteLock();
    
    // 读操作：可以并发
    public int read() {
        lock.readLock().lock();
        try {
            return count;
        } finally {
            lock.readLock().unlock();
        }
    }
    
    // 写操作：互斥
    public void write(int value) {
        lock.writeLock().lock();
        try {
            count = value;
        } finally {
            lock.writeLock().unlock();
        }
    }
    
    public static void main(String[] args) {
        ReadWriteCounter counter = new ReadWriteCounter();
        
        // 多个读线程可以并发
        for (int i = 0; i < 5; i++) {
            new Thread(() -> {
                for (int j = 0; j < 10; j++) {
                    System.out.println("读取：" + counter.read());
                }
            }).start();
        }
        
        // 写线程互斥
        new Thread(() -> {
            for (int i = 0; i < 10; i++) {
                counter.write(i);
                System.out.println("写入：" + i);
            }
        }).start();
    }
}
```

### 示例 5：锁的尝试获取

```java
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.TimeUnit;

public class TryLockExample {
    private final ReentrantLock lock = new ReentrantLock();
    
    public void method1() {
        if (lock.tryLock()) {
            try {
                System.out.println("method1 获取到锁");
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            } finally {
                lock.unlock();
            }
        } else {
            System.out.println("method1 未获取到锁");
        }
    }
    
    public void method2() {
        try {
            if (lock.tryLock(3, TimeUnit.SECONDS)) {
                try {
                    System.out.println("method2 获取到锁");
                } finally {
                    lock.unlock();
                }
            } else {
                System.out.println("method2 超时未获取到锁");
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
```

## 同步的最佳实践

### 1. 使用最小的同步范围

```java
// ✅ 推荐：只同步必要的代码
public void method() {
    // 不需要同步的代码
    doSomething();
    
    synchronized (this) {
        // 需要同步的代码
        count++;
    }
    
    // 不需要同步的代码
    doSomethingElse();
}

// ❌ 不推荐：同步整个方法
// public synchronized void method() {
//     // 所有代码都被同步
// }
```

### 2. 避免死锁

```java
// ✅ 推荐：按相同顺序获取锁
public void method1() {
    synchronized (lock1) {
        synchronized (lock2) {
            // ...
        }
    }
}

public void method2() {
    synchronized (lock1) {  // 相同顺序
        synchronized (lock2) {
            // ...
        }
    }
}
```

### 3. 使用 try-finally 释放锁

```java
// ✅ 推荐：确保锁被释放
lock.lock();
try {
    // ...
} finally {
    lock.unlock();
}
```

### 4. 避免在同步块中调用外部方法

```java
// ❌ 不推荐：可能造成死锁
synchronized (this) {
    externalMethod();  // 可能获取其他锁
}

// ✅ 推荐：先调用外部方法
Object result = externalMethod();
synchronized (this) {
    // 使用 result
}
```

## 小结

Java 线程同步与锁机制要点：

- **synchronized**：关键字，简单易用，自动释放锁
- **ReentrantLock**：显示锁，功能强大，需手动释放
- **ReadWriteLock**：读写分离锁，提高读并发性能
- **可重入**：同一线程可以多次获取同一把锁
- **线程安全**：使用同步机制保证共享资源安全

**关键要点**：
- synchronized 简单但功能有限
- ReentrantLock 功能强大但需手动管理
- 使用最小的同步范围
- 确保锁被正确释放
- 避免死锁

理解了线程同步与锁机制，你就能编写线程安全的程序。在下一章，我们将学习线程间通信。
