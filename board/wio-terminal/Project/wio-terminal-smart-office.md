---
sidebar_position: 13
slug: /wio-terminal-smart-office
draft: true
---

# Wio Terminal 智能办公室

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image.png#center)

## Demo 概述

这个 Demo 使用 Wio Terminal 和一些传感器模拟智慧办公场景。使用空气质量传感器、PM2.5 传感器检测办公室空气质量；使用人体红外传感器（PIR）检测办公室有无人员情况，当无人时自动关闭门窗灯光，有人时才开启用用 Wio Terminal 屏幕显示（模拟智能会议系统和通风系统）；使用 Wio Terminal 内置光传感器可以检测环境光亮度，从而调节灯的自动开关或智能亮度。

以上传感器均将数据传至Azure IoT Central，设置阈值，使得在数据异常时，Azure IoT Central做出提示。

livinfarms


## 准备1：硬件需求

- [Wio Terminal](https://www.seeedstudio.com/Wio-Terminal-p-4509.html)
- [Grove - 红外线人体传感器](https://www.seeedstudio.com/Grove-Adjustable-PIR-Motion-Sensor.html)
- [Grove - 空气质量传感器](https://www.seeedstudio.com/Grove-Air-Quality-Sensor-v1-3-Arduino-Compatible.html)
- [Grove - PM2.5 传感器](https://www.seeedstudio.com/Grove-Laser-PM2-5-Sensor-HM3301.html)
- [Grove - LED彩灯](https://www.seeedstudio.com/Grove-Multi-Color-Flash-LED-5mm.html)
- 杜邦线



## 准备2：软件需求

1. 用电脑连接 Wio Terminal

2. 打开要运行智慧办公室的[代码](https://files.seeedstudio.com/wiki/github_weiruanexample/Smart_Office_Azure1.ino)并添加运行所需要的[库](https://files.seeedstudio.com/wiki/github_weiruanexample/libraries1.zip)到 Arduino IDE

3. 注册 [Azure IoT Central](https://lab1.azureiotcentral.com/dashboards/)

!!! note
    如果您刚开始使用 Wio Terminal 或者不知道怎么上传代码和添加库，可以查看[这里]


## 实验1-1：设备连接

### 实验目的:

连接所需传感器。

### 实验步骤：

1. 连接传感器，空气传感器在右边 Grove 口，PM2.5 传感器在左边 Grove 口

![](https://files.seeedstudio.com/wiki/github_weiruanexample/lab2.png#center)

2. 在 Wio Terminal 后面连接人体红外线传感器和LED灯。

a. 人体红外传感器这里我们连接的是 D2 口，即分别用grove线连接传感器的 VCC（红线），GND（黑线），SIG（黄线） 到 Wio Terminal 的编号 2，6，16接口（其中grove线的白线不用连接）。

b. LED 灯连接的是 D3 口，即分别用grove线连接传感器的 VCC（红线），GND（黑线），SIG（黄线） 到 Wio Terminal 的编号 4，14，18接口（其中grove线的白线不用连接）。

![](https://files.seeedstudio.com/wiki/github_weiruanexample/lab2_2.png#center)


## 实验1-2：连接到 Azure IoT Central并使用 D2C Message 发送时序数据

### 实验目的:

实时监测实时监测办公室空气质量，PM2.5，光线强度，是否有人，将传感器数据传至Azure IoT Central。可Azure IoT Central分析近期数据。


### 实验步骤：

1. 注册好后打开[Azure IoT Central](https://apps.azureiotcentral.com/)

a. 在左侧菜单栏点击“My apps”来建造一个app，也可以在这里管理你的已经建造的app

![](https://files.seeedstudio.com/wiki/github_weiruanexample/weiruan2.png#center)

b. 在左侧点击进入“Build”界面

![](https://files.seeedstudio.com/wiki/github_weiruanexample/weiruan3.png#center)

c. 输入你想要的“Application name”和“URL”，Azure IoT Central提供了 7 天的免费试用机会

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image4.png#center)

当建造到 app 之后，在左侧菜单栏最下面选择“Administration” 接着选择“Device connection” 来连接我们的 Wio Terminal。名字是“SAS-IoT-Devices”

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image5.png#center)

e. 拷贝下“ID scope”和“Primary key”，两个参数使我们要填在我们的代码上进行网页和机器的认证连接。

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image6.png#center)


3. 下载[代码](https://files.seeedstudio.com/wiki/github_weiruanexample/Smart_Office_Azure1.ino)，修改 Arduino 代码并上传，需要改的内容为上一步保存的 ID_scope 和 primary_key 以确保网页和设备相连，并且修改WIFI账号和密码。

![](https://files.seeedstudio.com/wiki/github_weiruanexample/weiruantugai3.png#center)

4. Arduino IDE提示上传成功后，打开Arduino IDE右上角的串口，再观察是否连接成功

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image13.png#center)

5. 打开Azure IoT Central可观察数据

![](https://files.seeedstudio.com/wiki/github_weiruanexample/output5.png#center)

## 实验1-3：使用Azure IoT Central可视化界面观察数据

### 实验目的:

使用Azure IoT Central可视化界面观察数据。

### 实验步骤：

1. 创建设备templates

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-10.png#center)

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-11.png#center)

输入名字”Smart_Office“。(请确保名字一致)

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-12.png#center)

选择导入模型“Import a model”。

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-13.png#center)

选择文件夹中的 [Smart_Office.json](https://files.seeedstudio.com/wiki/github_weiruanexample/Smart_Office.zip)    ![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-14.png#center)

2. 点击Views，选择生成默认模板

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-15.png#center)

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-16.png#center)

3.此次实验在默认模板的基础上进行修改，使其自定义化,点击Overview。

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-17.png#center)

找到“LKV”，鼠标长按，将其拖拽至界面，如下图操作。

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-18.png#center)

调节大小

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-19.png#center)

设置其显示“ArethereanyPeople”，显示是否有人。

![](https://files.seeedstudio.com/wiki/github_weiruanexample/weiruantugai4.png#center)

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-21.png#center)

点击上传

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-22.png#center)

同理操作，设置空气质量类型

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-23.png#center)

设置完成后如下图，点击Start with devices，下滑至底部找到“Command”

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-24.png#center)

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-25.png#center)

选择Command选项为“meeting”。

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-26.png#center)

设置结束后效果如下图

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-29.png#center)

4. 点击左上角的“Save”保存后点击”Back“返回。

![](https://files.seeedstudio.com/wiki/github_weiruanexample/weiruantugai5.png#center)

返回后点击左上角“Publish”。

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-27.png#center)

5. 此时关闭串口，断开Wio Terminal再重新连接，打开串口。

Azure IOT Central返回devices界面查看,选择设备，选择“Overview”即可查看。

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image-28.png#center)

## 实验1-4：Azure IoT Central设置阈值，异常提示

### 实验目的:

使用空气质量传感器，PM2.5传感器来检测办公室内空气异常，并用 Azure IoT Central 发出提示消息。

### 实验步骤：

1. 点击左侧菜单栏的“Rules”再点击“Create a rule”

![](https://files.seeedstudio.com/wiki/github_weiruanexample/image15.png#center)

2. 选择刚开始设置的 template 的名字，设置想要的参数和实行动作的参数值，比如这里设置的是空气质量值低于50则要做出 actions

![](https://files.seeedstudio.com/wiki/github_weiruanexample/output8.png#center)

![](https://files.seeedstudio.com/wiki/github_weiruanexample/output9.png#center)

3. 设置 actions 为发送警告邮件

![](https://files.seeedstudio.com/wiki/github_weiruanexample/output10.png#center)

2. 当环境状态处于异常时，观察邮箱是否接收到异常提醒。

![](https://files.seeedstudio.com/wiki/github_weiruanexample/output11.png#center)

## 实验1-5：Azure IoT Central设置任务，使用C2D Message通道向设备发送指令，远程开启模拟智能会议系统

### 实验目的：

通过设置任务来模拟发送开启会议的信号

### 实验步骤：

点击左边菜单栏的“Devices”，再点击我们之前在 templete 设置的 command，输入 “on” 然后观察 Wio Termianl 的显示页面是否出现“Meeting On”的信息

![](https://files.seeedstudio.com/wiki/github_weiruanexample/weiruan30.png#center)

## 实验1-6：Wio Terminal模拟自动控制中心

### 实验目的：

Wio Terminal内置光传感器可以检测环境光亮度，从而调节灯的自动开关或智能亮度，采用人体红外传感器检测办公室有无人员情况，当无人时自动关闭门窗灯光，有人时才开启用用Wio Terminal屏幕显示（模拟智能会议系统和通风系统）。

### 实验步骤：

实验1-2中上传的代码已实现该功能，此处模拟环境变化观察 Wio Terminal 变化即可。





![](https://static.getiot.tech/WioT-Azure-IoT-Smart-Office-Dashboard-1.png)



![](https://static.getiot.tech/WioT-Azure-IoT-Smart-Office-Dashboard-2.png)



