---
sidebar_label: cansniffer 命令
sidebar_position: 21
slug: /cansniffer
---

# Linux cansniffer 命令 - CAN 报文内容可视化



## 介绍

**cansniffer** 命令是一个交互式 CAN 报文嗅探工具，以表格形式实时显示各 CAN ID 的数据内容，并在数据变化时高亮标记。相比 [candump](/linux-command/candump/) 的逐行滚动输出，cansniffer 更适合观察特定 ID 的数据变化趋势，常用于 ECU 调试和信号分析。

cansniffer 命令由 can-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install can-utils
```

**语法**：

```bash
cansniffer [options] [can-interface]
```

使用接口名 `any` 可从所有 CAN 接口接收。

**选项**：

- `-q`：静默启动（所有 ID 默认关闭）
- `-r <name>`：从文件 `sniffset.<name>` 读取过滤配置
- `-e`：固定扩展帧格式输出（禁用自动检测）
- `-b`：以二进制模式启动
- `-8`：以二进制模式启动（EFF 适配 80 字符宽度）
- `-B`：以带间隔的二进制模式启动（超过 80 字符）
- `-c`：启用数据变化彩色标记
- `-t <time>`：ID 显示超时，单位 ×10 ms（默认 500，0 为关闭）
- `-h <time>`：变化标记保持时间，单位 ×10 ms（默认 100）
- `-l <time>`：显示刷新周期，单位 ×10 ms（默认 20）

**运行时交互命令**：

| 按键 | 功能 |
| ---- | ---- |
| `q` + Enter | 退出 |
| `b` + Enter | 切换二进制 / HEX-ASCII 输出 |
| `c` + Enter | 切换彩色模式 |
| 空格 + Enter | 强制清屏 |
| `#` + Enter | 锁定当前标记/变化的位 |
| `*` + Enter | 清除位锁定 |
| `a` + Enter | 启用所有 SFF（11 位）ID |
| `n` + Enter | 关闭所有 SFF ID |
| `A` + Enter | 启用所有 EFF（29 位）ID |
| `N` + Enter | 关闭所有 EFF ID |
| `+FILTER` + Enter | 添加要嗅探的 CAN ID |
| `-FILTER` + Enter | 移除要嗅探的 CAN ID |
| `rNAME` + Enter | 读取配置文件 |
| `wNAME` + Enter | 写入配置文件 |

FILTER 可以是单个 CAN ID 或 CAN ID/掩码组合，例如 `+1F5` 添加 SFF ID 0x1F5，`+400600` 添加 ID 范围 0x400～0x5FF。

相关命令：[candump](/linux-command/candump/)、[cangen](/linux-command/cangen/)



## 示例

1、嗅探 can0 上所有报文，启用彩色变化标记：

```bash
cansniffer -c can0
```

2、静默启动，运行时手动添加感兴趣的 ID：

```bash
cansniffer -q can0
# 在交互界面输入：+123<Enter>  添加 ID 0x123
# 在交互界面输入：+400600<Enter>  添加 ID 0x400～0x5FF
```

3、从配置文件加载过滤规则：

```bash
cansniffer -r myfilter can0
```

4、嗅探所有 CAN 接口：

```bash
cansniffer -c any
```

5、以二进制模式启动，适配扩展帧显示：

```bash
cansniffer -8 -c can0
```

6、保存当前过滤和标记配置：

```bash
# 在交互界面输入：wmyconfig<Enter>
# 生成 sniffset.myconfig 文件，下次可用 -r myconfig 加载
```
