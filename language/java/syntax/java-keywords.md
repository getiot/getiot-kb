---
sidebar_position: 1
slug: /java-keywords
---

# Java 关键字与标识符

在 Java 中，关键字是语言保留的特殊单词，不能用作标识符。标识符是程序员定义的名称，用于标识类、方法、变量等。理解关键字和标识符的规则，是编写正确 Java 代码的基础。

## Java 保留字与关键字

### 什么是关键字

**关键字（Keywords）** 是 Java 语言中具有特殊含义的保留字，不能用作变量名、类名、方法名等标识符。

### Java 关键字列表

#### 访问控制

| 关键字 | 说明 | 备注 |
|:------:|:----|:----|
| `public` | 公共访问修饰符，修饰的类、方法或变量可以被任何类访问，是访问权限最宽松的修饰符 | 最常用的访问修饰符 |
| `private` | 私有访问修饰符，修饰的成员只能在本类内部访问，外部类无法直接访问 | 用于封装，保护内部实现 |
| `protected` | 受保护访问修饰符，修饰的成员可以在本类、同一包中的类以及子类中访问 | 常用于继承场景 |
| `default` | 包私有访问修饰符（默认访问级别），修饰的成员只能在同一包中访问，不需要显式声明 | 隐式，不写任何访问修饰符时默认使用 |

#### 类、方法和变量修饰符

| 关键字 | 说明 | 备注 |
|:------:|:----|:----|
| `class` | 用于定义类，类是 Java 面向对象编程的基本单元，包含属性和方法 | 每个 Java 文件最多只能有一个 public class |
| `interface` | 用于定义接口，接口定义了一组方法的契约，实现类必须实现这些方法 | Java 8+ 支持默认方法和静态方法 |
| `abstract` | 抽象修饰符，可以修饰类和方法。抽象类不能实例化，抽象方法只有声明没有实现 | 用于定义模板和规范 |
| `final` | 最终修饰符，修饰类表示不可继承，修饰方法表示不可重写，修饰变量表示不可修改 | 用于防止继承、重写或修改 |
| `static` | 静态修饰符，修饰的成员属于类而不是实例，可以通过类名直接访问 | 常用于工具方法和常量 |
| `synchronized` | 同步修饰符，用于实现线程同步，确保同一时刻只有一个线程可以访问被修饰的代码块或方法 | 用于多线程编程 |
| `volatile` | 易变修饰符，确保变量的修改对所有线程立即可见，防止指令重排序 | 用于多线程共享变量 |
| `transient` | 瞬态修饰符，修饰的变量在序列化时会被忽略，不会被保存到文件中 | 用于序列化场景 |
| `native` | 本地修饰符，表示方法由本地代码（如 C/C++）实现，通过 JNI 调用 | 用于调用本地库 |

#### 程序控制

| 关键字 | 说明 | 备注 |
|:------:|:----|:----|
| `if` | 条件判断语句，根据布尔表达式的值决定是否执行代码块 | 最常用的条件控制语句 |
| `else` | 与 if 配合使用，当 if 条件为 false 时执行 else 代码块 | 必须与 if 配对使用 |
| `switch` | 多分支选择语句，根据表达式的值选择执行不同的代码分支 | Java 14+ 支持 switch 表达式 |
| `case` | switch 语句中的分支标签，用于匹配 switch 表达式的值 | 每个 case 后通常需要 break |
| `default` | switch 语句中的默认分支，当所有 case 都不匹配时执行 | 可以放在任意位置 |
| `for` | for 循环语句，用于重复执行代码块，包含初始化、条件判断和更新三部分 | 最常用的循环语句 |
| `while` | while 循环语句，当条件为 true 时重复执行代码块 | 先判断条件再执行 |
| `do` | do-while 循环语句，先执行代码块再判断条件，至少执行一次 | 与 while 配合使用 |
| `break` | 跳出语句，用于跳出当前循环或 switch 语句，继续执行后面的代码 | 可以跳出多层循环（带标签） |
| `continue` | 继续语句，跳过当前循环的剩余代码，继续下一次循环迭代 | 只影响当前循环 |
| `return` | 返回语句，用于从方法中返回结果或提前结束方法执行 | void 方法可以省略 return |

