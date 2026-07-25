---
sidebar_position: 8
slug: /java-arrays
sidebar_label: Java 数组
---

# Java 数组

数组是存储相同类型数据的连续内存空间。Java 中的数组是对象，提供了高效的数据存储和访问方式。理解数组的使用是处理批量数据的基础。

## 一维数组与多维数组

### 一维数组

**声明方式**：
```java
// 方式 1：声明后初始化
int[] arr;
arr = new int[5];

// 方式 2：声明并初始化
int[] arr = new int[5];

// 方式 3：直接初始化
int[] arr = {1, 2, 3, 4, 5};

// 方式 4：声明时指定大小
int[] arr = new int[]{1, 2, 3, 4, 5};
```

**访问元素**：
```java
int[] arr = {1, 2, 3, 4, 5};

// 访问第一个元素（索引从 0 开始）
int first = arr[0];  // 1

// 访问最后一个元素
int last = arr[arr.length - 1];  // 5

// 修改元素
arr[0] = 10;  // arr = {10, 2, 3, 4, 5}
```

**数组长度**：
```java
int[] arr = {1, 2, 3, 4, 5};
int length = arr.length;  // 5（注意：length 是属性，不是方法）
```

### 多维数组

**二维数组**：
```java
// 方式 1：声明并分配空间
int[][] matrix = new int[3][4];  // 3 行 4 列

// 方式 2：直接初始化
int[][] matrix = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
};

// 方式 3：不规则数组
int[][] matrix = new int[3][];
matrix[0] = new int[2];
matrix[1] = new int[3];
matrix[2] = new int[4];
```

**访问二维数组**：
```java
int[][] matrix = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
};

// 访问元素
int value = matrix[1][2];  // 6（第 2 行第 3 列）

// 获取行数和列数
int rows = matrix.length;        // 3
int cols = matrix[0].length;    // 3
```

**三维数组**：
```java
int[][][] cube = new int[3][4][5];  // 3 层 4 行 5 列

// 访问
int value = cube[0][1][2];
```

## 数组初始化与访问

### 数组初始化

#### 1. 默认初始化

```java
// 数值类型：初始化为 0
int[] arr = new int[5];  // {0, 0, 0, 0, 0}

// 布尔类型：初始化为 false
boolean[] flags = new boolean[3];  // {false, false, false}

// 引用类型：初始化为 null
String[] names = new String[3];  // {null, null, null}
```

#### 2. 显式初始化

```java
// 一维数组
int[] arr = {1, 2, 3, 4, 5};

// 二维数组
int[][] matrix = {
    {1, 2, 3},
    {4, 5, 6}
};

// 不规则数组
int[][] jagged = {
    {1, 2},
    {3, 4, 5},
    {6, 7, 8, 9}
};
```

#### 3. 循环初始化

```java
// 初始化一维数组
int[] arr = new int[5];
for (int i = 0; i < arr.length; i++) {
    arr[i] = i + 1;  // {1, 2, 3, 4, 5}
}

// 初始化二维数组
int[][] matrix = new int[3][4];
for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
        matrix[i][j] = i * matrix[i].length + j + 1;
    }
}
```

### 数组访问

#### 1. 读取元素

```java
int[] arr = {10, 20, 30, 40, 50};

// 访问单个元素
int value = arr[2];  // 30

// 遍历数组
for (int i = 0; i < arr.length; i++) {
    System.out.println(arr[i]);
}

// 使用增强 for 循环
for (int num : arr) {
    System.out.println(num);
}
```

#### 2. 修改元素

```java
int[] arr = {1, 2, 3, 4, 5};

// 修改单个元素
arr[0] = 10;  // {10, 2, 3, 4, 5}

// 批量修改
for (int i = 0; i < arr.length; i++) {
    arr[i] = arr[i] * 2;  // 每个元素乘以 2
}
```

#### 3. 数组边界

```java
int[] arr = {1, 2, 3};

// ✅ 有效索引：0 到 arr.length - 1
int first = arr[0];        // 1
int last = arr[arr.length - 1];  // 3

// ❌ 错误：数组越界
// int invalid = arr[3];  // ArrayIndexOutOfBoundsException
// int negative = arr[-1];  // ArrayIndexOutOfBoundsException
```

## 数组常用工具（Arrays 类）

`java.util.Arrays` 提供了操作数组的静态方法。

### 1. 数组排序

```java
import java.util.Arrays;

int[] arr = {3, 1, 4, 1, 5, 9, 2, 6};

// 排序（升序）
Arrays.sort(arr);  // {1, 1, 2, 3, 4, 5, 6, 9}

// 部分排序
int[] arr2 = {3, 1, 4, 1, 5, 9, 2, 6};
Arrays.sort(arr2, 0, 4);  // 只排序前 4 个元素
```

### 2. 数组查找

```java
int[] arr = {1, 2, 3, 4, 5};

// 二分查找（数组必须已排序）
int index = Arrays.binarySearch(arr, 3);  // 2

// 未找到返回负数
int notFound = Arrays.binarySearch(arr, 6);  // -6
```

### 3. 数组比较

```java
int[] arr1 = {1, 2, 3};
int[] arr2 = {1, 2, 3};
int[] arr3 = {1, 2, 4};

// 比较数组内容
boolean equal = Arrays.equals(arr1, arr2);  // true
boolean notEqual = Arrays.equals(arr1, arr3);  // false
```

### 4. 数组填充

```java
int[] arr = new int[5];

// 填充所有元素
Arrays.fill(arr, 10);  // {10, 10, 10, 10, 10}

// 填充部分元素
int[] arr2 = new int[5];
Arrays.fill(arr2, 1, 3, 20);  // {0, 20, 20, 0, 0}
```

