---
sidebar_position: 2
slug: /java-files
sidebar_label: Java 文件与目录操作
---

# Java 文件与目录操作

文件与目录操作是程序开发中的常见需求。Java 提供了 `File` 类和 `Path/Files` 类来处理文件和目录。理解这些类的使用是进行文件操作的基础。本章将详细介绍 Java 中的文件与目录操作。

## File 类方法

File 类的常用方法包括：创建、删除、重命名、判断等。

### File 类概述

**`File` 类**（java.io.File）用于表示文件和目录的抽象路径名。

```java
import java.io.File;

// 创建 File 对象（不创建实际文件）
File file = new File("test.txt");
File dir = new File("directory");
```

### 创建文件和目录

```java
File file = new File("test.txt");

// 创建文件
boolean created = file.createNewFile();  // 如果文件不存在则创建

// 创建目录
File dir = new File("mydir");
boolean dirCreated = dir.mkdir();  // 创建单层目录

// 创建多层目录
File multiDir = new File("parent/child/grandchild");
boolean multiCreated = multiDir.mkdirs();  // 创建多层目录
```

### 删除文件和目录

```java
File file = new File("test.txt");

// 删除文件
boolean deleted = file.delete();  // 删除文件或空目录

// 删除目录（必须为空）
File dir = new File("mydir");
boolean dirDeleted = dir.delete();  // 只能删除空目录
```

### 重命名和移动

```java
File oldFile = new File("old.txt");
File newFile = new File("new.txt");

// 重命名或移动
boolean renamed = oldFile.renameTo(newFile);
```

### 判断文件属性

```java
File file = new File("test.txt");

// 判断是否存在
boolean exists = file.exists();

// 判断是否为文件
boolean isFile = file.isFile();

// 判断是否为目录
boolean isDirectory = file.isDirectory();

// 判断是否可读
boolean canRead = file.canRead();

// 判断是否可写
boolean canWrite = file.canWrite();

// 判断是否可执行
boolean canExecute = file.canExecute();

// 判断是否隐藏
boolean isHidden = file.isHidden();
```

### 获取文件信息

```java
File file = new File("test.txt");

// 获取文件名
String name = file.getName();  // "test.txt"

// 获取路径
String path = file.getPath();  // "test.txt"
String absolutePath = file.getAbsolutePath();  // 绝对路径

// 获取父目录
String parent = file.getParent();  // null 或父目录路径
File parentFile = file.getParentFile();

// 获取文件大小（字节）
long length = file.length();

// 获取最后修改时间
long lastModified = file.lastModified();  // 时间戳
Date date = new Date(lastModified);
```

### 列出目录内容

```java
File dir = new File("directory");

// 列出文件和目录名
String[] names = dir.list();

// 列出文件和目录对象
File[] files = dir.listFiles();

// 使用过滤器
File[] txtFiles = dir.listFiles((dir1, name) -> name.endsWith(".txt"));
```

## Path / Files 类（Java 7 NIO）

### Path 接口

**`Path` 接口**（java.nio.file.Path）是 Java 7 引入的，用于表示文件系统路径。

```java
import java.nio.file.Path;
import java.nio.file.Paths;

// 创建 Path 对象
Path path = Paths.get("test.txt");
Path absolutePath = Paths.get("/home/user/test.txt");

// 组合路径
Path base = Paths.get("/home/user");
Path file = base.resolve("test.txt");  // /home/user/test.txt

// 获取路径组成部分
Path parent = path.getParent();
Path fileName = path.getFileName();
Path root = path.getRoot();
```

### Files 类

**`Files` 类**提供了丰富的静态方法操作文件和目录。

#### 创建文件和目录

```java
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

// 创建文件
Path file = Paths.get("test.txt");
Files.createFile(file);

// 创建目录
Path dir = Paths.get("mydir");
Files.createDirectory(dir);

// 创建多层目录
Path multiDir = Paths.get("parent/child/grandchild");
Files.createDirectories(multiDir);
```

#### 删除文件和目录

```java
// 删除文件
Files.delete(file);

// 安全删除（不存在不抛异常）
Files.deleteIfExists(file);

// 删除目录（必须为空）
Files.delete(dir);
```

#### 复制和移动

