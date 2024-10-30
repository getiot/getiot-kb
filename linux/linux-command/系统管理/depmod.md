---
sidebar_label: depmod 命令
sidebar_position: 29
slug: /depmod
---

# Linux depmod 命令 - 处理模块依赖



## 介绍

**depmod**（英文全拼：dependency modules）命令用于分析可载入模块的相依性，生成内核模块及其关联映射文件的依赖关系描述列表。

执行 depmod 命令将分析 `/lib/modules/'uname -r'` 目录中的内核模块（`uname -r` 是内核版本），并根据模块集中存在的符号创建一个类似于 Makefile 的依赖文件，名为 modules.dep。通常在构建嵌入式系统时，需要由这个命令来生成相应的文件，供 [modprobe](/linux-command/modprobe) 在安装模块时使用。

实际上，depmod 和 modprobe 命令工具简化了 Linux 模块化内核，方便系统维护人员进行管理。

**语法**：

```shell
depmod [options]
```

详细语法格式

```shell
depmod [ -a ] [ -b basedir ] [ -e ] [ -F System.map ] [ -n ] [ -v ] [ version ] [ -A ]
       [-n] [-v] [-A] [-P prefix] [-w] [version]

depmod [-e] [-E Module.symvers] [-F System.map] [-m] [-n] [-v] [-P prefix]
       [-w] [version] [filename...][Tex]
```

**选项**：

- `-a`, `--all` ：分析所有可用的模块；
- `-d`, `debug` ：执行排错模式；
- `-e` ：输出无法参照的符号；
- `-i` ：不检查符号表的版本；
- `-s`, `--system-log` ：在系统记录中记录错误；
- `-v`, `--verbose` ：执行时显示详细的信息；
- `-V`, `--version` ：显示版本信息；
- `--help` ：显示帮助。



## 示例

从默认位置检索模块文件，之后就可以将其载入内核

```shell
sudo ln -s /path/to/your-kernel-module.ko /lib/modules/`uname -r`
sudo depmod -a
sudo modprobe your-kernel-module
```

