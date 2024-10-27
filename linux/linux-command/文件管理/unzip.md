---
sidebar_label: unzip 命令
sidebar_position: 30
slug: /unzip
---

# unzip 命令



## 介绍

**unzip** 命令用于列出、测试和提取 zip 格式存档中的文件。

**语法**：

```shell
unzip [-Z] [-opts[modifiers]] file[.zip] [list] [-x xlist] [-d exdir]
```

**选项**：

- `-l` ：显示压缩文件内所包含的文件。
- `-c` ：将解压缩的结果显示到屏幕上，并对字符做适当的转换。
- `-n` ：解压缩时不要覆盖原有的文件。
- `-j` ：不处理压缩文件中原有的目录路径。
- `-v` ：显示压缩文件的详细信息和诊断信息。
- `-d exdir` ：指定解压目录。



## 示例


将 test.zip 解压缩到当前目录：

```shell
$ unzip test.zip
```

将 test.zip 解压缩到当前目录的 tmp 目录下：

```shell
$ unzip test.zip -d tmp
```

列出压缩文件 test.zip 中的内容：

```shell
$ unzip -l test.zip 
Archive:  test.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
        0  2021-06-06 00:38   test/
        6  2021-06-06 00:38   test/world.c
        6  2021-06-06 00:38   test/hello.c
---------                     -------
       12                     3 files
```

列出压缩文件 test.zip 的详细信息：

```shell
$ unzip -v test.zip 
Archive:  test.zip
 Length   Method    Size  Cmpr    Date    Time   CRC-32   Name
--------  ------  ------- ---- ---------- ----- --------  ----
       0  Stored        0   0% 2021-06-06 00:38 00000000  test/
       6  Stored        6   0% 2021-06-06 00:38 363a3020  test/world.c
       6  Stored        6   0% 2021-06-06 00:38 363a3020  test/hello.c
--------          -------  ---                            -------
      12               12   0%                            3 files
```

验证压缩文件 test.zip 的完整性：

```shell
$ unzip -t test.zip 
Archive:  test.zip
    testing: test/                    OK
    testing: test/world.c             OK
    testing: test/hello.c             OK
No errors detected in compressed data of test.zip.
```

