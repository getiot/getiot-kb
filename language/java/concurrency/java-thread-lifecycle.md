---
sidebar_position: 3
slug: /java-thread-lifecycle
sidebar_label: Java 线程生命周期
---

# Java 线程生命周期与状态

线程从创建到销毁会经历不同的状态。理解线程的生命周期和状态转换是掌握多线程编程的关键。本章将详细介绍 Java 中线程的生命周期。

## 线程生命周期

### 线程状态枚举

Java 中线程有 6 种状态（`Thread.State` 枚举）：

1. **NEW**：新建状态
2. **RUNNABLE**：可运行状态
3. **BLOCKED**：阻塞状态
4. **WAITING**：等待状态
5. **TIMED_WAITING**：定时等待状态
6. **TERMINATED**：终止状态

### NEW（新建）

**线程被创建但尚未启动**。

```java
Thread thread = new Thread(() -> {
    System.out.println("线程执行");
});

System.out.println(thread.getState());  // NEW
```

**特点**：
- 线程对象已创建
- 尚未调用 `start()` 方法
- 不能执行

### RUNNABLE（可运行）

**线程正在 JVM 中执行，但可能正在等待操作系统资源**。

```java
Thread thread = new Thread(() -> {
    System.out.println("线程执行");
});
thread.start();

System.out.println(thread.getState());  // RUNNABLE
```

**特点**：
- 已调用 `start()` 方法
- 可能在运行，也可能在等待 CPU
- 包括"运行中"和"就绪"两种子状态

### BLOCKED（阻塞）

**线程被阻塞，等待获取监视器锁**。

```java
public class BlockedExample {
    private static final Object lock = new Object();
    
    public static void main(String[] args) {
        Thread thread1 = new Thread(() -> {
            synchronized (lock) {
                try {
                    Thread.sleep(5000);  // 持有锁 5 秒
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });
        
        Thread thread2 = new Thread(() -> {
            synchronized (lock) {  // 等待获取锁
                System.out.println("获取到锁");
            }
        });
        
        thread1.start();
        Thread.sleep(100);  // 确保 thread1 先获取锁
        thread2.start();
        
        Thread.sleep(100);
        System.out.println(thread2.getState());  // BLOCKED
    }
}
```

**特点**：
- 等待获取 synchronized 锁
- 进入 synchronized 代码块时被阻塞

### WAITING（等待）

**线程无限期等待另一个线程执行特定操作**。

```java
public class WaitingExample {
    private static final Object lock = new Object();
    
    public static void main(String[] args) throws InterruptedException {
        Thread thread = new Thread(() -> {
            synchronized (lock) {
                try {
                    lock.wait();  // 进入 WAITING 状态
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });
        
        thread.start();
        Thread.sleep(100);
        System.out.println(thread.getState());  // WAITING
    }
}
```

**进入 WAITING 的方法**：
- `Object.wait()`：等待其他线程调用 `notify()` 或 `notifyAll()`
- `Thread.join()`：等待另一个线程结束
- `LockSupport.park()`：等待许可

### TIMED_WAITING（定时等待）

**线程等待指定的时间**。

```java
Thread thread = new Thread(() -> {
    try {
        Thread.sleep(5000);  // 进入 TIMED_WAITING 状态
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
});

thread.start();
Thread.sleep(100);
System.out.println(thread.getState());  // TIMED_WAITING
```

**进入 TIMED_WAITING 的方法**：
- `Thread.sleep(timeout)`：休眠指定时间
- `Object.wait(timeout)`：等待指定时间
- `Thread.join(timeout)`：等待指定时间
- `LockSupport.parkNanos(timeout)`：等待指定时间

### TERMINATED（终止）

**线程执行完毕或异常退出**。

```java
Thread thread = new Thread(() -> {
    System.out.println("线程执行");
});

thread.start();
thread.join();  // 等待线程结束
System.out.println(thread.getState());  // TERMINATED
```

**特点**：
- 线程执行完毕
- 线程异常退出
- 不能再次启动

## 状态转换示例

### 完整的状态转换图

```
NEW
  ↓ start()
RUNNABLE
  ↓ 获取锁失败
BLOCKED
  ↓ 获取到锁
RUNNABLE
  ↓ wait()
WAITING
  ↓ notify()
RUNNABLE
  ↓ sleep(timeout)
TIMED_WAITING
  ↓ 时间到
RUNNABLE
  ↓ run() 结束
TERMINATED
```

### 状态转换示例

```java
public class ThreadStateTransition {
    private static final Object lock = new Object();
    
    public static void main(String[] args) throws InterruptedException {
        Thread thread = new Thread(() -> {
            synchronized (lock) {
                try {
                    System.out.println("状态：" + Thread.currentThread().getState());  // RUNNABLE
                    lock.wait(2000);  // 进入 TIMED_WAITING
                    System.out.println("状态：" + Thread.currentThread().getState());  // RUNNABLE
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });
        
        System.out.println("创建后：" + thread.getState());  // NEW
        
        thread.start();
        Thread.sleep(100);
        System.out.println("启动后：" + thread.getState());  // TIMED_WAITING
        
        synchronized (lock) {
            lock.notify();  // 唤醒线程
        }
        
        thread.join();
        System.out.println("结束后：" + thread.getState());  // TERMINATED
    }
}
```

## join 与 sleep 的区别

### join() 方法

**`join()`** 等待另一个线程结束。

```java
Thread thread = new Thread(() -> {
    try {
        Thread.sleep(3000);
        System.out.println("线程执行完成");
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
});

thread.start();
thread.join();  // 主线程等待 thread 结束
System.out.println("主线程继续执行");
```

