---
sidebar_position: 4
---

# PHP 数据类型

在 PHP 中，变量是弱类型的，也就是说你可以在声明变量时不指定其数据类型。PHP 会根据变量的值自动判断其类型。尽管如此，理解 PHP 中支持的数据类型仍然非常重要。这样你才能更准确地操作变量、控制程序流程，甚至在调试中快速定位问题。

PHP 提供了八种数据类型，它们可以分为简单类型和复合类型。简单类型包括整数、浮点数、布尔值和 NULL，而复合类型则包括字符串、数组和对象。此外，资源类型用于存储外部资源的引用。



## 简单数据类型

### 整数（Integer）

整数是不带小数点的数字，例如 `4195` 或 `-200`。在 PHP 中，整数可以用十进制、十六进制、八进制或二进制表示：

```php showLineNumbers
$decimal = 123;    // 十进制
$octal = 0o177;    // 八进制（以 0o 开头）
$hex = 0x1A;       // 十六进制（以 0x 开头）
$binary = 0b1010;  // 二进制（以 0b 开头）
```

整数可以直接赋值给变量，或用于数学运算：

```php showLineNumbers
$num = 42;
$result = 100 - $num;  // 结果为 58
```

### 浮点数（Double）

浮点数是带有小数部分的数字，例如 `3.14` 或 `-0.5`。PHP 支持科学计数法表示大数或小数：

```php showLineNumbers
$float1 = 1.5;
$float2 = 1.2e3;  // 1200
$float3 = 2.3e-4; // 0.00023
```

浮点数运算可能会有精度问题，因此在处理货币等需要精确值的场景时需谨慎。

### 布尔值（Boolean）

布尔值只有两个可能的值：`true` 和 `false`。它们常用于条件判断：

```php showLineNumbers
$is_active = true;
$isAdmin = false;
```

PHP 会自动将其他类型转换为布尔值：

- 数字 `0`、空字符串 `""`、空数组 `[]` 和 `NULL` 转换为 `false`
- 其他值转换为 `true`

### NULL

`NULL` 表示“无值”或“空值”。未定义的变量或被 `unset()` 的变量值为 `NULL`：

```php showLineNumbers
$var = null;
var_dump($var);  // 输出 NULL
```



## 复合数据类型

### 字符串（String）

字符串是由字符组成的序列，用单引号或双引号括起来：

```php showLineNumbers
$str1 = 'Hello World';  // 单引号
$str2 = "PHP is fun";   // 双引号
```

双引号字符串支持变量解析和特殊字符转义：

```php showLineNumbers
$name = "GetIoT";
echo "My name is $name";  // 输出 My name is GetIoT
echo "New line: \n Tab: \t";  // 转义字符
```

多行字符串可以用 `heredoc` 或 `nowdoc` 语法：

```php showLineNumbers
$multiLine = <<<EOD
This is line 1.
This is line 2.
EOD;

$rawString = <<<'EOD'
No parsing here: $name
EOD;
```

### 数组（Array）

数组是键值对的集合，可以存储多个值：

```php showLineNumbers
// 索引数组
$fruits = ['apple', 'banana', 'orange'];

// 关联数组
$person = [
    'name' => 'GetIoT',
    'age' => 25
];

// 多维数组
$matrix = [
    [1, 2, 3],
    [4, 5, 6]
];
```

数组的键可以是整数或字符串，值可以是任意类型。

### 对象（Object）

对象是类的实例，包含属性和方法：

```php showLineNumbers
class User {
    public $name;
    
    function greet() {
        return "Hello, my name is " . $this->name;
    }
}

$user = new User();
$user->name = "GetIoT";
echo $user->greet();  // 输出 Hello, my name is GetIoT
```



## 资源（Resource）

资源是对外部资源（如文件句柄、数据库连接）的引用：

```php showLineNumbers
$file = fopen("example.txt", "r");
// 使用 $file 操作文件
fclose($file);
```

资源类型是特殊的，不能直接创建，只能通过特定函数获取。



## 检测数据类型

你可以使用 `gettype()` 函数获取变量的数据类型：

```php showLineNumbers
$var1 = 10;
$var2 = 3.14;
$var3 = "Hello";

echo gettype($var1);  // 输出 integer
echo gettype($var2);  // 输出 double
echo gettype($var3);  // 输出 string
```

除了 `gettype()` 函数，你也可以使用 `var_dump()` 来检查 PHP 中变量的类型，它会显示变量的类型、值和更详细的信息（比如字符串长度、数组结构、对象属性等）。

```php showLineNumbers
$var1 = 10;
$var2 = 3.14;
$var3 = "Hello";

var_dump($var1);
var_dump($var2);
var_dump($var3);
```

输出结果：

```php
int(10)
float(3.14)
string(5) "Hello"
```



## 小结

PHP 的数据类型系统为程序提供了强大的灵活性。简单类型（整数、浮点数、布尔值、NULL）用于存储基本值，而复合类型（字符串、数组、对象）则用于组织复杂数据结构。字符串是 Web 开发中使用最频繁的类型之一，掌握其用法尤为重要。资源类型虽然特殊，但在处理外部系统时不可或缺。理解这些数据类型及其用法，是成为 PHP 开发者的基础。
