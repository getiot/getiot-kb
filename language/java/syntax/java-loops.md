---
sidebar_position: 7
slug: /java-loops
sidebar_label: Java 循环结构
---

# Java 循环结构（for / while）

循环语句用于重复执行代码块。Java 提供了 for、while、do-while 三种循环结构，以及增强的 for 循环。理解循环的使用是编写高效程序的基础。

## for 循环

### for 循环语句

**语法**：

```java
for (初始化; 条件; 更新) {
    // 循环体
}
```

**执行流程**：
1. 执行初始化语句
2. 检查条件，如果为 false，退出循环
3. 执行循环体
4. 执行更新语句
5. 回到步骤 2

**示例**：
```java
// 打印 1 到 10
for (int i = 1; i <= 10; i++) {
    System.out.println(i);
}
```

**详细分析**：
```java
for (int i = 1;    // 初始化：i = 1
     i <= 10;      // 条件：i <= 10
     i++) {        // 更新：i 自增
    System.out.println(i);
}
```

### for 循环的变体

#### 1. 多个变量

```java
for (int i = 0, j = 10; i < j; i++, j--) {
    System.out.println("i = " + i + ", j = " + j);
}
```

#### 2. 省略初始化（变量已声明）

```java
int i = 0;
for (; i < 10; i++) {
    System.out.println(i);
}
```

#### 3. 省略更新（在循环体中更新）

```java
for (int i = 0; i < 10; ) {
    System.out.println(i);
    i += 2;  // 在循环体中更新
}
```

#### 4. 无限循环

```java
for (;;) {
    // 无限循环
    // 需要在循环体内使用 break 退出
    if (条件) {
        break;
    }
}
```

### 增强 for 循环（for-each）

**语法**：
```java
for (元素类型 变量 : 集合或数组) {
    // 循环体
}
```

**示例**：
```java
// 遍历数组
int[] numbers = {1, 2, 3, 4, 5};
for (int num : numbers) {
    System.out.println(num);
}

// 遍历集合
List<String> names = Arrays.asList("Alice", "Bob", "Charlie");
for (String name : names) {
    System.out.println(name);
}
```

**特点**：
- 语法简洁
- 自动处理索引
- 只读访问（不能修改元素）
- 适用于数组和实现了 `Iterable` 接口的集合

**限制**：
- 不能获取索引
- 不能修改数组元素
- 不能反向遍历

```java
int[] arr = {1, 2, 3};

// 增强 for 循环不能修改元素
for (int num : arr) {
    num = num * 2;  // 只修改了局部变量，不影响数组
}

// 需要使用传统 for 循环修改
for (int i = 0; i < arr.length; i++) {
    arr[i] = arr[i] * 2;  // 修改数组元素
}
```

## while 循环

### while 循环语句

**语法**：
```java
while (条件) {
    // 循环体
}
```

**执行流程**：
1. 检查条件
2. 如果为 true，执行循环体
3. 回到步骤 1

**示例**：
```java
int i = 1;
while (i <= 10) {
    System.out.println(i);
    i++;
}
```

**特点**：
- 先判断条件，再执行循环体
- 可能一次都不执行（条件初始为 false）

### do-while 循环语句

**语法**：
```java
do {
    // 循环体
} while (条件);
```

**执行流程**：
1. 执行循环体
2. 检查条件
3. 如果为 true，回到步骤 1

**示例**：
```java
int i = 1;
do {
    System.out.println(i);
    i++;
} while (i <= 10);
```

**特点**：
- 先执行循环体，再判断条件
- 至少执行一次

**对比**：
```java
int i = 10;

// while：不执行
while (i < 10) {
    System.out.println(i);
    i++;
}

// do-while：执行一次
do {
    System.out.println(i);  // 输出 10
    i++;
} while (i < 10);
```

## break 与 continue

### break 语句

**作用**：立即退出循环

```java
for (int i = 1; i <= 10; i++) {
    if (i == 5) {
        break;  // 退出循环
    }
    System.out.println(i);
}
// 输出：1, 2, 3, 4
```

**跳出多层循环**：使用标签

```java
outer: for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
        if (i == 1 && j == 1) {
            break outer;  // 跳出外层循环
        }
        System.out.println("i = " + i + ", j = " + j);
    }
}
```

### continue 语句

**作用**：跳过本次循环，继续下一次循环

```java
for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) {
        continue;  // 跳过偶数
    }
    System.out.println(i);
}
// 输出：1, 3, 5, 7, 9
```

**跳过多层循环**：使用标签

```java
outer: for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
        if (j == 1) {
            continue outer;  // 跳过外层循环的本次迭代
        }
        System.out.println("i = " + i + ", j = " + j);
    }
}
```

### break vs continue

| 语句 | 作用 | 示例 |
|:----:|:----:|:----:|
| break | 退出整个循环 | 找到目标后退出 |
| continue | 跳过本次迭代 | 跳过某些值，继续循环 |

