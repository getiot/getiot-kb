---
sidebar_position: 2
slug: /wio-terminal-codecraft-instruction
---

# Wio Terminal Codecraft 操作说明



**Codecraft** 是一款由柴火创客教育基于 Scratch 3.0 开发的图形化编程软件工具，支持多款硬件，包括 Wio Terminal。并且可以用零代码的方式在 Wio Terminal 上完成 TinyML 嵌入式机器学习项目。本文主要介绍如何在 Codecraft 创建机器学习项目，训练模型并部署到 Wio Terminal 硬件设备上。

在开始操作之前，请参考[这里](/dictionary/codecraft/)安装相关软件，并参考下图连接 Wio Terminal 和你的电脑。

![](https://static.getiot.tech/wio-terminal-codecraft-connection.png#center)



## 创建 Wio Terminal 项目

在 Codecraft [首页](https://ide.tinkergen.com/)界面点击 Wio Terminal 的图标，进入 Wio Terminal 嵌入式机器学习开发页面，创建你的机器学习项目。

![](https://static.getiot.tech/wio-terminal-codecraft.png#center)

提示：模型的创建和使用都需要登录，未注册 Codecraft 用户请先注册。使用未在 [Edge Impulse](/dictionary/edge-impulse/)（机器学习模型训练平台）注册使用的邮箱注册 Codecraft 将会接收到 Edge Impulse 的邮件，使用手机注册和已在 Edge Impulse 注册使用的邮箱注册 Codecraft 则不会收到该邮件。



## 嵌入式机器学习基本过程

在 Codecraft 中，所有机器学习过程都是由以下 4 步组成：

1. **创建与选择模型**：根据所需使用的传感器创建模型。
2. **数据采集**：利用 Wio Terminal 采集数据。

1. **训练与部署**：利用已采集的数据训练模型，训练完成后，部署已经训练好的模型。
2. **使用与编程**：编写程序使用机器学习模型。



### 1. 创建与选择模型

点击“创建与选择模型”即可看到“为嵌入式机器学习创建新模型”的界面，点击对应图标即可创建使用对应传感器的模型。创建完成新模型，界面会自动跳转至“数据采集”界面。

![](https://static.getiot.tech/wio-terminal-codecraft-001.png#center)

点击“创建与选择模型”即可看到“我的模型”的界面，包含了所有已创建的模型，点击即可查看。

![](https://static.getiot.tech/wio-terminal-codecraft-002.png#center)



### 2. 数据采集

数据采集包含 4 个步骤：① 确认标签，② 上传默认采集数据程序，③ 采集数据，④ 整理数据（可选项）。

**① 确认标签**

数据采集界面右侧有默认标签，可以添加和删除标签。

- 添加自定义标签：点击“＋”。
- 删除标签：鼠标移至标签，标签的左上角会出现“×”，点击“×”即可删除。
- 修改标签：单击标签即会出现修改标签的弹窗。

![](https://static.getiot.tech/wio-terminal-codecraft-003.png#center)



**② 上传默认采集数据程序**

连接 Wio Terminal 并在 Codecraft 中上传默认采集数据程序。

数据采集界面编程区有默认采集数据程序，上传程序即可开启数据采集之旅。

![](https://static.getiot.tech/wio-terminal-codecraft-004.png#center)

若使用了自定义的标签，可添加或修改积木块的标签，再上传采集数据程序。

![](https://static.getiot.tech/wio-terminal-codecraft-005.png#center)

若需默认数据采集程序，可在按下图步骤查找，点击“默认数据采集程序”，界面就会出现默认数据采集程序。

![](https://static.getiot.tech/wio-terminal-codecraft-006.png#center)



**③ 采集数据**

数据采集界面右上角提供“数据采集步骤介绍”，跟着数据采集步骤介绍的动图或静态图及文字描述轻松学会如何采集数据。

![](https://static.getiot.tech/wio-terminal-codecraft-007.png#center)

例如：

![](https://static.getiot.tech/wio-terminal-codecraft-008.png#center)

注意：动图 gif 已加速，实际动作可稍微放慢。

每个动作需要进行多次采集，按下按键后开始采集，此时 Wio Terminal 的屏幕应亮起红灯，采集结束后显示 OK。

Wio Terminal 显示收集完毕即可停止采集数据，Codecraft 仍在拼命加载中，是将数据从 Wio Terminal 传至 Codecraft 可能需要几秒钟。

![](https://static.getiot.tech/wio-terminal-codecraft-009.png#center)



**④ 整理数据**（可选项）

采集数据后，标签右上角会提示已采集的数据总时长。若数据不符合预期，可以进行删除。

![](https://static.getiot.tech/wio-terminal-codecraft-010.png#center)

当然我们也可以对样本进行其他的操作：修改名称、修改标签、分割样本、下载。

![](https://static.getiot.tech/wio-terminal-codecraft-011.png#center)

已完成所有数据采集后，点击“训练与部署”，进入下一个步骤。

![](https://static.getiot.tech/wio-terminal-codecraft-012.png#center)



### 3. 训练与部署

训练与部署包括 4 个步骤：① 选择神经网络规模大小设置参数，② 开始训练，③ 观察模型性能选择理想模型，④ 部署理想模型。

**① 选择神经网络规模大小设置参数**

进入“训练与部署”界面后，可以选择适合的神经网络规模：小（small）中（medium）大（large）型其中一个。

然后设置参数，设置训练周期数（training）为正整数，学习率（learning rate）为 0-1 的数，最低置信度（minimum confidence rating）为 0-1 的数。Codecraft 中提供了默认的参数值。

![](https://static.getiot.tech/wio-terminal-codecraft-013.png#center)

可在“样本数据”中观察已采集的数据样本。

![](https://static.getiot.tech/wio-terminal-codecraft-014.png#center)

点击可切换观察不同的数据。

![](https://static.getiot.tech/wio-terminal-codecraft-015.png#center)

**② 开始训练**

点击“开始训练”，即可训练模型。

![](https://static.getiot.tech/wio-terminal-codecraft-016.png#center)

训练过程中“日志输出”界面会输出训练日志。可通过观察“日志输出”推理训练还需花费时间。如下图，已完成“Epoch：62/500”说明总共需训练 500 轮，已训练了 62 轮。

![](https://static.getiot.tech/wio-terminal-codecraft-017.png#center)

加载完成后，能在“输出日志”中看到“模型训练任务已完成”，此时界面新增“模型训练报告”。

![](https://static.getiot.tech/wio-terminal-codecraft-018.png#center)



**③ 观察模型性能选择理想模型**

在“模型训练报告”界面，可观察训练的成绩，包括模型的准确性、损失、模型在 Wio Terminal 上的性能。

如果训练成绩不理想，可以返回训练模型第一步，选择其他规模的神经网络，或者调整参数的设置，再次训练，直到获得一个成绩理想的模型。

![](https://static.getiot.tech/wio-terminal-codecraft-019.png#center)

**④ 部署理想模型**

在“模型训练报告”界面，点击“部署模型”。

![](https://static.getiot.tech/wio-terminal-codecraft-020.png#center)

弹窗提示部署完成，点击“确认”后，自动跳转到“使用与编程”界面。

![](https://static.getiot.tech/wio-terminal-codecraft-021.png#center)



### 4. 使用与编程

**① 编写模型使用程序**

模型训练完成后，需要编写程序以使用该模型。首先，在“使用与编程”界面，点击“模型使用”即可使用已经部署的模型。

![](https://static.getiot.tech/wio-terminal-codecraft-022.png#center)

编写如下程序即可尝试使用你的模型

![](https://static.getiot.tech/wio-terminal-codecraft-023.png#center)

**② 上传程序至 Wio Terminal**

点击“上传”按钮将程序上传到 Wio Terminal。

![](https://static.getiot.tech/wio-terminal-codecraft-024.png#center)

选择目前的 Wio Terminal 对应的串口号（未必如图中的 COM20），点击“确定”按钮。

![](https://static.getiot.tech/wio-terminal-codecraft-025.png#center)

首次上传时间较长，且随模型复杂程度上传时间增长，请耐心等待。小模型上传时间大约为 4 分钟。

上传完成即可测试模型在 Wio Terminal 上的效果。



## 保存

为了方便日后查看作品，可点击 Codecraft 上方的标题栏修改作品名称，并保存作品。

![](https://static.getiot.tech/wio-terminal-codecraft-026.png#center)

之后可以在“我的作品”中找到它。

![](https://static.getiot.tech/wio-terminal-codecraft-027.png#center)



## 示例教程

为了帮助用户理解整个嵌入式机器学习的使用，我们提供了4个模板模型，您可以根据这些模板模型的示例，学习如何使用 Codecraft 进行嵌入式机器学习，当然，我们希望这些示例能起到抛砖引玉的作用，帮你构建跟多有趣的应用。

- [Wio Terminal 内置加速度器动作识别](/wiot/wio-terminal-codecraft-motion-recognition/)
- [Wio Terminal 内置光传感器手势识别](/wiot/wio-terminal-codecraft-gestures-recognition/)
- [Wio Terminal 内置麦克风识别唤醒词](/wiot/wio-terminal-codecraft-wakeup-words-recognition/)
- [Wio Terminal 外接多通道气体传感器识别味道](/wiot/wio-terminal-codecraft-smell-recognition/)

