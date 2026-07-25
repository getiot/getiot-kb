---
sidebar_position: 4
slug: /java-primitive-wrapper
sidebar_label: Java 包装类
---

# Java 包装类（Integer / Long / Double / Boolean）

Java 的基本数据类型不是对象，但在某些场景下需要将基本类型当作对象使用。为了解决这个问题，Java 为每个基本类型提供了对应的包装类（Wrapper Class）。本章将详细介绍包装类的概念和使用。

## 包装类概念

### 什么是包装类

**包装类（Wrapper Class）** 是将基本数据类型封装成对象的类。每个基本类型都有对应的包装类：

| 基本类型 | 包装类 | 大小 |
|:--------:|:------:|:----:|
| byte | Byte | 8 位 |
| short | Short | 16 位 |
| int | Integer | 32 位 |
| long | Long | 64 位 |
| float | Float | 32 位 |
| double | Double | 64 位 |
| char | Character | 16 位 |
| boolean | Boolean | 1 位/1 字节 |

### 为什么需要包装类

1. **集合框架需要**：Java 集合（如 ArrayList）只能存储对象，不能存储基本类型
2. **泛型需要**：泛型只能使用引用类型
3. **方法参数**：某些方法需要对象类型
4. **提供工具方法**：包装类提供了很多有用的静态方法

```java
// ❌ 错误：集合不能存储基本类型
// List<int> list = new ArrayList<>();  // 编译错误

// ✅ 正确：使用包装类
List<Integer> list = new ArrayList<>();
list.add(10);
list.add(20);
```

## 自动装箱 / 拆箱

### 装箱（Boxing）

**装箱**是将基本类型转换为对应的包装类对象。

#### 手动装箱

```java
// 手动装箱
int num = 10;
Integer integer = Integer.valueOf(num);  // 方式 1：推荐
Integer integer2 = new Integer(num);     // 方式 2：已废弃
```

#### 自动装箱（Auto-boxing）

Java 5 引入了自动装箱，编译器会自动将基本类型转换为包装类：

```java
// 自动装箱：编译器自动转换为 Integer.valueOf(10)
Integer integer = 10;

// 等价于
Integer integer = Integer.valueOf(10);
```

### 拆箱（Unboxing）

**拆箱**是将包装类对象转换为对应的基本类型。

#### 手动拆箱

```java
// 手动拆箱
Integer integer = Integer.valueOf(10);
int num = integer.intValue();
```

#### 自动拆箱（Auto-unboxing）

Java 5 引入了自动拆箱，编译器会自动将包装类转换为基本类型：

```java
// 自动拆箱：编译器自动转换为 integer.intValue()
Integer integer = 10;
int num = integer;

// 等价于
int num = integer.intValue();
```

### 自动装箱/拆箱示例

```java
// 自动装箱
Integer a = 10;        // 自动装箱
Integer b = 20;        // 自动装箱

// 自动拆箱
int sum = a + b;       // a 和 b 自动拆箱，然后相加

// 混合使用
Integer result = a + b;  // a 和 b 自动拆箱，相加后自动装箱

// 集合中使用
List<Integer> list = new ArrayList<>();
list.add(10);         // 自动装箱
int value = list.get(0);  // 自动拆箱
```

### 注意事项

#### 1. 空指针异常

```java
Integer integer = null;
// int num = integer;  // ❌ 运行时错误：NullPointerException

// ✅ 正确：先检查 null
if (integer != null) {
    int num = integer;
}
```

#### 2. 性能考虑

```java
// 自动装箱/拆箱有性能开销
for (int i = 0; i < 1000000; i++) {
    Integer num = i;  // 每次循环都创建对象
}

// 在循环中尽量使用基本类型
for (int i = 0; i < 1000000; i++) {
    // 使用基本类型，避免装箱
}
```

#### 3. 比较陷阱

```java
Integer a = 100;
Integer b = 100;
System.out.println(a == b);  // true（缓存范围内）

Integer c = 200;
Integer d = 200;
System.out.println(c == d);  // false（超出缓存范围）

// ✅ 正确：使用 equals 比较
System.out.println(c.equals(d));  // true
```

**原因**：Integer 在 -128 到 127 之间有缓存，超出范围会创建新对象。

## 常用方法

包装类有一些常用的数据类型转换方法，例如 `parseXXX`、`valueOf`、`toString` 等。

### Integer 类常用方法

#### 1. 字符串转整数

