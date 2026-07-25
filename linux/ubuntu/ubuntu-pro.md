---
sidebar_position: 5
---

# Ubuntu Pro

Ubuntu Pro 是 Canonical 提供的开源安全与合规订阅。它在普通 Ubuntu LTS 的安全维护之上，扩展仓库覆盖范围、拉长支持年限，并附带 Livepatch、实时内核、加固与合规工具等能力。

个人用途长期免费（机器数量以[官网](https://ubuntu.com/pro)当前说明为准，常见为最多 5 台物理机；正式社区成员额度更高）。企业可购买订阅或使用公有云上的 Ubuntu Pro 镜像。

## 本文解决什么问题

- Ubuntu Pro 是什么、能带来什么  
- 如何把本机绑定（attach）到订阅  
- 如何查看与开关服务  
- 如何启用**实时内核（Real-time kernel）**  

## Pro 能提供什么

根据官网介绍，Pro 提供的能力包括：

| 能力 | 说明 |
| --- | --- |
| **ESM**（Expanded Security Maintenance） | 把 LTS 安全维护从 Main 的约 5 年，扩展到更长周期，并覆盖更多 Universe 等软件包（具体以订阅与发行版为准） |
| **Livepatch** | 部分内核安全补丁可少重启应用，见 [Ubuntu Livepatch](/ubuntu/ubuntu-livepatch/) |
| **实时内核** | 集成 `PREEMPT_RT` 的实时内核，适合对延迟敏感的场景 |
| **合规与加固** | 如 FIPS、CIS / USG、DISA-STIG 等相关能力（按发行版与订阅） |
| **Landscape 等** | 大规模机器集中管理（企业场景更常见） |

:::tip
普通桌面学习机最常用的是：免费 Pro → 打开 ESM / Livepatch；做机器人、工控、音视频低延迟实验时，再考虑实时内核。
:::

## 准备工作

1. 建议使用 **Ubuntu LTS**（如 22.04 / 24.04 / 26.04）  
2. 确保 `pro` 客户端较新：

```bash
sudo apt update
sudo apt install ubuntu-pro-client
pro version
```

系统通常已预装 `ubuntu-pro-client`；升级可避免旧命令缺选项。

## 绑定订阅（attach）

### 方式一：交互式（推荐新手）

```bash
sudo pro attach
```

终端会给出链接与一次性代码。用浏览器打开 [Ubuntu Pro 绑定页](https://ubuntu.com/pro/attach)，登录后粘贴代码并选择订阅（个人免费订阅一般会默认出现）。完成后回到终端，等待提示绑定成功。

### 方式二：使用 token

在 [Ubuntu Pro 控制台](https://ubuntu.com/pro/dashboard) 复制 token：

```bash
sudo pro attach YOUR_TOKEN
```

### 公有云 Pro 镜像

在 AWS / Azure / GCP 等市场上的 Ubuntu Pro 实例，订阅往往已附带，可直接：

```bash
pro status
```

不必再手动 attach（以云厂商说明为准）。

### 不想自动启用推荐服务时

```bash
sudo pro attach --no-auto-enable
```

之后再用 `pro enable` 按需打开。

## 查看状态

```bash
pro status
```

输出里会列出各服务是否 available / enabled，例如 `esm-infra`、`esm-apps`、`livepatch`、`realtime-kernel` 等。

常用管理命令：

```bash
sudo pro enable 服务名
sudo pro disable 服务名
```

## 示例：启用 Livepatch

绑定后，许多 LTS 会默认启用 Livepatch。若未启用：

```bash
sudo pro enable livepatch
sudo canonical-livepatch status
```

细节见 [Ubuntu Livepatch](/ubuntu/ubuntu-livepatch/)。

## 示例：启用实时内核

实时内核面向需要更可预测调度延迟的场景（工控、机器人、部分音视频等）。启用前请确认：

- 当前发行版与架构在[支持列表](https://canonical-real-time-ubuntu-documentation.readthedocs-hosted.com/en/latest/reference/releases/)中  
- 已了解与 **Livepatch** 等服务可能互斥（`pro` 会提示并询问是否先关闭）  
- 启用会**更换内核**，完成后需要**重启**；回到原内核通常要手动调整 GRUB 启动项  

### 1. 确保已 attach，并更新客户端

```bash
pro status
sudo apt update && sudo apt install ubuntu-pro-client
```

### 2. 按硬件选择命令

**通用实时内核**（amd64 / arm64 常见场景；**不要**在树莓派上装 generic）：

```bash
sudo pro enable realtime-kernel
```

**树莓派 4 / 5**：

```bash
sudo pro enable realtime-kernel --variant=raspi
```

**部分 Intel IoT / 指定平台**（如文档中的 Intel IOTG 变体）：

```bash
sudo pro enable realtime-kernel --variant=intel-iotg
```

按提示确认警告。成功后会提示需要 reboot：

```bash
sudo reboot
```

### 3. 重启后确认

```bash
uname -r
pro status
```

内核版本字符串中通常能看到与 realtime 相关的标识（具体命名以当前包装为准）。

### 只要仓库、暂不装内核

```bash
sudo pro enable realtime-kernel --access-only
# 之后再按需：
# sudo apt install ubuntu-realtime
```

### 注意点

| 点 | 说明 |
| --- | --- |
| 与 Livepatch | 常见不兼容；启用 realtime 时可能被要求先 disable livepatch |
| 树莓派 | 必须用 `raspi` 变体，误用 generic 可能导致系统无法使用 |
| 回退 | 官方说明需手动切回原内核；操作前请留好救援手段 |
| 支持矩阵 | 发行版 / 变体以 [Real-time 文档](https://canonical-real-time-ubuntu-documentation.readthedocs-hosted.com/en/latest/) 为准 |

:::note 关于较新的 LTS
个别新版本可能调整实时内核的获取方式（例如是否进入主仓库）。动手前对照当前发行版的[官方 Real-time 说明](https://ubuntu.com/real-time)与 Pro Client 文档，避免照抄过期步骤。
:::

## 取消绑定

```bash
sudo pro detach
```

会按提示处理已启用服务；生产环境操作前先确认影响。

## 相关链接

- Ubuntu Pro 官网：[https://ubuntu.com/pro](https://ubuntu.com/pro)
- 绑定与服务文档：[https://documentation.ubuntu.com/pro-client/](https://documentation.ubuntu.com/pro-client/)
- 启用实时内核：[https://documentation.ubuntu.com/pro-client/en/latest/howtoguides/enable_realtime_kernel/](https://documentation.ubuntu.com/pro-client/en/latest/howtoguides/enable_realtime_kernel/)
- Real-time Ubuntu：[https://ubuntu.com/real-time](https://ubuntu.com/real-time)

## 小结

Ubuntu Pro = **更长、更广的安全维护 + 可选企业级能力**。个人可免费绑定；用 `pro attach` 接入，用 `pro enable` / `pro status` 管理服务。实时内核适合低延迟场景：选对变体、接受与 Livepatch 的取舍，启用后重启验证。
