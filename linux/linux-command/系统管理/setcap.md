---
sidebar_label: setcap 命令
sidebar_position: 55
slug: /setcap
---

# Linux setcap 命令 - 设置文件特殊权限



## 介绍

**setcap**（英文全拼：set capabilities）是在 Linux 系统中用于设置特殊权限的命令工具。它允许普通用户在执行特定程序时获得一些超过其正常权限的能力。具体来说，`setcap` 命令允许用户向可执行文件或动态链接库（共享对象）设置特殊的能力。这些能力使得程序能够执行某些通常需要超级用户权限才能完成的操作，例如绑定低于 1024 端口、访问摄像头、修改网络设置等。

通过使用 `setcap` 命令，用户不需要将整个程序以 root 身份运行，而只需为其设置所需的能力即可。这提供了更加灵活和安全的权限控制方式，同时避免了用户以超级用户身份运行程序带来的潜在风险。需要注意的是，`setcap` 命令需要以超级用户（root）身份执行，因为设置特殊能力是一个需要特权的操作。使用时应当慎重，确保仅将特定的能力赋予可信任的程序。

相关命令：[getcap](/linux-command/getcap/)

**语法**：

```bash
setcap [-q] [-v] [-n <rootid>] (-r|-|<caps>) <filename>
```

**选项**：

- `-q`：以简洁方式输出。
- `-v`：用于验证指定的功能当前是否与该文件关联（v 是 verify 的意思）。如果提供了 `-v` 和 `-n`，则还会验证 `-n <rootid>` 参数。
- `-n <rootid>`：设置仅在具有此 rootid 所有者的命名空间中使用的文件功能。
- `-r`：从文件中删除功能集。请注意，设置空功能集与删除它不同，空集可用于保证文件不会以特权执行。
- `-`：从标准输入读取功能。在这种情况下，功能集以空行终止。

**参数**：

- `caps`：功能集。详细参考下面说明。
- `filename`：文件名称。



## 权限

Linux 内核从 2.2 版本开始，就增加了 Capabilities 的概念与机制，并随着版本升高逐步得到改进。在 Linux 中，root 权限被分割为以下 29 种能力：

```bash
CAP_CHOWN            # 修改文件属主的权限
CAP_DAC_OVERRIDE     # 忽略文件的 DAC 访问限制
CAP_DAC_READ_SEARCH  # 忽略文件读及目录搜索的 DAC 访问限制
CAP_FOWNER           # 忽略文件属主 ID 必须和进程用户 ID 相匹配的限制
CAP_FSETID           # 允许设置文件的 setuid 位
CAP_KILL             # 允许对不属于自己的进程发送信号
CAP_SETGID           # 允许改变进程的组 ID
CAP_SETUID           # 允许改变进程的用户 ID
CAP_SETPCAP          # 允许向其他进程转移能力以及删除其他进程的能力
CAP_LINUX_IMMUTABLE  # 允许修改文件的 IMMUTABLE 和 APPEND 属性标志
CAP_NET_BIND_SERVICE # 允许绑定到小于 1024 的端口
CAP_NET_BROADCAST    # 允许网络广播和多播访问
CAP_NET_ADMIN        # 允许执行网络管理任务
CAP_NET_RAW          # 允许使用原始套接字
CAP_IPC_LOCK         # 允许锁定共享内存片段
CAP_IPC_OWNER        # 忽略 IPC 所有权检查
CAP_SYS_MODULE       # 允许插入和删除内核模块
CAP_SYS_RAWIO        # 允许直接访问 /devport,/dev/mem,/dev/kmem 及原始块设备
CAP_SYS_CHROOT       # 允许使用 chroot() 系统调用
CAP_SYS_PTRACE       # 允许跟踪任何进程
CAP_SYS_PACCT        # 允许执行进程的 BSD 式审计
CAP_SYS_ADMIN        # 允许执行系统管理任务，如加载或卸载文件系统、设置磁盘配额等
CAP_SYS_BOOT         # 允许重新启动系统
CAP_SYS_NICE         # 允许提升优先级及设置其他进程的优先级
CAP_SYS_RESOURCE     # 忽略资源限制
CAP_SYS_TIME         # 允许改变系统时钟
CAP_SYS_TTY_CONFIG   # 允许配置 TTY 设备
CAP_MKNOD            # 允许使用 mknod() 系统调用
CAP_LEASE            # 允许修改文件锁的 FL_LEASE 标志
```

使用 `setcap` 命令可以分割 root 用户的特权，即将 root 的特权分割成不同的能力，每种能力代表一定的特权操作。例如，能力 `CAP_SYS_MODULE` 表示用户能够加载（或卸载）内核模块的特权操作，而 `CAP_SETUID` 表示用户能够修改进程用户身份的特权操作。在 Capbilities 中系统将根据进程拥有的能力来进行特权操作的访问控制。

在 Capilities 中，只有进程和可执行文件才具有能力，每个进程拥有三组能力集，分别称为 cap_effective、cap_inheritable、cap_permitted（分别简记为：`pE`、`pI`、`pP`），其中：

- cap_permitted 表示进程所拥有的最大能力集；
- cap_effective 表示进程当前可用的能力集，可以看做是 cap_permitted 的一个子集；
- cap_inheitable 则表示进程可以传递给其子进程的能力集。

系统根据进程的 cap_effective 能力集进行访问控制，cap_effective 为 cap_permitted 的子集，进程可以通过取消 cap_effective 中的某些能力来放弃进程的一些特权。

可执行文件也拥有三组能力集，对应于进程的三组能力集，分别称为 cap_effective、cap_allowed 和 cap_forced（分别简记为 `fE`、`fI`、`fP`），其中：

- cap_allowed 表示程序运行时可从原进程的 cap_inheritable 中集成的能力集；
- cap_forced 表示运行文件时必须拥有才能完成其服务的能力集；
- cap_effective 则表示文件开始运行时可以使用的能力。



## 示例

安装 Wireshark 的时候，有一步是给 dumpcap 读网卡的权限，使得普通用户也可以使用 Wireshark 进行抓包：

```bash
$ sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/sbin/dumpcap
```

给可执行文件 /bin/ping 加上 “cap_net_admin,cap_net_raw+ep” 权限，普通用户即可使用 ping：

```bash
$ sudo setcap 'cap_net_admin,cap_net_raw+ep' /bin/ping
```

给 nginx 加上使用 1024 以内端口的权限（无需 root 权限）：

```bash
$ sudo setcap 'cap_net_bind_service=+eip' /usr/sbin/nginx
```

清除 nginx 可执行文件附加的权限：

```bash
$ sudo setcap -r nginx
```



