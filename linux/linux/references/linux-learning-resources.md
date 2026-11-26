---
sidebar_position: 4
sidebar_label: 学习路线与资源
slug: /linux-learning-resources
---

# Linux 学习路线与资源

学完《Linux 基础教程》后，你已经具备继续深入的基础。接下来不要急着到处跳，最好按方向逐步扩展。

## 建议学习路线

如果你是初学者，可以按这个顺序继续：

1. 熟练使用命令行：路径、文件、文本、查找、管道、权限。
2. 学习 Shell 脚本：变量、参数、流程控制、函数、文本处理。
3. 学习 Linux 服务管理：systemd、日志、定时任务、网络服务。
4. 学习网络基础：TCP/IP、DNS、HTTP、SSH、防火墙。
5. 学习系统排错：日志、进程、磁盘、内存、网络。
6. 按方向深入：服务器运维、嵌入式 Linux、Linux C 编程、驱动开发或云原生。

你不需要一次学完所有方向。Linux 是一套长期使用、长期积累的能力。

## GetIoT 相关教程

站内可以继续阅读：

- [Shell 教材](/linux-shell/)：系统学习 Shell 脚本。
- [Linux 命令大全](/linux-command/)：查询具体命令用法。
- [Linux 运维](/linux-ops/)：进一步学习服务器和运维场景。
- [Linux C 编程](/linux-c/)：学习 Linux 用户态 C 编程。
- [Linux 驱动开发](/ldd/)：深入内核和设备驱动。
- [嵌入式 Linux](/elinux/)：面向嵌入式系统开发。

## 官方和高质量资料

这些资料适合作为长期参考：

- [The Linux Kernel documentation](https://docs.kernel.org/)：Linux 内核官方文档，适合深入内核机制时阅读。
- [GNU Coreutils Manual](https://www.gnu.org/software/coreutils/manual/coreutils.html)：GNU coreutils 官方手册，覆盖大量基础命令。
- [Ubuntu Server documentation](https://ubuntu.com/server/docs/)：Ubuntu Server 官方文档，适合服务器入门和实践。
- [Debian Documentation](https://www.debian.org/doc/)：Debian 官方文档入口。
- [The Debian Administrator's Handbook](https://debian-handbook.info/)：系统学习 Debian 管理的免费书籍。
- [man7.org Linux manual pages](https://man7.org/linux/man-pages/)：在线 Linux man pages，适合查系统调用、库函数和命令文档。
- [Arch Wiki](https://wiki.archlinux.org/)：内容细、更新快，适合查配置和问题背景，但操作前要结合自己的发行版判断。

## 学习建议

不要用“收藏很多资料”代替学习。更有效的方法是：

- 每学一个命令，就在练习目录中运行几遍。
- 每遇到一个错误，就记录错误信息、排查过程和最终原因。
- 每完成一个小任务，就整理成自己的命令笔记。
- 多用 `man` 和 `--help`，少背孤立参数。
- 不懂的命令先拆开，再组合。

## 小项目练习

你可以尝试这些小项目：

- 写一个脚本备份指定目录。
- 用 `grep`、`sort`、`uniq` 分析一份日志。
- 配置 SSH key 登录自己的虚拟机或云服务器。
- 写一个 systemd service 运行自己的脚本。
- 用 `rsync` 同步项目目录到另一台机器。
- 模拟磁盘满、权限不足、端口占用并完成排查。

这些练习比单纯阅读更能形成能力。

## 小结

Linux 入门不是背命令大全，而是建立一套判断问题的框架。你需要知道文件在哪里、权限是谁的、进程是否运行、服务日志在哪里、网络哪一层出了问题。

当这些线索能连起来时，你就真正走进 Linux 世界了。
