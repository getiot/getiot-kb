---
sidebar_position: 23
---

# 基于 NB-IoT 的无人水质监测船



项目简介：本团队设计一款无人水质监测小船，在STM32F4 系列的MPU芯片上搭载FreeRTOS，具有水质监测，自主巡航，双重运动遥控，数据云传输以及微信小程序等功能，旨在解决水质监测作业环境恶劣、重复性强、采样时间长的作业特点和任务需求，实现快速、高效、精确的完成水质监测任务。

开源协议：GPL 3.0

 

## 功能定义

1. 以无人小船为监测平台，能够通过GPS和北斗双模模块的定位，通过电子罗盘和GPS配合PID算法和贪心算法实现自主巡航。
2. 能够监测多种水质气象信息，包括水温，pH值，浊度，TDS，气压，海拔，环境湿度温度，光照强度等。
3. 能够通过NB-IOT模块实现数据的远程传输。
4. 通过距离传输的433M模组进行远程控制，无限制距离控制采用微信小程序，二者可随意切换，通过mqtt服务器与微信小程序通信，实时显示船体位置和运动轨迹以及下达船体运动命令，使小船可智能的行驶到指定的坐标点，完成地图寻路。
5. 通过4G模组网络摄像头实时传输视频。
6. 采用水泵监测水质，可装上清洁网通过规划湖面地图点位进行多点巡航。
7. 小程序上带有电量显示，船体当前状态提示，低电量报警值等功能。

 

## 设计原理

系统以 STM32F405 为控制核心，感知层通过 TDS 传感器，浊度传感器，水温传感器，PH 传感器采集相应水质数据，HMC5883L 电子罗盘模块用来获取船体航线角，可配合 BC20 北斗/GPS 定位模块实现航线控制与自动巡航。传输层采用 NB-IoT 技术连接基站，并通过 MQTT 协议实现船体与华为云平台及小程序之间的数据传输。软件上系统搭载 FreeRTOS 实时操作系统，通过航向角的 PID 控制和卡尔曼滤波器抑制 GPS 漂移实现了自动导航和返航，并基于贪心算法规划多点水质采集的最短路径。

