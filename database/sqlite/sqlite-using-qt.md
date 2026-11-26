---
sidebar_position: 6
draft: true
---

# Qt 中使用 SQLite 数据库

SQLite 是一款开源轻量级的数据库软件，不需要 server，可以集成在其他软件中，非常适合嵌入式系统。Qt5 以上版本可以直接使用 SQLite（Qt 自带驱动）。



## 用法

### 准备

**引入 SQL 模块**

在Qt项目文件(.pro文件)中，加入SQL模块：

```makefile showLineNumbers
QT += sql
```

**引用头文件**

在需要使用SQL的类定义中，引用相关头文件。例如：

```c showLineNumbers
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
```



### 使用

#### 1. 建立数据库

检查连接、添加数据库驱动、设置数据库名称、数据库登录用户名、密码。

```cpp showLineNumbers
QSqlDatabase database;
if (QSqlDatabase::contains("qt_sql_default_connection"))
{
    database = QSqlDatabase::database("qt_sql_default_connection");
}
else
{
    database = QSqlDatabase::addDatabase("QSQLITE");
    database.setDatabaseName("MyDataBase.db");
    database.setUserName("XingYeZhiXia");
    database.setPassword("123456");
}
```

上述代码解释：

1. 第一行中，建立了一个`QSqlDatabase`对象，后续的操作要使用这个对象。

2. `if`语句用来检查指定的连接(connection)是否存在。这里指定的连接名称（connection name）是`qt_sql_default_connection`，这是Qt默认连接名称。实际使用时，这个名称可以任意取。如果判断此连接已经存在，那么`QSqlDatabase::contains()`函数返回true。此时，进入第一个分支，`QSqlDatabase::database()`返回这个连接。

3. 如果这个连接不存在，则进入`else`分支，需要创建连接，并添加数据库。在`else`分支第一行，`addDatabase()`的参数`QSQLITE`是SQLite对应的驱动名，不能改。而且需要注意的是，`addDatabase()`的第二个参数被省略了，第二个参数的默认参数就是上面提到的Qt默认连接名称`qt_sql_default_connection`。如果需要使用自定义的连接名称（如果程序需要处理多个数据库文件的话就会这样），则应该加入第二个参数，例如

   ```cpp
   database = QSqlDatabase::addDatabase("QSQLITE", "my_sql_connection);
   ```

   这个时候，如果在另一个地方需要判断`my_sql_connection`连接是否存在，就应该使用

   ```cpp
   if (QSqlDatabase::contains("my_sql_connection"))
   ```

4. `else`分支第二行中，`setDatabaseName()`的参数是数据库文件名。如果这个数据库不存在，则会在后续操作时自动创建；如果已经存在，则后续的操作会在已有的数据库上进行。

5. `else`分支后面两行，设置用户名和密码。用户名，密码都可以随便取，也可以省略。



#### 2. 打开数据库

使用 `open()` 打开数据库，并判断是否成功。注意，在第一步检查连接是否存在时，如果连接存在，则在返回这个连接的时候，会默认将数据库打开。

```cpp showLineNumbers
if (!database.open())
{
    qDebug() << "Error: Failed to connect database." << database.lastError();
}
else
{
    // do something
}
```

如果打开成功，则进入 else 分支。对数据库的操作都需要在else分支中进行。



#### 3. 关闭数据库

数据库操作完成后，最好关闭。

```cpp showLineNumbers
database.close();
```



#### 4. 操作数据库

对数据库进行操作需要用到QSqlQuery类，操作前必须定义一个对象。下面举例说明操作方法。操作需要使用SQLite语句，本文中的几个例子会使用几个常用的语句，关于SQLite语句的具体信息请参考SQLite相关资料。

**例1：创建表格**

创建一个名为student的表格，表格包含三列，第一列是id，第二列是名字，第三列是年龄。

