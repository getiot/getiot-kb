---
sidebar_position: 5
slug: /java-packages
sidebar_label: Java 包与 import
---

# Java 包（package）与 import

包（Package）是 Java 中组织类和接口的机制，用于避免命名冲突和管理代码结构。理解包的使用和 import 语句是编写大型 Java 程序的基础。本章将详细介绍包的概念和使用。

## package 的概念与使用

### 什么是包

**包**（Package）是 Java 中用于组织类和接口的命名空间机制。

**作用**：
1. **避免命名冲突**：不同包可以有同名类
2. **组织代码**：将相关类组织在一起
3. **访问控制**：配合访问修饰符控制可见性
4. **便于管理**：大型项目的代码组织

### 包声明

**语法**：`package 包名;`

```java
// 文件：com/example/Student.java
package com.example;

public class Student {
    // ...
}
```

**规则**：
- 必须是文件的第一行有效代码（注释除外）
- 一个文件只能有一个包声明
- 包名通常使用小写字母
- 包名通常对应目录结构

### 包命名规范

**推荐命名方式**：
- 使用反向域名：`com.example.project`
- 全小写字母
- 多个单词用点分隔
- 避免使用 Java 关键字

```java
// ✅ 推荐
package com.example.student;
package org.apache.commons;
package java.util;

// ❌ 不推荐
package Example;      // 应该小写
package com.example.Student;  // 应该小写
package com.example.class;     // 不能使用关键字
```

### 包与目录结构

**包名必须对应目录结构**：

```
项目根目录/
└── src/
    └── com/
        └── example/
            ├── Student.java    (package com.example;)
            ├── Teacher.java   (package com.example;)
            └── util/
                └── Helper.java  (package com.example.util;)
```

**编译和运行**：

```bash
# 编译
javac -d out src/com/example/*.java

# 运行
java -cp out com.example.Student
```

### 默认包

**不声明包时，类属于默认包**：

```java
// 文件：Student.java（无包声明）
public class Student {
    // ...
}
```

**注意**：
- 默认包中的类不能导入
- 不推荐使用默认包
- 生产环境应该使用明确的包名

## import 语句

### 什么是 import

**import** 用于引入其他包的类，简化类名的使用。

### import 的使用

#### 1. 导入单个类

```java
package com.example;

import java.util.ArrayList;  // 导入 ArrayList

public class Student {
    private ArrayList<String> courses;
}
```

#### 2. 导入整个包

```java
package com.example;

import java.util.*;  // 导入 java.util 包下的所有类

public class Student {
    private ArrayList<String> courses;
    private HashMap<String, Integer> scores;
}
```

**注意**：导入整个包不会导入子包。

#### 3. 使用完全限定名

```java
package com.example;

// 不使用 import，直接使用完全限定名
public class Student {
    private java.util.ArrayList<String> courses;
    private java.util.HashMap<String, Integer> scores;
}
```

### import 的位置

```java
package com.example;  // 1. 包声明

import java.util.ArrayList;  // 2. import 语句
import java.util.HashMap;

public class Student {  // 3. 类定义
    // ...
}
```

**顺序**：
1. package 声明
2. import 语句
3. 类定义

### 静态 import（Java 5+）

**静态 import** 用于导入类的静态成员。

```java
// 普通 import
import java.lang.Math;

double result = Math.sqrt(16);  // 需要类名

// 静态 import
import static java.lang.Math.sqrt;
import static java.lang.Math.PI;

double result = sqrt(16);  // 直接使用
double area = PI * 2 * 2;
```

**导入所有静态成员**：

```java
import static java.lang.Math.*;

double result = sqrt(16);
double sin = sin(PI / 2);
```

## 命名冲突处理

### 同名类冲突

**不同包的同名类**：

```java
package com.example;

import java.util.Date;
import java.sql.Date;  // ❌ 编译错误：命名冲突

public class Test {
    Date date;  // 不知道是哪个 Date
}
```

**解决方案 1：使用完全限定名**

```java
package com.example;

public class Test {
    java.util.Date utilDate;
    java.sql.Date sqlDate;
}
```

**解决方案 2：导入一个，另一个用完全限定名**

```java
package com.example;

import java.util.Date;

public class Test {
    Date utilDate;           // java.util.Date
    java.sql.Date sqlDate;   // java.sql.Date
}
```

