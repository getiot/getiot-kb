---
sidebar_position: 18
---

# Ubuntu 安装最新版本 Cutecom



Cutecom 是 Linux 下一款比较常用的图形化串口调试工具，但是在 Ubuntu 20.04 LTS 系统中，APT 默认安装的是 0.30.3 版本，这是比较旧的一个版本，有一些不完善的地方。目前 Cutecom 最新的版本是 0.51.0，本文就来介绍如何在 Ubuntu 上安装最新版本的 Cutecom。 

下面是使用 apt 包管理器下载的命令：

```bash
sudo apt install cutecom
```

如果需要使用最新版本，最直接的做法是自行编译，Cutecom 是一个开源软件，目前托管在 [Gitlab](https://gitlab.com/cutecom/cutecom/) 上。



## 安装依赖

Cutecom 是一个基于 Qt 实现的程序，支持 CMake 编译，因此在编译之前需要安装一些必要的依赖。

```bash
sudo apt install apt-transport-https git dh-make build-essential 
                 autoconf autotools-dev qt5-default libssl-dev 
                 qt5keychain-dev devscripts
```

因为 Cutecom 用到了 Qtserial，所以还需要安装 libqt5serialport5 库。

```bash
apt install libqt5serialport5-dev
```



## 下载编译

使用 Git 下载 Cutecom 源代码：

```bash
git clone https://gitlab.com/cutecom/cutecom.git
```

切换到 cutecom 目录

```bash
cd cutecom
```

执行 cmake 生成 Makefile

```bash
cmake .
```

编译工程

```bash
make
```

编译完成后在同一目录下可以看到 cutecom 的可执行文件，执行 `./cutecom` 即可启动。

![Ubuntu 安装最新版本 Cutecom](https://static.getiot.tech/Cutecom-v5.png#center)



## 源码分析

Cutecom 是一个标准的 Qt 项目，很适合阅读其源码学习 Qt 程序的设计。

**项目文件 CuteCom.pro**

项目文件 CuteCom.pro 中定义了项目包含的 .cpp、.h 文件、.ui 后缀的界面文件和 resources.qrc 资源文件等。

```ini
QT       += core gui serialport

greaterThan(QT_MAJOR_VERSION, 4){
  QT += widgets network
  CONFIG += c++11
}

TARGET = CuteCom
TEMPLATE = app


SOURCES += main.cpp \
    mainwindow.cpp \
    settings.cpp \
    devicecombo.cpp \
    serialdevicelistmodel.cpp \
    statusbar.cpp \
    sessionmanager.cpp \
    datadisplay.cpp \
    datahighlighter.cpp \
    searchpanel.cpp \
    timeview.cpp \
    ctrlcharacterspopup.cpp \
    plugin.cpp \
    pluginmanager.cpp \
    macroplugin.cpp \
    macrosettings.cpp \
    netproxyplugin.cpp \
    netproxysettings.cpp \
    counterplugin.cpp \
    controlpanel.cpp

HEADERS  += mainwindow.h \
    controlpanel.h \
    settings.h \
    devicecombo.h \
    serialdevicelistmodel.h \
    statusbar.h \
    sessionmanager.h \
    datadisplay.h \
    datahighlighter.h \
    searchpanel.h \
    timeview.h \
    ctrlcharacterspopup.h \
    plugin.h \
    pluginmanager.h \
    macroplugin.h \
    macrosettings.h \
    netproxyplugin.h \
    netproxysettings.h \
    counterplugin.h


FORMS    += mainwindow.ui \
    controlpanel.ui \
    statusbar.ui \
    sessionmanager.ui \
    searchpanel.ui \
    macroplugin.ui \
    netproxyplugin.ui \
    macrosettings.ui \
    netproxysettings.ui \
    counterplugin.ui

RESOURCES += \
    resources.qrc

DISTFILES += \
    qt.astylerc

RC_ICONS = images/cutecom.ico
```

**启动入口 main.cpp**

可以看到，使用 `QCoreApplication::translate` 支持国际化，然后基于 `MainWindow` 创建主界面。

```cpp
#include "mainwindow.h"
// version.h is generated via cmake
// if you use qmake, please cp version.h.in to version.h
#include "version.h"
#include <QApplication>
#include <QCommandLineParser>
#include <QIcon>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QCommandLineParser parser;
    parser.setApplicationDescription(
        QCoreApplication::translate("main", "CuteCom - Serial Terminal %1").arg(CuteCom_VERSION));
    parser.addHelpOption();
    QCommandLineOption sessionOption(QStringList() << "s"
                                                   << "session",
                                     QCoreApplication::translate("main", "Open a named <session>"),
                                     QCoreApplication::translate("main", "session"));
    parser.addOption(sessionOption);

    // Process the actual command line arguments given by the user
    parser.process(a);
    QString session = parser.value(sessionOption);

    MainWindow w(0, session);
    QIcon appIcon;
    appIcon.addFile(QStringLiteral(":/images/terminal.svg"));
    w.setWindowIcon(appIcon);
    w.show();

    return a.exec();
}
```

这里就不一一分析了，感兴趣的小伙伴可以自行阅读 Cutecom 的源代码。



