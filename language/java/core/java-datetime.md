---
sidebar_position: 4
slug: /java-datetime
sidebar_label: Java 日期与时间
---

# Java 日期与时间（java.time）

Java 8 引入了新的日期时间 API（`java.time` 包），解决了旧 API 的问题，提供了更好的日期时间处理能力。理解新的日期时间 API 是进行时间相关开发的基础。本章将详细介绍 Java 中的日期时间处理。

## java.time 包概览

### 为什么需要新的日期时间 API？

**旧 API（java.util.Date、Calendar）的问题**：

- 线程不安全
- API 设计混乱
- 时区处理复杂
- 可变对象，容易出错

**新 API（java.time）的优势**：
- 线程安全（不可变对象）
- API 设计清晰
- 时区处理简单
- 不可变对象，更安全

### LocalDate 类

**`LocalDate`** 表示日期（年-月-日），不包含时间。

```java
import java.time.LocalDate;

// 获取当前日期
LocalDate today = LocalDate.now();
System.out.println("今天：" + today);  // 2024-01-15

// 创建指定日期
LocalDate date1 = LocalDate.of(2024, 1, 15);
LocalDate date2 = LocalDate.of(2024, Month.JANUARY, 15);

// 从字符串解析
LocalDate date3 = LocalDate.parse("2024-01-15");

// 获取日期组成部分
int year = today.getYear();        // 2024
int month = today.getMonthValue(); // 1
int day = today.getDayOfMonth();   // 15
DayOfWeek dayOfWeek = today.getDayOfWeek();  // MONDAY
```

### LocalTime 类

**`LocalTime`** 表示时间（时:分:秒），不包含日期。

```java
import java.time.LocalTime;

// 获取当前时间
LocalTime now = LocalTime.now();
System.out.println("现在：" + now);  // 14:30:45.123

// 创建指定时间
LocalTime time1 = LocalTime.of(14, 30);
LocalTime time2 = LocalTime.of(14, 30, 45);
LocalTime time3 = LocalTime.of(14, 30, 45, 123456789);

// 从字符串解析
LocalTime time4 = LocalTime.parse("14:30:45");

// 获取时间组成部分
int hour = now.getHour();     // 14
int minute = now.getMinute(); // 30
int second = now.getSecond(); // 45
```

### LocalDateTime 类

**`LocalDateTime`** 表示日期和时间，不包含时区。

```java
import java.time.LocalDateTime;

// 获取当前日期时间
LocalDateTime now = LocalDateTime.now();
System.out.println("现在：" + now);  // 2024-01-15T14:30:45.123

// 创建指定日期时间
LocalDateTime dt1 = LocalDateTime.of(2024, 1, 15, 14, 30);
LocalDateTime dt2 = LocalDateTime.of(2024, Month.JANUARY, 15, 14, 30, 45);

// 从 LocalDate 和 LocalTime 组合
LocalDate date = LocalDate.of(2024, 1, 15);
LocalTime time = LocalTime.of(14, 30);
LocalDateTime dt3 = LocalDateTime.of(date, time);

// 从字符串解析
LocalDateTime dt4 = LocalDateTime.parse("2024-01-15T14:30:45");
```

## 日期/时间解析与格式化

### DateTimeFormatter 类

**`DateTimeFormatter`** 用于格式化和解析日期时间。

```java
import java.time.format.DateTimeFormatter;

// 格式化
LocalDate date = LocalDate.of(2024, 1, 15);
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
String formatted = date.format(formatter);  // "2024-01-15"

// 解析
LocalDate parsed = LocalDate.parse("2024-01-15", formatter);

// 预定义格式
DateTimeFormatter isoDate = DateTimeFormatter.ISO_DATE;
String formatted2 = date.format(isoDate);  // "2024-01-15"
```

### 常用格式模式

```java
LocalDateTime now = LocalDateTime.now();

// 自定义格式
DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
String formatted1 = now.format(formatter1);  // "2024-01-15 14:30:45"

DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy年MM月dd日 HH时mm分");
String formatted2 = now.format(formatter2);  // "2024年01月15日 14时30分"

DateTimeFormatter formatter3 = DateTimeFormatter.ofPattern("dd/MM/yyyy");
String formatted3 = now.format(formatter3);  // "15/01/2024"
```

### 格式模式符号

| 符号 | 含义 | 示例 |
|:----:|:----:|:----:|
| y | 年 | 2024 |
| M | 月 | 1, 01, Jan, January |
| d | 日 | 1, 01 |
| H | 时（24小时制） | 0-23 |
| h | 时（12小时制） | 1-12 |
| m | 分 | 0-59 |
| s | 秒 | 0-59 |
| a | AM/PM | AM, PM |

