---
sidebar_position: 5
slug: /java-regex
sidebar_label: 正则表达式
---

# 正则表达式（Regex）

正则表达式是用于匹配、查找和替换文本的强大工具。Java 提供了 `Pattern` 和 `Matcher` 类来处理正则表达式。理解正则表达式的使用是进行文本处理的基础。本章将详细介绍 Java 中的正则表达式。

## Pattern 与 Matcher 类

### Pattern 类

**`Pattern` 类**用于编译正则表达式。

```java
import java.util.regex.Pattern;

// 编译正则表达式
Pattern pattern = Pattern.compile("\\d+");  // 匹配一个或多个数字

// 检查是否匹配
boolean matches = Pattern.matches("\\d+", "123");  // true
```

### Matcher 类

**`Matcher` 类**用于执行匹配操作。

```java
import java.util.regex.Pattern;
import java.util.regex.Matcher;

Pattern pattern = Pattern.compile("\\d+");
Matcher matcher = pattern.matcher("123 abc 456");

// 查找匹配
while (matcher.find()) {
    System.out.println("找到：" + matcher.group());  // 123, 456
    System.out.println("位置：" + matcher.start() + "-" + matcher.end());
}
```

### 常用方法

```java
Pattern pattern = Pattern.compile("\\d+");
Matcher matcher = pattern.matcher("123 abc 456");

// matches：完全匹配
boolean matches = matcher.matches();  // false（不是完全匹配）

// find：查找下一个匹配
boolean found = matcher.find();  // true

// group：获取匹配的文本
String group = matcher.group();  // "123"

// start/end：获取匹配的位置
int start = matcher.start();  // 0
int end = matcher.end();      // 3

// replaceAll：替换所有匹配
String replaced = matcher.replaceAll("X");  // "X abc X"

// replaceFirst：替换第一个匹配
String replaced2 = matcher.replaceFirst("X");  // "X abc 456"
```

## 常用正则符号与表达式

### 字符类

| 符号 | 含义 | 示例 |
|:----:|:----:|:----:|
| `.` | 任意字符（除换行符） | `a.c` 匹配 "abc" |
| `\d` | 数字 [0-9] | `\d+` 匹配 "123" |
| `\D` | 非数字 | `\D+` 匹配 "abc" |
| `\w` | 单词字符 [a-zA-Z0-9_] | `\w+` 匹配 "hello123" |
| `\W` | 非单词字符 | `\W+` 匹配 "!@#" |
| `\s` | 空白字符 | `\s+` 匹配空格、制表符等 |
| `\S` | 非空白字符 | `\S+` 匹配非空白字符 |
| `[abc]` | 字符类：a、b 或 c | `[abc]` 匹配 "a"、"b" 或 "c" |
| `[^abc]` | 否定字符类：非 a、b、c | `[^abc]` 匹配除 a、b、c 外的字符 |
| `[a-z]` | 字符范围：a 到 z | `[a-z]+` 匹配小写字母 |
| `[0-9]` | 数字范围：0 到 9 | `[0-9]+` 匹配数字 |

### 量词

| 符号 | 含义 | 示例 |
|:----:|:----:|:----:|
| `*` | 0 次或多次 | `a*` 匹配 ""、"a"、"aa" |
| `+` | 1 次或多次 | `a+` 匹配 "a"、"aa" |
| `?` | 0 次或 1 次 | `a?` 匹配 ""、"a" |
| `{n}` | 恰好 n 次 | `a{3}` 匹配 "aaa" |
| `{n,}` | 至少 n 次 | `a{3,}` 匹配 "aaa"、"aaaa" |
| `{n,m}` | n 到 m 次 | `a{2,4}` 匹配 "aa"、"aaa"、"aaaa" |

### 位置锚点

| 符号 | 含义 | 示例 |
|:----:|:----:|:----:|
| `^` | 行首 | `^abc` 匹配行首的 "abc" |
| `$` | 行尾 | `abc$` 匹配行尾的 "abc" |
| `\b` | 单词边界 | `\bword\b` 匹配独立的 "word" |

### 分组和引用

| 符号 | 含义 | 示例 |
|:----:|:----:|:----:|
| `()` | 分组 | `(ab)+` 匹配 "ab"、"abab" |
| `\|` | 或 | `a\|b` 匹配 "a" 或 "b" |
| `\1` | 引用第一个分组 | `(.)\1` 匹配 "aa"、"bb" |

### 转义字符

**在 Java 字符串中，反斜杠需要转义**：

```java
// 匹配一个数字
Pattern pattern1 = Pattern.compile("\\d");  // 字符串中是 "\\d"，实际是 "\d"

// 匹配点号
Pattern pattern2 = Pattern.compile("\\.");  // 匹配 "." 字符

// 匹配反斜杠
Pattern pattern3 = Pattern.compile("\\\\");  // 匹配 "\" 字符
```

