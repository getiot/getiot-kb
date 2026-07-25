---
sidebar_position: 9
slug: /java-string
sidebar_label: Java 字符串
---

# Java 字符串（String / StringBuilder）

字符串是编程中最常用的数据类型之一。Java 提供了 String、StringBuilder 和 StringBuffer 三个字符串类。理解字符串的特性和使用方法是处理文本数据的基础。

## String 类与不可变性

### String 的不可变性

**String 是不可变的（immutable）**，一旦创建就不能修改。

```java
String str = "Hello";
str = str + " World";  // 不是修改原字符串，而是创建新字符串
```

**原理**：
- String 对象创建后，其内容不能改变
- 每次"修改"实际上创建了新的 String 对象
- 原对象如果没有引用，会被垃圾回收

```java
String s1 = "Hello";
String s2 = s1;  // s2 和 s1 指向同一个对象
s1 = s1 + " World";  // s1 指向新对象，s2 仍然指向 "Hello"
System.out.println(s1);  // "Hello World"
System.out.println(s2);  // "Hello"
```

### 为什么 String 是不可变的

1. **安全性**：防止意外修改
2. **线程安全**：多个线程可以安全共享
3. **缓存优化**：字符串常量池
4. **哈希码缓存**：hashCode 可以缓存

### 字符串创建方式

#### 1. 字面量方式（推荐）

```java
String str = "Hello";  // 使用字符串常量池
```

#### 2. new 关键字

```java
String str = new String("Hello");  // 创建新对象，不使用常量池
```

#### 3. 字符串常量池

```java
String s1 = "Hello";
String s2 = "Hello";
String s3 = new String("Hello");

System.out.println(s1 == s2);  // true（同一个对象，常量池）
System.out.println(s1 == s3);  // false（不同对象）
System.out.println(s1.equals(s3));  // true（内容相同）
```

**字符串常量池**：
- 相同字面量的字符串共享同一个对象
- 节省内存
- 使用 `==` 比较引用，`equals()` 比较内容

## StringBuilder / StringBuffer 使用

### StringBuilder

**可变字符串**，用于频繁修改字符串的场景。

```java
StringBuilder sb = new StringBuilder();
sb.append("Hello");
sb.append(" ");
sb.append("World");
String result = sb.toString();  // "Hello World"
```

**特点**：
- **可变**：可以修改内容
- **非线程安全**：单线程使用，性能更好
- **高效**：适合频繁修改

### StringBuffer

**可变字符串**，线程安全版本。

```java
StringBuffer sb = new StringBuffer();
sb.append("Hello");
sb.append(" ");
sb.append("World");
String result = sb.toString();  // "Hello World"
```

**特点**：
- **可变**：可以修改内容
- **线程安全**：多线程使用
- **性能较低**：因为同步开销

### StringBuilder vs StringBuffer

| 特性 | StringBuilder | StringBuffer |
|:----:|:------------:|:------------:|
| 线程安全 | 否 | 是 |
| 性能 | 更高 | 较低 |
| 使用场景 | 单线程 | 多线程 |

**选择建议**：
- **单线程**：使用 StringBuilder
- **多线程**：使用 StringBuffer

### 常用方法

#### append：追加

```java
StringBuilder sb = new StringBuilder();
sb.append("Hello");
sb.append(" ");
sb.append("World");
sb.append(123);  // 可以追加各种类型
```

#### insert：插入

```java
StringBuilder sb = new StringBuilder("Hello");
sb.insert(5, " World");  // "Hello World"
```

#### delete：删除

```java
StringBuilder sb = new StringBuilder("Hello World");
sb.delete(5, 11);  // "Hello"（删除索引 5 到 10）
```

#### replace：替换

```java
StringBuilder sb = new StringBuilder("Hello World");
sb.replace(0, 5, "Hi");  // "Hi World"
```

#### reverse：反转

```java
StringBuilder sb = new StringBuilder("Hello");
sb.reverse();  // "olleH"
```

## String 常用方法

String 的常用方法包括 `length()`、`substring()`、`charAt()`、`replace()` 等，下面逐一介绍。

#### 1. 长度和空值检查

```java
String str = "Hello";

// 获取长度
int length = str.length();  // 5

// 检查是否为空
boolean isEmpty = str.isEmpty();  // false
boolean isBlank = str.isBlank();  // false（Java 11+）

// 检查是否为 null 或空
if (str != null && !str.isEmpty()) {
    // 处理字符串
}
```

