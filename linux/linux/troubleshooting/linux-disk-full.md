---
sidebar_position: 2
sidebar_label: 磁盘满了怎么办
slug: /linux-disk-full
---

# Linux 磁盘满了怎么办

磁盘满了会引发很多问题：软件安装失败、服务写日志失败、数据库异常、系统登录异常。排查时不要急着删除文件，要先判断是哪块空间满了。

## 第一步：查看整体空间

```bash
df -h
```

重点看 `Use%` 接近 100% 的挂载点。例如：

```text
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda2        50G   49G     0 100% /
```

这表示根文件系统 `/` 已满。

## 第二步：查看 inode

```bash
df -i
```

如果 inode 使用率 100%，即使磁盘容量还有剩余，也可能无法创建新文件。大量小文件会导致这种情况。

## 第三步：定位大目录

从满的挂载点开始查。比如 `/` 满了：

```bash
sudo du -h --max-depth=1 / 2>/dev/null | sort -h
```

如果发现 `/var` 很大：

```bash
sudo du -h --max-depth=1 /var 2>/dev/null | sort -h
```

逐层向下，直到找到真正占空间的目录。

## 第四步：判断能不能删

常见可检查对象：

- 旧日志：`/var/log`
- 软件包缓存：`/var/cache`
- 用户下载目录：`~/Downloads`
- 项目构建产物：`build`、`dist`、`target`
- 临时文件：`/tmp`
- 旧备份：`backup`、`*.tar.gz`

不要随意删除：

- `/bin`
- `/sbin`
- `/lib`
- `/usr`
- `/etc`
- 数据库数据目录

删除前先确认文件用途和最近修改时间：

```bash
ls -lh file
stat file
```

## 清理 systemd journal

查看 journal 占用：

```bash
journalctl --disk-usage
```

保留最近 7 天：

```bash
sudo journalctl --vacuum-time=7d
```

或限制为 1 GB：

```bash
sudo journalctl --vacuum-size=1G
```

清理前请确认不需要旧日志排错。

## 删除后空间没有释放

如果删除了大文件，但 `df -h` 仍显示空间没释放，可能是有进程仍然打开着这个文件。

可以尝试重启相关服务。如果你知道是某个服务的日志文件，可以：

```bash
sudo systemctl restart 服务名
```

生产环境中重启服务前要评估影响。

## 防止再次发生

可以采取这些措施：

- 配置日志轮转。
- 给备份设置保留周期。
- 监控磁盘使用率。
- 把数据目录放到独立分区或磁盘。
- 定期清理构建产物和缓存。

## 小结

磁盘满了时按这个顺序：

```bash
df -h
df -i
sudo du -h --max-depth=1 / 2>/dev/null | sort -h
```

先定位，再判断，最后清理。不要为了腾空间盲删系统目录。
