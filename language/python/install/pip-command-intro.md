---
sidebar_position: 3
slug: /pip-command-intro
---

# PIP 命令介绍

在 Python 的开发过程中，我们经常会用到各种第三方库，例如 `requests` 用于发送网络请求，`flask` 用于构建 Web 应用。而这些库并不会默认包含在 Python 的安装包中，因此我们需要使用 Python 的包管理工具——`pip`，来安装和管理这些库。

本文将为你介绍 `pip` 命令的基本使用方法、常见操作和一些进阶技巧。

:::tip

**`pip`** 是 Python 官方推荐的包管理工具，全称是“Pip Installs Packages”。它用于从 Python 包索引（[PyPI](https://pypi.org/)）下载安装第三方库，并可以方便地对其进行管理（如升级、卸载、查看信息等）。

:::

## PIP 命令语法

```bash
pip <命令> [选项]
```

### 常用命令

|     命令     | 说明                                                     |
| :----------: | -------------------------------------------------------- |
|  `install`   | 安装软件包。                                             |
|  `download`  | 下载软件包（不安装）。                                   |
| `uninstall`  | 卸载已安装的软件包。                                     |
|   `freeze`   | 以 `requirements.txt` 格式输出当前安装的所有包及其版本。 |
|  `inspect`   | 检查当前 Python 环境。                                   |
|    `list`    | 列出已安装的软件包。                                     |
|    `show`    | 显示指定软件包的信息。                                   |
|   `check`    | 验证已安装的软件包是否存在依赖冲突。                     |
|   `config`   | 管理 pip 的本地和全局配置。                              |
|   `search`   | 在 PyPI 中搜索软件包。（注意：某些版本中已弃用）         |
|   `cache`    | 检查和管理 pip 的缓存（wheel 缓存）。                    |
|   `index`    | 查看软件包索引源的相关信息。                             |
|   `wheel`    | 从依赖构建 `.whl` 安装包文件。                           |
|    `hash`    | 计算软件包压缩文件的哈希值。                             |
| `completion` | 用于命令自动补全的辅助命令。                             |
|   `debug`    | 显示用于调试的详细信息。                                 |
|    `help`    | 显示命令帮助信息。                                       |

### 通用选项

| 选项                          | 说明                                                         |
| ----------------------------- | ------------------------------------------------------------ |
| `-h, --help`                  | 显示帮助信息。                                               |
| `--debug`                     | 让未处理的异常向外抛出，而不是打印到标准错误。               |
| `--isolated`                  | 以隔离模式运行 pip，忽略环境变量和用户配置。                 |
| `--require-virtualenv`        | 要求 pip 只能在虚拟环境中运行，否则报错退出。                |
| `--python <python>`           | 使用指定的 Python 解释器运行 pip。                           |
| `-v, --verbose`               | 显示更详细的输出。该选项可重复使用（最多 3 次）。            |
| `-V, --version`               | 显示 pip 的版本并退出。                                      |
| `-q, --quiet`                 | 减少输出内容。该选项可重复使用（分别对应 WARNING、ERROR 和 CRITICAL 级别）。 |
| `--log <路径>`                | 将详细输出日志追加写入指定文件。                             |
| `--no-input`                  | 禁用交互式输入提示。                                         |
| `--keyring-provider <方式>`   | 启用通过 `keyring` 库查找凭据。支持 [auto, disabled, import, subprocess]（默认 auto）。 |
| `--proxy <代理>`              | 指定代理服务器，例如 `http://user:pass@proxy.server:port`。  |
| `--retries <次数>`            | 每次连接的最大重试次数（默认 5 次）。                        |
| `--timeout <秒>`              | 设置 socket 超时时间（默认 15 秒）。                         |
| `--exists-action <操作>`      | 当路径已存在时的默认操作：(s)切换、(i)忽略、(w)清除、(b)备份、(a)终止。 |
| `--trusted-host <主机名>`     | 将该主机（或主机:端口）标记为可信，即使它没有有效的 HTTPS 证书。 |
| `--cert <路径>`               | 指定 PEM 编码的 CA 证书路径，覆盖默认证书。详情参见 pip 的“SSL 证书验证”文档。 |
| `--client-cert <路径>`        | 指定客户端 SSL 证书路径，需包含私钥和证书（PEM 格式）。      |
| `--cache-dir <目录>`          | 将缓存数据存储到指定目录。                                   |
| `--no-cache-dir`              | 禁用缓存功能。                                               |
| `--disable-pip-version-check` | 禁止定期检查 PyPI 上是否有新版本的 pip（启用 `--no-index` 时默认启用此项）。 |
| `--no-color`                  | 禁用彩色输出。                                               |
| `--no-python-version-warning` | 静默处理关于 Python 即将停止支持的警告。                     |
| `--use-feature <功能>`        | 启用新功能，可能与旧版本不兼容。                             |
| `--use-deprecated <功能>`     | 启用即将弃用的功能，将在未来版本中删除。                     |



## PIP 使用示例

#### 1. 安装包

```bash
pip install 包名
```

例如：

```bash
pip install requests
```

可以指定版本安装：

```bash
pip install requests==2.31.0
```

安装多个包：

```bash
pip install flask pandas numpy
```

#### 2. 卸载包

```bash
pip uninstall 包名
```

例如：

```bash
pip uninstall requests
```

#### 3. 查看已安装的包

```bash
pip list
```

输出示例：

```bash
Package    Version
---------- -------
requests   2.31.0
flask      2.3.3
```

#### 4. 查看包的信息

```bash
pip show 包名
```

例如：

```bash
pip show requests
```

输出包括包的版本、作者、安装路径等信息。

#### 5. 升级包

```bash
pip install --upgrade 包名
```

例如：

```bash
pip install --upgrade flask
```

#### 6. 冻结当前环境依赖（生成 requirements.txt）

```bash
pip freeze > requirements.txt
```

这个命令将当前虚拟环境中的所有安装包及其版本输出到一个 `requirements.txt` 文件中，便于后续部署或共享项目环境。

#### 7. 从 requirements.txt 安装依赖

```bash
pip install -r requirements.txt
```

这是部署 Python 项目时常用的命令，用于一次性安装所有依赖项。

#### 8. 查看 pip 版本及升级 pip

查看当前 pip 版本：

```bash
pip --version
```

升级 pip：

```bash
python -m pip install --upgrade pip
```