#### 异常处理

| 关键字 | 说明 | 备注 |
|:------:|:----|:----|
| `try` | 尝试执行代码块，用于标记可能抛出异常的代码区域 | 必须与 catch 或 finally 配合使用 |
| `catch` | 捕获异常，用于捕获 try 块中抛出的异常并进行处理 | 可以捕获多个异常类型 |
| `finally` | 最终执行块，无论是否发生异常都会执行的代码块，常用于资源清理 | 即使有 return 也会执行 |
| `throw` | 抛出异常，用于在方法中主动抛出异常对象 | 可以抛出检查型或非检查型异常 |
| `throws` | 声明异常，用于在方法签名中声明可能抛出的异常类型，调用者需要处理 | 用于检查型异常 |

#### 面向对象

| 关键字 | 说明 | 备注 |
|:------:|:----|:----|
| `extends` | 继承关键字，用于类继承另一个类，子类可以继承父类的属性和方法 | Java 只支持单继承 |
| `implements` | 实现关键字，用于类实现接口，实现类必须实现接口中定义的所有抽象方法 | 一个类可以实现多个接口 |
| `this` | 当前对象引用，指向当前类的实例，用于区分成员变量和局部变量，或调用其他构造方法 | 在实例方法中使用 |
| `super` | 父类引用，指向父类的实例，用于访问父类的成员变量、方法和构造方法 | 用于继承场景 |
| `new` | 创建对象关键字，用于实例化类，在堆内存中分配空间并调用构造方法创建对象 | 对象创建的基本方式 |
| `instanceof` | 类型判断运算符，用于判断对象是否是某个类或其子类的实例，返回布尔值 | 用于类型检查和类型转换 |

#### 数据类型

| 关键字 | 说明 | 备注 |
|:------:|:----|:----|
| `byte` | 字节型，8 位有符号整数，取值范围 -128 到 127 | 占用 1 字节内存 |
| `short` | 短整型，16 位有符号整数，取值范围 -32,768 到 32,767 | 占用 2 字节内存 |
| `int` | 整型，32 位有符号整数，取值范围 -2³¹ 到 2³¹-1 | 最常用的整数类型，占用 4 字节 |
| `long` | 长整型，64 位有符号整数，取值范围 -2⁶³ 到 2⁶³-1 | 占用 8 字节内存，字面量需要加 L |
| `float` | 单精度浮点型，32 位 IEEE 754 浮点数，精度约 7 位小数 | 占用 4 字节内存，字面量需要加 f |
| `double` | 双精度浮点型，64 位 IEEE 754 浮点数，精度约 15 位小数 | 默认浮点类型，占用 8 字节 |
| `char` | 字符型，16 位 Unicode 字符，取值范围 0 到 65,535 | 占用 2 字节内存，使用单引号 |
| `boolean` | 布尔型，表示真值，只有 true 和 false 两个值 | 占用空间取决于 JVM 实现 |
| `void` | 无返回值类型，用于方法声明，表示方法不返回任何值 | 只能用于方法返回类型 |

#### 其他

| 关键字 | 说明 | 备注 |
|:------:|:----|:----|
| `package` | 包声明关键字，用于声明类所属的包，组织和管理类文件 | 必须是文件的第一条语句（注释除外） |
| `import` | 导入关键字，用于导入其他包中的类、接口等，使代码可以使用短名称引用 | 可以导入单个类或整个包 |
| `enum` | 枚举关键字，用于定义枚举类型，枚举是一组固定的常量值 | Java 5+ 引入，是特殊的类 |
| `assert` | 断言关键字，用于在代码中添加断言，用于调试和测试，断言失败会抛出 AssertionError | 默认情况下断言被禁用，需要 -ea 参数启用 |
| `const` | 保留字，在 Java 中未使用，不能用作标识符 | 保留给未来使用，目前使用 final 代替 |
| `goto` | 保留字，在 Java 中未使用，不能用作标识符 | 保留给未来使用，Java 不支持 goto 语句 |