## 字符串匹配、查找、替换

### 匹配

**使用 `matches()` 检查字符串是否完全匹配**：

```java
String regex = "\\d{4}-\\d{2}-\\d{2}";  // 日期格式：YYYY-MM-DD
String date = "2024-01-15";

boolean matches = date.matches(regex);  // true
```

### 查找

**使用 `find()` 查找匹配的子串**：

```java
Pattern pattern = Pattern.compile("\\d+");
Matcher matcher = pattern.matcher("价格是 100 元，数量是 5 个");

while (matcher.find()) {
    System.out.println("找到数字：" + matcher.group());
    System.out.println("位置：" + matcher.start() + "-" + matcher.end());
}
// 输出：
// 找到数字：100
// 位置：3-6
// 找到数字：5
// 位置：11-12
```

### 替换

**使用 `replaceAll()` 和 `replaceFirst()` 替换**：

```java
String text = "价格是 100 元，数量是 5 个";

// 替换所有数字为 "X"
String replaced1 = text.replaceAll("\\d+", "X");  // "价格是 X 元，数量是 X 个"

// 替换第一个数字为 "X"
String replaced2 = text.replaceFirst("\\d+", "X");  // "价格是 X 元，数量是 5 个"

// 使用 Matcher
Pattern pattern = Pattern.compile("\\d+");
Matcher matcher = pattern.matcher(text);
String replaced3 = matcher.replaceAll("X");
```

### 分组替换

**使用分组进行替换**：

```java
String text = "2024-01-15";

// 交换年月日顺序
String replaced = text.replaceAll("(\\d{4})-(\\d{2})-(\\d{2})", "$3/$2/$1");
// "15/01/2024"

// 使用命名分组（Java 7+）
Pattern pattern = Pattern.compile("(?<year>\\d{4})-(?<month>\\d{2})-(?<day>\\d{2})");
Matcher matcher = pattern.matcher(text);
if (matcher.matches()) {
    String year = matcher.group("year");   // "2024"
    String month = matcher.group("month"); // "01"
    String day = matcher.group("day");     // "15"
}
```

## 示例：邮箱验证、手机号匹配

### 示例 1：邮箱验证

```java
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class EmailValidator {
    // 邮箱正则表达式
    private static final String EMAIL_PATTERN = 
        "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
    
    private static final Pattern pattern = Pattern.compile(EMAIL_PATTERN);
    
    public static boolean isValidEmail(String email) {
        if (email == null) {
            return false;
        }
        return pattern.matcher(email).matches();
    }
    
    public static void main(String[] args) {
        String[] emails = {
            "user@example.com",
            "test.email@example.co.uk",
            "invalid.email",
            "@example.com",
            "user@.com"
        };
        
        for (String email : emails) {
            System.out.println(email + " : " + isValidEmail(email));
        }
    }
}
```

### 示例 2：手机号匹配

```java
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class PhoneValidator {
    // 中国手机号正则表达式
    private static final String PHONE_PATTERN = "^1[3-9]\\d{9}$";
    
    private static final Pattern pattern = Pattern.compile(PHONE_PATTERN);
    
    public static boolean isValidPhone(String phone) {
        if (phone == null) {
            return false;
        }
        return pattern.matcher(phone).matches();
    }
    
    public static void main(String[] args) {
        String[] phones = {
            "13812345678",
            "15912345678",
            "12345678901",
            "1381234567",
            "23812345678"
        };
        
        for (String phone : phones) {
            System.out.println(phone + " : " + isValidPhone(phone));
        }
    }
}
```

### 示例 3：提取信息

```java
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.ArrayList;
import java.util.List;

public class TextExtractor {
    public static List<String> extractEmails(String text) {
        List<String> emails = new ArrayList<>();
        Pattern pattern = Pattern.compile("\\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}\\b");
        Matcher matcher = pattern.matcher(text);
        
        while (matcher.find()) {
            emails.add(matcher.group());
        }
        
        return emails;
    }
    
    public static List<String> extractPhoneNumbers(String text) {
        List<String> phones = new ArrayList<>();
        Pattern pattern = Pattern.compile("1[3-9]\\d{9}");
        Matcher matcher = pattern.matcher(text);
        
        while (matcher.find()) {
            phones.add(matcher.group());
        }
        
        return phones;
    }
    
    public static void main(String[] args) {
        String text = "联系我：邮箱是 user@example.com，电话是 13812345678，或者发邮件到 admin@test.com";
        
        List<String> emails = extractEmails(text);
        System.out.println("邮箱：" + emails);
        
        List<String> phones = extractPhoneNumbers(text);
        System.out.println("手机号：" + phones);
    }
}
```

