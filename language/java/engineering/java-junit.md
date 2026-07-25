---
sidebar_position: 5
slug: /java-junit
sidebar_label: Java 单元测试
---

# Java 单元测试（JUnit）

单元测试是保证代码质量的重要手段。理解 JUnit 的使用是进行测试驱动开发的基础。本章将详细介绍 Java 中的单元测试。

## JUnit 注解

### 常用注解

#### JUnit 5 常用注解

```java
import org.junit.jupiter.api.*;

public class JUnitExample {
    // 测试方法
    @Test
    public void testMethod() {
        // 测试代码
    }
    
    // 每个测试前执行
    @BeforeEach
    public void setUp() {
        // 初始化
    }
    
    // 每个测试后执行
    @AfterEach
    public void tearDown() {
        // 清理
    }
    
    // 所有测试前执行一次
    @BeforeAll
    public static void setUpAll() {
        // 初始化（必须是静态方法）
    }
    
    // 所有测试后执行一次
    @AfterAll
    public static void tearDownAll() {
        // 清理（必须是静态方法）
    }
}
```

#### JUnit 4 常用注解

```java
import org.junit.*;

public class JUnit4Example {
    @Before
    public void setUp() {
        // 每个测试前执行
    }
    
    @After
    public void tearDown() {
        // 每个测试后执行
    }
    
    @BeforeClass
    public static void setUpClass() {
        // 所有测试前执行一次
    }
    
    @AfterClass
    public static void tearDownClass() {
        // 所有测试后执行一次
    }
    
    @Test
    public void testMethod() {
        // 测试代码
    }
}
```

## 断言方法

### 常用断言

#### JUnit 5 断言

```java
import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

public class AssertionExample {
    @Test
    public void testAssertions() {
        // 相等断言
        assertEquals(5, 2 + 3);
        assertEquals("Hello", "Hello");
        
        // 不相等断言
        assertNotEquals(5, 2 + 2);
        
        // 真值断言
        assertTrue(5 > 3);
        assertFalse(5 < 3);
        
        // 空值断言
        assertNull(null);
        assertNotNull("Hello");
        
        // 相同对象断言
        String str1 = "Hello";
        String str2 = str1;
        assertSame(str1, str2);
        assertNotSame(str1, new String("Hello"));
        
        // 数组相等
        assertArrayEquals(new int[]{1, 2, 3}, new int[]{1, 2, 3});
        
        // 异常断言
        assertThrows(ArithmeticException.class, () -> {
            int result = 10 / 0;
        });
    }
}
```

#### JUnit 4 断言

```java
import org.junit.*;
import static org.junit.Assert.*;

public class JUnit4Assertion {
    @Test
    public void testAssertions() {
        assertEquals(5, 2 + 3);
        assertTrue(5 > 3);
        assertFalse(5 < 3);
        assertNull(null);
        assertNotNull("Hello");
    }
}
```

### 断言消息

```java
@Test
public void testWithMessage() {
    // 断言失败时显示消息
    assertEquals(5, 2 + 2, "计算错误");
    assertTrue(5 > 3, "5 应该大于 3");
}
```

## 测试套件与执行

### 测试类示例

```java
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

public class CalculatorTest {
    private Calculator calculator;
    
    @BeforeEach
    public void setUp() {
        calculator = new Calculator();
    }
    
    @Test
    public void testAdd() {
        int result = calculator.add(3, 4);
        assertEquals(7, result);
    }
    
    @Test
    public void testSubtract() {
        int result = calculator.subtract(5, 3);
        assertEquals(2, result);
    }
    
    @Test
    public void testMultiply() {
        int result = calculator.multiply(3, 4);
        assertEquals(12, result);
    }
    
    @Test
    public void testDivide() {
        double result = calculator.divide(10, 2);
        assertEquals(5.0, result, 0.001);
    }
    
    @Test
    public void testDivideByZero() {
        assertThrows(ArithmeticException.class, () -> {
            calculator.divide(10, 0);
        });
    }
}

class Calculator {
    public int add(int a, int b) {
        return a + b;
    }
    
    public int subtract(int a, int b) {
        return a - b;
    }
    
    public int multiply(int a, int b) {
        return a * b;
    }
    
    public double divide(int a, int b) {
        if (b == 0) {
            throw new ArithmeticException("除数不能为0");
        }
        return (double) a / b;
    }
}
```

### 参数化测试

```java
import org.junit.jupiter.params.*;
import org.junit.jupiter.params.provider.*;

import static org.junit.jupiter.api.Assertions.*;

@ParameterizedTest
@ValueSource(ints = {2, 4, 6, 8})
public void testEvenNumbers(int number) {
    assertTrue(number % 2 == 0);
}

@ParameterizedTest
@CsvSource({
    "2, 3, 5",
    "5, 5, 10",
    "10, 20, 30"
})
public void testAdd(int a, int b, int expected) {
    Calculator calc = new Calculator();
    assertEquals(expected, calc.add(a, b));
}
```