```java
Path source = Paths.get("source.txt");
Path dest = Paths.get("dest.txt");

// 复制文件
Files.copy(source, dest);

// 移动文件（重命名）
Files.move(source, dest);

// 复制时指定选项
Files.copy(source, dest, StandardCopyOption.REPLACE_EXISTING);
```

#### 读取和写入

```java
Path file = Paths.get("test.txt");

// 读取所有字节
byte[] bytes = Files.readAllBytes(file);

// 读取所有行
List<String> lines = Files.readAllLines(file);

// 写入字节
Files.write(file, bytes);

// 写入行
List<String> content = Arrays.asList("line1", "line2");
Files.write(file, content);
```

#### 获取文件属性

```java
Path file = Paths.get("test.txt");

// 判断是否存在
boolean exists = Files.exists(file);

// 判断是否为文件/目录
boolean isFile = Files.isRegularFile(file);
boolean isDirectory = Files.isDirectory(file);

// 获取文件大小
long size = Files.size(file);

// 获取最后修改时间
FileTime lastModified = Files.getLastModifiedTime(file);

// 获取文件属性
BasicFileAttributes attrs = Files.readAttributes(file, BasicFileAttributes.class);
```

## 遍历目录、文件过滤

### 遍历目录（File 类）

```java
// 递归遍历目录
public static void traverseDirectory(File dir) {
    if (dir.isDirectory()) {
        File[] files = dir.listFiles();
        if (files != null) {
            for (File file : files) {
                if (file.isDirectory()) {
                    traverseDirectory(file);  // 递归
                } else {
                    System.out.println(file.getAbsolutePath());
                }
            }
        }
    }
}
```

### 文件过滤

```java
File dir = new File("directory");

// 使用 FileFilter
File[] txtFiles = dir.listFiles(new FileFilter() {
    @Override
    public boolean accept(File pathname) {
        return pathname.getName().endsWith(".txt");
    }
});

// 使用 Lambda 表达式
File[] txtFiles2 = dir.listFiles(f -> f.getName().endsWith(".txt"));

// 使用 FilenameFilter
File[] txtFiles3 = dir.listFiles((dir1, name) -> name.endsWith(".txt"));
```

### 使用 Files 遍历（Java 7+）

```java
import java.nio.file.*;
import java.io.IOException;

// 遍历目录
public static void walkDirectory(Path dir) throws IOException {
    Files.walkFileTree(dir, new SimpleFileVisitor<Path>() {
        @Override
        public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) {
            System.out.println(file);
            return FileVisitResult.CONTINUE;
        }
        
        @Override
        public FileVisitResult visitFileFailed(Path file, IOException exc) {
            return FileVisitResult.CONTINUE;
        }
    });
}

// 使用 Stream API（Java 8+）
Files.walk(Paths.get("directory"))
    .filter(Files::isRegularFile)
    .filter(path -> path.toString().endsWith(".txt"))
    .forEach(System.out::println);
```

## 示例：文件复制、文件列表获取

### 示例 1：文件复制

```java
import java.io.*;
import java.nio.file.*;

public class FileCopy {
    // 使用 File 类复制
    public static void copyFileOld(String source, String dest) throws IOException {
        try (FileInputStream fis = new FileInputStream(source);
             FileOutputStream fos = new FileOutputStream(dest)) {
            byte[] buffer = new byte[1024];
            int length;
            while ((length = fis.read(buffer)) > 0) {
                fos.write(buffer, 0, length);
            }
        }
    }
    
    // 使用 Files 类复制（推荐）
    public static void copyFileNew(String source, String dest) throws IOException {
        Path sourcePath = Paths.get(source);
        Path destPath = Paths.get(dest);
        Files.copy(sourcePath, destPath, StandardCopyOption.REPLACE_EXISTING);
    }
    
    public static void main(String[] args) throws IOException {
        copyFileOld("source.txt", "dest1.txt");
        copyFileNew("source.txt", "dest2.txt");
    }
}
```

### 示例 2：文件列表获取

