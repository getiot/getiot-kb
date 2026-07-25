---
sidebar_position: 2
slug: /java-thread-create
sidebar_label: Java 创建线程的方式
---

# Java 创建线程的方式

Java 提供了多种创建线程的方式。理解不同的创建方式及其适用场景是掌握多线程编程的基础。本章将详细介绍 Java 中创建线程的各种方法。

## 继承 Thread 类

### 基本方式

**继承 `Thread` 类并重写 `run()` 方法**：

```java
public class MyThread extends Thread {
    @Override
    public void run() {
        System.out.println("线程执行：" + Thread.currentThread().getName());
    }
}

// 使用
MyThread thread = new MyThread();
thread.start();  // 启动线程
```

### 完整示例

```java
public class ThreadExtendExample extends Thread {
    private String threadName;
    
    public ThreadExtendExample(String threadName) {
        this.threadName = threadName;
    }
    
    @Override
    public void run() {
        for (int i = 0; i < 5; i++) {
            System.out.println(threadName + " 执行：" + i);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void main(String[] args) {
        ThreadExtendExample thread1 = new ThreadExtendExample("线程1");
        ThreadExtendExample thread2 = new ThreadExtendExample("线程2");
        
        thread1.start();
        thread2.start();
    }
}
```

### 优缺点

**优点**：
- 简单直接
- 可以直接使用 Thread 类的方法

**缺点**：
- Java 单继承，不能继承其他类
- 不符合面向对象设计原则（继承应该表示"是一个"关系）

## 实现 Runnable 接口

### 基本方式

**实现 `Runnable` 接口并实现 `run()` 方法**：

```java
public class MyRunnable implements Runnable {
    @Override
    public void run() {
        System.out.println("线程执行：" + Thread.currentThread().getName());
    }
}

// 使用
MyRunnable runnable = new MyRunnable();
Thread thread = new Thread(runnable);
thread.start();
```

### 完整示例

```java
public class RunnableExample implements Runnable {
    private String taskName;
    
    public RunnableExample(String taskName) {
        this.taskName = taskName;
    }
    
    @Override
    public void run() {
        for (int i = 0; i < 5; i++) {
            System.out.println(taskName + " 执行：" + i);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void main(String[] args) {
        Runnable task1 = new RunnableExample("任务1");
        Runnable task2 = new RunnableExample("任务2");
        
        Thread thread1 = new Thread(task1);
        Thread thread2 = new Thread(task2);
        
        thread1.start();
        thread2.start();
    }
}
```

### 使用 Lambda 表达式（Java 8+）

```java
// 使用 Lambda 表达式
Runnable task = () -> {
    System.out.println("线程执行");
};

Thread thread = new Thread(task);
thread.start();

// 或直接
Thread thread2 = new Thread(() -> {
    System.out.println("线程执行");
});
thread2.start();
```

### 优缺点

**优点**：
- 可以继承其他类
- 符合面向对象设计原则
- 任务和线程分离
- 可以共享同一个 Runnable 对象

**缺点**：
- 不能直接获取返回值
- 不能抛出检查型异常

## Callable 与 Future

### Callable 接口

**`Callable` 接口**类似于 `Runnable`，但可以返回值和抛出异常。

```java
@FunctionalInterface
public interface Callable<V> {
    V call() throws Exception;
}
```

### Future 接口

**`Future` 接口**表示异步计算的结果。

```java
public interface Future<V> {
    V get() throws InterruptedException, ExecutionException;
    V get(long timeout, TimeUnit unit) throws InterruptedException, ExecutionException, TimeoutException;
    boolean cancel(boolean mayInterruptIfRunning);
    boolean isCancelled();
    boolean isDone();
}
```

### 使用示例

```java
import java.util.concurrent.*;

public class CallableExample {
    public static void main(String[] args) throws Exception {
        ExecutorService executor = Executors.newSingleThreadExecutor();
        
        // 创建 Callable 任务
        Callable<Integer> task = () -> {
            int sum = 0;
            for (int i = 1; i <= 100; i++) {
                sum += i;
            }
            return sum;
        };
        
        // 提交任务，返回 Future
        Future<Integer> future = executor.submit(task);
        
        // 获取结果（阻塞）
        Integer result = future.get();
        System.out.println("结果：" + result);
        
        executor.shutdown();
    }
}
```

### FutureTask

**`FutureTask`** 是 `Runnable` 和 `Future` 的实现，可以包装 `Callable`。

```java
Callable<Integer> task = () -> {
    Thread.sleep(2000);
    return 42;
};

FutureTask<Integer> futureTask = new FutureTask<>(task);
Thread thread = new Thread(futureTask);
thread.start();

// 获取结果
Integer result = futureTask.get();  // 阻塞直到任务完成
System.out.println("结果：" + result);
```

