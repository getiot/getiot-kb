---
sidebar_position: 4
slug: /java-buffered-object-stream
sidebar_label: Java 缓冲流与对象流
---

# Java 缓冲流与对象流

缓冲流提供了缓冲功能，提高 IO 性能；对象流支持对象的序列化和反序列化。理解这些高级流的使用是进行高效 IO 操作的基础。本章将详细介绍 Java 中的缓冲流和对象流。

## 缓冲流

**缓冲流**（Buffered Stream）是处理流，包装其他流，提供缓冲功能，减少实际 IO 操作次数，提高性能。

### BufferedInputStream

**`BufferedInputStream`** 为字节输入流提供缓冲。

```java
import java.io.*;

// 包装 FileInputStream
try (FileInputStream fis = new FileInputStream("file.txt");
     BufferedInputStream bis = new BufferedInputStream(fis)) {
    byte[] buffer = new byte[1024];
    int length;
    while ((length = bis.read(buffer)) != -1) {
        System.out.write(buffer, 0, length);
    }
}
```

**优势**：
- 减少系统调用次数
- 提高读取性能
- 默认缓冲区大小：8192 字节

### BufferedOutputStream

**`BufferedOutputStream`** 为字节输出流提供缓冲。

```java
try (FileOutputStream fos = new FileOutputStream("file.txt");
     BufferedOutputStream bos = new BufferedOutputStream(fos)) {
    bos.write("Hello".getBytes());
    bos.flush();  // 刷新缓冲区
}
```

**注意**：写入后需要调用 `flush()` 确保数据写入，或关闭流时自动刷新。

### BufferedReader

**`BufferedReader`** 为字符输入流提供缓冲，支持按行读取。

```java
try (FileReader fr = new FileReader("file.txt");
     BufferedReader br = new BufferedReader(fr)) {
    String line;
    while ((line = br.readLine()) != null) {  // 按行读取
        System.out.println(line);
    }
}
```

**优势**：
- 支持按行读取（`readLine()`）
- 提高读取性能
- 默认缓冲区大小：8192 字符

### BufferedWriter

**`BufferedWriter`** 为字符输出流提供缓冲。

```java
try (FileWriter fw = new FileWriter("file.txt");
     BufferedWriter bw = new BufferedWriter(fw)) {
    bw.write("Hello");
    bw.newLine();  // 写入换行符
    bw.write("World");
    bw.flush();  // 刷新缓冲区
}
```

**常用方法**：
- `write(String str)`：写入字符串
- `newLine()`：写入换行符（跨平台）
- `flush()`：刷新缓冲区

## 对象流

**对象流**（Object Stream）用于序列化和反序列化对象，实现对象的持久化存储。

**序列化**（Serialization）是将对象转换为字节序列的过程。

**要求**：

- 对象必须实现 `Serializable` 接口
- 所有字段必须是可序列化的（基本类型或实现 Serializable）

```java
import java.io.Serializable;

public class Student implements Serializable {
    private static final long serialVersionUID = 1L;  // 版本号
    
    private String name;
    private int age;
    private transient String password;  // transient：不序列化
    
    public Student(String name, int age, String password) {
        this.name = name;
        this.age = age;
        this.password = password;
    }
    
    // Getter 方法
    public String getName() { return name; }
    public int getAge() { return age; }
    public String getPassword() { return password; }
}
```

### ObjectOutputStream

**`ObjectOutputStream`** 用于将对象写入流。

```java
import java.io.*;

try (FileOutputStream fos = new FileOutputStream("student.dat");
     ObjectOutputStream oos = new ObjectOutputStream(fos)) {
    Student student = new Student("张三", 20, "123456");
    oos.writeObject(student);
}
```

### ObjectInputStream

**`ObjectInputStream`** 用于从流中读取对象。

```java
try (FileInputStream fis = new FileInputStream("student.dat");
     ObjectInputStream ois = new ObjectInputStream(fis)) {
    Student student = (Student) ois.readObject();
    System.out.println("姓名：" + student.getName());
    System.out.println("年龄：" + student.getAge());
}
```

## 对象序列化与反序列化

### 序列化过程

