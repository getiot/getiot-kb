---
sidebar_position: 3
slug: /java-math
sidebar_label: Java 数学与随机数
---

# Java 数学与随机数（Math / Random）

Java 提供了 `Math` 类和 `Random` 类来处理数学运算和随机数生成。理解这些类的使用是进行数值计算的基础。本章将详细介绍 Java 中的数学和随机数处理。

## Math 类常用方法

### Math 类概述

**`Math` 类**提供了常用的数学运算方法，所有方法都是静态的。包括 abs、ceil、floor、round、pow、sqrt、max、min 等。

### 绝对值

```java
int abs1 = Math.abs(-10);      // 10
double abs2 = Math.abs(-10.5); // 10.5
long abs3 = Math.abs(-10L);    // 10
```

### 取整方法

```java
// ceil：向上取整
double ceil1 = Math.ceil(3.2);   // 4.0
double ceil2 = Math.ceil(-3.2);  // -3.0

// floor：向下取整
double floor1 = Math.floor(3.8);   // 3.0
double floor2 = Math.floor(-3.8);  // -4.0

// round：四舍五入
long round1 = Math.round(3.4);   // 3
long round2 = Math.round(3.6);   // 4
long round3 = Math.round(-3.5);  // -3（注意：-3.5 舍入为 -3）

// rint：最接近的整数（返回 double）
double rint1 = Math.rint(3.5);   // 4.0
double rint2 = Math.rint(4.5);   // 4.0（偶数舍入）
```

### 幂运算

```java
// pow：幂运算
double pow1 = Math.pow(2, 3);    // 8.0（2 的 3 次方）
double pow2 = Math.pow(2, 0.5); // 1.414...（2 的平方根）

// sqrt：平方根
double sqrt1 = Math.sqrt(16);   // 4.0
double sqrt2 = Math.sqrt(2);    // 1.414...

// cbrt：立方根（Java 5+）
double cbrt = Math.cbrt(27);    // 3.0

// exp：e 的幂
double exp = Math.exp(1);        // 2.718...（e）

// log：自然对数
double log = Math.log(Math.E);  // 1.0

// log10：以 10 为底的对数
double log10 = Math.log10(100); // 2.0
```

### 最大值和最小值

```java
// max：最大值
int max1 = Math.max(10, 20);        // 20
double max2 = Math.max(10.5, 20.3); // 20.3

// min：最小值
int min1 = Math.min(10, 20);        // 10
double min2 = Math.min(10.5, 20.3); // 10.5
```

### 三角函数

```java
// 角度转弧度
double radians = Math.toRadians(90);  // π/2

// 弧度转角度
double degrees = Math.toDegrees(Math.PI);  // 180.0

// 三角函数（参数是弧度）
double sin = Math.sin(Math.PI / 2);   // 1.0
double cos = Math.cos(0);              // 1.0
double tan = Math.tan(Math.PI / 4);    // 1.0

// 反三角函数
double asin = Math.asin(1);            // π/2
double acos = Math.acos(1);             // 0
double atan = Math.atan(1);             // π/4
```

### 其他常用方法

```java
// 随机数（0.0 到 1.0）
double random = Math.random();

// 符号函数
int signum1 = (int) Math.signum(10.5);   // 1
int signum2 = (int) Math.signum(-10.5);  // -1
int signum3 = (int) Math.signum(0);      // 0

// 次方取模
long powMod = (long) Math.pow(2, 10) % 1000;  // 24

// 常量
double pi = Math.PI;        // 3.14159...
double e = Math.E;          // 2.71828...
```

## Random 类生成随机数

### Random 类概述

**`Random` 类**用于生成伪随机数。

### 基本使用

