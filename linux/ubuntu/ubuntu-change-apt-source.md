---
sidebar_position: 7
---

# Ubuntu 更换源

默认的 `archive.ubuntu.com` / `security.ubuntu.com` 在国内有时偏慢或不稳定。把 APT 源换成较近的镜像站，通常能明显加快 `apt update` 与软件安装。

:::warning 先备份，再改代号
换源前务必备份配置文件。配置里的**发行版代号**必须与当前系统一致（如 `jammy`、`noble`），写错可能导致升级异常。用下面命令确认：

```bash
. /etc/os-release
echo "$VERSION_ID $UBUNTU_CODENAME"
```
:::

## 图形界面（最省事）

1. 打开 **软件和更新**（Software & Updates）  
2. 在 **Ubuntu 软件** 页的「下载自」中选择较近的服务器，或「其他站点…」里选镜像  
3. 关闭窗口时按提示重新载入软件包列表  

适合不想手改配置文件的场景。

## 先分清你的配置文件格式

| 系统 | 主要文件 |
| --- | --- |
| **Ubuntu 24.04 及更新** | `/etc/apt/sources.list.d/ubuntu.sources`（DEB822） |
| **较旧版本（如 22.04）** | `/etc/apt/sources.list`（传统 one-line） |

ARM 等架构设备往往使用 **ubuntu-ports** 镜像，而不是普通 `ubuntu` 仓库。树莓派等请对照镜像站的 *ubuntu-ports* 帮助页。

## 方法一：Ubuntu 24.04+（DEB822）

备份：

```bash
sudo cp /etc/apt/sources.list.d/ubuntu.sources \
        /etc/apt/sources.list.d/ubuntu.sources.bak
```

编辑：

```bash
sudo nano /etc/apt/sources.list.d/ubuntu.sources
```

把 `URIs:` 里的官方地址改成镜像地址。以 **Ubuntu 24.04（noble）+ 清华镜像** 为例（请按你的代号修改 `Suites`）：

```text
Types: deb
URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
Suites: noble noble-updates noble-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb
URIs: http://security.ubuntu.com/ubuntu
Suites: noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
```

:::note 关于 security 源
镜像站同步可能有延迟。许多帮助文档建议 **security 仍指向 `security.ubuntu.com`**，以便更快拿到安全更新。若你明确要用镜像的 security，需自行评估延迟风险。
:::

保存后执行：

```bash
sudo apt update
```

## 方法二：传统 sources.list（如 22.04）

备份：

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
```

若只是把官方域名批量换成清华：

```bash
sudo sed -i 's|archive.ubuntu.com|mirrors.tuna.tsinghua.edu.cn|g' /etc/apt/sources.list
sudo sed -i 's|security.ubuntu.com|mirrors.tuna.tsinghua.edu.cn|g' /etc/apt/sources.list
sudo apt update
```

:::tip 更稳妥的做法
直接整段替换为镜像站提供的模板（带正确代号），比只 sed 域名更不容易漏行。以镜像站当前帮助页为准。
:::

恢复备份示例：

```bash
sudo cp /etc/apt/sources.list.bak /etc/apt/sources.list
sudo apt update
```

## 常用国内镜像（需自行打开帮助页核对）

镜像地址与模板会随时间调整，**请以各站帮助页最新内容为准**：

| 镜像 | 帮助页 |
| --- | --- |
| 清华大学 TUNA | https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/ |
| 中科大 USTC | https://mirrors.ustc.edu.cn/help/ubuntu.html |
| 阿里云 | https://developer.aliyun.com/mirror/ubuntu |
| 腾讯云 | https://mirrors.cloud.tencent.com/guide/ubuntu.html |
| 华为云 | https://mirrors.huaweicloud.com/mirrorDocs/ubuntu/ |

在帮助页选择与你的 **版本代号** 一致的配置，复制后替换本地文件即可。

## 换源后自检

```bash
sudo apt update
```

成功时应能刷新索引且无明显 `404` / 代号不匹配错误。然后再安装软件验证：

```bash
apt policy bash
```

## 常见问题

| 现象 | 处理 |
| --- | --- |
| `404 Not Found` | 代号错误、镜像未同步该套件，或用了不适用的 ubuntu/ports |
| 校验失败 / NO_PUBKEY | 第三方源密钥问题；官方源一般检查是否改坏了 `Signed-By` |
| 仍然很慢 | 换另一镜像，或用「软件和更新」测速选择 |
| 改完想撤回 | 用 `.bak` 备份还原后 `apt update` |

## 小结

换源 = **备份 → 按版本改对文件与代号 → `apt update` 验证**。24.04 起优先改 `ubuntu.sources`；具体模板以清华 / 中科大等镜像站帮助页为准，不要死记过期片段。

软件源概念见 [Ubuntu 软件源](/ubuntu/ubuntu-software-repositories/)；装应用见 [Ubuntu 应用软件](/ubuntu/ubuntu-software/)。
