---
sidebar_position: 6
slug: /wio-terminal-codecraft-smell-recognition
---

# Wio Terminal 气体传感器识别味道



## 项目概述

本模型使用 Wio Terminal 外接 Grove - Multichannel Gas Sensor v2（多通道气体传感器）收集不同气味数据，训练模型以区分可乐（Cola）、酒精（alcohol）和空气（air）。

**期望效果**

期望实现的效果如下所示，Wio Terminal 实时展示当前检测的液体名称，例如酒精、可乐。

![](https://static.getiot.tech/wio-terminal-codecraft-smell-recognition.png#center)

**材料准备**

- 一台 Wio Terminal
- 一个 [Grove 多通道气体传感器](https://www.seeedstudio.com/Grove-Multichannel-Gas-Sensor-v2-p-4569.html)

**提示**：为确保准确性，传感器需进行预热至少 24h，预热即插在通电的 Wio Terminal 上（左边的 Grove 接口）。

**项目步骤**

正如 [Codecraft 操作说明](/wiot/wio-terminal-codecraft-instruction/) 所介绍，Wio Terminal 嵌入式机器学习项目包括 4 个步骤：

1. 创建与选择模型
2. 数据采集

3. 训练与部署
4. 使用与编程



## 项目步骤

### 1.创建与选择模型

点击“创建与选择模型”，点击“外接多通道气体传感器”，根据命名要求输入名称，点击“确认”。

![](https://static.getiot.tech/wio-terminal-codecraft-smell-recognition-001.png#center)

点击确定后会自动跳转到“数据采集”界面。



### 2.采集数据

“内置光传感器识别手势”有 3 个默认标签：可乐（cola）、酒精（alcohol）、空气（air）。

![](https://static.getiot.tech/wio-terminal-codecraft-smell-recognition-002.png#center)

我们需要使用 Wio Terminal 采集数据。连接 Wio Terminal 和电脑，在 Codecraft 的界面，点击 “上传”，此操作将上传默认采集数据程序。

![](https://static.getiot.tech/wio-terminal-codecraft-smell-recognition-003.png#center)

选择目前的 Wio Terminal 对应的串口号，点击“确定”按钮，将上传默认采集数据程序到 Wio Terminal 设备。上传时间通常数十秒钟，完成后会看到下图所示的“上传成功”画面。

**提示**：对于网页版的 Codecraft ，需要提前安装并启用 Codecraft Assistant 设备助手。

接下来就可以采集数据了，在 Codecraft 页面右上角有数据采集步骤介绍，根据介绍指示采集数据。

![](https://static.getiot.tech/wio-terminal-codecraft-smell-recognition-004.png#center)

分别按下 Wio Terminal 上方的按键，采集不同类型的数据，显示收集完毕即可停止采集数据。此时，CodeCraft 页面显示“拼命加载中”，等待 1-2 秒，将数据从 Wio Terminal 传至 CodeCraft。重复以上操作，采集多组数据。

你可以添加自定义标签（例如 coffee），并采集该类型的数据，步骤与默认标签的数据采集相似。

待所有标签的数据采集完毕，点击“训练与部署”。



### 3. 训练与部署

选择适合的神经网络规模：小（small）中（medium）大（large）型其中一个。设置参数：训练周期数（training）、学习率（learning rate）、最低置信度（minimum confidence rating）。

![](https://static.getiot.tech/wio-terminal-codecraft-smell-recognition-005.png#center)

点击“开始训练”按钮，开始训练模型。训练所需的时间与选择神经网络规模（小型中型大型）、训练周期数有关，网络规模越大所需时间越长，训练周期数越高所需时间亦越长，所以请耐心等待。

加载完成后，可以在“输出日志”中看到“TrainModel Job completed”提示，表示模型训练任务已完成。

然后在“模型训练报告”界面，点击“部署模型”。弹窗提示部署完成，点击“确认”后，自动跳转到“使用与编程”界面。



### 4. 使用与编程

部署模型之后，我们还要编写模型使用程序才能在 Wio Terminal 上使用。

在“使用与编程”界面，点击“模型使用”即可使用已经部署的模型。

![](https://static.getiot.tech/wio-terminal-codecraft-smell-recognition-006.png#center)

编写如下程序即可尝试使用你的模型。

![](https://static.getiot.tech/wio-terminal-codecraft-smell-recognition-007.png#center)

点击“上传”按钮，将程序上传程序到 Wio Terminal。首次上传时间较长，且随模型复杂程度上传时间增长，请耐心等待。小模型上传时间大约为 4 分钟。

程序上传成功后，我们就可以在 Wio Terminal 上测试模型效果。需要说明的是，即使训练模型分数达到很高仍不代表模型就是好的模型，训练模型的分高而实际使用预测效果差的现象被称为过拟合（overfitting），相当于模型生硬记忆背诵了训练数据集的细节，在面临新的数据时不会做题了，这是机器学习训练模型会遇到的问题。

解决办法是：增加数据集、降低学习率，再重新训练模型。