```java
import java.util.Random;

Random random = new Random();

// 生成随机整数
int randomInt = random.nextInt();        // 任意整数
int randomIntRange = random.nextInt(100); // 0-99

// 生成随机浮点数
double randomDouble = random.nextDouble(); // 0.0-1.0
float randomFloat = random.nextFloat();    // 0.0-1.0

// 生成随机布尔值
boolean randomBoolean = random.nextBoolean();

// 生成随机长整数
long randomLong = random.nextLong();

// 生成随机字节数组
byte[] bytes = new byte[10];
random.nextBytes(bytes);
```

### 使用种子

**使用种子可以生成可重现的随机数序列**：

```java
// 使用种子
Random random1 = new Random(42);
Random random2 = new Random(42);

// 相同的种子生成相同的序列
int value1 = random1.nextInt(100);
int value2 = random2.nextInt(100);
// value1 == value2
```

## 安全的随机数生成器

### ThreadLocalRandom（Java 7+）

**`ThreadLocalRandom`** 是线程安全的随机数生成器，性能更好。

```java
import java.util.concurrent.ThreadLocalRandom;

// 不需要创建实例，直接使用
int randomInt = ThreadLocalRandom.current().nextInt(100);
double randomDouble = ThreadLocalRandom.current().nextDouble();

// 指定范围
int value = ThreadLocalRandom.current().nextInt(1, 101);  // 1-100
double value2 = ThreadLocalRandom.current().nextDouble(1.0, 10.0);  // 1.0-10.0
```

**优势**：
- 线程安全
- 性能更好（避免同步开销）
- 不需要创建实例

### SecureRandom

**`SecureRandom`** 是加密安全的随机数生成器，用于安全相关场景。

```java
import java.security.SecureRandom;

SecureRandom secureRandom = new SecureRandom();

// 生成加密安全的随机数
int secureInt = secureRandom.nextInt(100);
byte[] secureBytes = new byte[16];
secureRandom.nextBytes(secureBytes);

// 使用指定的算法
SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
```

**使用场景**：
- 生成密码
- 生成密钥
- 生成令牌
- 其他安全相关场景

## 示例：生成随机验证码、数学计算示例

### 示例 1：生成随机验证码

```java
import java.util.Random;

public class VerificationCodeGenerator {
    private static final String CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    public static String generateCode(int length) {
        Random random = new Random();
        StringBuilder code = new StringBuilder();
        
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(CHARS.length());
            code.append(CHARS.charAt(index));
        }
        
        return code.toString();
    }
    
    public static void main(String[] args) {
        String code = generateCode(6);
        System.out.println("验证码：" + code);
    }
}
```

### 示例 2：数学计算

```java
public class MathExample {
    public static void main(String[] args) {
        // 基本运算
        System.out.println("绝对值：" + Math.abs(-10));
        System.out.println("最大值：" + Math.max(10, 20));
        System.out.println("最小值：" + Math.min(10, 20));
        
        // 取整
        System.out.println("向上取整：" + Math.ceil(3.2));
        System.out.println("向下取整：" + Math.floor(3.8));
        System.out.println("四舍五入：" + Math.round(3.6));
        
        // 幂运算
        System.out.println("2 的 3 次方：" + Math.pow(2, 3));
        System.out.println("16 的平方根：" + Math.sqrt(16));
        System.out.println("27 的立方根：" + Math.cbrt(27));
        
        // 对数
        System.out.println("e 的 1 次方：" + Math.exp(1));
        System.out.println("ln(e)：" + Math.log(Math.E));
        System.out.println("log10(100)：" + Math.log10(100));
        
        // 三角函数
        double angle = 45;
        double radians = Math.toRadians(angle);
        System.out.println("sin(45°)：" + Math.sin(radians));
        System.out.println("cos(45°)：" + Math.cos(radians));
        System.out.println("tan(45°)：" + Math.tan(radians));
        
        // 常量
        System.out.println("π：" + Math.PI);
        System.out.println("e：" + Math.E);
    }
}
```

### 示例 3：随机数应用

