---
sidebar_position: 33
draft: true
---

# R 语言 - Excel 文件



Microsoft Excel是使用最广泛的电子表格程序，它是以`.xls`或`.xlsx`格式存储数据。 R可以使用某些excel特定的包直接读取这些文件的内容。一些常用的软件包有 - *XLConnect*，*xlsx*，*gdata*等。在这个篇文章中，我们将使用*xlsx*软件包。 R也可以使用这个包写入*excel*文件。

## 安装xlsx软件包

可以在R控制台中使用以下命令来安装`xlsx`软件包。它可能会要求安装一些这个包所依赖的附加包。按照相同的命令与所需的包名来安装附加的包。

```r showLineNumbers
install.packages("xlsx")
R
```

## 验证并加载“xlsx”软件包

使用以下命令来验证和加载`xlsx`包。参考以下代码 - 

```r showLineNumbers
# Verify the package is installed.
any(grepl("xlsx",installed.packages()))

# Load the library into R workspace.
library("xlsx")
R
```

当脚本运行时，得到以下输出 - 

```shell
[1] TRUE
Loading required package: rJava
Loading required package: methods
Loading required package: xlsxjars
Shell
```

> 注： 如果第一个输出结果为：`FALSE`，请 `install.packages("xlsx")` 语句重新加载安装。

## 准备xlsx文件用作为输入

打开*Microsoft excel*。将以下数据复制并粘贴到名为*sheet1*的工作表中。

```txt
id    name      salary    start_date    dept
1    Rick      623.3        1/1/2012    IT
2    Dan       515.2     9/23/2013   Operations
3    Michelle  611        11/15/2014    IT
4    Ryan      729        5/11/2014    HR
5    Gary      843.25    3/27/2015    Finance
6    Nina      578       5/21/2013    IT
7    Simon      632.8        7/30/2013    Operations
8    Guru      722.5        6/17/2014    Finance
Txt
```

如下所示 - 

![img](http://www.yiibai.com/uploads/images/201708/2408/819150800_87300.png#center)

还将以下数据复制并粘贴到另一个工作表，并将此工作表重命名为*city*。

```txt
name     city
Rick     Seattle
Dan      Tampa
Michelle Chicago
Ryan     Seattle
Gary     Houston
Nina     Boston
Simon     Mumbai
Guru     Dallas
Txt
```

如下所示 - 

![img](http://www.yiibai.com/uploads/images/201708/2408/910150800_60576.png#center)

将Excel文件另存为*“input.xlsx”*，应该将此文件保存在R工作区的当前工作目录中。

## 读取Excel文件

使用`read.xlsx()`函数读取*input.xlsx*，如下所示，结果作为数据帧存储在R环境中。

```r showLineNumbers
# Read the first worksheet in the file input.xlsx.
data <- read.xlsx("input.xlsx", sheetIndex = 1)
print(data)
R
```

当我们执行上述代码时，会产生以下结果 -

```txt
  id     name salary start_date       dept
1  1     Rick 623.30 2012-01-01         IT
2  2      Dan 515.20 2013-09-23 Operations
3  3 Michelle 611.00 2014-11-15         IT
4  4     Ryan 729.00 2014-05-11         HR
5 NA     Gary 843.25 2015-03-27    Finance
6  6     Nina 578.00 2013-05-21         IT
7  7    Simon 632.80 2013-07-30 Operations
8  8     Guru 722.50 2014-06-17    Finance
```

