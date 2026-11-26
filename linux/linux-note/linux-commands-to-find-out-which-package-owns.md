---
sidebar_position: 9
---

# Linux 查找命令对应的软件包



在 Linux 中，有些命令的名称软件包的名称是不一样的，或者一个软件包中包含有多个命令。有时候，我们需要确定某个命令来自于哪个软件包，以便于可以在其他机器上安装，或者寻找该软件包的源代码进行编译或者修改。

下面以 Ubuntu（Debian 系列）和 CentOS（RedHat 系列）发行版为例，介绍查询 Linux 命令来自哪个软件包的方法。



## Ubuntu

对于 Ubuntu 系统，可以使用 `apt search` 命令进行搜索，例如查找 ppstest：

```bash
$ sudo apt search ppstest
正在排序... 完成
全文搜索... 完成  
pps-tools/focal,now 1.0.2-1 amd64 [已安装]
  LinuxPPS support tools and headers
```

另外，也可以安装 `apt-file` 工具进行查询，可以获得更多信息，安装命令如下：

```bash
sudo apt-get install -y apt-file
```

安装完成后需要执行下面命令更新索引信息方可查询

```bash
sudo apt-file update
```

`apt-file` 命令的搜索语法如下：

```bash
apt-file search -x [pattern]
```

说明：`-x` 或 `--regexp` 选项后面可接正则表达式。

例如：查询 ppstest 命令所属软件包

```bash
$ apt-file search ppstest
pps-tools: /usr/bin/ppstest               
pps-tools: /usr/share/man/man8/ppstest.8.gz
```

如果以绝对路径进行查询，可以更加精确匹配

```bash
# 先确认命令的绝对路径
$ which ppstest 
/usr/bin/ppstest

# 再进行查询
$ apt-file search /usr/bin/ppstest
pps-tools: /usr/bin/ppstest
```

`apt-file` 命令除了查找可执行文件，还可以查找其他文件，例如配置文件

```bash
$ apt-file search apache2.conf
apache2: /etc/apache2/apache2.conf        
apache2-doc: /usr/share/doc/apache2-doc/examples/apache2/apache2.conf.gz
```



## CentOS

对于 CentOS 系统，可以通过 `yum provides` 命令查找，例如：

```bash
yum provides ppstest
```

或者使用 `rpm` 命令查询，例如：

```bash
rpm -qf ppstest
```