```java
// parseInt：将字符串转换为 int
String str = "123";
int num = Integer.parseInt(str);  // 123

// valueOf：将字符串转换为 Integer 对象
Integer integer = Integer.valueOf("123");  // Integer 对象

// 指定进制
int binary = Integer.parseInt("1010", 2);   // 二进制：10
int hex = Integer.parseInt("FF", 16);       // 十六进制：255
```

#### 2. 整数转字符串

```java
int num = 123;

// 方式 1：使用 toString
String str1 = Integer.toString(num);  // "123"

// 方式 2：使用 String.valueOf
String str2 = String.valueOf(num);    // "123"

// 方式 3：使用 + 连接
String str3 = "" + num;               // "123"

// 指定进制
String binary = Integer.toBinaryString(10);  // "1010"
String hex = Integer.toHexString(255);       // "ff"
String octal = Integer.toOctalString(8);     // "10"
```

#### 3. 比较方法

```java
Integer a = 10;
Integer b = 20;

// compareTo：比较大小
int result = a.compareTo(b);  // -1（a < b）
// 返回：负数（小于）、0（等于）、正数（大于）

// equals：比较值
boolean equal = a.equals(b);  // false
```

#### 4. 其他常用方法

```java
Integer num = 10;

// 获取基本类型值
int value = num.intValue();
long longValue = num.longValue();
double doubleValue = num.doubleValue();

// 获取最大值和最小值
int max = Integer.MAX_VALUE;  // 2,147,483,647
int min = Integer.MIN_VALUE;  // -2,147,483,648

// 判断是否为数字
boolean isDigit = Character.isDigit('5');  // true
```

### Long 类常用方法

```java
// 字符串转 long
long num = Long.parseLong("1234567890");

// long 转字符串
String str = Long.toString(1234567890L);

// 其他方法类似 Integer
Long max = Long.MAX_VALUE;
Long min = Long.MIN_VALUE;
```

### Double 类常用方法

```java
// 字符串转 double
double num = Double.parseDouble("3.14");

// double 转字符串
String str = Double.toString(3.14);

// 判断是否为有限数
boolean isFinite = Double.isFinite(3.14);  // true
boolean isNaN = Double.isNaN(Double.NaN);  // true
boolean isInfinite = Double.isInfinite(Double.POSITIVE_INFINITY);  // true
```

### Boolean 类常用方法

```java
// 字符串转 boolean
boolean b1 = Boolean.parseBoolean("true");   // true
boolean b2 = Boolean.parseBoolean("false");  // false
boolean b3 = Boolean.parseBoolean("yes");    // false（只有 "true" 返回 true）

// boolean 转字符串
String str = Boolean.toString(true);  // "true"

// valueOf
Boolean bool = Boolean.valueOf("true");
```

### Character 类常用方法

```java
char ch = 'A';

// 判断字符类型
boolean isLetter = Character.isLetter(ch);      // true
boolean isDigit = Character.isDigit('5');        // true
boolean isWhitespace = Character.isWhitespace(' ');  // true
boolean isUpperCase = Character.isUpperCase(ch);      // true
boolean isLowerCase = Character.isLowerCase('a');     // true

// 字符转换
char upper = Character.toUpperCase('a');  // 'A'
char lower = Character.toLowerCase('A');  // 'a'

// 字符转数字
int code = Character.getNumericValue('5');  // 5
```

## Arrays / Objects 工具类概览

### Arrays 工具类

`java.util.Arrays` 提供了操作数组的静态方法。

#### 1. 数组排序

```java
int[] arr = {3, 1, 4, 1, 5, 9, 2, 6};

// 排序
Arrays.sort(arr);  // [1, 1, 2, 3, 4, 5, 6, 9]

// 部分排序
int[] arr2 = {3, 1, 4, 1, 5, 9, 2, 6};
Arrays.sort(arr2, 0, 4);  // 只排序前 4 个元素
```

#### 2. 数组查找

```java
int[] arr = {1, 2, 3, 4, 5};

// 二分查找（数组必须已排序）
int index = Arrays.binarySearch(arr, 3);  // 2

// 未找到返回负数
int notFound = Arrays.binarySearch(arr, 6);  // -6
```

#### 3. 数组比较

```java
int[] arr1 = {1, 2, 3};
int[] arr2 = {1, 2, 3};
int[] arr3 = {1, 2, 4};

// 比较数组内容
boolean equal = Arrays.equals(arr1, arr2);  // true
boolean notEqual = Arrays.equals(arr1, arr3);  // false
```

