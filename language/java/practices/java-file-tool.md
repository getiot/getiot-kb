---
sidebar_position: 2
slug: /java-file-tool
sidebar_label: Java 文件管理小工具
---

# Java 文件管理小工具

文件操作是 Java 应用的常见需求。理解文件管理工具的开发是进行实用程序开发的基础。本章将介绍如何开发文件管理工具。

## 文件批量操作示例

### 批量重命名

```java
import java.io.File;
import java.nio.file.*;

public class FileRenamer {
    public static void main(String[] args) {
        if (args.length < 2) {
            System.out.println("用法：java FileRenamer <目录> <前缀>");
            return;
        }
        
        String directory = args[0];
        String prefix = args[1];
        
        File dir = new File(directory);
        if (!dir.exists() || !dir.isDirectory()) {
            System.err.println("错误：目录不存在");
            return;
        }
        
        renameFiles(dir, prefix);
    }
    
    private static void renameFiles(File directory, String prefix) {
        File[] files = directory.listFiles();
        if (files == null) {
            return;
        }
        
        int counter = 1;
        for (File file : files) {
            if (file.isFile()) {
                String extension = getExtension(file.getName());
                String newName = prefix + "_" + counter + extension;
                File newFile = new File(directory, newName);
                
                if (file.renameTo(newFile)) {
                    System.out.println("重命名：" + file.getName() + " -> " + newName);
                    counter++;
                } else {
                    System.err.println("重命名失败：" + file.getName());
                }
            }
        }
    }
    
    private static String getExtension(String filename) {
        int lastDot = filename.lastIndexOf('.');
        return lastDot > 0 ? filename.substring(lastDot) : "";
    }
}
```

### 批量复制

```java
import java.io.*;
import java.nio.file.*;

public class FileCopier {
    public static void main(String[] args) {
        if (args.length < 2) {
            System.out.println("用法：java FileCopier <源目录> <目标目录>");
            return;
        }
        
        String sourceDir = args[0];
        String targetDir = args[1];
        
        try {
            copyDirectory(sourceDir, targetDir);
            System.out.println("复制完成");
        } catch (IOException e) {
            System.err.println("复制失败：" + e.getMessage());
        }
    }
    
    private static void copyDirectory(String source, String target) throws IOException {
        Path sourcePath = Paths.get(source);
        Path targetPath = Paths.get(target);
        
        Files.walk(sourcePath).forEach(sourceFile -> {
            try {
                Path targetFile = targetPath.resolve(sourcePath.relativize(sourceFile));
                if (Files.isDirectory(sourceFile)) {
                    Files.createDirectories(targetFile);
                } else {
                    Files.copy(sourceFile, targetFile, StandardCopyOption.REPLACE_EXISTING);
                    System.out.println("复制：" + sourceFile + " -> " + targetFile);
                }
            } catch (IOException e) {
                System.err.println("复制失败：" + sourceFile + " - " + e.getMessage());
            }
        });
    }
}
```

## 目录遍历与筛选

### 目录遍历

```java
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class DirectoryTraverser {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("用法：java DirectoryTraverser <目录>");
            return;
        }
        
        String directory = args[0];
        File dir = new File(directory);
        
        if (!dir.exists() || !dir.isDirectory()) {
            System.err.println("错误：目录不存在");
            return;
        }
        
        List<File> allFiles = new ArrayList<>();
        traverseDirectory(dir, allFiles);
        
        System.out.println("找到 " + allFiles.size() + " 个文件：");
        for (File file : allFiles) {
            System.out.println(file.getAbsolutePath());
        }
    }
    
    private static void traverseDirectory(File directory, List<File> files) {
        File[] entries = directory.listFiles();
        if (entries == null) {
            return;
        }
        
        for (File entry : entries) {
            if (entry.isDirectory()) {
                traverseDirectory(entry, files);
            } else {
                files.add(entry);
            }
        }
    }
}
```

### 文件筛选

```java
import java.io.File;
import java.util.function.Predicate;

public class FileFilter {
    public static void main(String[] args) {
        if (args.length < 2) {
            System.out.println("用法：java FileFilter <目录> <扩展名>");
            return;
        }
        
        String directory = args[0];
        String extension = args[1];
        
        File dir = new File(directory);
        if (!dir.exists() || !dir.isDirectory()) {
            System.err.println("错误：目录不存在");
            return;
        }
        
        Predicate<File> filter = file -> {
            if (!file.isFile()) {
                return false;
            }
            String name = file.getName();
            return name.endsWith("." + extension);
        };
        
        filterFiles(dir, filter);
    }
    
    private static void filterFiles(File directory, Predicate<File> filter) {
        File[] files = directory.listFiles();
        if (files == null) {
            return;
        }
        
        for (File file : files) {
            if (file.isDirectory()) {
                filterFiles(file, filter);
            } else if (filter.test(file)) {
                System.out.println(file.getAbsolutePath());
            }
        }
    }
}
```