```cpp showLineNumbers
QSqlQuery sql_query;
QString create_sql = "create table student (id int primary key, name varchar(30), age int)";
sql_query.prepare(create_sql);
if(!sql_query.exec())
{
    qDebug() << "Error: Fail to create table." << sql_query.lastError();
}
else
{
    qDebug() << "Table created!";
}
```

代码解释：

（1）第一行定义一个`QSqlQuery`对象。
（2）第二行是一个`QString`，其中的内容是SQLite语句。对数据库的操作，都是用SQLite的语句完成的，把这些指令以QString类型，通过`prepare`函数，保存在QSqlQuery对象中。也可将指令，以QString形式直接写在`exec()`函数的参数中，例如：

```cpp
sql_query.exec("create table student (id int primary key, name varchar(30), age int)");
```

创建表格语句：`create table <table_name> (f1 type1, f2 type2,…);`

`create table`是创建表格的语句，也可用大写`CREATE TABLE`；student是表格的名称，可以任意取；括号中是表格的格式，上述指令表明，表格中有三列，第一列的名称（表头）是id，这一列储存的数据类型是int，第二列名称是name，数据类型是字符数组，最多有30个字符（和char(30)的区别在于，varchar的实际长度是变化的，而char的长度始终是给定的值），第三列的名称是age，数据类型是int。

如果`sql_query.exec()`执行成功，则创建表格成功。



**例2：插入数据**
在刚才创建的表格中，插入一行数据。

```cpp showLineNumbers
QString insert_sql = "insert into student values (?, ?, ?)";
sql_query.prepare(insert_sql);
sql_query.addBindValue(max_id+1);
sql_query.addBindValue("Wang");
sql_query.addBindValue(25);
if(!sql_query.exec())
{
    qDebug() << sql_query.lastError();
}
else
{
    qDebug() << "inserted Wang!";
}
if(!sql_query.exec("INSERT INTO student VALUES(3, \"Li\", 23)"))
{
    qDebug() << sql_query.lastError();
}
else
{
    qDebug() << "inserted Li!";
}
```

插入语句：`insert into <table_name> values (value1, value2,…);`
`insert into`是插入语句，student是表格名称，values()是要插入的数据。这里，我们插入了2组数据。插入第一组数据的时候，用`addBindValue`来替代语句中的`?`，替代的顺序与`addBindValue`调用的顺序相同。插入第二组数据的时候，则是直接写出完整语句。

**例3：更新数据（修改数据）**

```cpp showLineNumbers
QString update_sql = "update student set name = :name where id = :id";
sql_query.prepare(update_sql);
sql_query.bindValue(":name", "Qt");
sql_query.bindValue(":id", 1);
if(!sql_query.exec())
{
    qDebug() << sql_query.lastError();
}
else
{
    qDebug() << "updated!";
}
```

语句：`update <table_name> set <f1=value1>, <f2=value2>… where <expression>;`
更新（修改）的语句是`update...set...`，其中student是表格名称，name是表头名称（即第二列），:name是待定的变量，where用于确定是哪一组数据，:id也是待定变量。
`bindValue(" ", " ")`函数用来把语句中的待定变量换成确定值。



**例4：查询数据**

（1）查询部分数据

```cpp showLineNumbers
QString select_sql = "select id, name from student";
if(!sql_query.exec(select_sql))
{
    qDebug()<<sql_query.lastError();
}
else
{
    while(sql_query.next())
    {
        int id = sql_query.value(0).toInt();
        QString name = sql_query.value(1).toString();
        qDebug()<<QString("id:%1    name:%2").arg(id).arg(name);
    }
}
```

语句`select <f1>, <f2>, ... from <table_name>;`
select是查询指令；`<f1>` 等等是要查询的变量（即表头），中间用逗号隔开；from ...指定表格。
上述语句是说查询student表中的 id 和 name 。执行查询之后，用`sql_query.value(int)`来获得数据。同样地，`value(0)`表示第一个数据，即 id，`value(1)`表示name。**注意**：`value()`函数的返回值类型是`QVariant`，因此要用`toInt()`等函数转换成特定的类型。