#### 2. 字符访问

```java
String str = "Hello";

// 获取指定位置的字符
char ch = str.charAt(0);  // 'H'

// 转换为字符数组
char[] chars = str.toCharArray();  // ['H', 'e', 'l', 'l', 'o']
```

#### 3. 子字符串

```java
String str = "Hello World";

// substring：提取子字符串
String sub1 = str.substring(6);      // "World"（从索引 6 到末尾）
String sub2 = str.substring(0, 5);   // "Hello"（从索引 0 到 4）

// 注意：substring 的第二个参数是结束索引（不包含）
```

#### 4. 查找

```java
String str = "Hello World";

// indexOf：查找字符或字符串的位置
int index1 = str.indexOf('o');        // 4（第一个 'o'）
int index2 = str.indexOf('o', 5);     // 7（从索引 5 开始查找）
int index3 = str.indexOf("World");     // 6

// lastIndexOf：从后往前查找
int lastIndex = str.lastIndexOf('o');  // 7

// contains：是否包含
boolean contains = str.contains("World");  // true

// startsWith / endsWith：是否以指定字符串开头/结尾
boolean starts = str.startsWith("Hello");  // true
boolean ends = str.endsWith("World");     // true
```

#### 5. 替换

```java
String str = "Hello World";

// replace：替换字符或字符串
String replaced1 = str.replace('l', 'L');      // "HeLLo WorLd"
String replaced2 = str.replace("World", "Java");  // "Hello Java"

// replaceAll：使用正则表达式替换
String replaced3 = str.replaceAll("\\s", "-");  // "Hello-World"（替换空格）

// replaceFirst：替换第一个匹配
String replaced4 = str.replaceFirst("l", "L");  // "HeLlo World"
```

#### 6. 大小写转换

```java
String str = "Hello World";

// 转大写
String upper = str.toUpperCase();  // "HELLO WORLD"

// 转小写
String lower = str.toLowerCase();  // "hello world"
```

#### 7. 去除空白

```java
String str = "  Hello World  ";

// trim：去除首尾空白
String trimmed = str.trim();  // "Hello World"

// strip：去除首尾空白（Java 11+，支持 Unicode）
String stripped = str.strip();  // "Hello World"

// stripLeading / stripTrailing：去除开头/结尾空白
String leading = str.stripLeading();   // "Hello World  "
String trailing = str.stripTrailing();  // "  Hello World"
```

#### 8. 分割

```java
String str = "apple,banana,orange";

// split：分割字符串
String[] fruits = str.split(",");  // ["apple", "banana", "orange"]

// 限制分割次数
String[] parts = str.split(",", 2);  // ["apple", "banana,orange"]
```

#### 9. 连接

```java
// join：连接字符串数组（Java 8+）
String[] arr = {"apple", "banana", "orange"};
String joined = String.join(", ", arr);  // "apple, banana, orange"
```

#### 10. 比较

```java
String s1 = "Hello";
String s2 = "hello";

// equals：比较内容（区分大小写）
boolean equal1 = s1.equals(s2);  // false

// equalsIgnoreCase：比较内容（不区分大小写）
boolean equal2 = s1.equalsIgnoreCase(s2);  // true

// compareTo：按字典序比较
int result = s1.compareTo(s2);  // 负数（s1 < s2）

// compareToIgnoreCase：不区分大小写比较
int result2 = s1.compareToIgnoreCase(s2);  // 0（相等）
```

## 字符串拼接与效率比较

### 字符串拼接方式

#### 1. 使用 + 运算符

```java
String str = "Hello" + " " + "World";  // "Hello World"
```

**特点**：
- 语法简洁
- 编译器会优化为 StringBuilder
- 适合少量拼接

#### 2. 使用 concat 方法

```java
String str = "Hello".concat(" ").concat("World");  // "Hello World"
```

**特点**：
- 每次调用创建新对象
- 性能较低

#### 3. 使用 StringBuilder

```java
StringBuilder sb = new StringBuilder();
sb.append("Hello");
sb.append(" ");
sb.append("World");
String str = sb.toString();  // "Hello World"
```

**特点**：
- 性能最好
- 适合大量拼接

#### 4. 使用 StringBuffer

```java
StringBuffer sb = new StringBuffer();
sb.append("Hello");
sb.append(" ");
sb.append("World");
String str = sb.toString();  // "Hello World"
```

