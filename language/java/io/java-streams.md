---
sidebar_position: 3
slug: /java-streams
sidebar_label: Java 字节流与字符流
---

# Java 字节流与字符流

字节流和字符流是 Java IO 的核心。理解它们的使用是进行文件读写的基础。本章将详细介绍 Java 中的字节流和字符流。

## 输入/输出字节流

### InputStream（字节输入流）

**`InputStream`** 是所有字节输入流的抽象基类。

**核心方法**：

```java
// 读取一个字节
int read() throws IOException;

// 读取到字节数组
int read(byte[] b) throws IOException;
int read(byte[] b, int off, int len) throws IOException;

// 跳过字节
long skip(long n) throws IOException;

// 关闭流
void close() throws IOException;

// 标记和重置（如果支持）
void mark(int readlimit);
void reset();
boolean markSupported();
```

**常用子类**：
- `FileInputStream`：文件输入流
- `ByteArrayInputStream`：字节数组输入流
- `BufferedInputStream`：缓冲输入流
- `DataInputStream`：数据输入流

### OutputStream（字节输出流）

**`OutputStream`** 是所有字节输出流的抽象基类。

**核心方法**：

```java
// 写入一个字节
void write(int b) throws IOException;

// 写入字节数组
void write(byte[] b) throws IOException;
void write(byte[] b, int off, int len) throws IOException;

// 刷新缓冲区
void flush() throws IOException;

// 关闭流
void close() throws IOException;
```

**常用子类**：
- `FileOutputStream`：文件输出流
- `ByteArrayOutputStream`：字节数组输出流
- `BufferedOutputStream`：缓冲输出流
- `DataOutputStream`：数据输出流

## 输入/输出字符流

### Reader（字符输入流）

**`Reader`** 是所有字符输入流的抽象基类。

**核心方法**：

```java
// 读取一个字符
int read() throws IOException;

// 读取到字符数组
int read(char[] cbuf) throws IOException;
int read(char[] cbuf, int off, int len) throws IOException;

// 跳过字符
long skip(long n) throws IOException;

// 关闭流
void close() throws IOException;
```

**常用子类**：
- `FileReader`：文件字符输入流
- `CharArrayReader`：字符数组输入流
- `BufferedReader`：缓冲字符输入流
- `InputStreamReader`：字节流转字符流

### Writer（字符输出流）

**`Writer`** 是所有字符输出流的抽象基类。

**核心方法**：

```java
// 写入一个字符
void write(int c) throws IOException;

// 写入字符数组
void write(char[] cbuf) throws IOException;
void write(char[] cbuf, int off, int len) throws IOException;

// 写入字符串
void write(String str) throws IOException;
void write(String str, int off, int len) throws IOException;

// 追加
Writer append(CharSequence csq) throws IOException;

// 刷新缓冲区
void flush() throws IOException;

// 关闭流
void close() throws IOException;
```

**常用子类**：
- `FileWriter`：文件字符输出流
- `CharArrayWriter`：字符数组输出流
- `BufferedWriter`：缓冲字符输出流
- `OutputStreamWriter`：字符流转字节流

## 常用子类

### FileInputStream

**`FileInputStream`** 用于从文件读取字节。

```java
import java.io.FileInputStream;
import java.io.IOException;

// 读取文件
try (FileInputStream fis = new FileInputStream("file.txt")) {
    int data;
    while ((data = fis.read()) != -1) {
        System.out.print((char) data);
    }
}

// 使用缓冲区读取（推荐）
try (FileInputStream fis = new FileInputStream("file.txt")) {
    byte[] buffer = new byte[1024];
    int length;
    while ((length = fis.read(buffer)) != -1) {
        System.out.write(buffer, 0, length);
    }
}
```

### FileOutputStream

**`FileOutputStream`** 用于向文件写入字节。

