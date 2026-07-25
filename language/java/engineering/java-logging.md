---
sidebar_position: 4
slug: /java-logging
sidebar_label: Java 日志框架
---

# Java 日志框架简介（JUL / Log4j / SLF4J）

日志是应用程序的重要组成部分。理解日志框架的使用是进行调试和监控的关键。本章将详细介绍 Java 中的日志框架。

## 常用 Java 日志框架

### JUL

**JUL**（Java Util Logging）是 Java 自带的日志框架。使用时不需要另外引用第三方类库，相对其他日志框架使用方便，学习简单，能够在小型应用中灵活使用。

**特点**：

- Java 标准库，无需额外依赖
- 功能简单
- 配置相对复杂

```java
import java.util.logging.Logger;
import java.util.logging.Level;

public class JULExample {
    private static final Logger logger = Logger.getLogger(JULExample.class.getName());
    
    public static void main(String[] args) {
        logger.info("信息日志");
        logger.warning("警告日志");
        logger.severe("严重错误日志");
        
        // 使用 Level
        logger.log(Level.INFO, "信息日志");
        logger.log(Level.WARNING, "警告日志");
    }
}
```

### Log4j

**Log4j** 是 Apache 下的一款开源的日志框架。它有一个升级版本 Log4j2，参考了 Logback 的一些优秀的设计，并且修复了一些问题。

**特点**：
- 功能强大
- 配置灵活
- 性能好

```java
import org.apache.log4j.Logger;

public class Log4jExample {
    private static final Logger logger = Logger.getLogger(Log4jExample.class);
    
    public static void main(String[] args) {
        logger.debug("调试日志");
        logger.info("信息日志");
        logger.warn("警告日志");
        logger.error("错误日志");
    }
}
```

### SLF4J

**SLF4J**（Simple Logging Facade for Java）是日志门面，提供统一的日志接口。学过设计模式的同学都会知道在 23 种设计模式中有一种模式叫 **门面模式** 或 **外观模式**（Facade），这意味着 SLF4J 充当不同日志框架门面的角色，让用户可以自由切换底层的日志实现。

**特点**：
- 日志门面，不实现日志
- 可以切换底层日志实现
- 推荐使用

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SLF4JExample {
    private static final Logger logger = LoggerFactory.getLogger(SLF4JExample.class);
    
    public static void main(String[] args) {
        logger.debug("调试日志");
        logger.info("信息日志");
        logger.warn("警告日志");
        logger.error("错误日志");
    }
}
```

## 日志等级与配置

### 日志等级

**日志等级**（从低到高）：

1. **TRACE**：最详细的日志
2. **DEBUG**：调试信息
3. **INFO**：一般信息
4. **WARN**：警告信息
5. **ERROR**：错误信息

### SLF4J 配置（logback）

**logback.xml**：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <!-- 控制台输出 -->
    <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>
    
    <!-- 文件输出 -->
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>logs/application.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>logs/application.%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>30</maxHistory>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>
    
    <!-- 根日志级别 -->
    <root level="INFO">
        <appender-ref ref="CONSOLE"/>
        <appender-ref ref="FILE"/>
    </root>
    
    <!-- 特定包的日志级别 -->
    <logger name="com.example" level="DEBUG"/>
</configuration>
```

### Log4j2 配置

**log4j2.xml**：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration>
    <Appenders>
        <!-- 控制台输出 -->
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss} [%t] %-5level %logger{36} - %msg%n"/>
        </Console>
        
        <!-- 文件输出 -->
        <RollingFile name="File" fileName="logs/application.log"
                     filePattern="logs/application-%d{yyyy-MM-dd}-%i.log">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss} [%t] %-5level %logger{36} - %msg%n"/>
            <Policies>
                <TimeBasedTriggeringPolicy/>
                <SizeBasedTriggeringPolicy size="10MB"/>
            </Policies>
            <DefaultRolloverStrategy max="10"/>
        </RollingFile>
    </Appenders>
    
    <Loggers>
        <!-- 根日志级别 -->
        <Root level="INFO">
            <AppenderRef ref="Console"/>
            <AppenderRef ref="File"/>
        </Root>
        
        <!-- 特定包的日志级别 -->
        <Logger name="com.example" level="DEBUG"/>
    </Loggers>
</Configuration>
```

## 日志输出示例

### 示例 1：基本日志

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggingExample {
    private static final Logger logger = LoggerFactory.getLogger(LoggingExample.class);
    
    public static void main(String[] args) {
        logger.trace("TRACE 级别日志");
        logger.debug("DEBUG 级别日志");
        logger.info("INFO 级别日志");
        logger.warn("WARN 级别日志");
        logger.error("ERROR 级别日志");
    }
}
```

