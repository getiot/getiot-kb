---
sidebar_position: 15
slug: /java-annotation
sidebar_label: Java 注解
---

# Java 注解（Annotation）

注解是 Java 5 引入的元数据机制，用于为程序元素提供附加信息。理解注解的使用是掌握现代 Java 开发的关键。本章将详细介绍 Java 中的注解。

## 注解的概念

### 什么是注解

**注解**（Annotation）是一种元数据，用于为代码提供附加信息，不影响程序的执行。

```java
// 使用注解
@Override
public void method() {
    // ...
}

@Deprecated
public void oldMethod() {
    // ...
}
```

### 注解的作用

1. **编译时处理**：提供信息给编译器
2. **运行时处理**：通过反射获取注解信息
3. **代码生成**：工具可以根据注解生成代码
4. **文档生成**：生成 API 文档

## 内置注解

### @Override

**标识方法重写父类方法**：

```java
public class Animal {
    public void makeSound() {
        System.out.println("动物发出声音");
    }
}

public class Dog extends Animal {
    @Override  // 标识重写
    public void makeSound() {
        System.out.println("汪汪汪");
    }
}
```

**好处**：
- 编译器检查重写是否正确
- 如果父类方法签名改变，会提示错误

### @Deprecated

**标识已过时的方法或类**：

```java
@Deprecated
public class OldClass {
    @Deprecated
    public void oldMethod() {
        System.out.println("过时的方法");
    }
}

// 使用时会提示警告
OldClass obj = new OldClass();
obj.oldMethod();  // 编译器会提示警告
```

### @SuppressWarnings

**抑制编译器警告**：

```java
@SuppressWarnings("unchecked")
public void method() {
    List list = new ArrayList();  // 抑制未检查警告
}

@SuppressWarnings({"unchecked", "deprecation"})
public void method2() {
    // 抑制多个警告
}
```

### @SafeVarargs

**标识方法使用可变参数是安全的**：

```java
@SafeVarargs
public static <T> void method(T... args) {
    // ...
}
```

### @FunctionalInterface

**标识函数式接口（Java 8+）**：

```java
@FunctionalInterface
public interface Calculator {
    int calculate(int a, int b);
    
    // 只能有一个抽象方法
    // int anotherMethod();  // ❌ 错误：函数式接口只能有一个抽象方法
}
```

## 元注解

**元注解**是用于定义注解的注解。

### @Target

**指定注解可以应用的位置**：

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Target;

@Target({ElementType.METHOD, ElementType.TYPE})
public @interface MyAnnotation {
}

// 可以使用在方法和类上
@MyAnnotation
public class MyClass {
    @MyAnnotation
    public void method() { }
}
```

**ElementType 值**：
- `TYPE`：类、接口、枚举
- `FIELD`：字段
- `METHOD`：方法
- `PARAMETER`：参数
- `CONSTRUCTOR`：构造方法
- `LOCAL_VARIABLE`：局部变量
- `ANNOTATION_TYPE`：注解
- `PACKAGE`：包

### @Retention

**指定注解的保留策略**：

```java
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface MyAnnotation {
}
```

**RetentionPolicy 值**：
- `SOURCE`：只在源代码中，编译后丢弃
- `CLASS`：编译到 .class 文件，运行时不可用（默认）
- `RUNTIME`：运行时可用，可以通过反射获取

### @Documented

**注解信息包含在 JavaDoc 中**：

```java
import java.lang.annotation.Documented;

@Documented
public @interface MyAnnotation {
}
```

### @Inherited

**注解可以被子类继承**：

```java
import java.lang.annotation.Inherited;

@Inherited
public @interface MyAnnotation {
}

@MyAnnotation
public class Parent { }

public class Child extends Parent {
    // Child 也继承了 @MyAnnotation
}
```

### @Repeatable

**注解可以重复使用（Java 8+）**：

```java
import java.lang.annotation.Repeatable;

@Repeatable(Roles.class)
public @interface Role {
    String value();
}

public @interface Roles {
    Role[] value();
}

// 可以重复使用
@Role("管理员")
@Role("用户")
public class User {
}
```

## 自定义注解

### 定义注解

**使用 `@interface` 关键字定义注解**：

```java
public @interface MyAnnotation {
    String value();  // 注解元素
    int count() default 1;  // 带默认值
}

// 使用
@MyAnnotation(value = "测试", count = 2)
public class MyClass {
}
```

### 注解元素

**注解可以有多个元素**：

```java
public @interface Author {
    String name();
    String email();
    int year() default 2024;
}

// 使用
@Author(name = "张三", email = "zhangsan@example.com", year = 2023)
public class Book {
}
```

### 单值注解

**如果注解只有一个元素，可以命名为 value**：

```java
public @interface Version {
    String value();  // 命名为 value
}

// 使用：可以省略 value =
@Version("1.0")
public class MyClass {
}

// 也可以显式写
@Version(value = "1.0")
public class MyClass2 {
}
```

## 注解的使用场景

### 1. 框架配置

```java
// Spring 框架示例
@Component
public class UserService {
    @Autowired
    private UserRepository userRepository;
    
