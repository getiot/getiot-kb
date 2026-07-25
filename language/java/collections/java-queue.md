---
sidebar_position: 6
slug: /java-queue
sidebar_label: Java Queue 与 Deque
---

# Java Queue 与 Deque

Queue（队列）和 Deque（双端队列）是 Java 集合框架中用于实现队列数据结构的接口。理解队列的使用是处理 FIFO 和双端操作的基础。本章将详细介绍 Java 中的队列。

## Queue 接口与实现

### Queue 接口

**`Queue`** 是队列接口，遵循 FIFO（First In First Out，先进先出）原则。

**核心方法**：

| 操作 | 抛出异常 | 返回特殊值 |
|:----:|:--------:|:----------:|
| 插入 | `add(e)` | `offer(e)` |
| 删除 | `remove()` | `poll()` |
| 查看 | `element()` | `peek()` |

### LinkedList 作为 Queue

**`LinkedList` 实现了 Queue 接口**，可以作为队列使用。

```java
import java.util.LinkedList;
import java.util.Queue;

Queue<String> queue = new LinkedList<>();

// 添加元素（推荐使用 offer）
queue.offer("first");
queue.offer("second");
queue.offer("third");

// 查看队首元素（不删除）
String head = queue.peek();  // "first"

// 删除并返回队首元素
String removed = queue.poll();  // "first"
```

### PriorityQueue（优先级队列）

**`PriorityQueue`** 是基于堆实现的优先级队列，元素按优先级排序。

```java
import java.util.PriorityQueue;

// 自然排序（升序）
PriorityQueue<Integer> pq = new PriorityQueue<>();
pq.offer(3);
pq.offer(1);
pq.offer(4);
pq.offer(1);
pq.offer(5);

// 按优先级取出（最小的先出）
while (!pq.isEmpty()) {
    System.out.println(pq.poll());  // 1, 1, 3, 4, 5
}

// 自定义排序（降序）
PriorityQueue<Integer> pqDesc = new PriorityQueue<>(Collections.reverseOrder());
pqDesc.offer(3);
pqDesc.offer(1);
pqDesc.offer(4);

while (!pqDesc.isEmpty()) {
    System.out.println(pqDesc.poll());  // 4, 3, 1
}
```

### Queue 的常用方法

```java
Queue<String> queue = new LinkedList<>();

// 添加元素
boolean added = queue.offer("item");  // 推荐：返回 boolean
// queue.add("item");                 // 不推荐：失败时抛出异常

// 删除元素
String removed = queue.poll();       // 推荐：返回 null（如果为空）
// String removed = queue.remove();  // 不推荐：失败时抛出异常

// 查看元素
String head = queue.peek();          // 推荐：返回 null（如果为空）
// String head = queue.element();    // 不推荐：失败时抛出异常

// 检查
boolean empty = queue.isEmpty();
int size = queue.size();
```

## Deque 接口

### Deque 接口

**`Deque`**（Double Ended Queue）是双端队列，支持在两端进行插入和删除操作。

**特点**：
- 可以作为队列使用（FIFO）
- 可以作为栈使用（LIFO）
- 支持在两端操作

### ArrayDeque

**`ArrayDeque`** 是基于数组实现的双端队列。

**特点**：
- **性能好**：比 LinkedList 性能更好
- **无容量限制**：自动扩容
- **线程不安全**：多线程环境下需要同步
- **不允许 null**：不能存储 null 元素

```java
import java.util.ArrayDeque;
import java.util.Deque;

Deque<String> deque = new ArrayDeque<>();

// 作为队列使用（FIFO）
deque.offerLast("first");
deque.offerLast("second");
String first = deque.pollFirst();  // "first"

// 作为栈使用（LIFO）
deque.push("first");
deque.push("second");
String top = deque.pop();  // "second"
```

## 常用操作方法

### Queue 方法

```java
Queue<String> queue = new LinkedList<>();

// offer：添加元素到队尾
queue.offer("first");
queue.offer("second");

// poll：删除并返回队首元素
String head = queue.poll();  // "first"

// peek：查看队首元素（不删除）
String next = queue.peek();  // "second"
```

### Deque 方法

#### 队列操作（FIFO）

```java
Deque<String> deque = new ArrayDeque<>();

// 队尾添加
deque.offerLast("first");
deque.offerLast("second");

// 队首删除
String first = deque.pollFirst();  // "first"

// 队首查看
String next = deque.peekFirst();   // "second"
```

#### 栈操作（LIFO）

```java
Deque<String> stack = new ArrayDeque<>();

// 入栈
stack.push("first");
stack.push("second");

// 出栈
String top = stack.pop();  // "second"

// 查看栈顶
String peek = stack.peek();  // "first"
```

#### 双端操作

```java
Deque<String> deque = new ArrayDeque<>();

// 在队首添加
deque.offerFirst("first");
deque.offerFirst("second");

// 在队尾添加
deque.offerLast("third");

// 从队首删除
String first = deque.pollFirst();  // "second"

// 从队尾删除
String last = deque.pollLast();    // "third"

// 查看队首
String head = deque.peekFirst();   // "first"

// 查看队尾
String tail = deque.peekLast();    // "first"
```

