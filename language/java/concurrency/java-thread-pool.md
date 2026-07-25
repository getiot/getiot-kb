---
sidebar_position: 6
slug: /java-thread-pool
sidebar_label: Java 线程池与 Executor
---

# Java 线程池与 Executor

线程池是管理线程的重要机制，可以复用线程，提高性能。理解线程池的使用是进行高效并发编程的关键。本章将详细介绍 Java 中的线程池。

## Executors 工厂方法

### Executor 框架

**`Executor` 框架**（Java 5+）提供了线程池的实现。

**核心接口**：
- `Executor`：执行任务的接口
- `ExecutorService`：扩展 Executor，提供生命周期管理
- `ScheduledExecutorService`：支持定时任务
- `ThreadPoolExecutor`：线程池实现类

### Executors 工厂类

**`Executors`** 提供了创建线程池的工厂方法。

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

// 创建固定大小的线程池
ExecutorService executor = Executors.newFixedThreadPool(10);

// 提交任务
executor.submit(() -> {
    System.out.println("任务执行");
});

// 关闭线程池
executor.shutdown();
```

## 几种常见线程池

### FixedThreadPool（固定大小线程池）

**`newFixedThreadPool(nThreads)`** 创建固定大小的线程池。

```java
ExecutorService executor = Executors.newFixedThreadPool(5);

for (int i = 0; i < 10; i++) {
    final int taskId = i;
    executor.submit(() -> {
        System.out.println("任务 " + taskId + " 执行");
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    });
}

executor.shutdown();
```

**特点**：
- 固定线程数
- 无界队列
- 适合执行长期任务

### CachedThreadPool（缓存线程池）

**`newCachedThreadPool()`** 创建可缓存的线程池。

```java
ExecutorService executor = Executors.newCachedThreadPool();

for (int i = 0; i < 10; i++) {
    final int taskId = i;
    executor.submit(() -> {
        System.out.println("任务 " + taskId + " 执行");
    });
}

executor.shutdown();
```

**特点**：
- 线程数可动态调整
- 空闲线程会被回收（60 秒）
- 适合执行短期任务

### ScheduledThreadPool（定时线程池）

**`newScheduledThreadPool(corePoolSize)`** 创建定时任务线程池。

```java
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

ScheduledExecutorService executor = Executors.newScheduledThreadPool(5);

// 延迟执行
executor.schedule(() -> {
    System.out.println("延迟执行");
}, 3, TimeUnit.SECONDS);

// 定时执行（固定延迟）
executor.scheduleAtFixedRate(() -> {
    System.out.println("定时执行");
}, 0, 1, TimeUnit.SECONDS);

// 定时执行（固定间隔）
executor.scheduleWithFixedDelay(() -> {
    System.out.println("定时执行");
}, 0, 1, TimeUnit.SECONDS);
```

**特点**：
- 支持延迟执行
- 支持定时执行
- 适合定时任务

### SingleThreadExecutor（单线程池）

**`newSingleThreadExecutor()`** 创建单线程的线程池。

```java
ExecutorService executor = Executors.newSingleThreadExecutor();

for (int i = 0; i < 5; i++) {
    executor.submit(() -> {
        System.out.println("任务执行");
    });
}

executor.shutdown();
```

**特点**：
- 只有一个工作线程
- 任务按顺序执行
- 适合需要顺序执行的任务

## submit vs execute

### execute() 方法

**`execute()`** 提交 `Runnable` 任务，不返回结果。

```java
ExecutorService executor = Executors.newFixedThreadPool(5);

executor.execute(() -> {
    System.out.println("任务执行");
});
```

**特点**：
- 提交 Runnable 任务
- 不返回结果
- 异常需要自己处理

### submit() 方法

**`submit()`** 提交任务，返回 `Future`。

```java
// 提交 Runnable
Future<?> future1 = executor.submit(() -> {
    System.out.println("任务执行");
});

// 提交 Callable
Future<Integer> future2 = executor.submit(() -> {
    return 42;
});

// 获取结果
try {
    Integer result = future2.get();
    System.out.println("结果：" + result);
} catch (Exception e) {
    e.printStackTrace();
}
```

**特点**：
- 可以提交 Runnable 或 Callable
- 返回 Future，可以获取结果
- 可以取消任务

### execute vs submit

| 特性 | execute | submit |
|:----:|:-------:|:------:|
| 返回类型 | void | Future |
| 异常处理 | 需要自己处理 | 封装在 Future 中 |
| 任务类型 | Runnable | Runnable 或 Callable |
| 取消任务 | 不支持 | 支持 |

## 示例：任务批量处理

### 示例 1：固定线程池

```java
import java.util.concurrent.*;

public class FixedThreadPoolExample {
    public static void main(String[] args) throws InterruptedException {
        ExecutorService executor = Executors.newFixedThreadPool(5);
        
        // 提交多个任务
        for (int i = 0; i < 10; i++) {
            final int taskId = i;
            executor.submit(() -> {
                System.out.println("任务 " + taskId + " 由线程 " + 
                    Thread.currentThread().getName() + " 执行");
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            });
        }
        
        executor.shutdown();
        executor.awaitTermination(10, TimeUnit.SECONDS);
    }
}
```

### 示例 2：使用 Future 获取结果

```java
import java.util.concurrent.*;
import java.util.ArrayList;
import java.util.List;

