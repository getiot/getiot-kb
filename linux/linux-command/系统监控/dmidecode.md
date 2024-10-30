---
sidebar_label: dmidecode 命令
sidebar_position: 5
slug: /dmidecode
---

# Linux dmidecode 命令 - 读取 DMI 信息



## 介绍

**dmidecode** 命令主要是通过 DMI 获取 Linux 主机的硬件信息。遵循 SMBIOS/DMI 标准，输出的信息包括 BIOS、系统、主板、处理器、内存、缓存等等。

DMI（Desktop Management Interface）是帮助收集电脑系统信息的管理系统，它的主要组成部分是 MIF（Management InformationFormat）数据库，这个数据库包括了所有有关电脑系统和配件的信息。dmidecode 的工作原理就是将 DMI 数据库中的信息解码，以人类可读的文本方式显示出来。但由于 DMI 信息可以人为修改，因此里面的信息不一定是系统准确的信息。

DMI 信息的收集必须在严格遵照 SMBIOS 规范的前提下进行。SMBIOS（System Management BIOS）是主板或系统制造者以标准格式显示产品管理信息所需遵循的统一规范。SMBIOS 和 DMI 是由行业指导机构 Desktop Management Task Force (DMTF) 起草的开放性的技术标准，其中 DMI 设计适用于任何的平台和操作系统。DMI 充当了管理工具和系统层之间接口的角色，它建立了标准的可管理系统更加方便了电脑厂商和用户对系统的了解。

**语法**：

```shell
dmidecode [OPTIONS]
```

**选项**：

- `-d`, `--dev-mem FILE` ：从设备文件（默认为 /dev/mem）读取信息。
- `-h`, `--help` ：显示帮助信息。
- `-q`, `--quiet` ：输出尽可能少的信息。
- `-s`, `--string KEYWORD` ：只显示指定 DMI 字符串的信息。
- `-t`, `--type TYPE` ：只显示指定类型的条目。
- `-H`, `--handle HANDLE` ：只显示指定句柄的条目内容。
- `-u`, `--dump` ：显示未解码的原始条目内容。
- `--dump-bin FILE` ：将 DMI 数据转储到一个二进制文件中。
- `--from-dump FILE` ：从一个二进制文件读取 DMI 数据。
- `-V`, `--version` ：显示版本信息。

**关键字 KEYWORD 的合法字符串包括**：

- bios-vendor
- bios-version
- bios-release-date
- system-manufacturer
- system-product-name
- system-version
- system-serial-number
- system-uuid
- baseboard-manufacturer
- baseboard-product-name
- baseboard-version
- baseboard-serial-number
- baseboard-asset-tag
- chassis-manufacturer
- chassis-type
- chassis-version
- chassis-serial-number
- chassis-asset-tag
- processor-family
- processor-manufacturer
- processor-version
- processor-frequency

**类型 TYPE 的合法字符串包括**：

- bios
- system
- baseboard
- chassis
- processor
- memory
- cache
- connector
- slot



## 示例

不带选项执行通常会输出所有的硬件信息（该命令需要 root 权限，请自行添加 sudo）

```shell
dmidecode
```

查看服务器型号

```shell
dmidecode | grep 'Product Name'
```

查看主板的序列号

```shell
dmidecode |grep 'Serial Number'
```

查看系统序列号

```shell
dmidecode -s system-serial-number
```

查看内存信息

```shell
dmidecode -t memory
```

查看 BIOS 信息（对应 type 为 0）

```shell
dmidecode -t 0
```

以简洁形式输出所有硬件信息

```shell
dmidecode -q
```