### 5. 数组转字符串

```java
int[] arr = {1, 2, 3};

// 转字符串
String str = Arrays.toString(arr);  // "[1, 2, 3]"
```

### 6. 数组复制

```java
int[] original = {1, 2, 3, 4, 5};

// 复制整个数组
int[] copy = Arrays.copyOf(original, original.length);

// 复制部分数组
int[] partial = Arrays.copyOf(original, 3);  // {1, 2, 3}

// 复制指定范围
int[] range = Arrays.copyOfRange(original, 1, 4);  // {2, 3, 4}
```

### 7. 数组转列表

```java
String[] arr = {"apple", "banana", "orange"};

// 转列表（固定大小）
List<String> list = Arrays.asList(arr);

// 注意：返回的列表不能添加或删除元素
// list.add("grape");  // 会抛出 UnsupportedOperationException
```

## 数组遍历示例

### 示例 1：基本遍历

```java
public class ArrayTraversal {
    public static void main(String[] args) {
        int[] arr = {1, 2, 3, 4, 5};
        
        // 方式 1：传统 for 循环
        System.out.println("传统 for 循环：");
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }
        System.out.println();
        
        // 方式 2：增强 for 循环
        System.out.println("增强 for 循环：");
        for (int num : arr) {
            System.out.print(num + " ");
        }
        System.out.println();
        
        // 方式 3：使用 Arrays.toString
        System.out.println("Arrays.toString：");
        System.out.println(Arrays.toString(arr));
    }
}
```

### 示例 2：查找最大值和最小值

```java
public class FindMinMax {
    public static void main(String[] args) {
        int[] arr = {3, 1, 4, 1, 5, 9, 2, 6};
        
        int max = arr[0];
        int min = arr[0];
        
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] > max) {
                max = arr[i];
            }
            if (arr[i] < min) {
                min = arr[i];
            }
        }
        
        System.out.println("最大值：" + max);
        System.out.println("最小值：" + min);
    }
}
```

### 示例 3：数组反转

```java
public class ReverseArray {
    public static void main(String[] args) {
        int[] arr = {1, 2, 3, 4, 5};
        
        // 反转数组
        for (int i = 0; i < arr.length / 2; i++) {
            int temp = arr[i];
            arr[i] = arr[arr.length - 1 - i];
            arr[arr.length - 1 - i] = temp;
        }
        
        System.out.println(Arrays.toString(arr));  // [5, 4, 3, 2, 1]
    }
}
```

### 示例 4：二维数组遍历

```java
public class TwoDimensionalArray {
    public static void main(String[] args) {
        int[][] matrix = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        
        // 方式 1：传统 for 循环
        System.out.println("传统 for 循环：");
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.print(matrix[i][j] + " ");
            }
            System.out.println();
        }
        
        // 方式 2：增强 for 循环
        System.out.println("增强 for 循环：");
        for (int[] row : matrix) {
            for (int num : row) {
                System.out.print(num + " ");
            }
            System.out.println();
        }
        
        // 方式 3：使用 Arrays.deepToString
        System.out.println("Arrays.deepToString：");
        System.out.println(Arrays.deepToString(matrix));
    }
}
```

### 示例 5：数组操作综合示例

```java
import java.util.Arrays;

public class ArrayOperations {
    public static void main(String[] args) {
        // 创建数组
        int[] arr = {3, 1, 4, 1, 5, 9, 2, 6};
        
        // 排序
        Arrays.sort(arr);
        System.out.println("排序后：" + Arrays.toString(arr));
        
        // 查找
        int index = Arrays.binarySearch(arr, 5);
        System.out.println("5 的位置：" + index);
        
        // 复制
        int[] copy = Arrays.copyOf(arr, arr.length);
        System.out.println("复制数组：" + Arrays.toString(copy));
        
        // 填充
        int[] filled = new int[5];
        Arrays.fill(filled, 10);
        System.out.println("填充后：" + Arrays.toString(filled));
        
        // 比较
        boolean equal = Arrays.equals(arr, copy);
        System.out.println("数组相等：" + equal);
    }
}
```

## 数组的注意事项

### 1. 数组长度固定

```java
int[] arr = new int[5];
// arr.length = 10;  // ❌ 错误：length 是 final，不能修改

// 如果需要动态大小，使用 ArrayList
List<Integer> list = new ArrayList<>();
list.add(1);
list.add(2);
```

### 2. 数组是对象

```java
int[] arr = {1, 2, 3};
System.out.println(arr instanceof Object);  // true
System.out.println(arr.getClass().getName());  // [I
```

### 3. 数组的引用

```java
int[] arr1 = {1, 2, 3};
int[] arr2 = arr1;  // arr2 和 arr1 指向同一个数组

arr2[0] = 10;
System.out.println(arr1[0]);  // 10（修改了同一个数组）
```

### 4. 多维数组的内存布局

```java
// 二维数组实际上是"数组的数组"
int[][] matrix = new int[3][4];
// matrix 是一个包含 3 个元素的数组
// 每个元素又是一个包含 4 个 int 的数组
```

## 小结

Java 数组要点：

- **一维数组**：存储相同类型的元素
- **多维数组**：数组的数组，支持不规则数组
- **初始化**：默认初始化、显式初始化、循环初始化
- **访问**：使用索引访问，注意边界
- **Arrays 工具类**：提供排序、查找、复制等方法

**关键要点**：
- 数组长度固定，创建后不能改变
- 索引从 0 开始，到 length - 1 结束
- 数组是对象，存储在堆内存
- 使用 Arrays 工具类简化操作
- 需要动态大小时使用 ArrayList

理解了数组，你就能处理批量数据。在下一章，我们将学习 Java 的字符串处理。