public class FutureExample {
    public static void main(String[] args) throws Exception {
        ExecutorService executor = Executors.newFixedThreadPool(5);
        List<Future<Integer>> futures = new ArrayList<>();
        
        // 提交多个任务
        for (int i = 0; i < 10; i++) {
            final int taskId = i;
            Future<Integer> future = executor.submit(() -> {
                Thread.sleep(1000);
                return taskId * 10;
            });
            futures.add(future);
        }
        
        // 获取所有结果
        for (Future<Integer> future : futures) {
            Integer result = future.get();
            System.out.println("结果：" + result);
        }
        
        executor.shutdown();
    }
}
```

### 示例 3：定时任务

```java
import java.util.concurrent.*;

public class ScheduledTaskExample {
    public static void main(String[] args) throws InterruptedException {
        ScheduledExecutorService executor = Executors.newScheduledThreadPool(3);
        
        // 延迟执行
        executor.schedule(() -> {
            System.out.println("延迟 3 秒执行");
        }, 3, TimeUnit.SECONDS);
        
        // 定时执行（固定频率）
        executor.scheduleAtFixedRate(() -> {
            System.out.println("定时执行：" + System.currentTimeMillis());
        }, 0, 1, TimeUnit.SECONDS);
        
        Thread.sleep(10000);
        executor.shutdown();
    }
}
```

### 示例 4：任务批量处理

```java
import java.util.concurrent.*;
import java.util.List;
import java.util.ArrayList;

public class BatchProcessing {
    public static void main(String[] args) throws Exception {
        ExecutorService executor = Executors.newFixedThreadPool(5);
        List<Callable<String>> tasks = new ArrayList<>();
        
        // 创建任务列表
        for (int i = 0; i < 10; i++) {
            final int taskId = i;
            tasks.add(() -> {
                Thread.sleep(1000);
                return "任务 " + taskId + " 完成";
            });
        }
        
        // 批量提交并等待所有任务完成
        List<Future<String>> futures = executor.invokeAll(tasks);
        
        // 获取所有结果
        for (Future<String> future : futures) {
            System.out.println(future.get());
        }
        
        executor.shutdown();
    }
}
```

### 示例 5：线程池关闭

```java
import java.util.concurrent.*;

public class ThreadPoolShutdown {
    public static void main(String[] args) throws InterruptedException {
        ExecutorService executor = Executors.newFixedThreadPool(5);
        
        // 提交任务
        for (int i = 0; i < 10; i++) {
            executor.submit(() -> {
                try {
                    Thread.sleep(2000);
                    System.out.println("任务完成");
                } catch (InterruptedException e) {
                    System.out.println("任务被中断");
                }
            });
        }
        
        // 关闭线程池
        executor.shutdown();  // 不再接受新任务，等待现有任务完成
        
        // 等待任务完成
        if (!executor.awaitTermination(5, TimeUnit.SECONDS)) {
            executor.shutdownNow();  // 强制关闭
        }
    }
}
```

## 线程池的最佳实践

### 1. 使用合适的线程池类型

```java
// 固定任务数：FixedThreadPool
ExecutorService executor1 = Executors.newFixedThreadPool(10);

// 短期任务：CachedThreadPool
ExecutorService executor2 = Executors.newCachedThreadPool();

// 定时任务：ScheduledThreadPool
ScheduledExecutorService executor3 = Executors.newScheduledThreadPool(5);
```

### 2. 正确关闭线程池

```java
// ✅ 推荐：优雅关闭
executor.shutdown();
try {
    if (!executor.awaitTermination(60, TimeUnit.SECONDS)) {
        executor.shutdownNow();
    }
} catch (InterruptedException e) {
    executor.shutdownNow();
    Thread.currentThread().interrupt();
}
```

### 3. 使用 Future 处理异常

```java
Future<?> future = executor.submit(() -> {
    // 可能抛出异常
});

try {
    future.get();
} catch (ExecutionException e) {
    Throwable cause = e.getCause();
    // 处理异常
}
```

### 4. 避免无界队列

```java
// ❌ 不推荐：无界队列可能导致内存溢出
// ExecutorService executor = Executors.newFixedThreadPool(10);

// ✅ 推荐：使用有界队列
ThreadPoolExecutor executor = new ThreadPoolExecutor(
    5, 10, 60L, TimeUnit.SECONDS,
    new LinkedBlockingQueue<>(100)  // 有界队列
);
```

## 小结

Java 线程池与 Executor 要点：

- **Executor 框架**：管理线程的执行
- **FixedThreadPool**：固定大小线程池
- **CachedThreadPool**：可缓存线程池
- **ScheduledThreadPool**：定时任务线程池
- **submit vs execute**：submit 返回 Future，execute 不返回

**关键要点**：
- 使用线程池复用线程，提高性能
- 根据场景选择合适的线程池类型
- 正确关闭线程池
- 使用 Future 获取结果和处理异常
- 避免无界队列导致内存溢出

理解了线程池，你就能高效地管理线程。在下一章，我们将学习 Java 并发工具类。
