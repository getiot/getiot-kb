---
sidebar_position: 7
---

# Ubuntu 应用软件

装好系统后，下一步通常是安装日常与开发常用软件。Ubuntu 上常见渠道有：**APT（`.deb`）**、**Snap**、**Flatpak**、官方安装包，以及源码编译。

本文给你一张「怎么选、怎么装」的地图，并列出一组高频命令；具体软件的专题安装（Wireshark、Wine、QQ 等）见本教程后续章节。

## 安装渠道怎么选

| 渠道 | 特点 | 适合 |
| --- | --- | --- |
| `apt` / `.deb` | 与系统集成好，依赖由 APT 管理 | 绝大多数命令行工具、库、服务 |
| Snap | 带依赖打包，更新独立，权限模型不同 | 部分桌面应用、上游主推 snap 的软件 |
| Flatpak | 跨发行版桌面应用分发 | 想要较新 GUI 应用时 |
| 官方 `.deb` / AppImage | 厂商直接提供 | 浏览器、IDE、专有软件 |
| 源码 / 二进制包 | 最灵活，维护成本最高 | apt 没有、又要特定版本时 |

更细的安装优先级（官方源 / 项目源 / PPA / 源码）见 [Ubuntu 软件源](/ubuntu/ubuntu-software-repositories/)。

:::tip 新手默认策略
能 `apt install` 就先 apt；只有版本不够新或官方明确推荐时，再上 Snap / Flatpak / 官网包。
:::

## 使用 APT（最常用）

确保源可用（必要时先 [更换源](/ubuntu/ubuntu-change-apt-source/)）：

```bash
sudo apt update
sudo apt install git curl vim build-essential
```

常用操作：

```bash
apt search nginx          # 搜索
apt show nginx            # 详情
sudo apt upgrade          # 升级已装软件
sudo apt remove nginx     # 卸载
sudo apt autoremove       # 清理无用依赖
```

查看某个命令来自哪个包：

```bash
dpkg -S $(which ls)
```

## 使用 Snap

许多 Ubuntu 桌面预装 `snapd`。示例：

```bash
snap find code
sudo snap install code --classic
snap list
sudo snap refresh
sudo snap remove code
```

:::note
`--classic` 表示经典约束（权限更接近传统包装）。不是所有 snap 都需要或允许该选项。
:::

## 图形商店

在应用菜单中打开 **Ubuntu Software**（或「软件」），可搜索并安装 APT / Snap 应用，适合不习惯命令行的场景。装开发工具时，仍建议看清来源是 Deb 还是 Snap。

## 手动安装 .deb

```bash
sudo apt install ./某个软件.deb
```

用 `apt install` 本地文件可以顺带解析依赖，一般比裸 `dpkg -i` 省心。若缺依赖：

```bash
sudo apt -f install
```

## 一组实用软件示例（APT）

按需安装，不必一次装完：

```bash
# 基础工具
sudo apt install git curl wget tree htop tmux unzip

# 编译与调试常见依赖
sudo apt install build-essential gdb cmake pkg-config

# 网络与远程
sudo apt install openssh-server net-tools

# 压缩
sudo apt install p7zip-full
```

更多专题：

| 需求 | 文档 |
| --- | --- |
| SSH | [Ubuntu 配置 SSH 服务](/ubuntu/ubuntu-ssh/) |
| Samba / NFS / TFTP | 见本教程侧边栏对应篇 |
| Wireshark / Wine / QQ 等 | 见「Ubuntu 安装 xxx」系列 |

## Flatpak（可选）

若需要 Flatpak：

```bash
sudo apt install flatpak
# 按 Flatpak 官方说明添加 Flathub 后，再 flatpak install ...
```

具体仓库添加步骤以 [Flatpak 文档](https://flatpak.org/setup/Ubuntu/) 为准（会随版本更新）。

## 常见问题

| 问题 | 建议 |
| --- | --- |
| `apt` 找不到包 | `apt update`；检查源与代号；确认组件（universe 等）已启用 |
| 两个同名应用（deb 与 snap） | 用 `which` / `snap list` / `apt policy` 分清正在用哪一个 |
| 卸载不干净 | `apt purge` + `autoremove`；snap/flatpak 用各自 remove |
| 版本太旧 | 官方源、PPA、Snap/Flatpak 或上游安装包，注意可信度 |

## 小结

Ubuntu 上装软件，优先把 **APT + 正确的软件源** 用熟，再按需使用 Snap / Flatpak / 官网包。装完基础工具后，你可以按本教程后面的专题篇继续配置开发与网络环境。

相关阅读：[apt 和 apt-get 的区别](/ubuntu/apt-vs-apt-get-difference/)、[Ubuntu 离线安装软件包](/ubuntu/ubuntu-install-packages-offline/)。