（2）查询全部数据

```cpp showLineNumbers
QString select_all_sql = "select * from student";
sql_query.prepare(select_all_sql);
if(!sql_query.exec())
{
    qDebug()<<sql_query.lastError();
}
else
{
    while(sql_query.next())
    {
        int id = sql_query.value(0).toInt();
        QString name = sql_query.value(1).toString();
        int age = sql_query.value(2).toInt();
        qDebug()<<QString("id:%1    name:%2    age:%3").arg(id).arg(name).arg(age);
    }
}
```

语句`select * from <table_name>;`
查询所有数据用 * 表示。用`while(sql_query.next())`用来遍历所有行。同样用`value()`获得数据。

（3）查询最大id

```cpp showLineNumbers
QString select_max_sql = "select max(id) from student";
int max_id = 0;
sql_query.prepare(select_max_sql);
if(!sql_query.exec())
{
    qDebug() << sql_query.lastError();
}
else
{
    while(sql_query.next())
    {
        max_id = sql_query.value(0).toInt();
        qDebug() << QString("max id:%1").arg(max_id);
    }
}
```

这个就是在语句中用`max`来获取最大值。

**例5：删除与清空**

（1）删除一条数据

```cpp showLineNumbers
QString delete_sql = "delete from student where id = ?";
sql_query.prepare(delete_sql);
sql_query.addBindValue(0);
if(!sql_query.exec())
{
    qDebug()<<sql_query.lastError();
}
else
{
    qDebug()<<"deleted!";
}
```

语句`delete from <table_name> where <f1> = <value>`
delete用于删除条目，用where给出限定条件。例如此处是删除 id = 0的条目。

（2）清空表格（删除所有）

```cpp showLineNumbers
QString clear_sql = "delete from student";
sql_query.prepare(clear_sql);
if(!sql_query.exec())
{
    qDebug() << sql_query.lastError();
}
else
{
    qDebug() << "table cleared";
}
```

这里没有用where给出限制，就会删除所有内容。



## Qt 读写 Sqlite 数据库的三种方式

 QT对一些基本的数据库的访问封装，可谓是极大的方便的我们开发人员，现在我们就来说下QT对Sqlite这个数据库的读写，Sqlite是一个比较小型的本地数据库，对于保存一些软件配置参数或量不是很大的数据是相当的方便，Qt本身已经自带了Sqlite的驱动，直接使用相关的类库即可，这篇我们主要来说明QT访问Sqlite数据库的三种方式(即使用三种类库去访问)，分别为QSqlQuery、QSqlQueryModel、QSqlTableModel，对于这三种类库，可看为一个比一个上层，也就是封装的更厉害，甚至第三种QSqlTableModel，根本就不需要开发者懂SQL语言，也能操作Sqlite数据库。



### 1、首先使用QSqlQuery来访问

我们先要在工程中包含与数据库相关的几个头文件

```c showLineNumbers
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlRecord>
#include <QtSql/QSqlQuery>
```



### 2、使用 QSqlQueryModel 来访问

QSqlQueryModel 类带有 Model 字样，相信你已经猜到我们可以用他来关联视图，就能把数据库的内容显示到视图上，当然，常规的操作也是可以的，但是我们只说说怎么用这个类来把数据库中的内容显示到是视图中，这里我们选择的视图类为 QTableView，直接上代码吧。



### 3、最后使用 QSqlTableModel 来访问

最后我们来说说使用 QSqlTableModel 这个类去操作 Sqlite 数据库，这个类比上两个封装的更彻底，即使我们不懂 SQL 语言，也能实现对 Sqlite 数据库的操作，并且这个类也可以通过视图来显示修改数据库内容，这里我就拿这个类做了个用户管理模块，其实也可以通用与其他任何一个模块，只要在生成对象时传入 sqlite 的数据库名及要操作的表名即可。





