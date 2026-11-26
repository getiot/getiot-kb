---
sidebar_position: 3
---

# SQLite 命令



广义来讲，Sqlite 命令可以分为三类，分别是 sqlite 命令行、sqlite 交互命令以及 sql 操作命令。

本文主要介绍 sqlite 命令行选项和 sqlite 交互命令，sql 操作命令则在后面章节介绍。



## 命令行选项

```shell
$ sqlite3 --help
Usage: sqlite3 [OPTIONS] FILENAME [SQL]
FILENAME is the name of an SQLite database. A new database is created
if the file does not previously exist.
OPTIONS include:
   -A ARGS...           run ".archive ARGS" and exit
   -append              append the database to the end of the file
   -ascii               set output mode to 'ascii'
   -bail                stop after hitting an error
   -batch               force batch I/O
   -column              set output mode to 'column'
   -cmd COMMAND         run "COMMAND" before reading stdin
   -csv                 set output mode to 'csv'
   -deserialize         open the database using sqlite3_deserialize()
   -echo                print commands before execution
   -init FILENAME       read/process named file
   -[no]header          turn headers on or off
   -help                show this message
   -html                set output mode to HTML
   -interactive         force interactive I/O
   -line                set output mode to 'line'
   -list                set output mode to 'list'
   -lookaside SIZE N    use N entries of SZ bytes for lookaside memory
   -maxsize N           maximum size for a --deserialize database
   -memtrace            trace all memory allocations and deallocations
   -mmap N              default mmap size set to N
   -newline SEP         set output row separator. Default: '\n'
   -nofollow            refuse to open symbolic links to database files
   -nullvalue TEXT      set text string for NULL values. Default ''
   -pagecache SIZE N    use N slots of SZ bytes each for page cache memory
   -quote               set output mode to 'quote'
   -readonly            open the database read-only
   -separator SEP       set output column separator. Default: '|'
   -stats               print memory stats before each finalize
   -version             show SQLite version
   -vfs NAME            use NAME as the default VFS
   -zip                 open the file as a ZIP Archive
```



## 交互命令

SQLite 交互命令也称为“点命令”。

当前目录下建立或打开 test.db 数据库文件，并进入 sqlite 命令终端，以 `sqlite>` 前缀标识：

```shell
sqlite3 test.db
```

查看数据库文件信息命令（注意命令前带字符 `.`）：

```sqlite
sqlite>.database
```

查看所有表的创建语句：

```sqlite
sqlite>.schema
```

查看指定表的创建语句：

```sqlite
sqlite>.schema table_name
```

以 sql 语句的形式列出表内容：

```sqlite
sqlite>.dump table_name
```

设置显示信息的分隔符：

```sqlite
sqlite>.separator symble
```

示例：设置显示信息以 `:` 分隔

```sqlite
sqlite>.separator :
```

设置显示模式：

```sqlite
sqlite>.mode mode_name
```

示例：默认为 list，设置为 column，其他模式可通过 `.help` 查看 mode 相关内容

```sqlite
sqlite>.mode column
```

输出帮助信息：

```sqlite
sqlite>.help
```

设置每一列的显示宽度：

```sqlite
sqlite>.width width_value
```

示例：设置宽度为 2

```sqlite
sqlite>.width 2
```

列出当前显示格式的配置：

```sqlite
sqlite>.show
```

退出 sqlite 终端命令：

```sqlite
sqlite>.quit
```

或

```sqlite
sqlite>.exit
```



## SQL 命令





