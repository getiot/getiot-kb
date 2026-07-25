---
sidebar_position: 2
slug: /java-utils
sidebar_label: Java 常用工具类
---

# Java 常用工具类（Objects / Arrays / Collections 等）

Java 提供了丰富的工具类来简化常见操作。理解这些工具类的使用可以提高开发效率。本章将详细介绍 Java 中的常用工具类。

## Objects 类

**`Objects` 类**（java.util.Objects，Java 7+）提供了操作对象的静态方法，主要用于空值检查和对象比较，包括 requireNonNull、equals、hashCode 等。

### requireNonNull 方法

检查对象是否为 null，为 null 时抛出异常：

```java
import java.util.Objects;

public void method(String str) {
    // 检查 null，如果为 null 抛出 NullPointerException
    String nonNull = Objects.requireNonNull(str);
    
    // 带自定义消息
    String nonNull2 = Objects.requireNonNull(str, "字符串不能为 null");
    
    // 带消息提供者（延迟计算）
    String nonNull3 = Objects.requireNonNull(str, () -> "字符串不能为 null");
}
```

### equals 方法

安全的对象比较，避免空指针异常：

```java
String str1 = "hello";
String str2 = "hello";
String str3 = null;

// ✅ 安全比较
boolean equal1 = Objects.equals(str1, str2);  // true
boolean equal2 = Objects.equals(str1, str3);  // false（不会抛异常）
boolean equal3 = Objects.equals(str3, str3);  // true（两个 null 相等）

// ❌ 不安全比较
// boolean equal = str1.equals(str3);  // 可能抛出 NullPointerException
```

### hashCode 方法

计算对象的哈希码，null 安全：

```java
String str = "hello";
int hash = Objects.hashCode(str);  // 如果 str 为 null，返回 0

// 多个对象的哈希码
int combinedHash = Objects.hash("hello", 123, true);
```

### 其他常用方法

```java
// 检查是否为 null
boolean isNull = Objects.isNull(str);      // str == null
boolean nonNull = Objects.nonNull(str);    // str != null

// 深度比较
int[] arr1 = {1, 2, 3};
int[] arr2 = {1, 2, 3};
boolean deepEqual = Objects.deepEquals(arr1, arr2);  // true

// toString（null 安全）
String result = Objects.toString(str);        // 如果 null 返回 "null"
String result2 = Objects.toString(str, "默认值");  // 如果 null 返回 "默认值"
```

## Arrays 类

**`Arrays` 类**（java.util.Arrays）提供了操作数组的静态方法，包括 sort、binarySearch、copyOf 等。

### sort 方法

数组排序：

```java
import java.util.Arrays;

int[] arr = {3, 1, 4, 1, 5, 9, 2, 6};

// 排序整个数组
Arrays.sort(arr);  // {1, 1, 2, 3, 4, 5, 6, 9}

// 排序指定范围
int[] arr2 = {3, 1, 4, 1, 5, 9, 2, 6};
Arrays.sort(arr2, 0, 4);  // 只排序前 4 个元素

// 对象数组排序（需要实现 Comparable）
String[] names = {"Charlie", "Alice", "Bob"};
Arrays.sort(names);  // {"Alice", "Bob", "Charlie"}
```

### binarySearch 方法

二分查找（数组必须已排序）：

```java
int[] arr = {1, 2, 3, 4, 5};

// 查找元素
int index = Arrays.binarySearch(arr, 3);  // 2

// 未找到返回负数
int notFound = Arrays.binarySearch(arr, 6);  // -6

// 在指定范围内查找
int index2 = Arrays.binarySearch(arr, 0, 3, 2);  // 在索引 0-2 范围内查找
```

### copyOf 方法

复制数组：

