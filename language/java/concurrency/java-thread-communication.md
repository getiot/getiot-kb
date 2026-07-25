---
sidebar_position: 5
slug: /java-thread-communication
sidebar_label: Java 线程间通信
---

# Java 线程间通信（wait / notify）

线程间通信是多线程编程中的重要概念。理解 wait/notify 机制是实现线程协调的基础。本章将详细介绍 Java 中的线程间通信。

## wait/notify 机制

### wait() 方法

**`wait()`** 使当前线程进入等待状态，直到其他线程调用 `notify()` 或 `notifyAll()`。

```java
public final void wait() throws InterruptedException;
public final void wait(long timeout) throws InterruptedException;
public final void wait(long timeout, int nanos) throws InterruptedException;
```

**重要规则**：
- 必须在 `synchronized` 代码块中调用
- 调用 `wait()` 会释放锁
- 被唤醒后需要重新获取锁

```java
synchronized (lock) {
    while (condition) {
        lock.wait();  // 释放锁，进入等待
    }
    // 被唤醒后，重新获取锁，继续执行
}
```

### notify() 方法

**`notify()`** 唤醒一个等待该对象锁的线程。

```java
public final void notify();
```

**特点**：
- 必须在 `synchronized` 代码块中调用
- 随机唤醒一个等待的线程
- 不释放锁，需要执行完同步块才释放

```java
synchronized (lock) {
    // 修改条件
    condition = true;
    lock.notify();  // 唤醒一个等待的线程
}
```

### notifyAll() 方法

**`notifyAll()`** 唤醒所有等待该对象锁的线程。

```java
public final void notifyAll();
```

**特点**：
- 必须在 `synchronized` 代码块中调用
- 唤醒所有等待的线程
- 线程竞争获取锁

```java
synchronized (lock) {
    condition = true;
    lock.notifyAll();  // 唤醒所有等待的线程
}
```

### wait/notify 的使用模式

```java
// 等待线程
synchronized (lock) {
    while (!condition) {  // 使用 while 而不是 if
        try {
            lock.wait();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            return;
        }
    }
    // 条件满足，执行操作
}

// 通知线程
synchronized (lock) {
    condition = true;
    lock.notify();  // 或 notifyAll()
}
```

**为什么使用 while 而不是 if**：
- 防止虚假唤醒（spurious wakeup）
- 确保条件真正满足

## 生产者-消费者模型

### 基本实现

```java
import java.util.LinkedList;
import java.util.Queue;

public class ProducerConsumer {
    private final Queue<Integer> queue = new LinkedList<>();
    private final int CAPACITY = 10;
    private final Object lock = new Object();
    
    // 生产者
    public void produce(int item) throws InterruptedException {
        synchronized (lock) {
            while (queue.size() == CAPACITY) {  // 队列满，等待
                System.out.println("队列满，生产者等待");
                lock.wait();
            }
            queue.offer(item);
            System.out.println("生产：" + item);
            lock.notifyAll();  // 通知消费者
        }
    }
    
    // 消费者
    public int consume() throws InterruptedException {
        synchronized (lock) {
            while (queue.isEmpty()) {  // 队列空，等待
                System.out.println("队列空，消费者等待");
                lock.wait();
            }
            int item = queue.poll();
            System.out.println("消费：" + item);
            lock.notifyAll();  // 通知生产者
            return item;
        }
    }
    
    public static void main(String[] args) {
        ProducerConsumer pc = new ProducerConsumer();
        
        // 生产者线程
        Thread producer = new Thread(() -> {
            try {
                for (int i = 0; i < 20; i++) {
                    pc.produce(i);
                    Thread.sleep(100);
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });
        
        // 消费者线程
        Thread consumer = new Thread(() -> {
            try {
                for (int i = 0; i < 20; i++) {
                    pc.consume();
                    Thread.sleep(200);
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });
        
        producer.start();
        consumer.start();
    }
}
```

### 多生产者多消费者

```java
public class MultiProducerConsumer {
    private final Queue<Integer> queue = new LinkedList<>();
    private final int CAPACITY = 10;
    private final Object lock = new Object();
    
    public void produce(int item) throws InterruptedException {
        synchronized (lock) {
            while (queue.size() == CAPACITY) {
                lock.wait();
            }
            queue.offer(item);
            System.out.println(Thread.currentThread().getName() + " 生产：" + item);
            lock.notifyAll();
        }
    }
    
    public int consume() throws InterruptedException {
        synchronized (lock) {
            while (queue.isEmpty()) {
                lock.wait();
            }
            int item = queue.poll();
            System.out.println(Thread.currentThread().getName() + " 消费：" + item);
            lock.notifyAll();
            return item;
        }
    }
    
    public static void main(String[] args) {
        MultiProducerConsumer pc = new MultiProducerConsumer();
        
        // 多个生产者
        for (int i = 0; i < 3; i++) {
            final int producerId = i;
            new Thread(() -> {
                try {
                    for (int j = 0; j < 10; j++) {
                        pc.produce(producerId * 10 + j);
                        Thread.sleep(100);
                    }
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }, "生产者" + producerId).start();
        }
        
        // 多个消费者
        for (int i = 0; i < 2; i++) {
            final int consumerId = i;
            new Thread(() -> {
                try {
                    for (int j = 0; j < 15; j++) {
                        pc.consume();
                        Thread.sleep(200);
                    }
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }, "消费者" + consumerId).start();
        }
    }
}
```

