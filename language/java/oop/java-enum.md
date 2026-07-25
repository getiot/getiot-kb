---
sidebar_position: 14
slug: /java-enum
sidebar_label: Java 枚举
---

# Java 枚举（enum）

枚举是 Java 5 引入的特殊类，用于定义一组固定的常量。理解枚举的使用是编写类型安全代码的关键。本章将详细介绍 Java 中的枚举。

## 枚举的概念

### 什么是枚举

**枚举**（Enum）是一种特殊的类，用于定义一组固定的常量值。

```java
// 定义枚举
public enum Season {
    SPRING, SUMMER, AUTUMN, WINTER
}

// 使用枚举
Season currentSeason = Season.SPRING;
System.out.println(currentSeason);  // SPRING
```

### 为什么使用枚举

**枚举的优势**：
1. **类型安全**：编译时检查，避免无效值
2. **代码清晰**：比魔法数字和字符串更清晰
3. **功能强大**：可以有方法、属性、构造方法
4. **单例模式**：每个枚举值都是单例

## 基本枚举

### 简单枚举

```java
public enum Day {
    MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY
}

// 使用
Day today = Day.MONDAY;
if (today == Day.MONDAY) {
    System.out.println("今天是星期一");
}
```

### 枚举的常用方法

```java
public enum Day {
    MONDAY, TUESDAY, WEDNESDAY
}

// 获取所有枚举值
Day[] days = Day.values();
for (Day day : days) {
    System.out.println(day);
}

// 根据名称获取枚举值
Day day = Day.valueOf("MONDAY");

// 获取枚举值的名称
String name = Day.MONDAY.name();  // "MONDAY"

// 获取枚举值的序号
int ordinal = Day.MONDAY.ordinal();  // 0
```

## 高级枚举

### 枚举可以有属性

```java
public enum Planet {
    MERCURY(3.303e+23, 2.4397e6),
    VENUS(4.869e+24, 6.0518e6),
    EARTH(5.976e+24, 6.37814e6),
    MARS(6.421e+23, 3.3972e6);
    
    private final double mass;   // 质量
    private final double radius; // 半径
    
    // 构造方法
    Planet(double mass, double radius) {
        this.mass = mass;
        this.radius = radius;
    }
    
    // Getter 方法
    public double getMass() {
        return mass;
    }
    
    public double getRadius() {
        return radius;
    }
    
    // 计算方法
    public double getSurfaceGravity() {
        double G = 6.67300E-11;
        return G * mass / (radius * radius);
    }
}

// 使用
Planet earth = Planet.EARTH;
System.out.println("地球质量：" + earth.getMass());
System.out.println("地球表面重力：" + earth.getSurfaceGravity());
```

### 枚举可以有方法

```java
public enum Operation {
    PLUS {
        @Override
        public double apply(double x, double y) {
            return x + y;
        }
    },
    MINUS {
        @Override
        public double apply(double x, double y) {
            return x - y;
        }
    },
    MULTIPLY {
        @Override
        public double apply(double x, double y) {
            return x * y;
        }
    },
    DIVIDE {
        @Override
        public double apply(double x, double y) {
            return x / y;
        }
    };
    
    // 抽象方法：每个枚举值必须实现
    public abstract double apply(double x, double y);
}

// 使用
double result = Operation.PLUS.apply(10, 5);  // 15
```

### 枚举可以实现接口

```java
public interface Describable {
    String getDescription();
}

public enum Status implements Describable {
    ACTIVE("激活状态"),
    INACTIVE("未激活状态"),
    PENDING("待处理状态");
    
    private final String description;
    
    Status(String description) {
        this.description = description;
    }
    
    @Override
    public String getDescription() {
        return description;
    }
}

// 使用
Status status = Status.ACTIVE;
System.out.println(status.getDescription());  // "激活状态"
```

## 枚举的使用场景

### 1. 状态定义

```java
public enum OrderStatus {
    PENDING,    // 待处理
    PROCESSING, // 处理中
    SHIPPED,    // 已发货
    DELIVERED,  // 已送达
    CANCELLED   // 已取消
}

public class Order {
    private OrderStatus status;
    
    public void setStatus(OrderStatus status) {
        this.status = status;
    }
    
    public OrderStatus getStatus() {
        return status;
    }
}
```

### 2. 配置选项

```java
public enum LogLevel {
    DEBUG, INFO, WARNING, ERROR
}

public class Logger {
    private LogLevel level;
    
    public void log(String message, LogLevel level) {
        if (level.ordinal() >= this.level.ordinal()) {
            System.out.println("[" + level + "] " + message);
        }
    }
}
```

### 3. 单例模式

