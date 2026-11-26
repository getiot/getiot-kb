---
sidebar_position: 27
sidebar_label: LidarView 软件分析
authors: [luhuadong]
---

# LidarView 软件分析



## 关键组件

LidarView 应用程序通过 C++ 的 Qt 和 Python 来实现。PythonQt 库用于 Python 来访问 C++ 层。应用的主要逻辑在 applogic.py 实现。Python 代码在运行时，通过使用 Qt 的 uitools 库来加载使用者的接口（.ui files）。Qt 编辑器可以用来编辑 .ui 文件。该 VeloView 应用程序可以使用 Python 和 .UI 文件进行扩展。

LidarView 的源代码主要是 VTK 类和 Qt 类的混合。在源代码的文件中 VTK 类（具有前缀 vtk）中不包含任何 Qt 的依赖。Qt 类（具有前缀 vv 或者 pq）依赖于 VTK、Qt 和 ParaView 的 Qt 库。在 LidarView 中，VTK 类的核心被编译程一个插件库，名字叫做 libVelodyneHDLPlugin，它可以被加载到 ParaView 中。LidarView app 是用过 C++ Qt 类和 Python 代码实现的。Python 代码主要功能主要在 applogic.py 中实现。



### ParaView插件

libVelodyneHDLPlugin 库依赖于 VTK、ParaView、Qt、PythonQt、Boost 和 libpcap。通过使用 ParaView 4.0，这个插件可以被加载到 ParaView 应用中。构建可以指定特定 Boost 库的静态版，所以该插件的依赖是 libpcap 和 PythonQt 库，这一点 ParaView 好。

在 Windows 下，只要 libpcap 和 PythonQt 在同一目录下，这个插件便可被加载。在 Mac 下，你应该使用 install_name_tool 来解决这些依赖库的位置，它是相对与 @loader_path（加载位置），然后只要将 libpcap 和 PythonQt 库文件相对放到 libVelodyneHDLPlugin 库中即可。

在 ParaView 中，Velodyne pcap 阅读和 Velodyne 网络源插件都在 Sources 菜单中被使能。the Velodyne pcap reader and Velodyne network source plugin are available in the Sources menu.

### VTK readers

VeloView 和 ParaView 的插件 VelodyneHDL 包含了阅读器/来源。Velodyne pcap 阅读器是在 vtkVelodyneHDLReader.{cxx,h} 中用 C++ 来实现的。当读取 pcap 文件时，阅读器先扫描整个文件，寻找帧分割（当方位角从 360 溢出到 0 度）。该位置会被记录，以便于以后跳到对应帧来寻找相应数据。

网络来源阅读器接受来自 Velodyne 传感器的 UDP 数据包。Velodyne 传感器使用了 Boost 的 asio 库。网络来源在 vtkVelodyneHDLSource.{cxx,h}. 中被实现。源以生产者/消费者模型管理多个线程，并使用 vtkVelodyneHDLReader 的一个实例来将数据包转换为 VTK 点云数据。



### Qt



### PythonQt

