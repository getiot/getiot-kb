---
sidebar_position: 6
slug: /java-compile-run
---

# Java 编译与运行过程

理解 Java 的编译和运行过程，有助于你更好地理解 Java 的工作原理，以及如何解决编译和运行中的问题。本章将详细介绍从源代码到程序执行的完整过程。

## Java 源码 → 字节码 → JVM 执行

### 完整流程

```bash
Java 源代码 (.java)
    ↓
javac 编译器
    ↓
字节码 (.class)
    ↓
JVM（Java 虚拟机）
    ↓
机器码（JIT 编译）
    ↓
CPU 执行
    ↓
程序运行结果
```

### 详细步骤

#### 1. 编写源代码

创建 `.java` 文件，编写 Java 代码：

```java showLineNumbers
// HelloWorld.java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

#### 2. 编译（Compilation）

使用 `javac` 编译器将源代码编译为字节码：

```bash showLineNumbers
javac HelloWorld.java
```

**编译过程**：
- **词法分析**：将源代码分解为标记（tokens）
- **语法分析**：检查语法是否正确
- **语义分析**：检查类型、作用域等
- **代码生成**：生成字节码文件

**结果**：生成 `HelloWorld.class` 文件（字节码）

#### 3. 加载（Loading）

JVM 加载 `.class` 文件：

- **类加载器**：读取字节码文件
- **验证**：检查字节码的正确性
- **准备**：为类变量分配内存
- **解析**：将符号引用转换为直接引用

#### 4. 执行（Execution）

JVM 执行字节码：

- **解释执行**：逐条解释字节码指令
- **JIT 编译**：将热点代码编译为机器码
- **运行**：CPU 执行机器码

## javac 与 java 命令使用

### javac 命令

**作用**：编译 Java 源代码为字节码

#### 基本用法

```bash showLineNumbers
# 编译单个文件
javac HelloWorld.java

# 编译多个文件
javac File1.java File2.java File3.java

# 编译目录下所有文件
javac *.java

# 编译带包的文件
javac com/example/HelloWorld.java
```

#### 常用选项

```bash showLineNumbers
# -d：指定输出目录
javac -d out src/HelloWorld.java

# -cp 或 -classpath：指定类路径
javac -cp lib/*.jar src/HelloWorld.java

# -encoding：指定源文件编码
javac -encoding UTF-8 HelloWorld.java

# -source：指定源代码版本
javac -source 17 HelloWorld.java

# -target：指定目标字节码版本
javac -target 17 HelloWorld.java

# -verbose：显示详细信息
javac -verbose HelloWorld.java
```

#### 编译示例

```bash showLineNumbers
# 示例 1：基本编译
javac HelloWorld.java
# 生成：HelloWorld.class

# 示例 2：指定输出目录
javac -d classes src/HelloWorld.java
# 生成：classes/HelloWorld.class

# 示例 3：编译多个文件
javac -d out src/**/*.java
# 编译 src 目录下所有 .java 文件到 out 目录
```

### java 命令

**作用**：运行编译后的 Java 程序

#### 基本用法

```bash showLineNumbers
# 运行类（无包）
java HelloWorld

# 运行带包的类
java com.example.HelloWorld

