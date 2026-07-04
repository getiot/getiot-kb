---
sidebar_position: 4
---

# R 语言基础语法



## 编程方式

开始 R 语言编程的最简单的方式，就是在命令行中执行 **R** 命令进入交互式的编程窗口，执行完这个命令后会调出 R 语言的解释器，我们在 > 符后面输入代码即可。

一门新的语言学习一般是从输出 "Hello, World!" 程序开始，R 语言的 "Hello, World!" 程序代码如下：

```R showLineNumbers
myString <- "Hello, World!"
print ( myString )
```

在交互式的编程窗口中依次输入上述两行代码，即可看到输出结果。

以上实例将字符串 "Hello, World!" 赋值给 myString 变量，然后使用 print() 函数输出。

**注意**：R 语言赋值使用的是左箭头 `<-` 符号，不过一些新版本也支持等号 `=`。

交互式的编程窗口虽然简单，但是不利于保存代码，因此我们可以将 R 代码保存为脚本文件（R 语言文件后缀为 **.R**），再通过 Rscript 命令执行该脚本。例如，我们可以将上面代码保存为一个 hello-world.R 文件，然后执行：

```bash
$ Rscript hello-world.R 
[1] "Hello, World!"
```

代码仓库：[https://github.com/getiot/r-courses](https://github.com/getiot/r-courses)



## 变量

R 语言的有效的变量名称由字母、数字以及点号 `.` 或下划线 `_` 组成。变量名称以字母或点开头，下表列出了变量命名的示例。

| 变量名             | 是否正确 | 原因                                               |
| :----------------- | :------- | :------------------------------------------------- |
| var_name2.         | 正确     | 字符开头，并由字母、数字、下划线和点号组成         |
| var_name%          | 错误     | % 是非法字符                                       |
| 2var_name          | 错误     | 不能数字开头                                       |
| .var_name,var.name | 正确     | 可以 . 号开头，但是要注意 . 号开头后面不能跟着数字 |
| .2var_name         | 错误     | . 号开头后面不能跟着数字                           |
| _var_name          | 错误     | 不能以下划线 _ 开头                                |



## 变量赋值

最新版本的 R 语言的赋值可以使用左箭头 `<-`、等号 `=`、右箭头 `->` 赋值：

```R showLineNumbers
# 使用等号 = 号赋值
> var.1 = c(0,1,2,3)          
> print(var.1)
[1] 0 1 2 3

# 使用左箭头 <-赋值
> var.2 <- c("learn","R")  
> print(var.2)
[1] "learn" "R"
   
# 使用右箭头 -> 赋值
> c(TRUE,1) -> var.3
> print(var.3)
[1] 1 1   
```

查看已定义的变量可以使用 `ls()` 函数：

```R showLineNumbers
> print(ls())
[1] "var.1" "var.2" "var.3"
```

删除变量可以使用 `rm()` 函数：

```R showLineNumbers
> rm(var.3)
> print(ls())
[1] "var.1" "var.2"
```



## 注释

注释就像在 R 程序中帮助文本，并且在执行实际程序时被解释器忽略。单个注释在语句的开头使用 `#` 写成如下：

```r showLineNumbers
# My first program in R Programming
R
```

R 不支持多行注释，但可以执行以下操作：

```r showLineNumbers
if(FALSE) {
   "This is a demo for multi-line comments and it should be put inside either a single
      OR double quote"
}

myString <- "Hello, World!"
print ( myString)
R
```

虽然上述注释由 R 解释器执行，但不会干扰你的实际编程代码。所以我们可以把要注释的内容放入单引号或双引号中。

