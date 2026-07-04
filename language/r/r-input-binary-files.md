---
sidebar_position: 36
draft: true
---

# R 语言 - 二进制文件



二进制文件是一个文件，其中包含仅以位和字节形式存储的信息(`0`和`1`)。它们不可读，因为其中的字节转换为包含许多其他不可打印字符的字符和符号。尝试使用任何文本编辑器读取二进制文件将显示为类似`Ø`和`ð`这样的字符。

二进制文件必须由特定程序读取才能使用。例如，*Microsoft Word*程序的二进制文件只能通过Word程序读取到人类可读的形式。这表明，除了人类可读的文本之外，还有更多的信息，如格式化的字符和页码等，它们也与字母数字字符一起存储。最后二进制文件是一个连续的字节序列。 我们在文本文件中看到的换行符是将第一行连接到下一个的字符。

有时，由其他程序生成的数据需要由R作为二进制文件处理。 另外R需要创建可以与其他程序共享的二进制文件。

R有两个函数用来创建和读取二进制文件，它们分别是：`WriteBin()`和`readBin()`函数。

## 语法

```r showLineNumbers
writeBin(object, con)
readBin(con, what, n )
R
```

以下是使用的参数的描述 - 

- *con* - 是要读取或写入二进制文件的连接对象。
- *object* - 是要写入的二进制文件。
- *what* - 是像字符，整数等的模式，代表要读取的字节。
- *n* - 是从二进制文件读取的字节数。

## 实例

这里考虑使用R内置数据`“mtcars”`。 首先，我们从它创建一个csv文件并将其转换为二进制文件并将其存储为操作系统文件。接下来将这个二进制文件读入R中。

### 1. 写入二进制文件

我们将数据帧`“mtcars”`读为csv文件，然后将其作为二进制文件写入操作系统。参考以下代码实现 - 

```r showLineNumbers
# Read the "mtcars" data frame as a csv file and store only the columns 
   "cyl", "am" and "gear".
write.table(mtcars, file = "mtcars.csv",row.names = FALSE, na = "", 
   col.names = TRUE, sep = ",")

# Store 5 records from the csv file as a new data frame.
new.mtcars <- read.table("mtcars.csv",sep = ",",header = TRUE,nrows = 5)

# Create a connection object to write the binary file using mode "wb".
write.filename = file("/web/com/binmtcars.dat", "wb")

# Write the column names of the data frame to the connection object.
writeBin(colnames(new.mtcars), write.filename)

# Write the records in each of the column to the file.
writeBin(c(new.mtcars$cyl,new.mtcars$am,new.mtcars$gear), write.filename)

# Close the file for writing so that it can be read by other program.
close(write.filename)
R
```

### 2. 读取二进制文件

上面创建的二进制文件将所有数据作为连续字节存储。 因此，我们将通过选择列名称和列值的适当值来读取它。

```r showLineNumbers
# Create a connection object to read the file in binary mode using "rb".
read.filename <- file("/web/com/binmtcars.dat", "rb")

# First read the column names. n = 3 as we have 3 columns.
column.names <- readBin(read.filename, character(),  n = 3)

# Next read the column values. n = 18 as we have 3 column names and 15 values.
read.filename <- file("/web/com/binmtcars.dat", "rb")
bindata <- readBin(read.filename, integer(),  n = 18)

# Print the data.
print(bindata)

# Read the values from 4th byte to 8th byte which represents "cyl".
cyldata = bindata[4:8]
print(cyldata)

# Read the values form 9th byte to 13th byte which represents "am".
amdata = bindata[9:13]
print(amdata)

# Read the values form 9th byte to 13th byte which represents "gear".
geardata = bindata[14:18]
print(geardata)

# Combine all the read values to a dat frame.
finaldata = cbind(cyldata, amdata, geardata)
colnames(finaldata) = column.names
print(finaldata)
R
```

当我们执行上面的代码，它产生以下结果和图表 -

```shell
 [1]    7108963 1728081249    7496037          6          6          4
 [7]          6          8          1          1          1          0
[13]          0          4          4          4          3          3

[1] 6 6 4 6 8

[1] 1 1 1 0 0

[1] 4 4 4 3 3

     cyl am gear
[1,]   6  1    4
[2,]   6  1    4
[3,]   4  1    4
[4,]   6  0    3
[5,]   8  0    3
Shell
```

我们可以看到，通过读取R中的二进制文件，得到了原始数据。


