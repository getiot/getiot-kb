---
sidebar_position: 4
sidebar_label: 文件传输
slug: /linux-scp-rsync
---

# Linux 文件传输：scp 与 rsync

远程使用 Linux 时，你经常需要在本机和服务器之间传文件。最常用的两个工具是 [scp](/linux-command/scp/) 和 [rsync](/linux-command/rsync/)。

它们通常都通过 SSH 连接，因此在学习本文前，建议先阅读 [通过 SSH 连接 Linux](connect-using-ssh.md)。

## scp：简单复制

从本机复制文件到服务器：

```bash
scp local.txt user@example.com:/home/user/
```

从服务器复制文件到本机：

```bash
scp user@example.com:/home/user/remote.txt .
```

复制目录需要加 `-r`：

```bash
scp -r project user@example.com:/home/user/
```

指定 SSH 端口：

```bash
scp -P 2222 local.txt user@example.com:/home/user/
```

注意这里是大写 `-P`。

## rsync：适合同步

`rsync` 适合重复同步目录。它会尽量只传输变化部分，比每次完整复制更高效。

同步本地目录到服务器：

```bash
rsync -av project/ user@example.com:/home/user/project/
```

常用选项：

- `-a`：归档模式，保留权限、时间等信息。
- `-v`：显示详细过程。
- `-z`：传输时压缩。
- `--delete`：删除目标端多余文件，让两边保持一致。
- `--dry-run`：演练，不真正修改。

## 注意末尾斜杠

`rsync` 的源路径末尾斜杠很重要。

```bash
rsync -av project user@example.com:/home/user/backup/
```

会把整个 `project` 目录复制到 `backup` 下。

```bash
rsync -av project/ user@example.com:/home/user/backup/
```

会把 `project` 目录里面的内容复制到 `backup` 下。

初学时建议先加 `--dry-run` 看结果：

```bash
rsync -av --dry-run project/ user@example.com:/home/user/backup/
```

确认输出符合预期后，再去掉 `--dry-run`。

## 指定 SSH 端口

如果服务器 SSH 端口不是 22：

```bash
rsync -av -e "ssh -p 2222" project/ user@example.com:/home/user/project/
```

## 什么时候用 scp，什么时候用 rsync

| 场景 | 推荐 |
| --- | --- |
| 偶尔复制一个文件 | `scp` |
| 复制一个小目录 | `scp -r` |
| 经常同步项目目录 | `rsync -av` |
| 传输大目录，只想更新变化部分 | `rsync` |
| 需要删除目标端多余文件 | `rsync --delete` |

## 安全提醒

使用远程路径前，先确认目标目录：

```bash
ssh user@example.com "pwd && ls"
```

使用 `rsync --delete` 前一定先演练：

```bash
rsync -av --delete --dry-run source/ user@example.com:/target/
```

:::warning
`rsync --delete` 会删除目标端多余文件。路径写错时，可能造成严重数据丢失。
:::

## 小结

你可以先记住：

- `scp file user@host:/path/`：复制单个文件到远程。
- `scp user@host:/path/file .`：从远程复制文件到本地。
- `rsync -av source/ user@host:/target/`：同步目录内容。
- `rsync --dry-run`：先演练，确认会发生什么。

当你开始管理服务器或开发板时，`scp` 和 `rsync` 会非常常用。
