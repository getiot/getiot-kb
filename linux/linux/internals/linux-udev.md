---
sidebar_position: 4
sidebar_label: udev 简介
slug: /linux-udev
authors: [luhuadong]
---

# Linux udev 简介



## udev 是什么

udev 是 Linux 2.6 内核里的引入的一个功能，它替代了原来的 devfs，成为当前 Linux 内核默认的设备管理工具。udev 以守护进程的形式运行（udevd），通过侦听内核发出来的用户空间事件（uevent）来管理 `/dev` 目录下的设备文件，主要目的是根据外设检测和热插拔进行操作，包括将控制权返回给内核的操作，例如加载内核模块或设备固件。

不同于之前的 Linux 内核设备管理工具，udev 运行在用户空间（user space），而不是内核空间（kernel space）。实际上，udev 就是“userspace /dev”的意思。

作为 devfsd 和 hotplug 的继承者，udev 还通过添加、符号链接和重命名来管理 `/dev` 目录中的设备节点。udev 取代了 hotplug 和 hwdetect 的功能。

udev 以并发（并行）的形式处理单独的事件，因此会对旧系统的潜在性能进行优化。同时，这也使得系统管理变得复杂，因为内核模块加载顺序不会在引导过程中保留下来。如果系统有多个块设备，可能会出现设备节点在重启后更改名称的现象。例如，当前机器有两个硬盘驱动器，“/dev/sda”可能会在下次启动时变成“/dev/sdb”。



## udev 工作原理

Udev 的机制是比较简单的，当 Linux 内核设备模型中任何设备有事件需要上报时，就会触发 uevent 提供的接口。Uevent 模块准备好上报事件的格式后，可以通过两个途径把事件上报到用户空间，一种是通过 kmod 模块，直接调用用户空间的可执行文件；另一种是通过 netlink 通信机制，将事件从内核空间传递给用户空间。

![udev 工作原理](https://static.getiot.tech/linux-udev-uevent.png#center)



## udev 如何管理设备

我们都知道，所有的设备在 Linux 里都是以设备文件的形式存在。在早期的 Linux 版本中，`/dev` 目录包含了所有可能出现的设备的设备文件。很难想象 Linux 用户如何在这些大量的设备文件中找到匹配条件的设备文件。

现在 udev 只为那些连接到 Linux 操作系统的设备产生设备文件。并且 udev 能通过定义一个 udev 规则（rule）来产生匹配设备属性的设备文件，这些设备属性可以是内核设备名称、总线路径、厂商名称、型号、序列号或者磁盘大小等等。

udev 采用动态管理方式，当添加或删除设备时，udev 的守护进程侦听来自内核的 uevent，以此添加或者删除 /dev 下的设备文件。因此，udev 只为已经连接的设备产生设备文件，而不会在 `/dev` 下产生大量虚无的设备文件。



## udev 规则文件

通过 Linux 默认的规则文件，udev 在 `/dev` 里为所有的设备定义了内核设备名称，比如 `/dev/sda`、`/dev/hda`、`/dev/fd` 等等。

由于 udev 运行在用户空间，因此 Linux 用户可以通过自定义的规则文件，灵活地产生标识性强的设备文件名，比如 `/dev/boot_disk`、`/dev/root_disk`、`/dev/color_printer` 等等。

同时，udev 还支持按一定的条件来设置设备文件的权限和设备文件所有者/组。在不同的 udev 版本中，实现的方法不同。


