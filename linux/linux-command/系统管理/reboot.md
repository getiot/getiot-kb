---
sidebar_label: reboot 命令
sidebar_position: 46
slug: /reboot
---

# Linux reboot 命令 - 重启系统



## 介绍

在 Linux 系统中，**reboot** 命令用于重新启动计算机，类似于 Windows 系统中的 `restart` 命令。需要注意，机器重启必须要 root 用户才有权限。

**语法**：

```bash
reboot [OPTIONS...]
```

**选项**：

- `-n`：在重启之前不做将记忆体资料写回硬盘的动作，即没有同步操作。
- `-w`：并不会真的重启，只是把记录写到 /var/log/wtmp 文件里。
- `-d`：不把记录写到 /var/log/wtmp 文件里（`-n` 选项包含了 `-d`）。
- `-f`：强制重启，不呼叫 `shutdown` 这个指令。
- `-i`：在重启之前先把所有网络相关的设备停止。



## 示例

重新启动机器：

```bash
reboot
```

模拟重开机：

```bash
reboot -w
```