### 包名冲突

**避免与标准库包名冲突**：

```java
// ❌ 错误：不要使用 java 或 javax 开头的包名
package java.example;  // 可能冲突

// ✅ 正确：使用反向域名
package com.example;
```

### 类名冲突

**同一包内不能有同名类**：

```java
// 文件 1：com/example/Student.java
package com.example;
public class Student { }

// 文件 2：com/example/Student.java
package com.example;
public class Student { }  // ❌ 编译错误：类名冲突
```

## 常用包介绍

#### java.lang

**Java 核心类库**，自动导入。

```java
// 不需要 import
String str = "Hello";
Integer num = 10;
System.out.println("输出");
```

**包含**：String、Integer、System、Object 等。

#### java.util

**工具类库**，最常用的包之一。

```java
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
```

**包含**：集合类、日期时间、随机数等。

#### java.io

**输入输出类库**。

```java
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
```

#### java.net

**网络编程类库**。

```java
import java.net.URL;
import java.net.Socket;
import java.net.ServerSocket;
```

#### java.sql

**数据库操作类库**。

```java
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
```

## 包的最佳实践

### 1. 使用明确的包名

```java
// ✅ 推荐：使用反向域名
package com.example.project.module;

// ❌ 不推荐：使用简单名称
package project;
```

### 2. 避免使用通配符 import

```java
// ❌ 不推荐：导入整个包
import java.util.*;

// ✅ 推荐：明确导入需要的类
import java.util.ArrayList;
import java.util.HashMap;
```

**原因**：
- 代码更清晰
- 避免命名冲突
- IDE 可以优化

### 3. 组织相关类

```java
// 相关类放在同一包
package com.example.model;
// Student.java
// Teacher.java
// Course.java

package com.example.service;
// StudentService.java
// TeacherService.java
```

### 4. 使用有意义的包名

```java
// ✅ 推荐：有意义的包名
package com.example.student.model;
package com.example.student.service;
package com.example.student.dao;

// ❌ 不推荐：无意义的包名
package com.example.a;
package com.example.b;
```

## 实际示例

### 示例 1：完整的包结构

```
项目/
└── src/
    └── com/
        └── example/
            └── school/
                ├── model/
                │   ├── Student.java
                │   └── Teacher.java
                ├── service/
                │   └── StudentService.java
                └── util/
                    └── DateUtil.java
```

**Student.java**：
```java
package com.example.school.model;

public class Student {
    private String name;
    private int age;
    
    // ...
}
```

**StudentService.java**：
```java
package com.example.school.service;

import com.example.school.model.Student;
import java.util.ArrayList;
import java.util.List;

public class StudentService {
    private List<Student> students = new ArrayList<>();
    
    public void addStudent(Student student) {
        students.add(student);
    }
    // ...
}
```

### 示例 2：处理命名冲突

```java
package com.example;

import java.util.Date;
import java.text.SimpleDateFormat;

public class DateExample {
    public void test() {
        // 使用 java.util.Date
        Date utilDate = new Date();
        
        // 使用 java.sql.Date（完全限定名）
        java.sql.Date sqlDate = new java.sql.Date(System.currentTimeMillis());
        
        // 格式化日期
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String formatted = sdf.format(utilDate);
    }
}
```

### 示例 3：静态 import 使用

```java
package com.example;

import static java.lang.Math.*;
import static java.lang.System.out;

public class MathExample {
    public void test() {
        // 直接使用 Math 的静态方法
        double sqrt = sqrt(16);        // 4.0
        double power = pow(2, 3);       // 8.0
        double sin = sin(PI / 2);       // 1.0
        
        // 直接使用 System.out
        out.println("结果：" + sqrt);
    }
}
```

## 小结

Java 包与 import 要点：

- **包的作用**：组织代码、避免冲突、控制访问
- **包声明**：package 语句，对应目录结构
- **import**：导入其他包的类
- **命名冲突**：使用完全限定名解决
- **最佳实践**：明确包名、避免通配符、组织相关类

**关键要点**：
- 包名使用反向域名
- 包名对应目录结构
- import 简化类名使用
- 静态 import 导入静态成员
- 处理命名冲突使用完全限定名

理解了包和 import，你就能组织大型 Java 项目。在下一章，我们将学习 Java 的封装。
