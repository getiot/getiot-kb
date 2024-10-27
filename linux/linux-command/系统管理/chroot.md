---
sidebar_label: chroot 命令
sidebar_position: 43
slug: /chroot
---

# chroot 命令



## 介绍

**chroot**（英文全称：change root directory）命令用于改变根目录。

Linux 系统的目录结构默认都是以 root 根目录（即 `/`）开始的，使用 chroot 命令可以将指定的目录作为根目录。

**语法**：

```bash
chroot [OPTION] NEWROOT [COMMAND [ARG]...]
```

**选项**：

- `--groups=G_LIST` ：指定补充组，如 g1, g2, ... , gN。
- `--userspec=USER:GROUP` ：指定使用的用户和组（通过 ID 或 name）。
- `--skip-chdir` ：不用将工作目录更改为 `/`。
- `--help` ：显示帮助信息并退出。
- `--version` ：显示版本信息并退出。

如果没有指定 COMMAND 命令，chroot 默认会执行 `${SHELL} -i`，进入 shell 交互模式。



## 示例

假设 /opt/rootfs 目录是一个可用的文件系统

```bash
$ ls /opt/rootfs/
bin  boot  dev  etc  home  lib  media  mnt  opt  proc  run  sbin  sys  tmp  usr  var
```

先执行下面命令查看当前进程指向的根目录

```bash
$ ls -ld /proc/self/root
lrwxrwxrwx 1 root root 0 Jun  5 14:14 /proc/self/root -> /
```

查看当前根文件系统的 /etc/version 信息

```bash
$ cat /etc/version
20210330083304
```

查看执行 chroot 后的 /etc/version 信息

```bash
$ sudo chroot /opt/rootfs cat /etc/version
20210605043324
```

不带命令执行 chroot

```bash
$ sudo chroot /opt/rootfs
```

再次查看此时的 /etc/version 信息

```bash
$ cat /etc/version
20210605043324
```

执行 `exit` 退出并返回到原来的根文件系统。