参考链接：[ImportError:No module named PythonQt #628](https://github.com/RobotLocomotion/director/issues/628)

PythonQt 不是一个标准的 Python 模块。

### ParaView



### VTK



### PCL



### Superbuild



## submodule



| 自仓库               | 简称   | 作用               |
| -------------------- | ------ | ------------------ |
| lidarview-superbuild | lv-sb  | 构建系统           |
| lidarview-core       | LVCore | 核心模块           |
| Plugins/xxx          |        | 点云数据协议解释器 |







## 构建系统

### 根 CMakeLists.txt 文件

```cmake
cmake_minimum_required(VERSION 3.20.3 FATAL_ERROR)
project(LidarView)
#Thanks to ExternalProject CMAKE_SOURCE_DIR will correctly be the same as this PROJECT_SOURCE_DIR
# 感谢 ExternalProject CMAKE_SOURCE_DIR 将正确地与此 PROJECT_SOURCE_DIR 相同

# add path to get all the needed modules used to config Lidarview
# 添加路径以获取用于配置 Lidarview 所需的所有模块
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/LVCore/CMake")

# Include branding.cmake
# 包括 branding.cmake
include(Application/branding.cmake)

# we include the module that allow us to configure the Lidarview project
# 我们包含允许我们配置 Lidarview 项目的模块
include(SetupLidarviewProject)

# custom code here
# 自定义代码在这里
add_subdirectory(Plugins/VelodynePlugin)

# Application
# 应用程序
add_subdirectory(Application)

# Must be invoked Last
include(FinalizeLidarViewProject)
```



### LVCore/CMake

```bash
LVCore/CMake
├── CheckBuildType.cmake                # 
├── FinalizeLidarViewProject.cmake      # 
├── GenerateConfiguration.cmake.in      # 
├── Git.cmake                           # 
├── OutputCMakeCacheLog.cmake           # 
├── ParaViewDetermineVersion.cmake      # 
├── PythonModuleInstaller.cmake         # 
├── SetCompilationFlags.cmake           # 
├── SetupDoxygenDocumentation.cmake     # 
├── SetupLidarviewProject.cmake         # 
├── SetupOutputDirs.cmake               # 
├── SetupWindowsCustomInstall.cmake     # 
└── scripts
    ├── lidarview.osx-rpath.cmake       # 
    └── lidarview.unix-zlib-link.cmake  # 
```





## Plugins

### VelodynePlugin

```bash
velodyneplugin
├── CMakeLists.txt
└── Plugin
    ├── CMakeLists.txt
    ├── paraview.plugin
    └── VelodyneLidar
        ├── CalibrationsFiles
        ├── CMakeLists.txt
        ├── LICENSE
        ├── PlaneFitter
        ├── StandAloneTools
        ├── Testing
        ├── VelodyneHDLPositionPacketInterpreter
        ├── VelodynePacketInterpreter
        └── vtk.module
```



### HesaiPlugin

```bash
HesaiPlugin/
├── CMakeLists.txt
├── HesaiPacketInterpreter
│   ├── HesaiPacketInterpreter.xml
│   ├── laser_ts.cxx
│   ├── laser_ts.h
│   ├── PacketFormat.h
│   ├── vtkHesaiPacketInterpreter.cxx
│   └── vtkHesaiPacketInterpreter.h
└── Utilities
    └── Hesai_parser.lua
```



|                        |      |      |
| ---------------------- | ---- | ---- |
| HesaiPlugin            |      |      |
| HesaiLidar_General_SDK |      |      |
|                        |      |      |



```bash
rudy@Latitude-3420:~/LidarView/src/Plugins/HesaiPlugin$ tree -L 3
.
├── CMakeLists.txt
├── Plugin    # 插件代码
│   ├── CMakeLists.txt
│   ├── HesaiLidar
│   │   ├── CalibrationFiles
│   │   ├── CMakeLists.txt
│   │   ├── HesaiGeneralPacketInterpreter
│   │   ├── HesaiLidar_General_SDK
│   │   ├── HesaiPacketInterpreter
│   │   └── vtk.module
│   └── paraview.plugin
└── Utilities  # 测试工具
    └── Hesai_parser.lua
```





### AsensingPlugin

添加子仓库

```bash
git submodule add git@github.com:luhuadong/AsensingPlugin.git Plugins/AsensingPlugin
```



运行 Lua 脚本（不是这样运行的，要放到 Wireshark 里运行）

```bash
$ lua Asensing_parser.lua 
lua: Asensing_parser.lua:3: attempt to call a nil value (global 'Proto')
stack traceback:
	Asensing_parser.lua:3: in main chunk
	[C]: in ?
```



```
Make sure that you declared the function higher up in the script than when it's called so in other words make sure local function Proto() is above when you do Proto() in the script

确保在脚本中将函数声明到比调用时更高的位置，换句话说，确保在脚本中执行 Proto() 时，本地函数 Proto() 在上面
```



### ExamplePlugin

```bash
Plugins/ExamplePlugin/
├── CMakeLists.txt
├── ExampleFormat.h
├── ExampleLidarPacketInterpreter.xml
├── README.md
├── vtkExamplePacketInterpreter.cxx
└── vtkExamplePacketInterpreter.h
```



```bash
Plugins/AsensingPlugin/
├── CMakeLists.txt
├── Plugin
│   ├── AsensingLidar
│   │   ├── AsensingGeneralPacketInterpreter
│   │   │   ├── AsensingGeneralPacketInterpreter.xml
│   │   │   ├── vtkAsensingGeneralPacketInterpreter.cxx
│   │   │   └── vtkAsensingGeneralPacketInterpreter.h
│   │   ├── AsensingPacketInterpreter
│   │   │   ├── AsensingPacketFormat.h
│   │   │   ├── AsensingPacketInterpreter.xml
│   │   │   ├── laser_ts.cxx
│   │   │   ├── laser_ts.h
│   │   │   ├── vtkAsensingPacketInterpreter.cxx
│   │   │   └── vtkAsensingPacketInterpreter.h
│   │   ├── CalibrationFiles
│   │   │   ├── Neptune128.csv
│   │   │   ├── NeptuneL30.csv
│   │   │   └── NeptuneXT.csv
│   │   ├── CMakeLists.txt
│   │   └── vtk.module
│   ├── CMakeLists.txt
│   └── paraview.plugin
└── Utilities
    └── Asensing_parser.lua
```





## 入口函数

```bash
$ strings ./install/bin/LidarView | grep main
__libc_start_main
creating main window `vvMainWindow`
LidarView_main.cxx
_ZNK4QUrl14topLevelDomainE6QFlagsINS_25ComponentFormattingOptionEE
_ZSt9remainderee
_ZSt9remainderff
topLevelDomain
_GLOBAL__sub_I_LidarView_main.cxx
/home/rudy/workspace/Projects/LidarView/LidarView/build/lidarview-superbuild/common-superbuild/lidarview/build/Application/LidarView_main.cxx
nb_remainder
nb_inplace_remainder
_GLOBAL__sub_I_LidarView_main.cxx
main
__libc_start_main@@GLIBC_2.2.5
```

LidarView_main.cxx 文件是自动生成的，位于 build 目录，具体路径为：

lidarview-superbuild/common-superbuild/lidarview/build/Application/LidarView_main.cxx

```bash
(gdb) r
Starting program: /home/rudy/workspace/Projects/LidarView/LidarView/build/install/bin/LidarView 
l
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Breakpoint 1, main (argc=32767, argv=0x5555555d11a0 <qt_resource_struct>)
    at /home/rudy/workspace/Projects/LidarView/LidarView/build/lidarview-superbuild/common-superbuild/lidarview/build/Application/LidarView_main.cxx:61
61	{
(gdb) l
56	#if !defined(__APPLE__) && !defined(_WIN32)
57	#include <cstring>
58	#endif
59	
60	int main(int argc, char* argv[])
61	{
62	  // Workaround for issue 19751
63	#if QT_VERSION < QT_VERSION_CHECK(5, 14, 0)
64	  vtksys::SystemTools::PutEnv("QT_AUTO_SCREEN_SCALE_FACTOR=0");
65	#endif
(gdb) n
```

启动 Qt 线程

```cpp
QApplication qtapp(argc, argv);
```



### vvMainWindow

- 头文件：Application/vvMainWindow.h
- 源文件：Application/vvMainWindow.cxx
- UI 文件：Application/vvMainWindow.ui

```python
def getMainWindow():
    return findQObjectByName(QtGui.QApplication.topLevelWidgets(), 'vvMainWindow')
```

Application/Ui/python/lidarview/applogic.py



## 解释器实现

两个解释器

- vtkAsensingGeneralPacketInterpreter
- vtkAsensingPacketInterpreter





HesaiPacketInterpreter.xml

```xml
<ServerManagerConfiguration>
  <ProxyGroup name="LidarPacketInterpreter">
    <SourceProxy name="HesaiPacketInterpreter"
         class="vtkHesaiPacketInterpreter"
         label="Hesai Packet Interpreter"
         base_proxygroup="base_LidarPacketInterpreter_g"
         base_proxyname="base_LidarPacketInterpreter">

    </SourceProxy>
  </ProxyGroup>
</ServerManagerConfiguration>
```



HesaiGeneralPacketInterpreter.xml

```xml
<ServerManagerConfiguration>
  <ProxyGroup name="LidarPacketInterpreter">
    <SourceProxy name="HesaiGeneralPacketInterpreter"
         class="vtkHesaiGeneralPacketInterpreter"
         label="Hesai General Packet Interpreter"
         base_proxygroup="base_LidarPacketInterpreter_g"
         base_proxyname="base_LidarPacketInterpreter">

    </SourceProxy>
  </ProxyGroup>
</ServerManagerConfiguration>
```



### 数据流

```bash
vtkHesaiPacketInterpreter::IsLidarPacket
vtkLidarPacketInterpreter::IsValidPacket
PacketConsumer::HandleSensorData
vtkLidarPacketInterpreter::ProcessPacketWrapped
```



```cpp
bool vtkLidarPacketInterpreter::IsValidPacket(unsigned char const * data, 
                                              unsigned int dataLength)
{
  return this->IsLidarPacket(data, dataLength);
}
```



```cpp
void PacketConsumer::ThreadLoop()
{
  NetworkPacket* packet = nullptr;
  this->Stream->GetInterpreter()->ResetCurrentData();
  while (this->Packets->dequeue(packet))
  {
    this->HandleSensorData(packet);
    delete packet;
  }
}
```



```cpp
void vtkLidarPacketInterpreter::ProcessPacketWrapped(unsigned char const * data,
                                                  unsigned int dataLength,
                                                  double PacketNetworkTime_s)
{
  // if the framing Method is the NetworkPacketTime one
  // We check if the frame has te be split.
  if(this->IsLidarPacket(data, dataLength) && this->FramingMethod == FramingMethod_t::NETWORK_PACKET_TIME_FRAMING)
  {
    auto currentFrameNumber = static_cast<unsigned long long>(PacketNetworkTime_s / this->FrameDuration_s);
    if (this->LastNetworkTimeFrameNumber != 0 // do not frame on first call of this function
        && currentFrameNumber != this->LastNetworkTimeFrameNumber) // new frame found
    {
      this->SplitFrame(false, FramingMethod_t::NETWORK_PACKET_TIME_FRAMING);
    }
    this->LastNetworkTimeFrameNumber = currentFrameNumber;
  }

  // Interpreter the packet
  this->ProcessPacket(data, dataLength);
}
```



### 识别新帧

```cpp
if(frameInfo->IsNewFrame(1, currentBlock.GetAzimuth()))
{
    this->SplitFrame();
}
```



### 绘制点云

```cpp
void vtkHesaiPacketInterpreter::ProcessPacket(unsigned char const* data,
                                              unsigned int dataLength)
{
    for (int blockID = start_block; blockID < end_block; blockID++)
    {
        if(frameInfo->IsNewFrame(1, currentBlock.GetAzimuth()))
        {
            this->SplitFrame();
        }
        
        for (int laserID = 0; laserID < PANDAR128_LASER_NUM; laserID++)
        {
            double x = xyDistance * this->Sin_all_angle[azimuthIdx];
            double y = xyDistance * this->Cos_all_angle[azimuthIdx];
            double z = distance * this->Sin_all_angle[static_cast<int>(pitch * 100 + 0.5)];
            double intensity = currentBlock.units[laserID].GetIntensity();
            
            this->Points->SetPoint(current_pt_id, x, y, z);    /* 点 */
            
            TrySetValue(this->PointsX, current_pt_id, x);
            TrySetValue(this->PointsY, current_pt_id, y);
            TrySetValue(this->PointsZ, current_pt_id, z);
            
            TrySetValue(this->LaserID, current_pt_id, laserID);
            TrySetValue(this->Intensities, current_pt_id, intensity);
            TrySetValue(this->Timestamps, current_pt_id, timestamp);
            TrySetValue(this->Distances, current_pt_id, distance);
            current_pt_id++;
        }
    }
}
```

SetPoint 函数

/usr/include/vtk-7.1/vtkPoints.h

```cpp
inline void vtkPoints::SetPoint(vtkIdType id, double x, double y, double z)
{
  double p[3] = { x, y, z };
  this->Data->SetTuple(id, p);
}
```



lidarview-superbuild/common-superbuild/paraview/src/VTK/Common/Core/vtkSmartPointer.h

lidarview-superbuild/common-superbuild/paraview/src/VTK/Common/Core/vtkPoints.h

```cpp
T* operator->() const noexcept { return static_cast<T*>(this->Object); }
```



```
double p[3] = { x, y, z };
{0.74944066751798921, 3.823463166943768, 0.90524524754434355}
```





```cpp
struct HesaiSpecificFrameInformation : public SpecificFrameInformation
{
  // Declare 2 LastAzimuth values, one is used for Preprocess Packet
  // The other is used for ProcessPacket
  double LastAzimuth[2] = {-1, -1};

  bool IsNewFrame(int index, double newAzimuth)
  {
  }
}
```





## 实现细节

### vtkLidarPacketInterpreter





### 网络端口

Application/Ui/Widgets/vvCalibrationDialog.cxx

```cpp
void vvCalibrationDialog::setDefaultConfiguration()
{
  const double defaultSensorValue = 0.00;
  const int minAllowedPort = 1024;   // The port between 0 and 1023 are reserved
  const int defaultLidarPort = 2368; // The port between 0 and 1023 are reserved
  const int defaultGpsPort = 8308;   // There is 16 bit to encode the ports : from 0 to 65535
  const QString defaultIpAddress = "127.0.0.1"; // Local host
    
}
```



```cpp
int vvCalibrationDialog::lidarPort() const
{
  return this->Internal->LidarPortSpinBox->value();
}
```



```cpp
QString vvCalibrationDialog::ipAddressForwarding() const
{
  return this->Internal->ipAddresslineEdit->text();
}
```



Application/Ui/lqUpdateCalibrationReaction.cxx

```cpp
void lqUpdateCalibrationReaction::UpdateCalibration(pqPipelineSource* & lidarSource,
                                                    pqPipelineSource* & posOrSource,
                                                    const vvCalibrationDialog& dialog)
{
  // Set the Network Part
  lqUpdateCalibrationReaction::setNetworkCalibration(lidarProxy, dialog.lidarPort(), 
                                                     dialog.lidarForwardingPort(),
                                                     dialog.isForwarding(), 
                                                     dialog.ipAddressForwarding(),
                                                     dialog.isCrashAnalysing(), 
                                                     dialog.isEnableMultiSensors());
}
```

setNetworkCalibration 函数

```cpp
void lqUpdateCalibrationReaction::setNetworkCalibration(vtkSMProxy * proxy, double listenningPort,
     double forwardingPort, bool isForwarding, QString ipAddressForwarding, bool isCrashAnalysing,
     bool multiSensors)
{
  if(IsStreamProxy(proxy))
  {
    vtkSMPropertyHelper(proxy, "ListeningPort").Set(listenningPort);
    vtkSMPropertyHelper(proxy, "IsCrashAnalysing").Set(isCrashAnalysing);

    if(isForwarding)
    {
      vtkSMPropertyHelper(proxy, "IsForwarding").Set(forwardingPort);
      vtkSMPropertyHelper(proxy, "IsForwarding").Set(isForwarding);
      vtkSMPropertyHelper(proxy, "ForwardedIpAddress").Set(ipAddressForwarding.toStdString().c_str());
    }
  }
  // We only select the reading port if the multisensor is enable
  // To avoid displaying nothing with one pcap in case the port is wrong
  else if(IsLidarReaderProxy(proxy) && multiSensors)
  {
    vtkSMPropertyHelper(proxy, "LidarPort").Set(listenningPort);
  }
  else if(IsPositionOrientationReaderProxy(proxy) && multiSensors)
  {
    vtkSMPropertyHelper(proxy, "PositionOrientationPort").Set(listenningPort);
  }
  proxy->UpdateVTKObjects();
}
```



### 校准文件

Sensor Calibration 选框

Sensor Calibration -> ListWidget

保存列表：LidarPlugin/CalibrationFileDialog/Files



### HesaiLidar



## 界面窗口

### vvCalibrationDialog.ui

LidarView/src/Application/Ui/Widgets/vvCalibrationDialog.ui

按钮

```
interpreterRadio_hesai
```





### vvSelectFramesDialog.ui





### vvCropReturnsDialog.ui



## PyQt

在 Application/Ui/python/lidarview/ 目录下

```bash
Application/Ui/python$ tree lidarview/
lidarview/
├── aboutDialog.py           # About LidarView 对话框
├── applogic.py              # 
├── gridAdjustmentDialog.py  # 
├── __init__.py              # 
└── planefit.py              # 
```

### applogic.py

```python
# Main function, Used by lqVeloViewManager
def start():

    global app
    app = AppLogic()

    view = smp.GetActiveView()
    view.Background = [0.0, 0.0, 0.0]
    view.Background2 = [0.0, 0.0, 0.2]
    view.UseGradientBackground = True
    smp._DisableFirstRenderCameraReset()
    smp.GetActiveView().LODThreshold = 1e100

    resetCameraToForwardView()

    setupActions()
    disableSaveActions()
    hideColorByComponent()
    createRPMBehaviour()

    # Create Grid #WIP not perfect requires loaded plugin
    createGrid()
```





## 调试

### Qt Creator

1、superbuild_python_version not set CMakeLists.txt: 12 (include)

```cmake
#Sanitize checks
if(NOT SOFTWARE_NAME OR NOT SOFTWARE_VENDOR)
  message(FATAL_ERROR "SOFTWARE_NAME or SOFTWARE_VENDOR branding not set")
endif()
if(NOT superbuild_python_version)
  message(FATAL_ERROR "superbuild_python_version not set")
endif()
if(NOT paraview_version)
  message(FATAL_ERROR "paraview_version not set")
endif()
```



2、CMake process exited with exit code 1.



3、No CMake configuration found!



### GDB

打断点

```bash
break vtkHesaiPacketInterpreter.cxx:IsLidarPacket
break vtkHesaiPacketInterpreter.cxx:ProcessPacket
break vtkHesaiPacketInterpreter.cxx:PreProcessPacket
```







## Lua 解释器

LidarView 的 Plugin 解释器插件中提供了一些 xxx_parser.lua 脚本，这些解析器脚本是用来在 Wireshark 中解析自定义协议的，你可以通过下面命令让它工作起来。

```bash
wireshark -X lua_script:VelodyneAPFParser.lua -r myfile.pcap
```





## 测试

测试代码

- LVCore/LidarPlugin/Plugin/LidarCore/Testing/



### Velodyne

回放 pcap 数据出现如下警告：

```bash
( 173.434s) [paraview        ]vtkVelodyneLegacyPacket:1092  WARN| The data-packet from the sensor has a factory byte (0x21) recognized as having 32 lasers, LidarView will interpret data-packets and show points based on the XML calibration file only (currently: 16 lasers).
```

原因是选的激光雷达 VLP-16，应该选 VLP-32c。

