---
sidebar_position: 10
slug: /java-methods
sidebar_label: Java 方法
---

# Java 方法（方法定义与调用）

方法是组织代码的基本单元，用于封装功能逻辑。理解方法的定义、调用、参数传递和返回值是编写模块化程序的基础。本章将详细介绍 Java 方法的使用。

## 方法定义、参数、返回值

### 方法定义

**语法**：
```java
[访问修饰符] [static] [final] 返回类型 方法名(参数列表) {
    // 方法体
    return 返回值;  // 如果有返回值
}
```

**组成部分**：
1. **访问修饰符**：public、private、protected、默认
2. **static**：静态方法（可选）
3. **final**：最终方法（可选）
4. **返回类型**：方法返回的数据类型，void 表示无返回值
5. **方法名**：遵循命名规范（小驼峰）
6. **参数列表**：方法接收的参数
7. **方法体**：方法执行的代码

### 无参数无返回值

```java
public void sayHello() {
    System.out.println("Hello, World!");
}
```

### 有参数无返回值

```java
public void greet(String name) {
    System.out.println("Hello, " + name + "!");
}

// 多个参数
public void introduce(String name, int age) {
    System.out.println("我是 " + name + "，今年 " + age + " 岁");
}
```

### 有返回值

```java
// 返回基本类型
public int add(int a, int b) {
    return a + b;
}

// 返回引用类型
public String getFullName(String firstName, String lastName) {
    return firstName + " " + lastName;
}

// 返回数组
public int[] getNumbers() {
    return new int[]{1, 2, 3, 4, 5};
}
```

### 方法调用

```java
public class MethodExample {
    // 定义方法
    public void sayHello() {
        System.out.println("Hello");
    }
    
    public int add(int a, int b) {
        return a + b;
    }
    
    public static void main(String[] args) {
        MethodExample obj = new MethodExample();
        
        // 调用无返回值方法
        obj.sayHello();
        
        // 调用有返回值方法
        int result = obj.add(10, 20);
        System.out.println("结果：" + result);
    }
}
```

### 参数传递

#### 1. 基本类型参数（值传递）

```java
public void modifyValue(int x) {
    x = 100;  // 只修改局部变量，不影响原变量
}

public static void main(String[] args) {
    int num = 10;
    modifyValue(num);
    System.out.println(num);  // 仍然是 10
}
```

#### 2. 引用类型参数（引用传递）

```java
public void modifyArray(int[] arr) {
    arr[0] = 100;  // 修改数组元素
}

public static void main(String[] args) {
    int[] numbers = {1, 2, 3};
    modifyArray(numbers);
    System.out.println(numbers[0]);  // 100（被修改了）
}
```

**注意**：Java 中所有参数传递都是**值传递**，但对于引用类型，传递的是引用的副本，所以可以修改对象的内容。

#### 3. 可变参数（varargs）

```java
// 可变参数必须是最后一个参数
public int sum(int... numbers) {
    int total = 0;
    for (int num : numbers) {
        total += num;
    }
    return total;
}

// 调用
int result1 = sum(1, 2, 3);        // 6
int result2 = sum(1, 2, 3, 4, 5);  // 15
int result3 = sum();               // 0
```

**可变参数内部是数组**：
```java
public void print(String... messages) {
    for (String msg : messages) {
        System.out.println(msg);
    }
}
```

## 方法重载

### 什么是方法重载

**方法重载（Overloading）**：同一个类中可以有多个同名方法，但参数列表必须不同。

**规则**：
1. 方法名相同
2. 参数列表不同（类型、个数、顺序）
3. 返回类型可以不同（但不能仅靠返回类型区分）
4. 访问修饰符可以不同

### 重载示例

```java
public class Calculator {
    // 两个 int 参数
    public int add(int a, int b) {
        return a + b;
    }
    
    // 三个 int 参数
    public int add(int a, int b, int c) {
        return a + b + c;
    }
    
    // double 参数
    public double add(double a, double b) {
        return a + b;
    }
    
    // 参数顺序不同
    public void print(String name, int age) {
        System.out.println(name + ", " + age);
    }
    
    public void print(int age, String name) {
        System.out.println(age + ", " + name);
    }
}
```

### 重载解析

```java
Calculator calc = new Calculator();

calc.add(1, 2);        // 调用 add(int, int)
calc.add(1, 2, 3);     // 调用 add(int, int, int)
calc.add(1.0, 2.0);    // 调用 add(double, double)
```

