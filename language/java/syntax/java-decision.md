---
sidebar_position: 6
slug: /java-decision
sidebar_label: Java 流程控制
---

# Java 流程控制（if / switch）

流程控制语句用于根据条件决定程序的执行路径。Java 提供了 if-else 和 switch 两种条件语句。理解流程控制是编写逻辑清晰程序的基础。

## if-else 语句

包括 `if` 语句、`if - else` 语句、`if - else if - else` 语句等不同分支组合。

### if 语句

**语法**：
```java
if (条件) {
    // 条件为 true 时执行
}
```

**示例**：
```java
int score = 85;

if (score >= 60) {
    System.out.println("及格");
}
```

### if-else 语句

**语法**：
```java
if (条件) {
    // 条件为 true 时执行
} else {
    // 条件为 false 时执行
}
```

**示例**：
```java
int age = 18;

if (age >= 18) {
    System.out.println("已成年");
} else {
    System.out.println("未成年");
}
```

### if-else if-else 语句

**语法**：
```java
if (条件1) {
    // 条件1 为 true 时执行
} else if (条件2) {
    // 条件1 为 false，条件2 为 true 时执行
} else if (条件3) {
    // 前面的条件都为 false，条件3 为 true 时执行
} else {
    // 所有条件都为 false 时执行
}
```

**示例**：
```java
int score = 85;

if (score >= 90) {
    System.out.println("优秀");
} else if (score >= 80) {
    System.out.println("良好");
} else if (score >= 60) {
    System.out.println("及格");
} else {
    System.out.println("不及格");
}
```

### 注意事项

#### 1. 条件必须是布尔表达式

```java
// ✅ 正确
if (age >= 18) { }

// ❌ 错误：不能使用数字作为条件
// if (age) { }  // 编译错误
```

#### 2. 大括号的使用

```java
// 单语句可以省略大括号（不推荐）
if (age >= 18)
    System.out.println("已成年");

// 推荐：始终使用大括号
if (age >= 18) {
    System.out.println("已成年");
}
```

**为什么推荐使用大括号**：
- 代码更清晰
- 避免添加代码时的错误
- 减少维护成本

#### 3. else 的匹配

```java
int x = 10;
int y = 5;

// else 匹配最近的 if
if (x > 0)
    if (y > 0)
        System.out.println("都大于 0");
    else
        System.out.println("y 不大于 0");  // 这个 else 匹配内层 if
```

## switch 语句

### switch-case 语句

**语法**：
```java
switch (表达式) {
    case 值1:
        // 代码
        break;
    case 值2:
        // 代码
        break;
    default:
        // 默认代码
        break;
}
```

**示例**：
```java
int day = 3;

switch (day) {
    case 1:
        System.out.println("星期一");
        break;
    case 2:
        System.out.println("星期二");
        break;
    case 3:
        System.out.println("星期三");
        break;
    default:
        System.out.println("其他");
        break;
}
```

### switch 表达式（Java 14+）

**语法**：
```java
String dayName = switch (day) {
    case 1 -> "星期一";
    case 2 -> "星期二";
    case 3 -> "星期三";
    default -> "其他";
};
```

**多行代码**：
```java
String result = switch (day) {
    case 1 -> {
        System.out.println("处理星期一");
        yield "星期一";
    }
    case 2 -> "星期二";
    default -> "其他";
};
```

### switch 的特性

#### 1. 支持的类型

- **Java 7 之前**：只支持 `int`、`char`、`byte`、`short`、`enum`
- **Java 7+**：支持 `String`
- **Java 14+**：支持更多类型，可以使用 switch 表达式

```java
// 支持 String
String day = "Monday";
switch (day) {
    case "Monday":
        System.out.println("星期一");
        break;
    case "Tuesday":
        System.out.println("星期二");
        break;
    default:
        System.out.println("其他");
}
```

#### 2. break 的作用

**没有 break**：会继续执行下一个 case（穿透）

```java
int day = 1;

switch (day) {
    case 1:
        System.out.println("星期一");
        // 没有 break，继续执行
    case 2:
        System.out.println("星期二");
        break;
    default:
        System.out.println("其他");
}
// 输出：
// 星期一
// 星期二
```

**有 break**：执行完当前 case 后退出

```java
int day = 1;

switch (day) {
    case 1:
        System.out.println("星期一");
        break;  // 退出 switch
    case 2:
        System.out.println("星期二");
        break;
}
// 输出：星期一
```

#### 3. default 子句

- 所有 case 都不匹配时执行
- 可以放在任何位置（通常放在最后）
- 不是必需的

```java
int day = 10;

switch (day) {
    case 1:
        System.out.println("星期一");
        break;
    default:
        System.out.println("无效的日期");
        break;
}
```

