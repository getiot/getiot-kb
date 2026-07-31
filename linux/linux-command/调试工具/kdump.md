---
sidebar_label: kdump 命令
sidebar_position: 10
slug: /kdump
description: "kdump 是 Linux 内核的崩溃转储（crash dump）机制。当内核发生 panic 时，kdump 通过 kexec 启动一个预留的捕获内核（capture kernel），将当前内存状态保存为 vmcore 文件，供事后使用…"
---

# Linux kdump - 内核崩溃转储机制



## 介绍

**kdump** 是 Linux 内核的崩溃转储（crash dump）机制。当内核发生 panic 时，kdump 通过 kexec 启动一个预留的捕获内核（capture kernel），将当前内存状态保存为 vmcore 文件，供事后使用 [crash](/linux-command/crash/) 工具分析崩溃原因。

kdump 不是单一命令，而是一套由内核、kexec 工具和系统服务组成的机制。在 Debian/Ubuntu 上通常通过 `kdump-tools` 软件包管理。

```bash
sudo apt install kdump-tools crash
```

**工作原理**：

1. 正常运行时，主内核通过 kexec 预留一块内存给捕获内核
2. 主内核崩溃（panic）时，kexec 自动启动捕获内核
3. 捕获内核将内存转储为 `/var/crash/` 下的 vmcore 文件
4. 系统重启后，使用 `crash` 分析 vmcore

**主要配置文件**：

- `/etc/default/kdump-tools`：kdump 服务配置（转储路径、内核参数等）
- `/etc/default/grub`：GRUB 中需为捕获内核预留内存（如 `crashkernel=256M`）

**常用管理命令**：

```bash
# 查看 kdump 服务状态
sudo systemctl status kdump-tools

# 启动 / 停止 kdump 服务
sudo systemctl start kdump-tools
sudo systemctl stop kdump-tools

# 查看已保存的崩溃转储
ls /var/crash/

# 测试 kdump 是否配置正确（会触发内核 panic，慎用！）
sudo echo c > /proc/sysrq-trigger
```

相关命令：[crash](/linux-command/crash/)、[perf](/linux-command/perf/)、[strace](/linux-command/strace/)



## 示例

1、安装并启用 kdump：

```bash
sudo apt install kdump-tools crash
sudo systemctl enable kdump-tools
sudo systemctl start kdump-tools
```

2、检查 kdump 是否已正确预留内存：

```bash
cat /proc/cmdline | grep crashkernel
sudo kdump-config show
```

3、查看捕获内核配置：

```bash
sudo kdump-config status
```

4、列出已保存的崩溃转储：

```bash
ls -la /var/crash/
```

5、分析最新的 vmcore 文件：

```bash
sudo crash \
  /usr/lib/debug/boot/vmlinux-$(uname -r) \
  /var/crash/$(ls -t /var/crash/ | head -1)/vmcore
```

6、配置转储保存路径（编辑 `/etc/default/kdump-tools`）：

```bash
# 示例：指定转储目录
KDUMP_COREDIR="/var/crash"
```

7、在 GRUB 中添加 crashkernel 参数后更新引导：

```bash
# 编辑 /etc/default/grub，在 GRUB_CMDLINE_LINUX 中添加：
# crashkernel=256M

sudo update-grub
sudo reboot
```
