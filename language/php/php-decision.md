---
sidebar_position: 7
---

# PHP 条件语句

在实际开发中，你经常会根据不同的条件执行不同的代码逻辑。PHP 提供了多种条件语句（decision making statements）来帮你实现这些功能。

常见的 PHP 条件语句包括：

- `if` 语句
- `if...else` 语句
- `if...elseif...else` 语句
- `switch` 语句
- 三元运算符（`?:`）
- Null 合并运算符（`??`）



## if 语句

`if` 是最基本的条件语句。如果条件为 `true`，则执行 `if` 块中的代码。

**语法：**

```php
if (condition) {
    // 如果 condition 为 true，执行这里的代码
}
```

**示例：**

```php
<?php
$a = 10;
if ($a > 5) {
    echo "a 大于 5";
}
?>
```



## if...else 语句

当你想要在条件为 `false` 时执行其他代码，可以使用 `if...else`。

**语法：**

```php
if (condition) {
    // 条件为 true
} else {
    // 条件为 false
}
```

**示例：**

```php
<?php
$score = 60;
if ($score >= 60) {
    echo "及格";
} else {
    echo "不及格";
}
?>
```



## if...elseif...else 语句

当你有多个条件要判断时，可以使用 `if...elseif...else` 结构。

**语法：**

```php
if (condition1) {
    // 条件1为 true
} elseif (condition2) {
    // 条件2为 true
} else {
    // 以上都不满足
}
```

**示例：**

```php
<?php
$score = 85;
if ($score >= 90) {
    echo "优秀";
} elseif ($score >= 70) {
    echo "良好";
} elseif ($score >= 60) {
    echo "及格";
} else {
    echo "不及格";
}
?>
```



## switch 语句

当你有多个“相等判断”时，可以使用 `switch` 语句替代多个 `if...elseif`，让结构更清晰。

**语法：**

```php
switch (expression) {
    case value1:
        // 如果 expression == value1
        break;
    case value2:
        // 如果 expression == value2
        break;
    default:
        // 所有 case 都不匹配时执行
}
```

**示例：**

```php
<?php
$day = "Tue";
switch ($day) {
    case "Mon":
        echo "今天是星期一";
        break;
    case "Tue":
        echo "今天是星期二";
        break;
    case "Wed":
        echo "今天是星期三";
        break;
    default:
        echo "不是工作日";
}
?>
```

⚠️ 别忘了在每个 `case` 之后加上 `break;`，否则会继续执行下一个 `case`。



## 三元运算符（?:）

三元运算符是一种简洁的写法，用来根据条件返回不同的值。

**语法：**

```php
condition ? value_if_true : value_if_false;
```

**示例：**

```php
<?php
$age = 18;
echo ($age >= 18) ? "成年人" : "未成年人";
?>
```



## Null 合并运算符（??）

这个运算符可以判断变量是否存在，并且不为 `null`，如果不存在则返回默认值。它从 PHP 7 开始引入，非常适合用于处理表单数据等。

**语法：**

```php
$var = $_GET['name'] ?? "默认值";
```

**等价于：**

```php
$var = isset($_GET['name']) ? $_GET['name'] : "默认值";
```



## 小结

PHP 提供了多种条件判断方式，让你能根据不同情况控制程序的执行路径。无论是简单的 `if` 判断，还是复杂的 `switch` 分支，你都能灵活运用它们写出逻辑清晰、功能强大的代码。熟练掌握这些语句后，你就可以更自如地处理各种业务场景中的条件判断问题了。
