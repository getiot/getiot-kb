---
sidebar_label: date 命令
sidebar_position: 18
slug: /date
---

# Linux date 命令 - 显示/设置日期时间



## 介绍

**date** 命令用于显示或设置 Linux 系统的日期和时间。

**语法**：

```bash
date [OPTION]... [+FORMAT]
date [-u|--utc|--universal] [MMDDhhmm[[CC]YY][.ss]]
```

**选项**：

- `-d`, `--date=STRING` ：显示字符串所指的日期与时间，字符串前后必须加上双引号。
- `-s`, `--set=STRING` ：根据字符串来设置日期与时间，字符串前后必须加上双引号。
- `-u`, `--utc`, `--universal` ：以 UTC 时间显示或设置。
- `--help` ：显示帮助信息。
- `--version` ：显示版本信息。

**参数**：指定显示时使用的日期时间格式。

具体的日期格式字符串列表如下：

- `%H` 小时，24小时制（00~23）
- `%I` 小时，12小时制（01~12）
- `%k` 小时，24小时制（0~23）
- `%l` 小时，12小时制（1~12）
- `%M` 分钟（00~59）
- `%p` 显示出 AM 或 PM
- `%r` 显示时间，12小时制（`hh:mm:ss %p`）
- `%s` 从1970年1月1日 00:00:00 到目前经历的秒数
- `%S` 显示秒（00~59）
- `%T` 显示时间，24小时制（`hh:mm:ss`）
- `%X` 显示时间的格式（`%H:%M:%S`）
- `%Z` 显示时区，日期域（CST）
- `%a` 显示星期的缩写（Sun~Sat）
- `%A` 显示星期的全称（Sunday~Saturday）
- `%h`, `%b` 显示月份的缩写（Jan~Dec）
- `%B` 显示月份的全称（January~December）
- `%c` 显示日期和时间（Tue Nov 20 14:12:58 2012）
- `%d` 显示一个月的第几天（01~31）
- `%x`, `%D` 显示日期（`mm/dd/yy`）
- `%j` 显示一年的第几天（001~366）
- `%m` 显示月份（01~12）
- `%w` 显示一个星期的第几天（0 代表星期天）
- `%W` 显示一年的第几个星期（00~53，星期一为第一天）
- `%y` 显示年份的最后两个数字（1999 则是 99）



## 示例

显示当前日期（年、月、日）：

```bash
$ date +"%Y year %m month %d day"
2021 year 05 month 30 day
```

显示昨天日期：

```bash
$ date -d "1 day ago" +"%Y-%m-%d"
2021-05-29
```

显示前天日期：

```bash
date -d "-2 day"
```

显示 30 秒后的时间：

```bash
date -d "30 second"
```

以指定时间显示（而不是当前时间）：

```bash
date --date="2060/01/01 08:00:00"
```

重新设定系统时间：

```bash
date --set="2060/01/01 08:00:00"
```

查看当前日期的时间戳：

```bash
date +%s
```

查看指定日期的时间戳：

```bash
date -d '2020-12-01 00:00:00' +%s
```

将时间戳转换为时间显示：

```bash
date -d @1669345425
```