    @Transactional
    public void saveUser(User user) {
        userRepository.save(user);
    }
}
```

### 2. 数据验证

```java
public class User {
    @NotNull
    @Size(min = 3, max = 20)
    private String username;
    
    @Email
    private String email;
    
    @Min(18)
    @Max(100)
    private int age;
}
```

### 3. 测试框架

```java
public class CalculatorTest {
    @Test
    public void testAdd() {
        Calculator calc = new Calculator();
        assertEquals(5, calc.add(2, 3));
    }
    
    @Before
    public void setUp() {
        // 测试前准备
    }
    
    @After
    public void tearDown() {
        // 测试后清理
    }
}
```

### 4. 代码生成

```java
// Lombok 示例
@Data
@Builder
public class User {
    private String name;
    private int age;
}
```

## 运行时处理注解

### 通过反射获取注解

```java
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.reflect.Method;

// 定义注解
@Retention(RetentionPolicy.RUNTIME)
public @interface MyAnnotation {
    String value();
}

// 使用注解
public class MyClass {
    @MyAnnotation("测试方法")
    public void testMethod() {
        System.out.println("测试");
    }
}

// 获取注解信息
public class AnnotationProcessor {
    public static void main(String[] args) throws Exception {
        Class<?> clazz = MyClass.class;
        Method method = clazz.getMethod("testMethod");
        
        // 获取注解
        MyAnnotation annotation = method.getAnnotation(MyAnnotation.class);
        if (annotation != null) {
            System.out.println("注解值：" + annotation.value());
        }
    }
}
```

## 实际示例

### 示例 1：自定义注解

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

// 定义注解
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface LogExecution {
    String value() default "";
    boolean logParams() default true;
    boolean logResult() default true;
}

// 使用注解
public class Calculator {
    @LogExecution(value = "加法运算", logParams = true, logResult = true)
    public int add(int a, int b) {
        return a + b;
    }
    
    @LogExecution("减法运算")
    public int subtract(int a, int b) {
        return a - b;
    }
}
```

### 示例 2：处理注解

```java
import java.lang.reflect.Method;

public class AnnotationHandler {
    public static void processAnnotations(Object obj) throws Exception {
        Class<?> clazz = obj.getClass();
        Method[] methods = clazz.getDeclaredMethods();
        
        for (Method method : methods) {
            LogExecution annotation = method.getAnnotation(LogExecution.class);
            if (annotation != null) {
                System.out.println("方法：" + method.getName());
                System.out.println("描述：" + annotation.value());
                System.out.println("记录参数：" + annotation.logParams());
                System.out.println("记录结果：" + annotation.logResult());
            }
        }
    }
    
    public static void main(String[] args) throws Exception {
        Calculator calc = new Calculator();
        processAnnotations(calc);
    }
}
```

### 示例 3：验证注解

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

// 验证注解
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface NotNull {
    String message() default "字段不能为空";
}

// 使用
public class User {
    @NotNull(message = "用户名不能为空")
    private String username;
    
    @NotNull
    private String email;
}

// 验证器
public class Validator {
    public static void validate(Object obj) throws Exception {
        Class<?> clazz = obj.getClass();
        java.lang.reflect.Field[] fields = clazz.getDeclaredFields();
        
        for (java.lang.reflect.Field field : fields) {
            NotNull annotation = field.getAnnotation(NotNull.class);
            if (annotation != null) {
                field.setAccessible(true);
                Object value = field.get(obj);
                if (value == null) {
                    throw new IllegalArgumentException(annotation.message());
                }
            }
        }
    }
}
```

## 注解的最佳实践

### 1. 合理使用内置注解

```java
// ✅ 推荐：使用 @Override
@Override
public void method() { }

// ✅ 推荐：标记过时方法
@Deprecated
public void oldMethod() { }
```

### 2. 定义清晰的注解

```java
// ✅ 推荐：元素命名清晰
@Author(name = "张三", email = "zhangsan@example.com")

// ❌ 不推荐：元素命名不清晰
@Author(n = "张三", e = "zhangsan@example.com")
```

### 3. 使用合适的保留策略

```java
// 编译时处理：SOURCE
@Retention(RetentionPolicy.SOURCE)
public @interface CompileTimeAnnotation { }

// 运行时处理：RUNTIME
@Retention(RetentionPolicy.RUNTIME)
public @interface RuntimeAnnotation { }
```

## 小结

Java 注解要点：

- **注解概念**：元数据，提供附加信息
- **内置注解**：@Override、@Deprecated、@SuppressWarnings 等
- **元注解**：@Target、@Retention、@Documented 等
- **自定义注解**：使用 @interface 定义
- **运行时处理**：通过反射获取注解信息

**关键要点**：
- 注解是元数据，不影响程序执行
- 使用 @Target 指定应用位置
- 使用 @Retention 指定保留策略
- 通过反射可以获取运行时注解
- 合理使用注解提高代码质量

理解了注解，你就能使用现代 Java 框架和工具。恭喜你完成了面向对象编程的学习！
