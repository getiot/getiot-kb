---
sidebar_position: 1
slug: /java-io-overview
sidebar_label: Java IO 模型概览
---

# Java IO 模型概览

IO（Input/Output，输入输出）是程序与外部世界交互的重要方式。理解 Java 的 IO 模型是进行文件操作、网络通信等开发的基础。本章将详细介绍 Java 的 IO 体系结构。

## 阻塞 IO 与非阻塞 IO

### 阻塞 IO（BIO）

**阻塞 IO**（Blocking IO）是传统的 IO 模型，当程序执行 IO 操作时，线程会被阻塞，直到操作完成。

**特点**：
- **同步阻塞**：线程等待 IO 操作完成
- **简单易用**：API 简单，易于理解
- **资源消耗**：每个连接需要一个线程
- **适用场景**：连接数较少的场景

```java
// 阻塞 IO 示例
try (FileInputStream fis = new FileInputStream("file.txt")) {
    int data;
    while ((data = fis.read()) != -1) {  // 阻塞，直到读取到数据
        System.out.print((char) data);
    }
}
```

### 非阻塞 IO（NIO）

**非阻塞 IO**（Non-blocking IO）是 Java 4 引入的 IO 模型，线程不会被阻塞。

**特点**：

- **非阻塞**：线程可以继续执行其他操作
- **高效**：一个线程可以处理多个连接
- **复杂**：API 相对复杂
- **适用场景**：高并发、大量连接的场景

```java
// NIO 示例
FileChannel channel = FileChannel.open(Paths.get("file.txt"), StandardOpenOption.READ);
ByteBuffer buffer = ByteBuffer.allocate(1024);
int bytesRead = channel.read(buffer);  // 非阻塞
```

### 异步 IO（AIO）

**异步 IO**（Asynchronous IO）是 Java 7 引入的异步 IO 模型。

**特点**：
- **完全异步**：IO 操作在后台执行
- **回调机制**：通过回调处理结果
- **高性能**：适合高并发场景
- **使用较少**：实际应用中使用较少

## 输入流 / 输出流概念

### 流的概念

**流**（Stream）是数据在程序和外部之间的流动通道。

**特点**：
- **单向**：流是单向的，要么输入，要么输出
- **顺序**：数据按顺序流动
- **抽象**：隐藏底层实现细节

### 输入流（InputStream / Reader）

**输入流**用于从外部读取数据到程序。

```java
// 字节输入流
InputStream is = new FileInputStream("file.txt");
int data = is.read();  // 读取一个字节

// 字符输入流
Reader reader = new FileReader("file.txt");
int data = reader.read();  // 读取一个字符
```

### 输出流（OutputStream / Writer）

**输出流**用于从程序写入数据到外部。

```java
// 字节输出流
OutputStream os = new FileOutputStream("file.txt");
os.write(65);  // 写入一个字节

// 字符输出流
Writer writer = new FileWriter("file.txt");
writer.write("Hello");  // 写入字符串
```

### 流的分类

```
IO 流
├── 按方向分类
│   ├── 输入流（InputStream / Reader）
│   └── 输出流（OutputStream / Writer）
├── 按数据类型分类
│   ├── 字节流（InputStream / OutputStream）
│   └── 字符流（Reader / Writer）
└── 按功能分类
    ├── 节点流（直接操作数据源）
    └── 处理流（包装其他流，提供额外功能）
```

## 字节流 / 字符流区别

### 字节流（Byte Stream）

**字节流**以字节为单位处理数据，适合处理二进制数据。

**核心类**：
- `InputStream`：字节输入流
- `OutputStream`：字节输出流

**特点**：
- 处理字节数据（8 位）
- 适合处理图片、视频、音频等二进制文件
- 可以处理任何类型的数据

```java
// 字节流示例
try (FileInputStream fis = new FileInputStream("image.jpg");
     FileOutputStream fos = new FileOutputStream("copy.jpg")) {
    int data;
    while ((data = fis.read()) != -1) {
        fos.write(data);
    }
}
```

### 字符流（Character Stream）

**字符流**以字符为单位处理数据，适合处理文本数据。

**核心类**：
- `Reader`：字符输入流
- `Writer`：字符输出流

**特点**：
- 处理字符数据（16 位 Unicode）
- 适合处理文本文件
- 自动处理字符编码

```java
// 字符流示例
try (FileReader fr = new FileReader("text.txt");
     FileWriter fw = new FileWriter("copy.txt")) {
    int data;
    while ((data = fr.read()) != -1) {
        fw.write(data);
    }
}
```

