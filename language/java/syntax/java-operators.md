---
sidebar_position: 5
slug: /java-operators
sidebar_label: Java 运算符
---

# Java 运算符

运算符是用于执行各种运算的符号。Java 提供了丰富的运算符，包括算术、关系、逻辑、位运算等。理解运算符的用法和优先级，是编写正确 Java 程序的基础。

## 算术运算符、关系运算符、逻辑运算符

### 算术运算符

用于执行基本的数学运算。

| 运算符 | 说明 | 示例 | 结果 |
|:------:|:----:|:----:|:----:|
| + | 加法 | 10 + 5 | 15 |
| - | 减法 | 10 - 5 | 5 |
| * | 乘法 | 10 * 5 | 50 |
| / | 除法 | 10 / 5 | 2 |
| % | 取模（余数） | 10 % 3 | 1 |
| ++ | 自增 | a++ 或 ++a | a + 1 |
| -- | 自减 | a-- 或 --a | a - 1 |

#### 基本算术运算

```java
int a = 10;
int b = 3;

System.out.println(a + b);  // 13
System.out.println(a - b);  // 7
System.out.println(a * b);  // 30
System.out.println(a / b);  // 3（整数除法）
System.out.println(a % b);  // 1（余数）

// 浮点数除法
double x = 10.0;
double y = 3.0;
System.out.println(x / y);  // 3.333...
```

#### 自增和自减

```java
int a = 10;

// 后置自增：先使用，后自增
int b = a++;  // b = 10, a = 11

// 前置自增：先自增，后使用
int c = ++a;  // a = 12, c = 12

// 自减同理
int d = a--;  // d = 12, a = 11
int e = --a;  // a = 10, e = 10
```

**区别**：
- `a++`：先使用 a 的值，然后 a 自增
- `++a`：先 a 自增，然后使用 a 的值

### 关系运算符

用于比较两个值的大小关系，返回布尔值。

| 运算符 | 说明 | 示例 | 结果 |
|:------:|:----:|:----:|:----:|
| == | 等于 | 10 == 5 | false |
| != | 不等于 | 10 != 5 | true |
| > | 大于 | 10 > 5 | true |
| \< | 小于 | 10 \< 5 | false |
| >= | 大于等于 | 10 >= 5 | true |
| \<= | 小于等于 | 10 \<= 5 | false |

```java
int a = 10;
int b = 5;

System.out.println(a == b);  // false
System.out.println(a != b);  // true
System.out.println(a > b);   // true
System.out.println(a < b);   // false
System.out.println(a >= b);  // true
System.out.println(a \<= b);  // false
```

**注意**：
- `==` 比较的是值（基本类型）或引用（对象类型）
- 对于对象，`==` 比较的是引用，不是内容
- 比较对象内容使用 `equals()` 方法

```java
String str1 = "hello";
String str2 = "hello";
String str3 = new String("hello");

System.out.println(str1 == str2);  // true（字符串常量池）
System.out.println(str1 == str3);  // false（不同对象）
System.out.println(str1.equals(str3));  // true（内容相同）
```

### 逻辑运算符

用于组合多个布尔表达式。

| 运算符 | 说明 | 示例 | 结果 |
|:------:|:----:|:----:|:----:|
| && | 逻辑与（短路） | true && false | false |
| \|\| | 逻辑或（短路） | true \|\| false | true |
| ! | 逻辑非 | !true | false |
| & | 逻辑与（非短路） | true & false | false |
| \| | 逻辑或（非短路） | true \| false | true |
| ^ | 逻辑异或 | true ^ false | true |

#### 短路逻辑运算符

```java
int a = 10;
int b = 5;

// &&：如果左边为 false，右边不执行（短路）
if (a > 0 && b > 0) {
    System.out.println("都大于 0");
}

// ||：如果左边为 true，右边不执行（短路）
if (a > 0 || b < 0) {
    System.out.println("至少一个满足");
}

// !：取反
boolean flag = true;
if (!flag) {
    System.out.println("flag 为 false");
}
```

**短路特性示例**：

```java
int a = 10;

// 短路：a > 0 为 true，继续检查 a < 5
if (a > 0 && a < 5) {
    // 不会执行
}

// 短路：a > 0 为 true，右边不执行
if (a > 0 || (a = 20) > 0) {
    // a 仍然是 10，不是 20
}
```

#### 非短路逻辑运算符

