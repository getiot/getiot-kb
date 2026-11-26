---
sidebar_position: 28
sidebar_label: LidarView 编译测试
authors: [luhuadong]
---

# LidarView 编译测试



## 构建步骤

```bash
mkdir LidarView
cd LidarView
```



```bash
git clone git@gitlab.kitware.com:LidarView/lidarview.git --recurse-submodules src
```



```bash
mkdir build
cd build
cmake ../src/Superbuild -GNinja -DCMAKE_BUILD_TYPE=Release
cmake --build . -j
```

如果需要编译 Debug 版本，则使用下面命令：

```bash
cmake ../src/Superbuild -GNinja -DCMAKE_BUILD_TYPE=Debug -DSUPERBUILD_ALLOW_DEBUG:BOOL=ON
```





运行

```bash
./install/bin/LidarView
```

可以看到如下界面：

![](https://static.getiot.tech/lidarview-430rc2-main-window.png)



## 目录结构

```bash
$ tree src -L 1
src
├── Application
├── CMakeLists.txt
├── LICENSE
├── LVCore
├── Plugins
├── README.md
├── RELEASES.md
├── Superbuild
└── version.txt
```



```bash
$ tree src -L 2
src
├── Application
│   ├── About.svg
│   ├── branding.cmake
│   ├── CMakeLists.txt
│   ├── Icons
│   ├── logo.icns
│   ├── SoftwareInformation
│   ├── Ui
│   ├── vvAboutDialog.ui
│   ├── vvFilters.xml
│   ├── vvMainWindow.cxx
│   ├── vvMainWindow.h
│   ├── vvMainWindow.ui
│   ├── vvResources.qrc
│   └── vvSources.xml
├── CMakeLists.txt
├── LICENSE
├── LVCore
│   ├── ApplicationComponents
│   ├── CI
│   ├── CMake
│   ├── CMakeLists.txt
│   ├── CONTRIBUTION.md
│   ├── DatasetIOPlugin
│   ├── Documentation
│   ├── LICENSE
│   ├── LidarPlugin
│   ├── LidarSlamPlugin
│   ├── Python
│   ├── PythonQtPlugin
│   ├── README.md
│   └── Utilities
├── Plugins
│   ├── HesaiPlugin
│   └── VelodynePlugin
├── README.md
├── RELEASES.md
├── Superbuild
│   ├── CMakeLists.txt
│   ├── lidarview-superbuild
│   ├── Projects
│   └── versions.cmake
└── version.txt
```



