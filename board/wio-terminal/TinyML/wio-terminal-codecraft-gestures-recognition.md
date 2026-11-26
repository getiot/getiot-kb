---
sidebar_position: 4
slug: /wio-terminal-codecraft-gestures-recognition
---

# Wio Terminal 光传感器手势识别



## 项目概述

本模型使用 Wio Terminal 内置的光传感器，识别手势：石头（rock）、剪刀（scissors）、布（paper）。

这是一项使用基于规则的编程很难解决的任务。因为人们每次做手势的方式都不完全一样，若使用编程方法，我们把不同的人不同的手势方式考虑进去，那将是成百上千条不同的规则。实际上这仍是理想化情况，仍有很多人不同的手势未被考虑到，速度、角度、频率、方向等任一因素的轻微变化都需为其建立新的规则，但机器学习（TinyML）可以轻松地处理这些变化。

众所周知，用相机传感器结合机器学习来识别手势是可能的，即使图像被缩小了很多。但使用光传感器，相当于仅使用了相机的一个像素点来识别手势，则是完全不同水平的挑战。让我们通过此项目迎接挑战吧！

**期望效果**

期望实现的效果如下所示，Wio Terminal 实时展示当前对 Wio Terminal 的手势动作的识别结果。石头（rock）、剪刀（scissors）、布（paper）其中一种。

![](https://static.getiot.tech/wio-terminal-codecraft-gestures-recognition.png#center)

**材料准备**

硬件方面只需要一台 Wio Terminal（内置光传感器）

**项目步骤**

正如 [Codecraft 操作说明](/wiot/wio-terminal-codecraft-instruction/) 所介绍，Wio Terminal 嵌入式机器学习项目包括 4 个步骤：

1. 创建与选择模型
2. 数据采集
3. 训练与部署
4. 使用与编程



## 项目步骤

### 1. 创建与选择模型

点击“创建与选择模型”，点击“内置光传感器识别手势”，根据命名要求输入名称，点击“确认”。

![](https://static.getiot.tech/wio-terminal-codecraft-gestures-recognition-001.png#center)

点击确定后会自动跳转到“数据采集”界面。



### 2. 采集数据

“内置光传感器识别手势”有 3 个默认标签：石头（rock）、剪刀（scissors）、布（paper）。

![](https://static.getiot.tech/wio-terminal-codecraft-gestures-recognition-002.png#center)

我们需要使用 Wio Terminal 采集数据。连接 Wio Terminal 和电脑，在 Codecraft 的界面，点击 “上传”，此操作将上传默认采集数据程序。

![](https://static.getiot.tech/wio-terminal-codecraft-gestures-recognition-003.png#center)

选择目前的 Wio Terminal 对应的串口号，点击“确定”按钮，将上传默认采集数据程序到 Wio Terminal 设备。上传时间通常数十秒钟，完成后会看到下图所示的“上传成功”画面。

**提示**：对于网页版的 Codecraft ，需要提前安装并启用 Codecraft Assistant 设备助手。

接下来就可以采集数据了，在 Codecraft 页面右上角有数据采集步骤介绍，根据介绍指示采集数据。

![](https://static.getiot.tech/wio-terminal-codecraft-gestures-recognition-004.png#center)

分别按下 Wio Terminal 上方的按键，采集不同类型的数据，显示收集完毕即可停止采集数据。此时，CodeCraft 页面显示“拼命加载中”，等待 1-2 秒，将数据从 Wio Terminal 传至 CodeCraft。重复以上操作，采集多组数据。

你可以添加自定义标签，并采集该类型的数据，步骤与默认标签的数据采集相似。

待所有标签的数据采集完毕，点击“训练与部署”。



### 3. 训练与部署

选择适合的神经网络规模：小（small）中（medium）大（large）型其中一个。设置参数：训练周期数（training）、学习率（learning rate）、最低置信度（minimum confidence rating）。

![](https://static.getiot.tech/wio-terminal-codecraft-gestures-recognition-005.png#center)

点击“开始训练”按钮，开始训练模型。训练所需的时间与选择神经网络规模（小型中型大型）、训练周期数有关，网络规模越大所需时间越长，训练周期数越高所需时间亦越长，所以请耐心等待。

加载完成后，可以在“输出日志”中看到“TrainModel Job completed”提示。

![](https://static.getiot.tech/wio-terminal-codecraft-gestures-recognition-006.png#center)

在部署模型之前，我们先观察一下模型性能，选择理想模型。在“模型训练报告”界面，可观察训练的成绩，包括模型的准确性、损失、模型在 Wio Terminal 上的性能。

如果训练成绩不理想，可以返回训练模型第一步，选择其他规模的神经网络，或者调整参数的设置，再次训练，直到获得一个成绩理想的模型。

![](https://static.getiot.tech/wio-terminal-codecraft-gestures-recognition-007.png#center)

当我们获得一个较为理想的模型后，就可以点击“部署模型”。



### 4. 使用与编程

部署模型之后，我们还要编写模型使用程序才能在 Wio Terminal 上使用。

在“使用与编程”界面，点击“模型使用”即可使用已经部署的模型。

![](https://static.getiot.tech/wio-terminal-codecraft-gestures-recognition-008.png#center)

编写如下程序即可尝试使用你的模型。

![](https://static.getiot.tech/wio-terminal-codecraft-gestures-recognition-009.png#center)

点击“上传”按钮，将程序上传程序到 Wio Terminal。首次上传时间较长，且随模型复杂程度上传时间增长，请耐心等待。小模型上传时间大约为 4 分钟。

程序上传成功后，我们就可以在 Wio Terminal 上测试模型效果。需要说明的是，即使训练模型分数达到很高仍不代表模型就是好的模型，训练模型的分高而实际使用预测效果差的现象被称为过拟合（overfitting），相当于模型生硬记忆背诵了训练数据集的细节，在面临新的数据时不会做题了，这是机器学习训练模型会遇到的问题。

解决办法是：增加数据集、降低学习率，再重新训练模型。