### 关键字使用示例

```java
// 类定义
public class Student {
    // 变量修饰符
    private String name;
    private static int count;
    private final int id;
    
    // 构造方法
    public Student(String name, int id) {
        this.name = name;
        this.id = id;
        count++;
    }
    
    // 方法
    public void study() {
        if (name != null) {
            System.out.println(name + " is studying");
        }
    }
    
    // 静态方法
    public static int getCount() {
        return count;
    }
}
```

## 合法标识符命名规则

### 什么是标识符

**标识符（Identifier）** 是程序员定义的名称，用于标识：
- 类名
- 方法名
- 变量名
- 包名
- 接口名
- 常量名

### 命名规则

#### 1. 基本规则

- **必须以字母、下划线（_）或美元符号（$）开头**
- **后续字符可以是字母、数字、下划线或美元符号**
- **不能是关键字或保留字**
- **区分大小写**
- **没有长度限制**（但建议合理长度）

#### 2. 合法标识符示例

```java
// ✅ 合法
String name;
int age;
double _price;
String $value;
int studentCount;
String firstName;
int MAX_SIZE;
String user_name;
```

#### 3. 非法标识符示例

```java
// ❌ 非法：以数字开头
int 2name;

// ❌ 非法：包含特殊字符
String user-name;
int user@id;

// ❌ 非法：是关键字
int class;
String public;

// ❌ 非法：包含空格
String user name;
```

### 标识符分类

#### 1. 类名和接口名

**规范**：大驼峰命名（PascalCase）

```java
// ✅ 正确
public class StudentManager { }
public class UserService { }
public interface Runnable { }
public interface Comparable { }

// ❌ 错误
public class studentManager { }  // 应该首字母大写
public class user_service { }    // 应该使用驼峰命名
```

#### 2. 方法名和变量名

**规范**：小驼峰命名（camelCase）

```java
// ✅ 正确
public void getUserName() { }
public void calculateTotal() { }
int studentCount = 10;
String firstName = "John";

// ❌ 错误
public void GetUserName() { }  // 应该首字母小写
int student_count = 10;        // 应该使用驼峰命名
```

#### 3. 常量名

**规范**：全大写下划线分隔（UPPER_SNAKE_CASE）

```java
// ✅ 正确
public static final int MAX_SIZE = 100;
public static final String DEFAULT_NAME = "Unknown";
public static final double PI = 3.14159;

// ❌ 错误
public static final int maxSize = 100;      // 应该全大写
public static final String defaultName = "Unknown";  // 应该全大写
```

#### 4. 包名

**规范**：全小写，点分隔

```java
// ✅ 正确
package com.example.project;
package org.apache.commons;

// ❌ 错误
package com.Example.Project;  // 应该全小写
package COM.EXAMPLE;           // 应该全小写
```

## 命名规范与常用约定

### Java 命名约定总结

| 类型 | 命名规范 | 示例 |
|------|---------|------|
| 类名 | 大驼峰（PascalCase） | `StudentManager` |
| 接口名 | 大驼峰（PascalCase） | `Runnable` |
| 方法名 | 小驼峰（camelCase） | `getUserName()` |
| 变量名 | 小驼峰（camelCase） | `studentCount` |
| 常量名 | 全大写下划线（UPPER_SNAKE_CASE） | `MAX_SIZE` |
| 包名 | 全小写，点分隔 | `com.example.project` |
| 参数名 | 小驼峰（camelCase） | `userName` |
| 局部变量 | 小驼峰（camelCase） | `tempValue` |

### 命名最佳实践

#### 1. 使用有意义的名称

```java
// ✅ 好：名称清晰表达含义
int studentCount;
String userName;
public void calculateTotalPrice() { }

// ❌ 差：名称不清晰
int x;
String s;
public void calc() { }
```