```java
// 序列化对象
public static void serializeObject(Object obj, String filename) throws IOException {
    try (FileOutputStream fos = new FileOutputStream(filename);
         ObjectOutputStream oos = new ObjectOutputStream(fos)) {
        oos.writeObject(obj);
    }
}
```

### 反序列化过程

```java
// 反序列化对象
public static Object deserializeObject(String filename) throws IOException, ClassNotFoundException {
    try (FileInputStream fis = new FileInputStream(filename);
         ObjectInputStream ois = new ObjectInputStream(fis)) {
        return ois.readObject();
    }
}
```

### serialVersionUID

**`serialVersionUID`** 用于版本控制，确保序列化和反序列化的类版本一致。

```java
public class Student implements Serializable {
    private static final long serialVersionUID = 1L;  // 版本号
    
    // 如果类结构改变，应该更新版本号
    // private static final long serialVersionUID = 2L;
}
```

**作用**：
- 版本兼容性检查
- 防止类结构不匹配导致的错误
- 建议显式声明

### transient 关键字

**`transient`** 用于标记不需要序列化的字段。

```java
public class User implements Serializable {
    private String username;
    private transient String password;  // 不序列化密码
    
    // password 字段不会被序列化
}
```

## 示例：对象存储与恢复

### 示例 1：基本对象序列化

```java
import java.io.*;

public class ObjectSerialization {
    public static void main(String[] args) throws IOException, ClassNotFoundException {
        // 创建对象
        Student student = new Student("张三", 20, "123456");
        
        // 序列化
        try (FileOutputStream fos = new FileOutputStream("student.dat");
             ObjectOutputStream oos = new ObjectOutputStream(fos)) {
            oos.writeObject(student);
            System.out.println("对象已序列化");
        }
        
        // 反序列化
        try (FileInputStream fis = new FileInputStream("student.dat");
             ObjectInputStream ois = new ObjectInputStream(fis)) {
            Student restored = (Student) ois.readObject();
            System.out.println("姓名：" + restored.getName());
            System.out.println("年龄：" + restored.getAge());
            System.out.println("密码：" + restored.getPassword());  // null（transient）
        }
    }
}
```

### 示例 2：序列化多个对象

```java
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class MultipleObjectsSerialization {
    public static void main(String[] args) throws IOException, ClassNotFoundException {
        // 创建对象列表
        List<Student> students = new ArrayList<>();
        students.add(new Student("张三", 20, "pwd1"));
        students.add(new Student("李四", 22, "pwd2"));
        students.add(new Student("王五", 21, "pwd3"));
        
        // 序列化列表
        try (FileOutputStream fos = new FileOutputStream("students.dat");
             ObjectOutputStream oos = new ObjectOutputStream(fos)) {
            oos.writeObject(students);
        }
        
        // 反序列化列表
        try (FileInputStream fis = new FileInputStream("students.dat");
             ObjectInputStream ois = new ObjectInputStream(fis)) {
            @SuppressWarnings("unchecked")
            List<Student> restored = (List<Student>) ois.readObject();
            restored.forEach(s -> System.out.println(s.getName() + ": " + s.getAge()));
        }
    }
}
```

### 示例 3：自定义序列化

```java
import java.io.*;

public class CustomSerialization implements Serializable {
    private static final long serialVersionUID = 1L;
    private String name;
    private transient String sensitiveData;
    
    // 自定义序列化
    private void writeObject(ObjectOutputStream oos) throws IOException {
        oos.defaultWriteObject();  // 默认序列化
        oos.writeObject(encrypt(sensitiveData));  // 加密后序列化
    }
    
    // 自定义反序列化
    private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException {
        ois.defaultReadObject();  // 默认反序列化
        String encrypted = (String) ois.readObject();
        this.sensitiveData = decrypt(encrypted);  // 解密
    }
    
    private String encrypt(String data) {
        // 加密逻辑
        return "encrypted_" + data;
    }
    
    private String decrypt(String data) {
        // 解密逻辑
        return data.replace("encrypted_", "");
    }
}
```

### 示例 4：缓冲流的使用

