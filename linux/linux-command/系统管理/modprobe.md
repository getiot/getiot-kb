---
sidebar_label: modprobe 命令
sidebar_position: 28
slug: /modprobe
---

# Linux modprobe 命令 - 自动加载模块



## 介绍

**modprobe**（英文全拼：modules probe）命令用于智能地向内核中加载模块或者从内核中移除模块。

modprobe 可载入指定的个别模块，或是载入一组相依的模块。modprobe 会根据 [depmod](/linux-command/depmod) 所产生的相依关系，决定要载入哪些模块。若在载入过程中发生错误，则 modprobe 会卸载整组的模块。需要注意的是为了方便，模块名中的 `-` 和 `_` 是没有区别的。

modprobe 命令会查找 `/lib/modules/'uname -r'` 目录中的模块和文件 (`uname -r` 是内核版本），但是不会查找 `/etc/modprobe.conf` 和 `/etc/modprobe.d/` 目录下配置所排除的内容。

modprobe 命令不会修改模块内容，解析模块内容和使用模块参数是在内核中进行的，所以如果模块装载失败，内核会将失败的日志通过 dmesg 打印出来。

**语法**：

```bash
modprobe [options] modulename
modprobe [options] -a modulename [modulename...]
```

**选项**：

- `-a`, `--all` ：载入全部的模块。
- `-c`, `--show-conf` ：显示所有模块的设置信息。
- `-d`, `--debug` ：使用排错模式。
- `-l`, `--list` ：显示可用的模块。
- `-r`, `--remove` ：模块闲置不用时，即自动卸载模块。
- `-t`, `--type` ：指定模块类型。
- `-v`, `--verbose` ：执行时显示详细的信息。
- `-V`, `--version` ：显示版本信息。
- `-h` ：显示帮助。

**参数**：模块名（使用 `-a` 选项可以接多个模块名）



## 示例

查看 modules 的配置文件：

```bash
modprobe -c
```

这里，可以查看 modules 的配置文件，比如模块的 alias 别名是什么等，会打印许多行信息。

加载 spidev 模块：

```bash
sudo modprobe spidev
```

卸载 spidev 模块：

```bash
sudo modprobe -r spidev
```