# 传递参数
java HelloWorld arg1 arg2
```

#### 常用选项

```bash showLineNumbers
# -cp 或 -classpath：指定类路径
java -cp .:lib/* com.example.HelloWorld

# -Xmx：设置最大堆内存
java -Xmx512m HelloWorld

# -Xms：设置初始堆内存
java -Xms256m HelloWorld

# -version：显示版本信息
java -version

# -verbose：显示详细信息
java -verbose:class HelloWorld

# -D：设置系统属性
java -Dkey=value HelloWorld
```

#### 运行示例

```bash showLineNumbers
# 示例 1：基本运行
java HelloWorld
# 输出：Hello, World!

# 示例 2：传递参数
java HelloWorld hello world
# args[0] = "hello", args[1] = "world"

# 示例 3：指定类路径
java -cp .:lib/*:out com.example.HelloWorld
```

## 类路径（classpath）概念

### 什么是类路径

**类路径（classpath）** 是 JVM 查找类文件的路径。当 JVM 需要加载一个类时，会在类路径中搜索对应的 `.class` 文件。

### 类路径的组成

类路径可以包含：

- **目录**：包含 `.class` 文件的目录
- **JAR 文件**：Java 归档文件
- **ZIP 文件**：压缩文件

### 设置类路径

#### 方法 1：使用 -cp 选项

```bash showLineNumbers
# 单个路径
java -cp /path/to/classes HelloWorld

# 多个路径（Windows 用分号，Linux/macOS 用冒号）
java -cp .:lib/*:out HelloWorld

# Windows 示例
java -cp .;lib\*;out HelloWorld
```

#### 方法 2：使用环境变量

**Windows**：
```bash showLineNumbers
set CLASSPATH=.;lib\*;out
java HelloWorld
```

**Linux/macOS**：
```bash showLineNumbers
export CLASSPATH=.:lib/*:out
java HelloWorld
```

#### 方法 3：使用清单文件（MANIFEST.MF）

在 JAR 文件中设置：

```manifest showLineNumbers
Manifest-Version: 1.0
Class-Path: lib/dependency1.jar lib/dependency2.jar
Main-Class: com.example.HelloWorld
```

### 类路径的查找顺序

JVM 按以下顺序查找类：

1. **Bootstrap 类路径**：JVM 核心类（rt.jar 等）
2. **Extension 类路径**：扩展类
3. **用户类路径**：通过 -cp 或 CLASSPATH 指定的路径

### 类路径示例

#### 示例 1：单文件程序

```bash showLineNumbers
project/
└── HelloWorld.java
```

```bash showLineNumbers
javac HelloWorld.java
java HelloWorld
# 类路径：当前目录（.）
```

#### 示例 2：带包的程序

```bash showLineNumbers
project/
└── src/
    └── com/
        └── example/
            └── HelloWorld.java
```

```bash showLineNumbers
# 编译
javac -d out src/com/example/HelloWorld.java

# 运行（从 out 目录运行）
cd out
java com.example.HelloWorld

# 或指定类路径
java -cp out com.example.HelloWorld
```

#### 示例 3：使用外部库

```bash showLineNumbers
project/
├── src/
│   └── Main.java
├── lib/
│   ├── library1.jar
│   └── library2.jar
└── out/
    └── Main.class
```

```bash showLineNumbers
# 编译
javac -cp lib/* -d out src/Main.java

# 运行
java -cp out:lib/* Main
```

## 常见编译与运行问题

### 编译问题

#### 问题 1：找不到符号（Cannot find symbol）

**错误信息**：
```bash showLineNumbers
error: cannot find symbol
  symbol:   variable x
  location: class HelloWorld
```

**原因**：
- 变量未声明
- 类未导入
- 拼写错误

**解决**：
```java showLineNumbers
// ❌ 错误
public class Test {
    public static void main(String[] args) {
        System.out.println(x);  // x 未声明
    }
}

// ✅ 正确
public class Test {
    public static void main(String[] args) {
        int x = 10;  // 先声明
        System.out.println(x);
    }
}
```

#### 问题 2：类找不到（Class not found）

**错误信息**：
```bash showLineNumbers
error: cannot find symbol
  symbol:   class Scanner
  location: class HelloWorld
```

**原因**：未导入类

**解决**：
```java showLineNumbers
// ❌ 错误
public class Test {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
    }
}

// ✅ 正确
import java.util.Scanner;  // 添加导入

public class Test {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
    }
}
```

#### 问题 3：编码问题

**错误信息**：
```bash showLineNumbers
error: unmappable character for encoding ASCII
```

**原因**：源文件编码与编译器编码不匹配

**解决**：
```bash showLineNumbers
# 指定编码编译
javac -encoding UTF-8 HelloWorld.java
```

### 运行问题

#### 问题 1：找不到或无法加载主类

**错误信息**：
```bash showLineNumbers
Error: Could not find or load main class HelloWorld
```

**原因**：
- 类路径不正确
- 类名拼写错误
- 包名问题

**解决**：
```bash showLineNumbers
# 错误：包含 .class
java HelloWorld.class

# 正确：不包含扩展名
java HelloWorld

# 错误：包名问题
java HelloWorld  # 如果类在包中

# 正确：使用完全限定名
java com.example.HelloWorld
```

#### 问题 2：类路径问题

**错误信息**：
```bash showLineNumbers
Exception in thread "main" java.lang.NoClassDefFoundError: com/example/HelloWorld
```

**原因**：类路径设置不正确

**解决**：
```bash showLineNumbers
# 检查类文件是否存在
ls -R out/

# 使用正确的类路径运行
java -cp out com.example.HelloWorld

# 或进入正确的目录
cd out
java com.example.HelloWorld
```

#### 问题 3：主方法找不到

**错误信息**：
```bash showLineNumbers
Error: Main method not found in class HelloWorld
```

**原因**：
- main 方法签名错误
- main 方法不存在

**解决**：
```java showLineNumbers
// ❌ 错误：缺少 static
public void main(String[] args) { }

// ✅ 正确：完整的 main 方法
public static void main(String[] args) { }
```

### 调试技巧

#### 1. 检查文件结构

```bash showLineNumbers
# 查看文件结构
tree
# 或
find . -name "*.java" -o -name "*.class"
```

#### 2. 使用 -verbose 选项

```bash showLineNumbers
# 编译时显示详细信息
javac -verbose HelloWorld.java

# 运行时显示类加载信息
java -verbose:class HelloWorld
```

#### 3. 检查类文件

```bash showLineNumbers
# 使用 javap 反编译查看类信息
javap HelloWorld
javap -c HelloWorld  # 显示字节码
```

## 实际示例

### 示例 1：单文件程序

```java showLineNumbers
// Calculator.java
public class Calculator {
    public static void main(String[] args) {
        int a = 10;
        int b = 20;
        int sum = a + b;
        System.out.println("和：" + sum);
    }
}
```

**编译和运行**：
```bash showLineNumbers
javac Calculator.java
java Calculator
# 输出：和：30
```

### 示例 2：多文件程序

**文件 1：Student.java**
```java showLineNumbers
package com.example;

public class Student {
    private String name;
    
    public Student(String name) {
        this.name = name;
    }
    
    public void introduce() {
        System.out.println("我是 " + name);
    }
}
```

**文件 2：Main.java**
```java showLineNumbers
package com.example;

public class Main {
    public static void main(String[] args) {
        Student student = new Student("张三");
        student.introduce();
    }
}
```

**编译和运行**：
```bash showLineNumbers
# 编译（需要编译所有依赖的类）
javac com/example/*.java

# 或分别编译
javac com/example/Student.java
javac com/example/Main.java

# 运行
java com.example.Main
# 输出：我是 张三
```

### 示例 3：使用外部库

**项目结构**：
```bash showLineNumbers
project/
├── src/
│   └── Main.java
├── lib/
│   └── commons-lang3-3.12.0.jar
└── out/
```

**Main.java**：
```java showLineNumbers
import org.apache.commons.lang3.StringUtils;

public class Main {
    public static void main(String[] args) {
        String text = "  hello world  ";
        String trimmed = StringUtils.trim(text);
        System.out.println("原文本：[" + text + "]");
        System.out.println("处理后：[" + trimmed + "]");
    }
}
```

**编译和运行**：
```bash showLineNumbers
# 编译（指定类路径）
javac -cp lib/commons-lang3-3.12.0.jar -d out src/Main.java

# 运行（指定类路径）
java -cp out:lib/commons-lang3-3.12.0.jar Main
```

## 小结

Java 编译与运行过程：

- **编译过程**：源代码 → 字节码（javac）
- **运行过程**：字节码 → JVM 执行（java）
- **类路径**：JVM 查找类的路径
- **常见问题**：找不到符号、类路径错误、主方法问题

**关键要点**：
- `javac` 编译源代码为字节码
- `java` 运行字节码
- 类路径告诉 JVM 在哪里找类
- 包名对应目录结构
- 注意编码和路径问题

理解了编译和运行过程，你就能更好地解决开发中的问题。在下一章，我们将开始学习 Java 的语法基础。
