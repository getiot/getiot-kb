---
sidebar_position: 3
---

# GDB 可视化工具 gdbgui



**gdbgui** 是一款基于浏览器的 gdb 可视化工具，后台使用 Python 语言编写。gdbgui 可作为 GDB 调试器的前端，可用于 C/C++、Go、Rust 等项目，提供打断点、单步调试、查看堆栈等功能。

![](https://static.getiot.tech/gdbgui_animation.gif)



## 安装 gdbgui

官方提供了多种安装 gdbgui 的方式，下面将逐一介绍。在开始之前，你需要先执行下面命令安装依赖。

Ubuntu/Debian 系统

```bash
sudo apt-get install gdb python3
```

macOS 系统

```bash
brew install python3
brew install gdb --with-python --with-all-targets
```



### 使用 pipx 安装

```bash
python3 -m pip install --user pipx
python3 -m userpath append ~/.local/bin
```



```bash
pipx install gdbgui
```



```bash
$ pipx install gdbgui
  installed package gdbgui 0.15.1.0, installed using Python 3.8.10
  These apps are now globally available
    - gdbgui
done! ✨ 🌟 ✨
```





### 使用 pip 安装



```bash
pip install gdbgui
```



```bash
pip install --upgrade gdbgui
```





### 直接下载安装

Download and run the binary executable for your system from [GitHub Releases](https://github.com/cs01/gdbgui/releases).





## 使用示例



## 相关链接

- 项目官网：[https://gdbgui.com](https://gdbgui.com)
- Github 仓库：[https://github.com/cs01/gdbgui](https://github.com/cs01/gdbgui)



源码里面有个example目录，下面有很多例子。

