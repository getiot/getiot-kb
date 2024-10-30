---
sidebar_label: tar 命令
sidebar_position: 26
slug: /tar
---

# tar 命令 - 压缩或解压缩文件



## 介绍

**tar**（英文全拼：tape archive）命令用于在磁带、或者磁盘上创建和提取归档文件。

tar 命令默认只是把多个文件打包放到一起，并不会对文件进行压缩，如果想要进行压缩或解压缩操作，则需要使用对应的选项参数。

**语法**：

tar 命令的用法有三种风格

- 传统风格

  ```shell
  tar {A|c|d|r|t|u|x}[GnSkUWOmpsMBiajJzZhPlRvwo] [ARG...]
  ```

- UNIX 风格

  ```shell
  tar -A [OPTIONS] ARCHIVE ARCHIVE
  tar -c [-f ARCHIVE] [OPTIONS] [FILE...]
  tar -d [-f ARCHIVE] [OPTIONS] [FILE...]
  tar -t [-f ARCHIVE] [OPTIONS] [MEMBER...]
  tar -r [-f ARCHIVE] [OPTIONS] [FILE...]
  tar -u [-f ARCHIVE] [OPTIONS] [FILE...]
  tar -x [-f ARCHIVE] [OPTIONS] [MEMBER...]
  ```

- GNU 风格

  ```shell
  tar {--catenate|--concatenate} [OPTIONS] ARCHIVE ARCHIVE
  tar --create [--file ARCHIVE] [OPTIONS] [FILE...]
  tar {--diff|--compare} [--file ARCHIVE] [OPTIONS] [FILE...]
  tar --del--extractete [--file ARCHIVE] [OPTIONS] [MEMBER...]
  tar --append [-f ARCHIVE] [OPTIONS] [FILE...]
  tar --list [-f ARCHIVE] [OPTIONS] [MEMBER...]
  tar --test-label [--file ARCHIVE] [OPTIONS] [LABEL...]
  tar --update [--file ARCHIVE] [OPTIONS] [FILE...]
  tar --update [-f ARCHIVE] [OPTIONS] [FILE...]
  tar {--extract|--get} [-f ARCHIVE] [OPTIONS] [MEMBER...]
  ```

**选项**：

- `-A`, `--catenate` ：将新增的归档文件附加到已存在的另一个归档文件。
- `-c`, `--create` ：建立新的归档文件。
- `-d`, `--diff` ：对比归档文件内和文件系统上的文件的差异。
- `-k`, `--keep-old-files` ：解压时不替换存在的文件，而将其认为是错误。
- `-m`, `--touch` ：不要解压文件的修改时间。
- `-r`, `--append` ：将新增文件附加到已存在的归档文件的结尾。
- `-S`, `--sparse` ：高效处理离散文件。
- `-t`, `--list` ：列出归档文件的内容。
- `-u`, `--update` ：仅置换较归档文件内的文件更新的文件。
- `-x`, `--extract`, `--get` ：从归档文件中提取文件。
- `-f <ARCHIVE>` ：指定归档文件。
- `-j`, `--bzip2` ：通过 bzip2 命令处理归档文件。
- `-J`, `--xz` ：通过 xz 命令处理归档文件。
- `-z`, `--gzip`, `--gunzip`, `--ungzip` ：通过 gzip 命令处理归档文件。
- `-Z`, `--compress`, `--uncompress` ：通过 compress 命令处理归档文件。
- `-v`, `--verbose` ：显示命令执行过程。
- `--exclude=PATTERN` ：排除 PATTERN 匹配的所有文件。



## 示例

使用 gzip 格式压缩文件（将 hello.c 和 world.c 压缩为 getiot.tar.gz）：

```shell
$ touch hello.c world.c
$ tar zcvf getiot.tar.gz hello.c world.c 
hello.c
world.c
```

列出压缩文件内容：

```shell
$ tar ztvf getiot.tar.gz 
-rw-rw-r-- rudy/rudy         0 2021-05-25 23:56 hello.c
-rw-rw-r-- rudy/rudy         0 2021-05-25 23:56 world.c
```

解压文件（解压到 /tmp 目录）：

```shell
$ tar zxvf getiot.tar.gz -C /tmp
hello.c
world.c
```

压缩当前目录下的所有文件（排除 .git 目录）：

```shell
tar jcvf getiot.tar.bz2 --exclude=.git ./*
```

