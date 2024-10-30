---
sidebar_label: screen 命令
sidebar_position: 22
slug: /screen
---

# screen 命令 - 多窗口终端



## 介绍

**screen** 命令是一个多重视窗管理程序，这里的“视窗”是指一个全屏幕的文字模式画面。用户可以通过该软件同时连接多个本地或远程的命令行会话（通常是交互式 shell），并在其间自由切换。通常，在使用 [telnet](/linux-command/telnet) 登入主机或是使用老式的终端机时，才有可能用到 screen 程序。

使用前请确保你的系统上已经安装 screen 命令，如果未安装，可以参考下面安装方法：

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="apt" label="Debian/Ubuntu" default>

    ```bash
    sudo apt install screen
    ```
  </TabItem>
  <TabItem value="yum" label="CentOS/RHEL">
    ```bash
    sudo yum install screen
    ```
  </TabItem>
</Tabs>

**语法**：

```bash
screen [-opts] [cmd [args]]
screen -r [host.tty]
```

**选项**：

- `-A`：将所有的视窗都调整为目前终端机的大小。
- `-d`：将指定的 screen 作业离线。
- `-m`：即使目前已在作业中的 screen 作业，仍强制建立新的 screen 作业。
- `-r [session]`：恢复离线的 screen 作业。
- `-R`：先试图恢复离线的作业，若找不到离线的作业，即建立新的 screen 作业。
- `-s <shell>`：指定建立新视窗时，所要执行的 shell。
- `-S <sockname>`：指定 screen 作业的名称，使用 `<pid>.sockname` 代替 `<pid>.<tty>.<host>`。
- `-x`：恢复之前离线的 screen 作业。
- `-ls [match]`：显示目前所有的 screen 作业。
- `-list`：显示目前所有的 screen 作业。
- `-wipe`：检查目前所有的 screen 作业，并删除已经无法使用的 screen 作业。
- `-v`：显示版本信息。



## 示例

**创建窗口**

直接输入 screen，创建一个新的窗口：

```bash
screen
```

但是这样启动的 screen 会话没有名字，实践上推荐为每个 screen 会话取一个名字方便分辨，例如：

```bash
screen -S getiot
```

screen 启动后，会创建第一个窗口，也就是窗口 No. 0，并在其中打开一个系统默认的 shell（一般是 bash）。当执行 `screen` 命令之后，会立刻又返回到命令提示符，仿佛什么也没有发生似的，其实你已经进入 screen 的世界了。（执行 `exit` 退出 screen 窗口）

也可以在 screen 命令之后加入你喜欢的参数，使之直接打开你指定的程序，例如：

```bash
screen vi getiot.txt
```

screen 创建一个执行 `vi getiot.txt` 的单窗口会话，退出 vi 将退出该窗口/会话。

**查看窗口**

打开多个窗口后，可以使用快捷键 `Ctrl`+`A` 再按 `W` 列出当前所有窗口。如果使用文本终端，这个列表会列在屏幕左下角，如果使用 X 环境下的终端模拟器，这个列表会列在标题栏里。窗口列表一般像下面这样：

```bash
0$ bash  1-$ bash  2*$ bash  
```

这个例子中，我们开启了三个窗口，其中 `*` 号表示当前位于窗口 2，`-` 号表示上一次切换窗口时位于窗口 1。

**会话分离与恢复**

你可以不中断 screen 窗口中程序的运行而暂时断开（detach）screen 会话，并在随后时间重新连接（attach）该会话，重新控制各窗口中运行的程序。例如，我们打开一个 screen 窗口编辑 /tmp/getiot.txt 文件：

```bash
screen vi /tmp/getiot.txt
```

之后我们想暂时退出做点别的事情，比如出去散散步，那么在 screen 窗口键入 `Ctrl`+`A` 再按 `D`，screen 会给出 detached 提示：

```bash
[detached from 35507.getiot]
```

半个小时之后回来了，找到该 screen 会话：

```bash
$ screen -ls
There is a screen on:
	35507.getiot	(2024年02月23日 15时55分40秒)	(Detached)
1 Socket in /run/screen/S-rudy.
```

重新连接会话：

```shell
screen -r 35507
```

或者：

```bash
screen -r 35507.getiot
```

会话中的一切都还在。

当然，如果你在另一台机器上没有分离一个 screen 会话，就无从恢复会话了。这时可以使用下面命令强制将这个会话从它所在的终端分离，转移到新的终端上来：

**清除 dead 会话**

如果由于某种原因其中一个会话死掉了（例如人为杀掉该会话），这时 `screen -ls` 会显示该会话为 dead 状态。可以使用下面命令清除该会话：

```bash
screen -wipe
```

**关闭或杀死一个 screen 会话**

正常情况下，当你退出一个窗口中最后一个程序（通常是 bash）后，这个窗口就关闭了。另一个关闭窗口的方法是使用 `Ctrl`+`A` 键，然后按下 `K` 键，最后当提示你是否要杀死这个会话时按下 `Y` 键，这个快捷键会杀死当前的窗口，同时也将杀死这个窗口中正在运行的进程。

如果一个 screen 会话中最后一个窗口被关闭了，那么整个 screen 会话也就退出了，screen 进程会被终止。

