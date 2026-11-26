---
sidebar_position: 3
sidebar_label: Dev 文件系统
slug: /linux-dev-filesystem
authors: [luhuadong]
---

# Linux Dev 文件系统

`/dev` 是 Linux 中存放设备节点的目录。硬盘、终端、串口、随机数发生器、空设备等，都可能在 `/dev` 中以“文件”的形式出现。

在 Linux 中，“一切皆文件”不是说所有东西真的都是普通文件，而是很多资源都可以通过类似文件的接口访问。设备节点就是这种思想的重要体现。

## 查看 /dev

```bash
ls /dev | head
```

你会看到很多设备名，例如：

```text
null
zero
random
tty
sda
```

不同系统输出会不同，虚拟机、服务器、开发板上的设备差异很大。

## 字符设备和块设备

查看详细信息：

```bash
ls -l /dev/null /dev/sda 2>/dev/null
```

可能看到：

```text
crw-rw-rw- 1 root root 1, 3 Jul 24 10:00 /dev/null
brw-rw---- 1 root disk 8, 0 Jul 24 10:00 /dev/sda
```

第一列开头：

- `c` 表示字符设备。
- `b` 表示块设备。

字符设备按字节流读写，例如串口、终端、`/dev/null`。块设备按块读写，例如磁盘和分区。

中间的 `1, 3`、`8, 0` 是主设备号和次设备号，用于内核识别设备类型和具体设备。

## 常见特殊设备

| 设备 | 作用 |
| --- | --- |
| `/dev/null` | 空设备，写入内容会被丢弃，读取立即结束 |
| `/dev/zero` | 读取时持续返回零字节 |
| `/dev/random` | 随机数设备，可能阻塞 |
| `/dev/urandom` | 非阻塞随机数设备，常用于一般随机需求 |
| `/dev/tty` | 当前控制终端 |
| `/dev/pts/` | 伪终端设备，SSH 和终端窗口常用 |

例如丢弃错误输出：

```bash
find /etc -name "*.conf" 2>/dev/null
```

这里的 `/dev/null` 就像一个“黑洞”，任何写进去的内容都会被丢弃。

## 磁盘设备

常见磁盘设备名：

- `/dev/sda`、`/dev/sdb`：SCSI/SATA/USB 磁盘常见命名。
- `/dev/vda`：虚拟化环境常见 VirtIO 磁盘。
- `/dev/nvme0n1`：NVMe SSD。
- `/dev/mmcblk0`：SD 卡、eMMC。

分区通常是在设备名后加编号：

- `/dev/sda1`
- `/dev/nvme0n1p1`
- `/dev/mmcblk0p1`

查看块设备更推荐：

```bash
lsblk
```

不要只凭 `/dev/sdb` 这类名字判断设备，因为插拔顺序可能改变。

## 终端设备

查看当前终端：

```bash
tty
```

输出可能是：

```text
/dev/pts/0
```

这表示当前 Shell 连接到一个伪终端。SSH 登录、图形终端窗口通常都会使用 `/dev/pts/` 下的设备。

## /dev 和 udev

早期系统中的 `/dev` 可能包含大量静态设备节点。现代 Linux 通常由 udev 动态管理设备节点。

当内核发现设备变化时，会发出事件。udev 根据规则：

- 创建设备节点。
- 设置权限和所属组。
- 创建符号链接。
- 执行必要动作。

所以你插入 U 盘后看到新的 `/dev/sdb1`，背后就可能有 udev 参与。

## 权限问题

设备节点也有权限。比如串口设备可能属于 `dialout` 组：

```bash
ls -l /dev/ttyUSB0
```

如果普通用户没有权限访问串口，可能需要加入对应用户组。具体组名和规则取决于发行版和设备类型。

不要随意把设备节点改成全局可写。更好的做法是通过用户组或 udev 规则管理权限。

## 小结

你需要记住：

- `/dev` 存放设备节点。
- `c` 是字符设备，`b` 是块设备。
- `/dev/null`、`/dev/zero`、`/dev/random`、`/dev/tty` 是常见特殊设备。
- 磁盘设备名可能变化，查看磁盘优先用 `lsblk`。
- 现代 Linux 通常由 udev 动态管理 `/dev`。

理解 `/dev` 后，你会更容易读懂磁盘、串口、USB、嵌入式设备相关教程。