### 方法对比

| 操作 | Queue | Deque（队列） | Deque（栈） |
|:----:|:-----:|:-------------:|:-----------:|
| 添加 | `offer()` | `offerLast()` | `push()` |
| 删除 | `poll()` | `pollFirst()` | `pop()` |
| 查看 | `peek()` | `peekFirst()` | `peek()` |

## 实际示例

### 示例 1：队列基本操作

```java
import java.util.*;

public class QueueExample {
    public static void main(String[] args) {
        Queue<String> queue = new LinkedList<>();
        
        // 添加元素
        queue.offer("任务1");
        queue.offer("任务2");
        queue.offer("任务3");
        
        // 处理队列
        while (!queue.isEmpty()) {
            String task = queue.poll();
            System.out.println("处理：" + task);
        }
    }
}
```

### 示例 2：优先级队列

```java
import java.util.*;

public class PriorityQueueExample {
    public static void main(String[] args) {
        // 按优先级排序的任务队列
        PriorityQueue<Task> tasks = new PriorityQueue<>((t1, t2) -> 
            Integer.compare(t1.getPriority(), t2.getPriority()));
        
        tasks.offer(new Task("低优先级任务", 3));
        tasks.offer(new Task("高优先级任务", 1));
        tasks.offer(new Task("中优先级任务", 2));
        
        // 按优先级处理
        while (!tasks.isEmpty()) {
            Task task = tasks.poll();
            System.out.println("处理：" + task.getName() + "（优先级：" + task.getPriority() + "）");
        }
    }
}
```

### 示例 3：栈操作

```java
import java.util.*;

public class StackExample {
    public static void main(String[] args) {
        // 使用 Deque 作为栈
        Deque<String> stack = new ArrayDeque<>();
        
        // 入栈
        stack.push("first");
        stack.push("second");
        stack.push("third");
        
        // 出栈
        while (!stack.isEmpty()) {
            String item = stack.pop();
            System.out.println("出栈：" + item);
        }
        // 输出：third, second, first（后进先出）
    }
}
```

### 示例 4：双端队列

```java
import java.util.*;

public class DequeExample {
    public static void main(String[] args) {
        Deque<String> deque = new ArrayDeque<>();
        
        // 两端添加
        deque.offerFirst("first");
        deque.offerLast("last");
        deque.offerFirst("newFirst");
        deque.offerLast("newLast");
        
        System.out.println("队列：" + deque);  // [newFirst, first, last, newLast]
        
        // 两端删除
        String first = deque.pollFirst();  // "newFirst"
        String last = deque.pollLast();    // "newLast"
        
        // 两端查看
        String head = deque.peekFirst();   // "first"
        String tail = deque.peekLast();    // "last"
    }
}
```

### 示例 5：括号匹配（使用栈）

```java
import java.util.*;

public class BracketMatcher {
    public static boolean isValid(String s) {
        Deque<Character> stack = new ArrayDeque<>();
        Map<Character, Character> pairs = new HashMap<>();
        pairs.put(')', '(');
        pairs.put(']', '[');
        pairs.put('}', '{');
        
        for (char c : s.toCharArray()) {
            if (pairs.containsValue(c)) {
                // 左括号入栈
                stack.push(c);
            } else if (pairs.containsKey(c)) {
                // 右括号匹配
                if (stack.isEmpty() || stack.pop() != pairs.get(c)) {
                    return false;
                }
            }
        }
        
        return stack.isEmpty();
    }
    
    public static void main(String[] args) {
        System.out.println(isValid("()"));      // true
        System.out.println(isValid("()[]{}"));  // true
        System.out.println(isValid("(]"));      // false
        System.out.println(isValid("([)]"));    // false
    }
}
```

## Queue 和 Deque 的选择

### 使用 Queue

- 只需要 FIFO 队列
- 不需要双端操作
- 使用 LinkedList 或 PriorityQueue

### 使用 Deque

- 需要双端操作
- 需要作为栈使用
- 使用 ArrayDeque（性能更好）

### 使用 ArrayDeque vs LinkedList

**ArrayDeque**：
- 性能更好
- 不允许 null
- 适合作为栈和队列

**LinkedList**：
- 功能更多（实现了 List）
- 允许 null
- 适合需要 List 功能的场景

## 小结

Java Queue 与 Deque 要点：

- **Queue**：FIFO 队列，使用 offer/poll/peek
- **PriorityQueue**：优先级队列，按优先级排序
- **Deque**：双端队列，支持两端操作
- **ArrayDeque**：基于数组的双端队列，性能好
- **栈操作**：使用 push/pop/peek

**关键要点**：
- Queue 遵循 FIFO 原则
- PriorityQueue 按优先级排序
- Deque 支持双端操作
- ArrayDeque 性能优于 LinkedList
- 可以使用 Deque 实现栈

理解了 Queue 和 Deque，你就能处理队列和栈的数据结构。在下一章，我们将学习 Java 集合的遍历与排序。
