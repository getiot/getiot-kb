---
sidebar_position: 2
slug: /java-data-types
sidebar_label: Java 数据类型
---

# Java 数据类型（基本类型）

Java 是一门强类型语言，每个变量都必须有明确的数据类型。理解 Java 的数据类型是编写正确程序的基础。本章将详细介绍 Java 的基本数据类型及其使用。

## 基本数据类型

Java 有 **8 种基本数据类型**（Primitive Types），它们不是对象，直接存储在栈内存中，性能较高。

### 整数类型

#### int（整型）

- **大小**：32 位（4 字节）
- **取值范围**：-2³¹ 到 2³¹-1（-2,147,483,648 到 2,147,483,647）
- **默认值**：0
- **最常用**：日常开发中最常用的整数类型

```java
int age = 25;
int count = 100;
int maxValue = Integer.MAX_VALUE;  // 2,147,483,647
int minValue = Integer.MIN_VALUE;  // -2,147,483,648
```

#### long（长整型）

- **大小**：64 位（8 字节）
- **取值范围**：-2⁶³ 到 2⁶³-1
- **默认值**：0L
- **使用场景**：需要存储更大的整数

```java
long population = 8000000000L;  // 注意：需要加 L 后缀
long timestamp = System.currentTimeMillis();
long maxLong = Long.MAX_VALUE;  // 9,223,372,036,854,775,807
```

**注意**：long 类型字面量需要加 `L` 或 `l` 后缀（推荐使用大写 `L`，避免与数字 1 混淆）

#### byte（字节型）

- **大小**：8 位（1 字节）
- **取值范围**：-128 到 127
- **默认值**：0
- **使用场景**：处理二进制数据、网络编程

```java
byte b = 100;
byte minByte = Byte.MIN_VALUE;  // -128
byte maxByte = Byte.MAX_VALUE;  // 127
```

#### short（短整型）

- **大小**：16 位（2 字节）
- **取值范围**：-32,768 到 32,767
- **默认值**：0
- **使用场景**：节省内存（现在较少使用）

```java
short year = 2024;
short minShort = Short.MIN_VALUE;  // -32,768
short maxShort = Short.MAX_VALUE;  // 32,767
```

### 浮点类型

#### float（单精度浮点型）

- **大小**：32 位（4 字节）
- **精度**：约 7 位有效数字
- **取值范围**：约 ±3.4 × 10³⁸
- **默认值**：0.0f
- **使用场景**：对精度要求不高的浮点数

```java
float price = 99.99f;  // 注意：需要加 f 后缀
float pi = 3.14159f;
float maxFloat = Float.MAX_VALUE;
```

**注意**：float 类型字面量需要加 `f` 或 `F` 后缀

#### double（双精度浮点型）

- **大小**：64 位（8 字节）
- **精度**：约 15-17 位有效数字
- **取值范围**：约 ±1.7 × 10³⁰⁸
- **默认值**：0.0
- **最常用**：日常开发中最常用的浮点类型

```java
double height = 175.5;  // 默认是 double，不需要后缀
double weight = 70.5;
double pi = 3.141592653589793;
double maxDouble = Double.MAX_VALUE;
```

### 字符类型

#### char（字符型）

- **大小**：16 位（2 字节）
- **取值范围**：Unicode 字符（0 到 65,535）
- **默认值**：'\u0000'（空字符）
- **使用场景**：存储单个字符

```java
char grade = 'A';
char chinese = '中';
char unicode = '\u0041';  // 'A'
char newline = '\n';      // 换行符
char tab = '\t';          // 制表符
```

**注意**：
- 使用单引号 `''` 表示字符
- 可以存储 Unicode 字符
- 可以表示转义字符

### 布尔类型

#### boolean（布尔型）

- **大小**：JVM 实现相关（通常 1 位或 1 字节）
- **取值**：`true` 或 `false`
- **默认值**：false
- **使用场景**：条件判断、逻辑运算

```java
boolean isActive = true;
boolean isEmpty = false;
boolean result = (10 > 5);  // true
```

**注意**：Java 中的 boolean 不能转换为数字（与 C/C++ 不同）

## 数据类型大小与取值范围

### 完整对比表

| 类型 | 大小 | 取值范围 | 默认值 | 包装类 |
|:----:|:----:|:-------:|:------:|:------:|
| byte | 8 位 | -128 到 127 | 0 | Byte |
| short | 16 位 | -32,768 到 32,767 | 0 | Short |
| int | 32 位 | -2³¹ 到 2³¹-1 | 0 | Integer |
| long | 64 位 | -2⁶³ 到 2⁶³-1 | 0L | Long |
| float | 32 位 | ±3.4 × 10³⁸ | 0.0f | Float |
| double | 64 位 | ±1.7 × 10³⁰⁸ | 0.0 | Double |
| char | 16 位 | 0 到 65,535 | '\u0000' | Character |
| boolean | 1 位/1 字节 | true / false | false | Boolean |

### 获取取值范围

