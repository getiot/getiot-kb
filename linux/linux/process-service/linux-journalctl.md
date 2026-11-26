---
sidebar_position: 6
sidebar_label: journalctl 日志查看
slug: /linux-journalctl
---

# Linux journalctl 日志查看

很多现代 Linux 发行版使用 systemd 管理服务，同时使用 journald 收集系统日志。`journalctl` 就是查看这些日志的主要工具。

如果你排查服务启动失败、网络异常、系统重启原因，`journalctl` 经常是第一站。

## 查看所有日志

```bash
journalctl
```

输出会进入分页界面，按键和 `less` 类似：

- 空格：下一页。
- `b`：上一页。
- `/word`：搜索关键词。
- `q`：退出。

如果日志很多，不建议从头翻。你可以加过滤条件。

## 查看本次启动日志

```bash
journalctl -b
```

`-b` 表示 boot，也就是本次启动。

查看上一次启动日志：

```bash
journalctl -b -1
```

这对于排查“刚才重启前发生了什么”很有帮助。

## 查看某个服务的日志

查看 SSH 服务日志：

```bash
journalctl -u ssh
```

有些发行版服务名可能是 `sshd`：

```bash
journalctl -u sshd
```

如果你不确定服务名，先用：

```bash
systemctl list-units --type=service | grep ssh
```

## 实时跟踪日志

```bash
journalctl -u ssh -f
```

`-f` 表示 follow，会持续显示新日志。按 Ctrl+C 停止。

这和 `tail -f` 的用途类似，只是日志来源是 systemd journal。

## 按时间过滤

查看今天的日志：

```bash
journalctl --since today
```

查看最近 30 分钟：

```bash
journalctl --since "30 minutes ago"
```

查看指定时间段：

```bash
journalctl --since "2026-07-24 09:00" --until "2026-07-24 10:00"
```

时间字符串由 systemd 解析。不同语言环境下显示格式可能不同，但上面的形式通常比较稳。

## 按级别过滤

查看错误及更严重日志：

```bash
journalctl -p err
```

常见级别包括：

| 级别 | 含义 |
| --- | --- |
| `emerg` | 系统不可用 |
| `alert` | 必须立即处理 |
| `crit` | 严重错误 |
| `err` | 错误 |
| `warning` | 警告 |
| `notice` | 重要提示 |
| `info` | 普通信息 |
| `debug` | 调试信息 |

服务排错时常用：

```bash
journalctl -u nginx -p warning
```

## 查看内核日志

```bash
journalctl -k
```

这会显示内核相关日志，类似 [dmesg](/linux-command/dmesg/) 的用途。

排查硬件、驱动、文件系统错误时会用到它。

## 控制输出格式

只看最近 50 行：

```bash
journalctl -n 50
```

不使用分页器，直接输出：

```bash
journalctl --no-pager -n 50
```

显示更详细字段：

```bash
journalctl -o verbose -n 5
```

## 查看日志占用空间

```bash
journalctl --disk-usage
```

如果日志占用过大，可以清理旧日志。例如保留最近 7 天：

```bash
sudo journalctl --vacuum-time=7d
```

或限制总空间：

```bash
sudo journalctl --vacuum-size=1G
```

:::warning
清理日志会删除历史排错线索。生产系统中执行前，应确认是否需要归档或备份。
:::

## 小结

最常用的 `journalctl` 命令是：

```bash
journalctl -b
journalctl -u 服务名
journalctl -u 服务名 -f
journalctl -p err
journalctl --since today
```

遇到服务异常时，可以先看 `systemctl status 服务名`，再用 `journalctl -u 服务名` 继续追踪。
