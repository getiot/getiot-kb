---
sidebar_position: 3
---

# PHP 基础语法



## PHP 标记

在进行PHP开发时，一般是先编写一个简单的HTML网页，然后将PHP代码嵌入到HTML中。为了区分HTML与PHP代码，需要使用标记对PHP代码进行标识。如下面的代码所示。

```php showLineNumbers
<body>
  <p>Hello HTML </p>
  <p><?php echo 'Hello, PHP'; ?></p>
</body>
```

上述示例中，`<?php echo 'Hello, PHP'; ?>` 是一段嵌入在 HTML 中的 PHP 代码。其中，`<?php` 是 PHP 开始标记，`?>` 是 PHP 结束标记，echo 用于输出字符串。

另外，在 PHP 的开发中，有时也需要编写一个纯 PHP 代码的文件，此时应省略结束标记，并且开始标记要顶格书写。下面是一个纯 PHP 文件的代码示例。

```php showLineNumbers
 <?php
 echo 'Happy Coding, Happy Life.';
```

在 PHP 中还有一种常用的标记，以 `<?` 开始，以 `?>` 结束，称为短标记。在使用时，需在 php.ini 文件中设置 `short_open_tag` 的值为 `on`。短标记的示例代码如下。

```php showLineNumbers
 <?
 echo 'Happy Coding, Happy Life.';
 ?>
```

需要注意的是，为了保证程序的兼容性，不推荐使用这种标记。



## 语句结束符

在PHP中，当一条语句结束后，需要写上语句结束符“;”。如果没有写语句结束符，则PHP程序在运行时就会报错。

例如，在下面的代码没有写语句结束符。

```php showLineNumbers
<?php
echo 'Happy Coding, Happy Life.'
```

当上述代码执行后，网页中会显示类似于 `syntax error, unexpected end of file, expecting ',' or ';'` 的错误信息。



## 代码注释

注释是对程序代码的解释和说明，使代码更易于阅读与维护，在解析时会被解析器忽略。在 PHP 中，最常用的两种注释分别为单行注释 `//` 和多行注释 `/* ... */`。

单行注释的示例代码如下。

```php showLineNumbers
echo 'Happy Coding, Happy Life.';  // 单行注释
```

多行注释的示例代码如下。

```php showLineNumbers
/*
  多行注释
*/
echo 'Happy Coding, Happy Life.';
```

