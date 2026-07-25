---
sidebar_position: 1
slug: /java-exceptions
sidebar_label: Java 异常体系
---

# Java 异常体系与异常处理

异常处理是 Java 程序健壮性的重要保障。理解异常体系和处理机制是编写可靠程序的基础。本章将详细介绍 Java 中的异常处理。

## 异常概念（检查型异常 vs 非检查型异常）

### 什么是异常

**异常**（Exception）是程序运行时发生的错误或意外情况。

```java
// 常见的异常情况
int[] arr = new int[5];
int value = arr[10];  // ArrayIndexOutOfBoundsException

String str = null;
int length = str.length();  // NullPointerException

int result = 10 / 0;  // ArithmeticException
```

### 异常的分类

Java 异常分为两大类：

1. **检查型异常（Checked Exception）**：必须处理的异常
2. **非检查型异常（Unchecked Exception）**：可以不处理的异常

### 异常类层次结构

```
Throwable
├── Error（错误，非检查型）
│   ├── OutOfMemoryError
│   ├── StackOverflowError
│   └── ...
└── Exception（异常）
    ├── RuntimeException（运行时异常，非检查型）
    │   ├── NullPointerException
    │   ├── ArrayIndexOutOfBoundsException
    │   ├── IllegalArgumentException
    │   └── ...
    └── 其他 Exception（检查型异常）
        ├── IOException
        ├── SQLException
        └── ...
```

### 检查型异常

**检查型异常**（Checked Exception）是编译时必须处理的异常，如果不处理，代码无法编译通过。

```java
// 检查型异常示例
import java.io.FileReader;
import java.io.IOException;

public void readFile() {
    // ❌ 编译错误：必须处理 IOException
    // FileReader reader = new FileReader("file.txt");
    
    // ✅ 正确：使用 try-catch 处理
    try {
        FileReader reader = new FileReader("file.txt");
        reader.close();
    } catch (IOException e) {
        e.printStackTrace();
    }
    
    // ✅ 正确：使用 throws 声明
    // public void readFile() throws IOException { }
}
```

**常见的检查型异常**：
- `IOException`：输入输出异常
- `SQLException`：数据库异常
- `ClassNotFoundException`：类未找到异常

### 非检查型异常

**非检查型异常**（Unchecked Exception）是运行时异常，编译时不强制处理。

```java
// 非检查型异常示例
public void method() {
    // 可以不处理，但运行时可能抛出异常
    int[] arr = new int[5];
    int value = arr[10];  // ArrayIndexOutOfBoundsException
    
    String str = null;
    int length = str.length();  // NullPointerException
}
```

**常见的非检查型异常**：
- `NullPointerException`：空指针异常
- `ArrayIndexOutOfBoundsException`：数组越界异常
- `IllegalArgumentException`：非法参数异常
- `ArithmeticException`：算术异常

## try-catch-finally 语句结构

### 基本语法

```java
try {
    // 可能抛出异常的代码
} catch (ExceptionType e) {
    // 处理异常
} finally {
    // 无论是否发生异常都会执行
}
```

### try-catch

```java
try {
    int[] arr = new int[5];
    int value = arr[10];  // 可能抛出异常
} catch (ArrayIndexOutOfBoundsException e) {
    System.out.println("数组越界：" + e.getMessage());
    e.printStackTrace();  // 打印异常堆栈
}
```

### finally 块

**finally 块中的代码无论是否发生异常都会执行**：