```java
int a = 10;

// 非短路：即使左边为 false，右边也会执行
if (a < 0 & (a = 20) > 0) {
    // a 变为 20
}

// 非短路：即使左边为 true，右边也会执行
if (a > 0 | (a = 30) > 0) {
    // a 变为 30
}
```

**使用建议**：通常使用 `&&` 和 `||`（短路版本），性能更好且更安全。

## 位运算符、三元运算符

### 位运算符

用于对二进制位进行操作。

| 运算符 | 说明 | 示例 | 结果 |
|:------:|:----:|:----:|:----:|
| & | 按位与 | 5 & 3 | 1 |
| \| | 按位或 | 5 \| 3 | 7 |
| ^ | 按位异或 | 5 ^ 3 | 6 |
| ~ | 按位取反 | ~5 | -6 |
| \<\< | 左移 | 5 \<\< 1 | 10 |
| >> | 右移（有符号） | 5 >> 1 | 2 |
| >>> | 右移（无符号） | -5 >>> 1 | 2147483645 |

#### 按位与（&）

```java
int a = 5;  // 二进制：101
int b = 3;  // 二进制：011

int result = a & b;  // 001 = 1
//   101
// & 011
// ----
//   001
```

#### 按位或（|）

```java
int a = 5;  // 101
int b = 3;  // 011

int result = a | b;  // 111 = 7
//   101
// | 011
// ----
//   111
```

#### 按位异或（^）

```java
int a = 5;  // 101
int b = 3;  // 011

int result = a ^ b;  // 110 = 6
//   101
// ^ 011
// ----
//   110
```

**异或的特性**：
- `a ^ a = 0`
- `a ^ 0 = a`
- 可用于交换两个数（不使用临时变量）

```java
int a = 5;
int b = 3;

// 交换两个数
a = a ^ b;  // a = 6
b = a ^ b;  // b = 5
a = a ^ b;  // a = 3
```

#### 位移运算符

```java
int a = 5;  // 二进制：101

// 左移：相当于乘以 2 的 n 次方
int left = a << 1;   // 1010 = 10（5 * 2）
int left2 = a << 2;  // 10100 = 20（5 * 4）

// 右移（有符号）：相当于除以 2 的 n 次方
int right = a >> 1;   // 10 = 2（5 / 2）
int right2 = a >> 2;  // 1（5 / 4）

// 右移（无符号）：高位补 0
int unsigned = -5 >>> 1;  // 正数
```

### 三元运算符

**语法**：`条件 ? 值1 : 值2`

如果条件为 true，返回值1；否则返回值2。

```java
int a = 10;
int b = 5;

// 如果 a > b，返回 a，否则返回 b
int max = a > b ? a : b;  // 10

// 等价于
int max;
if (a > b) {
    max = a;
} else {
    max = b;
}
```

**嵌套使用**：

```java
int score = 85;
String grade = score >= 90 ? "A" : 
               score >= 80 ? "B" : 
               score >= 70 ? "C" : "D";
// grade = "B"
```

**使用建议**：
- 简单的条件判断可以使用三元运算符
- 复杂的逻辑建议使用 if-else
- 嵌套不要超过 2 层

## 运算符优先级与表达式求值顺序

### 运算符优先级

从高到低：

1. **一元运算符**：`++`, `--`, `!`, `~`, `+`, `-`（正负号）
2. **乘除模**：`*`, `/`, `%`
3. **加减**：`+`, `-`
4. **位移**：`<<`, `>>`, `>>>`
5. **关系**：`<`, `>`, `<=`, `>=`, `instanceof`
6. **相等**：`==`, `!=`
7. **按位与**：`&`
8. **按位异或**：`^`
9. **按位或**：`|`
10. **逻辑与**：`&&`
11. **逻辑或**：`||`
12. **三元**：`? :`
13. **赋值**：`=`, `+=`, `-=`, `*=`, `/=`, `%=`, `&=`, `|=`, `^=`, `<<=`, `>>=`, `>>>=`

### 优先级示例

```java
int a = 10;
int b = 5;
int c = 2;

// 乘除优先于加减
int result1 = a + b * c;      // 10 + 10 = 20（不是 30）
int result2 = (a + b) * c;    // 30

// 关系运算符优先于逻辑运算符
boolean result3 = a > b && b > c;  // true && true = true

// 一元运算符优先
int result4 = -a + b;  // -10 + 5 = -5
```

### 表达式求值顺序

**从左到右**（除了赋值运算符从右到左）：