#### 4. 数组填充

```java
int[] arr = new int[5];

// 填充所有元素
Arrays.fill(arr, 10);  // [10, 10, 10, 10, 10]

// 填充部分元素
int[] arr2 = new int[5];
Arrays.fill(arr2, 1, 3, 20);  // [0, 20, 20, 0, 0]
```

#### 5. 数组转字符串

```java
int[] arr = {1, 2, 3};

// 转字符串
String str = Arrays.toString(arr);  // "[1, 2, 3]"
```

#### 6. 数组复制

```java
int[] original = {1, 2, 3, 4, 5};

// 复制整个数组
int[] copy = Arrays.copyOf(original, original.length);

// 复制部分数组
int[] partial = Arrays.copyOf(original, 3);  // [1, 2, 3]

// 复制指定范围
int[] range = Arrays.copyOfRange(original, 1, 4);  // [2, 3, 4]
```

### Objects 工具类

`java.util.Objects` 提供了操作对象的静态方法（Java 7+）。

#### 1. 空值检查

```java
String str = null;

// 检查是否为 null
boolean isNull = Objects.isNull(str);      // true
boolean nonNull = Objects.nonNull(str);    // false

// 要求非 null（为 null 抛出异常）
// Objects.requireNonNull(str);  // 抛出 NullPointerException
```

#### 2. 对象比较

```java
String a = "hello";
String b = "hello";
String c = null;

// 安全的 equals（避免空指针）
boolean equal1 = Objects.equals(a, b);  // true
boolean equal2 = Objects.equals(a, c);  // false（不会抛异常）
boolean equal3 = Objects.equals(c, c);  // true（两个 null 相等）

// 深度比较
int[] arr1 = {1, 2, 3};
int[] arr2 = {1, 2, 3};
boolean deepEqual = Objects.deepEquals(arr1, arr2);  // true
```

#### 3. 哈希码

```java
String str = "hello";

// 计算哈希码（null 安全）
int hash = Objects.hashCode(str);  // 如果 str 为 null，返回 0

// 多个对象的哈希码
int combinedHash = Objects.hash("hello", 123, true);
```

#### 4. 字符串表示

```java
String str = "hello";

// toString（null 安全）
String result = Objects.toString(str);        // "hello"
String result2 = Objects.toString(null);       // "null"
String result3 = Objects.toString(null, "默认值");  // "默认值"
```

## 实际示例

### 示例 1：包装类的使用

```java
public class WrapperExample {
    public static void main(String[] args) {
        // 自动装箱
        Integer a = 10;
        Integer b = 20;
        
        // 自动拆箱
        int sum = a + b;
        System.out.println("和：" + sum);
        
        // 集合中使用
        List<Integer> numbers = new ArrayList<>();
        numbers.add(1);
        numbers.add(2);
        numbers.add(3);
        
        // 自动拆箱
        for (int num : numbers) {
            System.out.println(num);
        }
    }
}
```

### 示例 2：字符串转换

```java
public class ConversionExample {
    public static void main(String[] args) {
        // 字符串转数字
        String str = "123";
        int num = Integer.parseInt(str);
        System.out.println("数字：" + num);
        
        // 数字转字符串
        int value = 456;
        String str2 = String.valueOf(value);
        System.out.println("字符串：" + str2);
        
        // 不同进制转换
        String binary = "1010";
        int decimal = Integer.parseInt(binary, 2);
        System.out.println("二进制 " + binary + " = 十进制 " + decimal);
        
        int hexValue = Integer.parseInt("FF", 16);
        System.out.println("十六进制 FF = 十进制 " + hexValue);
    }
}
```

### 示例 3：Arrays 工具类使用

```java
import java.util.Arrays;

public class ArraysExample {
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
    }
}
```

## 小结

Java 包装类要点：

- **包装类概念**：将基本类型封装成对象
- **自动装箱/拆箱**：Java 5 引入，自动转换基本类型和包装类
- **常用方法**：parseXXX、valueOf、toString 等
- **工具类**：Arrays 和 Objects 提供实用方法

**关键要点**：
- 集合和泛型必须使用包装类
- 注意自动装箱/拆箱的性能开销
- 比较包装类使用 equals，不要用 ==
- 注意空指针异常
- 充分利用 Arrays 和 Objects 工具类

理解了包装类，你就能在需要对象的地方使用基本类型。在下一章，我们将学习 Java 的运算符。