```java
int[] original = {1, 2, 3, 4, 5};

// 复制整个数组
int[] copy = Arrays.copyOf(original, original.length);

// 复制部分数组（指定长度）
int[] partial = Arrays.copyOf(original, 3);  // {1, 2, 3}

// 复制指定范围
int[] range = Arrays.copyOfRange(original, 1, 4);  // {2, 3, 4}
```

### 其他常用方法

```java
// 比较数组
int[] arr1 = {1, 2, 3};
int[] arr2 = {1, 2, 3};
boolean equal = Arrays.equals(arr1, arr2);  // true

// 填充数组
int[] arr = new int[5];
Arrays.fill(arr, 10);  // {10, 10, 10, 10, 10}
Arrays.fill(arr, 1, 3, 20);  // {10, 20, 20, 10, 10}

// 转字符串
String str = Arrays.toString(arr);  // "[1, 2, 3]"

// 转列表（固定大小）
List<String> list = Arrays.asList("a", "b", "c");
```

## Collections 类

**`Collections` 类**（java.util.Collections）提供了操作集合的静态方法，包括 sort、shuffle、reverse 等。

### sort 方法

集合排序：

```java
import java.util.*;

List<Integer> list = new ArrayList<>(Arrays.asList(3, 1, 4, 1, 5));

// 排序
Collections.sort(list);  // {1, 1, 3, 4, 5}

// 自定义排序
Collections.sort(list, Collections.reverseOrder());  // 降序

// 使用自定义比较器
Collections.sort(list, (a, b) -> b - a);  // 降序
```

### shuffle 方法

随机打乱集合：

```java
List<Integer> list = new ArrayList<>(Arrays.asList(1, 2, 3, 4, 5));

// 打乱顺序
Collections.shuffle(list);  // 随机顺序

// 使用指定的随机数生成器
Random random = new Random(42);
Collections.shuffle(list, random);
```

### reverse 方法

反转集合：

```java
List<Integer> list = new ArrayList<>(Arrays.asList(1, 2, 3, 4, 5));

// 反转
Collections.reverse(list);  // {5, 4, 3, 2, 1}
```

### 其他常用方法

```java
// 查找
List<Integer> list = Arrays.asList(1, 2, 3, 4, 5);
int index = Collections.binarySearch(list, 3);  // 2（必须已排序）

// 最大最小值
int max = Collections.max(list);  // 5
int min = Collections.min(list);  // 1

// 频率统计
int frequency = Collections.frequency(list, 1);  // 1 出现的次数

// 替换
Collections.replaceAll(list, 1, 10);  // 将所有 1 替换为 10

// 填充
Collections.fill(list, 0);  // 用 0 填充所有元素

// 交换
Collections.swap(list, 0, 4);  // 交换索引 0 和 4 的元素

// 旋转
Collections.rotate(list, 2);  // 向右旋转 2 个位置

// 创建不可变集合
List<Integer> unmodifiable = Collections.unmodifiableList(list);

// 创建同步集合
List<Integer> synchronized = Collections.synchronizedList(list);
```

## UUID 与随机数生成

### UUID 类

**UUID**（Universally Unique Identifier）用于生成唯一标识符。

```java
import java.util.UUID;

// 生成随机 UUID
UUID uuid = UUID.randomUUID();
String uuidString = uuid.toString();  // "550e8400-e29b-41d4-a716-446655440000"

// 从字符串创建 UUID
UUID uuid2 = UUID.fromString("550e8400-e29b-41d4-a716-446655440000");

// 获取 UUID 的各个部分
long mostSignificantBits = uuid.getMostSignificantBits();
long leastSignificantBits = uuid.getLeastSignificantBits();
```

### 随机数生成

使用 `Random` 类生成随机数：

```java
import java.util.Random;

Random random = new Random();

// 生成随机整数
int randomInt = random.nextInt();  // 任意整数
int randomIntRange = random.nextInt(100);  // 0-99

// 生成随机浮点数
double randomDouble = random.nextDouble();  // 0.0-1.0
float randomFloat = random.nextFloat();     // 0.0-1.0

// 生成随机布尔值
boolean randomBoolean = random.nextBoolean();

// 使用种子（可重现）
Random seededRandom = new Random(42);
int value = seededRandom.nextInt(100);
```