### 字节流 vs 字符流

| 特性 | 字节流 | 字符流 |
|:----:|:------:|:------:|
| 数据单位 | 字节（8 位） | 字符（16 位） |
| 适用场景 | 二进制文件 | 文本文件 |
| 编码处理 | 不处理编码 | 自动处理编码 |
| 核心类 | InputStream/OutputStream | Reader/Writer |
| 性能 | 较快 | 较慢（需要编码转换） |

### 选择建议

**使用字节流**：
- 处理图片、视频、音频等二进制文件
- 处理网络数据
- 需要精确控制字节数据

**使用字符流**：
- 处理文本文件
- 需要自动处理字符编码
- 需要按字符处理数据

## IO 流的层次结构

### 节点流和处理流

#### 节点流（Node Stream）

**节点流**直接操作数据源。

```java
// 节点流：直接操作文件
FileInputStream fis = new FileInputStream("file.txt");
FileOutputStream fos = new FileOutputStream("file.txt");
```

#### 处理流（Processing Stream）

**处理流**包装其他流，提供额外功能。

```java
// 处理流：包装节点流，提供缓冲功能
BufferedInputStream bis = new BufferedInputStream(fis);
BufferedOutputStream bos = new BufferedOutputStream(fos);
```

### 装饰器模式

**Java IO 使用装饰器模式**，可以组合多个流：

```java
// 组合多个处理流
try (FileInputStream fis = new FileInputStream("file.txt");
     BufferedInputStream bis = new BufferedInputStream(fis);
     DataInputStream dis = new DataInputStream(bis)) {
    // 使用 DataInputStream 读取数据
}
```

## 实际示例

### 示例 1：字节流 vs 字符流

```java
import java.io.*;

public class StreamComparison {
    // 使用字节流复制文件
    public static void copyFileByteStream(String source, String dest) throws IOException {
        try (FileInputStream fis = new FileInputStream(source);
             FileOutputStream fos = new FileOutputStream(dest)) {
            int data;
            while ((data = fis.read()) != -1) {
                fos.write(data);
            }
        }
    }
    
    // 使用字符流复制文本文件
    public static void copyFileCharStream(String source, String dest) throws IOException {
        try (FileReader fr = new FileReader(source);
             FileWriter fw = new FileWriter(dest)) {
            int data;
            while ((data = fr.read()) != -1) {
                fw.write(data);
            }
        }
    }
    
    public static void main(String[] args) throws IOException {
        // 复制二进制文件（图片）使用字节流
        copyFileByteStream("image.jpg", "copy.jpg");
        
        // 复制文本文件可以使用字符流
        copyFileCharStream("text.txt", "copy.txt");
    }
}
```

### 示例 2：流的组合使用

```java
import java.io.*;

public class StreamComposition {
    public static void main(String[] args) throws IOException {
        // 组合多个流：文件 -> 缓冲 -> 数据流
        try (FileInputStream fis = new FileInputStream("data.bin");
             BufferedInputStream bis = new BufferedInputStream(fis);
             DataInputStream dis = new DataInputStream(bis)) {
            
            // 读取不同类型的数据
            int intValue = dis.readInt();
            double doubleValue = dis.readDouble();
            String stringValue = dis.readUTF();
            
            System.out.println("整数：" + intValue);
            System.out.println("浮点数：" + doubleValue);
            System.out.println("字符串：" + stringValue);
        }
    }
}
```

## IO 模型的选择

### 选择阻塞 IO（BIO）

- 连接数较少
- 简单应用
- 不需要高并发

### 选择非阻塞 IO（NIO）

- 高并发场景
- 大量连接
- 需要高性能

### 选择字节流

- 处理二进制数据
- 处理图片、视频等文件
- 网络数据传输

### 选择字符流

- 处理文本文件
- 需要字符编码处理
- 按字符处理数据

## 小结

Java IO 模型概览要点：

- **阻塞 IO**：同步阻塞，简单易用
- **非阻塞 IO**：非阻塞，适合高并发
- **输入流/输出流**：数据流动的方向
- **字节流/字符流**：处理的数据类型不同
- **节点流/处理流**：直接操作 vs 包装增强

**关键要点**：
- 输入流读取数据，输出流写入数据
- 字节流处理二进制数据，字符流处理文本数据
- 处理流可以组合使用，提供额外功能
- 根据场景选择合适的 IO 模型和流类型

理解了 IO 模型概览，你就能选择合适的 IO 方式。在下一章，我们将学习 Java 的文件与目录操作。
