---
sidebar_position: 54
slug: /locale
---

# locale 命令



## 介绍

**locale** 命令用于显示 Linux 系统本地语言环境等有关信息。如果未指定任何选项与参数，locale 将会显示 `LC_*` 系列环境变量表示的每个本地语言环境类别的当前设置。

**语法**：

```bash
locale [选项...] [names]
locale [选项...] [-a|-m]
```

其中，`names` 是 IEEE Std 1003.1-2001 定义的本地语言环境的类别，例如：

| 类别          | 定义                           |
| ------------- | ------------------------------ |
| `LC_CTYPE`    | 字符集编码定义                 |
| `LC_COLLATE`  | 排序原则与顺序定义             |
| `LC_TIME`     | 日期与时间格式定义             |
| `LC_NUMERIC`  | 非钱币的小数点与千分号定义     |
| `LC_MONETARY` | 钱币符号、小数点与千分号等定义 |
| `LC_MESSAGES` | 肯定与否定回答定义             |
| `LC_NAME`     | 称呼定义                       |

**选项**：

- `-a`, `--all-locales`：输出系统支持的所有本地语言环境。
- `-m`, `--charmaps`：显示可用字符集的名字，如 UTF-8（中文字符集）。
- `-c`, `--category-name`：显示命令行参数指定的本地语言类别的详细定义。有效的本地语言类别是 `LC_CTYPE` 等。
- `-k`, `--keyword-name`：显示选定关键字（如 ctype-class-names）的定义。
- `-v`, `--verbose`：详细显示模式。
- `--usage`：显示命令的简要用法。
- `-?`, `--help`：显示命令的帮助信息，然后退出。
- `-V`, `--version`：显示命令的版本和版权等信息，然后退出。



## 示例

显示系统支持的所有本地语言环境：

```bash
$ locale -av
locale: zh_CN.utf8      archive: /usr/lib/locale/locale-archive
-------------------------------------------------------------------------------
    title | Chinese locale for Peoples Republic of China
    email | bug-glibc-locales@gnu.org
 language | Chinese
territory | China
 revision | 0.1
     date | 2000-07-25
  codeset | UTF-8
```

显示本地语言环境的时间表示种类与方式：

```bash
$ locale -cv LC_TIME
LC_TIME
日;一;二;三;四;五;六
星期日;星期一;星期二;星期三;星期四;星期五;星期六
1月;2月;3月;4月;5月;6月;7月;8月;9月;10月;11月;12月
一月;二月;三月;四月;五月;六月;七月;八月;九月;十月;十一月;十二月
上午;下午
%Y年%m月%d日 %A %H时%M分%S秒
%Y年%m月%d日
%H时%M分%S秒
%p %I时%M分%S秒
```



