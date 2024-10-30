---
sidebar_label: smartctl 命令
sidebar_position: 6
slug: /smartctl
---

# smartctl 命令 - 管理 SMART 磁盘



## 介绍

**smartctl** 是用于 SMART 磁盘的控制和监视的一个实用程序。SMART 是 Self-Monitoring, Analysis and Reporting Technology 的缩写，即“自监控、分析和报告技术”，该技术内置于大多数 ATA/SATA 和 SCSI/SAS 硬盘驱动器和固态驱动器中。

SMART 的目的是监控硬盘的可靠性和预测硬盘故障，并进行不同类型的硬盘自检。smartctl 还支持一些与 SMART 无关的功能，在 Linux 物理服务器中非常有用。

smartctl 命令由 smartmontools 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install smartmontools
```

**语法：**

```bash
smartctl [options] device
```

**选项：**

- `-h`, `--help`, `--usage`：显示帮助信息并退出。
- `-V`, `--version`, `--copyright`, `--license`：打印许可证、版权和版本信息并退出。
- `-i`, `--info`：显示设备的身份信息。
- `--identify[=[w][nvb]]`：显示来自 IDENTIFY DEVICE 数据的字（words）和位（bits）。
- `-g NAME`, `--get=NAME`：获取设备设置。
- `-a`, `--all`：显示设备的所有 SMART 信息。
- `-x`, `--xall`：显示设备的所有信息。
- `--scan`：扫描设备。
- `--scan-open`：扫描设备并尝试打开每个设备。
- `-j`, `--json[=[cgiosuv]]`：以 JSON 格式打印输出。
- `-q TYPE`, `--quietmode=TYPE`：设置安静模式。
- `-d TYPE`, `--device=TYPE`：指定设备类型。
- `-T TYPE`, `--tolerance=TYPE`：设置宽容模式。
- `-b TYPE`, `--badsum=TYPE`：设置错误校验和的操作。
- `-r TYPE`, `--report=TYPE`：报告交易。
- `-n MODE[,STATUS]`, `--nocheck=MODE[,STATUS]`：如果是 never, sleep, standby, idle 模式则不检查。
- `-s VALUE`, `--smart=VALUE`：在设备上启用或禁用 SMART (on/off)。
- `-o VALUE`, `--offlineauto=VALUE`：在设备上启用或禁用自动离线测试 (on/off)。
- `-S VALUE`, `--saveauto=VALUE`：在设备上启用或禁用属性自动保存 (on/off)。
- `-s NAME[,VALUE]`, `--set=NAME[,VALUE]`：启用或禁用设备设置 (on/off)。
- `-H`, `--health`：显示设备 SMART 健康状态。
- `-c`, `--capabilities`：显示设备 SMART 功能。
- `-A`, `--attributes`：显示设备 SMART 供应商特定的属性和值。
- `-f FORMAT`, `--format=FORMAT`：设置属性的输出格式。
- `-l TYPE`, `--log=TYPE`：显示设备日志。
- `-v N,OPTION`, `--vendorattribute=N,OPTION`：设置供应商属性 N 的显示选项。
- `-F TYPE`, `--firmwarebug=TYPE`：使用固件错误解决方法。
- `-P TYPE`, `--presets=TYPE`：驱动器特定的预设。
- `-B [+]FILE`, `--drivedb=[+]FILE`：从 FILE 读取并替换（add）驱动器数据库（默认是 +/etc/smart_drivedb.h，然后是 /var/lib/smartmontools/drivedb/drivedb.h）。
- `-t TEST`, `--test=TEST`：运行测试。
- `-C`, `--captive`：在捕获模式下进行测试（需要同时使用 -t 选项）。
- `-X`, `--abort`：中止设备上的任何非强制测试。



## 示例

打印 /dev/sda 设备的所有 SMART 信息

```bash
smartctl --all /dev/sda
```

在第一个磁盘上（/dev/sda）启用 SMART

```bash
smartctl --smart=on --offlineauto=on --saveauto=on /dev/sda
```

执行扩展磁盘自检

```bash
smartctl --test=long /dev/sda
```

打印自检和属性错误

```bash
smartctl --attributes --log=selftest --quietmode=errorsonly /dev/sda
```

打印 3ware RAID 控制器上第三个 ATA 磁盘的所有 SMART 信息

```bash
smartctl --all --device=3ware,2 /dev/sda
smartctl --all --device=3ware,2 /dev/twe0
smartctl --all --device=3ware,2 /dev/twa0
smartctl --all --device=3ware,2 /dev/twl0
```

打印连接到第 1 个 HighPoint RAID 控制器第 1 个通道的第 3 个 PMPort 的 SATA 磁盘的所有 SMART 信息

```bash
smartctl --all --device=hpt,1/1/3 /dev/sda
```

打印 Areca RAID 控制器上第一个机箱的第三个 ATA 磁盘的所有 SMART 信息

```bash
smartctl --all --device=areca,3/1 /dev/sg2
```



