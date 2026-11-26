---
sidebar_position: 3
sidebar_label: 服务启动失败怎么查
slug: /linux-service-failed
---

# Linux 服务启动失败怎么查

Linux 服务启动失败时，不要只看一句 `failed`。systemd 通常已经记录了足够多的线索，你需要按顺序把它们找出来。

## 第一步：查看服务状态

```bash
systemctl status 服务名
```

例如：

```bash
systemctl status nginx
```

重点看：

- `Loaded`：服务单元是否加载成功。
- `Active`：当前状态。
- `Main PID`：主进程。
- 最近几行日志。

如果服务名不确定，可以列出服务：

```bash
systemctl list-units --type=service | grep nginx
```

## 第二步：查看完整日志

```bash
journalctl -u 服务名 -n 100
```

实时跟踪：

```bash
journalctl -u 服务名 -f
```

只看本次启动：

```bash
journalctl -b -u 服务名
```

日志通常会告诉你配置文件路径、权限问题、端口占用、依赖缺失等信息。

## 第三步：检查配置文件

很多服务提供配置检查命令。例如 Nginx 常用：

```bash
nginx -t
```

不同服务命令不同，请以服务文档为准。

如果没有专门检查命令，至少可以：

```bash
sudo systemctl cat 服务名
```

查看 systemd unit 文件内容，确认 `ExecStart` 指向的程序和参数。

## 第四步：检查端口占用

如果日志提示端口已被占用：

```bash
ss -tulpn | grep ":80"
```

找到占用端口的进程后，再决定是停止旧服务、换端口，还是修改配置。

## 第五步：检查权限和路径

常见问题包括：

- 配置文件不存在。
- 数据目录不存在。
- 服务用户没有读写权限。
- 可执行文件路径错误。

你可以检查：

```bash
ls -l /path/to/file
ls -ld /path/to/dir
```

如果服务以特定用户运行，还要确认该用户有权限访问这些路径。

## 第六步：重新加载或重启

修改 unit 文件后：

```bash
sudo systemctl daemon-reload
```

重启服务：

```bash
sudo systemctl restart 服务名
```

查看状态：

```bash
systemctl status 服务名
```

如果只是修改服务自己的配置，有些服务支持 reload：

```bash
sudo systemctl reload 服务名
```

前提是该服务支持 reload。

## 常见原因清单

| 现象 | 可能原因 |
| --- | --- |
| 配置解析失败 | 配置语法错误 |
| Permission denied | 文件、目录或端口权限不足 |
| Address already in use | 端口被占用 |
| No such file or directory | 路径写错或文件缺失 |
| Start request repeated too quickly | 服务反复失败，触发 systemd 限制 |
| Dependency failed | 依赖服务没有启动 |

## 小结

服务启动失败时，按这个顺序查：

```bash
systemctl status 服务名
journalctl -u 服务名 -n 100
systemctl cat 服务名
ss -tulpn
```

先读日志，再改配置。不要只凭经验重启很多次。