**特点**：
- 等待指定线程结束
- 可以指定超时时间：`join(timeout)`
- 会释放当前线程持有的锁（如果持有）

### sleep() 方法

**`sleep()`** 让当前线程休眠指定时间。

```java
try {
    Thread.sleep(3000);  // 休眠 3 秒
    System.out.println("休眠结束");
} catch (InterruptedException e) {
    e.printStackTrace();
}
```

**特点**：
- 让当前线程休眠
- 不释放锁
- 是静态方法

### join vs sleep

| 特性 | join() | sleep() |
|:----:|:------:|:-------:|
| 作用对象 | 等待其他线程 | 当前线程休眠 |
| 释放锁 | 释放 | 不释放 |
| 方法类型 | 实例方法 | 静态方法 |
| 参数 | 线程对象 | 时间 |

```java
public class JoinVsSleep {
    private static final Object lock = new Object();
    
    public static void main(String[] args) throws InterruptedException {
        Thread thread1 = new Thread(() -> {
            synchronized (lock) {
                try {
                    System.out.println("thread1 开始");
                    Thread.sleep(2000);  // 不释放锁
                    System.out.println("thread1 结束");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });
        
        Thread thread2 = new Thread(() -> {
            synchronized (lock) {
                System.out.println("thread2 执行");
            }
        });
        
        thread1.start();
        Thread.sleep(100);
        thread2.start();
        
        thread1.join();  // 主线程等待 thread1 结束
        System.out.println("主线程继续");
    }
}
```

## 实际示例

### 示例 1：观察线程状态

```java
public class ThreadStateObserver {
    public static void main(String[] args) throws InterruptedException {
        Thread thread = new Thread(() -> {
            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });
        
        System.out.println("创建后：" + thread.getState());  // NEW
        
        thread.start();
        System.out.println("启动后：" + thread.getState());  // RUNNABLE 或 TIMED_WAITING
        
        Thread.sleep(100);
        System.out.println("休眠中：" + thread.getState());  // TIMED_WAITING
        
        thread.join();
        System.out.println("结束后：" + thread.getState());  // TERMINATED
    }
}
```

### 示例 2：BLOCKED 状态

```java
public class BlockedStateDemo {
    private static final Object lock = new Object();
    
    public static void main(String[] args) throws InterruptedException {
        Thread thread1 = new Thread(() -> {
            synchronized (lock) {
                try {
                    System.out.println("thread1 获取锁");
                    Thread.sleep(5000);  // 持有锁 5 秒
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });
        
        Thread thread2 = new Thread(() -> {
            synchronized (lock) {
                System.out.println("thread2 获取锁");
            }
        });
        
        thread1.start();
        Thread.sleep(100);  // 确保 thread1 先获取锁
        thread2.start();
        
        Thread.sleep(100);
        System.out.println("thread2 状态：" + thread2.getState());  // BLOCKED
        
        thread1.join();
        thread2.join();
    }
}
```

### 示例 3：WAITING 状态

```java
public class WaitingStateDemo {
    private static final Object lock = new Object();
    
    public static void main(String[] args) throws InterruptedException {
        Thread thread = new Thread(() -> {
            synchronized (lock) {
                try {
                    System.out.println("线程等待");
                    lock.wait();  // 进入 WAITING 状态
                    System.out.println("线程被唤醒");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });
        
        thread.start();
        Thread.sleep(100);
        System.out.println("状态：" + thread.getState());  // WAITING
        
        synchronized (lock) {
            lock.notify();  // 唤醒线程
        }
        
        thread.join();
    }
}
```

### 示例 4：状态监控

```java
public class ThreadStateMonitor {
    public static void monitorThread(Thread thread) {
        Thread monitor = new Thread(() -> {
            while (thread.getState() != Thread.State.TERMINATED) {
                System.out.println("线程状态：" + thread.getState());
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    break;
                }
            }
            System.out.println("线程状态：" + thread.getState());
        });
        monitor.start();
    }
    
    public static void main(String[] args) throws InterruptedException {
        Thread thread = new Thread(() -> {
            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });
        
        monitorThread(thread);
        thread.start();
        thread.join();
    }
}
```

## 线程状态的最佳实践

### 1. 理解状态转换

- 理解各种状态的触发条件
- 知道如何从一种状态转换到另一种状态

### 2. 避免长时间阻塞

```java
// ✅ 推荐：使用超时
thread.join(5000);  // 最多等待 5 秒

// ❌ 不推荐：无限等待
// thread.join();
```

### 3. 正确处理中断

```java
try {
    Thread.sleep(1000);
} catch (InterruptedException e) {
    // 正确处理中断
    Thread.currentThread().interrupt();
    return;
}
```

## 小结

Java 线程生命周期要点：

- **6 种状态**：NEW、RUNNABLE、BLOCKED、WAITING、TIMED_WAITING、TERMINATED
- **状态转换**：理解各种状态的转换条件
- **join()**：等待其他线程结束
- **sleep()**：当前线程休眠
- **状态监控**：使用 getState() 获取线程状态

**关键要点**：
- NEW：创建未启动
- RUNNABLE：可运行（包括运行和就绪）
- BLOCKED：等待锁
- WAITING：无限期等待
- TIMED_WAITING：定时等待
- TERMINATED：已结束
- join 等待其他线程，sleep 当前线程休眠

理解了线程生命周期，你就能更好地控制线程的执行。在下一章，我们将学习线程同步与锁机制。