```java
import java.io.FileOutputStream;
import java.io.IOException;

// 写入文件
try (FileOutputStream fos = new FileOutputStream("file.txt")) {
    fos.write(65);  // 写入字节 'A'
    fos.write("Hello".getBytes());
}

// 追加模式
try (FileOutputStream fos = new FileOutputStream("file.txt", true)) {
    fos.write(" World".getBytes());
}
```

### FileReader

**`FileReader`** 用于从文件读取字符。

```java
import java.io.FileReader;
import java.io.IOException;

// 读取文件
try (FileReader fr = new FileReader("file.txt")) {
    int data;
    while ((data = fr.read()) != -1) {
        System.out.print((char) data);
    }
}

// 使用缓冲区读取（推荐）
try (FileReader fr = new FileReader("file.txt")) {
    char[] buffer = new char[1024];
    int length;
    while ((length = fr.read(buffer)) != -1) {
        System.out.print(new String(buffer, 0, length));
    }
}
```

### FileWriter

**`FileWriter`** 用于向文件写入字符。

```java
import java.io.FileWriter;
import java.io.IOException;

// 写入文件
try (FileWriter fw = new FileWriter("file.txt")) {
    fw.write("Hello");
    fw.write(" World");
    fw.flush();  // 刷新缓冲区
}

// 追加模式
try (FileWriter fw = new FileWriter("file.txt", true)) {
    fw.write(" Appended");
}
```

## 示例：文本文件读写

### 示例 1：使用字节流读写文本

```java
import java.io.*;

public class ByteStreamExample {
    // 写入文本文件
    public static void writeTextFile(String filename, String content) throws IOException {
        try (FileOutputStream fos = new FileOutputStream(filename)) {
            fos.write(content.getBytes("UTF-8"));
        }
    }
    
    // 读取文本文件
    public static String readTextFile(String filename) throws IOException {
        try (FileInputStream fis = new FileInputStream(filename)) {
            byte[] buffer = new byte[1024];
            StringBuilder sb = new StringBuilder();
            int length;
            while ((length = fis.read(buffer)) != -1) {
                sb.append(new String(buffer, 0, length, "UTF-8"));
            }
            return sb.toString();
        }
    }
    
    public static void main(String[] args) throws IOException {
        writeTextFile("test.txt", "Hello, 世界！");
        String content = readTextFile("test.txt");
        System.out.println(content);
    }
}
```

### 示例 2：使用字符流读写文本（推荐）

```java
import java.io.*;

public class CharStreamExample {
    // 写入文本文件
    public static void writeTextFile(String filename, String content) throws IOException {
        try (FileWriter fw = new FileWriter(filename)) {
            fw.write(content);
        }
    }
    
    // 读取文本文件
    public static String readTextFile(String filename) throws IOException {
        try (FileReader fr = new FileReader(filename)) {
            char[] buffer = new char[1024];
            StringBuilder sb = new StringBuilder();
            int length;
            while ((length = fr.read(buffer)) != -1) {
                sb.append(buffer, 0, length);
            }
            return sb.toString();
        }
    }
    
    public static void main(String[] args) throws IOException {
        writeTextFile("test.txt", "Hello, 世界！");
        String content = readTextFile("test.txt");
        System.out.println(content);
    }
}
```

### 示例 3：按行读取文件

```java
import java.io.*;

public class LineReaderExample {
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
    
    // 使用 Files.readAllLines（Java 7+）
    public static void readLinesNew(String filename) throws IOException {
        List<String> lines = Files.readAllLines(Paths.get(filename));
        for (int i = 0; i < lines.size(); i++) {
            System.out.println((i + 1) + ": " + lines.get(i));
        }
    }
}
```

### 示例 4：复制文件