**特点**：
- 线程安全
- 性能低于 StringBuilder

### 效率比较

```java
// 方式 1：使用 +（少量拼接，编译器优化）
String result = str1 + str2 + str3;  // ✅ 推荐

// 方式 2：使用 +（循环中，性能差）
String result = "";
for (int i = 0; i < 1000; i++) {
    result += i;  // ❌ 每次循环创建新对象
}

// 方式 3：使用 StringBuilder（循环中，性能好）
StringBuilder sb = new StringBuilder();
for (int i = 0; i < 1000; i++) {
    sb.append(i);  // ✅ 推荐
}
String result = sb.toString();
```

**性能测试示例**：

```java
public class StringPerformance {
    public static void main(String[] args) {
        int count = 10000;
        
        // 方式 1：使用 +
        long start1 = System.currentTimeMillis();
        String result1 = "";
        for (int i = 0; i < count; i++) {
            result1 += i;
        }
        long time1 = System.currentTimeMillis() - start1;
        
        // 方式 2：使用 StringBuilder
        long start2 = System.currentTimeMillis();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < count; i++) {
            sb.append(i);
        }
        String result2 = sb.toString();
        long time2 = System.currentTimeMillis() - start2;
        
        System.out.println("使用 + 耗时：" + time1 + "ms");
        System.out.println("使用 StringBuilder 耗时：" + time2 + "ms");
    }
}
```

**结果**：StringBuilder 通常快得多。

### 使用建议

1. **少量拼接**：使用 `+` 运算符
2. **循环中拼接**：使用 `StringBuilder`
3. **多线程环境**：使用 `StringBuffer`
4. **已知大小**：使用 `StringBuilder(int capacity)` 指定初始容量

```java
// 指定初始容量，减少扩容
StringBuilder sb = new StringBuilder(1000);
```

## 实际示例

### 示例 1：字符串操作

```java
public class StringOperations {
    public static void main(String[] args) {
        String str = "  Hello World  ";
        
        // 去除空白
        String trimmed = str.trim();
        System.out.println("去除空白：" + trimmed);
        
        // 转大写
        String upper = trimmed.toUpperCase();
        System.out.println("转大写：" + upper);
        
        // 替换
        String replaced = trimmed.replace("World", "Java");
        System.out.println("替换后：" + replaced);
        
        // 分割
        String[] words = trimmed.split(" ");
        System.out.println("分割后：" + Arrays.toString(words));
    }
}
```

### 示例 2：字符串拼接

```java
public class StringConcatenation {
    public static void main(String[] args) {
        // 少量拼接
        String name = "Java";
        String message = "Hello, " + name + "!";  // ✅ 推荐
        System.out.println(message);
        
        // 大量拼接
        StringBuilder sb = new StringBuilder();
        for (int i = 1; i <= 10; i++) {
            sb.append(i);
            if (i < 10) {
                sb.append(", ");
            }
        }
        System.out.println("数字序列：" + sb.toString());
    }
}
```

### 示例 3：字符串查找和替换

```java
public class StringSearch {
    public static void main(String[] args) {
        String text = "Hello World, Hello Java";
        
        // 查找
        int index = text.indexOf("Hello");
        System.out.println("第一次出现位置：" + index);
        
        int lastIndex = text.lastIndexOf("Hello");
        System.out.println("最后一次出现位置：" + lastIndex);
        
        // 替换所有
        String replaced = text.replace("Hello", "Hi");
        System.out.println("替换后：" + replaced);
        
        // 替换第一个
        String replacedFirst = text.replaceFirst("Hello", "Hi");
        System.out.println("替换第一个：" + replacedFirst);
    }
}
```

## 小结

Java 字符串要点：

- **String 不可变**：创建后不能修改，每次"修改"创建新对象
- **StringBuilder**：可变字符串，单线程使用，性能好
- **StringBuffer**：可变字符串，线程安全，性能较低
- **常用方法**：length、substring、charAt、replace、split 等
- **拼接效率**：少量用 `+`，大量用 `StringBuilder`

**关键要点**：
- String 是不可变的，理解这一点很重要
- 循环中拼接使用 StringBuilder
- 使用 `equals()` 比较内容，不要用 `==`
- 充分利用字符串常量池
- 根据场景选择合适的字符串类

理解了字符串，你就能处理各种文本数据。在下一章，我们将学习 Java 的方法。
