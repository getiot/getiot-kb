# RPLIDAR 思岚 A1 激光雷达

RPLIDAR A1 是思岚（SLAMTEC）推出的一款低成本 360 度激光扫描测距雷达，采用激光三角测距技术，配合自主研发的高速的视觉采集处理机构，可进行每秒 8000 次以上的测距动作。在将采样周期设为 1450 点采样/周的条件下，RPLIDAR 扫描频率达 5.5hz，并且最高可达 10hz 的扫描频率。

RPLIDAR A1 可以实现在二维平面的 12 米半径范围内进行 360 度全方位的激光测距扫描，并产生所在空间的平面点云地图信息。这些云地图信息可用于地图测绘、机器人定位导航、物体/环境建模等实际应用中。 

![](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1.jpg#center-400)


## 系统构成及连接

RPLIDAR A1 主要分为激光测距核心以及使得激光测距核心高速旋转的机械部分。在分别给各子系统供电后，测距核心将开始顺时针旋转扫描。用户可以通过 RPLIDAR A1 的通讯接口（串口/USB 等）获取 RPLIDAR 的扫描测距数据。

![RPLIDAR A1 系统构成示意图](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1-Components.png#center)

RPLIDAR A1 自身带有转速检测与自适应系统，雷达的扫描频率会自动随着实际的电机转速做出调整。无需使用者为 RPLIDAR A1 提供复杂的供电系统，降低了总体成本。并且外部系统可以通过通讯接口获取当前雷达的实际转速。



## 工作原理和使用

RPLIDAR A1 采用了激光三角测距技术，配合 SLAMTEC 研发的高速的视觉采集处理机构，可进行每秒高达 8000 次以上的测距动作。每次测距过程中，RPLIDAR A1 将发射经过调制的红外激光信号，该激光信号在照射到目标物体后产生的反光将被 RPLIDAR A1 的视觉采集系统接受。经过嵌入在 RPLIDAR A1 内部的 DSP 处理器实时解算，被照射到的目标物体与 RPLIDAR A1 的距离值以及当前的夹角信息将从通讯接口中输出。

![RPLIDAR A1 工作原理示意图](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1-Principe.png#center)

在电机机构的驱动下 RPLIDAR A1 的测距核心将进行顺时针旋转，从而实现对 360 度全方位环境的扫描测距检测。

![RPLIDAR A1 扫描所得环境示意图](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1-Example.png#center)




## 输出数据

在 RPLIDAR A1 工作时，每次采样的数据将通过通讯接口输出。每个采样点的数据将包括如下的信息。如果需要具体的数据格式和通讯接口的协议，请与 SLAMTEC 联系。 

**表：RPLIDAR A1 采样点的数据信息**

| 数据类型 | 单位     | 描述                                    |
| -------- | -------- | --------------------------------------- |
| 距离值   | 毫米     | RPLIDAR 距离当前采样点之间的实际距离    |
| 夹角     | 度       | 当前采样点相对于 RPLIDAR 自身朝向的夹角 |
| 信号强度 | 级       | 当前采样点的信号强度                    |
| 起始信号 | (布尔值) | 表示当前采集点是否属于一次新的扫描      |

RPLIDAR A1 采样点数据帧传输示意图如下图所示。

![](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1-Data-Frame.png#center)

RPLIDAR A1 在不断的输出中包含了上述信息的采样点数据帧。外部系统可以通过发送控制指令使 RPLIDAR A1 停止输出数据。使用 4k 及以上采样频率时，传输数据结构有所不同。具体信息请与 SLAMTEC 联系。



## 硬件参数

### 测量性能

RPLIDAR A1M8 型号激光雷达的测量测量性能如下表所示。

![RPLIDAR A1 性能表](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1-Parameters.png#center)

需要注意，三角测距系统距离分辨率将随着实际距离值变化，RPLIDAR A1 的理论具体变化情况如下图所示：

![RPLIDAR A1 测距系统距离分辨率随实际距离变化趋势图](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1-Parameters-resolution.png#center)



### 光学信息

RPLIDAR A1M8 型号激光雷达的光学特性如下表所示。

**表：RPLIDAR A1 光学信息表**

| 项目       | 单位       | 最小值 | 典型值 | 最大值 | 备注     |
| ---------- | ---------- | ------ | ------ | ------ | -------- |
| 激光器波长 | 纳米（nm） | 775    | 785    | 795    | 红外波段 |
| 激光器功率 | 毫瓦（mW） | 待定   | 3      | 5      | 峰值功率 |
| 脉冲时长   | 微秒（us） | 80     | 98     | 120    |          |



### 接口定义

RPLIDAR A1 标准配置采用 3.3V 电平的串口（UART）作为通讯接口，并且可以随着客户需求采用 USB 等其他接口。下表为基于串口接口的规格信息，具体的串口通讯协议与 SDK 请联系 SLAMTEC。

![RPLIDAR A1 接口定义示意图](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1-Connector.png#center)

RPLIDAR A1 模块提供一个 3 pin 的电机驱动接口和一个 4 pin 的串口通信接口，分别采用 PH1.25-3P 和 PH1.25-4P 的立贴座，具体接口引脚说明如下表所示。

![](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1-Interface.png#center)

MOTOCTL 引脚可以用以控制电机的运行或者定转控制，也可以使用 PWM 信号对电机的旋转速度进行调制，从而控制 RPLIDAR A1 扫描频率。

RPLIDAR A1 串口默认波特率为 115200 bps，工作模式为 8N1，即 8 位数据、1位停止位、无校验。



## 供电与功耗情况

RPLIDAR A1 采用测距逻辑系统与电机系统分别供电的模式。外部系统需要单独为这两个部分供应电能以确保扫描测距数据的精确性。下图展示了推荐的供电模式。具体的规格信息请参考下文表格。

![RPLIDAR A1 推荐供电模式](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1-Power.png#center)



## 自我保护和状态检测

为了确保 RPLIDAR A1 在工作当中激光器时刻工作在 < 5mW 的安全输出范围内，并且避免因故障导致设备自身出现损害。RPLIDAR A1 带有了激光器功耗检测以及传感器健康检查逻辑。在以下故障发生时，RPLIDAR A1 将自动停止扫描工作，并且关闭激光发射器，避免对外界以及自身造成损伤。

- 激光器发射功率超过限定值
- 激光器无法正常点亮
- 雷达扫描系统转速不稳定
- 雷达扫描系统转速过低
- 激光信号传感器工作异常

外部系统可以通过通讯接口查询当前系统的工作状态，并且可以尝试重启系统恢复工作。 



## 安全性与适用范围

RPLIDAR A1 系统采用低功率（< 5mW）的红外线激光器作为发射光源，并采用调制脉冲方式驱动，激光器仅在极短的时间内进行发射动作。因而可以确保对人类及宠物的安全性，可以达到 Class I 级别的激光器安全标准。产品符合 21 CFR 1040.10 和 1040.11，但根据 2007 年 6 月 24 日激光通告第 50 号的偏差除外。

注意：使用非本文指定的控制，调整或执行程序可能会导致危险的辐射暴露。调制的激光可以有效避免在测距扫描过程当中的环境光与日光干扰。可以在室内环境以及无阳光直射的室外环境下使用。

![](https://static.getiot.tech/Laser-symbol-text.png#center-200)

## 开发工具与支持

为了方便用户使用 RPLIDAR A1 进行产品开发并加速开发周期，针对 RPLIDAR A1M8 型号，SLAMTEC 提供了机器人管理与开发软件 [RoboStudio](https://www.slamtec.com/cn/RoboStudio) 中供用户进行图形化调试。

![](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1-RoboStudio.png#center)

另外，SLAMTEC 还提供了可以运行于 x86 Windows、x86 Linux、ARM Linux 等平台下的 SDK 开发包。具体信息请联系 SLAMTEC。



## 开发套件

### 硬件

RPLIDAR A1 开发套装包含了方便用户对 RPLIDAR A1 进行性能评估和早期开发所需的配套工具。用户只需要将 RPLIDAR A1 模组与 PC 机连接，即可在配套的评估软件中观测 RPLIDAR A1 工作时采集得到的环境扫描点云画面或者使用 SDK 进行开发。

![RPLIDAR A1 开发套件实物图](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1-Kit.png#center)

RPLIDAR A1 开发套装包含了如下组件：

- RPLIDAR A1 模组（内置 PWM 电机驱动器）
- USB 适配器
- RPLIDAR A1 模组通讯排线

注意：另需自备 USB 线缆用于连接。

RPLIDAR A1 开发套装中包含了标准版本的 RPLIDAR 模组（A1M1-R1）。同时，模组内集成了可以使用逻辑电平（3.3v）驱动的电机控制器。开发者可以使用该电机驱动器使用 PWM 信号对电机转速进行控制，从而控制 RPLIDAR A1 扫描的频率或者在必要时刻关闭电机节能。

开发套装包含一个 USB 适配器模块，用于对 RPLIDAR 模组进行供电驱动，并使用 USB 接口与 PC 等外部设备进行通讯。只要使用配套的通讯排线与 RPLIDAR 模组相连，用户只需要一条 USB 线缆即可使用 RPLIDAR。

USB 适配器采用 CP2102 芯片实现串口（UART）至 USB 信号的转换。因此需要在 PC 系统中安装对应的驱动程序。其驱动程序可以在配套的 SDK 包中找到，或者从 Silicon Labs 的[官方网站](https://www.silabs.com/interface/usb-bridges)中下载。

### 软件

SLAMTEC 在机器人管理与开发软件 RoboStudio 中提供了可视化插件 Lidars 用于评估和调试。通过该插件，用户可以直观地观测到 RPLIDAR 实时的测距扫描结果，并且可以保存测距结果至外部文件供进一步分析。

**目前该软件需要运行在 Windows 平台下，对于 Linux 和 MacOS 用户，可以使用 SDK 中提供的其他示例程序。**

请确保 RPLIDAR A1 模组已经通过 USB 转接器连接至 PC，且已经安装了前文所述的驱动程序。运行 RoboStudio，注册账号并登陆。

如果连接正常，将进入 RoboStudio 主界面，点击“文件->雷达”选项，左侧弹出雷达浮动窗口，然后展开串口，连接至 PC 的雷达将出现在列表中，点击该雷达图标即可。在雷达下方展开工具图标列表，左侧为调速按钮（RPLDIAR A1 雷达默认不可调速），右侧为工具栏按钮，点击工具栏按钮可在主工作界面上打开工具栏选项， 如下图所示：

<!-- ![RoboStudio 的 Lidars 插件工作界面]() -->

其中串口下列出的雷达显示了当前连接雷达的序列号、版本信息。所有对 RPLIDAR 可进行的操作均已在工具栏列出：

![](https://static.getiot.tech/SLAMTEC-RPLIDAR-A1-RoboStudio-Toolbar.png#center)

点击扫描采集按钮，则可以在主工作区中看到当前的扫描图，默认电机旋转参数设定在 8Hz 左右：

<!-- ![Lidars 插件显示的雷达扫描的轮廓]() -->

在主工作区鼠标右键菜单中可以选择不同的测距范围，从而实现对扫描画面的缩放。测距核心的扫描速度（转速）可以通过画面最后的文字读出。



### 调整扫描频率

由于 USB 适配器中将电机控制信号 MOTOCTL 设置为高电平，因此 RPLIDAR A1 扫描电机将始终保持在最高转速下，此时 RPLIDAR A1 扫描也保持在较快的频率上。如果希望控制 RPLIDAR A1 的扫描频率，则需要控制电机转速。

可以将 MOTOCTL 信号连接至具有 PWM 信号输出能力的设备中，比如 MCU 的 PWM 输出 IO 上。并通过从 RPLIDAR A1 测距核心反馈的到的当前扫描频率作为反馈，调节 PWM 的占空比。从而实现对将 RPLIDAR A1 扫描频率锁定在一个希望的数值上。

请参考 RPLIDAR A1 协议规范与应用文档了解详情，或者参考 SDK 中关于获取 RPLIDAR A1 扫描频率的代码。



### 使用 SDK 进行开发

SLAMTEC 提供了对 RPLIDAR A1 进行开发的配套 SDK。该 SDK 支持 Windows、Linux 操作系统，并且用户也可以通过 SLAMTEC 提供的 SDK 源代码快速将 SDK 移植到其他的操作系统或者嵌入式系统当中。请参考 SDK 文档了解详情。



## 应用场合

本系统适用于如下领域：

- 家用看护/清洁机器人的导航与定位
- 通用的机器人导航与定位
- 智能玩具的定位于障碍物检测
- 环境扫描与 3D 重建
- 通用的同步定位与建图（SLAM） 

