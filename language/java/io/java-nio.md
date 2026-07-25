---
sidebar_position: 5
slug: /java-nio
sidebar_label: Java NIO 简介
---

# Java NIO 简介

NIO（New IO）是 Java 4 引入的新 IO API，提供了非阻塞 IO 和更高效的 IO 操作。理解 NIO 的基本概念是进行高性能 IO 开发的基础。本章将简要介绍 Java NIO 的核心概念。

## Buffer 与 Channel 概念

### Buffer（缓冲区）

**`Buffer`** 是 NIO 中用于存储数据的容器。

**核心 Buffer 类型**：
- `ByteBuffer`：字节缓冲区
- `CharBuffer`：字符缓冲区
- `IntBuffer`：整数缓冲区
- `DoubleBuffer`：双精度缓冲区

**Buffer 的状态**：
- **capacity**：容量，缓冲区大小
- **position**：位置，下一个读写位置
- **limit**：限制，可读写数据的边界
- **mark**：标记，用于 reset

```java
import java.nio.ByteBuffer;

// 创建缓冲区
ByteBuffer buffer = ByteBuffer.allocate(1024);  // 分配 1024 字节

// 写入数据
buffer.put("Hello".getBytes());

// 切换到读模式
buffer.flip();

// 读取数据
byte[] data = new byte[buffer.remaining()];
buffer.get(data);
```

### Channel（通道）

**`Channel`** 是 NIO 中用于 IO 操作的通道。

**核心 Channel 类型**：
- `FileChannel`：文件通道
- `SocketChannel`：TCP 通道
- `ServerSocketChannel`：TCP 服务器通道
- `DatagramChannel`：UDP 通道

**特点**：
- 双向：可以读写
- 异步：支持非阻塞模式
- 高效：直接与操作系统交互

```java
import java.nio.channels.FileChannel;
import java.nio.file.*;

// 打开文件通道
FileChannel channel = FileChannel.open(Paths.get("file.txt"), 
                                       StandardOpenOption.READ, 
                                       StandardOpenOption.WRITE);
```

## 文件通道（FileChannel）

### FileChannel 基本操作

```java
import java.nio.channels.FileChannel;
import java.nio.file.*;
import java.nio.ByteBuffer;

// 打开文件通道
Path path = Paths.get("file.txt");
try (FileChannel channel = FileChannel.open(path, 
        StandardOpenOption.READ, 
        StandardOpenOption.WRITE)) {
    
    // 读取数据
    ByteBuffer buffer = ByteBuffer.allocate(1024);
    int bytesRead = channel.read(buffer);
    
    // 写入数据
    buffer.flip();
    channel.write(buffer);
}
```

### 文件复制（FileChannel）

```java
// 使用 FileChannel 复制文件（高效）
public static void copyFile(Path source, Path dest) throws IOException {
    try (FileChannel sourceChannel = FileChannel.open(source, StandardOpenOption.READ);
         FileChannel destChannel = FileChannel.open(dest, 
             StandardOpenOption.WRITE, StandardOpenOption.CREATE)) {
        destChannel.transferFrom(sourceChannel, 0, sourceChannel.size());
    }
}
```

## Path 与 Files API

### Path 接口

**`Path`** 表示文件系统路径（Java 7+）。

```java
import java.nio.file.Path;
import java.nio.file.Paths;

// 创建 Path
Path path = Paths.get("file.txt");
Path absolutePath = Paths.get("/home/user/file.txt");

// 路径操作
Path parent = path.getParent();
Path fileName = path.getFileName();
Path root = path.getRoot();

// 组合路径
Path base = Paths.get("/home/user");
Path file = base.resolve("file.txt");  // /home/user/file.txt
```

### Files 类

**`Files`** 提供了丰富的文件操作静态方法。

```java
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.List;

// 读取文件
byte[] bytes = Files.readAllBytes(path);
List<String> lines = Files.readAllLines(path);

// 写入文件
Files.write(path, bytes);
Files.write(path, lines);

// 复制文件
Files.copy(source, dest, StandardCopyOption.REPLACE_EXISTING);

// 移动文件
Files.move(source, dest, StandardCopyOption.REPLACE_EXISTING);

// 删除文件
Files.delete(path);
Files.deleteIfExists(path);

// 创建目录
Files.createDirectory(path);
Files.createDirectories(path);

// 获取文件属性
long size = Files.size(path);
FileTime lastModified = Files.getLastModifiedTime(path);
BasicFileAttributes attrs = Files.readAttributes(path, BasicFileAttributes.class);
```

## 示例：NIO 文件拷贝

### 示例 1：使用 FileChannel 复制