```java
public enum Singleton {
    INSTANCE;
    
    private String data;
    
    public void setData(String data) {
        this.data = data;
    }
    
    public String getData() {
        return data;
    }
}

// 使用
Singleton.INSTANCE.setData("数据");
String data = Singleton.INSTANCE.getData();
```

## 枚举的常用方法

### values() 方法

**获取所有枚举值**：

```java
public enum Day {
    MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY
}

Day[] days = Day.values();
for (Day day : days) {
    System.out.println(day);
}
```

### valueOf() 方法

**根据名称获取枚举值**：

```java
Day day = Day.valueOf("MONDAY");  // 返回 Day.MONDAY

// 如果名称不存在，抛出 IllegalArgumentException
// Day invalid = Day.valueOf("INVALID");  // 抛出异常
```

### name() 和 ordinal() 方法

```java
Day day = Day.MONDAY;

String name = day.name();      // "MONDAY"
int ordinal = day.ordinal();   // 0（第一个枚举值的序号是 0）
```

### compareTo() 方法

**比较枚举值的顺序**：

```java
Day monday = Day.MONDAY;
Day friday = Day.FRIDAY;

int result = monday.compareTo(friday);  // 负数（MONDAY 在 FRIDAY 之前）
```

## 实际示例

### 示例 1：完整的枚举

```java
public enum HttpStatus {
    OK(200, "成功"),
    NOT_FOUND(404, "未找到"),
    INTERNAL_ERROR(500, "服务器错误");
    
    private final int code;
    private final String message;
    
    HttpStatus(int code, String message) {
        this.code = code;
        this.message = message;
    }
    
    public int getCode() {
        return code;
    }
    
    public String getMessage() {
        return message;
    }
    
    // 根据状态码查找枚举
    public static HttpStatus fromCode(int code) {
        for (HttpStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("无效的状态码：" + code);
    }
}

// 使用
HttpStatus status = HttpStatus.OK;
System.out.println(status.getCode());    // 200
System.out.println(status.getMessage()); // "成功"

HttpStatus status2 = HttpStatus.fromCode(404);
System.out.println(status2);  // NOT_FOUND
```

### 示例 2：枚举实现接口

```java
public interface Colorful {
    String getColor();
}

public enum TrafficLight implements Colorful {
    RED("红色") {
        @Override
        public String getColor() {
            return "红色";
        }
    },
    YELLOW("黄色") {
        @Override
        public String getColor() {
            return "黄色";
        }
    },
    GREEN("绿色") {
        @Override
        public String getColor() {
            return "绿色";
        }
    };
    
    private final String description;
    
    TrafficLight(String description) {
        this.description = description;
    }
    
    public String getDescription() {
        return description;
    }
}

// 使用
TrafficLight light = TrafficLight.RED;
System.out.println(light.getColor());      // "红色"
System.out.println(light.getDescription()); // "红色"
```

### 示例 3：枚举作为单例

```java
public enum DatabaseConnection {
    INSTANCE;
    
    private Connection connection;
    
    public void connect() {
        // 连接数据库
        System.out.println("连接数据库");
    }
    
    public void disconnect() {
        // 断开连接
        System.out.println("断开数据库连接");
    }
    
    public Connection getConnection() {
        return connection;
    }
}

// 使用
DatabaseConnection.INSTANCE.connect();
DatabaseConnection.INSTANCE.disconnect();
```

## 枚举 vs 常量类

### 使用枚举

```java
public enum Status {
    ACTIVE, INACTIVE, PENDING
}
```

### 使用常量类

```java
public class Status {
    public static final int ACTIVE = 1;
    public static final int INACTIVE = 2;
    public static final int PENDING = 3;
}
```

### 对比

| 特性 | 枚举 | 常量类 |
|:----:|:----:|:------:|
| 类型安全 | ✅ | ❌ |
| 编译时检查 | ✅ | ❌ |
| 可以有方法 | ✅ | ❌ |
| 可以有属性 | ✅ | ❌ |
| 单例模式 | ✅ | ❌ |

**推荐使用枚举**：更安全、更强大、更清晰。

## 小结

Java 枚举要点：

- **枚举定义**：用 enum 关键字，定义固定常量
- **高级特性**：可以有属性、方法、构造方法
- **实现接口**：枚举可以实现接口
- **常用方法**：values()、valueOf()、name()、ordinal()
- **使用场景**：状态定义、配置选项、单例模式

**关键要点**：
- 枚举是类型安全的常量
- 每个枚举值都是单例
- 可以有属性和方法
- 可以实现接口
- 推荐使用枚举替代常量类

理解了枚举，你就能编写更类型安全的代码。在下一章，我们将学习 Java 的注解。
