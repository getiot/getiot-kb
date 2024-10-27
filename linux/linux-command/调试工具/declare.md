---
sidebar_label: declare 命令
sidebar_position: 8
slug: /declare
---

# declare 命令



## 介绍

在 Linux 中，**`declare`** 命令主要用于声明变量的属性，尤其是在 Shell 脚本编程中。它有几个用途，包括声明变量的类型、属性和设置变量的值。declare 命令若不带任何参数选项，则会显示所有 Shell 变量及其值。

需要注意的是，`declare` 命令在交互式 shell 中可能不如在脚本中常见，因为它通常用于在脚本中显式声明变量的属性。在交互式 shell 中，通常直接使用简单的变量赋值语句。

**语法**：

```bash
declare [-aAfFgilnrtux] [-p] [名称[=值] ...]
```

**选项**：

- `-f`：限制动作或显示为仅函数名称和定义。
- `-F`：限制仅显示函数名称（以及调试时显示行号和源文件名）。
- `-g`：当用于 shell 函数内时创建全局变量，否则忽略。
- `-p`：显示每个 NAME 变量的属性和值。

设定属性的选项：

- `-a`：使 NAME 成为下标数组（如果支持）。
- `-A`：使 NAME 成为关联数组（如果支持）
- `-i`：使 NAME 带有 `integer`（整数）属性。
-  `-l`：将 NAME 在赋值时转为小写。
- `-n`：使 NAME 成为指向一个以其值为名称的变量的引用。
- `-r`：将 NAME 变为只读。
- `-t`：使 NAME 带有 `trace`（追踪）属性。
- `-u`：将每个 NAME 在赋值时转为大写。
- `-x`：将 NAME 导出。



## 示例

声明一个普通的变量，并给它赋予一个初始值：

```bash
declare variable_name=value
```

声明一个只读变量（一旦设置，该变量的值将不能被修改）：

```bash
declare -r readonly_variable=value
```

声明一个整数变量（`declare` 会尝试将变量的值作为整数处理）：

```bash
declare -i integer_variable=value
```

声明一个数组变量，并初始化数组元素：

```bash
declare -a array_variable=(value1 value2 value3)
```

声明一个关联数组（Associative Array），关联数组使用字符串作为索引：

```bash
declare -A associative_array_variable
```

声明一个函数，显示函数的定义：

```bash
declare -f function_name
```

显示变量或函数的属性，包括类型、值等信息：

```bash
declare -p variable_name
declare -f function_name
```

取消变量的某些属性，比如取消只读属性：

```bash
declare +属性 variable_name
```

