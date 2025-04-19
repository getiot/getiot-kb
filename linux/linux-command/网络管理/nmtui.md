---
sidebar_label: nmtui 命令
sidebar_position: 41
slug: /nmtui
---

# Linux nmtui 命令 - 文本界面网络设置



## 介绍

**nmtui** 是 NetworkManager 网络管理客户端附带的一个命令行工具。它是一个基于 Curses 的 TUI（Text User Interface）应用程序，用于与 NetworkManager 交互。启动 nmtui 时，系统会提示用户选择要执行的活动，除非将其指定为第一个参数。

**语法**：

```bash
nmtui [OPTIONS]
```

**选项**：

- `-h, --help`：显示帮助信息。

nmtui 支持以下三种活动：

- `edit`：显示连接编辑器，支持添加、修改、查看和删除连接。它提供与 [`nm-connection-editor`](/linux-command/nm-connection-editor/) 类似的功能。
- `connect`：显示可用连接的列表，以及激活或停用它们的选项。它提供与 `nm-applet` 类似的功能。
- `hostname`：设置系统主机名。

与上述活动相对应，`nmtui` 还附带了名为 `nmtui-edit`、`nmtui-connect` 和 `nmtui-hostname` 的二进制文件，用于跳过活动的选择。

```bash
nmtui-edit     等效于  nmtui edit  {name | id}
nmtui-connect  等效于  nmtui connect  {name | uuid | device | SSID}
nmtui-hostname 等效于  nmtui hostname
```



## 示例

通过命令行启动 nmtui 程序：

```bash
$ nmtui
```

可以看到如下字符窗口，你可以根据提示通过键盘操作。

![](https://static.getiot.tech/nmtui-screenshot.png#center)

