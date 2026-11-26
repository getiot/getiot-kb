---
sidebar_position: 3
sidebar_label: 常用命令速查
slug: /linux-command-cheatsheet
---

# Linux 常用命令速查

这是一份面向初学者的 Linux 常用命令速查表。它不是替代《Linux 命令大全》，而是帮助你在学习基础教程时快速回忆“该用哪个命令”。

更详细的参数和示例，请阅读 [Linux 命令大全](/linux-command/)。

## 路径和目录

| 需求 | 命令 |
| --- | --- |
| 查看当前目录 | [pwd](/linux-command/pwd/) |
| 切换目录 | [cd](/linux-command/cd/) |
| 查看目录内容 | [ls](/linux-command/ls/) |
| 创建目录 | [mkdir](/linux-command/mkdir/) |

## 文件操作

| 需求 | 命令 |
| --- | --- |
| 创建空文件或更新时间 | [touch](/linux-command/touch/) |
| 复制文件或目录 | [cp](/linux-command/cp/) |
| 移动或重命名 | [mv](/linux-command/mv/) |
| 删除文件或目录 | [rm](/linux-command/rm/) |
| 查看文件类型 | [file](/linux-command/file/) |
| 查看文件详细状态 | [stat](/linux-command/stat/) |

## 文本查看和搜索

| 需求 | 命令 |
| --- | --- |
| 输出短文件 | [cat](/linux-command/cat/) |
| 分页查看长文件 | [less](/linux-command/less/) |
| 查看开头 | [head](/linux-command/head/) |
| 查看结尾 | [tail](/linux-command/tail/) |
| 搜索文本 | [grep](/linux-command/grep/) |
| 统计行数、字数 | [wc](/linux-command/wc/) |

## 查找

| 需求 | 命令 |
| --- | --- |
| 按条件查找文件 | [find](/linux-command/find/) |
| 快速按文件名查找 | [locate](/linux-command/locate/) |
| 查命令路径 | [which](/linux-command/which/) |
| 查命令类型 | [type](/linux-command/type/) |
| 查命令相关文件 | [whereis](/linux-command/whereis/) |

## 权限和用户

| 需求 | 命令 |
| --- | --- |
| 查看当前用户 | [whoami](/linux-command/whoami/) |
| 查看用户身份 | [id](/linux-command/id/) |
| 临时提升权限 | [sudo](/linux-command/sudo/) |
| 切换用户 | [su](/linux-command/su/) |
| 修改权限 | [chmod](/linux-command/chmod/) |
| 修改所有者 | [chown](/linux-command/chown/) |
| 查看默认权限掩码 | [umask](/linux-command/umask/) |

## 磁盘和挂载

| 需求 | 命令 |
| --- | --- |
| 查看磁盘空间 | [df](/linux-command/df/) |
| 查看目录大小 | [du](/linux-command/du/) |
| 查看块设备 | [lsblk](/linux-command/lsblk/) |
| 挂载文件系统 | [mount](/linux-command/mount/) |
| 卸载文件系统 | [umount](/linux-command/umount/) |

## 进程和服务

| 需求 | 命令 |
| --- | --- |
| 查看进程 | [ps](/linux-command/ps/) |
| 动态查看进程 | [top](/linux-command/top/) |
| 交互式进程查看 | [htop](/linux-command/htop/) |
| 结束进程 | [kill](/linux-command/kill/) |
| 查看后台作业 | [jobs](/linux-command/jobs/) |
| 管理服务 | [systemctl](/linux-command/systemctl/) |
| 管理定时任务 | [crontab](/linux-command/crontab/) |

## 网络

| 需求 | 命令 |
| --- | --- |
| 查看 IP 和路由 | [ip](/linux-command/ip/) |
| 测试连通性 | [ping](/linux-command/ping/) |
| 查看端口监听 | [ss](/linux-command/ss/) |
| 发起 HTTP 请求 | [curl](/linux-command/curl/) |
| 查询 DNS | [dig](/linux-command/dig/) |
| SSH 登录 | [ssh](/linux-command/ssh/) |
| 复制远程文件 | [scp](/linux-command/scp/) |
| 同步文件 | [rsync](/linux-command/rsync/) |

## 软件包

| 发行版 | 常用命令 |
| --- | --- |
| Debian/Ubuntu | [apt](/linux-command/apt/) |
| Debian/Ubuntu 底层工具 | [dpkg](/linux-command/dpkg/) |
| Fedora/RHEL 系 | [dnf](/linux-command/dnf/) |
| 旧 RHEL/CentOS | [yum](/linux-command/yum/) |

## 获取帮助

| 需求 | 命令 |
| --- | --- |
| 查看手册 | [man](/linux-command/man/) |
| 查看 GNU info 文档 | [info](/linux-command/info/) |
| 快速了解命令用途 | [whatis](/linux-command/whatis/) |
| 查看命令帮助 | `命令 --help` |

## 小结

速查表的意义是帮你快速定位方向。真正使用时，建议继续阅读每个命令的详细页面，并在 `~/linux-practice` 目录中动手练习。