**编译器根据参数类型和数量选择方法**。

### 重载注意事项

#### 1. 不能仅靠返回类型区分

```java
// ❌ 错误：仅返回类型不同，不能重载
public int getValue() { return 1; }
public String getValue() { return "1"; }  // 编译错误
```

#### 2. 类型转换

```java
public void method(int x) { }
public void method(long x) { }

// 调用
method(10);  // 调用 method(int)，因为 10 是 int 类型
method(10L); // 调用 method(long)
```

#### 3. 自动类型提升

```java
public void method(byte x) { }
public void method(int x) { }

byte b = 10;
method(b);  // 调用 method(byte)
method(10); // 调用 method(int)

// 如果没有 method(byte)，会自动提升为 method(int)
```

## 递归方法示例

### 什么是递归

**递归（Recursion）**：方法调用自身。

**要素**：
1. **递归终止条件**：避免无限递归
2. **递归调用**：方法调用自身
3. **问题规模减小**：每次递归问题规模应该减小

### 递归示例

#### 1. 计算阶乘

```java
public class Factorial {
    public static long factorial(int n) {
        // 终止条件
        if (n <= 1) {
            return 1;
        }
        // 递归调用
        return n * factorial(n - 1);
    }
    
    public static void main(String[] args) {
        System.out.println(factorial(5));  // 120
    }
}
```

**执行过程**：
```
factorial(5)
  = 5 * factorial(4)
  = 5 * (4 * factorial(3))
  = 5 * (4 * (3 * factorial(2)))
  = 5 * (4 * (3 * (2 * factorial(1))))
  = 5 * (4 * (3 * (2 * 1)))
  = 120
```

#### 2. 斐波那契数列

```java
public class Fibonacci {
    public static int fibonacci(int n) {
        // 终止条件
        if (n <= 1) {
            return n;
        }
        // 递归调用
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
    
    public static void main(String[] args) {
        for (int i = 0; i < 10; i++) {
            System.out.print(fibonacci(i) + " ");
        }
        // 输出：0 1 1 2 3 5 8 13 21 34
    }
}
```

#### 3. 计算数组和

```java
public class ArraySum {
    public static int sum(int[] arr, int index) {
        // 终止条件
        if (index >= arr.length) {
            return 0;
        }
        // 递归调用
        return arr[index] + sum(arr, index + 1);
    }
    
    public static void main(String[] args) {
        int[] arr = {1, 2, 3, 4, 5};
        System.out.println(sum(arr, 0));  // 15
    }
}
```

#### 4. 二分查找（递归版）

```java
public class BinarySearch {
    public static int binarySearch(int[] arr, int target, int left, int right) {
        // 终止条件
        if (left > right) {
            return -1;  // 未找到
        }
        
        int mid = (left + right) / 2;
        
        if (arr[mid] == target) {
            return mid;  // 找到
        } else if (arr[mid] > target) {
            return binarySearch(arr, target, left, mid - 1);  // 左半部分
        } else {
            return binarySearch(arr, target, mid + 1, right);  // 右半部分
        }
    }
    
    public static void main(String[] args) {
        int[] arr = {1, 3, 5, 7, 9, 11, 13};
        int index = binarySearch(arr, 7, 0, arr.length - 1);
        System.out.println("索引：" + index);  // 3
    }
}
```

### 递归的优缺点

**优点**：
- 代码简洁
- 表达清晰
- 适合解决递归定义的问题

**缺点**：
- 性能较低（函数调用开销）
- 可能栈溢出（深度过大）
- 难以调试

**优化**：使用迭代（循环）替代递归，或使用尾递归优化。

## 方法调用与栈帧关系

### 方法调用栈

**调用栈（Call Stack）**：方法调用时，JVM 会创建一个栈帧（Stack Frame）存储方法的局部变量、参数和返回地址。

```java
public class StackExample {
    public static void method1() {
        System.out.println("方法1开始");
        method2();
        System.out.println("方法1结束");
    }
    
    public static void method2() {
        System.out.println("方法2开始");
        method3();
        System.out.println("方法2结束");
    }
    
    public static void method3() {
        System.out.println("方法3");
    }
    
    public static void main(String[] args) {
        method1();
    }
}
```

**执行过程**：
```
main 调用 method1
  └─ method1 调用 method2
      └─ method2 调用 method3
          └─ method3 执行完毕，返回
      └─ method2 执行完毕，返回
  └─ method1 执行完毕，返回
└─ main 执行完毕
```