## 嵌套与条件表达式

### 嵌套 if 语句

```java
int age = 20;
boolean hasLicense = true;

if (age >= 18) {
    if (hasLicense) {
        System.out.println("可以开车");
    } else {
        System.out.println("需要驾照");
    }
} else {
    System.out.println("年龄不够");
}
```

**简化嵌套**：使用逻辑运算符

```java
int age = 20;
boolean hasLicense = true;

if (age >= 18 && hasLicense) {
    System.out.println("可以开车");
} else if (age >= 18) {
    System.out.println("需要驾照");
} else {
    System.out.println("年龄不够");
}
```

### 条件表达式（三元运算符）

**语法**：`条件 ? 值1 : 值2`

```java
int score = 85;
String grade = score >= 60 ? "及格" : "不及格";

// 嵌套使用
String result = score >= 90 ? "优秀" : 
                score >= 80 ? "良好" : 
                score >= 60 ? "及格" : "不及格";
```

**与 if-else 对比**：

```java
// 三元运算符
int max = a > b ? a : b;

// if-else
int max;
if (a > b) {
    max = a;
} else {
    max = b;
}
```

## 实例演示：分数评级

### 示例 1：使用 if-else

```java
public class GradeExample {
    public static void main(String[] args) {
        int score = 85;
        String grade;
        
        if (score >= 90) {
            grade = "A";
        } else if (score >= 80) {
            grade = "B";
        } else if (score >= 70) {
            grade = "C";
        } else if (score >= 60) {
            grade = "D";
        } else {
            grade = "F";
        }
        
        System.out.println("分数：" + score + "，等级：" + grade);
    }
}
```

### 示例 2：使用 switch（Java 14+）

```java
public class GradeSwitchExample {
    public static void main(String[] args) {
        int score = 85;
        int level = score / 10;  // 8
        
        String grade = switch (level) {
            case 10, 9 -> "A";
            case 8 -> "B";
            case 7 -> "C";
            case 6 -> "D";
            default -> "F";
        };
        
        System.out.println("分数：" + score + "，等级：" + grade);
    }
}
```

### 示例 3：综合示例

```java
public class StudentGrade {
    public static void main(String[] args) {
        int score = 85;
        boolean passed = score >= 60;
        
        // 判断是否及格
        if (passed) {
            System.out.println("及格");
            
            // 判断等级
            if (score >= 90) {
                System.out.println("等级：优秀");
            } else if (score >= 80) {
                System.out.println("等级：良好");
            } else {
                System.out.println("等级：中等");
            }
        } else {
            System.out.println("不及格，需要补考");
        }
        
        // 使用三元运算符
        String status = passed ? "通过" : "不通过";
        System.out.println("状态：" + status);
    }
}
```

### 示例 4：多条件判断

```java
public class ComplexCondition {
    public static void main(String[] args) {
        int age = 20;
        boolean hasLicense = true;
        boolean hasInsurance = true;
        
        // 复杂条件判断
        if (age >= 18) {
            if (hasLicense) {
                if (hasInsurance) {
                    System.out.println("可以合法驾驶");
                } else {
                    System.out.println("需要购买保险");
                }
            } else {
                System.out.println("需要驾照");
            }
        } else {
            System.out.println("年龄不够，不能驾驶");
        }
        
        // 简化版本
        if (age >= 18 && hasLicense && hasInsurance) {
            System.out.println("可以合法驾驶");
        } else if (age >= 18 && hasLicense) {
            System.out.println("需要购买保险");
        } else if (age >= 18) {
            System.out.println("需要驾照");
        } else {
            System.out.println("年龄不够，不能驾驶");
        }
    }
}
```

## if vs switch 选择建议

### 使用 if 的场景

- 条件复杂（多个条件组合）
- 范围判断（如 `score >= 80`）
- 布尔条件
- 条件数量少（2-3 个）

### 使用 switch 的场景

- 多个离散值判断
- 值比较（`==`）
- 代码更清晰易读
- 条件数量多（4 个以上）

### 性能考虑

- **if-else**：按顺序检查条件，找到匹配后停止
- **switch**：对于整数，编译器可能优化为跳转表，性能更好

## 小结

Java 流程控制要点：

- **if-else**：条件判断，支持嵌套
- **switch**：多值选择，注意 break 的使用
- **三元运算符**：简单的条件表达式
- **嵌套**：合理使用，避免过度嵌套

**关键要点**：
- if 条件必须是布尔表达式
- 推荐始终使用大括号
- switch 注意 break 的使用，避免穿透
- Java 14+ 支持 switch 表达式
- 根据场景选择 if 或 switch

掌握了流程控制，你就能编写有逻辑的程序。在下一章，我们将学习 Java 的循环结构。
