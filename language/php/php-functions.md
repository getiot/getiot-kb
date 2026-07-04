---
sidebar_position: 11
---

# PHP 函数

在开发过程中，当你需要多次重复执行某段逻辑时，函数就能派上用场了。通过将代码封装进函数中，你不仅可以**提高代码复用性**，还可以**让代码结构更清晰、可维护性更高**。

:::tip 

函数是一段**可重复使用的代码块**，你可以在程序中任何地方调用它。PHP 内置了大量函数（比如 `strlen()`、`date()` 等），你也可以自己定义函数。

:::



## 创建函数

你可以使用 `function` 关键字来定义自己的函数。

**语法：**

```php
function functionName() {
    // 函数体
}
```

**示例：**

```php
<?php
function sayHello() {
    echo "你好，世界！";
}

sayHello(); // 调用函数
?>
```



## 带参数的函数

你可以给函数传递参数（参数在函数定义时指定），这样函数可以处理不同的数据。

**语法：**

```php
function functionName($param1, $param2) {
    // 使用 $param1 和 $param2
}
```

**示例：**

```php
<?php
function greet($name) {
    echo "你好，$name！";
}

greet("小明");
greet("小红");
?>
```



## 带默认参数的函数

如果调用函数时没有提供某个参数，PHP 会使用默认值。

**示例：**

```php
<?php
function greet($name = "朋友") {
    echo "你好，$name！<br>";
}

greet();         // 输出：你好，朋友！
greet("小李");    // 输出：你好，小李！
?>
```



## 函数返回值

你可以使用 `return` 关键字让函数返回一个值，而不是直接输出结果。

**示例：**

```php
<?php
function add($a, $b) {
    return $a + $b;
}

$result = add(3, 5);
echo "结果是：$result";
?>
```



## 可变数量的参数

从 PHP 5.6 开始，你可以使用 `...` 语法传入任意多个参数。

**示例：**

```php
<?php
function sum(...$numbers) {
    $total = 0;
    foreach ($numbers as $num) {
        $total += $num;
    }
    return $total;
}

echo sum(1, 2, 3, 4); // 输出 10
?>
```



## 函数的作用域（Scope）

在函数内部定义的变量，默认是**局部变量**，在函数外部无法访问。若要在函数内部访问全局变量，可以使用 `global` 关键字或 `$GLOBALS` 数组。

**示例：**

```php
<?php
$a = 10;
$b = 20;

function sum() {
    global $a, $b;
    echo $a + $b;
}

sum(); // 输出 30
?>
```



## 递归函数

函数可以自己调用自己，这就是**递归函数**（Recursive Function）。递归通常用于处理像阶乘、树形结构等问题。

**示例：**

```php
<?php
function factorial($n) {
    if ($n === 0) return 1;
    return $n * factorial($n - 1);
}

echo factorial(5); // 输出 120
?>
```

⚠️ 写递归函数时一定要确保有终止条件，否则会陷入无限循环。



## 匿名函数（Closure）

PHP 还支持匿名函数，也叫闭包（Closure），可以用于函数式编程或作为参数传递。

**示例：**

```php
<?php
$greet = function($name) {
    return "你好，$name";
};

echo $greet("小强");
?>
```



## 内置函数示例

PHP 提供了成千上万个内置函数，比如：

- `strlen()`：计算字符串长度
- `strtoupper()`：转换为大写
- `array_merge()`：合并数组
- `date()`：获取当前日期
- `var_dump()`：输出变量类型和值

你可以随时在 [PHP 官方文档](https://www.php.net/manual/)中查找函数用法。



## 小结

函数是你组织和重用代码的好帮手。通过学习如何定义、调用、传参、返回值，以及理解作用域和递归等特性，你可以写出结构更清晰、逻辑更强大的 PHP 程序。掌握函数的使用，你就能写出更加模块化和优雅的代码。