```java
import java.io.*;

public class BufferedStreamExample {
    // 使用缓冲流复制文件
    public static void copyFileBuffered(String source, String dest) throws IOException {
        try (FileInputStream fis = new FileInputStream(source);
             BufferedInputStream bis = new BufferedInputStream(fis);
             FileOutputStream fos = new FileOutputStream(dest);
             BufferedOutputStream bos = new BufferedOutputStream(fos)) {
            byte[] buffer = new byte[8192];
            int length;
            while ((length = bis.read(buffer)) != -1) {
                bos.write(buffer, 0, length);
            }
        }
    }
    
    // 使用 BufferedReader 按行读取
    public static void readLines(String filename) throws IOException {
        try (FileReader fr = new FileReader(filename);
             BufferedReader br = new BufferedReader(fr)) {
            String line;
            int lineNumber = 1;
            while ((line = br.readLine()) != null) {
                System.out.println(lineNumber + ": " + line);
                lineNumber++;
            }
        }
    }
    
    // 使用 BufferedWriter 写入
    public static void writeLines(String filename, List<String> lines) throws IOException {
        try (FileWriter fw = new FileWriter(filename);
             BufferedWriter bw = new BufferedWriter(fw)) {
            for (String line : lines) {
                bw.write(line);
                bw.newLine();
            }
        }
    }
}
```

### 示例 5：性能对比

```java
import java.io.*;

public class PerformanceComparison {
    public static void main(String[] args) throws IOException {
        String filename = "largefile.txt";
        
        // 不使用缓冲
        long start1 = System.currentTimeMillis();
        copyWithoutBuffer(filename, "copy1.txt");
        long time1 = System.currentTimeMillis() - start1;
        
        // 使用缓冲
        long start2 = System.currentTimeMillis();
        copyWithBuffer(filename, "copy2.txt");
        long time2 = System.currentTimeMillis() - start2;
        
        System.out.println("不使用缓冲：" + time1 + "ms");
        System.out.println("使用缓冲：" + time2 + "ms");
    }
    
    private static void copyWithoutBuffer(String source, String dest) throws IOException {
        try (FileInputStream fis = new FileInputStream(source);
             FileOutputStream fos = new FileOutputStream(dest)) {
            int data;
            while ((data = fis.read()) != -1) {
                fos.write(data);
            }
        }
    }
    
    private static void copyWithBuffer(String source, String dest) throws IOException {
        try (FileInputStream fis = new FileInputStream(source);
             BufferedInputStream bis = new BufferedInputStream(fis);
             FileOutputStream fos = new FileOutputStream(dest);
             BufferedOutputStream bos = new BufferedOutputStream(fos)) {
            byte[] buffer = new byte[8192];
            int length;
            while ((length = bis.read(buffer)) != -1) {
                bos.write(buffer, 0, length);
            }
        }
    }
}
```

## 序列化的注意事项

### 1. 必须实现 Serializable

```java
// ✅ 正确
public class Student implements Serializable { }

// ❌ 错误：不能序列化
// public class Student { }
```

### 2. 所有字段必须可序列化

```java
public class Student implements Serializable {
    private String name;  // ✅ 可序列化
    private int age;      // ✅ 可序列化
    // private Thread thread;  // ❌ 错误：Thread 不可序列化
}
```

### 3. 使用 transient 排除字段

```java
public class User implements Serializable {
    private String username;
    private transient String password;  // 不序列化
}
```

### 4. 注意版本兼容性

```java
// 如果类结构改变，更新 serialVersionUID
private static final long serialVersionUID = 2L;
```

## 小结

Java 缓冲流与对象流要点：

- **缓冲流**：提供缓冲功能，提高 IO 性能
- **BufferedReader / BufferedWriter**：字符缓冲流，支持按行读写
- **BufferedInputStream / BufferedOutputStream**：字节缓冲流
- **对象流**：支持对象序列化和反序列化
- **序列化要求**：实现 Serializable 接口

**关键要点**：
- 使用缓冲流提高性能
- BufferedReader 支持按行读取
- 对象必须实现 Serializable 才能序列化
- 使用 transient 排除不需要序列化的字段
- 注意 serialVersionUID 的版本控制

理解了缓冲流和对象流，你就能进行高效的 IO 操作和对象持久化。在下一章，我们将学习 Java 的 NIO。
