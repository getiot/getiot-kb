---
sidebar_position: 5
slug: /java-hello-world
sidebar_label: 第一个 Java 程序
---

# 第一个 Java 程序（Hello World）

"Hello World" 是学习任何编程语言的第一个程序。它虽然简单，但包含了 Java 程序的基本要素。通过这个程序，你将学会如何编写、编译和运行 Java 程序。

## Hello World 示例代码

### 最简单的版本

```java showLineNumbers
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

### 代码解释

让我们逐行分析这段代码：

```java showLineNumbers
// 第 1 行：定义一个公共类，类名为 HelloWorld
public class HelloWorld {
    
    // 第 2 行：定义主方法，这是程序的入口点
    public static void main(String[] args) {
        
        // 第 3 行：输出 "Hello, World!" 到控制台
        System.out.println("Hello, World!");
    }
}
```

**关键点**：
- `public class HelloWorld`：类名必须与文件名相同（HelloWorld.java）
- `public static void main(String[] args)`：程序入口，JVM 从这里开始执行
- `System.out.println()`：输出语句，打印内容并换行

## println 与输出基础

### System.out.println()

**作用**：输出内容到控制台，并在末尾换行

```java showLineNumbers
System.out.println("Hello, World!");
// 输出：Hello, World!
// （自动换行）
```

### 其他输出方法

#### System.out.print()

**作用**：输出内容但不换行

```java showLineNumbers
System.out.print("Hello");
System.out.print("World");
// 输出：HelloWorld（不换行）
```

#### System.out.printf()

**作用**：格式化输出（类似 C 语言的 printf）

```java showLineNumbers
String name = "Java";
int version = 17;
System.out.printf("语言：%s，版本：%d%n", name, version);
// 输出：语言：Java，版本：17

// 常用格式说明符：
// %s：字符串
// %d：整数
// %f：浮点数
// %n：换行
```

### 输出示例

```java showLineNumbers
public class OutputExample {
    public static void main(String[] args) {
        // println：换行输出
        System.out.println("第一行");
        System.out.println("第二行");
        
        // print：不换行
        System.out.print("Hello");
        System.out.print(" ");
        System.out.print("World");
        System.out.println(); // 手动换行
        
        // printf：格式化输出
        int age = 20;
        String name = "张三";
        System.out.printf("姓名：%s，年龄：%d 岁%n", name, age);
        
        // 输出多个值
        System.out.println("姓名：" + name + "，年龄：" + age + " 岁");
    }
}
```

**输出结果**：
```bash showLineNumbers
第一行
第二行
Hello World
姓名：张三，年龄：20 岁
姓名：张三，年龄：20 岁
```

## main 方法详解

### main 方法的完整签名

```java showLineNumbers
public static void main(String[] args)
```

### 各部分说明

#### public

- **含义**：公共访问修饰符
- **作用**：允许 JVM 从类外部调用这个方法
- **必须性**：必须，否则 JVM 无法访问

#### static

- **含义**：静态方法
- **作用**：属于类而不是实例，可以直接通过类名调用
- **必须性**：必须，因为程序启动时还没有创建对象

```java showLineNumbers
// 为什么需要 static？
// 因为 JVM 调用 main 方法时，还没有创建任何对象
// 所以 main 方法必须是静态的，可以直接通过类名调用
HelloWorld.main(args); // 不需要创建 HelloWorld 对象
```

#### void

- **含义**：无返回值
- **作用**：main 方法不需要返回值
- **必须性**：必须，JVM 不期望 main 方法返回值

#### main

- **含义**：方法名
- **作用**：JVM 查找的固定方法名
- **必须性**：必须，这是约定

#### String[] args

- **含义**：字符串数组参数
- **作用**：接收命令行参数
- **必须性**：必须，即使不使用参数

### main 方法的使用

#### 不使用参数

```java showLineNumbers
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        // args 参数未使用，但必须声明
    }
}
```

#### 使用命令行参数

```java showLineNumbers
public class ArgsExample {
    public static void main(String[] args) {
        // 检查是否有参数
        if (args.length == 0) {
            System.out.println("没有提供参数");
        } else {
            System.out.println("参数个数：" + args.length);
            for (int i = 0; i < args.length; i++) {
                System.out.println("参数 " + i + ": " + args[i]);
            }
        }
    }
}
```

**运行**：
```bash showLineNumbers
java ArgsExample hello world java
# 输出：
# 参数个数：3
# 参数 0: hello
# 参数 1: world
# 参数 2: java
```

## 编译与运行示例

### 步骤 1：创建源文件

创建文件 `HelloWorld.java`：

```java showLineNumbers
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

