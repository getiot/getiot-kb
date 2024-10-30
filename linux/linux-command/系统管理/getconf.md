---
sidebar_label: getconf 命令
sidebar_position: 44
slug: /getconf
---

# Linux getconf 命令 - 查询系统配置变量



## 介绍

**getconf**（英文全拼：get system configuration）命令用于查询系统配置变量的值。

**语法**：

```bash
getconf -a
getconf [-v specification] system_var
getconf [-v specification] path_var pathname
```

**选项**：

- `-a` ：显示当前系统的所有配置变量（configuration variables）及其值。
- `-v` ：指示获取配置变量的规范和版本。

**参数**：

- `system_var` ：系统变量（具体系统变量名称参考 sysconf 或 confstr 定义）。
- `path_var` ：路径名称（具体参考 pathconf 定义），必须带上 pathname 参数。



## 示例

查看当前系统的所有配置变量及其对应的值

```bash
$ getconf  -a
LINK_MAX                           65000
_POSIX_LINK_MAX                    65000
MAX_CANON                          255
_POSIX_MAX_CANON                   255
MAX_INPUT                          255
_POSIX_MAX_INPUT                   255
NAME_MAX                           255
_POSIX_NAME_MAX                    255
PATH_MAX                           4096
_POSIX_PATH_MAX                    4096
PIPE_BUF                           4096
_POSIX_PIPE_BUF                    4096
...
```

查看 Linux 内存页大小（单位字节）

```bash
$ getconf PAGE_SIZE
4096
```

查看 /usr 目录内的文件名允许的最大字节数

```bash
$ getconf NAME_MAX /usr
255
```

查看 Linux 系统位数（32 位 / 64 位）

```bash
$ getconf LONG_BIT
64
```