### 测试套件（JUnit 4）

```java
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Suite.class)
@Suite.SuiteClasses({
    CalculatorTest.class,
    StringUtilsTest.class,
    MathUtilsTest.class
})
public class TestSuite {
    // 测试套件类
}
```

### 测试执行

**使用 Maven 执行测试**：

```bash
# 运行所有测试
mvn test

# 运行特定测试类
mvn test -Dtest=CalculatorTest

# 运行特定测试方法
mvn test -Dtest=CalculatorTest#testAdd
```

**使用 IDE 执行**：
- 右键测试类或方法
- 选择 "Run Test"

## 实际示例

### 示例 1：字符串工具测试

```java
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

public class StringUtilsTest {
    @Test
    public void testIsEmpty() {
        assertTrue(StringUtils.isEmpty(null));
        assertTrue(StringUtils.isEmpty(""));
        assertFalse(StringUtils.isEmpty("Hello"));
    }
    
    @Test
    public void testReverse() {
        assertEquals("olleh", StringUtils.reverse("hello"));
        assertEquals("", StringUtils.reverse(""));
        assertNull(StringUtils.reverse(null));
    }
}

class StringUtils {
    public static boolean isEmpty(String str) {
        return str == null || str.isEmpty();
    }
    
    public static String reverse(String str) {
        if (str == null) {
            return null;
        }
        return new StringBuilder(str).reverse().toString();
    }
}
```

### 示例 2：用户服务测试

```java
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

public class UserServiceTest {
    private UserService userService;
    
    @BeforeEach
    public void setUp() {
        userService = new UserService();
    }
    
    @Test
    public void testCreateUser() {
        User user = userService.createUser("张三", "zhangsan@example.com");
        assertNotNull(user);
        assertEquals("张三", user.getName());
        assertEquals("zhangsan@example.com", user.getEmail());
    }
    
    @Test
    public void testCreateUserWithInvalidEmail() {
        assertThrows(IllegalArgumentException.class, () -> {
            userService.createUser("张三", "invalid-email");
        });
    }
    
    @Test
    public void testFindUserById() {
        User user = userService.createUser("张三", "zhangsan@example.com");
        User found = userService.findUserById(user.getId());
        assertNotNull(found);
        assertEquals(user.getId(), found.getId());
    }
    
    @Test
    public void testFindUserByIdNotFound() {
        User found = userService.findUserById(999);
        assertNull(found);
    }
}
```

### 示例 3：Mock 测试

```java
import org.junit.jupiter.api.*;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

public class OrderServiceTest {
    @Mock
    private UserDao userDao;
    
    @Mock
    private OrderDao orderDao;
    
    private OrderService orderService;
    
    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        orderService = new OrderService(userDao, orderDao);
    }
    
    @Test
    public void testCreateOrder() {
        User user = new User(1, "张三");
        when(userDao.findById(1)).thenReturn(user);
        
        Order order = orderService.createOrder(1, 100.0);
        
        assertNotNull(order);
        assertEquals(1, order.getUserId());
        verify(orderDao).save(order);
    }
}
```

## 单元测试的最佳实践

### 1. 测试命名规范

```java
// ✅ 推荐：方法名_条件_期望结果
@Test
public void testAdd_WhenBothPositive_ReturnsSum() {
    // ...
}

// 或使用描述性名称
@Test
public void shouldReturnSumWhenAddingTwoPositiveNumbers() {
    // ...
}
```

### 2. 一个测试一个断言

```java
// ✅ 推荐：一个测试一个断言
@Test
public void testAdd() {
    assertEquals(5, calculator.add(2, 3));
}

// ⚠️ 可以：相关断言可以放在一起
@Test
public void testUserCreation() {
    User user = userService.createUser("张三", "email@example.com");
    assertNotNull(user);
    assertEquals("张三", user.getName());
}
```

### 3. 使用 @BeforeEach 初始化

```java
@BeforeEach
public void setUp() {
    // 初始化测试数据
    calculator = new Calculator();
    userService = new UserService();
}
```

### 4. 测试异常

```java
@Test
public void testDivideByZero() {
    assertThrows(ArithmeticException.class, () -> {
        calculator.divide(10, 0);
    });
}
```

## 小结

Java 单元测试要点：

- **JUnit 注解**：@Test、@BeforeEach、@AfterEach、@BeforeAll、@AfterAll
- **断言方法**：assertEquals、assertTrue、assertNull、assertThrows
- **测试套件**：组织多个测试类
- **参数化测试**：使用不同参数测试同一方法
- **Mock 测试**：模拟依赖对象

**关键要点**：
- 使用 JUnit 编写单元测试
- 使用断言验证结果
- 使用 @BeforeEach 初始化
- 测试正常情况和异常情况
- 保持测试独立和可重复

理解了单元测试，你就能保证代码质量。恭喜你完成了第十部分的学习！
