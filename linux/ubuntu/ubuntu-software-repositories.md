---
sidebar_position: 5
---

# Ubuntu 软件源

Ubuntu 通过 **APT 软件源（仓库，repository）** 组织大量可安装软件。你执行 `apt install` 时，系统会按已配置的源地址下载 `.deb` 包及其依赖。

把软件源想成「官方指定的应用货架」：货架分类不同，维护方与许可也不同。

## 四大组件（Components）

桌面版默认通常会启用下面几类（可在「软件和更新」里勾选）：

| 组件 | 含义 |
| --- | --- |
| **Main** | Canonical 官方支持的免费开源软件，质量与安全更新有保障 |
| **Universe** | 社区维护的免费开源软件，软件更多，支持力度与 Main 不同 |
| **Restricted** | 有专有许可的常用组件（如部分设备驱动、固件相关） |
| **Multiverse** | 受版权或法律限制较多的软件，启用前需自行评估合规性 |

:::tip
一般桌面开发机：Main + Universe 几乎必开；Restricted 常因硬件需要打开；Multiverse 按需。
:::

## 更新口袋（Suites / pockets）

同一发行版代号（如 `jammy`、`noble`）下，常见还有：

| 名称 | 作用 |
| --- | --- |
| `release`（如 `noble`） | 该版本发布时的基础软件包 |
| `updates` | 推荐更新 |
| `security` | 安全更新（很重要） |
| `backports` | 从较新版本反向移植的软件，默认可选 |
| `proposed` | 待测试更新，**一般不要给生产机启用** |

## 源配置文件在哪

| Ubuntu 版本 | 常见配置位置 |
| --- | --- |
| 24.04 及更新 | `/etc/apt/sources.list.d/ubuntu.sources`（DEB822 格式） |
| 较旧版本 | `/etc/apt/sources.list`，以及 `sources.list.d/` 下若干 `.list` |

额外源（PPA、第三方）通常以独立文件放在 `/etc/apt/sources.list.d/`。

查看当前发行版代号：

```bash
. /etc/os-release
echo "$UBUNTU_CODENAME"
```

## APT 与软件源类型

APT 是从指定的软件源获取安装包。常见几类源可以这样理解：

- **默认使用的官方源**：Ubuntu 发行版官方提供的安装包，虽然不一定是最新版，但质量和安全性有保障。
- **软件自行提供的官方源**：比如 llvm/clang 就提供了 Ubuntu 和 Debian 的[官方源](https://apt.llvm.org/)。
- **PPA**（Personal Package Archive）：个人软件源，可理解为托管软件安装包的 GitHub。方便，但质量参差，添加前建议看维护情况与评价。

此外还有本地 / 离线仓库等场景。换国内镜像、加快 `apt update` 的方法见：[Ubuntu 更换源](/ubuntu/ubuntu-change-apt-source/)。

## 软件安装方式优先顺序

Ubuntu 上通常既可以用 APT 包管理器安装，也可以手动编译源码。对 APT 来说，你可以修改软件源（软件仓库的来源），从而安装更多软件。

下面是比较建议的软件安装方式优先顺序（可按场景调整）：

- 只是需要一个程序，不关心版本号：用 apt 安装
- 只是需要一个程序，需要的版本 apt 里就有：用 apt 安装
- 只是需要一个程序，需要的版本 apt 没有提供，但有官方源：添加对应的官方源，再用 apt 安装
- 只是需要一个程序，需要的版本 apt 没有提供，但 PPA 里有：添加对应的 PPA，再用 apt 安装
- 只是需要一个程序，需要的版本 apt 没有提供，PPA 里也没有：从源码自行编译安装
- 想要探索 Linux 世界的秘密：从源码自行编译安装

另外还有 **Snap**、**Flatpak**、官方 `.deb` 等并行渠道，见 [Ubuntu 应用软件](/ubuntu/ubuntu-software/)。

:::note APT 与源的关系
`apt` 只从**你已配置且 `apt update` 成功的源**里解析软件。源不可达、代号写错或 GPG 校验失败时，安装会失败——先修好源，再装软件。
:::

## 常用命令（复习）

```bash
sudo apt update              # 刷新软件索引
apt search 关键字            # 搜索
apt show 包名                # 查看包信息
sudo apt install 包名        # 安装
sudo apt remove 包名         # 卸载（可保留配置）
sudo apt purge 包名          # 卸载并删除配置
sudo apt autoremove          # 清理无用依赖
```

`apt` 与 `apt-get` 的差异见：[apt 和 apt-get 的区别](/ubuntu/apt-vs-apt-get-difference/)。

## 小结

软件源决定了「能装什么、从哪下载、是否可信」。先分清 Main / Universe / Restricted / Multiverse，再按「官方源 → 项目官方源 → PPA → 源码」的优先级选型；换源与装应用分别见后续两篇。
