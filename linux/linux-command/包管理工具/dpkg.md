---
sidebar_label: dpkg 命令
sidebar_position: 5
slug: /dpkg
---

# dpkg 命令 - 管理 Debian 软件包



## 介绍

**dpkg**（英文全拼：Debian package）命令是 Debian Linux 系统用来安装、创建和管理软件包的实用工具。它是 Debian 软件包管理器的基础，由伊恩·默多克创建于1993年。

从名称可以看出，dpkg 是专门为 Debian 开发的套件管理系统，方便软件的安装、更新及移除。实际上，所有源自 Debian 的 Linux 发行版都可以使用 dpkg 来管理软件包，例如 Ubuntu、Knoppix 等。

dpkg 本身是一个底层的工具，被用于安装、卸载和查询 .deb 软件包相关的信息。上层的工具，如 apt 则被用于从远程获取软件包以及处理复杂的软件包关系。

**语法**：

```shell
dpkg [option...] action
```

**选项**：

- `-i`, `--install` ：安装软件包。
- `-r`, `--remove` ：删除软件包。
- `-l`, `--list` ：显示已安装软件包列表。
- `-L`, `--listfiles` ：显示于软件包关联的文件。
- `-c` ：显示软件包内文件列表。
- `-?`, `--help` ：显示帮助信息。
- `--version` ：显示版本信息。



## 示例

安装软件包

```shell
dpkg -i <package-file>
dpkg -i helloworld_1.0.deb  # 以 helloworld_1.0.deb 软件包为例
```

安装一个目录（如 /usr/local/src）下面所有的软件包

```bash
dpkg -R /usr/local/src
```

释放软件包，但是不进行配置

```bash
dpkg --unpack <package-file>
```

重新配置和释放软件包

```bash
dpkg --configure <package-file>
```

卸载软件包（保留其配置信息）

```shell
dpkg -r <package-file>
```

卸载软件包（包括配置信息）

```bash
dpkg -P <package-file>
dpkg --purge <package-file>
```

列出已安装的软件包

```shell
dpkg -l
dpkg -l | grep helloworld # 在已安装的软件包中搜索 helloworld
```

列出软件包的内容（目录信息）

```shell
dpkg -c <package-file>
```

从软件包里面读取软件的信息

```bash
dpkg -A <package-file>
```

替代软件包的信息

```bash
dpkg --update-avail [Packages-file]
```

合并软件包信息

```bash
dpkg --merge-avail [Packages-file]
```

丢失所有的 Uninstall 的软件包信息

```bash
dpkg --forget-old-unavail
```

删除软件包的 Avaliable 信息

```bash
dpkg --clear-avail
```

查找只有部分安装的软件包信息

```bash
dpkg -C
```

比较同一个包的不同版本之间的差别

```bash
dpkg --compare-versions ver1 op ver2
```

创建一个 deb 文件

```bash
dpkg -b <directory> <package-file>
dpkg --build <directory> <package-file>
```

显示一个 deb 软件包的描述信息

```bash
dpkg -I <package-file>
```

报告指定软件包的状态信息（是否已安装）

```bash
dpkg -s <package-file>
```

显示一个软件包安装到系统里面的文件目录信息（该软件包必须已安装）

```bash
dpkg -L <package-file>
dpkg -L vim # 以 vim 为例
```

搜索指定软件包里面的文件（模糊查询）

```bash
dpkg -S <filename-search-pattern>
```



