---
sidebar_position: 15
slug: /wio-terminal-basement-monitoring
---

# Wio Terminal 地下室监测案例

![](https://static.getiot.tech/wio-terminal-basement-monitoring-01.jpeg#center)

本案例来自一位美国的创客 Mithum Das 为家里地下室设计的一套环境监测方案。使用 Wio Terminal 和 BME680 环境传感器，配合 [Blynk](/dictionary/blynk/) 监测地下室环境数据，确保地下室的湿度不会过高，并通过手机提醒用户检查除湿桶是否已满。另外，通过麦克风采集环境噪声（除湿机的声音），使用 TinyML（通过 Edge Impulse 平台）训练机器学习模型，判断除湿机是否正常工作。



## 项目背景

Mithum Das 居住在美国东海岸，那里许多房屋都有地下室。Mithum Das 家的地下室还是尚未完工的状态，因此有一个除湿机放在地下室，保持地下室干燥。但问题是，当水桶充满水，最终湿度变高时，设备就会关闭。我需要定期去地下室，确保除湿机是在运行的。但有时候会忘记检查一两个星期。导致地下室里的湿度在一段时间内处于太高的数值，以至于霉菌的滋生。毒霉菌会对你的眼睛和呼吸系统造成刺激，还会在地下室产生难闻的气味。霉菌还会导致哮喘病的发作，并且给免疫系统能力低下的人带来严重的危害，所以保持地下室干燥是一件很重要的事情。



## 解决方案

Mithum Das 使用 Wio Terminal 和 BME680 环境传感器制作了一个检测装置，它能够检测温度、湿度、室内空气质量（IAQ）和噪音。检测到的数据将会显示在 Wio Terminal 上，然后发送到 Blynk。当湿度超过预先设置的数值时（可通过 Blynk 应用程序设置），Blynk 将会推送通知到手机上，方便用户及时了解地下室的情况，并且合理的使用除湿机。

![](https://static.getiot.tech/wio-terminal-basement-monitoring-02.jpeg#center)

### 空气质量监测

BME680 传感器可以测量室内的空气质量。这对于 Mithum Das 的地下室来说是一个非常重要的，因为油罐和供暖设备都位于地下室。如果地下室产生难闻的气味或者室内空气质量升高，Blynk 就会推送通知到用户。

![](https://static.getiot.tech/wio-terminal-basement-monitoring-08.jpeg#center)



### Blynk 仪表板

与 Wio Terminal 的显示屏相比较，从 Blynk 应用程序 查看传感器检测到的数据更加方便。Wio Terminal 每秒都会将数据发送到 Blynk 的服务器，用户便可在应用程序上查看。

![](https://static.getiot.tech/wio-terminal-basement-monitoring-04.jpeg#center)

该项目使用了四种量规，一个滑块和一个图表和一个通知小组件，四种量规连接到四个引脚。

```cpp showLineNumbers
Blykn.virtualWrite(V1,t);
Blykn.virtualWrite(V1,h);
Blykn.virtualWrite(V1,a);
Blykn.virtualWrite(V1,avg);
```

将湿度的预设数值链接到滑块

```cpp showLineNumbers
BLYNK（V0）
{
    //reads the slider value when it changes in the app
    humidityThreshold = param.asInt();
}

if(h > humidityThreshold )
{
    if(lastNotification == 0 || (millis() - lastNotification) > 60*60*1000)
    {
        lastNotification = millis();
        Blynk.notify("Basement is too humid. Check the dehumidifier");
    }
}
```



## 嵌入式机器学习

除此之外，该项目还运用了嵌入式机器学习 TinyML（利用 Edeg Impulse Studio）分析来自除湿机所发出来的声音，并对设备运行或者待命状态进行预判。Edge Impulse 是一个基于网络的工具，你可以在这里收集数据、构建推理模型、测试模型性能，最后上传到单片机。（参考 [Wio Terminal Edge Impulse 教程](/wiot/wio-terminal-tinyml-edge-impulse/)）

Mithum 收集了大约 3 分钟的数据。是因为在地下室里除了抽湿机没有其他的噪音，所以 3 分钟就够了。

![](https://static.getiot.tech/wio-terminal-basement-monitoring-05.jpeg#center)

Mithun Das 尝试了 MFCC 和 MFE 两种信号处理模块，从训练结果来看，MFE 的效果更好一些。

![](https://static.getiot.tech/wio-terminal-basement-monitoring-06.jpeg#center)

模型训练完成后，下载 Arduino library，因为库中的示例是专门针对 Arduino Nano BLE Sense 的代码，所以应用 Wio Terminal 作为主控需要更改一些代码。具体代码可前往项目页面参考 dehumifier_tinyml.ino，将 Edge Impulse 的 sdk 与代码链接起来。

![](https://static.getiot.tech/wio-terminal-basement-monitoring-07.jpeg#center)

模型判断设计为每秒都在运行，但是就向 Blynk 发送数据间隔为 10 秒。除此之外，预测有时也会出错，所以最好采用取平均值的方法来消除错误数据。



## 部署

最后，Mithum Das 利用 3D 打印机制作装置外壳，将整套设备安装到地下室。

![](https://static.getiot.tech/wio-terminal-basement-monitoring-09.png#center)



