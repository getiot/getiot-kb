---
sidebar_position: 5
draft: true
---

# Linux 高效检测 USB 插拔



In an [earlier post](http://www.mycpu.org/detect-usb-disconnect/), I had written about detecting a dead USB with a simple script. The summary of that was you have a shell script periodically polling the output of `lsusb` command to monitor a USB device of your interest.

Unfortunately, the script is not efficient and it is embarrassing to be monitoring constantly in this day and age. Thanks to Grant Vesely for bringing this question up.

There are several ways to do the same, but the most efficient way to do this has to be simply subscribing to a `udev` event or simply known as a `uevent` from the Kernel.

## What is `udev`?（什么是 udev）

`udev` provides a dynamic device directory containing only the files for actually present devices. It creates or removes device node files usually located in the /dev directory, or it renames network interfaces.

`udev` 提供了一个动态设备目录，只包含实际存在的设备的文件。 它创建或删除通常位于 /dev 目录中的设备节点文件，或者重命名网络接口。 

As part of the hotplug subsystem, `udev` is executed if a kernel device is added or removed from the system. On device creation, `udev` reads the sysfs directory of the given device to collect device attributes like label, serial number or bus device number. These attributes may be used as keys to determine a unique name for the device. `udev` maintains a database for devices present on the system. On device removal, `udev` queries its database for the name of the device file to be deleted. Refer to the man page for `udev`

作为热插拔子系统的一部分，如果在系统中添加或删除内核设备，则执行 `udev`。 在设备创建时，`udev` 读取给定设备的 sysfs 目录以收集设备属性，如标签、序列号或总线设备号。 这些属性可以用作键来确定设备的唯一名称。 `udev` 为系统上存在的设备维护一个数据库。 删除设备时，`udev` 会在其数据库中查询要删除的设备文件的名称。 请参阅 `udev` 的手册页 

## How do you `udev`?（如何使用 udev）

The udev daemon, systemd-udevd (or systemd-udevd.service) communicates with the kernel and receives device uevents directly from it each time you add or remove a device from the system, or a device changes its state.

udev 守护进程 systemd-udevd（或 systemd-udevd.service）与内核通信并在您每次从系统中添加或删除设备或设备更改其状态时直接从内核接收设备 uevent。 

Udev is based on rules, they are flexible and powerful. Every received device event is matched against the set of rules read from files located in `/lib/udev/rules.d` and `/run/udev/rules.d`.

Udev 基于规则，它们灵活而强大。 每个接收到的设备事件都与从位于 `/lib/udev/rules.d` 和 `/run/udev/rules.d` 的文件中读取的一组规则相匹配。

You can write custom rules files in the `/etc/udev/rules.d/` directory (files should end with the .rules extension) to process a device. Note that rules files in this directory have the highest priority.

您可以在`/etc/udev/rules.d/` 目录中编写自定义规则文件（文件应以.rules 扩展名结尾）来处理设备。 请注意，此目录中的规则文件具有最高优先级。 

### `udev` Monitor

We can monitor all the `udev` events in the Kernel from user space using the following command.

```
udevadm monitor
```

### How to Detect a Dead USB with `udev`?

#### Create `Actions` for Connection and Disconnection

For USB Connection, the action taken could simply be to log it

```
$ cat ~/usb_add_scream
#!/bin/bash

echo "USB inserted at $(date)" >> /tmp/usb_disc.log
```

On Disconnection event, the action taken could be to log the time of disconnection.

```
$ cat ~/usb_remove_scream
#!/bin/bash

echo "USB disconnected at $(date)" >> /tmp/usb_disc.log
```

#### Rules to Trigger Actions

`udev` allows you to create rules. These rules for my USB mouse look like this:

```
SUBSYSTEM=="usb", ACTION=="add", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="045e", RUN="/home/manoj/usb_add_scream"
SUBSYSTEM=="usb", ACTION=="remove", ENV{DEVTYPE}=="usb_device", RUN="/home/manoj/usb_remove_scream"
```

Setting up these rules automatically trigger the action when the rules are satisfied. In particular, the rule checks for `usb` subsystem’s action for `add` or `remove` of a USB device type. If this rule is satisfied then it `RUN`s the script for action (needs to have execute permissions)

```
╰─ lsusb| grep 045e
Bus 001 Device 036: ID 045e:07fd Microsoft Corp. Nano Transceiver 1.1
╰─ cat /tmp/usb_disc.log 
╰─ 
```

Then I disconnect the mouse connected over a USB hub.

```
╰─ lsusb| grep 045e
╰─ cat /tmp/usb_disc.log 
USB disconnected at Fri Jan 24 23:33:19 PST 2020
USB disconnected at Fri Jan 24 23:33:19 PST 2020
╰─ 
╰─ 
╰─ lsusb| grep 045e     
Bus 001 Device 037: ID 045e:07fd Microsoft Corp. Nano Transceiver 1.1
╰─ cat /tmp/usb_disc.log
USB disconnected at Fri Jan 24 23:33:19 PST 2020
USB disconnected at Fri Jan 24 23:33:19 PST 2020
USB inserted at Fri Jan 24 23:33:42 PST 2020
USB inserted at Fri Jan 24 23:33:42 PST 2020
╰─ 
```

## Advantages

This method does not require any CPU for constantly monitoring, neither does it take any other resource than to handle an in-memory notification from the kernel to the user space. This is the basis for `sysfs` entries to show relevant device information.



