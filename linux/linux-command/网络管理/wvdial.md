---
sidebar_position: 43
slug: /wvdial
---

# wvdial 命令



## 介绍

wvdial 是一个智能的 PPP 拨号工具，这意味着它会拨打调制解调器并启动 PPP 连接到互联网。wvdial 类似于 chat 程序，不同之处在于它使用启发式方法来猜测如何拨号和登录您的服务器，而不是强迫您编写登录脚本。这里 PPP 的作用是与拨入方协商传输数据的方法并维持该连接。

wvdial 命令由 wvdial 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install wvdial
```

当 wvdial 启动时，它首先从 /etc/wvdial.conf 和 ~/.wvdialrc 加载其配置，其中包含有关调制解调器端口、速度和初始化字符串等基本信息，以及有关 Internet 服务提供商 (ISP) 的信息，例如：电话号码、您的用户名和密码。然后它会初始化您的调制解调器并拨打服务器并等待连接（来自调制解调器的 CONNECT 字符串）。它理解并响应典型的连接问题（如忙和无拨号）。

连接后的任何时候，如果 wvdial 看到来自服务器的 PPP 序列，它就会启动 PPP。 否则，它会尝试通过执行以下操作来说服服务器启动 PPP：

- 响应它看到的任何登录名/密码提示；
- 解释“选择以下之一”风格的菜单；
- 最终，发送单词“ppp”（一个常见的终端服务器命令）。

如果这些尝试都失败了，wvdial 只会运行 pppd 命令，并希望一切顺利。它将启动连接，然后耐心等待您按 Ctrl + C 删除链接。

**语法**：

```bash
wvdial [ OPTIONS ] [ SECTION ] ...
```

**选项**：

- `-c`, `--chat` ：在 pppd 中运行 wvdial 作为聊天替换，而不是让 wvdial 协商连接然后调用 pppd 的更正常的方法。
- `-C`, `--config=CONFIGFILE` ：使用 `CONFIGFILE` 作为配置文件运行 wvdial，而不是 /etc/wvdial.conf。该选项主要用在当您希望为每个用户单独添加配置，或者想避免在系统范围的配置文件中包含拨号信息（用户名、密码、电话卡号码等）的时候。
- `-n`, `--no-syslog` ：不要将调试信息输出到 syslog 守护进程（仅与 --chat 一起使用时有效）。
- `--help` ：显示帮助信息。
- `--version` ：显示版本信息。

**参数**：

参数 `SECTION` 是配置文件（类似 windows 里的 ini 文件）中的某一段，一个 wvdial.conf 配置文件可以有好多个 section，每一个 section 由一些变量组成，可以使用 [wvdialconf](/linux-command/wvdialconf) 命令自动生成配置文件。

wvdial 通常在没有命令行选项的情况下运行，在这种情况下，它从 /etc/wvdial.conf 的 `[Dialer Defaults]` 部分读取其配置。关于配置文件的详细说明，可以通过 `man wvdial.conf` 命令获取。下面是一个 wvdial.conf 配置文件的示例：

```ini showLineNumbers
[Dialer Defaults]
Modem = /dev/ttyS2
Baud = 57600
Init = ATZ
Init2 = AT S11=50
Phone = 555-4242
Username = apenwarr
Password = my-password

[Dialer phone2]
Phone = 555-4243

[Dialer shh]
Init3 = ATM0

[Dialer pulse]
Dial Command = ATDP
```



## 示例

从 /etc/wvdial.conf 配置文件中读取 `[Dialer phone2]` 的选项参数进行拨号：

```bash
wvdial phone2
```

提示：该命令将首先读取 `[Dialer Defaults]` 部分的默认选项（如果有），然后再从 `[Dialer phone2]` 部分中找到的覆盖默认选项的所有选项。可以在命令行中指定 /etc/wvdial.conf 的一个或多个 SECTION。如果指定了多个部分，则将按照给定的顺序处理它们，每个部分将覆盖它之前的所有部分。

例如，下面命令将先从 `[Dialer Defaults]` 部分读取默认选项，然后使用在 `[Dialer phone2]` 部分中找到的选项覆盖任何或所有选项，然后是 `[Dialer pulse]` 部分，最后是 `[Dialer shh]` 部分。

```bash
wvdial phone2 pulse shh
```


使用这种方法，就可以轻松地配置 wvdial 以在不同的 Internet 提供商、调制解调器初始化字符串、帐户名称等之间切换，而无需一遍又一遍地指定相同的配置信息。

