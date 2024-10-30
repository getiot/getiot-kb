---
sidebar_label: sudo 命令
sidebar_position: 36
slug: /sudo
---

# Linux sudo 命令 - 以超级用户执行



## 介绍

在 Linux 系统中，**sudo** 是一种权限管理机制，管理员可以授权于一些普通用户去执行一些 root 执行的操作，而不需要知道 root 的密码。

sudo 允许一个已授权用户以超级用户或者其它用户的角色运行一个命令。当然，能做什么不能做什么都是通过安全策略来指定的。sudo 支持插件架构的安全策略，并能把输入输出写入日志。第三方可以开发并发布自己的安全策略和输入输出日志插件，并让它们无缝的和 sudo 一起工作。默认的安全策略记录在 /etc/sudoers 文件中。而安全策略可能需要用户通过密码来验证他们自己。也就是在用户执行 sudo 命令时要求用户输入自己账号的密码。如果验证失败，sudo 命令将会退出。

**语法**：

```bash
sudo -h | -K | -k | -V
sudo -v [-AknS] [-g group] [-h host] [-p prompt] [-u user]
sudo -l [-AknS] [-g group] [-h host] [-p prompt] [-U user] [-u user] [command]
sudo [-AbEHknPS] [-r role] [-t type] [-C num] [-g group] [-h host] [-p prompt] [-T timeout] [-u user] [VAR=value] [-i|-s] [<command>]
sudo -e [-AknS] [-r role] [-t type] [-C num] [-g group] [-h host] [-p prompt] [-T timeout] [-u user] file ...
```

**选项**：

- `-A, --askpass`：使用助手程序进行密码提示。
- `-b, --background`：在后台运行命令。
- `-B, --bell`：出现提示时按响铃。
- `-C, --close-from=num`：关闭所有 >= num 的文件描述符。
- `-E, --preserve-env`：在执行命令时保留用户环境。
- `--preserve-env=list`：保留特定的环境变量。
- `-e, --edit`：编辑文件而非执行命令。
- `-g, --group=group`：以指定的用户组或 ID 执行命令。
- `-H, --set-home`：将 HOME 变量设为目标用户的主目录。
- `-h, --help`：显示帮助信息。
- `-h, --host=host`：在主机上运行命令（如果插件支持）。
- `-i, --login`：以目标用户身份运行一个登录 shell；可同时指定一条命令。
- `-K, --remove-timestamp`：完全移除时间戳文件。
- `-k, --reset-timestamp`：无效的时间戳文件。
- `-l, --list`：列出用户权限或检查某个特定命令；对于长格式，使用两次。
- `-n, --non-interactive`：非交互模式，不提示。
- `-P, --preserve-groups`：保留组向量，而非设置为目标的组向量。
- `-p, --prompt=prompt`：使用指定的密码提示。
- `-r, --role=role`：以指定的角色创建 SELinux 安全环境。
- `-S, --stdin`：从标准输入读取密码。
- `-s, --shell`：以目标用户运行 shell；可同时指定一条命令。
- `-t, --type=type`：以指定的类型创建 SELinux 安全环境。
- `-T, --command-timeout=timeout`：在超出指定时间后终止命令。
- `-U, --other-user=user`：在列表模式中显示用户的权限。
- `-u, --user=user`：以指定用户或 ID 运行命令（或编辑文件）。
- `-V, --version`：显示版本信息。
- `-v, --validate`：更新用户的时间戳而不执行命令。
- `--`：停止处理命令行参数。



## 示例

切换到 root 用户：

```bash
sudo su
```

指定用户执行命令：

```bash
sudo -u getiot ls -l
```

以 root 权限执行上一条命令：

```bash
sudo !!
```

列出目前的权限：

```bash
sudo -l
```

列出 sudo 的版本信息：

```bash
sudo -V
```

