---
sidebar_position: 5
---

# PHP 常量

常量是 PHP 中一种特殊的标识符，一旦定义后，其值在整个脚本中不能被改变。常量的命名规则与变量类似，由英文字母、下划线和数字组成，但首字符不能是数字。与变量不同的是，常量名前面不需要加 `$` 符号。



## 定义常量

在 PHP 中，使用 `define()` 函数定义常量。该函数的基本语法如下：

```php
bool define ( string $name , mixed $value [, bool $case_insensitive = false ] )
```

- **`$name`**：必选参数，指定常量的名称。
- **`$value`**：必选参数，指定常量的值。
- **`$case_insensitive`**：可选参数，如果设置为 `true`，则常量名称大小写不敏感，默认为大小写敏感。

### 示例：定义区分大小写的常量

```php
<?php
define("GREETING", "Welcome to w3cschool.cn!");
echo GREETING; // 输出 "Welcome to w3cschool.cn!"
?>
```

### 示例：定义不区分大小写的常量

```php
<?php
define("GREETING", "Welcome to w3cschool.cn!", true);
echo greeting; // 输出 "Welcome to w3cschool.cn!"
?>
```



## 常量的全局性

常量在定义后，默认是全局的，可以在整个脚本的任何地方使用，包括在函数内部。即使常量定义在函数外部，函数内部仍然可以访问它。

### 示例：在函数内部使用常量

```php
<?php
define("GREETING", "欢迎访问 W3cschool.cn");

function myTest() {
    echo GREETING;
}

myTest(); // 输出 "欢迎访问 W3cschool.cn"
?>
```



## 常量与变量的区别

- **值的可变性**：常量的值一旦定义，不能被修改或重新定义；变量的值可以随时修改。
- **作用域**：常量默认是全局的，可以在任何地方访问；变量的作用域通常局限于其定义的范围（如函数内部）。
- **命名规则**：常量名不加 `$` 符号；变量名需要加 `$` 符号。



## 小结

PHP 常量是一种在脚本中存储固定值的方式，一旦定义，其值不能被改变。常量的定义通过 `define()` 函数完成，可以设置为大小写敏感或不敏感。常量的一个重要特点是全局性，可以在脚本的任何地方使用，这使得它非常适合存储在整个脚本中需要频繁使用的固定值，如数据库连接信息、网站标题等。
