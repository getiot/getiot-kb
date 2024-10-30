---
sidebar_label: trippy 命令
sidebar_position: 20
slug: /trippy
---

# trippy 命令 - 网络调试分析工具



## 介绍

**trippy** 是一个命令行工具（别名 **trip**），支持 Linux、Windows、macOS 等平台，可以代替 [traceroute](/linux-command/traceroute) 查看互联网通信的路径，分析网络状况。

trippy 使用 Rust 语言实现，使用前需要安装，安装方法如下：

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="cargo" label="Cargo" default>
    ```bash
    cargo install trippy
    ```
  </TabItem>
  <TabItem value="snap" label="Snap">
    ```bash
    snap install trippy
    ```
  </TabItem>
  <TabItem value="brew" label="Homebrew">
    ```bash
    brew install trippy
    ```
  </TabItem>
    <TabItem value="winget" label="WinGet">
    ```bash
    winget install trippy
    ```
  </TabItem>
    <TabItem value="scoop" label="Scoop">
    ```bash
    scoop install trippy
    ```
  </TabItem>
    <TabItem value="pacman" label="Pacman">
    ```bash
    pacman -S trippy
    ```
  </TabItem>
</Tabs>

**语法**：

```bash
trip [OPTIONS] [TARGETS]...
```

注：trip 是 trippy 的软链接，因此可以用 trip 代替 trippy。



## 示例

具有默认参数的基本用法：

```bash
trip example.com
```

注意：在 Linux 运行需要使用 sudo 提权。输出结果如下：

![](https://static.getiot.tech/trippy-getiot-20231217.png#center)

不需要提升特权的跟踪：

```bash
trip example.com --unprivileged
```

使用 udp（或 tcp 或 icmp）协议：

```bash
trip example.com -p udp
```

指定追踪的最低轮转时间为 250 毫秒，宽限期为 50 毫秒：

```bash
trip example.com -i 250ms -g 50ms
```

使用自定义的第一个 TTL 和最大 TTL 值：

```bash
trip example.com --first-ttl 2 --max-ttl 10
```

使用自定义目标端口443进行 tcp 跟踪：

```bash
trip example.com -p tcp -P 443
```

使用自定义源端口 5000 跟踪 udp：

```bash
trip example.com -p udp -S 5000
```