![3ajjZqevbs5MoSVSfe8vTyxvzU2GhjCCNYsCmbwI.png](https://image.lceda.cn/pullimage/3ajjZqevbs5MoSVSfe8vTyxvzU2GhjCCNYsCmbwI.png#center)

## 技术规格 

- 尺寸：60x20cm
- 重量：1.3KG
- 巡航速度：1m/s-3m/s
- 最大航行时间：≥ 30分钟
- 搭载传感器类型：pH，TDS，水温，光照，海拔，环境湿度，环境温度
- 通信方式：2.4GHz, NB-IOT, 4GLTE
- 电池容量：5400mAh
- 工作温度范围：0~+70℃



## 硬件部分说明

![img](https://image.lceda.cn/pullimage/0dS1MLpG0IHCkbSpthlyCqKUnEj7tPLNPFURgdla.jpeg#center)

该无人船硬件系统主要分为4个部分：

(1) 船体框架和动力螺旋桨电机

(2) 主电路和外围传感器器件等组成的电路驱动系统

(3) 4G调制解调器和UVC摄像头组成的图传系统

(4) 遥控器

值得注意的是，为了保证船体的行驶稳定，我们将图传模块和主电路分开，船体的控制信息和数据通过NB-IOT模块传输给云服务器，而图像信息通过4G调制解调器直接传输给上位机，网络传输部分使用了两条链路同时工作，从而避免图传线路异常时，船体失联。虽然这会增加整体系统的功耗但我们认为这是必要的取舍。

### 船体组装与改造

(1) 船体组装

将购买后的散件组装完成即可

![5POYDM3syn8lxXIWd9i0KgZiMdDp093SNYwvw1f7.png](https://image.lceda.cn/pullimage/5POYDM3syn8lxXIWd9i0KgZiMdDp093SNYwvw1f7.png#center)

 螺旋桨的安装图

![Ttm885C0MRNiDH5OoHXsuSSZxeWwRmSkpL8WSx2j.png](https://image.lceda.cn/pullimage/Ttm885C0MRNiDH5OoHXsuSSZxeWwRmSkpL8WSx2j.png#center)

![yBhxi8bzONW24eyOeLDFPUtuTfXqixHT1RcUlqoo.png](https://image.lceda.cn/pullimage/yBhxi8bzONW24eyOeLDFPUtuTfXqixHT1RcUlqoo.png#center)

 

(2) 船体钻孔与改造

为了让船体具备水质采集与检测能力，必须在现有的船体框架上进行钻孔并安放相应的传感器和采样装置。

![qSvyV9WenvdnSiDcVAJcXRTxzH6ZXA5YEwFqVvUF.png](https://image.lceda.cn/pullimage/qSvyV9WenvdnSiDcVAJcXRTxzH6ZXA5YEwFqVvUF.png#center)

上图可以看出，我们在船的盖板上安装了一个亚克力平台，平台上放置了一个密封的采样盒，并将传感器插入采样盒，这样当进行水质采样时，水泵会抽水到盒子内部，进行相应的参数读取后排出。

当然这只是其中一种布局方案，您可以根据您自身的喜好调整布局。

若您不喜欢这种抽水进行采样的设计，您也可以直接将传感器外置，放入河流中进行采样，不过您必须做好相应的放水措施。

（注意：pH传感器比较脆弱，浸泡时间过长可能导致测量数据不准或损坏）

（3）添置浮力棒

船体内部放有各种器件，使得船体质量变大，在无人船航行的过程中可能会因为速度过快引起沉船风险，故需要在船体两侧加装浮力棒增加船体浮力。

### 电路组装

![kz7xJjrfYaprMDTQwUGK5bi4rhVNsadcybuH1EEq.png](https://image.lceda.cn/pullimage/kz7xJjrfYaprMDTQwUGK5bi4rhVNsadcybuH1EEq.png#center)

![fGKdIGVcDK1Aq1Q23b69msyMr4Nne8DWRsRAOhds.png](https://image.lceda.cn/pullimage/fGKdIGVcDK1Aq1Q23b69msyMr4Nne8DWRsRAOhds.png#center)

 

按照项目的电路原理图进行焊接，并将电路板放入船仓内并连接上电源和各种线缆，船体上方的盖子一定要盖好在下水。

电子罗盘需要注意它的安装位置，建议是将它接线出来，安装到船体尾部中间。电子罗盘对放置的位置有很多因素会干扰到电子罗盘，所以在安装的时候自行调整位置，最好是接线出来安装电子罗盘然后固定好。

![2kJ6HzHOdusbS4r1a6Nr5Lx5xZAtgBqURjNznTJO.png](https://image.lceda.cn/pullimage/2kJ6HzHOdusbS4r1a6Nr5Lx5xZAtgBqURjNznTJO.png#center)

传感器需要放置在抽水系统盒子里面，将PH传感器，浑浊度传感器，TDS传感器通过打孔后采用防水胶704将其粘好不会漏水即可。抽水系统由两个水泵组成的，一个是抽水进盒子的水泵，一个是盒子里排水的水泵。盒子里面不能完全封闭所以在盒子上方开了两个孔连接了管道用来空气流通到盒子里面，防止盒子密闭空间空气不流通就难以抽水。抽水泵电机方向的正负极需要注意一下不能接反，否则也无法抽水进来。

![pQVEO2aA1710P4xkG3DIlQUx2vD79lBZWJPw2Zmx.png](https://image.lceda.cn/pullimage/pQVEO2aA1710P4xkG3DIlQUx2vD79lBZWJPw2Zmx.png#center)![cav8r9PV0X8oiI5wY3KxX0IbDx5VvUlebIo9EQLI.png](https://image.lceda.cn/pullimage/cav8r9PV0X8oiI5wY3KxX0IbDx5VvUlebIo9EQLI.png#center)

抽取水面上的那个水泵的水管需要做一下稍微的处理，以防湖水的渣质抽到水泵里卡住水泵，无法工作，如果抽取水面上的水泵工作不正常无法抽进水可能就是被渣质给堵住了，需要拆卸下面的螺丝将拆下的头拿去用水冲洗薄膜，拆下来的头里的白色薄膜是拆卸不了的直接冲洗即可，在安装上尝试。

![PhNQQtIAkZN1w6vZxATvRWXShKWb3EB1fxd6598D.png](https://image.lceda.cn/pullimage/PhNQQtIAkZN1w6vZxATvRWXShKWb3EB1fxd6598D.png#center)

电源的开关在船体尾部。下水是船体上方的盖子一定要盖好后在下水，下水后开盖时也需要小心不要让水溅到主控板上，或者电路线上。建议是准备好纸张擦一下船壳上方的水。

![hgyFLqoxvSeHueDAGJ2sf6xe7rKsUR6LKn9z34Rz.png](https://image.lceda.cn/pullimage/hgyFLqoxvSeHueDAGJ2sf6xe7rKsUR6LKn9z34Rz.png#center)

### 图传模块安装

相较于传统的图传模块这个4G图传可以在任何4G信号覆盖到的地方工作，真正摆脱了对于距离的限制，虽然相比于传统图传模块来说，图像的传输并不高效，通常会伴随有图像延迟，但对于实时性需求不高的场景中，4G图传靠其低成本优势更适合这些场景的应用。

![BWkWU01e1PXeIdeYChDiifEC677KrtfWICFWowHs.png](https://image.lceda.cn/pullimage/BWkWU01e1PXeIdeYChDiifEC677KrtfWICFWowHs.png#center)

项目中使用的4G调制解调器是使用了市面上出售的UFI设备改造而成的，这类设备通常是用来作为便携上网设备使用，其内部运行的是安卓系统，将设备内部运行的安卓系统改成常规的Linux系统再搭载通用的摄像头即可实现图像获取功能。

这类设备的优点是成本低，并且原生就自带有4G的modem十分方便，缺点是并非市面上所有的型号都可以运行Linux系统，只有一些特定的型号可以操作。

详细的信息请参考github开源项目：https://github.com/OpenStick/OpenStick

![mc9BdP1LKAKtXCgtxYy1i26zB7MtnCmC6gJC2SGW.png](https://image.lceda.cn/pullimage/mc9BdP1LKAKtXCgtxYy1i26zB7MtnCmC6gJC2SGW.png#center)![VkXS41rVTse3dTMXjYCv0fMqql6ok69J0yoSGTbb.png](https://image.lceda.cn/pullimage/VkXS41rVTse3dTMXjYCv0fMqql6ok69J0yoSGTbb.png#center)

#### 刷入armbian系统

输入步骤请参考：https://blog.csdn.net/molun1101/article/details/127961397

#### 连接UVC摄像头

这边有两种方法可以连接摄像头：

1、使用USBhub1拖4电路拓展主板的USB口，可以使用开源的PCB工程

例：

- https://oshwhub.com/zy143l/ufi_hub_lite_share
- https://oshwhub.com/zy143l/ufi_hub_rj45_share
- https://oshwhub.com/led_terminator/ji-yu-SL2.2sde-USB-HUBkuo-zhan-w

将设备插入usb口并从核心板上的摄像头接口拉电源线接上，并把UVC摄像头插上即可。

2、直接使用USB母对母转接头接入UVC摄像头

![vVvzvUBp7J8dRafQDBm1Y0mPo7cORMxUaDMauqrv.png](https://image.lceda.cn/pullimage/vVvzvUBp7J8dRafQDBm1Y0mPo7cORMxUaDMauqrv.png#center)

优点，无需焊接转接板（但是要焊两根电源线），缺点不方便后期功能拓展（若需要接其他USB设备就需要改变硬件结构）。

![eh8MQDeWsdGWpExmD6R2qf4hYseFgwZqiKUy5I7W.png](https://image.lceda.cn/pullimage/eh8MQDeWsdGWpExmD6R2qf4hYseFgwZqiKUy5I7W.png#center)



## 微信小程序上位机操作说明

打开微信小程序列表搜索：“IOT太阳能水质船”即可获取无人水质检测船的微信小程序上位机

### 操作模式

小程序上可切换船体控制模式：遥控器模式和自主航行模式。

**遥控器模式：**使用2.4G遥控器控制船体，遥控器模式中可在小程序上点击手动监测控制直接驱动抽水泵将水槽灌满，然后进行水质监测，将传感器数据上传小程序。

![NOWkNYg8GgmynIINRVJRs6DhMd2uraFnNSjwovA5.png](https://image.lceda.cn/pullimage/NOWkNYg8GgmynIINRVJRs6DhMd2uraFnNSjwovA5.png#center)

 

**自主航行模式：**使该模式采样往地图上设置坐标点，来控制船体自主航行到坐标点自动进行水质检测，**坐标遍历完后检测完后会无需人为控制可自主返回出发点**。

![27C27qs8dL2Nl0UqI8oYhOpHbWvfgKjil1DkhW1I.png](https://image.lceda.cn/pullimage/27C27qs8dL2Nl0UqI8oYhOpHbWvfgKjil1DkhW1I.png#center)![HgjRKJ5IyK0iGncOIQ165km1bn5LlgdWuLhJPg9N.png](https://image.lceda.cn/pullimage/HgjRKJ5IyK0iGncOIQ165km1bn5LlgdWuLhJPg9N.png#center)

**自主航行步骤：**

1、点击航行矫正按钮

**注意：**罗盘矫正成功，小程序上会提示 `Compass_Successful`，如果是 `Compass_error` 请重新矫正，直到看到 `Compass_Successful`，不然无法进行下一步。

2、点击设置路径点按钮，在地图上设置坐标点

3、点击开始任务，船体开始自主航行

 

**状态提示：**

- ship_Idel 空闲提示
- ship_forward app手动控制提示
- ship_rotate 航行矫正提示
- ship_Gps 设置点位提示
- ship_run 自主导航提示
- ship_check_water 监测水质提示
- ship_error_stop 错误停止提示
- ship_back 自主返航提示
- ship_Please_Compass_Check!请进行航行矫正
- ship_Compass_Successful 电子罗盘矫正成功
- ship_Compass_error 电子罗盘矫正失败
- ship_hight_temp_warning 高温警告
- ship_powerlose_Warning 低电量警告
- ship_pumping 抽水中
- ship_release 放水中

 

### 其他页面说明

**调试终端页面**

![GHD2uuW4j3lMUsEcsmrTs2Gcz7DtJZpNxsPu3HtJ.png](https://image.lceda.cn/pullimage/GHD2uuW4j3lMUsEcsmrTs2Gcz7DtJZpNxsPu3HtJ.png#center)

调试终端可显示一些其他信息如：经纬度，信号强度，自主航行时的距离,实时显示等。

**视频实时显示页面**

![LdF8vqtYN1Sp1kPFar18AY3AkvCvSUR3GT0TliO8.png](https://image.lceda.cn/pullimage/LdF8vqtYN1Sp1kPFar18AY3AkvCvSUR3GT0TliO8.png#center)

 

### MQTT 服务器搭建

要使船体具备云功能，就需要搭建一个专门为船体提供 MQTT 服务的平台。并且这个平台必须具备公网 IP 环境。可以通过以下两种方式获取 MQTT 服务器。

**1、使用 EMQX Cloud 的试用额度**

EMQX Cloud 平台免费为用户提供了每月1百万分钟连接数和1GB流量的试用额度。

**2、 搭建 EMQX 开源版私人 MQTT 服务**

自己搭建 MQTT 服务器的好处就是无限制的流量和设备连接数，如果你有大量设备连接需求请一定使用本方法。在此之前你需要一台运行 Linux 操作系统的公网 VPS。

如果想长期使用，推荐搭建自己的 MQTT 服务平台。

 

### 图传软件安装

#### 安装 motiion

首先需要在图传里面安装motion监控软件，用来驱动UVC摄像头。

（1）使用ssh进入图传的shell终端

（2）在终端输入命令：apt install motion

（3）编辑配置文件

#### 安装 zerotier 软件

因为图传和上位机使用的网络环境并非公网，所以无法进行点对点访问，只能通过 P2P 远程组网的方式将微信小程序上位机和图传进行远程组件局域网来进行相互之间的访问。

（1）使用ssh进入图传的shell终端

（2）在终端中输入命令：curl -s | sudo bash 

这个命令会自动安装 zerotier 所需要的组件和程序本体。






## 工程视频/附件

| 序号 |                           文件名称                           | 下载次数 |
| :--: | :----------------------------------------------------------: | :------: |
|  1   | [无人水质监测船.mp4](https://oshwhub.com/attachments/2023/8/jPK4K8sRjqWrYJesqxsty3eA2qXSfoa9WMboXYgI.mp4?operation=download) |   212    |
|  2   | [ship_code.zip](https://oshwhub.com/attachments/2023/8/9fXwSNlBBvrN9jYbruFNnl4YedDA1fB333xFLqVM.zip?operation=download) |   109    |
|  3   | [嘉立创无人船说明书.docx](https://oshwhub.com/attachments/2023/8/RoqVcflWbO6qNjdmhOY5nwARy1EDwNwCY4TxX7oj.zip?operation=download) |    87    |




### 原理图

![img](https://image-pro.lceda.cn/pullimages/d3b011e7a8c64fb7ba8978208ef9acf2.webp#center)

![img](https://image-pro.lceda.cn/pullimages/d3b011e7a8c64fb7ba8978208ef9acf2.webp#center)

### PCB

![img](https://image-pro.lceda.cn/pullimages/0ebcb03bd2cf495b957c3498013a9f1e.webp#center)



## 相关链接

- [基于NB-IOT的无人水质监测船](https://oshwhub.com/u8xx/ji-yu-NB-IOTde-wu-ren-shui-zhi-j)
