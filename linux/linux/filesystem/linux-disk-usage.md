---
sidebar_position: 6
sidebar_label: 磁盘空间与目录大小
slug: /linux-disk-usage
---

# Linux 磁盘空间与目录大小：df、du

Linux 系统用久了，最常见的问题之一就是磁盘空间不足。你需要知道两个问题：

- 哪个文件系统快满了？
- 哪个目录占用了空间？

本文介绍 [df](/linux-command/df/) 和 [du](/linux-command/du/)。

## df：查看文件系统空间

查看磁盘空间：

```bash
df -h
```

输出类似：

```text
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda2        50G   31G   17G  66% /
tmpfs           1.9G  2.0M  1.9G   1% /run
```

`-h` 表示 human-readable，会用 `K`、`M`、`G` 显示容量。

你重点关注：

- `Filesystem`：文件系统或设备。
- `Size`：总容量。
- `Used`：已用空间。
- `Avail`：可用空间。
- `Use%`：使用率。
- `Mounted on`：挂载点。

如果 `/` 使用率接近 100%，系统可能无法写日志、安装软件，甚至服务启动失败。

## du：查看目录大小

查看当前目录下各文件和子目录大小：

```bash
du -h
```

只看总大小：

```bash
du -sh .
```

查看当前目录下一层内容大小：

```bash
du -h --max-depth=1
```

按大小排序：

```bash
du -h --max-depth=1 2>/dev/null | sort -h
```

## 找出大文件

在当前目录下查找大于 100 MB 的文件：

```bash
find . -type f -size +100M
```

如果要显示大小：

```bash
find . -type f -size +100M -exec ls -lh {} \;
```

这里的 `{}` 是 `find` 找到的文件，`\;` 表示这一段命令结束。你不需要马上记住所有细节，先知道它能把匹配结果交给 `ls -lh` 查看。

## inode 也可能用完

有时 `df -h` 看起来还有空间，但系统仍提示没有空间。这可能是 inode 用完了。

查看 inode：

```bash
df -i
```

inode 可以简单理解为文件的“索引节点”。大量小文件可能耗尽 inode，比如缓存目录、临时目录、邮件队列等。

## 常见清理方向

磁盘满了不要盲删。可以按下面顺序排查：

1. 用 `df -h` 找到快满的挂载点。
2. 用 `du -h --max-depth=1` 逐层定位大目录。
3. 判断大文件是否是日志、缓存、构建产物、旧备份。
4. 确认用途后再清理。

常见可检查目录：

- `/var/log`：日志。
- `/var/cache`：缓存。
- `~/Downloads`：下载文件。
- 项目目录中的 `build`、`dist`、`target`、`node_modules`。

:::warning
不要为了腾空间随意删除 `/usr`、`/lib`、`/bin`、`/etc` 中的文件。这些目录包含系统程序和配置，误删可能导致系统无法启动。
:::

## du 和 df 结果不一致

有时你删除了一个大日志文件，但 `df -h` 显示空间没有释放。这通常是因为某个进程仍然打开着这个已删除文件。

处理思路是：

- 找到持有文件的进程。
- 重启对应服务。
- 再检查空间。

这个问题在服务日志中较常见，后面的排错章节会继续讲。

## 小结

排查磁盘空间可以记住两条命令：

```bash
df -h
du -h --max-depth=1
```

`df` 看整体，`du` 找目录。不要急着删除，先定位，再判断，最后清理。
