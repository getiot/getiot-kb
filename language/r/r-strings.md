---
sidebar_position: 9
---

# R 语言 - 字符串



字符串用于存储文本。

在 R 语言中，字符串用单引号或双引号括起来：

```R showLineNumbers
"hello"
'hello'
```

`"hello"` 和 `'hello'` 是一样的。



## 字符串变量赋值

将字符串分配给变量是通过变量后跟 `<-` 运算符和字符串来完成的，例如：

```R showLineNumbers
str <- "Hello"
str # print the value of str
```



## 多行字符串

你可以将多行字符串分配给一个变量，例如：

```R showLineNumbers
str <- "The only way to do great work is to love what you do. 
If you haven’t found it yet, keep looking. Don’t settle. 
As with all matters of the heart, 
you’ll know when you find it."

str # print the value of str
```

但是，请注意 R 会在每个换行符的末尾添加一个 `\n`。这称为转义字符，表示**换行**。

如果要将换行符插入与代码中相同的位置，请使用 `cat()` 函数：

```R showLineNumbers
str <- "The only way to do great work is to love what you do. 
If you haven’t found it yet, keep looking. Don’t settle. 
As with all matters of the heart, 
you’ll know when you find it."

cat(str)
```



## 字符串长度

R 中有许多有用的字符串函数。

例如，要查找字符串中的字符数，可使用 `nchar()` 函数：

```R showLineNumbers
str <- "Hello World!"

nchar(str)
```



## 检查字符串

使用 `grepl()` 函数检查字符串中是否存在一个字符或字符序列：

```R showLineNumbers
str <- "Hello World!"

grepl("H", str)        # TRUE
grepl("Hello", str)    # TRUE
grepl("X", str)        # FALSE
```



## 合并字符串

使用 `paste()` 函数合并/连接两个字符串：

```R showLineNumbers
str1 <- "Hello"
str2 <- "World"

paste(str1, str2)
```



## 转义字符

要在字符串中插入非法字符，你必须使用转义字符（escape character）。转义字符是反斜杠 `\` 后跟要插入的字符。

非法字符的一个示例是字符串中的双引号被双引号包围：

```R showLineNumbers
str <- "We are the so-called "Vikings", from the north."

str
```

上述代码是错误的，执行时提示：

```R showLineNumbers
Error: unexpected symbol in "str <- "We are the so-called "Vikings"
```

解决办法是在双引号前使用转义字符 `\"`：

```R showLineNumbers
str <- "We are the so-called \"Vikings\", from the north."

str
cat(str)
```

请注意，自动打印 **str** 变量将在输出中打印反斜杠，可以使用 `cat()` 函数打印它而不使用反斜杠。

R 中的其他转义字符：

| 转义字符 | 说明                      |
| :------- | :------------------------ |
| `\\`     | 反斜杠（Backslash）       |
| `\n`     | 换行符（New Line）        |
| `\r`     | 回车符（Carriage Return） |
| `\t`     | 制表符（Tab）             |
| `\b`     | 退格（Backspace）         |

