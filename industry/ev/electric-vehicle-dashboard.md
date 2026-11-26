---
sidebar_position: 15
draft: true
authors: [luhuadong]
---

# 电动汽车仪表设计



早期的汽车仪表是从汽车工程师调试的习惯中产生的，尤其是在上个世纪的工业时代。用指针和指南针显示速度和速度信息作为参考是时代文明的体现，机械化占了近100％的时间。在汽车时代，只能用更多的指示灯来表示汽车故障信息和提示信息。总体布局具有浓厚的工业氛围。



## 数字仪表设计案例

该设计的重点是根据驾驶场景过滤信息的不同驾驶模式。仪表组的设计根据三种模式而变化：**高速公路，城市和静止**。高速公路和城市模式由系统自动启用。当汽车处于停车或空档时，静止模式启动。



### 界面结构概览

用户界面由3个不同的栏和3个“信息面板”组成。**顶栏（1）**显示易于理解的**“长期”信息**，如时间，天气和预计到达时间（ETA）。
**两个侧边栏（2,3）**分别显示来自用户手机的**仪表板图标和通知**。条形图中的信息在不同的驱动模式下基本保持不变。

主要区域分为**三个信息面板（4,5,6）**。这些显示**关键信息**，如导航系统，速度和方向。信息可视化和数据类型可以根据驾驶模式显着改变，因此，选择具有三个信息面板的清晰设计以保持结构感。

![](https://static.getiot.tech/design-of-an-instrument-cluster-for-an-electric-car-01.png)



### 高速公路模式

在高速公路上行驶时，仪表组仅向驾驶员显示完全必要的信息，以最大限度地减少驾驶员分心。

左侧面板显示了汽车相对于速度限制的**速度**。对于一个司机来说，在高速公路上，无论他的速度有多快，都与速度限制的相对速度无关。当绿色圆圈完成时，驾驶员正在完全达到速度限制。速度限制显示在表盘中央。

中间和右侧面板显示**路线和方向**。在高速公路上行驶时，显示完整的地图信息太多了。驾驶员只需要知道他需要驾驶哪条车道以及下一步要去哪里。因此，中间空间仅显示汽车在道路上的位置以及驾驶员应遵循的路线（蓝线）。右侧刻度盘充当每个方向的进度条。它为每个新方向重新启动。

![](https://static.getiot.tech/design-of-an-instrument-cluster-for-an-electric-car-02.png)

当驾驶员超过速度限制时，界面会给驾驶员提供微妙的提示以减速。首先，通过将刻度盘的颜色更改为红色，并在其持续增加速度时，通过将整个簇的轮廓更改为红色。

![](https://static.getiot.tech/design-of-an-instrument-cluster-for-an-electric-car-03.gif)



### 城市模式

当用户进入城市时，UI 相应地改变信息的显示。在高速公路驾驶模式中，重点是驾驶员的注意力和以正确的速度驾驶，在城市中，这变得强调在复杂的街道上航行。

首先，地图会更改为城市的详细俯视图，并在其上方投射路线。其次，由于焦点远离速度，左面板变得不那么重要了。因此，它显示实际的数字速度和环形亮起的环境颜色，而不是绿色。但是，用于超速的相同反馈系统仍然存在。

![](https://static.getiot.tech/design-of-an-instrument-cluster-for-an-electric-car-04.png)



### 静止模式

如果汽车处于**停车或空档状态**，则与其他驾驶模式相比，UI 为驾驶员提供非常不同的信息。这背后的原因是驱动程序将对更详细的信息更感兴趣。因此，他将使用主要的信息娱乐系统。然后，仪表板将作为第二个屏幕，提供有关汽车状态的快速，关键信息。

左侧面板显示电池的充电水平和驱动的总距离。中央面板显示了汽车的顶视图，反映了汽车的状态（打开车门，车灯，机械问题）。右侧面板显示当前的媒体设置。 

顶部栏中的信息也会略有变化，因为它会显示更详细的信息。除此之外，还会显示数据，以及天气和天气预报。自动变速箱的设置显示在中央。

![](https://static.getiot.tech/design-of-an-instrument-cluster-for-an-electric-car-05.gif)





## Qt 汽车仪表盘设计教程

- [《如何用Qt Design Studio打造汽车仪表盘》（第一部分）](https://resources.qt.io/cn/qtdesignstudio-cluster-tutorial-part1)
- [《如何用Qt Design Studio打造汽车仪表盘》（第二部分）](https://resources.qt.io/cn/qtdesignstudio-cluster-tutorial-part2)
- [《如何用Qt Design Studio打造汽车仪表盘》（第三部分）](https://resources.qt.io/cn/qtdesignstudio-cluster-tutorial-part3)
- [《如何用Qt Design Studio打造汽车仪表盘》（第四部分）](https://resources.qt.io/cn/qtdesignstudio-cluster-tutorial-part4)
- [《如何用Qt Design Studio打造汽车仪表盘》（第五部分）](https://resources.qt.io/cn/qtdesignstudio-cluster-tutorial-part5)