```java
import java.nio.channels.FileChannel;
import java.nio.file.*;

public class NIOFileCopy {
    // 方法 1：使用 transferFrom
    public static void copyFile1(Path source, Path dest) throws IOException {
        try (FileChannel sourceChannel = FileChannel.open(source, StandardOpenOption.READ);
             FileChannel destChannel = FileChannel.open(dest, 
                 StandardOpenOption.WRITE, StandardOpenOption.CREATE)) {
            destChannel.transferFrom(sourceChannel, 0, sourceChannel.size());
        }
    }
    
    // 方法 2：使用 transferTo
    public static void copyFile2(Path source, Path dest) throws IOException {
        try (FileChannel sourceChannel = FileChannel.open(source, StandardOpenOption.READ);
             FileChannel destChannel = FileChannel.open(dest, 
                 StandardOpenOption.WRITE, StandardOpenOption.CREATE)) {
            sourceChannel.transferTo(0, sourceChannel.size(), destChannel);
        }
    }
    
    // 方法 3：使用 Buffer
    public static void copyFile3(Path source, Path dest) throws IOException {
        try (FileChannel sourceChannel = FileChannel.open(source, StandardOpenOption.READ);
             FileChannel destChannel = FileChannel.open(dest, 
                 StandardOpenOption.WRITE, StandardOpenOption.CREATE)) {
            ByteBuffer buffer = ByteBuffer.allocate(8192);
            while (sourceChannel.read(buffer) != -1) {
                buffer.flip();
                destChannel.write(buffer);
                buffer.clear();
            }
        }
    }
}
```

### 示例 2：使用 Files 类

```java
import java.nio.file.*;

public class FilesExample {
    public static void main(String[] args) throws IOException {
        Path source = Paths.get("source.txt");
        Path dest = Paths.get("dest.txt");
        
        // 复制文件
        Files.copy(source, dest, StandardCopyOption.REPLACE_EXISTING);
        
        // 读取所有行
        List<String> lines = Files.readAllLines(source);
        
        // 写入所有行
        Files.write(dest, lines);
        
        // 读取所有字节
        byte[] bytes = Files.readAllBytes(source);
        
        // 写入字节
        Files.write(dest, bytes);
    }
}
```

### 示例 3：Buffer 操作

```java
import java.nio.ByteBuffer;

public class BufferExample {
    public static void main(String[] args) {
        // 创建缓冲区
        ByteBuffer buffer = ByteBuffer.allocate(1024);
        
        // 写入模式
        buffer.put("Hello".getBytes());
        buffer.put(" World".getBytes());
        
        // 切换到读模式
        buffer.flip();
        
        // 读取数据
        byte[] data = new byte[buffer.remaining()];
        buffer.get(data);
        System.out.println(new String(data));  // "Hello World"
        
        // 重置位置
        buffer.rewind();
        
        // 标记和重置
        buffer.mark();
        buffer.get();  // 读取一个字节
        buffer.reset();  // 回到标记位置
    }
}
```

## NIO vs 传统 IO

### 对比表

| 特性 | 传统 IO | NIO |
|:----:|:-------:|:---:|
| 阻塞性 | 阻塞 | 非阻塞（可选） |
| 缓冲区 | 流 | Buffer |
| 通道 | 流 | Channel |
| 选择器 | 无 | Selector |
| 适用场景 | 连接数少 | 高并发 |

### 选择建议

**使用传统 IO**：
- 简单应用
- 连接数较少
- 不需要高并发

**使用 NIO**：
- 高并发场景
- 大量连接
- 需要非阻塞 IO

## NIO 的核心概念总结

### 1. Buffer

- 存储数据的容器
- 有 position、limit、capacity 等属性
- 支持读写模式切换

### 2. Channel

- IO 操作的通道
- 双向（可读写）
- 支持非阻塞模式

### 3. Selector

- 多路复用器
- 一个线程管理多个 Channel
- 适合高并发场景

## 小结

Java NIO 简介要点：

- **Buffer**：数据容器，有 position、limit、capacity
- **Channel**：IO 通道，双向，支持非阻塞
- **FileChannel**：文件通道，高效文件操作
- **Path/Files**：现代化文件 API（Java 7+）
- **优势**：非阻塞、高性能、适合高并发

**关键要点**：

- NIO 使用 Buffer 和 Channel
- FileChannel 提供高效文件操作
- Path/Files 提供现代化文件 API
- NIO 适合高并发场景
- 传统 IO 适合简单应用

理解了 NIO 的基本概念，你就能进行高性能的 IO 操作。恭喜你完成了第六部分的学习！
