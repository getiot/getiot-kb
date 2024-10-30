---
sidebar_label: wvdialconf 命令
sidebar_position: 44
slug: /wvdialconf
---

# Linux wvdialconf 命令 - 配置调制解调器



## 介绍

**wvdialconf** 命令用于为 [wvdial](/linux-command/wvdial) 生成一个配置文件，默认为 /etc/wvdial.conf。通常在首次安装 wvdial 工具，还没有配置文件时使用。

wvdialconf 会检测 Linux 系统当前接入的调制解调器，获取最大波特率和初始化字符串信息，并根据这些信息生成或更新 wvdial 配置文件。

注意：wvdialconf 是完全非交互式的。意味着您仍然需要编辑 /etc/wvdial.conf 以指定 Internet 帐户的电话号码、登录名和密码，才能让 wvdial 正常工作。



## 示例

插入 modem，执行下面命令生成 wvdial 配置文件

```bash
sudo wvdialconf
```

或者指定文件名

```bash
sudo wvdialconf /etc/wvdial.conf
```

执行完成后，会生成 `/etc/wvdial.conf` 文件，内容如下：

```ini showLineNumbers
[Dialer Defaults]
Init2 = ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0
Modem Type = Analog Modem
; Phone = <Target Phone Number>
ISDN = 0
; Username = <Your Login Name>
Init1 = ATZ
; Password = <Your Password>
Modem = /dev/ttyUSB2
Baud = 9600
```

