---
sidebar_position: 2
---

# R 语言开发环境



本文将介绍如何安装 R 语言开发环境以及 RStudio 集成开发环境。



## 安装

要安装 R，请转到 [https://cloud.r-project.org](https://cloud.r-project.org) 并下载适用于 Windows、Mac 或 Linux 的最新版本的 R。

下载并安装 R 后，你就可以在计算机上运行 R。

如果你和我一样使用 Ubuntu，那么还可以参考以下方法进行安装。

### Ubuntu

下面以 Ubuntu 为例，演示如何安装 R 语言开发环境。

注意：当前 R 4.2. 版本的软件包可用于大多数稳定的 Ubuntu 桌面版本，直到它们的正式生命周期结束为止。但是，仅完全支持最新的长期支持（LTS）版本。截至2022年5月2日，支持的版本包括

- Jammy Jellyfish (22.04, amd64 only)
- Impish Indri (21.10, amd64 only),
- Focal Fossa (20.04; LTS and amd64 only),
- Bionic Beaver (18.04; LTS), and
- Xenial Xerus (16.04; LTS).

打开终端，依次执行下面命令，配置关于 CRAN 的 R 二进制文件信息。

```bash
# 更新软件包索引
sudo apt update -qq

# 安装两个必要的工具
sudo apt install --no-install-recommends software-properties-common dirmngr

# 添加签名密钥
# 要验证密钥，请运行 gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc

# 添加来自 CRAN 的 R 4.0 仓库
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
```

这里我们用 `lsb_release -cs` 来自动匹配你的 Ubuntu 系统版本，返回的字段是 “jammy”, “impish”, “focal”, “bionic”, … 中的一个。

然后运行下面命令，开始安装 R 及其依赖。

```bash
sudo apt install --no-install-recommends r-base
```



## 测试

在终端输入 `R` 回车，即可进入 R 语言环境，如下所示。

```bash
$ R

R version 4.2.2 Patched (2022-11-10 r83330) -- "Innocent and Trusting"
Copyright (C) 2022 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R是自由软件，不带任何担保。
在某些条件下你可以将其自由散布。
用'license()'或'licence()'来看散布的详细条件。

R是个合作计划，有许多人为之做出了贡献.
用'contributors()'来看合作者的详细情况
用'citation()'会告诉你如何在出版物中正确地引用R或R程序包。

用'demo()'来看一些示范程序，用'help()'来阅读在线帮助文件，或
用'help.start()'通过HTML浏览器来看帮助文件。
用'q()'退出R.

>
```

在此交互命令窗口，你可以输入一些数字运算式进行简单的测试，例如：

```R showLineNumbers
> 12+13
[1] 25
```

测试完成后输入 `q()` 退出。

```bash
> q()
```



## 集成开发环境

对于初学者来说，安装完 R 就可以使用了。但是如果你需要经常使用 R，那么可能需要一个集成开发环境（IDE）。

对 R 来说最常用的 IED 是 RStudio，它支持 Windows、Mac、Linux 等平台，提供桌面版和服务器版两种版本，并且支持商业付费版和开源免费版（AGPL v3）两种 License。你可以通过 [https://posit.co/downloads/](https://posit.co/downloads/) 网页下载并安装 RStudio，通常我们选择免费的 RStudio Desktop 即可。

下图是 Ubuntu 系统启动的 RStudio 主界面：

![](https://static.getiot.tech/RStudio-for-Ubuntu.png#center)

