---
sidebar_label: seq 命令
sidebar_position: 3
slug: /seq
---

# seq 命令



## 介绍

**seq**（英文全拼：sequence）命令用于产生一串序列化的数字，即从某个数到另外一个数之间的所有整数。

**语法**：

```bash
seq [OPTION]... LAST
seq [OPTION]... FIRST LAST
seq [OPTION]... FIRST INCREMENT LAST
```

**选项**：

- `-f`, `--format=FORMAT` ：使用 printf 样式的浮点格式。
- `-s`, `--separator=STRING` ：使用指定字符串分隔数字（默认使用：`\n`）。
- `-w`, `--equal-width` ：在列前添加 0 使得宽度相同。
- `--help` ：显示帮助信息并退出。
- `--version` ：输出版本信息并退出。

**参数**：`FIRST` 为首数，`INCREMENT` 为增量，`LAST` 为尾数。



## 示例

指定格式输出 9-11 的整数

```bash
$ seq -f"%3g" 9 11
  9
 10
 11
```

指定输出等宽数字

```bash
$ seq -w 98 2 102
098
100
102
```

