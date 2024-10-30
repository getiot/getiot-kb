---
sidebar_label: modinfo 命令
sidebar_position: 27
slug: /modinfo
---

# modinfo 命令 - 显示模块信息



## 介绍

**modinfo**（英文全拼：module information）命令用于显示指定的 Linux 内核模块的相关信息。

默认情况下，为了便于阅读，会以 `fieldname : value` 的格式列出模块的每个属性。

**语法**：

```bash
modinfo [-0] [-F field] [modulename|filename...]
```

**选项**：

- `-F`, `--field` ：仅在一行上显示 field 值，这对于脚本较为有用。常用的 field 有 author、description、licence、param、depends、alias、filename。
- `-0`, `--null` ：使用 ASCII 码的 `0` 字符分隔 field 值，而不是一个换行符。（该选项对脚本比较有用）
- `-a`、`-d`、`-l`、`-p`、`-n` ：这些分别是 author、description、license、param、filename 的简短形式，用于显示对应的信息。
- `-V`, `--version` ：显示版本信息。

**参数**：模块名或文件名。如果使用模块名，而没有指定文件名，则会在 `/lib/modules/$(uname -r)` 目录中搜索，就像 [modprobe](/linux-command/modprobe) 一样。



## 示例

显示 sg 模块（SCSI generic 驱动）的信息

```bash
modinfo sg 
```

显示 sg 模块的开发人员信息

```bash
modinfo -a sg
```

显示 sg 模块的描述信息

```bash
modinfo -d sg
```

显示 sg 模块的许可信息

```bash
modinfo -l sg
```

显示 sg 模块所支持的参数

```bash
modinfo -p sg
```

