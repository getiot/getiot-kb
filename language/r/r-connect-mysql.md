---
sidebar_position: 38
draft: true
---

# R 语言 - 连接 MySQL 数据库



关系数据库系统中的数据是以规范化格式存储的。 所以，为了进行统计计算，我们需要非常高级和复杂的SQL查询。但是R可以很容易地连接到许多关系数据库，如：[MySQL](http://www.yiibai.com/mysql/)，[Oracle](http://www.oraok.com/)，Sql Server等，并将它们作为数据帧提取。 当从数据库中读取数据到R环境中可用以后，它就成为一个正常的R数据集，可以使用所有强大的软件包和函数进行操作或分析。

在本教程中，我们将使用R编程语言连接到MySQL数据库。

## RMySQL 包

R有一个名为`RMySQL`的内置包，它提供与MySql数据库之间的本机连接。您可以使用以下命令在R环境中安装此软件包。

```r showLineNumbers
install.packages("RMySQL")
R
```

## 连接 MySql

当安装了软件包(`RMySQL`)之后，我们在R中创建一个连接对象以连接到数据库。它需要用户名，密码，数据库名称和主机名等数据库连接所需要的信息。

```r showLineNumbers
library("RMySQL");
# Create a connection Object to MySQL database.
# We will connect to the sampel database named "testdb" that comes with MySql installation.
mysqlconnection = dbConnect(MySQL(), user = 'root', password = '123456', dbname = 'testdb',
   host = 'localhost')

# List the tables available in this database.
dbListTables(mysqlconnection)
R
```

当我们执行上述代码时，会产生以下结果(当前数据中的所有表) -

```shell
 [1] "articles"       "contacts"       "demos"          "divisions"     
 [5] "items"          "luxuryitems"    "order"          "persons"       
 [9] "posts"          "revenues"       "special_isnull" "t"             
[13] "tbl"            "tmp"            "v1"             "vparts"
Shell
```

## 查询表

可以使用`dbSendQuery()`函数查询MySQL中的数据库表。该查询在MySql中执行，并使用R 的`fetch()`函数返回结果集,最后将此结果作为数据帧存储在R中。

假设要查询的表是：`persons`，其创建语句和数据如下 - 

```sql
/*
Navicat MySQL Data Transfer

Source Server         : localhost-57
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : testdb

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2017-08-24 00:35:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `persons`
-- ----------------------------
DROP TABLE IF EXISTS `persons`;
CREATE TABLE `persons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `date_of_birth` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of persons
-- ----------------------------
INSERT INTO `persons` VALUES ('1', 'John Doe', '1990-01-01');
INSERT INTO `persons` VALUES ('2', 'David Taylor', '1989-06-06');
INSERT INTO `persons` VALUES ('3', 'Peter Drucker', '1988-03-02');
INSERT INTO `persons` VALUES ('4', 'Lily Minsu', '1992-05-05');
INSERT INTO `persons` VALUES ('5', 'Mary William', '1995-12-01');
SQL
```

将上述表导入到数据库中，并创建以下R代码，用来执行从数据库的表中查询数据 -

```r showLineNumbers
library("RMySQL");
# Create a connection Object to MySQL database.
# We will connect to the sampel database named "testdb" that comes with MySql installation.
mysqlconnection = dbConnect(MySQL(), user = 'root', password = '123456', dbname = 'testdb',
   host = 'localhost');
# Query the "actor" tables to get all the rows.
result = dbSendQuery(mysqlconnection, "select * from persons")

# Store the result in a R data frame object. n = 5 is used to fetch first 5 rows.
data.frame = fetch(result, n = 5)
print(data.frame)
R
```

执行上面示例代码，得到以下结果 - 

```shell
  id     full_name date_of_birth
1  1      John Doe    1990-01-01
2  2  David Taylor    1989-06-06
3  3 Peter Drucker    1988-03-02
4  4    Lily Minsu    1992-05-05
5  5  Mary William    1995-12-01
Shell
```

## 使用过滤子句查询

我们可以传递任何有效的选择查询来获取结果，如下代码所示 - 

```r showLineNumbers
library("RMySQL");
# Create a connection Object to MySQL database.
# We will connect to the sampel database named "testdb" that comes with MySql installation.
mysqlconnection = dbConnect(MySQL(), user = 'root', password = '123456', dbname = 'testdb',
   host = 'localhost');
result = dbSendQuery(mysqlconnection, "select * from persons where date_of_birth = '1990-01-01'")

# Fetch all the records(with n = -1) and store it as a data frame.
data.frame = fetch(result, n = -1)
print(data.frame)
R
```

当我们执行上述代码时，会产生以下结果 -

```shell
  id full_name date_of_birth
1  1  John Doe    1990-01-01
Shell
```

## 更新表中的行记录

可以通过将更新查询传递给`dbSendQuery()`函数来更新MySQL表中的行。

```r showLineNumbers
dbSendQuery(mysqlconnection, "update persons set date_of_birth = '1999-01-01' where id=3")
R
```

执行上述代码后，可以看到在MySql已经更新`persons`表中对应的记录。

## 将数据插入到表中

参考以下代码实现 - 

```r showLineNumbers
library("RMySQL");
# Create a connection Object to MySQL database.
# We will connect to the sampel database named "testdb" that comes with MySql installation.
mysqlconnection = dbConnect(MySQL(), user = 'root', password = '123456', dbname = 'testdb',
   host = 'localhost');
dbSendQuery(mysqlconnection,
   "insert into persons(full_name, date_of_birth) values ('Maxsu', '1992-01-01')"
)
R
```

执行上述代码后，可以看到向MySql的`persons`表中，插入一行数据。

## 在 MySql 中创建表

我们通过使用`dbWriteTable()`函数向MySql中创建表。它会覆盖表，如果它已经存在并且以数据帧为输入。

```r showLineNumbers
library("RMySQL");
# Create the connection object to the testdb database where we want to create the table.
mysqlconnection = dbConnect(MySQL(), user = 'root', password = '123456', dbname = 'testdb',host = 'localhost')

# Use the R data frame "mtcars" to create the table in MySql.
# All the rows of mtcars are taken inot MySql.
dbWriteTable(mysqlconnection, "mtcars", mtcars[, ], overwrite = TRUE)
R
```

执行上述代码后，我们可以看到在MySql数据库中创建一个名称为：*mtcars*的表，并有填充了一些数据。

## 在 MySql 中删除表

我们可以删除MySql数据库中的表，将`drop table`语句传递到`dbSendQuery()`函数中，就像在SQL中查询表中的数据一样。

```r showLineNumbers
dbSendQuery(mysqlconnection, 'drop table if exists mtcars')
R
```

执行上述代码后，我们可以看到MySql数据库中的`mtcars`表被删除。

