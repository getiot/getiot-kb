---
sidebar_position: 2
sidebar_label: 常用环境变量速查
slug: /environment-reference
---

# U-Boot 常用环境变量速查

不同平台的 environment 差异很大。本页列出教程中常见变量，帮助你读懂启动脚本。

| 变量 | 说明 |
| --- | --- |
| `bootcmd` | 自动启动时执行的命令 |
| `bootdelay` | 自动启动等待时间 |
| `bootargs` | 传给 Linux kernel 的命令行参数 |
| `kernel_addr_r` | kernel 加载地址 |
| `fdt_addr_r` | DTB 加载地址 |
| `ramdisk_addr_r` | initramfs/initrd 加载地址 |
| `scriptaddr` | boot script 加载地址 |
| `pxefile_addr_r` | PXE/extlinux 配置加载地址 |
| `serverip` | TFTP/NFS server IP |
| `ipaddr` | U-Boot 本机 IP |
| `ethaddr` | 网卡 MAC 地址 |
| `stdin`、`stdout`、`stderr` | console 输入输出设备 |
| `filesize` | 最近一次加载文件的大小 |
| `fileaddr` | 最近一次加载文件的地址，取决于命令支持 |
| `boot_targets` | Standard Boot 常用启动目标顺序 |
| `bootmeths` | Standard Boot 启动方法顺序或子集 |
| `bootfile` | 网络启动默认文件名 |
| `gatewayip` | 网关 IP，网络启动时可能使用 |
| `netmask` | 子网掩码 |
| `autoload` | DHCP 后是否自动加载文件，配置相关 |
| `bootcount` | 启动计数，具体后端取决于配置 |
| `bootlimit` | 启动失败限制，配合 bootcount |
| `altbootcmd` | bootlimit 超限后执行的备用启动命令 |

常见查看方式：

```bash
# [U-Boot]
printenv bootcmd bootargs kernel_addr_r fdt_addr_r ramdisk_addr_r
```

临时设置：

```bash
# [U-Boot]
setenv bootargs "console=ttyAMA0 root=/dev/vda2 rw rootwait"
```

删除变量：

```bash
# [U-Boot]
setenv my_temp_var
```

:::note
环境变量是启动流程的“配置层”。如果手动命令能启动，而自动启动失败，优先检查 `bootcmd` 和相关脚本变量。
:::

## 脚本变量示例

```bash
# [U-Boot]
setenv load_kernel 'load mmc 0:1 ${kernel_addr_r} /boot/Image'
setenv load_fdt 'load mmc 0:1 ${fdt_addr_r} /boot/<board>.dtb'
setenv boot_linux 'booti ${kernel_addr_r} - ${fdt_addr_r}'
setenv bootcmd 'run load_kernel load_fdt boot_linux'
```

需要运行时展开的变量，通常用单引号定义。

## 保存前检查

执行 `saveenv` 前至少确认：

- environment 存储位置正确。
- 当前变量不是临时调试值。
- 有恢复默认环境的方法。
- 有设备恢复方案。
