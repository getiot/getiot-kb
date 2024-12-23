---
sidebar_label: find 命令
sidebar_position: 10
slug: /find
---

# Linux find 命令 - 查找文件或目录



## 介绍

**find** 命令是 Linux 系统管理员中最强大的工具之一。find 命令会根据用户指定的表达式（权限、类型、日期、所有权、大小等条件）在目录层次结构中搜索文件和目录，并且可以对每个匹配的文件执行用户指定的操作。另外，也可以将 find 命令与其他工具结合使用，例如 [`grep`](/linux-command/grep) 或 [`sed`](/linux-command/sed)，实现更复杂的功能。

**语法**：

```bash
find [-H] [-L] [-P] [-Olevel] [-D debugopts] [path...] [expression]
```

**选项**：

- `path...` 路径属性定义搜索文件的起始目录，可以指定一个或多个起始目录。
- `expression` 表达式属性由选项，搜索模式和由运算符分隔的动作组成。

要在目录中搜索文件，调用 `find` 命令的用户需要对起始目录以及子目录具有读取权限。

让我们看一下示例 `find -L /var/www -name "*.js"`。选项`-L`告诉`find`命令跟随符号链接。

`/var/www`是find命令搜索的开始目录。表达式`-name "*.js`告诉`find`搜索以`.js`结尾的文件JavaScript文件。



## 示例

### 按名称查找/搜索文件

通过名称查找文件可能是 `find` 命令的最常见用法。要使用文件名查找文件，请在要搜索的文件名后加上 `-name` 选项。

例如，要在 `/home/getiot` 目录中搜索名为 `document.pdf` 的文件，可以使用命令 `find /home/getiot -type f -name document.pdf`。

find 的 `-name` 选项是区分大小写的，如果你需要运行不区分大小写的搜索，请将 `-name` 选项更改为 `-iname`。find 命令将匹配 `Document.pdf`，`DOCUMENT.pdf` 等。

```bash
find /home/getiot -type f -iname document.pdf
```



### 按文件扩展名查找文件

根据扩展名搜索文件与按名称搜索文件相同。例如，要在 `/var/log/nginx` 目录中查找所有以 `.log.gz` 结尾的文件，可以使用下面命令。

```bash
find /var/log/nginx -type f -name '*.log.gz'
```

