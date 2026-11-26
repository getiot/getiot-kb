---
sidebar_position: 5
slug: /wio-terminal-codecraft-wakeup-words-recognition
---

# Wio Terminal 麦克风识别唤醒词

![Wio Terminal TinyML 麦克风识别唤醒词](https://static.getiot.tech/wio-terminal-codecraft-wakeup-words-recognition.png#center)

## 项目概述

本模型使用 Wio Terminal 内置的麦克风收集人声唤醒词和环境音，使用 TinyML（通过 Codecraft）训练模型以实现用唤醒词（Hi wio）唤醒设备。

**期望效果**

当对着 Wio Terminal 喊 “**hi wio**” 时，Wio Terminal 可以实时响应。

**材料准备**

硬件方面只需要一台 Wio Terminal（内置麦克风）

**项目步骤**

正如 [Codecraft 操作说明](/wiot/wio-terminal-codecraft-instruction/) 所介绍，Wio Terminal 嵌入式机器学习项目包括 4 个步骤：

1. 创建与选择模型
2. 数据采集
3. 训练与部署
4. 使用与编程



## 项目步骤

### 1. 创建与选择模型

点击“创建与选择模型”，点击“内置麦克风识别唤醒词”，根据命名要求输入名称（例如 hi_wio），点击“确认”。

![](https://static.getiot.tech/wio-terminal-codecraft-wakeup-words-recognition-001.png#center)

点击确定后会自动跳转到“数据采集”界面。



### 2. 采集数据

“内置麦克风识别唤醒词”有 3 个默认标签：唤醒词（hi wio）、环境声（background）、其他词（other words）。

![](https://static.getiot.tech/wio-terminal-codecraft-wakeup-words-recognition-002.png#center)

我们需要使用 Wio Terminal 采集数据。连接 Wio Terminal 和电脑，在 Codecraft 的界面，点击 “上传”，此操作将上传默认采集数据程序到 Wio Terminal。

![](https://static.getiot.tech/wio-terminal-codecraft-wakeup-words-recognition-003.png#center)

选择目前的 Wio Terminal 对应的串口号，点击“确定”按钮，将上传默认采集数据程序到 Wio Terminal 设备。上传时间通常数十秒钟，完成后会看到下图所示的“上传成功”画面。

**提示**：对于网页版的 Codecraft ，需要提前安装并启用 Codecraft Assistant 设备助手。

接下来就可以采集数据了，在 Codecraft 页面右上角有数据采集步骤介绍，根据介绍指示采集数据。

![](https://static.getiot.tech/wio-terminal-codecraft-wakeup-words-recognition-004.png#center)

Wio Terminal 显示 OK 表示收集完毕，CodeCraft 此时仍在拼命加载中（可能持续十几秒），此段时间因为语音数据量较大，将其从 WioTerminal 传至 CodeCraft 时间较长，请耐心等待。

数据上传完毕后，可对录音数据进行裁剪，以获得更好的训练效果。之后点击“训练与部署”。

当然，你也可以添加自定义标签，以使得 Wio Terminal 识别更多词汇。



### 3. 训练与部署

选择适合的神经网络规模：小（small）中（medium）大（large）型其中一个。设置参数：训练周期数（training）、学习率（learning rate）、最低置信度（minimum confidence rating）。

点击“开始训练”按钮，开始训练模型。训练所需的时间与选择神经网络规模（小型中型大型）、训练周期数有关，网络规模越大所需时间越长，训练周期数越高所需时间亦越长，所以请耐心等待。

![](https://static.getiot.tech/wio-terminal-codecraft-wakeup-words-recognition-005.png#center)

加载完成后，可以在“输出日志”中看到“TrainModel Job completed”提示，表示模型训练任务已完成。

然后在“模型训练报告”界面，点击“部署模型”。弹窗提示部署完成，点击“确认”后，自动跳转到“使用与编程”界面。



### 4.使用与编程

部署模型之后，我们还要编写模型使用程序才能在 Wio Terminal 上使用。

在“使用与编程”界面，点击“模型使用”即可使用已经部署的模型。

![](https://static.getiot.tech/wio-terminal-codecraft-wakeup-words-recognition-006.png#center)

编写如下程序即可尝试使用你的模型。

![](https://static.getiot.tech/wio-terminal-codecraft-wakeup-words-recognition-007.png#center)

点击“上传”按钮，将程序上传程序到 Wio Terminal。首次上传时间较长，且随模型复杂程度上传时间增长，请耐心等待。小模型上传时间大约为 4 分钟。

程序上传成功后，我们就可以在 Wio Terminal 上测试模型效果。需要说明的是，即使训练模型分数达到很高仍不代表模型就是好的模型，训练模型的分高而实际使用预测效果差的现象被称为过拟合（overfitting），相当于模型生硬记忆背诵了训练数据集的细节，在面临新的数据时不会做题了，这是机器学习训练模型会遇到的问题。

解决办法是：增加数据集、降低学习率，再重新训练模型。

