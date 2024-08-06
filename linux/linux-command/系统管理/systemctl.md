---
sidebar_position: 49
slug: /systemctl
---

# systemctl 命令



## 介绍

**systemctl**（英文全拼：system control）用于控制 systemd 系统和管理服务。

systemd 是目前 Linux 系统上主要的系统守护进程管理工具，由于 init 一方面对于进程的管理是串行化的，容易出现阻塞情况，另一方面 init 也仅仅是执行启动脚本，并不能对服务本身进行更多的管理。所以许多 Linux 发行版都由 systemd 取代了 init 作为默认的系统进程管理工具。

systemd 所管理的所有系统资源都称作 Unit，通过 systemd 命令集可以方便的对这些 Unit 进行管理。比如 systemctl、hostnamectl、timedatectl、localctl 等命令，这些命令虽然改写了 init 时代用户的命令使用习惯（不再使用 chkconfig、service 等命令），但确实也提供了很大的便捷性。

**语法**：

```bash
systemctl [OPTIONS...] COMMAND [UNIT...]
```

**选项**：

command 选项字如下：

- `start`：启动指定的 unit。
- `stop`：关闭指定的 unit。
- `restart`：重启指定 unit。
- `reload`：重载指定 unit。
- `enable`：系统开机时自动启动指定 unit，前提是配置文件中有相关配置。
- `disable`：开机时不自动运行指定 unit。
- `status`：查看指定 unit 当前运行状态。

**参数**：unit 是要配置的服务名称。



## 示例

重新加载 systemd unit 配置文件

```bash
systemctl --system daemon-reload
```

查看一个 service 的状态

```bash
systemctl status xxx.service
```

启动和停止这个 service（本次启动有效）

```bash
systemctl start xxx.service
systemctl stop xxx.service
```

使能或关闭一个 service（下次启动有效）

```bash
systemctl enable xxx.service
systemctl disable xxx.service
```

上述 xxx.service 的后缀都是可以省略的，例如 nginx.service 可以直接写 nginx。