## 示例：多线程消息队列

### 示例 1：简单消息队列

```java
import java.util.LinkedList;
import java.util.Queue;

public class MessageQueue {
    private final Queue<String> messages = new LinkedList<>();
    private final int MAX_SIZE = 10;
    private final Object lock = new Object();
    private volatile boolean running = true;
    
    // 发送消息
    public void send(String message) throws InterruptedException {
        synchronized (lock) {
            while (messages.size() >= MAX_SIZE && running) {
                System.out.println("队列满，等待发送");
                lock.wait();
            }
            if (running) {
                messages.offer(message);
                System.out.println("发送消息：" + message);
                lock.notifyAll();
            }
        }
    }
    
    // 接收消息
    public String receive() throws InterruptedException {
        synchronized (lock) {
            while (messages.isEmpty() && running) {
                System.out.println("队列空，等待接收");
                lock.wait();
            }
            if (!running && messages.isEmpty()) {
                return null;
            }
            String message = messages.poll();
            System.out.println("接收消息：" + message);
            lock.notifyAll();
            return message;
        }
    }
    
    // 停止
    public void stop() {
        synchronized (lock) {
            running = false;
            lock.notifyAll();
        }
    }
    
    public static void main(String[] args) throws InterruptedException {
        MessageQueue queue = new MessageQueue();
        
        // 发送者
        Thread sender = new Thread(() -> {
            try {
                for (int i = 0; i < 20; i++) {
                    queue.send("消息" + i);
                    Thread.sleep(100);
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });
        
        // 接收者
        Thread receiver = new Thread(() -> {
            try {
                String message;
                while ((message = queue.receive()) != null) {
                    Thread.sleep(200);
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });
        
        sender.start();
        receiver.start();
        
        sender.join();
        Thread.sleep(1000);
        queue.stop();
        receiver.join();
    }
}
```

### 示例 2：使用 BlockingQueue（推荐）

```java
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

public class BlockingQueueExample {
    private final BlockingQueue<String> queue = new LinkedBlockingQueue<>(10);
    
    public void send(String message) throws InterruptedException {
        queue.put(message);  // 阻塞直到有空间
        System.out.println("发送：" + message);
    }
    
    public String receive() throws InterruptedException {
        String message = queue.take();  // 阻塞直到有消息
        System.out.println("接收：" + message);
        return message;
    }
    
    public static void main(String[] args) {
        BlockingQueueExample example = new BlockingQueueExample();
        
        Thread producer = new Thread(() -> {
            try {
                for (int i = 0; i < 20; i++) {
                    example.send("消息" + i);
                    Thread.sleep(100);
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });
        
        Thread consumer = new Thread(() -> {
            try {
                for (int i = 0; i < 20; i++) {
                    example.receive();
                    Thread.sleep(200);
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });
        
        producer.start();
        consumer.start();
    }
}
```

### 示例 3：条件等待

```java
public class ConditionExample {
    private boolean condition = false;
    private final Object lock = new Object();
    
    public void waitForCondition() throws InterruptedException {
        synchronized (lock) {
            while (!condition) {
                System.out.println("等待条件满足");
                lock.wait();
            }
            System.out.println("条件满足，继续执行");
        }
    }
    
    public void setCondition() {
        synchronized (lock) {
            condition = true;
            System.out.println("设置条件为 true");
            lock.notifyAll();
        }
    }
    
    public static void main(String[] args) throws InterruptedException {
        ConditionExample example = new ConditionExample();
        
        Thread waiter = new Thread(() -> {
            try {
                example.waitForCondition();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });
        
        waiter.start();
        Thread.sleep(2000);
        example.setCondition();
        waiter.join();
    }
}
```

## wait/notify 的注意事项

### 1. 必须在 synchronized 中调用

```java
// ❌ 错误：不在 synchronized 中
// lock.wait();  // 抛出 IllegalMonitorStateException

// ✅ 正确
synchronized (lock) {
    lock.wait();
}
```

### 2. 使用 while 而不是 if

```java
// ❌ 错误：可能虚假唤醒
synchronized (lock) {
    if (!condition) {
        lock.wait();
    }
}

// ✅ 正确：防止虚假唤醒
synchronized (lock) {
    while (!condition) {
        lock.wait();
    }
}
```

### 3. 使用 notifyAll 而不是 notify

```java
// ⚠️ 注意：notify 只唤醒一个线程
lock.notify();

// ✅ 推荐：notifyAll 唤醒所有等待的线程
lock.notifyAll();
```

### 4. 处理中断异常

```java
synchronized (lock) {
    while (!condition) {
        try {
            lock.wait();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            return;  // 或处理中断
        }
    }
}
```

## 小结

Java 线程间通信要点：

- **wait()**：使线程等待，释放锁
- **notify()**：唤醒一个等待的线程
- **notifyAll()**：唤醒所有等待的线程
- **使用模式**：在 synchronized 中使用 while 循环
- **生产者-消费者**：经典的线程通信模型

**关键要点**：
- wait/notify 必须在 synchronized 中调用
- 使用 while 而不是 if 防止虚假唤醒
- wait 会释放锁，notify 不释放锁
- 推荐使用 notifyAll
- 正确处理中断异常

理解了线程间通信，你就能实现线程协调。在下一章，我们将学习线程池与 Executor。