```java
int a = 10;
int b = 5;

// 从左到右求值
int result = a + b - 3;  // 先算 a + b，再减 3

// 赋值从右到左
int x = y = 10;  // 先 y = 10，再 x = y
```

### 使用括号

**建议**：不确定优先级时，使用括号明确表达意图：

```java
// 不清晰
int result = a + b * c - d / e;

// 清晰
int result = a + (b * c) - (d / e);
```

## 赋值运算符

### 基本赋值

```java
int a = 10;  // 赋值
```

### 复合赋值

| 运算符 | 等价于 | 示例 |
|:------:|:-----:|:----:|
| += | a = a + b | a += b |
| -= | a = a - b | a -= b |
| *= | a = a * b | a *= b |
| /= | a = a / b | a /= b |
| %= | a = a % b | a %= b |
| &= | a = a & b | a &= b |
| \|= | a = a \| b | a \|= b |
| ^= | a = a ^ b | a ^= b |
| \<\<= | a = a \<\< b | a \<\<= b |
| >>= | a = a >> b | a >>= b |
| >>>= | a = a >>> b | a >>>= b |

```java
int a = 10;

a += 5;   // a = 15
a -= 3;   // a = 12
a *= 2;   // a = 24
a /= 4;   // a = 6
a %= 4;   // a = 2
```

## 实际示例

### 示例 1：综合运算

```java
public class OperatorExample {
    public static void main(String[] args) {
        int a = 10;
        int b = 3;
        
        // 算术运算
        System.out.println("a + b = " + (a + b));  // 13
        System.out.println("a - b = " + (a - b));  // 7
        System.out.println("a * b = " + (a * b));  // 30
        System.out.println("a / b = " + (a / b));  // 3
        System.out.println("a % b = " + (a % b));  // 1
        
        // 关系运算
        System.out.println("a > b: " + (a > b));   // true
        System.out.println("a == b: " + (a == b));  // false
        
        // 逻辑运算
        boolean x = true;
        boolean y = false;
        System.out.println("x && y: " + (x && y));  // false
        System.out.println("x || y: " + (x || y));  // true
        
        // 三元运算符
        int max = a > b ? a : b;
        System.out.println("最大值: " + max);  // 10
    }
}
```

### 示例 2：位运算应用

```java
public class BitwiseExample {
    public static void main(String[] args) {
        int a = 5;  // 101
        int b = 3;  // 011
        
        System.out.println("a & b = " + (a & b));  // 1
        System.out.println("a | b = " + (a | b));  // 7
        System.out.println("a ^ b = " + (a ^ b));  // 6
        
        // 左移：乘以 2
        System.out.println("a << 1 = " + (a << 1));  // 10
        
        // 右移：除以 2
        System.out.println("a >> 1 = " + (a >> 1));  // 2
        
        // 判断奇偶（使用 & 1）
        System.out.println("a 是奇数: " + ((a & 1) == 1));  // true
    }
}
```

### 示例 3：优先级示例

```java
public class PrecedenceExample {
    public static void main(String[] args) {
        int a = 10;
        int b = 5;
        int c = 2;
        
        // 注意优先级
        int result1 = a + b * c;        // 20（不是 30）
        int result2 = (a + b) * c;      // 30
        
        boolean result3 = a > b && b > c;  // true
        
        // 使用括号明确意图
        int result4 = (a + b) * (c + 1);  // 45
        
        System.out.println("result1 = " + result1);
        System.out.println("result2 = " + result2);
        System.out.println("result3 = " + result3);
        System.out.println("result4 = " + result4);
    }
}
```

## 小结

Java 运算符要点：

- **算术运算符**：+、-、*、/、%、++、--
- **关系运算符**：==、!=、>、\<、>=、\<=
- **逻辑运算符**：&&、||、!（注意短路特性）
- **位运算符**：&、|、^、~、\<\<、>>、>>>
- **三元运算符**：条件 ? 值1 : 值2
- **优先级**：一元 > 乘除 > 加减 > 关系 > 逻辑 > 赋值

**关键要点**：
- 注意整数除法和浮点数除法的区别
- 理解前置和后置自增/自减的区别
- 使用 `&&` 和 `||` 的短路特性提高性能
- 对象比较使用 `equals()`，不要用 `==`
- 不确定优先级时使用括号
- 位运算可用于性能优化

掌握了运算符，你就能编写各种计算和判断的代码。在下一章，我们将学习 Java 的流程控制语句。
