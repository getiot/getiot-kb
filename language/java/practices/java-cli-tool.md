---
sidebar_position: 1
slug: /java-cli-tool
sidebar_label: Java 命令行工具示例
---

# Java 命令行工具示例

命令行工具是 Java 应用的重要形式。理解命令行工具的开发是进行实用程序开发的基础。本章将介绍如何开发 Java 命令行工具。

## Scanner 与 Console 使用

### Scanner 读取输入

**`Scanner`** 用于读取用户输入。

```java
import java.util.Scanner;

public class ScannerExample {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.print("请输入姓名：");
        String name = scanner.nextLine();
        
        System.out.print("请输入年龄：");
        int age = scanner.nextInt();
        
        System.out.println("姓名：" + name + "，年龄：" + age);
        
        scanner.close();
    }
}
```

### Console 读取密码

**`Console`** 用于读取敏感信息（如密码）。

```java
import java.io.Console;

public class ConsoleExample {
    public static void main(String[] args) {
        Console console = System.console();
        
        if (console == null) {
            System.err.println("无法获取控制台");
            return;
        }
        
        String username = console.readLine("用户名：");
        char[] password = console.readPassword("密码：");
        
        System.out.println("用户名：" + username);
        System.out.println("密码长度：" + password.length);
        
        // 清除密码
        java.util.Arrays.fill(password, ' ');
    }
}
```

## 命令行参数解析

### 基本参数解析

```java
public class ArgsParser {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("用法：java ArgsParser <选项>");
            return;
        }
        
        for (int i = 0; i < args.length; i++) {
            String arg = args[i];
            
            if ("-h".equals(arg) || "--help".equals(arg)) {
                printHelp();
            } else if ("-v".equals(arg) || "--version".equals(arg)) {
                printVersion();
            } else if ("-f".equals(arg) || "--file".equals(arg)) {
                if (i + 1 < args.length) {
                    String filename = args[++i];
                    processFile(filename);
                } else {
                    System.err.println("错误：-f 选项需要文件名");
                }
            } else {
                System.err.println("未知选项：" + arg);
            }
        }
    }
    
    private static void printHelp() {
        System.out.println("帮助信息");
    }
    
    private static void printVersion() {
        System.out.println("版本 1.0.0");
    }
    
    private static void processFile(String filename) {
        System.out.println("处理文件：" + filename);
    }
}
```

### 使用 Apache Commons CLI

```java
import org.apache.commons.cli.*;

public class CLITool {
    public static void main(String[] args) {
        Options options = new Options();
        
        options.addOption("h", "help", false, "显示帮助");
        options.addOption("v", "version", false, "显示版本");
        options.addOption(Option.builder("f")
            .longOpt("file")
            .hasArg()
            .argName("FILE")
            .desc("指定文件")
            .build());
        
        CommandLineParser parser = new DefaultParser();
        try {
            CommandLine cmd = parser.parse(options, args);
            
            if (cmd.hasOption("help")) {
                HelpFormatter formatter = new HelpFormatter();
                formatter.printHelp("CLITool", options);
            } else if (cmd.hasOption("version")) {
                System.out.println("版本 1.0.0");
            } else if (cmd.hasOption("file")) {
                String filename = cmd.getOptionValue("file");
                processFile(filename);
            }
        } catch (ParseException e) {
            System.err.println("解析错误：" + e.getMessage());
        }
    }
    
    private static void processFile(String filename) {
        System.out.println("处理文件：" + filename);
    }
}
```

## 简单 CLI 工具实现

### 示例 1：计算器工具

