---
sidebar_position: 1
slug: /java-thread-basics
sidebar_label: Java 线程与进程基础
---

# Java 线程与进程基础

多线程是 Java 并发编程的核心。理解线程和进程的概念是掌握并发编程的基础。本章将详细介绍 Java 中线程与进程的基础知识。

## 线程 vs 进程

### 进程（Process）

**进程**是操作系统分配资源的基本单位，是程序的一次执行过程。

**特点**：
- **独立内存空间**：每个进程有独立的内存空间
- **资源隔离**：进程之间相互独立，互不影响
- **开销大**：创建和切换进程开销较大
- **通信复杂**：进程间通信需要使用 IPC（进程间通信）机制

```java
// 进程示例：运行一个 Java 程序就是一个进程
public class ProcessExample {
    public static void main(String[] args) {
        // 这是一个进程
        System.out.println("进程 ID：" + ProcessHandle.current().pid());
    }
}
```

### 线程（Thread）

**线程**是进程内的执行单元，是 CPU 调度的基本单位。

**特点**：
- **共享内存空间**：同一进程内的线程共享内存
- **轻量级**：创建和切换线程开销较小
- **通信简单**：线程间可以直接共享数据
- **需要同步**：共享数据需要同步机制保护

```java
// 线程示例
public class ThreadExample {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            System.out.println("线程执行");
        });
        thread.start();
    }
}
```

### 进程 vs 线程对比

| 特性 | 进程 | 线程 |
|:----:|:----:|:----:|
| 资源分配 | 独立内存空间 | 共享内存空间 |
| 创建开销 | 大 | 小 |
| 切换开销 | 大 | 小 |
| 通信方式 | IPC（复杂） | 共享内存（简单） |
| 独立性 | 完全独立 | 相互影响 |
| 数量 | 较少 | 可以很多 |

### 为什么使用多线程

**多线程的优势**：
1. **提高效率**：充分利用多核 CPU
2. **响应性**：避免阻塞，提高用户体验
3. **资源利用**：更好地利用系统资源
4. **并发处理**：同时处理多个任务

## Thread 类与 Runnable 接口

### Thread 类

**`Thread` 类**是 Java 中表示线程的类。

```java
import java.lang.Thread;

// 获取当前线程
Thread currentThread = Thread.currentThread();
System.out.println("当前线程：" + currentThread.getName());

// 线程的基本操作
Thread thread = new Thread();
thread.start();      // 启动线程
thread.join();       // 等待线程结束
thread.sleep(1000);  // 线程休眠（静态方法）
```

### Runnable 接口

**`Runnable` 接口**定义了线程要执行的任务。

```java
@FunctionalInterface
public interface Runnable {
    void run();
}
```

**特点**：
- 函数式接口（Java 8+）
- 只有一个 `run()` 方法
- 可以用于 Lambda 表达式

```java
// 实现 Runnable
Runnable task = new Runnable() {
    @Override
    public void run() {
        System.out.println("任务执行");
    }
};

// 使用 Lambda 表达式
Runnable task2 = () -> System.out.println("任务执行");
```

### Thread 和 Runnable 的关系

**Thread 类实现了 Runnable 接口**：

```java
public class Thread implements Runnable {
    private Runnable target;
    
    public void run() {
        if (target != null) {
            target.run();
        }
    }
}
```

## JVM 线程模型概览

### JVM 线程模型

**JVM 使用 1:1 线程模型**（一个 Java 线程对应一个操作系统线程）。

**线程类型**：
1. **用户线程（User Thread）**：应用程序创建的线程
2. **守护线程（Daemon Thread）**：为其他线程提供服务的线程

### 守护线程

**守护线程**是后台线程，当所有用户线程结束时，JVM 会退出。

```java
Thread daemonThread = new Thread(() -> {
    while (true) {
        System.out.println("守护线程运行中");
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
});

daemonThread.setDaemon(true);  // 设置为守护线程
daemonThread.start();

// 主线程结束，守护线程也会结束
```

**特点**：
- 不能独立存在，依赖用户线程
- 所有用户线程结束时，守护线程自动结束
- 适合后台任务（如垃圾回收）

### 线程优先级

**线程优先级**影响线程的调度（但不保证）。

```java
Thread thread = new Thread(() -> {
    // 线程任务
});

// 设置优先级（1-10，默认 5）
thread.setPriority(Thread.MAX_PRIORITY);  // 10
thread.setPriority(Thread.NORM_PRIORITY); // 5
thread.setPriority(Thread.MIN_PRIORITY);  // 1

// 获取优先级
int priority = thread.getPriority();
```

**注意**：优先级只是建议，不保证执行顺序。

### 线程组

**线程组**用于管理一组线程。

```java
ThreadGroup group = new ThreadGroup("MyGroup");
Thread thread1 = new Thread(group, () -> System.out.println("线程1"));
Thread thread2 = new Thread(group, () -> System.out.println("线程2"));

thread1.start();
thread2.start();
```

## 实际示例

### 示例 1：基本线程操作

```java
public class BasicThreadExample {
    public static void main(String[] args) {
        // 创建线程
        Thread thread = new Thread(() -> {
            System.out.println("线程执行：" + Thread.currentThread().getName());
        });
        
        // 启动线程
        thread.start();
        
        // 主线程继续执行
        System.out.println("主线程：" + Thread.currentThread().getName());
    }
}
```

### 示例 2：多线程执行

```java
public class MultiThreadExample {
    public static void main(String[] args) {
        // 创建多个线程
        for (int i = 0; i < 5; i++) {
            final int threadNum = i;
            Thread thread = new Thread(() -> {
                System.out.println("线程 " + threadNum + " 执行");
            });
            thread.start();
        }
    }
}
```

### 示例 3：守护线程

```java
public class DaemonThreadExample {
    public static void main(String[] args) {
        // 守护线程
        Thread daemon = new Thread(() -> {
            while (true) {
                System.out.println("守护线程运行中");
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    break;
                }
            }
        });
        daemon.setDaemon(true);
        daemon.start();
        
        // 主线程执行
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        
        System.out.println("主线程结束，守护线程也会结束");
    }
}
```

## 小结

Java 线程与进程基础要点：

- **进程**：操作系统资源分配单位，独立内存空间
- **线程**：CPU 调度单位，共享内存空间
- **Thread 类**：表示线程的类
- **Runnable 接口**：定义线程任务
- **守护线程**：后台线程，随用户线程结束

**关键要点**：
- 进程独立，线程共享
- 线程是轻量级的进程
- Thread 实现 Runnable 接口
- 守护线程不能独立存在
- 多线程提高程序效率

理解了线程与进程基础，你就能开始学习多线程编程。在下一章，我们将学习如何创建线程。
