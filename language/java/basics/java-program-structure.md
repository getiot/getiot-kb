---
sidebar_position: 4
slug: /java-program-structure
---

# Java 程序的基本结构

在编写第一个 Java 程序之前，你需要了解 Java 程序的基本结构。理解程序结构有助于你更好地组织代码，编写出清晰、规范的 Java 程序。

## 类文件结构

### 完整的 Java 程序结构

一个典型的 Java 源文件（.java）包含以下部分：

```java showLineNumbers
// 1. 包声明（可选）
package com.example;

// 2. 导入语句（可选）
import java.util.Scanner;
import java.util.*;

// 3. 类定义（必需）
public class HelloWorld {
    
    // 4. 主方法（程序入口）
    public static void main(String[] args) {
        // 5. 程序代码
        System.out.println("Hello, World!");
    }
    
    // 6. 其他方法（可选）
    public void sayHello() {
        System.out.println("Hello!");
    }
}
```

### 各部分详解

#### 1. 包声明（package）

**作用**：组织和管理类，避免类名冲突

```java showLineNumbers
package com.example.hello;

public class HelloWorld {
    // ...
}
```

**规则**：
- 必须是文件的第一行有效代码（注释除外）
- 一个文件只能有一个包声明
- 包名通常使用小写字母，用点分隔
- 包名通常对应目录结构

**命名规范**：
- 使用反向域名：`com.example.project`
- 全小写
- 多个单词用点分隔

#### 2. 导入语句（import）

**作用**：引入其他包的类，简化类名使用

```java showLineNumbers
// 导入单个类
import java.util.Scanner;

// 导入整个包（不推荐，可能造成命名冲突）
import java.util.*;

// 使用完全限定名（不导入）
java.util.Scanner scanner = new java.util.Scanner(System.in);
```

**规则**：
- 在包声明之后，类定义之前
- 可以有多个 import 语句
- 按字母顺序排列（可选，但推荐）

**常用导入**：

```java showLineNumbers
import java.util.Scanner;        // 输入
import java.util.ArrayList;      // 列表
import java.util.HashMap;        // 映射
import java.io.File;             // 文件
import java.io.IOException;      // 异常
```

#### 3. 类定义（class）

**作用**：定义类的结构和行为

```java showLineNumbers
// 公共类（public class）
public class HelloWorld {
    // 类内容
}

// 普通类
class Helper {
    // 类内容
}
```

**规则**：
- 一个文件最多只能有一个 public 类
- public 类的名称必须与文件名相同
- 类名使用大驼峰命名（PascalCase）

**类修饰符**：
- `public`：公共类，可以被其他包访问
- `abstract`：抽象类，不能实例化
- `final`：最终类，不能被继承
- 无修饰符：包私有，只能在同一包内访问

#### 4. 主方法（main）

**作用**：程序的入口点，JVM 从这里开始执行

```java showLineNumbers
public static void main(String[] args) {
    // 程序代码
}
```

**方法签名说明**：
- `public`：公共方法，可以被 JVM 调用
- `static`：静态方法，属于类而不是实例
- `void`：无返回值
- `main`：方法名，固定
- `String[] args`：命令行参数数组

**命令行参数示例**：

```java showLineNumbers
public class ArgsExample {
    public static void main(String[] args) {
        System.out.println("参数个数：" + args.length);
        for (int i = 0; i < args.length; i++) {
            System.out.println("参数 " + i + ": " + args[i]);
        }
    }
}
```

运行：
```bash showLineNumbers
java ArgsExample hello world
# 输出：
# 参数个数：2
# 参数 0: hello
# 参数 1: world
```

## 注释与代码风格

### 注释类型

#### 1. 单行注释

```java showLineNumbers
// 这是单行注释
int x = 10; // 行尾注释
```

#### 2. 多行注释

```java showLineNumbers
/*
 * 这是多行注释
 * 可以写多行
 * 用于较长的说明
 */
```

#### 3. 文档注释（Javadoc）

```java showLineNumbers
/**
 * 这是文档注释
 * 用于生成 API 文档
 * 
 * @param name 用户名
 * @return 问候语
 */
public String greet(String name) {
    return "Hello, " + name;
}
```

### 代码风格规范

#### 1. 命名规范

**类名**：大驼峰命名（PascalCase）
```java showLineNumbers
public class StudentManager { }
public class UserService { }
```

**方法名和变量名**：小驼峰命名（camelCase）
```java showLineNumbers
public void getUserName() { }
int studentCount = 10;
```

**常量**：全大写下划线分隔（UPPER_SNAKE_CASE）
```java showLineNumbers
public static final int MAX_SIZE = 100;
public static final String DEFAULT_NAME = "Unknown";
```

**包名**：全小写，点分隔
```java showLineNumbers
package com.example.project;
```