```java
import java.util.Scanner;

public class CalculatorCLI {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("简单计算器");
        System.out.println("输入 'quit' 退出");
        
        while (true) {
            System.out.print("> ");
            String input = scanner.nextLine().trim();
            
            if ("quit".equalsIgnoreCase(input)) {
                break;
            }
            
            try {
                double result = evaluate(input);
                System.out.println("结果：" + result);
            } catch (Exception e) {
                System.err.println("错误：" + e.getMessage());
            }
        }
        
        scanner.close();
        System.out.println("再见！");
    }
    
    private static double evaluate(String expression) {
        // 简单的表达式计算（示例）
        String[] parts = expression.split("\\s+");
        if (parts.length != 3) {
            throw new IllegalArgumentException("格式：数字 运算符 数字");
        }
        
        double a = Double.parseDouble(parts[0]);
        String op = parts[1];
        double b = Double.parseDouble(parts[2]);
        
        switch (op) {
            case "+":
                return a + b;
            case "-":
                return a - b;
            case "*":
                return a * b;
            case "/":
                if (b == 0) {
                    throw new ArithmeticException("除数不能为0");
                }
                return a / b;
            default:
                throw new IllegalArgumentException("未知运算符：" + op);
        }
    }
}
```

### 示例 2：文件查找工具

```java
import java.io.File;
import java.util.Scanner;

public class FileFinder {
    public static void main(String[] args) {
        if (args.length < 2) {
            System.out.println("用法：java FileFinder <目录> <文件名>");
            return;
        }
        
        String directory = args[0];
        String filename = args[1];
        
        File dir = new File(directory);
        if (!dir.exists() || !dir.isDirectory()) {
            System.err.println("错误：目录不存在");
            return;
        }
        
        findFiles(dir, filename);
    }
    
    private static void findFiles(File directory, String filename) {
        File[] files = directory.listFiles();
        if (files == null) {
            return;
        }
        
        for (File file : files) {
            if (file.isDirectory()) {
                findFiles(file, filename);
            } else if (file.getName().contains(filename)) {
                System.out.println(file.getAbsolutePath());
            }
        }
    }
}
```

### 示例 3：待办事项管理工具

```java
import java.util.*;

public class TodoCLI {
    private static List<String> todos = new ArrayList<>();
    private static Scanner scanner = new Scanner(System.in);
    
    public static void main(String[] args) {
        System.out.println("待办事项管理工具");
        System.out.println("命令：add, list, remove, quit");
        
        while (true) {
            System.out.print("> ");
            String command = scanner.nextLine().trim();
            
            if ("quit".equalsIgnoreCase(command)) {
                break;
            } else if (command.startsWith("add ")) {
                String task = command.substring(4).trim();
                addTodo(task);
            } else if ("list".equalsIgnoreCase(command)) {
                listTodos();
            } else if (command.startsWith("remove ")) {
                try {
                    int index = Integer.parseInt(command.substring(7).trim());
                    removeTodo(index);
                } catch (NumberFormatException e) {
                    System.err.println("错误：无效的索引");
                }
            } else {
                System.err.println("未知命令：" + command);
            }
        }
        
        scanner.close();
    }
    
    private static void addTodo(String task) {
        todos.add(task);
        System.out.println("已添加：" + task);
    }
    
    private static void listTodos() {
        if (todos.isEmpty()) {
            System.out.println("没有待办事项");
        } else {
            for (int i = 0; i < todos.size(); i++) {
                System.out.println((i + 1) + ". " + todos.get(i));
            }
        }
    }
    
    private static void removeTodo(int index) {
        if (index < 1 || index > todos.size()) {
            System.err.println("错误：索引超出范围");
            return;
        }
        String removed = todos.remove(index - 1);
        System.out.println("已删除：" + removed);
    }
}
```

## 小结

Java 命令行工具要点：

- **Scanner**：读取用户输入
- **Console**：读取敏感信息（密码）
- **命令行参数**：通过 args 数组获取
- **CLI 工具**：实现交互式命令行工具

**关键要点**：
- 使用 Scanner 读取输入
- 使用 Console 读取密码
- 解析命令行参数
- 实现交互式 CLI 工具
- 提供清晰的用户界面

理解了命令行工具开发，你就能创建实用的 CLI 程序。在下一章，我们将学习 Java 文件管理小工具。
