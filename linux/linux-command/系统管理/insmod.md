---
sidebar_position: 24
slug: /insmod
---

# insmod 命令



## 介绍

**insmod**（英文全拼：install module）命令用于将模块载入 Linux 内核。

Linux 是一个允许用户在运行时加载内核模块以扩展内核功能的操作系统，LKM（Loadable Kernel Modules，可加载内核模块）通常用于添加对新硬件（作为设备驱动程序）和文件系统的支持，或用于增加系统调用。insmod 命令将带有/不带参数的内核目标文件（.ko）载入内核。

**语法**：

```shell
insmod [filename] [module options...]
```

**选项**：

- `-V`, `--version` ：显示版本信息。
- `-h`, `--help` ：显示帮助信息。

**参数**：模块文件名（可带参数）



## 示例

将当前目录下的 getiot.ko 模块载入内核：

```shell
sudo insmod getiot.ko
```

执行 insmod 命令需要 root 权限，因此需要添加 sudo，可通过 dmesg 命令查看内核模块的打印信息。

指定模块载入内核：

```shell
sudo insmod /home/rudy/getiot.ko
```

 加载内核模块时传入参数：

```shell
sudo insmod getiot.ko user="Rudy"
```

上述命令后面带的参数将传递给运行的内核模块，至于接收和使用什么参数则取决于该模块是怎么写的。