## 时间间隔与计算

### Duration 类

**`Duration`** 表示时间间隔（精确到纳秒），用于 LocalTime 和 LocalDateTime。

```java
import java.time.Duration;

LocalTime start = LocalTime.of(10, 0);
LocalTime end = LocalTime.of(14, 30);

// 计算时间间隔
Duration duration = Duration.between(start, end);
System.out.println("间隔：" + duration);  // PT4H30M

// 获取间隔组成部分
long hours = duration.toHours();      // 4
long minutes = duration.toMinutes();  // 270
long seconds = duration.getSeconds(); // 16200

// 创建 Duration
Duration duration1 = Duration.ofHours(2);
Duration duration2 = Duration.ofMinutes(30);
Duration duration3 = Duration.ofSeconds(90);
```

### Period 类

**`Period`** 表示日期间隔（年-月-日），用于 LocalDate。

```java
import java.time.Period;

LocalDate start = LocalDate.of(2024, 1, 1);
LocalDate end = LocalDate.of(2024, 12, 31);

// 计算日期间隔
Period period = Period.between(start, end);
System.out.println("间隔：" + period);  // P11M30D

// 获取间隔组成部分
int years = period.getYears();   // 0
int months = period.getMonths(); // 11
int days = period.getDays();     // 30

// 创建 Period
Period period1 = Period.ofYears(1);
Period period2 = Period.ofMonths(6);
Period period3 = Period.ofDays(30);
Period period4 = Period.of(1, 2, 3);  // 1年2月3天
```

### 日期时间计算

```java
LocalDate date = LocalDate.of(2024, 1, 15);

// 加减日期
LocalDate plusDays = date.plusDays(10);      // 加 10 天
LocalDate plusWeeks = date.plusWeeks(2);      // 加 2 周
LocalDate plusMonths = date.plusMonths(1);    // 加 1 月
LocalDate plusYears = date.plusYears(1);      // 加 1 年

LocalDate minusDays = date.minusDays(5);      // 减 5 天

// 使用 Period
Period period = Period.of(1, 2, 3);
LocalDate newDate = date.plus(period);       // 加 1年2月3天

// 使用 Duration（需要转换为 LocalDateTime）
LocalDateTime dateTime = date.atStartOfDay();
LocalDateTime newDateTime = dateTime.plus(Duration.ofHours(2));
```

## 时区处理

### ZonedDateTime 类

**`ZonedDateTime`** 表示带时区的日期时间。

```java
import java.time.ZonedDateTime;
import java.time.ZoneId;

// 获取当前时区的日期时间
ZonedDateTime now = ZonedDateTime.now();
System.out.println("现在：" + now);  // 2024-01-15T14:30:45.123+08:00[Asia/Shanghai]

// 指定时区
ZonedDateTime zoned1 = ZonedDateTime.now(ZoneId.of("Asia/Shanghai"));
ZonedDateTime zoned2 = ZonedDateTime.now(ZoneId.of("America/New_York"));

// 从 LocalDateTime 创建
LocalDateTime localDateTime = LocalDateTime.of(2024, 1, 15, 14, 30);
ZonedDateTime zoned3 = localDateTime.atZone(ZoneId.of("Asia/Shanghai"));

// 时区转换
ZonedDateTime beijing = ZonedDateTime.now(ZoneId.of("Asia/Shanghai"));
ZonedDateTime newYork = beijing.withZoneSameInstant(ZoneId.of("America/New_York"));
```

### ZoneId 类

**`ZoneId`** 表示时区标识符。

```java
import java.time.ZoneId;

// 系统默认时区
ZoneId systemZone = ZoneId.systemDefault();

// 指定时区
ZoneId shanghai = ZoneId.of("Asia/Shanghai");
ZoneId newYork = ZoneId.of("America/New_York");
ZoneId utc = ZoneId.of("UTC");

// 获取所有可用时区
Set<String> zoneIds = ZoneId.getAvailableZoneIds();
```

## 示例：获取当前时间、计算日期差值

### 示例 1：基本日期时间操作

```java
import java.time.*;
import java.time.format.DateTimeFormatter;

public class DateTimeExample {
    public static void main(String[] args) {
        // 当前日期时间
        LocalDate today = LocalDate.now();
        LocalTime now = LocalTime.now();
        LocalDateTime dateTime = LocalDateTime.now();
        
        System.out.println("今天：" + today);
        System.out.println("现在：" + now);
        System.out.println("日期时间：" + dateTime);
        
        // 创建指定日期时间
        LocalDate birthday = LocalDate.of(2000, 1, 1);
        System.out.println("生日：" + birthday);
        
        // 格式化
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy年MM月dd日");
        String formatted = today.format(formatter);
        System.out.println("格式化：" + formatted);
        
        // 解析
        LocalDate parsed = LocalDate.parse("2024-01-15");
        System.out.println("解析：" + parsed);
    }
}
```