## 读写日志文件示例

### 日志文件写入

```java
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class LogWriter {
    private String logFile;
    private PrintWriter writer;
    
    public LogWriter(String logFile) throws IOException {
        this.logFile = logFile;
        this.writer = new PrintWriter(
            new FileWriter(logFile, true),  // 追加模式
            true  // 自动刷新
        );
    }
    
    public void log(String level, String message) {
        String timestamp = LocalDateTime.now()
            .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        writer.println(String.format("[%s] [%s] %s", timestamp, level, message));
    }
    
    public void info(String message) {
        log("INFO", message);
    }
    
    public void warn(String message) {
        log("WARN", message);
    }
    
    public void error(String message) {
        log("ERROR", message);
    }
    
    public void close() {
        writer.close();
    }
    
    public static void main(String[] args) {
        try {
            LogWriter logger = new LogWriter("application.log");
            
            logger.info("应用启动");
            logger.warn("这是一个警告");
            logger.error("这是一个错误");
            
            logger.close();
            System.out.println("日志已写入");
        } catch (IOException e) {
            System.err.println("写入日志失败：" + e.getMessage());
        }
    }
}
```

### 日志文件读取

```java
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class LogReader {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("用法：java LogReader <日志文件>");
            return;
        }
        
        String logFile = args[0];
        try {
            List<String> logs = readLogs(logFile);
            System.out.println("读取到 " + logs.size() + " 条日志：");
            for (String log : logs) {
                System.out.println(log);
            }
        } catch (IOException e) {
            System.err.println("读取日志失败：" + e.getMessage());
        }
    }
    
    private static List<String> readLogs(String logFile) throws IOException {
        List<String> logs = new ArrayList<>();
        
        try (BufferedReader reader = new BufferedReader(
                new FileReader(logFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                logs.add(line);
            }
        }
        
        return logs;
    }
    
    // 按级别筛选日志
    public static List<String> filterByLevel(String logFile, String level) throws IOException {
        List<String> filtered = new ArrayList<>();
        
        try (BufferedReader reader = new BufferedReader(
                new FileReader(logFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.contains("[" + level + "]")) {
                    filtered.add(line);
                }
            }
        }
        
        return filtered;
    }
}
```

### 日志文件分析

```java
import java.io.*;
import java.util.*;

public class LogAnalyzer {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("用法：java LogAnalyzer <日志文件>");
            return;
        }
        
        String logFile = args[0];
        try {
            analyzeLogs(logFile);
        } catch (IOException e) {
            System.err.println("分析日志失败：" + e.getMessage());
        }
    }
    
    private static void analyzeLogs(String logFile) throws IOException {
        Map<String, Integer> levelCount = new HashMap<>();
        int totalLines = 0;
        
        try (BufferedReader reader = new BufferedReader(
                new FileReader(logFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                totalLines++;
                
                if (line.contains("[INFO]")) {
                    levelCount.merge("INFO", 1, Integer::sum);
                } else if (line.contains("[WARN]")) {
                    levelCount.merge("WARN", 1, Integer::sum);
                } else if (line.contains("[ERROR]")) {
                    levelCount.merge("ERROR", 1, Integer::sum);
                }
            }
        }
        
        System.out.println("日志分析结果：");
        System.out.println("总行数：" + totalLines);
        System.out.println("级别统计：");
        levelCount.forEach((level, count) -> {
            System.out.println("  " + level + ": " + count);
        });
    }
}
```

## 小结

Java 文件管理工具要点：

- **批量操作**：重命名、复制、移动文件
- **目录遍历**：递归遍历目录结构
- **文件筛选**：按条件筛选文件
- **日志处理**：读写和分析日志文件

**关键要点**：
- 使用 File 和 NIO.2 进行文件操作
- 实现批量文件操作
- 遍历和筛选文件
- 读写日志文件
- 分析日志数据

理解了文件管理工具，你就能开发实用的文件处理程序。在下一章，我们将学习 Java 编码规范与最佳实践。
