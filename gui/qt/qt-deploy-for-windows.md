---
sidebar_position: 35
draft: true
---

# Qt 程序打包发布（Windows）



工具

- windeployqt
- Enigma Virtual Box
- **NSIS**
- Dependency walker 库依赖分析工具



步骤

- 打开一个 QT 程序，编译 Release 版本
- 打开 Release 目录，找到里面的 exe 程序
- 将 exe 文件拷贝到一个单独的文件夹
- 在开始菜单中，打开 QT 命令行窗口
- 切换到 exe 文件目录，执行 `windeployqt 程序名` 命令将所需的库文件全都拷贝到 exe 程序所在的目录
- 此时，在当前目录下是可以点击运行 exe 程序的，说明库文件都已经拷贝到当前目录下了。这时就可以执行将这一堆文件进行打包的操作了，需要使用Enigma Virtual Box 工具。



