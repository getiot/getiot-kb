---
sidebar_position: 4
---

# Ubuntu Livepatch

**Livepatch** 由 Canonical 提供，用来在**不重启系统**的情况下，为受支持的 Ubuntu 内核打上部分**关键安全补丁**。它特别适合服务器、长期运行的开发机，以及「一重启就要协调一堆服务」的环境。

它不是「永远不用重启」的魔法：不是所有内核更新都能 live patch；发行版大版本升级、部分内核更新仍可能需要重启。

## 本文解决什么问题

- Livepatch 能做什么、不能做什么  
- 如何用 Ubuntu Pro 启用  
- 如何查看状态与关闭  

## 适用场景与前提

- 建议在 **Ubuntu LTS** 上使用  
- 内核需在 Livepatch 支持列表中（换过自定义内核时尤其要注意）  
- 需要 **Ubuntu Pro** 订阅；个人用途可在官网申请免费额度（机器数量以官网当前说明为准）  

:::note
公有云上的 Ubuntu Pro 镜像有时已经附带订阅，可跳过「获取 token / attach」步骤，直接看 `pro status`。
:::

## 启用步骤

### 1. 获取 Ubuntu Pro token

1. 打开 Ubuntu Pro 相关页面（可从 [Livepatch 介绍页](https://ubuntu.com/security/livepatch) 进入）  
2. 登录并获取机器的 **token**  
3. 在本机终端执行（把 `TOKEN` 换成你的令牌）：

```bash
sudo pro attach TOKEN
```

对多数 LTS，attach 成功后 Livepatch 常会**默认启用**。可用下面命令确认。

### 2. 若未启用，手动打开

```bash
sudo pro enable livepatch
```

成功时通常会安装 `canonical-livepatch`（snap），并提示已启用。

### 3. 查看状态

```bash
pro status
sudo canonical-livepatch status
```

需要更详细输出时：

```bash
sudo canonical-livepatch status --verbose
```

若内核不受支持，状态里通常会有提示：此时即使「开着」服务，也可能收不到有效补丁。

## 关闭 Livepatch

```bash
sudo pro disable livepatch
```

## 限制与注意点

| 点 | 说明 |
| --- | --- |
| 不等于免重启 | 只覆盖部分内核安全修复；其他更新仍可能要 reboot |
| 内核兼容 | 自定义 / 第三方内核可能不受支持 |
| 与部分 Pro 服务互斥 | 例如与部分 FIPS、实时内核（realtime）组合可能不兼容；`pro` 会提示 |
| 网络 | 需要能访问 Canonical Livepatch 服务 |

:::tip 和普通更新的关系
日常仍应定期执行 `sudo apt update && sudo apt upgrade`。Livepatch 主要补「内核安全、且希望少重启」这一块，不替代完整的软件更新流程。
:::

## 相关链接

- Livepatch 概述：https://ubuntu.com/security/livepatch  
- 官方启用教程：https://ubuntu.com/tutorials/enable-the-livepatch-service  
- Ubuntu Pro Client 文档：https://documentation.ubuntu.com/pro-client/  

## 小结

Livepatch = **少重启的内核安全热补丁**。个人与小规模机器可通过 Ubuntu Pro 免费额度启用；用 `pro attach` / `pro enable livepatch` 打开，用 `canonical-livepatch status` 确认是否真正生效。

接下来了解软件从哪里来：[Ubuntu 软件源](/ubuntu/ubuntu-software-repositories/)。