```java
// 整数类型
System.out.println("byte: " + Byte.MIN_VALUE + " 到 " + Byte.MAX_VALUE);
System.out.println("short: " + Short.MIN_VALUE + " 到 " + Short.MAX_VALUE);
System.out.println("int: " + Integer.MIN_VALUE + " 到 " + Integer.MAX_VALUE);
System.out.println("long: " + Long.MIN_VALUE + " 到 " + Long.MAX_VALUE);

// 浮点类型
System.out.println("float: " + Float.MIN_VALUE + " 到 " + Float.MAX_VALUE);
System.out.println("double: " + Double.MIN_VALUE + " 到 " + Double.MAX_VALUE);
```

## 类型转换（自动类型转换、强制类型转换）

### 自动类型转换（隐式转换）

**规则**：从小类型自动转换为大类型，不会丢失精度

**转换方向**：
```
byte → short → int → long → float → double
                ↑
               char
```

#### 示例

```java
// int 自动转换为 long
int a = 100;
long b = a;  // 自动转换

// int 自动转换为 double
int x = 10;
double y = x;  // 自动转换为 10.0

// char 自动转换为 int
char ch = 'A';
int code = ch;  // 自动转换为 65（ASCII 码）

// float 自动转换为 double
float f = 3.14f;
double d = f;  // 自动转换
```

### 强制类型转换（显式转换）

**规则**：从大类型转换为小类型，需要显式转换，可能丢失精度

**语法**：`(目标类型) 值`

#### 示例

```java
// double 强制转换为 int（丢失小数部分）
double d = 3.14;
int i = (int) d;  // i = 3

// long 强制转换为 int（可能溢出）
long l = 3000000000L;
int i = (int) l;  // 可能溢出

// int 强制转换为 byte（可能溢出）
int x = 200;
byte b = (byte) x;  // b = -56（溢出）

// char 和 int 相互转换
char ch = 'A';
int code = (int) ch;  // code = 65
char ch2 = (char) 65;  // ch2 = 'A'
```

### 类型转换注意事项

#### 1. 精度丢失

```java
// 浮点数转整数，丢失小数部分
double d = 9.99;
int i = (int) d;  // i = 9，丢失 0.99

// 大整数转小整数，可能溢出
long l = 3000000000L;
int i = (int) l;  // 溢出，结果不正确
```

#### 2. 溢出问题

```java
// byte 范围：-128 到 127
int x = 200;
byte b = (byte) x;  // b = -56（溢出）

// 检查是否溢出
if (x >= Byte.MIN_VALUE && x <= Byte.MAX_VALUE) {
    byte b = (byte) x;
} else {
    System.out.println("值超出 byte 范围");
}
```

#### 3. 字符转换

```java
// 数字转字符
int code = 65;
char ch = (char) code;  // 'A'

// 字符转数字
char ch = 'A';
int code = (int) ch;  // 65

// 字符数字转整数
char digit = '5';
int num = digit - '0';  // num = 5
```

### 实际应用示例

#### 示例 1：计算平均值

```java
int sum = 100;
int count = 3;
// 需要将其中一个转换为 double，避免整数除法
double average = (double) sum / count;  // 33.333...
// 或
double average = sum / (double) count;
```

#### 示例 2：处理用户输入

```java
// 从字符串转换为数字
String input = "123";
int number = Integer.parseInt(input);

// 从数字转换为字符串
int num = 456;
String str = String.valueOf(num);
```

#### 示例 3：类型安全的转换

```java
public class TypeConversion {
    public static void main(String[] args) {
        // 自动转换
        int a = 10;
        long b = a;  // int → long
        double c = b;  // long → double
        
        // 强制转换
        double d = 9.99;
        int e = (int) d;  // double → int，e = 9
        
        // 字符转换
        char ch = 'A';
        int code = ch;  // char → int，code = 65
        char ch2 = (char) (code + 1);  // 'B'
        
        System.out.println("a = " + a);
        System.out.println("b = " + b);
        System.out.println("c = " + c);
        System.out.println("d = " + d);
        System.out.println("e = " + e);
        System.out.println("ch = " + ch);
        System.out.println("code = " + code);
        System.out.println("ch2 = " + ch2);
    }
}
```

## 数据类型选择建议

### 整数类型选择

- **int**：日常开发首选，性能好，范围足够
- **long**：需要存储超过 int 范围的整数
- **byte/short**：特殊场景（网络编程、文件处理）或需要节省内存

### 浮点类型选择

- **double**：日常开发首选，精度更高
- **float**：对内存敏感的场景（如大量浮点数数组）

### 注意事项

1. **避免使用 float 和 double 进行精确计算**（如货币），使用 `BigDecimal`
2. **注意类型转换的精度丢失和溢出**
3. **使用合适的类型，避免不必要的内存浪费**

## 小结

Java 基本数据类型要点：

- **8 种基本类型**：byte、short、int、long、float、double、char、boolean
- **类型大小**：从 8 位到 64 位不等
- **类型转换**：自动转换（小→大）和强制转换（大→小）
- **注意事项**：精度丢失、溢出、类型选择

**关键要点**：
- int 和 double 是最常用的类型
- long 需要 L 后缀，float 需要 f 后缀
- 强制转换可能丢失精度或溢出
- 选择合适的类型平衡性能和精度

理解了数据类型，你就能正确地声明和使用变量。在下一章，我们将学习 Java 的变量和常量。