#### 2. 避免缩写（除非是通用缩写）

```java
// ✅ 好：清晰完整
String userName;
int studentCount;

// ⚠️ 可接受：通用缩写
String id;  // ID 是通用缩写
String url; // URL 是通用缩写

// ❌ 差：不清晰的缩写
String usrNm;
int stdCnt;
```

#### 3. 布尔变量使用 is/has/can 前缀

```java
// ✅ 好：布尔变量命名
boolean isActive;
boolean hasPermission;
boolean canEdit;
boolean isEmpty;

// ❌ 差：不够清晰
boolean active;
boolean permission;
```

#### 4. 集合使用复数形式

```java
// ✅ 好：集合使用复数
List<Student> students;
Map<String, User> users;
Set<String> names;

// ❌ 差：单数形式
List<Student> student;
```

#### 5. 方法名使用动词

```java
// ✅ 好：方法名是动词
public void calculateTotal() { }
public String getUserName() { }
public boolean isValid() { }

// ❌ 差：方法名是名词
public void total() { }
public String userName() { }
```

### 常见命名模式

#### Getter 和 Setter 方法

```java
public class Student {
    private String name;
    private int age;
    
    // Getter：get + 属性名（首字母大写）
    public String getName() {
        return name;
    }
    
    // Setter：set + 属性名（首字母大写）
    public void setName(String name) {
        this.name = name;
    }
    
    // 布尔类型使用 is 前缀
    private boolean active;
    
    public boolean isActive() {
        return active;
    }
}
```

#### 构造方法

```java
// 构造方法名与类名相同
public class Student {
    public Student() { }  // 无参构造
    public Student(String name) { }  // 有参构造
}
```

#### 常量

```java
public class Constants {
    // 公共常量
    public static final int MAX_SIZE = 100;
    public static final String DEFAULT_NAME = "Unknown";
    
    // 私有常量
    private static final int INTERNAL_VALUE = 50;
}
```

## 实际示例

### 示例 1：完整的类定义

```java
package com.example.model;

// 类名：大驼峰
public class StudentManager {
    // 常量：全大写下划线
    private static final int MAX_STUDENTS = 100;
    
    // 静态变量：小驼峰
    private static int studentCount = 0;
    
    // 实例变量：小驼峰
    private String managerName;
    private List<Student> students;
    
    // 构造方法：与类名相同
    public StudentManager(String managerName) {
        this.managerName = managerName;
        this.students = new ArrayList<>();
    }
    
    // 方法名：小驼峰，动词开头
    public void addStudent(Student student) {
        if (students.size() < MAX_STUDENTS) {
            students.add(student);
            studentCount++;
        }
    }
    
    // Getter：get + 属性名
    public String getManagerName() {
        return managerName;
    }
    
    // 布尔方法：is + 属性名
    public boolean isEmpty() {
        return students.isEmpty();
    }
}
```

### 示例 2：接口定义

```java
// 接口名：大驼峰，通常以 -able 或 I- 开头（可选）
public interface Runnable {
    // 方法名：小驼峰
    void run();
}

public interface Comparable<T> {
    int compareTo(T other);
}
```

### 示例 3：枚举定义

```java
// 枚举名：大驼峰
public enum Status {
    // 枚举值：全大写下划线
    ACTIVE,
    INACTIVE,
    PENDING
}
```

## 小结

Java 关键字与标识符要点：

- **关键字**：语言保留的特殊单词，不能用作标识符
- **标识符规则**：字母/下划线/$ 开头，后续可以是字母/数字/下划线/$
- **命名规范**：类名大驼峰、方法变量小驼峰、常量全大写
- **最佳实践**：有意义、清晰、遵循约定

**关键规则**：
- 不能使用关键字作为标识符
- 标识符区分大小写
- 遵循命名规范提高代码可读性
- 使用有意义的名称

掌握了关键字和标识符的规则，你就能编写规范的 Java 代码。在下一章，我们将学习 Java 的数据类型。
