---
sidebar_position: 1
slug: /java-keywords-cheatsheet
sidebar_label: Java 关键字速查表
---

# Java 关键字速查表

Java 关键字是语言的基础。本章提供 Java 所有关键字的快速参考。

## 所有关键字列表

### 访问控制

- **`public`**：公共访问修饰符
- **`private`**：私有访问修饰符
- **`protected`**：受保护访问修饰符

### 类、方法和变量修饰符

- **`abstract`**：抽象类或方法
- **`class`**：定义类
- **`extends`**：继承
- **`final`**：不可变
- **`implements`**：实现接口
- **`interface`**：定义接口
- **`native`**：本地方法
- **`new`**：创建对象
- **`static`**：静态
- **`strictfp`**：严格浮点
- **`synchronized`**：同步
- **`transient`**：瞬态
- **`volatile`**：易变

### 程序控制

- **`break`**：跳出循环
- **`case`**：switch 分支
- **`continue`**：继续循环
- **`default`**：默认分支
- **`do`**：do-while 循环
- **`else`**：else 分支
- **`for`**：for 循环
- **`if`**：if 条件
- **`instanceof`**：类型检查
- **`return`**：返回
- **`switch`**：switch 语句
- **`while`**：while 循环

### 错误处理

- **`assert`**：断言
- **`catch`**：捕获异常
- **`finally`**：最终块
- **`throw`**：抛出异常
- **`throws`**：声明异常
- **`try`**：尝试块

### 包相关

- **`import`**：导入包
- **`package`**：定义包

### 基本类型

- **`boolean`**：布尔类型
- **`byte`**：字节类型
- **`char`**：字符类型
- **`double`**：双精度浮点
- **`float`**：单精度浮点
- **`int`**：整数类型
- **`long`**：长整数
- **`short`**：短整数

### 变量引用

- **`super`**：父类引用
- **`this`**：当前对象引用
- **`void`**：无返回值

### 保留字

- **`const`**：保留字（未使用）
- **`goto`**：保留字（未使用）

## 简单说明与使用场景

### 访问控制关键字

```java
public class MyClass { }        // 公共类
private int count;             // 私有变量
protected void method() { }    // 受保护方法
```

### 类和方法关键字

```java
abstract class Animal { }       // 抽象类
final class String { }          // 不可继承
static int count;               // 静态变量
synchronized void method() { }  // 同步方法
```

### 控制流关键字

```java
if (condition) { }              // 条件判断
for (int i = 0; i < 10; i++) { } // 循环
while (condition) { }           // 循环
switch (value) { }              // 分支
break;                          // 跳出
continue;                       // 继续
return value;                   // 返回
```

### 异常处理关键字

```java
try {
    // 代码
} catch (Exception e) {
    // 处理异常
} finally {
    // 清理
}
throw new Exception();          // 抛出异常
```

### 类型关键字

```java
int number = 10;                // 整数
double price = 99.99;           // 浮点数
boolean flag = true;            // 布尔值
char ch = 'A';                  // 字符
```

## 小结

Java 关键字速查要点：

- **访问控制**：public、private、protected
- **类和方法**：class、interface、abstract、final、static
- **控制流**：if、for、while、switch、break、continue
- **异常处理**：try、catch、finally、throw、throws
- **基本类型**：int、double、boolean、char 等

**关键要点**：
- 关键字不能用作标识符
- 了解关键字的用途
- 正确使用关键字
- 注意保留字

这是 Java 关键字的快速参考，帮助你快速查找和使用关键字。
