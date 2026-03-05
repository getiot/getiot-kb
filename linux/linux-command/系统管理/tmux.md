---
sidebar_label: tmux 命令
sidebar_position: 23
slug: /tmux
---

# Linux tmux 命令 - 终端复用器



## 介绍

**Tmux** 是一款终端复用工具，其核心作用是解绑会话与窗口，实现断网重连、会话保持、多窗格分屏及多窗口管理。它允许在单界面中并行执行多个任务，且即使关闭终端窗口，后台程序依然会持续运行，特别适合远程服务器管理和高效率开发。

**核心概念**：

1. **Session**（会话）：一个具体的任务环境。
2. **Window**（窗口）：会话中的独立标签页。
3. **Pane**（窗格）：窗口中的分屏显示。

**主要用途**：

- **后台任务运行与恢复**：SSH 远程连接服务器时，如果因网络中断或电脑关机，传统终端上的程序会终止。Tmux 允许你在会话中运行程序，即使掉线，任务也会持续在后台运行，下次重新登录即可通过 `tmux attach` 恢复之前的环境，不会丢失工作进度。
- **终端分屏与多窗口操作**：一个窗口可以划分为多个面板（Pane），在一个屏幕上同时查看多个日志、代码或命令输出，提高多任务处理效率。
- **会话管理**：可以创建多个命名会话，快速切换不同的工作场景（例如，一个会话跑代码，一个会话看日志），不再需要打开多个终端窗口。
- **结对编程与演示**：允许不同用户同时接入同一个 Tmux 会话，方便进行远程结对编程或展示工作内容。

**安装**：

使用前请确保你的系统上已经安装 tmux 命令，如果未安装，可以参考下面安装方法：

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="apt" label="Debian/Ubuntu" default>

    ```bash
    sudo apt install tmux
    ```
  </TabItem>
  <TabItem value="yum" label="CentOS/RHEL">
    ```bash
    sudo yum install tmux
    ```
  </TabItem>
</Tabs>

**语法**：

```bash
tmux [options] [command [flags]]
```

**选项**：

- `-2`：强制 tmux 假定终端支持 256 色。
- `-C`：以控制模式启动。
- `-c shell-command`：使用默认 Shell 执行 shell-command。如有必要，将启动 tmux 服务器以获取 default-shell 选项。当 tmux 用作登录 Shell 时，此选项用于与 sh 兼容。
- `-f file`：指定替代配置文件。默认情况下，tmux 会先加载系统配置文件（如果存在，位于 /etc/tmux.conf），然后查找用户配置文件（位于 ~/.tmux.conf）。
- `-L socket-name`：tmux 将服务器 socket 存储在 `TMUX_TMPDIR` 环境变量指定的目录下，若该变量未设置则存储在 /tmp 下。默认 socket 名为 default。此选项允许指定不同的 socket 名称，从而允许运行多个独立的 tmux 服务器。与 `-S` 不同，此处不需要指定完整路径：所有 socket 均创建在同一目录中。
- `-l`：行为如同登录 Shell。此标志当前无效，仅用于当 tmux 用作登录 Shell 时与其他 Shell 保持兼容。
- `-S socket-path`：指定服务器 socket 的完整替代路径。如果指定了 `-S`，则不使用默认 socket 目录，且任何 `-L` 标志都将被忽略。
- `-u`：即使 `LC_ALL`、`LC_CTYPE` 或 `LANG` 中首个被设置的环境变量不包含 "UTF-8" 或 "UTF8"，也向终端写入 UTF-8 输出。
- `-v`：请求详细日志记录。
- `-V`：显示 tmux 版本。



## 常用命令和快捷键

进入 Tmux 终端界面后，所有操作都需要先按下前缀键（默认是 `Ctrl+b`），然后输入命令键。

#### 会话管理

| 命令/快捷键             | 说明                             |
| :---------------------- | :------------------------------- |
| `tmux new -s <name>`    | 创建名为 name 的新会话           |
| `Ctrl+b :new<回车>`     | 启动新会话                       |
| `Ctrl+b d`              | 分离当前会话（会话继续后台运行） |
| `tmux ls`               | 列出所有会话                     |
| `tmux attach -t <name>` | 重新连接到指定会话               |
| `Ctrl+b $`              | 重命名当前会话                   |
| `Ctrl+b s`              | 切换会话                         |

#### 窗口管理

| 命令/快捷键       | 说明                 |
| :---------------- | :------------------- |
| `Ctrl+b c`        | 创建新窗口           |
| `Ctrl+b &`        | 关闭当前窗口         |
| `Ctrl+b n`        | 切换到下一个窗口     |
| `Ctrl+b p`        | 切换到上一个窗口     |
| `Ctrl+b <number>` | 切换到指定编号的窗口 |
| `Ctrl+b ,`        | 重命名当前窗口       |

#### 面板管理

| 命令/快捷键      | 说明                |
| :--------------- | :------------------ |
| `Ctrl+b %`       | 垂直分割当前面板    |
| `Ctrl+b "`       | 水平分割当前面板    |
| `Ctrl+b <arrow>` | 在面板间移动焦点    |
| `Ctrl+b x`       | 关闭当前面板        |
| `Ctrl+b z`       | 最大化/恢复当前面板 |
| `Ctrl+b Space`   | 切换面板布局        |



## 配置 tmux

tmux 的配置文件位于 `~/.tmux.conf`，你可以在这里自定义 tmux 的快捷键、颜色和布局。如果文件不存在，你可以手动创建它。另外，系统级配置则位于 `/etc/tmux.conf`，我们推荐优先使用用户配置文件 `~/.tmux.conf`。

以下是一些常用配置项：

```bash showLineNumbers
# 设置前缀键为 Ctrl+a（比默认的 Ctrl+b 更容易按）
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# 启用鼠标支持（可以鼠标点击切换面板/窗口）
set -g mouse on

# 设置状态栏颜色
set -g status-bg black
set -g status-fg white

# 设置面板边框颜色
set -g pane-border-style fg=green
set -g pane-active-border-style fg=red

# 设置窗口从1开始编号（默认是0）
set -g base-index 1
setw -g pane-base-index 1
```

修改配置后，可以按 `Ctrl+b :` 然后输入 `source-file ~/.tmux.conf` 重新加载配置。



## 示例

创建一个 tmux 会话：

```bash
tmux
```

此时你已经进入 tmux 会话，屏幕底部通常会出现一个状态栏，例如 `[0] 0:bash*`。

分离 tmux 会话：

```bash
Ctrl + b
然后按 d
```

此时 tmux 会话在后台运行，如果在该会话启动了程序，程序会继续执行。

重新连接 tmux：

```bash
tmux attach
```

如果有多个会话，可以指定编号：

```bash
tmux attach -t 0
```

查看当前 tmux 会话：

```bash
tmux ls
```

关闭会话，可在 tmux 里执行：

```bash
Ctrl + d
# 或直接输入：
exit
```