### 示例 2：计算日期差值

```java
import java.time.*;
import java.time.temporal.ChronoUnit;

public class DateCalculation {
    public static void main(String[] args) {
        LocalDate start = LocalDate.of(2024, 1, 1);
        LocalDate end = LocalDate.of(2024, 12, 31);
        
        // 使用 Period 计算日期差值
        Period period = Period.between(start, end);
        System.out.println("间隔：" + period.getYears() + "年" + 
                          period.getMonths() + "月" + 
                          period.getDays() + "天");
        
        // 使用 ChronoUnit 计算差值
        long days = ChronoUnit.DAYS.between(start, end);
        System.out.println("相差天数：" + days);
        
        long months = ChronoUnit.MONTHS.between(start, end);
        System.out.println("相差月数：" + months);
        
        // 计算年龄
        LocalDate birthDate = LocalDate.of(2000, 1, 1);
        LocalDate today = LocalDate.now();
        long age = ChronoUnit.YEARS.between(birthDate, today);
        System.out.println("年龄：" + age + "岁");
    }
}
```

### 示例 3：时区处理

```java
import java.time.*;

public class TimeZoneExample {
    public static void main(String[] args) {
        // 当前时区
        ZonedDateTime beijing = ZonedDateTime.now(ZoneId.of("Asia/Shanghai"));
        System.out.println("北京时间：" + beijing);
        
        // 转换为其他时区
        ZonedDateTime newYork = beijing.withZoneSameInstant(ZoneId.of("America/New_York"));
        System.out.println("纽约时间：" + newYork);
        
        ZonedDateTime london = beijing.withZoneSameInstant(ZoneId.of("Europe/London"));
        System.out.println("伦敦时间：" + london);
        
        // 计算时差
        Duration duration = Duration.between(beijing.toLocalTime(), newYork.toLocalTime());
        System.out.println("时差：" + duration.toHours() + "小时");
    }
}
```

### 示例 4：日期时间工具类

```java
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

public class DateTimeUtils {
    // 判断是否为闰年
    public static boolean isLeapYear(int year) {
        return Year.isLeap(year);
    }
    
    // 获取月份天数
    public static int getDaysInMonth(int year, int month) {
        YearMonth yearMonth = YearMonth.of(year, month);
        return yearMonth.lengthOfMonth();
    }
    
    // 计算两个日期之间的天数
    public static long daysBetween(LocalDate start, LocalDate end) {
        return ChronoUnit.DAYS.between(start, end);
    }
    
    // 格式化日期时间
    public static String formatDateTime(LocalDateTime dateTime, String pattern) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
        return dateTime.format(formatter);
    }
    
    // 判断日期是否在范围内
    public static boolean isDateInRange(LocalDate date, LocalDate start, LocalDate end) {
        return !date.isBefore(start) && !date.isAfter(end);
    }
    
    public static void main(String[] args) {
        System.out.println("2024 是闰年：" + isLeapYear(2024));
        System.out.println("2024年2月天数：" + getDaysInMonth(2024, 2));
        
        LocalDate start = LocalDate.of(2024, 1, 1);
        LocalDate end = LocalDate.of(2024, 12, 31);
        System.out.println("相差天数：" + daysBetween(start, end));
        
        LocalDateTime now = LocalDateTime.now();
        System.out.println("格式化：" + formatDateTime(now, "yyyy-MM-dd HH:mm:ss"));
        
        LocalDate date = LocalDate.of(2024, 6, 15);
        System.out.println("日期在范围内：" + isDateInRange(date, start, end));
    }
}
```

## 小结

Java 日期与时间要点：

- **LocalDate**：日期（年-月-日）
- **LocalTime**：时间（时:分:秒）
- **LocalDateTime**：日期时间
- **DateTimeFormatter**：格式化和解析
- **Duration**：时间间隔（精确到纳秒）
- **Period**：日期间隔（年-月-日）
- **ZonedDateTime**：带时区的日期时间

**关键要点**：
- 新 API 是不可变的，线程安全
- 使用 DateTimeFormatter 格式化和解析
- Duration 用于时间间隔，Period 用于日期间隔
- ZonedDateTime 处理时区
- 推荐使用新 API，避免使用旧 API

理解了日期时间 API，你就能处理各种时间相关的需求。在下一章，我们将学习 Java 的正则表达式。