```java
FileReader reader = null;
try {
    reader = new FileReader("file.txt");
    // 读取文件
} catch (IOException e) {
    e.printStackTrace();
} finally {
    // 无论是否发生异常，都会执行
    if (reader != null) {
        try {
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

**try-with-resources（Java 7+）**：自动关闭资源

```java
// 自动关闭资源
try (FileReader reader = new FileReader("file.txt")) {
    // 使用 reader
} catch (IOException e) {
    e.printStackTrace();
}
// reader 自动关闭，不需要 finally
```

## 多个 catch 捕获

### 捕获多个异常

```java
try {
    // 可能抛出多种异常
    int[] arr = new int[5];
    int value = arr[10];
    String str = null;
    int length = str.length();
} catch (ArrayIndexOutOfBoundsException e) {
    System.out.println("数组越界");
} catch (NullPointerException e) {
    System.out.println("空指针异常");
} catch (Exception e) {
    System.out.println("其他异常：" + e.getMessage());
}
```

### 捕获顺序

**子类异常必须在父类异常之前**：

```java
try {
    // ...
} catch (NullPointerException e) {  // 子类
    // 处理空指针异常
} catch (Exception e) {  // 父类
    // 处理其他异常
}

// ❌ 错误：父类在前
// } catch (Exception e) { }
// } catch (NullPointerException e) { }  // 编译错误
```

### 多异常捕获（Java 7+）

**一个 catch 块可以捕获多种异常**：

```java
try {
    // ...
} catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
    System.out.println("空指针或数组越界异常");
} catch (Exception e) {
    System.out.println("其他异常");
}
```

## throw 与 throws 关键字

#### throw

**`throw` 用于抛出异常**：

```java
public void method() {
    if (condition) {
        throw new IllegalArgumentException("参数无效");
    }
}

// 抛出检查型异常
public void readFile() throws IOException {
    if (!file.exists()) {
        throw new IOException("文件不存在");
    }
}
```

#### throws

**`throws` 用于声明方法可能抛出的异常**：

```java
// 声明可能抛出检查型异常
public void readFile() throws IOException {
    FileReader reader = new FileReader("file.txt");
    // ...
}

// 声明可能抛出多个异常
public void method() throws IOException, SQLException {
    // ...
}
```

#### throw vs throws

| 关键字 | 作用 | 位置 | 示例 |
|:------:|:----:|:----:|:----:|
| throw | 抛出异常 | 方法体内 | `throw new Exception();` |
| throws | 声明异常 | 方法签名 | `public void m() throws Exception` |

## 自定义异常类

### 创建自定义异常

**继承 Exception 或 RuntimeException**：

```java
// 自定义检查型异常
public class CustomException extends Exception {
    public CustomException(String message) {
        super(message);
    }
    
    public CustomException(String message, Throwable cause) {
        super(message, cause);
    }
}

// 自定义非检查型异常
public class CustomRuntimeException extends RuntimeException {
    public CustomRuntimeException(String message) {
        super(message);
    }
}
```

### 使用自定义异常

```java
public class BankAccount {
    private double balance;
    
    public void withdraw(double amount) throws InsufficientFundsException {
        if (amount > balance) {
            throw new InsufficientFundsException("余额不足，当前余额：" + balance);
        }
        balance -= amount;
    }
}

// 自定义异常
public class InsufficientFundsException extends Exception {
    public InsufficientFundsException(String message) {
        super(message);
    }
}

// 使用
try {
    account.withdraw(1000);
} catch (InsufficientFundsException e) {
    System.out.println("取款失败：" + e.getMessage());
}
```

## 异常链

**异常链**（Exception Chaining）是将原始异常作为新异常的原因，保留完整的异常信息。

```java
try {
    // 可能抛出异常的操作
} catch (IOException e) {
    // 包装为更高级的异常
    throw new CustomException("文件操作失败", e);
}
```

异常链示例：

```java
public class DatabaseException extends Exception {
    public DatabaseException(String message, Throwable cause) {
        super(message, cause);  // 保留原始异常
    }
}

public class DataAccess {
    public void connect() throws DatabaseException {
        try {
            // 数据库连接操作
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            // 包装为更高级的异常
            throw new DatabaseException("数据库驱动未找到", e);
        }
    }
}

