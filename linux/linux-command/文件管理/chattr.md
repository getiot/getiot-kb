---
sidebar_label: chattr 命令
sidebar_position: 31
slug: /chattr
---

# chattr 命令



## 介绍

**chattr**（英文全拼：change file attributes）命令用于修改 Linux 文件系统中的文件属性。

**语法**：

```bash
chattr [ -RVf ] [ -v version ] [ -p project ] [ mode ] files...
```

**选项**：

- `-R` ：递归处理目录下的所有文件。
- `-V` ：显示指令执行过程。
- `-f` ：禁止显示大多数错误消息。
- `-v version` ：设置文件的版本/代号。
- `-p project` ：设置文件的项目编号。
- `+<属性>`：开启文件或目录的该项属性。
- `-<属性>`：关闭文件或目录的该项属性。
- `=<属性>`：指定文件或目录的该项属性。

**模式**：

通用格式为：`+-=[aAcCdDeijsStTu]`，其中 `aAcCdDeijsStTu` 表示可以赋予文件的新属性，说明如下。

- `a`：让文件或目录仅供附加用途。
- `A`：当一个具有 `A` 属性的文件被访问时，它的 atime 记录不会被修改。
- `c`：将文件或目录压缩后存放。
- `d`：将文件或目录排除在倾倒操作之外。
- `i`：不得任意更动文件或目录。
- `j`：如果文件系统安装有 `data=order` 或 `data=writeback` 选项，则具有 `j` 属性的文件在写入文件本身之前将其所有数据写入 ext 3 日志。
- `s`：当删除具有 `s` 属性集的文件时，其块将被归零并写回磁盘。
- `S`：当修改具有 `S` 属性集的文件时，更改将同步写入磁盘；这相当于应用于文件子集的“同步”挂载选项。
- `u`：当删除具有 `u` 属性集的文件时，它的内容将被保存。



## 示例

用 chattr 命令防止系统中某个关键文件被修改（加锁）：

```bash
chattr +i /opt/test.txt
```

然后试一下 [rm](/linux-command/rm)、[mv](/linux-command/mv)、rename 等命令操作于该文件，都是得到 “Operation not permitted” 的结果。

执行下面命令可以解锁该文件：

```bash
chattr -i /opt/test.txt
```

让某个文件只能往里面追加内容，不能删除，一些日志文件适用于这种操作：

```bash
chattr +a /data/user_act.log
```

