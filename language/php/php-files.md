---
sidebar_position: 14
---

# PHP 文件读写

在日常开发中，你经常需要和文件打交道，比如读取配置文件、写日志、上传用户数据等。PHP 提供了一系列函数，让你可以方便地**创建、读取、写入、删除文件**。



## 打开文件

使用 `fopen()` 函数可以打开一个文件。它的基本语法如下：

```php
fopen(filename, mode);
```

参数说明：

- `filename`：你要打开的文件名（可以是相对或绝对路径）
- `mode`：打开方式（常用如 `r`、`w`、`a` 等）

常见模式说明：

| 模式 | 描述                                   |
| :--: | -------------------------------------- |
| `r`  | 只读，从文件开头开始                   |
| `r+` | 读写，从文件开头开始                   |
| `w`  | 只写，从开头写（会清空原内容）         |
| `w+` | 读写，从开头写（会清空原内容）         |
| `a`  | 追加写入，从末尾写                     |
| `a+` | 读写，从末尾写                         |
| `x`  | 创建新文件并写入，如果文件已存在则失败 |



## 写入文件

如果你想把内容写入文件，可以使用 `fwrite()` 函数。配合 `fopen()` 一起使用。

示例：

```php
<?php
$file = fopen("example.txt", "w");
fwrite($file, "Hello, 文件世界！");
fclose($file);
?>
```

这个例子会创建（或清空）`example.txt` 文件，并写入一行内容。



## 读取文件内容

使用 `fread()` 读取文件内容：

```php
<?php
$file = fopen("example.txt", "r");
$content = fread($file, filesize("example.txt"));
fclose($file);
echo $content;
?>
```

`fread()` 会读取指定长度的文件内容（通常用 `filesize()` 获取文件大小）。

除了 `fread()`  函数，还有一种更简单的读取 —— 使用 `file_get_contents()`。如果你只需要快速读取整个文件内容，可以使用它。例如：

```php
<?php
$content = file_get_contents("example.txt");
echo $content;
?>
```

这是非常常用且简洁的方式。



## 将内容写入文件（简洁写法）

同样，对于写入文件，也有一种简洁的写法 —— 使用 `file_put_contents()`。

这个函数可以快速把字符串写入文件，不需要手动打开或关闭文件。

```php
<?php
file_put_contents("log.txt", "访问记录时间：" . date("Y-m-d H:i:s") . "\n", FILE_APPEND);
?>
```

加上 `FILE_APPEND` 参数表示追加模式写入，否则会覆盖。



## 删除文件

如果你需要删除一个文件，可以使用 `unlink()` 函数。例如：

```php
<?php
unlink("example.txt");
?>
```

⚠️ 请小心使用，删除后文件无法恢复。



## 检查文件是否存在

如果你想检查一个文件是否存在，可以使用 `file_exists()` 函数。例如：

```php
<?php
if (file_exists("config.txt")) {
    echo "文件存在";
} else {
    echo "文件不存在";
}
?>
```



## 目录操作

在 PHP 中，你可以使用以下函数操作目录：

- `mkdir("test")`：创建目录
- `rmdir("test")`：删除空目录
- `scandir(".")`：列出当前目录下的文件和子目录



## 错误处理

建议使用 `is_writable()` 或 `is_readable()` 判断文件是否可写/读，避免报错。

```php
<?php
if (is_writable("data.txt")) {
    file_put_contents("data.txt", "追加内容", FILE_APPEND);
} else {
    echo "文件不可写";
}
?>
```



## 注意事项

- **限制上传目录权限**，不要让用户上传任意 PHP 脚本。
- 避免使用用户输入构造文件路径（防止目录遍历攻击）。
- 使用 `basename()` 函数提取安全文件名。
- 写文件时建议使用日志目录，不要和程序代码混在一起。



## 小结

PHP 提供了强大的文件操作功能，无论是读写文本文件，还是日志记录、配置加载，你都能轻松实现。记住合理使用 `fopen()`、`fread()`、`fwrite()` 等基础函数，并掌握 `file_get_contents()` 和 `file_put_contents()` 这类快捷方法，会大大提升你处理文件的效率。