**`ThreadLocalRandom`（Java 7+）**：线程安全的随机数生成器

```java
import java.util.concurrent.ThreadLocalRandom;

// 不需要创建实例，直接使用
int randomInt = ThreadLocalRandom.current().nextInt(100);
double randomDouble = ThreadLocalRandom.current().nextDouble();
```

## 示例：数组排序、集合工具方法应用

### 示例 1：数组操作

```java
import java.util.Arrays;

public class ArrayExample {
    public static void main(String[] args) {
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

### 示例 2：集合操作

```java
import java.util.*;

public class CollectionExample {
    public static void main(String[] args) {
        List<Integer> list = new ArrayList<>(Arrays.asList(3, 1, 4, 1, 5, 9, 2, 6));
        
        // 排序
        Collections.sort(list);
        System.out.println("排序后：" + list);
        
        // 反转
        Collections.reverse(list);
        System.out.println("反转后：" + list);
        
        // 打乱
        Collections.shuffle(list);
        System.out.println("打乱后：" + list);
        
        // 最大最小值
        System.out.println("最大值：" + Collections.max(list));
        System.out.println("最小值：" + Collections.min(list));
        
        // 频率统计
        System.out.println("1 出现的次数：" + Collections.frequency(list, 1));
        
        // 替换
        Collections.replaceAll(list, 1, 10);
        System.out.println("替换后：" + list);
    }
}
```

### 示例 3：UUID 和随机数

```java
import java.util.UUID;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

public class RandomExample {
    public static void main(String[] args) {
        // UUID
        UUID uuid = UUID.randomUUID();
        System.out.println("UUID：" + uuid.toString());
        
        // Random
        Random random = new Random();
        System.out.println("随机整数（0-99）：" + random.nextInt(100));
        System.out.println("随机浮点数：" + random.nextDouble());
        
        // ThreadLocalRandom
        int value = ThreadLocalRandom.current().nextInt(1, 101);  // 1-100
        System.out.println("随机数（1-100）：" + value);
        
        // 生成随机字符串
        String randomString = generateRandomString(10);
        System.out.println("随机字符串：" + randomString);
    }
    
    private static String generateRandomString(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }
}
```

### 示例 4：综合应用

```java
import java.util.*;

public class UtilsExample {
    public static void main(String[] args) {
        // Objects 使用
        String str = "hello";
        String nullStr = null;
        
        System.out.println("equals：" + Objects.equals(str, "hello"));  // true
        System.out.println("equals null：" + Objects.equals(str, nullStr));  // false
        
        // Arrays 使用
        int[] arr = {3, 1, 4, 1, 5};
        Arrays.sort(arr);
        System.out.println("排序后：" + Arrays.toString(arr));
        
        // Collections 使用
        List<String> list = new ArrayList<>(Arrays.asList("c", "a", "b"));
        Collections.sort(list);
        System.out.println("排序后：" + list);
        
        // UUID
        UUID uuid = UUID.randomUUID();
        System.out.println("UUID：" + uuid);
    }
}
```

## 小结

Java 常用工具类要点：

- **Objects**：空值检查、对象比较、哈希码计算
- **Arrays**：数组排序、查找、复制、填充
- **Collections**：集合排序、打乱、反转、查找
- **UUID**：生成唯一标识符
- **Random**：生成随机数

**关键要点**：
- Objects 提供 null 安全的操作
- Arrays 提供数组操作工具
- Collections 提供集合操作工具
- UUID 用于生成唯一 ID
- Random 用于生成随机数

理解了常用工具类，你就能更高效地处理数据和对象。在下一章，我们将学习 Java 的数学和随机数类。