**栈帧结构**：
- 局部变量
- 参数
- 返回地址
- 操作数栈

### 栈溢出

**栈溢出（StackOverflowError）**：递归深度过大，栈空间不足。

```java
public class StackOverflow {
    public static void infiniteRecursion() {
        infiniteRecursion();  // 无限递归
    }
    
    public static void main(String[] args) {
        infiniteRecursion();  // 抛出 StackOverflowError
    }
}
```

**解决**：
- 确保递归有终止条件
- 减少递归深度
- 使用迭代替代递归

### 方法调用的内存模型

```java
public class MemoryModel {
    public static void method(int x) {
        int y = 10;  // 局部变量
        // ...
    }
    
    public static void main(String[] args) {
        int a = 5;
        method(a);
    }
}
```

**内存分配**：
- **栈内存**：存储局部变量、方法参数、返回地址
- **堆内存**：存储对象
- **方法区**：存储类信息、常量

## 实际示例

### 示例 1：综合方法使用

```java
public class MethodDemo {
    // 无参数无返回值
    public void greet() {
        System.out.println("Hello!");
    }
    
    // 有参数无返回值
    public void greet(String name) {
        System.out.println("Hello, " + name + "!");
    }
    
    // 有返回值
    public int calculate(int a, int b, String operation) {
        switch (operation) {
            case "+":
                return a + b;
            case "-":
                return a - b;
            case "*":
                return a * b;
            case "/":
                return b != 0 ? a / b : 0;
            default:
                return 0;
        }
    }
    
    // 可变参数
    public int sum(int... numbers) {
        int total = 0;
        for (int num : numbers) {
            total += num;
        }
        return total;
    }
    
    public static void main(String[] args) {
        MethodDemo demo = new MethodDemo();
        
        demo.greet();
        demo.greet("Java");
        
        int result = demo.calculate(10, 5, "+");
        System.out.println("结果：" + result);
        
        int sum = demo.sum(1, 2, 3, 4, 5);
        System.out.println("和：" + sum);
    }
}
```

### 示例 2：递归应用

```java
public class RecursionExamples {
    // 计算阶乘
    public static long factorial(int n) {
        if (n <= 1) return 1;
        return n * factorial(n - 1);
    }
    
    // 计算幂
    public static long power(int base, int exponent) {
        if (exponent == 0) return 1;
        return base * power(base, exponent - 1);
    }
    
    // 反转字符串
    public static String reverse(String str) {
        if (str == null || str.length() <= 1) {
            return str;
        }
        return reverse(str.substring(1)) + str.charAt(0);
    }
    
    public static void main(String[] args) {
        System.out.println("5! = " + factorial(5));  // 120
        System.out.println("2^8 = " + power(2, 8));   // 256
        System.out.println(reverse("Hello"));        // olleH
    }
}
```

### 示例 3：方法重载

```java
public class OverloadExample {
    // 打印整数
    public void print(int value) {
        System.out.println("整数：" + value);
    }
    
    // 打印浮点数
    public void print(double value) {
        System.out.println("浮点数：" + value);
    }
    
    // 打印字符串
    public void print(String value) {
        System.out.println("字符串：" + value);
    }
    
    // 打印多个整数
    public void print(int... values) {
        System.out.print("多个整数：");
        for (int v : values) {
            System.out.print(v + " ");
        }
        System.out.println();
    }
    
    public static void main(String[] args) {
        OverloadExample obj = new OverloadExample();
        
        obj.print(10);           // 整数：10
        obj.print(3.14);         // 浮点数：3.14
        obj.print("Hello");      // 字符串：Hello
        obj.print(1, 2, 3, 4);   // 多个整数：1 2 3 4
    }
}
```

## 小结

Java 方法要点：

- **方法定义**：访问修饰符、返回类型、方法名、参数列表、方法体
- **参数传递**：基本类型值传递，引用类型传递引用副本
- **方法重载**：同名方法，参数列表不同
- **递归**：方法调用自身，需要终止条件
- **调用栈**：方法调用时创建栈帧

**关键要点**：
- 方法用于封装功能逻辑
- 参数传递是值传递
- 方法重载根据参数列表区分
- 递归需要终止条件，避免栈溢出
- 理解调用栈有助于调试

掌握了方法，你就能编写模块化的代码。在下一章，我们将开始学习 Java 的面向对象编程。