```java
// break：找到第一个偶数就退出
for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) {
        System.out.println("找到偶数：" + i);
        break;  // 退出循环
    }
}

// continue：跳过所有奇数
for (int i = 1; i <= 10; i++) {
    if (i % 2 != 0) {
        continue;  // 跳过奇数
    }
    System.out.println("偶数：" + i);
}
```

## 循环嵌套示例

### 示例 1：打印乘法表

```java
public class MultiplicationTable {
    public static void main(String[] args) {
        // 外层循环：控制行
        for (int i = 1; i <= 9; i++) {
            // 内层循环：控制列
            for (int j = 1; j <= i; j++) {
                System.out.print(j + " × " + i + " = " + (i * j) + "\t");
            }
            System.out.println();  // 换行
        }
    }
}
```

**输出**：
```
1 × 1 = 1
1 × 2 = 2    2 × 2 = 4
1 × 3 = 3    2 × 3 = 6    3 × 3 = 9
...
```

### 示例 2：查找二维数组

```java
public class FindInMatrix {
    public static void main(String[] args) {
        int[][] matrix = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        
        int target = 5;
        boolean found = false;
        
        // 使用标签跳出嵌套循环
        outer: for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                if (matrix[i][j] == target) {
                    System.out.println("找到 " + target + " 在位置 [" + i + "][" + j + "]");
                    found = true;
                    break outer;  // 跳出外层循环
                }
            }
        }
        
        if (!found) {
            System.out.println("未找到 " + target);
        }
    }
}
```

### 示例 3：打印图案

```java
public class Pattern {
    public static void main(String[] args) {
        int n = 5;
        
        // 打印三角形
        for (int i = 1; i <= n; i++) {
            // 打印空格
            for (int j = 1; j <= n - i; j++) {
                System.out.print(" ");
            }
            // 打印星号
            for (int j = 1; j <= 2 * i - 1; j++) {
                System.out.print("*");
            }
            System.out.println();
        }
    }
}
```

**输出**：
```
    *
   ***
  *****
 *******
*********
```

### 示例 4：使用增强 for 循环遍历

```java
public class EnhancedForExample {
    public static void main(String[] args) {
        // 二维数组
        int[][] matrix = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        
        // 使用增强 for 循环
        for (int[] row : matrix) {
            for (int num : row) {
                System.out.print(num + " ");
            }
            System.out.println();
        }
        
        // 集合
        List<List<Integer>> list = Arrays.asList(
            Arrays.asList(1, 2, 3),
            Arrays.asList(4, 5, 6),
            Arrays.asList(7, 8, 9)
        );
        
        for (List<Integer> row : list) {
            for (int num : row) {
                System.out.print(num + " ");
            }
            System.out.println();
        }
    }
}
```

## 循环选择建议

### 使用 for 循环

- 循环次数已知
- 需要索引
- 遍历数组或集合

### 使用 while 循环

- 循环次数未知
- 条件复杂
- 需要先判断条件

### 使用 do-while 循环

- 至少执行一次
- 需要先执行再判断

### 使用增强 for 循环

- 遍历数组或集合
- 不需要索引
- 只读访问

## 实际示例

### 示例 1：计算阶乘

```java
public class Factorial {
    public static void main(String[] args) {
        int n = 5;
        long factorial = 1;
        
        // 使用 for 循环
        for (int i = 1; i <= n; i++) {
            factorial *= i;
        }
        
        System.out.println(n + "! = " + factorial);  // 120
    }
}
```

### 示例 2：查找质数

```java
public class PrimeNumbers {
    public static void main(String[] args) {
        int n = 20;
        
        System.out.println("1 到 " + n + " 的质数：");
        for (int i = 2; i <= n; i++) {
            boolean isPrime = true;
            
            // 检查是否为质数
            for (int j = 2; j <= Math.sqrt(i); j++) {
                if (i % j == 0) {
                    isPrime = false;
                    break;  // 找到因子，退出内层循环
                }
            }
            
            if (isPrime) {
                System.out.print(i + " ");
            }
        }
    }
}
```

### 示例 3：用户输入验证

```java
import java.util.Scanner;

public class InputValidation {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int number;
        
        // 使用 do-while 确保至少执行一次
        do {
            System.out.print("请输入一个 1 到 100 之间的数字：");
            number = scanner.nextInt();
            
            if (number < 1 || number > 100) {
                System.out.println("输入无效，请重新输入！");
            }
        } while (number < 1 || number > 100);
        
        System.out.println("输入有效：" + number);
        scanner.close();
    }
}
```

## 小结

Java 循环结构要点：

- **for 循环**：循环次数已知，需要索引
- **增强 for 循环**：遍历数组和集合，语法简洁
- **while 循环**：先判断条件，可能不执行
- **do-while 循环**：先执行再判断，至少执行一次
- **break**：退出循环
- **continue**：跳过本次迭代

**关键要点**：
- 根据场景选择合适的循环结构
- 注意避免无限循环
- 使用标签跳出多层循环
- 增强 for 循环不能修改元素
- 合理使用 break 和 continue

掌握了循环结构，你就能编写重复执行的代码。在下一章，我们将学习 Java 的数组。
