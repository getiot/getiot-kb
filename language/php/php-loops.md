---
sidebar_position: 8
---

# PHP 循环语句

在实际编程中，你经常会遇到需要重复执行一段代码的情况，比如遍历数组、处理用户数据等。为了避免重复写相同的代码，PHP 提供了几种常用的循环结构，让你可以**高效地处理重复任务**。

PHP 提供的主要循环类型包括：

- `while` 循环
- `do...while` 循环
- `for` 循环
- `foreach` 循环



## while 循环

只要指定的条件为 `true`，`while` 循环就会一直执行。它会**先判断条件**，再执行代码块。

**语法：**

```php
while (condition) {
    // 条件为 true 时重复执行这里的代码
}
```

**示例：**

```php
<?php
$i = 0;
while ($i < 5) {
    echo "当前值是：$i <br>";
    $i++;
}
?>
```



## do...while 循环

`do...while` 和 `while` 不同的是，它会**先执行一次代码**，然后再判断条件是否为 `true`。

**语法：**

```php
do {
    // 先执行这里
} while (condition);
```

**示例：**

```php
<?php
$i = 0;
do {
    echo "当前值是：$i <br>";
    $i++;
} while ($i < 5);
?>
```

即使初始条件不成立，`do...while` 也至少会执行一次。



## for 循环

`for` 循环是结构最紧凑、最常用的一种循环方式，适用于**已知重复次数**的场景。

**语法：**

```php
for (初始表达式; 条件; 每次迭代后的操作) {
    // 执行的代码
}
```

**示例：**

```php
<?php
for ($i = 0; $i < 5; $i++) {
    echo "当前值是：$i <br>";
}
?>
```



## foreach 循环

`foreach` 是专门用来遍历数组或对象的。它非常适合处理集合类数据结构。

**语法（遍历值）：**

```php
foreach ($array as $value) {
    // 使用 $value
}
```

**语法（遍历键值对）：**

```php
foreach ($array as $key => $value) {
    // 使用 $key 和 $value
}
```

**示例：**

```php
<?php
$colors = ["red", "green", "blue"];
foreach ($colors as $color) {
    echo "颜色：$color <br>";
}
?>
```



## 循环控制语句：break 和 continue

你还可以使用 `break` 和 `continue` 来控制循环的执行过程：

- `break`：**跳出整个循环**
- `continue`：**跳过本次循环，继续下一轮**

**示例：**

```php
<?php
for ($i = 0; $i < 10; $i++) {
    if ($i == 5) {
        break;  // 当 i 等于 5 时跳出循环
    }
    echo "$i <br>";
}
?>
```



## 小结

循环语句是 PHP 编程中的基础工具，它可以帮你重复执行任务、处理数据集合、控制流程逻辑。你可以根据实际需求选择使用 `while`、`do...while`、`for` 或 `foreach` 循环，并配合 `break` 和 `continue` 实现更灵活的控制。一旦掌握这些循环技巧，你的代码就能更加高效、优雅！
