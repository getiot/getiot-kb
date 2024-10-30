---
sidebar_label: size 命令
sidebar_position: 6
slug: /size
---

# size 命令 - 显示目标文件的大小



## 介绍

Linux 系统中的 **size** 命令用于显示指定目标文件或可执行文件各段的大小及其总和。

通常，size 针对每个目标文件或可执行文件，包括档案文件中的每个模块生成一行输出信息。其中，*objfiles* 是需要考察的一个或一组目标文件或可执行文件，也可以是一个 ar 档案文件，表示考察其中的所有模块文件。如果未指定文件，默认的输入文件是当前目录中的 a.out 文件。

**语法**：

```bash
size [选项] [文件]
```

**选项**：

- `-A|-B|-G, --format={sysv|berkeley|gnu}`：指定代码段的显示格式。其中，

  - `-A` 或 `--format=sysv` 表示 System V 格式；
  - `-B` 或 `--format=berkeley` 表示默认的 Berkeley 格式；
  - `-G` 或 `--format=gnu` 表示 GNU 格式。

- `-o|-d|-x, --radix={8|10|16}`：指定输出数值的表示方式，其中，

  - `-o` 或 `--radix=8` 表示八进制数值；
  - `-d` 或 `--radix=10` 表示十进制数值；
  - `-x` 或 `--radix=16` 表示十六进制数值。

  在每一行输出信息中，各段的总和总是采用两种形式分别给出：十进制与十六进制数值（`-d` 或 `-x` 选项），八进制与十六进制数值（`-o` 选项）。

- `-t, --totals`：最后增加一行统计数据，显示所有目标文件或可执行文件的纵向累计（仅适用于 `-B` 选项的 Berkeley 显示格式）。

- `--common`：显示目标文件或可执行文件中通用标识符（*COM* syms）部分占用的空间总和。当使用 Berkeley 格式显示时，这个数据包含在 bss 段中。

- `--target=<bfdname>`：设置二进制文件格式。

- `@<file>`：从指定的文件 `<file>` 中读取命令行选项。

- `-h, --help`：显示帮助信息。

- `-v, --version`：显示版本信息。



## 示例

采用默认的 Berkeley 格式显示 bash 和 find 命令文件各段的大小与总和：

```shell
$ size -B /bin/bash /bin/find
   text	   data	    bss	    dec	    hex	filename
1127345	  47356	  40056	1214757	 128925	/bin/bash
 300059	  10408	   2712	 313179	  4c75b	/bin/find
```

在上述基础上增加一行统计数据：

```bash
$ size -Bt /bin/bash /bin/find
   text	   data	    bss	    dec	    hex	filename
1127345	  47356	  40056	1214757	 128925	/bin/bash
 300059	  10408	   2712	 313179	  4c75b	/bin/find
1427404	  57764	  42768	1527936	 175080	(TOTALS)
```