```java
import java.io.*;
import java.nio.file.*;
import java.util.stream.Collectors;

public class FileList {
    // 使用 File 类
    public static void listFilesOld(String dirPath) {
        File dir = new File(dirPath);
        if (dir.isDirectory()) {
            File[] files = dir.listFiles();
            if (files != null) {
                for (File file : files) {
                    System.out.println(file.getName());
                }
            }
        }
    }
    
    // 使用 Files 类（推荐）
    public static void listFilesNew(String dirPath) throws IOException {
        Path dir = Paths.get(dirPath);
        Files.list(dir)
            .forEach(path -> System.out.println(path.getFileName()));
    }
    
    // 过滤文件
    public static void listTxtFiles(String dirPath) throws IOException {
        Path dir = Paths.get(dirPath);
        List<Path> txtFiles = Files.list(dir)
            .filter(Files::isRegularFile)
            .filter(path -> path.toString().endsWith(".txt"))
            .collect(Collectors.toList());
        
        txtFiles.forEach(System.out::println);
    }
}
```

### 示例 3：递归遍历目录

```java
import java.io.*;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;

public class DirectoryTraversal {
    // 使用 File 类递归遍历
    public static void traverseOld(File dir) {
        if (dir.isDirectory()) {
            File[] files = dir.listFiles();
            if (files != null) {
                for (File file : files) {
                    if (file.isDirectory()) {
                        traverseOld(file);
                    } else {
                        System.out.println(file.getAbsolutePath());
                    }
                }
            }
        }
    }
    
    // 使用 Files.walkFileTree（推荐）
    public static void traverseNew(Path dir) throws IOException {
        Files.walkFileTree(dir, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) {
                System.out.println(file);
                return FileVisitResult.CONTINUE;
            }
            
            @Override
            public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) {
                System.out.println("进入目录：" + dir);
                return FileVisitResult.CONTINUE;
            }
        });
    }
    
    // 使用 Stream API（Java 8+）
    public static void traverseStream(Path dir) throws IOException {
        Files.walk(dir)
            .filter(Files::isRegularFile)
            .forEach(System.out::println);
    }
}
```

### 示例 4：文件操作综合示例

```java
import java.io.*;
import java.nio.file.*;
import java.util.Arrays;

public class FileOperations {
    public static void main(String[] args) throws IOException {
        // 创建文件
        File file = new File("test.txt");
        file.createNewFile();
        
        // 写入内容
        try (FileWriter fw = new FileWriter(file)) {
            fw.write("Hello, World!");
        }
        
        // 读取内容
        try (FileReader fr = new FileReader(file)) {
            char[] buffer = new char[1024];
            int length = fr.read(buffer);
            System.out.println(new String(buffer, 0, length));
        }
        
        // 获取文件信息
        System.out.println("文件名：" + file.getName());
        System.out.println("大小：" + file.length() + " 字节");
        System.out.println("是否可读：" + file.canRead());
        System.out.println("是否可写：" + file.canWrite());
        
        // 使用 Files 类
        Path path = Paths.get("test.txt");
        List<String> lines = Files.readAllLines(path);
        System.out.println("行数：" + lines.size());
        
        // 删除文件
        Files.delete(path);
    }
}
```

## File vs Path/Files

### 对比表

| 特性 | File 类 | Path/Files 类 |
|:----:|:-------:|:-------------:|
| 引入版本 | Java 1.0 | Java 7 |
| API 设计 | 较老 | 现代化 |
| 功能 | 基本功能 | 功能更丰富 |
| 性能 | 一般 | 更好 |
| 推荐使用 | 旧代码 | 新代码 |

### 选择建议

**使用 File 类**：
- 维护旧代码
- 简单操作
- 兼容性要求

**使用 Path/Files 类**：
- 新项目
- 需要丰富功能
- 需要更好性能

## 小结

Java 文件与目录操作要点：

- **File 类**：传统文件操作，基本功能
- **Path/Files 类**：现代化 API，功能丰富
- **创建删除**：文件和目录的创建与删除
- **遍历目录**：递归遍历和文件过滤
- **文件复制**：使用流或 Files 类

**关键要点**：
- File 类用于基本文件操作
- Path/Files 类提供更强大的功能
- 使用 Files.walkFileTree 遍历目录
- 使用过滤器筛选文件
- 推荐使用 Path/Files 类（Java 7+）

理解了文件与目录操作，你就能处理各种文件操作需求。在下一章，我们将学习 Java 的字节流与字符流。
