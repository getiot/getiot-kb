---
sidebar_position: 2
slug: /java-api-cheatsheet
sidebar_label: Java 常用 API 速查
---

# Java 常用 API 速查

Java API 是开发的基础。本章提供常用 API 的快速参考。

## java.lang 关键类

### String

```java
String str = "Hello";
str.length();                    // 长度
str.charAt(0);                   // 获取字符
str.substring(1, 3);             // 子字符串
str.indexOf("l");                // 查找
str.replace("l", "L");           // 替换
str.toUpperCase();               // 转大写
str.toLowerCase();               // 转小写
str.trim();                      // 去除空格
str.split(",");                  // 分割
str.equals("Hello");             // 比较
```

### StringBuilder / StringBuffer

```java
StringBuilder sb = new StringBuilder();
sb.append("Hello");              // 追加
sb.insert(5, " World");          // 插入
sb.delete(0, 5);                 // 删除
sb.reverse();                    // 反转
String result = sb.toString();   // 转字符串
```

### Math

```java
Math.abs(-5);                    // 绝对值
Math.max(3, 5);                  // 最大值
Math.min(3, 5);                  // 最小值
Math.sqrt(16);                   // 平方根
Math.pow(2, 3);                  // 幂
Math.round(3.7);                 // 四舍五入
Math.ceil(3.2);                  // 向上取整
Math.floor(3.7);                  // 向下取整
Math.random();                   // 随机数
```

### Object

```java
obj.equals(other);               // 相等比较
obj.hashCode();                  // 哈希码
obj.toString();                  // 字符串表示
obj.getClass();                  // 获取类
```

## java.util 关键类

### Arrays

```java
Arrays.sort(array);              // 排序
Arrays.binarySearch(array, key); // 二分查找
Arrays.fill(array, value);       // 填充
Arrays.copyOf(array, length);    // 复制
Arrays.equals(array1, array2);   // 比较
Arrays.toString(array);          // 转字符串
```

### Collections

```java
Collections.sort(list);          // 排序
Collections.reverse(list);       // 反转
Collections.shuffle(list);       // 打乱
Collections.max(collection);     // 最大值
Collections.min(collection);      // 最小值
Collections.frequency(list, obj); // 频率
```

### Date / Calendar（已过时，推荐使用 java.time）

```java
Date date = new Date();
Calendar cal = Calendar.getInstance();
```

### Random

```java
Random random = new Random();
random.nextInt();                // 随机整数
random.nextInt(100);             // 0-99
random.nextDouble();             // 随机浮点数
```

## java.io 关键类

### File

```java
File file = new File("path");
file.exists();                   // 是否存在
file.isFile();                   // 是否是文件
file.isDirectory();              // 是否是目录
file.getName();                  // 文件名
file.getPath();                  // 路径
file.length();                   // 大小
file.delete();                   // 删除
file.mkdir();                    // 创建目录
```

### FileInputStream / FileOutputStream

```java
// 读取文件
try (FileInputStream fis = new FileInputStream("file.txt")) {
    int data;
    while ((data = fis.read()) != -1) {
        // 处理数据
    }
}

// 写入文件
try (FileOutputStream fos = new FileOutputStream("file.txt")) {
    fos.write(data);
}
```

### BufferedReader / BufferedWriter

```java
// 读取
try (BufferedReader reader = new BufferedReader(
        new FileReader("file.txt"))) {
    String line;
    while ((line = reader.readLine()) != null) {
        // 处理行
    }
}

// 写入
try (BufferedWriter writer = new BufferedWriter(
        new FileWriter("file.txt"))) {
    writer.write("内容");
    writer.newLine();
}
```

## 常用方法与示例

### 字符串操作

```java
// 检查空字符串
if (str != null && !str.isEmpty()) { }

// 字符串拼接
String result = str1 + str2;
String result2 = String.join(", ", list);

// 格式化
String formatted = String.format("姓名：%s，年龄：%d", name, age);
```

### 集合操作

```java
// List 操作
list.add(item);                  // 添加
list.remove(item);               // 删除
list.get(index);                 // 获取
list.size();                     // 大小
list.contains(item);             // 包含

// Map 操作
map.put(key, value);             // 添加
map.get(key);                    // 获取
map.remove(key);                 // 删除
map.containsKey(key);            // 包含键
map.containsValue(value);        // 包含值
map.size();                      // 大小
```

### 日期时间（java.time）

```java
LocalDate date = LocalDate.now();
LocalTime time = LocalTime.now();
LocalDateTime datetime = LocalDateTime.now();

date.plusDays(1);               // 加天数
date.minusDays(1);              // 减天数
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
String formatted = date.format(formatter);
```

## 小结

Java 常用 API 要点：

- **java.lang**：String、StringBuilder、Math、Object
- **java.util**：Arrays、Collections、Random
- **java.io**：File、FileInputStream、BufferedReader
- **java.time**：LocalDate、LocalTime、LocalDateTime

**关键要点**：
- 熟悉常用 API
- 了解方法签名
- 注意异常处理
- 使用 try-with-resources

这是 Java 常用 API 的快速参考，帮助你快速查找和使用 API。
