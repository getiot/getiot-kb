---
sidebar_position: 9
---

# PHP 数组

在 PHP 中，如果你需要保存一组相关的数据（比如一系列学生的名字、商品价格列表等），就应该使用数组（array）。数组可以让你使用一个变量，存储多个值，这在开发中非常实用。

PHP 支持三种主要类型的数组：

1. **索引数组**（Indexed Arrays）：使用数字索引
2. **关联数组**（Associative Arrays）：使用字符串键名
3. **多维数组**（Multidimensional Arrays）：数组中的元素还是数组



## 索引数组

索引数组的键是从 `0` 开始的整数，常用于存储有序的数据列表。

**创建方式一（自动索引）：**

```php
<?php
$colors = array("red", "green", "blue");
?>
```

**创建方式二（手动索引）：**

```php
<?php
$colors[0] = "red";
$colors[1] = "green";
$colors[2] = "blue";
?>
```

**访问元素：**

```php
echo $colors[1]; // 输出 green
```

**遍历数组：**

```php
foreach ($colors as $value) {
    echo "$value <br>";
}
```



## 关联数组

关联数组用字符串作为键名，常用于表示带有含义的数据，比如姓名和年龄的对应关系。

**示例：**

```php
<?php
$age = array("Tom" => 25, "Jerry" => 22, "Spike" => 30);
echo $age["Jerry"]; // 输出 22
?>
```

**遍历数组：**

```php
foreach ($age as $name => $value) {
    echo "$name 年龄是 $value <br>";
}
```



## 多维数组

当数组中的元素本身还是数组时，就形成了多维数组，常用于处理表格数据。

**示例：**

```php
<?php
$contacts = array(
    "Tom" => array(
        "email" => "tom@example.com",
        "phone" => "123456"
    ),
    "Jerry" => array(
        "email" => "jerry@example.com",
        "phone" => "654321"
    )
);

echo $contacts["Jerry"]["email"]; // 输出 jerry@example.com
?>
```



## 有用的数组函数

PHP 提供了很多处理数组的内置函数，下面是一些常用的：

| 函数名           | 说明                       |
| ---------------- | -------------------------- |
| `count()`        | 获取数组中元素个数         |
| `array_merge()`  | 合并多个数组               |
| `in_array()`     | 检查某个值是否存在于数组中 |
| `array_keys()`   | 获取数组中的所有键名       |
| `array_values()` | 获取数组中的所有值         |
| `sort()`         | 对索引数组排序（升序）     |
| `asort()`        | 对关联数组按值排序         |
| `ksort()`        | 对关联数组按键名排序       |

**示例：**

```php
<?php
$fruits = array("banana", "apple", "orange");
sort($fruits);
print_r($fruits);
?>
```



## 小结

数组是 PHP 中最常用的数据结构之一，它可以帮你轻松管理多个值，无论是简单列表、键值对，还是更复杂的嵌套结构。掌握数组的创建、访问、遍历方式以及常见函数的使用，你就能更高效地处理各种数据操作场景。
