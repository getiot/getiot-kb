---
sidebar_label: mktemp 命令
sidebar_position: 27
slug: /mktemp
description: "mktemp 命令用于安全地创建临时文件或目录，并输出其路径名。模板中的 X 会被随机字符替换，避免文件名冲突。在 Shell 脚本中常用于存放中间数据，配合 trap 可在脚本退出时自动清理。"
---

# Linux mktemp 命令 - 创建临时文件或目录



## 介绍

**mktemp** 命令用于安全地创建临时文件或目录，并输出其路径名。模板中的 `X` 会被随机字符替换，避免文件名冲突。在 Shell 脚本中常用于存放中间数据，配合 `trap` 可在脚本退出时自动清理。

mktemp 命令由 GNU coreutils 软件包提供，通常系统已预装。

**语法**：

```bash
mktemp [选项]... [模板]
```

模板中最后一部分必须包含至少 3 个连续的 `X`。未指定模板时，默认使用 `tmp.XXXXXXXXXX`。

**选项**：

- `-d, --directory`：创建目录而非文件
- `-u, --dry-run`：只打印名称，不实际创建（不安全，仅用于测试）
- `-q, --quiet`：创建失败时不输出诊断信息
- `--suffix=后缀`：在模板后追加后缀（后缀不能含斜杠）
- `-p 目录, --tmpdir[=目录]`：将模板视为相对于指定目录的名称；未指定目录时使用 `$TMPDIR` 或 `/tmp`
- `-t`：将模板视为相对于临时目录的纯文件名（已废弃，建议使用 `-p`）
- `--help`：显示帮助
- `--version`：显示版本

创建文件的默认权限为 `u+rw`（目录为 `u+rwx`），再减去 umask 限制。

相关命令：[rm](/linux-command/rm/)、[touch](/linux-command/touch/)、[mkdir](/linux-command/mkdir/)



## 示例

1、创建临时文件并获取路径：

```bash
tmpfile=$(mktemp)
echo "data" > "$tmpfile"
cat "$tmpfile"
rm "$tmpfile"
```

2、创建临时目录：

```bash
tmpdir=$(mktemp -d)
echo "working in $tmpdir"
rm -rf "$tmpdir"
```

3、指定模板格式：

```bash
mktemp /tmp/myapp.XXXXXX
```

4、创建带 `.log` 后缀的临时文件：

```bash
mktemp --suffix=.log
```

5、在脚本中安全使用，退出时自动清理：

```bash
tmpfile=$(mktemp)
trap 'rm -f "$tmpfile"' EXIT

# 使用临时文件 ...
echo "processing" > "$tmpfile"
```

6、在指定目录下创建临时文件：

```bash
mktemp -p /var/tmp app.XXXXXX
```