```java
import java.io.*;

public class FileCopyExample {
    // 使用字节流复制（适合任何文件）
    public static void copyFileByteStream(String source, String dest) throws IOException {
        try (FileInputStream fis = new FileInputStream(source);
             FileOutputStream fos = new FileOutputStream(dest)) {
            byte[] buffer = new byte[8192];  // 8KB 缓冲区
            int length;
            while ((length = fis.read(buffer)) != -1) {
                fos.write(buffer, 0, length);
            }
        }
    }
    
    // 使用字符流复制（只适合文本文件）
    public static void copyFileCharStream(String source, String dest) throws IOException {
        try (FileReader fr = new FileReader(source);
             FileWriter fw = new FileWriter(dest)) {
            char[] buffer = new char[8192];
            int length;
            while ((length = fr.read(buffer)) != -1) {
                fw.write(buffer, 0, length);
            }
        }
    }
    
    public static void main(String[] args) throws IOException {
        // 复制二进制文件使用字节流
        copyFileByteStream("image.jpg", "copy.jpg");
        
        // 复制文本文件可以使用字符流
        copyFileCharStream("text.txt", "copy.txt");
    }
}
```

### 示例 5：处理编码

```java
import java.io.*;

public class EncodingExample {
    // 指定编码读取
    public static String readWithEncoding(String filename, String encoding) throws IOException {
        try (FileInputStream fis = new FileInputStream(filename);
             InputStreamReader isr = new InputStreamReader(fis, encoding);
             BufferedReader br = new BufferedReader(isr)) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line).append("\n");
            }
            return sb.toString();
        }
    }
    
    // 指定编码写入
    public static void writeWithEncoding(String filename, String content, String encoding) throws IOException {
        try (FileOutputStream fos = new FileOutputStream(filename);
             OutputStreamWriter osw = new OutputStreamWriter(fos, encoding);
             BufferedWriter bw = new BufferedWriter(osw)) {
            bw.write(content);
        }
    }
    
    public static void main(String[] args) throws IOException {
        // 使用 UTF-8 编码
        writeWithEncoding("test.txt", "Hello, 世界！", "UTF-8");
        String content = readWithEncoding("test.txt", "UTF-8");
        System.out.println(content);
    }
}
```

## try-with-resources

**使用 try-with-resources 自动关闭流**（Java 7+）：

```java
// ✅ 推荐：自动关闭
try (FileInputStream fis = new FileInputStream("file.txt")) {
    // 使用流
}  // 自动关闭

// ❌ 不推荐：手动关闭
FileInputStream fis = null;
try {
    fis = new FileInputStream("file.txt");
    // 使用流
} finally {
    if (fis != null) {
        fis.close();
    }
}
```

## 流的最佳实践

### 1. 使用缓冲区

```java
// ✅ 推荐：使用缓冲区
try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream("file.txt"))) {
    // 性能更好
}

// ❌ 不推荐：不使用缓冲区
// try (FileInputStream fis = new FileInputStream("file.txt")) {
//     // 性能较差
// }
```

### 2. 使用 try-with-resources

```java
// ✅ 推荐：自动关闭
try (FileReader fr = new FileReader("file.txt")) {
    // 使用流
}
```

### 3. 选择合适的流类型

```java
// 文本文件：使用字符流
FileReader fr = new FileReader("text.txt");

// 二进制文件：使用字节流
FileInputStream fis = new FileInputStream("image.jpg");
```

### 4. 处理异常

```java
try (FileInputStream fis = new FileInputStream("file.txt")) {
    // 使用流
} catch (FileNotFoundException e) {
    System.err.println("文件未找到：" + e.getMessage());
} catch (IOException e) {
    System.err.println("IO 错误：" + e.getMessage());
}
```

## 小结

Java 字节流与字符流要点：

- **InputStream/OutputStream**：字节流，处理二进制数据
- **Reader/Writer**：字符流，处理文本数据
- **FileInputStream/FileOutputStream**：文件字节流
- **FileReader/FileWriter**：文件字符流
- **使用建议**：文本用字符流，二进制用字节流

**关键要点**：
- 字节流以字节为单位，字符流以字符为单位
- 文本文件使用字符流，二进制文件使用字节流
- 使用缓冲区提高性能
- 使用 try-with-resources 自动关闭流
- 注意字符编码问题

理解了字节流和字符流，你就能进行基本的文件读写操作。在下一章，我们将学习 Java 的缓冲流与对象流。