## 示例：并发任务执行

### 示例 1：继承 Thread

```java
public class ThreadExtendDemo extends Thread {
    private int taskId;
    
    public ThreadExtendDemo(int taskId) {
        this.taskId = taskId;
    }
    
    @Override
    public void run() {
        System.out.println("任务 " + taskId + " 开始执行");
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("任务 " + taskId + " 执行完成");
    }
    
    public static void main(String[] args) {
        for (int i = 1; i <= 3; i++) {
            ThreadExtendDemo thread = new ThreadExtendDemo(i);
            thread.start();
        }
    }
}
```

### 示例 2：实现 Runnable

```java
public class RunnableDemo implements Runnable {
    private int taskId;
    
    public RunnableDemo(int taskId) {
        this.taskId = taskId;
    }
    
    @Override
    public void run() {
        System.out.println("任务 " + taskId + " 开始执行");
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("任务 " + taskId + " 执行完成");
    }
    
    public static void main(String[] args) {
        for (int i = 1; i <= 3; i++) {
            Runnable task = new RunnableDemo(i);
            Thread thread = new Thread(task);
            thread.start();
        }
    }
}
```

### 示例 3：使用 Callable 和 Future

```java
import java.util.concurrent.*;
import java.util.ArrayList;
import java.util.List;

public class CallableDemo {
    public static void main(String[] args) throws Exception {
        ExecutorService executor = Executors.newFixedThreadPool(3);
        List<Future<Integer>> futures = new ArrayList<>();
        
        // 提交多个任务
        for (int i = 1; i <= 5; i++) {
            final int taskId = i;
            Callable<Integer> task = () -> {
                System.out.println("任务 " + taskId + " 开始执行");
                Thread.sleep(2000);
                System.out.println("任务 " + taskId + " 执行完成");
                return taskId * 10;
            };
            
            Future<Integer> future = executor.submit(task);
            futures.add(future);
        }
        
        // 获取所有结果
        for (Future<Integer> future : futures) {
            Integer result = future.get();
            System.out.println("任务结果：" + result);
        }
        
        executor.shutdown();
    }
}
```

### 示例 4：Lambda 表达式创建线程

```java
public class LambdaThreadDemo {
    public static void main(String[] args) {
        // 方式 1：直接使用 Lambda
        new Thread(() -> {
            System.out.println("线程执行");
        }).start();
        
        // 方式 2：使用变量
        Runnable task = () -> {
            for (int i = 0; i < 5; i++) {
                System.out.println("执行：" + i);
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        };
        
        Thread thread1 = new Thread(task);
        Thread thread2 = new Thread(task);
        
        thread1.start();
        thread2.start();
    }
}
```

### 示例 5：综合示例

```java
import java.util.concurrent.*;

public class ThreadCreationSummary {
    public static void main(String[] args) throws Exception {
        // 方式 1：继承 Thread
        Thread thread1 = new Thread() {
            @Override
            public void run() {
                System.out.println("方式1：继承 Thread");
            }
        };
        thread1.start();
        
        // 方式 2：实现 Runnable
        Thread thread2 = new Thread(new Runnable() {
            @Override
            public void run() {
                System.out.println("方式2：实现 Runnable");
            }
        });
        thread2.start();
        
        // 方式 3：Lambda 表达式
        Thread thread3 = new Thread(() -> {
            System.out.println("方式3：Lambda 表达式");
        });
        thread3.start();
        
        // 方式 4：Callable + Future
        ExecutorService executor = Executors.newSingleThreadExecutor();
        Future<String> future = executor.submit(() -> {
            return "方式4：Callable + Future";
        });
        System.out.println(future.get());
        executor.shutdown();
    }
}
```

## 创建线程方式的选择

### 使用继承 Thread

- 简单场景
- 不需要返回值
- 不需要继承其他类

### 使用实现 Runnable（推荐）

- 需要继承其他类
- 任务和线程分离
- 可以共享任务对象
- 符合面向对象设计

### 使用 Callable + Future

- 需要返回值
- 需要处理异常
- 需要异步执行

## 小结

Java 创建线程方式要点：

- **继承 Thread**：简单直接，但受单继承限制
- **实现 Runnable**：推荐方式，灵活，可继承其他类
- **Callable + Future**：支持返回值和异常
- **Lambda 表达式**：简化代码（Java 8+）

**关键要点**：
- 推荐使用 Runnable 接口
- 需要返回值使用 Callable
- Lambda 表达式简化代码
- 任务和线程分离是好的设计
- 根据场景选择合适的创建方式

理解了创建线程的方式，你就能创建多线程程序。在下一章，我们将学习线程的生命周期与状态。