### 示例 2：参数化日志

```java
public class ParameterizedLogging {
    private static final Logger logger = LoggerFactory.getLogger(ParameterizedLogging.class);
    
    public void processUser(String username, int age) {
        // ✅ 推荐：使用参数化日志
        logger.info("处理用户：{}，年龄：{}", username, age);
        
        // ❌ 不推荐：字符串拼接
        // logger.info("处理用户：" + username + "，年龄：" + age);
    }
    
    public void processOrder(String orderId, double amount) {
        logger.debug("订单ID：{}，金额：{}", orderId, amount);
        
        if (amount > 1000) {
            logger.warn("大额订单：订单ID={}，金额={}", orderId, amount);
        }
    }
}
```

### 示例 3：异常日志

```java
public class ExceptionLogging {
    private static final Logger logger = LoggerFactory.getLogger(ExceptionLogging.class);
    
    public void processData() {
        try {
            // 业务逻辑
            int result = 10 / 0;
        } catch (ArithmeticException e) {
            // ✅ 推荐：记录异常和上下文
            logger.error("处理数据时发生错误：用户ID={}", getUserId(), e);
            
            // ❌ 不推荐：只记录消息
            // logger.error("处理数据时发生错误");
        }
    }
    
    private String getUserId() {
        return "user123";
    }
}
```

### 示例 4：条件日志

```java
public class ConditionalLogging {
    private static final Logger logger = LoggerFactory.getLogger(ConditionalLogging.class);
    
    public void processItems(List<String> items) {
        // 只在 DEBUG 级别时执行复杂操作
        if (logger.isDebugEnabled()) {
            logger.debug("处理项目列表：{}", items.stream()
                .map(String::toUpperCase)
                .collect(Collectors.joining(", ")));
        }
        
        // 或使用 lambda（SLF4J 1.8+）
        logger.debug("处理项目列表：{}", () -> items.stream()
            .map(String::toUpperCase)
            .collect(Collectors.joining(", ")));
    }
}
```

### 示例 5：MDC（Mapped Diagnostic Context）

```java
import org.slf4j.MDC;

public class MDCLogging {
    private static final Logger logger = LoggerFactory.getLogger(MDCLogging.class);
    
    public void processRequest(String requestId, String userId) {
        // 设置上下文信息
        MDC.put("requestId", requestId);
        MDC.put("userId", userId);
        
        try {
            logger.info("开始处理请求");
            // 业务逻辑
            logger.info("请求处理完成");
        } finally {
            // 清理上下文
            MDC.clear();
        }
    }
}
```

**logback.xml 配置 MDC**：

```xml
<encoder>
    <pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] [%X{requestId}] [%X{userId}] %-5level %logger{36} - %msg%n</pattern>
</encoder>
```

## 日志框架的最佳实践

### 1. 使用 SLF4J 作为日志门面

```java
// ✅ 推荐：使用 SLF4J
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

private static final Logger logger = LoggerFactory.getLogger(MyClass.class);
```

### 2. 使用参数化日志

```java
// ✅ 推荐：参数化日志
logger.info("用户 {} 登录，IP：{}", username, ip);

// ❌ 不推荐：字符串拼接
logger.info("用户 " + username + " 登录，IP：" + ip);
```

### 3. 合理使用日志级别

```java
logger.trace("详细的调试信息");
logger.debug("调试信息");
logger.info("一般信息");
logger.warn("警告信息");
logger.error("错误信息", exception);
```

### 4. 记录异常堆栈

```java
// ✅ 推荐：记录异常对象
logger.error("处理失败", exception);

// ❌ 不推荐：只记录异常消息
logger.error("处理失败：" + exception.getMessage());
```

## 小结

Java 日志框架要点：

- **JUL**：Java 自带日志框架
- **Log4j**：Apache 日志框架
- **SLF4J**：日志门面，推荐使用
- **日志等级**：TRACE、DEBUG、INFO、WARN、ERROR
- **配置**：通过 XML 或 properties 文件配置

**关键要点**：
- 推荐使用 SLF4J 作为日志门面
- 使用参数化日志提高性能
- 合理使用日志级别
- 记录异常堆栈信息
- 使用 MDC 添加上下文信息

理解了日志框架，你就能更好地调试和监控应用。在下一章，我们将学习 Java 单元测试（JUnit）。
