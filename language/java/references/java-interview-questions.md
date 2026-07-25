---
sidebar_position: 4
slug: /java-interview-questions
sidebar_label: Java 面试问题
---

# Java 面试问题

面试是检验 Java 知识的重要环节。本章整理常见的 Java 面试问题。

## 核心语法问题

### 1. Java 的基本数据类型有哪些？

**答案**：
- 整数类型：byte、short、int、long
- 浮点类型：float、double
- 字符类型：char
- 布尔类型：boolean

### 2. == 和 equals() 的区别？

**答案**：
- `==` 比较引用（基本类型比较值）
- `equals()` 比较对象内容（需要重写）

```java
String str1 = new String("Hello");
String str2 = new String("Hello");
str1 == str2;                    // false（不同对象）
str1.equals(str2);              // true（内容相同）
```

### 3. String、StringBuilder、StringBuffer 的区别？

**答案**：
- **String**：不可变，线程安全
- **StringBuilder**：可变，非线程安全，性能好
- **StringBuffer**：可变，线程安全，性能较差

## OOP 面向对象问题

### 4. 面向对象的三大特性？

**答案**：
- **封装**：隐藏实现细节
- **继承**：代码复用
- **多态**：同一接口不同实现

### 5. 抽象类和接口的区别？

**答案**：
- **抽象类**：可以有实现，单继承
- **接口**：Java 8+ 可以有默认方法，多实现

### 6. final 关键字的作用？

**答案**：
- 修饰类：不可继承
- 修饰方法：不可重写
- 修饰变量：不可修改

## 异常、集合、IO、多线程相关问题

### 7. 异常的分类？

**答案**：
- **Checked Exception**：编译时检查，必须处理
- **Unchecked Exception**：运行时异常，可以不处理
- **Error**：系统错误

### 8. ArrayList 和 LinkedList 的区别？

**答案**：
- **ArrayList**：数组实现，随机访问快
- **LinkedList**：链表实现，插入删除快

### 9. HashMap 的工作原理？

**答案**：
- 基于哈希表
- 使用 hashCode() 计算位置
- 解决冲突使用链表或红黑树（Java 8+）

### 10. 线程的创建方式？

**答案**：
- 继承 Thread 类
- 实现 Runnable 接口
- 实现 Callable 接口
- 使用线程池

### 11. synchronized 和 Lock 的区别？

**答案**：
- **synchronized**：关键字，自动释放锁
- **Lock**：接口，手动释放锁，功能更强大

## Java 8 新特性问题

### 12. Lambda 表达式的优点？

**答案**：
- 简化代码
- 函数式编程
- 提高可读性

### 13. Stream API 的作用？

**答案**：
- 函数式处理集合
- 支持并行处理
- 链式操作

### 14. Optional 的作用？

**答案**：
- 避免 NullPointerException
- 明确表示可能为空的值
- 提供链式操作

## 小结

Java 面试问题要点：

- **核心语法**：数据类型、== vs equals、String 相关
- **OOP**：三大特性、抽象类 vs 接口、final
- **异常**：异常分类、处理方式
- **集合**：List、Set、Map 的区别
- **多线程**：创建方式、同步机制
- **Java 8**：Lambda、Stream、Optional

**关键要点**：
- 理解基本概念
- 掌握区别和特点
- 了解使用场景
- 准备实际例子

这是 Java 面试问题的快速参考，帮助你准备面试。
