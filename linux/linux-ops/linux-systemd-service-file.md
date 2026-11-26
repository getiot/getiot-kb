---
sidebar_position: 7
---

# Linux systemd 服务脚本

![Linux systemd 服务脚本](https://static.getiot.tech/linux-systemd-1.webp#center)

**Systemd** 是一个系统和服务管理器，也是 Linux 操作系统中最常用的初始化系统之一。它的设计目标是提供更快、更有效、更可靠的系统启动过程，并提供强大的管理和监控服务的能力。本文首先介绍 systemd 服务脚本的基本情况，并通过一个简单的示例带领读者学习如何编写 systemd 服务脚本，实现 Linux 服务的自启动、启动、停止和重启管理。



## Systemd 是什么

Systemd 是 Linux 系统中一个重要的系统和服务管理器，最早是为了代替传统的 SysV 初始化系统（init）而开发的，相较于传统 init，systemd 具有许多优势。例如支持并行启动，可同时启动多个服务，提高系统启动速度；引入了单一进程（PID 1）和 cgroups 技术，可以更好地管理系统和服务进程。目前，许多主流 Linux 发行版都采用了 systemd 作为其默认的初始化系统，包括 Ubuntu、Debian、Fedora、CentOS、Arch Linux 等。

总的来说，使用 systemd 可以更加简单灵活地管理各种系统服务，它提供了统一的命令行工具和配置文件格式，使得对系统和服务的管理更加一致和简化。用户可以通过 [systemctl](/linux-command/systemctl/) 命令来控制 systemd 系统和管理服务。



## service 脚本

Linux 的 service 脚本一般存放在 `/etc/systemd/` 和 `/usr/lib/systemd` 路径下，前者包含着多个 *.target.wants 文件，如 multi-user.target.wants 等；而后者为安装软件生成 service 的目录，一般编写自己的 service 可以放在此目录下。但需要注意的是，位于 /usr/lib/systemd/ 中服务脚本可能会在下次更新时被覆盖。

无论是 `/etc/systemd/` 还是 `/usr/lib/systemd`  目录，其中又包含 system 和 user 目录。前者是系统服务，开机不需要用户登录即可运行的服务；后者是用户服务，需要用户登录后才能运行的服务。

- **/etc/systemd/system/**
- **/etc/systemd/user/**
- **/usr/lib/systemd/system/**
- **/usr/lib/system/user/**

服务脚本文件以 .service 结尾，由 Unit、Service 和 Install 三个区块组成，以下是一个 service 脚本样例：

```ini showLineNumbers
[Unit]   
Description=test   		# 简单描述服务
After=network.target    # 描述服务类别，表示本服务需要在network服务启动后在启动
Before=xxx.service      # 表示需要在某些服务启动之前启动，After和Before字段只涉及启动顺序，不涉及依赖关系

[Service] 
Type=forking     		# 设置服务的启动方式
User=USER        		# 设置服务运行的用户
Group=USER       		# 设置服务运行的用户组
WorkingDirectory=/PATH	# 设置服务运行的路径(cwd)
KillMode=control-group  # 定义systemd如何停止服务
Restart=no        		# 定义服务进程退出后，systemd的重启方式，默认是不重启
ExecStart=/start.sh    	# 服务启动命令，命令需要绝对路径（采用sh脚本启动其他进程时Type须为forking）
   
[Install]   
WantedBy=multi-user.target  # 多用户
```



## 参数说明

service 脚本的参数分为三个区块，各区块作用如下：

| 区块             | 描述               |
| ---------------- | ------------------ |
| `[Unit]` 区块    | 启动顺序与依赖关系 |
| `[Service]` 区块 | 启动行为定义       |
| `[Install]` 区块 | 服务安装定义       |



### Unit 区块

#### **服务描述**

- Description：给出当前服务的简单描述。
- Documentation：给出文档位置。

#### **启动顺序**

- After：定义 xxx.service 应该在哪些 target 或 service 服务之后启动，例如网络服务 network.target。
- Before：定义 xxx.service 应该在哪些 target 或 service 服务之前启动。

#### **依赖关系**

- Wants：表示 xxx.service 与定义的服务存在“弱依赖”关系，即指定的服务启动失败或停止运行不影响 xxx 的运行。
- Requires：则表示“强依赖”关系，即指定服务启动失败或异常退出，那么 xxx 也必须退出；反之 xxx 启动则指定服务也会启动。

### Service 区块

#### **启动命令**

- EnvironmentFile：指定当前服务的环境参数文件（路径），如 `EnviromentFile=-/etc/sysconfig/xxx`，连词号表示抑制错误，即发生错误时，不影响其他命令的执行。
- Environment：后面接多个不同的 shell 变量，如 `Environment=DATA_DIR=/dir/data`。
- User：设置服务运行的用户。
- Group：设置服务运行的用户组。
- WorkingDirectory：设置服务运行的路径。
- Exec*：各种与执行相关的命令。
  - ExecStart：定义启动服务时执行的命令。
  - ExecStop：定义停止服务时执行的命令。
  - ExecStartPre：定义启动服务前执行的命令。
  - ExecStartPost：定义启动服务后执行的命令。
  - ExecStopPost：定义停止服务后执行的命令。
  - ExecReload：定义重启服务时执行的命令。

#### **启动类型**

- Type：字段定义启动类型，可以设置的值如下：
  - simple（默认值）：`ExecStart` 字段启动的进程为主进程，即直接启动服务进程。
  - forking：`ExecStart` 字段将以 `fork()` 方式启动，此时父进程将会退出，子进程将成为主进程（例如用 shell 脚本启动服务进程）。
  - oneshot：类似于 `simple`，但只**执行一次**，systemd 会等它执行完，才启动其他服务。
  - dbus：类似于 `simple`，但会等待 D-Bus 信号后启动。
  - notify：类似于 `simple`，启动结束后会发出通知信号，然后 systemd 再启动其他服务。
  - idle：类似于 `simple`，但是要等到其他任务都执行完，才会启动该服务。一种使用场合是为让该服务的输出，不与其他服务的输出相混合。
- RemainAfterExit：设为 `yes`，表示进程退出以后，服务仍然保持执行。

#### **重启行为**

- KillMode：定义 systemd 如何停止服务，可以设置的值如下：
  - control-group（default）：当前控制组里面的所有子进程，都会被杀掉。
  - process：只杀主进程。
  - mixed：主进程将收到 SIGTERM 信号，子进程收到 SIGKILL 信号。
  - none：没有进程会被杀掉，只是执行服务的 stop 命令。
- Restart：定义了服务退出后，Systemd 的重启方式，可以设置的值如下（对于守护进程，推荐设为 `on-failure`，对于那些允许发生错误退出的服务，可以设为 `on-abnormal`）：
  - no（default）：退出后不会重启。
  - on-success：只有正常退出时（退出状态码为0），才会重启。
  - on-failure：非正常退出时（退出状态码非0），包括被信号终止和超时，才会重启。
  - on-abnormal：只有被信号终止和超时，才会重启。
  - on-abort：只有在收到没有捕捉到的信号终止时，才会重启。
  - on-watchdog：超时退出，才会重启。
  - always：不管是什么退出原因，总是重启。
- RestartSec：表示 systemd 重启服务之前，需要等待的秒数。

### Install 区块

WantedBy：表示该服务所在的 Target。

Target 的含义是服务组，如 `WantedBy=multi-user.target` 指的是该服务所属于 `multi-user.target`。当执行 `systemctl enable xxx.service` 命令时，`xxx.service` 的符号链接就会被创建在 `/etc/systemd/system/multi-user.target` 目录下。

可以通过 `systemctl get-default` 命令查看系统默认启动的 target，一般为 `multi-user` 或者是 `graphical`。因此配置好相应的 WantedBy 字段，可以实现服务的开机启动。



## 简单示例

示例代码：[systemd-example](https://github.com/getiot/linux-c/tree/main/service/systemd-example)

### 准备工作

下面通过一个简单的示例演示如何编写 systemd 服务脚本。为了更加简单，我们编写一个 example.sh 脚本作为服务程序，该脚本的功能是往 /tmp 目录写一个带时间信息的文件，用于验证服务是否被执行。

example.sh 脚本内容如下：

```bash
#!/bin/bash
echo "The script works. `date`" > /tmp/diditwork.txt
```

接着，给 example.sh 脚本添加可执行权限，并拷贝到 /usr/sbin/ 系统目录。

```bash
$ chmod +x example.sh
$ sudo cp example.sh /usr/sbin/
```

尝试执行 `example.sh`，通过 `cat /tmp/diditwork.txt` 命令查看是否写入成功。

```bash
The script works. 2023年 08月 20日 星期日 15:08:23 CST
```



### 编写服务脚本

在 /etc/systemd/system 目录中创建一个 example.service 服务单元文件，内容如下：

```ini showLineNumbers
[Unit]
Description=example systemd service unit file.

[Service]
ExecStart=/bin/bash /usr/sbin/example.sh

[Install]
WantedBy=multi-user.target
```

这样，一个最简单的 systemd 服务脚本就写好了！这里的关键是在 ExecStart 参数中填入 example.sh 脚本的路径。



### 使脚本生效

完成服务脚本编写后，需要执行以下命令重新加载所有的 systemd 服务，否则会找不到 example.service 服务。

```bash
sudo systemctl daemon-reload
```

接着就可以通过 [systemctl](/linux-command/systemctl/) 命令来控制服务启停，控制命令语法如下：

```bash
# 管理服务 [使能自启动|启动|停止|重启|查看状态]
sudo systemctl [enable|start|stop|restart|status] xxx.service
```

现在，执行下面命令启动 example.service 服务。

```bash
sudo systemctl start example.service
```

通过 tmp/diditwork.txt 文件检查 example.service 服务是否成功启动。

```bash
$ cat /tmp/diditwork.txt
The script works. 2023年 08月 20日 星期日 15:45:37 CST
```

如果你想要在每次重启系统后都自动启动 example.service 服务，则需要执行下面命令：

```bash
sudo systemctl enable example.service
```



## 更多

想要获得 systemd 服务的完整文档说明，可访问 [systemd service documentation](https://www.freedesktop.org/software/systemd/man/systemd.service.html)。