#### 2. 缩进和空格

```java showLineNumbers
// 推荐：使用 4 个空格缩进
public class Example {
    public void method() {
        if (condition) {
            // 代码
        }
    }
}
```

#### 3. 大括号风格

**推荐风格**：左大括号不换行

```java showLineNumbers
public class Example {
    public void method() {
        if (condition) {
            // 代码
        }
    }
}
```

#### 4. 代码组织

```java showLineNumbers
public class Student {
    // 1. 常量
    private static final int MAX_AGE = 100;
    
    // 2. 字段（属性）
    private String name;
    private int age;
    
    // 3. 构造方法
    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    // 4. 方法
    public String getName() {
        return name;
    }
    
    // 5. 内部类（如果有）
    private class Helper { }
}
```

## 方法与语句块

### 方法定义

**语法**：
```java showLineNumbers
[访问修饰符] [static] [final] 返回类型 方法名(参数列表) {
    // 方法体
}
```

**示例**：

```java showLineNumbers
// 无参数无返回值
public void sayHello() {
    System.out.println("Hello!");
}

// 有参数有返回值
public int add(int a, int b) {
    return a + b;
}

// 静态方法
public static void printMessage(String message) {
    System.out.println(message);
}
```

### 语句块

**代码块**：用大括号 `{}` 包围的代码

```java showLineNumbers
public class Example {
    // 类级别代码块
    {
        System.out.println("实例初始化块");
    }
    
    // 静态代码块
    static {
        System.out.println("静态初始化块");
    }
    
    public void method() {
        // 方法代码块
        {
            int x = 10;
            System.out.println(x);
        }
        // x 在这里不可访问
    }
}
```

**作用域**：
- 代码块内定义的变量只在块内有效
- 外层代码块可以访问内层变量
- 内层代码块不能访问外层同名变量

## 编译与运行关系

### 编译过程

```bash
Java 源代码 (.java)
    ↓ javac 编译
字节码 (.class)
    ↓ JVM 执行
运行结果
```

### 文件结构示例

```bash
project/
├── src/
│   └── com/
│       └── example/
│           └── HelloWorld.java
└── out/
    └── com/
        └── example/
            └── HelloWorld.class
```

### 编译命令

```bash showLineNumbers
# 编译单个文件
javac HelloWorld.java

# 编译带包的文件
javac com/example/HelloWorld.java

# 编译多个文件
javac *.java

# 指定输出目录
javac -d out src/**/*.java
```

### 运行命令

```bash showLineNumbers
# 运行类（无包）
java HelloWorld

# 运行带包的类
java com.example.HelloWorld

# 传递参数
java HelloWorld arg1 arg2

# 指定类路径
java -cp .:lib/* com.example.HelloWorld
```

### 类路径（classpath）

**作用**：告诉 JVM 在哪里查找类文件

```bash showLineNumbers
# 设置类路径
java -cp /path/to/classes com.example.HelloWorld

# 多个路径（Windows 用分号，Linux/macOS 用冒号）
java -cp .:lib/*:out com.example.HelloWorld

# 使用环境变量
export CLASSPATH=.:lib/*
java com.example.HelloWorld
```

## 完整示例

### 示例 1：简单程序

```java showLineNumbers
public class SimpleExample {
    public static void main(String[] args) {
        System.out.println("这是一个简单的 Java 程序");
    }
}
```

### 示例 2：带包和导入的程序

```java showLineNumbers
package com.example;

import java.util.Scanner;

public class InputExample {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("请输入你的名字：");
        String name = scanner.nextLine();
        System.out.println("你好，" + name + "！");
        scanner.close();
    }
}
```

### 示例 3：多类文件程序

**文件 1：Student.java**
```java showLineNumbers title="Student.java"
package com.example;

public class Student {
    private String name;
    private int age;
    
    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    public void introduce() {
        System.out.println("我是 " + name + "，今年 " + age + " 岁");
    }
}
```

**文件 2：Main.java**
```java showLineNumbers title="Main.java"
package com.example;

public class Main {
    public static void main(String[] args) {
        Student student = new Student("张三", 20);
        student.introduce();
    }
}
```

## 小结

Java 程序的基本结构：

- **包声明**：组织类，避免冲突
- **导入语句**：引入其他包的类
- **类定义**：定义类的结构和行为
- **主方法**：程序入口点
- **注释**：单行、多行、文档注释
- **代码风格**：命名规范、缩进、组织

**关键要点**：
- 一个文件最多一个 public 类
- public 类名必须与文件名相同
- main 方法是程序入口
- 包名对应目录结构
- 遵循代码风格规范

理解了 Java 程序的基本结构，你就能编写规范的 Java 代码。在下一章，我们将编写第一个 Java 程序。
