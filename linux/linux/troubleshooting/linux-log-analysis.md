---
sidebar_position: 5
sidebar_label: 日志分析入门
slug: /linux-log-analysis
---

# Linux 日志分析入门

日志是 Linux 排错的主要线索。服务为什么启动失败、谁登录过系统、磁盘为什么满、网络为什么断，很多答案都藏在日志里。

## 常见日志位置

传统日志通常在：

```text
/var/log
```

常见文件包括：

- `/var/log/syslog`：Debian/Ubuntu 常见系统日志。
- `/var/log/messages`：部分 RHEL 系系统常见系统日志。
- `/var/log/auth.log`：认证相关日志，Debian/Ubuntu 常见。
- `/var/log/secure`：认证相关日志，RHEL 系常见。
- `/var/log/kern.log`：内核日志，部分系统存在。

使用 systemd 的系统还会把日志存入 journal，用 `journalctl` 查看。

## 从最近日志看起

查看文件末尾：

```bash
tail -n 100 /var/log/syslog
```

实时跟踪：

```bash
tail -f /var/log/syslog
```

如果系统没有 `/var/log/syslog`，使用：

```bash
journalctl -n 100
```

## 按服务查看

systemd 服务日志：

```bash
journalctl -u 服务名 -n 100
```

实时查看：

```bash
journalctl -u 服务名 -f
```

只看本次启动：

```bash
journalctl -b -u 服务名
```

## 搜索关键词

常见关键词：

- `error`
- `failed`
- `denied`
- `timeout`
- `refused`
- `warning`

忽略大小写搜索：

```bash
grep -i "error" app.log
```

带行号：

```bash
grep -n -i "failed" app.log
```

在多个日志中搜索：

```bash
grep -R -n -i "denied" /var/log 2>/dev/null
```

## 按时间缩小范围

如果你知道问题发生在某个时间点，就不要从头翻日志。

使用 journal：

```bash
journalctl --since "2026-07-24 09:00" --until "2026-07-24 10:00"
```

普通文本日志可以先用 `less` 打开，再用 `/` 搜索日期或关键词。

## 看日志上下文

只看到一行错误往往不够。可以用 `grep -C` 显示上下文：

```bash
grep -C 3 -i "error" app.log
```

含义是显示匹配行前后各 3 行。

也可以用：

```bash
grep -A 5 -B 5 -i "error" app.log
```

`-A` 是 after，`-B` 是 before。

## 常见日志线索

| 关键词 | 可能方向 |
| --- | --- |
| `Permission denied` | 权限、SELinux、AppArmor、目录所有者 |
| `No such file or directory` | 路径错误、文件缺失 |
| `Address already in use` | 端口被占用 |
| `Connection refused` | 目标端口没有服务监听 |
| `Connection timed out` | 网络、防火墙、安全组 |
| `No space left on device` | 磁盘空间或 inode |

## 保护敏感信息

日志中可能包含：

- IP 地址。
- 用户名。
- Token。
- Cookie。
- 内网域名。
- 请求参数。

分享日志给别人前，请先脱敏。

## 小结

日志分析可以按这个套路：

1. 明确问题发生时间。
2. 找到相关服务或日志文件。
3. 从最近日志看起。
4. 搜索关键错误词。
5. 查看上下文。
6. 根据线索回到配置、权限、网络、磁盘等方向继续查。

日志不是答案本身，但它会告诉你下一步该往哪里看。
