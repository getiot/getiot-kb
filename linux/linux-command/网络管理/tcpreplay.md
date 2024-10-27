---
sidebar_label: tcpreplay 命令
sidebar_position: 33
slug: /tcpreplay
---

# tcpreplay 命令



## 介绍

**tcpreplay** 是一个用于在网络中重放和编辑 pcap 文件的命令行工具。它可以用来测试网络设备的性能、网络分析、入侵检测系统（IDS）的测试和验证等。tcpreplay 工具允许用户将先前捕获的网络流量重放到网络中，以模拟真实的流量。通过组合不同的选项参数，可以灵活地模拟各种网络条件和负载。

tcpreplay 命令由 [tcpreplay](https://tcpreplay.appneta.com) 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install tcpreplay
```

安装完成后，系统会增加 `tcpreplay`、`tcprewrite`、`tcpreplay-edit`、`tcpprep`、`tcpbridge`、`tcpliveplay`、`tcpcapinfo` 等几个命令。

**语法**：

```bash
tcpreplay [ -<flag> [<val>] | --<name>[{=| }<val>] ]... <pcap_file(s)>
```

**选项**：

- `-i, --intf1=str`：指定回放流量的网络接口（多网卡系统必须指定）。
- `-I, --intf2=str`：辅助流量输出接口（可选）。
- `-T, --timer=str`：选择数据包计时模式。可以是 `select`、`ioport`、`gtod` 或 `nano`。
- `--maxsleep=num`：数据包之间休眠时间不超过 `num` 毫秒。
- `-v, --verbose`：通过 tcpdump 将解码后的数据包打印到标准输出 `STDOUT`。
- `-A, --decode=str`：传递给 tcpdump 解码器的参数（需要 `-v` 选项）。
- `-K, --preload-pcap`：发送前将数据包预加载到 RAM 中。
- `-l, --loop=num`：指定回放流量的次数。默认是 1 次。
- `-L, --limit=num`：指定回放数据包的数量（需要大于 1）。
- `-x, --multiplier=str`：将回放速度修改为指定倍数。
- `-p, --pps=str`：以指定的 packets/sec 速度（每秒包数）回放数据包。
- `-M, --mbps=str`：以指定的 Mbps 速度（带宽）回放数据包。
- `-t, --topspeed`：尽可能快地回放数据包。
- `-o, --oneatatime`：根据每个用户输入，一次重放一个数据包。



## 示例

将 example.pcap 文件中的流量重放到 `eth0` 接口上：

```bash
tcpreplay -i eth0 example.pcap
```

将 example.pcap 文件中的流量在 `eth0` 接口上重放 5 次：

```bash
tcpreplay -i eth0 -l 5 example.pcap
```

根据 pcap 文件中的时间戳来重放流量：

```bash
tcpreplay -i eth0 -t example.pcap
```

以 10 Mbps 的速度重放流量：

```bash
tcpreplay -i eth0 --mbps=10 example.pcap
```

以每秒 1000 包的速度重放流量：

```bash
tcpreplay -i eth0 --pps=1000 example.pcap
```

只重放前 100 个包：

```bash
tcpreplay -i eth0 -L 100 example.pcap
```



## 资源链接

- [tcpreplay 代码仓库](https://github.com/appneta/tcpreplay)
- [tcpreplay 项目主页](https://tcpreplay.appneta.com)

