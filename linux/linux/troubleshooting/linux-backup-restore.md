---
sidebar_position: 6
sidebar_label: 备份与恢复基础
slug: /linux-backup-restore
---

# Linux 备份与恢复基础

备份不是等系统出问题时才想起来的事。真正有用的备份，必须能恢复。Linux 初学者至少要理解哪些文件该备份、怎么备份、怎么验证。

## 先区分数据和系统

通常最重要的是数据，而不是系统本身。

常见需要备份：

- 用户家目录中的文档和项目。
- 服务配置文件。
- 数据库数据或数据库导出。
- 网站上传文件。
- 脚本和自动化任务。
- SSH 密钥和证书，但要妥善加密保存。

通常不需要完整备份：

- 软件包缓存。
- 临时文件。
- 构建产物。
- 可以重新安装的软件。

## 使用 tar 备份目录

备份一个目录：

```bash
tar -czf project-backup.tar.gz project
```

查看归档内容：

```bash
tar -tzf project-backup.tar.gz | head
```

恢复到当前目录：

```bash
tar -xzf project-backup.tar.gz
```

恢复到指定目录：

```bash
mkdir restore-test
tar -xzf project-backup.tar.gz -C restore-test
```

## 使用 rsync 同步备份

同步目录到备份目录：

```bash
rsync -av project/ backup/project/
```

演练模式：

```bash
rsync -av --dry-run project/ backup/project/
```

删除目标端多余文件，让目标和源保持一致：

```bash
rsync -av --delete project/ backup/project/
```

:::warning
使用 `--delete` 前先加 `--dry-run`。路径写错会删除目标端文件。
:::

## 数据库不能只复制目录

数据库通常不能简单复制数据目录当作备份，尤其是在数据库运行时。

更稳妥的做法是使用数据库自己的导出工具，例如：

- MySQL/MariaDB：`mysqldump` 或物理备份工具。
- PostgreSQL：`pg_dump`、`pg_dumpall` 或物理备份方案。
- SQLite：可以复制数据库文件，但也要注意写入中的一致性。

具体命令要参考数据库教程或官方文档。

## 备份配置文件

修改系统配置前先备份：

```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
```

如果改坏了，可以恢复：

```bash
sudo cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
```

然后重新加载或重启服务。

## 验证备份

备份完成不代表安全。你需要定期验证：

- 备份文件是否存在。
- 文件大小是否合理。
- 能否列出归档内容。
- 能否恢复到临时目录。
- 恢复后的服务或数据是否可用。

一个没有测试过的备份，只能叫“希望”。

## 备份原则

常见原则是保留多份副本：

- 本机一份。
- 外部磁盘或 NAS 一份。
- 异地或云端一份。

重要数据还要考虑：

- 加密。
- 权限。
- 自动化。
- 保留周期。
- 恢复演练。

## 小结

入门阶段你至少应该掌握：

- 用 `tar` 打包备份。
- 用 `rsync` 同步备份。
- 修改配置前先复制 `.bak`。
- 数据库要用专门方式备份。
- 备份必须测试恢复。

备份不是高级运维才需要的东西。你越早养成习惯，未来越少后悔。
