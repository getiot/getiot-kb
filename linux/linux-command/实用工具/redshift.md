---
sidebar_position: 9
slug: /redshift
---

# redshift 命令



## 介绍

Linux 中的 **redshift** 命令可以根据一天中的时间设置显示器的色温。它通过改变显示器配色和亮度来加强用户夜间坐在屏幕前的体验，减少由于显示屏对眼睛造成的压力。

启动时，用户可以根据经度和纬度来配置地理坐标，redshift 会根据太阳的位置平滑地调整屏幕地配色和亮度。通常，夜间的屏幕色温会调向偏暖色。这是因为 redshift 有两个默认的色温值（日间色温：6500K，夜间色温：4500K），中性温度值为 6500K，使用此值不会改变显示器的色温，将色温设置为高于此值的值会导致更多的蓝光，而设置较低的值会导致更多的红光。

redshift 通常不会预先安装，但可在大多数 Linux 发行版的默认仓库中找到。例如，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install redshift
```

**语法**：

```bash
redshift [-l LAT:LON | -l PROVIDER:OPTIONS] [-t DAY:NIGHT] [OPTIONS...]
```

**选项**：

- `-h`：显示此帮助信息。
- `-v`：详细输出。
- `-V`：显示程序版本。
- `-b DAY:NIGHT`：设置要应用的屏幕亮度（介于 0.1 和 1.0 之间）。
- `-c FILE`：从指定的配置文件加载设置。
- `-g R:G:B`：设置要应用的额外伽马校正。
- `-l LAT:LON`：设置当前的位置。
- `-l PROVIDER`：选择位置自动更新提供者（输入“list”以查看可用的提供者）。
- `-m METHOD`：用于设置色温的方法（键入“list”以查看可用方法）。
- `-o`：单次模式（不连续调节色温）。
- `-O TEMP`：单次手动模式（设置色温）。
- `-p`：打印模式（仅打印参数并退出）。
- `-P`：在应用新的色彩效果之前重置现有的伽玛斜线（gamma ramps）。
- `-x`：重置模式（从屏幕上移除调整）。
- `-r`：禁用色温之间的淡入淡出。
- `-t DAY:NIGHT`：指定色温调整的时间点（白天/晚上）。



## 示例

自动获取地理位置来调整屏幕色温

```bash
$ redshift 
正在尝试位置服务”geoclue2“。
正在使用服务”geoclue2“。
正在使用模式 ”randr“。
Waiting for initial location to become available...
位置：23.11 北纬, 113.25 东经

```