值得一提的是，使用通配符时，必须加单/双引号或用反斜杠`\`转义星号符号`*`，以避免shell解释它。

要查找与正则表达式 `*.log.gz` 不匹配的所有文件，可以使用 find 命令的 `-not` 选项。例如，要查找所有未以 `*.log.gz` 结尾的文件，你可以使用以下 find 命令。

```bash
find /var/log/nginx -type f -not -name '*.log.gz'
```



### 按类型查找文件

有时你可能需要搜索指定的文件类型，例如普通文件，目录或符号链接。在 Linux 中，一切都是文件，包括目录。

要根据文件的类型搜索文件，请使用 find 的 `-type` 选项指定文件类型。这里我们列出了 Linux 中所有文件的类型。

`f` 是常规文件，`d` 是目录，`l` 是[符号链接](/linux/linux-hard-soft-link)，`c` 是字符设备，`b` 是块设备，`p` 是命名管道 FIFO，`s` 是 socket 套接字。

例如，要在当前工作目录中查找所有目录，可以使用命令 `find . -type d`，这里 `.` 表是当前目录，`-type d` 指定文件类型是目录。

常见示例是使用 [`chmod`](/linux-command/chmod) 命令将网站文件权限递归更改为 `644`，目录权限更改为 `755`：

```bash
find /var/www/my_website -type d -exec chmod 0755 {} \;
find /var/www/my_website -type f -exec chmod 0644 {} \;
```



### 按大小查找文件

要根据文件大小查找文件，请使用 find 命令的 `-size` 选项，之后指定文件的大小。你可以使用以下后缀指定文件大小。

如果你使用 `-size` 选项，但为指定文件的大小，find 将会使用 512 字节作为大小进行文件的搜索。

`b` 是 512 字节，`c` 是字节，`w` 是两字节，`k` 千字节即 kb， `M` 是兆字节，即 MB，`G` 是千兆字节即是 GB。

例如命令 `find /tmp -type f -size 1024c` 将在 `/tmp` 目录中找到所有 1024 字节的文件。

find 命令还允许你搜索大于或小于指定大小的文件。你可以使用加减符号和文件的大小表示大于或者小于，`+` 符号表示大于，`-` 减符号表示小于。

例如命令 `find . -type f -size -1M`，将在当前工作目录中搜索所有小于 `1MB` 的文件。注意大小值之前的是减号符号 `-`。

命令 `find . -type f -size +1M` 将搜索大小大于 `1MB` 的文件，注意大小值之前的是加号符号 `+`。

你甚至可以搜索大小范围内的文件。以下 find 命令将在当前目录下搜索/查找 `1MB` 到和 `2MB` 之间的所有文件。

```bash
find . -type f -size +1M -size 21M
```



### 按日期查找文件

`find`命令还可以根据文件的最后修改，访问或更改时间来搜索文件。与按大小搜索时相同，使用加号和减号表示大于或小于。

例如命令 `find /etc/dovecot/conf.d -name "*.conf" -mtime 5`。将搜索 `/etc/dovecot/conf.d` 目录下以 `.conf` 结尾并且在最近五天内已被修改的所有文件。

除了使用 24 小时作为单位之外，你还可以使用分钟、小时、秒等单位作为搜索的条件。我们将在这里列出这些选项。

`-amin` 表示文件最后的访问时间，以分钟作为单位。`-atime` 表示最后的访问时间，以 24 小时作为单位，即一天。这两个选项都表示在指定访问时间之内。

`-cmin` 表示文件在最后更改时间，以分钟作为单位。`-ctime` 表示文件在最后更改时间，但以 24 小时作为单位，即一天。这两个选项都表示在指定最后更改时间之内。

`-mmin` 表示文件的最后修改时间，以分钟作为单位。`-mtime` 表示文件的最后修改时间，但以 24 小时作为单位，即一天。这两个选项都表示在指定修改时间之内。

如果你需要指定修改，访问或更改时间之外作为搜索条件。你可以使用 find 的 `-daystart` 选项。它将会修改以上选项为时间之外。

这是根据修改日期过滤文件的另一个示例。以下命令将列出 `/home` 目录中 30 多天之后修改的所有文件，包括 30 天的。

```bash
find /home -mtime +30 -daystart
```



### 按权限查找文件

find 的 `-perm` 选项可让你根据文件权限搜索文件。你可以使用文件权限的符号模式，或者数字模式进行搜索。

我们建议你使用数字模式，因为符号模式会显得更复杂，这不易于阅读。你可以在数字模式前加上减号 `-` 或斜线 `/`。

如果将斜线 `/` 用作前缀，则至少是用户，组或其他人的其中一个权限位与文件匹配。如果将减号 `-` 用作前缀，则文件的权限位必须全匹配。

```bash
find . -perm /444
find . -perm -664
```



### 按所有者查找文件

find 的 `-user` 和 `-group` 选项允许你要查找指定用户或组拥有的文件。例如命令 `find / -user getiot`，将会搜索用户 `getiot` 拥有的所有文件和目录。

这是一个真实的例子。假设你要查找 `www-data` 用户拥有的所有文件，并将匹配文件的所有权从 `www-data` 更改为 `nginx`。

```bash
find / -user www-data -type f  -exec chown nginx {} \;
```



### 查找并删除文件

将 `-delete` 选项附加到匹配表达式的末尾。find 将会删除所有匹配的文件。

建议仅在确定结果与要删除的文件匹配时，使用 `-delete` 选项。你可以先打印匹配的文件，然后再加 `-delete` 选项。请谨慎使用 `-delete` 选项。

对于目录的删除，find 的 `--delete` 选项只能删除与 `rmdir` 相同的空目录。例如，要从 `/var/log/` 中删除所有以 `.temp` 结尾的文件，你可以运行以下 find 命令。

```bash
find /var/log/ -name `*.temp` -delete
```