```java
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;
import java.security.SecureRandom;

public class RandomExample {
    public static void main(String[] args) {
        // Random
        Random random = new Random();
        System.out.println("Random 整数（0-99）：" + random.nextInt(100));
        System.out.println("Random 浮点数：" + random.nextDouble());
        
        // ThreadLocalRandom
        int value = ThreadLocalRandom.current().nextInt(1, 101);
        System.out.println("ThreadLocalRandom（1-100）：" + value);
        
        // SecureRandom
        SecureRandom secureRandom = new SecureRandom();
        byte[] token = new byte[16];
        secureRandom.nextBytes(token);
        System.out.println("SecureRandom 令牌：" + bytesToHex(token));
        
        // 生成随机密码
        String password = generatePassword(12);
        System.out.println("随机密码：" + password);
    }
    
    private static String generatePassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*";
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();
        
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(chars.length());
            password.append(chars.charAt(index));
        }
        
        return password.toString();
    }
    
    private static String bytesToHex(byte[] bytes) {
        StringBuilder hex = new StringBuilder();
        for (byte b : bytes) {
            hex.append(String.format("%02x", b));
        }
        return hex.toString();
    }
}
```

### 示例 4：数学计算工具

```java
public class MathUtils {
    // 计算圆的面积
    public static double circleArea(double radius) {
        return Math.PI * Math.pow(radius, 2);
    }
    
    // 计算两点间距离
    public static double distance(double x1, double y1, double x2, double y2) {
        return Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
    }
    
    // 判断是否为质数
    public static boolean isPrime(int n) {
        if (n < 2) return false;
        if (n == 2) return true;
        if (n % 2 == 0) return false;
        
        int sqrt = (int) Math.sqrt(n);
        for (int i = 3; i <= sqrt; i += 2) {
            if (n % i == 0) return false;
        }
        return true;
    }
    
    // 计算阶乘
    public static long factorial(int n) {
        if (n < 0) throw new IllegalArgumentException("n 必须 >= 0");
        if (n <= 1) return 1;
        
        long result = 1;
        for (int i = 2; i <= n; i++) {
            result *= i;
        }
        return result;
    }
    
    public static void main(String[] args) {
        System.out.println("圆的面积（半径 5）：" + circleArea(5));
        System.out.println("两点距离：" + distance(0, 0, 3, 4));
        System.out.println("17 是质数：" + isPrime(17));
        System.out.println("5! = " + factorial(5));
    }
}
```

## Math 和 Random 的最佳实践

### 1. 使用 Math 进行数学运算

```java
// ✅ 推荐：使用 Math 类的方法
double area = Math.PI * Math.pow(radius, 2);

// ❌ 不推荐：自己实现
// double area = 3.14159 * radius * radius;
```

### 2. 选择合适的随机数生成器

```java
// 一般用途：Random
Random random = new Random();

// 多线程：ThreadLocalRandom
int value = ThreadLocalRandom.current().nextInt(100);

// 安全相关：SecureRandom
SecureRandom secureRandom = new SecureRandom();
```

### 3. 注意精度问题

```java
// 浮点数比较
double a = 0.1 + 0.2;
double b = 0.3;

// ❌ 不推荐：直接比较
// if (a == b) { }

// ✅ 推荐：使用误差范围
double epsilon = 0.0001;
if (Math.abs(a - b) < epsilon) {
    // 相等
}
```

## 小结

Java 数学与随机数要点：

- **Math 类**：提供数学运算方法（abs、ceil、floor、pow、sqrt 等）
- **Random 类**：生成伪随机数
- **ThreadLocalRandom**：线程安全的随机数生成器
- **SecureRandom**：加密安全的随机数生成器
- **应用场景**：数学计算、随机数生成、验证码生成

**关键要点**：
- Math 类所有方法都是静态的
- Random 可以使用种子生成可重现序列
- ThreadLocalRandom 性能更好，适合多线程
- SecureRandom 用于安全相关场景
- 注意浮点数精度问题

理解了数学和随机数类，你就能进行各种数值计算。在下一章，我们将学习 Java 的日期和时间处理。