// 使用
try {
    dataAccess.connect();
} catch (DatabaseException e) {
    System.out.println("异常：" + e.getMessage());
    // 获取原始异常
    Throwable cause = e.getCause();
    if (cause != null) {
        System.out.println("原因：" + cause.getMessage());
    }
}
```

## 异常处理最佳实践

### 1. 具体异常类型

```java
// ✅ 推荐：捕获具体异常
try {
    // ...
} catch (FileNotFoundException e) {
    // 处理文件未找到
} catch (IOException e) {
    // 处理其他 IO 异常
}

// ❌ 不推荐：捕获通用异常
// } catch (Exception e) { }
```

### 2. 不要忽略异常

```java
// ❌ 不推荐：忽略异常
try {
    // ...
} catch (Exception e) {
    // 什么都不做
}

// ✅ 推荐：至少记录异常
try {
    // ...
} catch (Exception e) {
    e.printStackTrace();  // 至少打印堆栈
    // 或记录日志
    logger.error("发生异常", e);
}
```

### 3. 使用 try-with-resources

```java
// ✅ 推荐：自动关闭资源
try (FileReader reader = new FileReader("file.txt")) {
    // 使用资源
}

// ❌ 不推荐：手动关闭
// FileReader reader = new FileReader("file.txt");
// try {
//     // ...
// } finally {
//     reader.close();
// }
```

### 4. 异常信息要清晰

```java
// ✅ 推荐：提供清晰的异常信息
throw new IllegalArgumentException("年龄必须在 0-150 之间，当前值：" + age);

// ❌ 不推荐：异常信息不清晰
// throw new IllegalArgumentException("参数无效");
```

## 实际示例

### 示例 1：完整的异常处理

```java
public class FileProcessor {
    public void processFile(String filename) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }
        } catch (FileNotFoundException e) {
            System.err.println("文件未找到：" + filename);
        } catch (IOException e) {
            System.err.println("读取文件时发生错误：" + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("发生未知错误：" + e.getMessage());
        }
    }
}
```

### 示例 2：自定义异常

```java
// 自定义异常
public class ValidationException extends Exception {
    private String field;
    private Object value;
    
    public ValidationException(String field, Object value, String message) {
        super(message);
        this.field = field;
        this.value = value;
    }
    
    public String getField() {
        return field;
    }
    
    public Object getValue() {
        return value;
    }
}

// 使用
public class UserValidator {
    public void validate(User user) throws ValidationException {
        if (user.getAge() < 0 || user.getAge() > 150) {
            throw new ValidationException("age", user.getAge(), "年龄必须在 0-150 之间");
        }
        
        if (user.getEmail() == null || !user.getEmail().contains("@")) {
            throw new ValidationException("email", user.getEmail(), "邮箱格式无效");
        }
    }
}
```

### 示例 3：异常链

```java
public class DataService {
    public void saveData(String data) throws DataServiceException {
        try {
            // 数据库操作
            database.save(data);
        } catch (SQLException e) {
            throw new DataServiceException("保存数据失败", e);
        } catch (IOException e) {
            throw new DataServiceException("IO 操作失败", e);
        }
    }
}

// 自定义异常
public class DataServiceException extends Exception {
    public DataServiceException(String message, Throwable cause) {
        super(message, cause);
    }
}

// 使用
try {
    dataService.saveData("数据");
} catch (DataServiceException e) {
    System.out.println("异常：" + e.getMessage());
    Throwable cause = e.getCause();
    if (cause instanceof SQLException) {
        System.out.println("数据库异常：" + cause.getMessage());
    }
}
```

## 小结

Java 异常体系要点：

- **异常分类**：检查型异常和非检查型异常
- **异常处理**：try-catch-finally 语句
- **异常抛出**：throw 抛出异常，throws 声明异常
- **自定义异常**：继承 Exception 或 RuntimeException
- **异常链**：保留原始异常信息

**关键要点**：
- 检查型异常必须处理
- 非检查型异常可以不处理
- 使用 try-with-resources 自动关闭资源
- 捕获具体异常类型
- 不要忽略异常
- 异常信息要清晰

理解了异常处理，你就能编写更健壮的程序。在下一章，我们将学习 Java 的常用工具类。
