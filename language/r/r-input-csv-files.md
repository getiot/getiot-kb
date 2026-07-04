---
sidebar_position: 32
draft: true
---

# R 语言 - CSV 文件



在R中，我们可以从存储在R环境外部的文件读取数据。还可以将数据写入由操作系统存储和访问的文件。 R可以读取和写入各种文件格式，如：*csv*，*excel*，*xml*等。

在本章中，我们将学习如何从`csv`文件中读取数据，然后将数据写入`csv`文件。 该文件应该存在于当前工作目录中，以方便*R*可以读取它。 当然，也可以设置自己的目录，并从那里读取文件。

## 获取和设置工作目录

可以使用`getwd()`函数来检查R工作区指向哪个目录，使用`setwd()`函数设置新的工作目录。

```r showLineNumbers
# Get and print current working directory.
print(getwd())

# Set current working directory.
# setwd("/web/com")
setwd("F:/worksp/R")

# Get and print current working directory.
print(getwd())
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
[1] "C:/Users/Administrator/Documents"
[1] "F:/worksp/R"
Shell
```

> 注意： 此结果取决于您的操作系统和您当前正在工作的目录。

## 作为CSV文件输入

csv文件是一个文本文件，其中列中的值用逗号分隔。假设下面的数据存在于名为*input.csv* 的文件中。

您可以使用Windows记事本通过复制和粘贴此数据来创建此文件。使用记事本中的另存为所有文件(`*.*`)选项将文件另存为：*input.csv*(在目录：*F:/worksp/R* 下载)。

```csv
id,name,salary,start_date,dept
1,Rick,623.3,2012-01-01,IT
2,Dan,515.2,2013-09-23,Operations
3,Michelle,611,2014-11-15,IT
4,Ryan,729,2014-05-11,HR
 ,Gary,843.25,2015-03-27,Finance
6,Nina,578,2013-05-21,IT
7,Simon,632.8,2013-07-30,Operations
8,Guru,722.5,2014-06-17,Finance
Csv
```

## 读取CSV文件

以下是*read.csv()*函数的一个简单示例，用于读取当前工作目录中可用的CSV文件 -

```r showLineNumbers
setwd("F:/worksp/R")
data <- read.csv("input.csv")
print(data)
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
> data <- read.csv("input.csv")
> print(data)
  id     name salary start_date       dept
1  1     Rick 623.30 2012-01-01         IT
2  2      Dan 515.20 2013-09-23 Operations
3  3 Michelle 611.00 2014-11-15         IT
4  4     Ryan 729.00 2014-05-11         HR
5 NA     Gary 843.25 2015-03-27    Finance
6  6     Nina 578.00 2013-05-21         IT
7  7    Simon 632.80 2013-07-30 Operations
8  8     Guru 722.50 2014-06-17    Finance
Shell
```

## 分析CSV文件

默认情况下，`read.csv()`函数将输出作为数据帧。这可以很容易地查看到，此外，我们可以检查列和行的数量。

```r showLineNumbers
setwd("F:/worksp/R")
data <- read.csv("input.csv")

print(is.data.frame(data))
print(ncol(data))
print(nrow(data))
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
[1] TRUE
[1] 5
[1] 8
Shell
```

当我们在数据帧中读取数据，可以应用所有适用于数据帧的函数，如下一节所述。

**获得最高工资**

```r showLineNumbers
# Create a data frame.
data <- read.csv("input.csv")

# Get the max salary from data frame.
sal <- max(data$salary)
print(sal)
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
[1] 843.25
Shell
```

**获得最高工资的人员的详细信息**

可以使用过滤条件获取符合特定的行，类似于SQL的`where`子句。

```r showLineNumbers
setwd("F:/worksp/R")
# Create a data frame.
data <- read.csv("input.csv")

# Get the max salary from data frame.
sal <- max(data$salary)

# Get the person detail having max salary.
retval <- subset(data, salary == max(salary))
print(retval)
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
      id    name  salary  start_date    dept
5     NA    Gary  843.25  2015-03-27    Finance
Shell
```

**获取IT部门的所有人员**

```r showLineNumbers
# Create a data frame.
data <- read.csv("input.csv")

retval <- subset( data, dept == "IT")
print(retval)
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
       id   name      salary   start_date   dept
1      1    Rick      623.3    2012-01-01   IT
3      3    Michelle  611.0    2014-11-15   IT
6      6    Nina      578.0    2013-05-21   IT
Shell
```

**获取IT部门薪水在600以上的人员**

```r showLineNumbers
setwd("F:/worksp/R")
# Create a data frame.
data <- read.csv("input.csv")

info <- subset(data, salary > 600 & dept == "IT")
print(info)
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
       id   name      salary   start_date   dept
1      1    Rick      623.3    2012-01-01   IT
3      3    Michelle  611.0    2014-11-15   IT
Shell
```

**获得在2014年或以后入职的人员**

```r showLineNumbers
setwd("F:/worksp/R")
# Create a data frame.
data <- read.csv("input.csv")

retval <- subset(data, as.Date(start_date) > as.Date("2014-01-01"))
print(retval)
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
       id   name     salary   start_date    dept
3      3    Michelle 611.00   2014-11-15    IT
4      4    Ryan     729.00   2014-05-11    HR
5     NA    Gary     843.25   2015-03-27    Finance
8      8    Guru     722.50   2014-06-17    Finance
Shell
```

## 写入CSV文件

R可以从现有数据帧中来创建csv文件。`write.csv()`函数用于创建`csv`文件。 该文件在工作目录中创建。参考以下示例代码 - 

```r showLineNumbers
setwd("F:/worksp/R")
# Create a data frame.
data <- read.csv("input.csv")
retval <- subset(data, as.Date(start_date) > as.Date("2014-01-01"))
# print(retval)
# Write filtered data into a new file.
write.csv(retval,"output.csv")
newdata <- read.csv("output.csv")
print(newdata)
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
  X      id   name      salary   start_date    dept
1 3      3    Michelle  611.00   2014-11-15    IT
2 4      4    Ryan      729.00   2014-05-11    HR
3 5     NA    Gary      843.25   2015-03-27    Finance
4 8      8    Guru      722.50   2014-06-17    Finance
Shell
```

这里列*X*来自数据集更新器。在编写文件时可以使用其他参数来删除它。

```r showLineNumbers
setwd("F:/worksp/R")
# Create a data frame.
data <- read.csv("input.csv")
retval <- subset(data, as.Date(start_date) > as.Date("2014-01-01"))

# Write filtered data into a new file.
write.csv(retval,"output.csv", row.names = FALSE)
newdata <- read.csv("output.csv")
print(newdata)
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
      id    name      salary   start_date    dept
1      3    Michelle  611.00   2014-11-15    IT
2      4    Ryan      729.00   2014-05-11    HR
3     NA    Gary      843.25   2015-03-27    Finance
4      8    Guru      722.50   2014-06-17    Finance
```