**重要**：文件名必须与类名完全相同（包括大小写）

### 步骤 2：编译

打开终端/命令行，进入文件所在目录：

```bash showLineNumbers
# 编译
javac HelloWorld.java

# 如果成功，会生成 HelloWorld.class 文件
```

**编译结果**：
- 成功：生成 `.class` 文件，无输出
- 失败：显示错误信息

### 步骤 3：运行

```bash showLineNumbers
# 运行（注意：不需要 .class 扩展名）
java HelloWorld

# 输出：Hello, World!
```

### 完整示例

#### 示例 1：基础 Hello World

```java showLineNumbers
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

**编译和运行**：
```bash showLineNumbers
javac HelloWorld.java
java HelloWorld
# 输出：Hello, World!
```

#### 示例 2：带参数的 Hello World

```java showLineNumbers
public class Hello {
    public static void main(String[] args) {
        if (args.length > 0) {
            System.out.println("Hello, " + args[0] + "!");
        } else {
            System.out.println("Hello, World!");
        }
    }
}
```

**运行**：
```bash showLineNumbers
javac Hello.java
java Hello
# 输出：Hello, World!

java Hello Java
# 输出：Hello, Java!
```

#### 示例 3：多行输出

```java showLineNumbers
public class MultiLine {
    public static void main(String[] args) {
        System.out.println("欢迎学习 Java！");
        System.out.println("这是你的第一个程序");
        System.out.println("继续加油！");
    }
}
```

**输出**：
```bash showLineNumbers
欢迎学习 Java！
这是你的第一个程序
继续加油！
```

### 常见错误

#### 错误 1：类名与文件名不匹配

```java showLineNumbers
// 文件：Hello.java
public class HelloWorld {  // 错误：类名与文件名不匹配
    public static void main(String[] args) {
        System.out.println("Hello");
    }
}
```

**解决**：文件名改为 `HelloWorld.java` 或类名改为 `Hello`

#### 错误 2：缺少 main 方法

```java showLineNumbers
public class HelloWorld {
    // 错误：缺少 main 方法
    public void sayHello() {
        System.out.println("Hello");
    }
}
```

**解决**：添加 `public static void main(String[] args)` 方法

#### 错误 3：main 方法签名错误

```java showLineNumbers
public class HelloWorld {
    // 错误：main 方法签名不正确
    public void main(String[] args) {
        System.out.println("Hello");
    }
}
```

**解决**：添加 `static` 关键字

#### 错误 4：运行类时包含 .class

```bash showLineNumbers
# 错误
java HelloWorld.class

# 正确
java HelloWorld
```

## 使用 IDE 运行

### IntelliJ IDEA

1. **创建项目**：
   
   - File → New → Project
   - 选择 Java
   - 选择 JDK
   - 创建项目
   
2. **创建类**：
   - 右键 src 目录 → New → Java Class
   - 输入类名：HelloWorld
   - 选择 "Class"

3. **编写代码**：
   ```java showLineNumbers
   public class HelloWorld {
       public static void main(String[] args) {
           System.out.println("Hello, World!");
       }
   }
   ```

4. **运行**：
   - 点击 main 方法旁边的绿色三角形
   - 或右键 → Run 'HelloWorld.main()'
   - 或使用快捷键（Ctrl+Shift+F10 / Cmd+Shift+R）

### Eclipse

1. **创建项目**：
   - File → New → Java Project
   - 输入项目名
   - 完成

2. **创建类**：
   - 右键 src → New → Class
   - 输入类名
   - 勾选 "public static void main(String[] args)"
   - 完成

3. **运行**：
   - 右键类文件 → Run As → Java Application
   - 或点击运行按钮

## 小结

第一个 Java 程序要点：

- **基本结构**：类定义 + main 方法 + 输出语句
- **输出方法**：`System.out.println()`、`print()`、`printf()`
- **main 方法**：程序入口，固定签名
- **编译运行**：`javac` 编译，`java` 运行
- **常见错误**：类名文件名不匹配、缺少 main、方法签名错误

**关键步骤**：
1. 创建 `.java` 文件
2. 编写类和方法
3. 使用 `javac` 编译
4. 使用 `java` 运行

恭喜你完成了第一个 Java 程序！在下一章，我们将深入了解 Java 的编译和运行过程。