### 示例 4：文本处理

```java
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class TextProcessor {
    // 移除多余空格
    public static String removeExtraSpaces(String text) {
        return text.replaceAll("\\s+", " ").trim();
    }
    
    // 提取数字
    public static List<Integer> extractNumbers(String text) {
        List<Integer> numbers = new ArrayList<>();
        Pattern pattern = Pattern.compile("\\d+");
        Matcher matcher = pattern.matcher(text);
        
        while (matcher.find()) {
            numbers.add(Integer.parseInt(matcher.group()));
        }
        
        return numbers;
    }
    
    // 验证密码强度（至少8位，包含大小写字母和数字）
    public static boolean isStrongPassword(String password) {
        String pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$";
        return password.matches(pattern);
    }
    
    // 格式化日期
    public static String formatDate(String date) {
        // 将 YYYYMMDD 格式化为 YYYY-MM-DD
        return date.replaceAll("(\\d{4})(\\d{2})(\\d{2})", "$1-$2-$3");
    }
    
    public static void main(String[] args) {
        String text = "价格是   100   元，数量是  5   个";
        System.out.println("移除多余空格：" + removeExtraSpaces(text));
        
        List<Integer> numbers = extractNumbers(text);
        System.out.println("提取数字：" + numbers);
        
        System.out.println("密码强度：" + isStrongPassword("Password123"));
        
        String date = "20240115";
        System.out.println("格式化日期：" + formatDate(date));
    }
}
```

### 示例 5：常用正则表达式

```java
public class CommonRegex {
    // 常用正则表达式模式
    public static final String EMAIL = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
    public static final String PHONE_CN = "^1[3-9]\\d{9}$";
    public static final String ID_CARD = "^[1-9]\\d{5}(18|19|20)\\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\\d|3[01])\\d{3}[0-9Xx]$";
    public static final String URL = "^(https?://)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([/\\w \\.-]*)*/?$";
    public static final String IP = "^((25[0-5]|2[0-4]\\d|[01]?\\d\\d?)\\.){3}(25[0-5]|2[0-4]\\d|[01]?\\d\\d?)$";
    public static final String DATE_YYYY_MM_DD = "^\\d{4}-\\d{2}-\\d{2}$";
    public static final String TIME_HH_MM_SS = "^\\d{2}:\\d{2}:\\d{2}$";
    
    public static boolean validate(String text, String pattern) {
        return Pattern.matches(pattern, text);
    }
    
    public static void main(String[] args) {
        System.out.println("邮箱验证：" + validate("user@example.com", EMAIL));
        System.out.println("手机号验证：" + validate("13812345678", PHONE_CN));
        System.out.println("URL 验证：" + validate("https://www.example.com", URL));
        System.out.println("IP 验证：" + validate("192.168.1.1", IP));
        System.out.println("日期验证：" + validate("2024-01-15", DATE_YYYY_MM_DD));
    }
}
```

## 正则表达式最佳实践

### 1. 预编译 Pattern

```java
// ✅ 推荐：预编译 Pattern（性能更好）
private static final Pattern PATTERN = Pattern.compile("\\d+");

// ❌ 不推荐：每次编译（性能差）
// Pattern pattern = Pattern.compile("\\d+");
```

### 2. 使用合适的量词

```java
// ✅ 推荐：使用非贪婪量词（需要时）
Pattern pattern = Pattern.compile("<.*?>");  // 非贪婪匹配

// ❌ 不推荐：贪婪匹配可能导致问题
// Pattern pattern = Pattern.compile("<.*>");  // 贪婪匹配
```

### 3. 转义特殊字符

```java
// ✅ 正确：转义特殊字符
Pattern pattern = Pattern.compile("\\.");  // 匹配点号

// ❌ 错误：未转义
// Pattern pattern = Pattern.compile(".");  // 匹配任意字符
```

### 4. 使用分组提高可读性

```java
// ✅ 推荐：使用分组
Pattern pattern = Pattern.compile("(\\d{4})-(\\d{2})-(\\d{2})");

// ❌ 不推荐：不使用分组
// Pattern pattern = Pattern.compile("\\d{4}-\\d{2}-\\d{2}");
```

## 小结

Java 正则表达式要点：

- **Pattern**：编译正则表达式
- **Matcher**：执行匹配操作
- **常用符号**：字符类、量词、位置锚点、分组
- **字符串方法**：matches、replaceAll、replaceFirst
- **应用场景**：验证、提取、替换文本

**关键要点**：
- 在 Java 字符串中反斜杠需要转义
- 预编译 Pattern 提高性能
- 使用分组提高可读性和功能
- 注意贪婪和非贪婪匹配
- 常用正则表达式可以复用

理解了正则表达式，你就能高效地处理文本数据。恭喜你完成了第四部分的学习！
