---
sidebar_position: 7
slug: /wio-terminal-tinyml-edge-impulse
---

# Wio Terminal Edge Impulse 教程

![](https://static.getiot.tech/wio-terminal-edge-impulse.png#center)

[**Edge Impulse**](/dictionary/edge-impulse/) 可以帮助开发人员创建具有嵌入式机器学习的下一代智能设备解决方案。使得今天由于成本、带宽或功率限制而被丢弃的 99% 的传感器数据，在边缘人工智能技术的加持下，将得到有价值的利用。

好消息是，Edge Impulse 官方已经正式支持 Wio Terminal 了，这意味着我们可以使用 Wio Terminal 进行最前沿的机器学习！



## 安装依赖

要在 Edge Impulse 中使用 Wio Terminal，需要安装以下软件依赖：

1. [Node.js v12](https://nodejs.org/en/) 或更高版本，参考 [Node.js 安装](/nodejs/nodejs-installation/)

2. [Arduino CLI](https://arduino.github.io/arduino-cli/latest/)，Linux 和 macOS 可执行下面命令安装：

   ```bash
   curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
   ```

3. Edge Impulse CLI 和 serial monitor

   ```bash
   npm install -g edge-impulse-cli 
   ```

提示：如果安装 Edge Impulse CLI 时出现问题，请参考 [Installation and troubleshooting](https://docs.edgeimpulse.com/docs/cli-installation) 排除故障。



## 连接 Edge Impulse

安装好软件依赖之后，下一步就是将 Wio Terminal 开发板连接到 Edge Impulse 平台。



### 1. 更新 Wio Terminal 固件

连接 Wio Terminal 到你的电脑，将 Wio Terminal 的电源开关从“ON”位置进一步向下滑动，松开，再次滑动并松开（即快速向下滑动两次），进入 **Bootloader 模式**（DFU 模式）。

<img src="https://static.getiot.tech/Wio-Terminal-Bootloader.png" width="600" />

之后你会看到一个名为“Arduino”的外部驱动器出现在你的 PC 中。下载 [Edge Impulse uf2](https://github.com/Seeed-Studio/Seeed_Arduino_edgeimpulse/releases/tag/1.4.0) 固件文件，将其拖到 `Arduino` 驱动。这样，就把 Edge Impulse 加载到 Seeeduino Wio Terminal 啦！

**提示**：你可以下载 [Wio Terminal Edge Impulse](https://github.com/Seeed-Studio/Seeed_Arduino_edgeimpulse) 源代码，以便于修改和构建你的固件。



### 2. 设置 Keys

打开 Shell 终端，执行下面命令：

```bash
$ edge-impulse-daemon
```

**提示**：连接到新设备时，运行 `edge-impulse-daemon --clean` 以删除以前的缓存。

```bash
$ edge-impulse-daemon 
Edge Impulse serial daemon v1.14.0
? What is your user name or e-mail address (edgeimpulse.com)? rudy
? What is your password? [hidden]
Endpoints:
    Websocket: wss://remote-mgmt.edgeimpulse.com
    API:       https://studio.edgeimpulse.com/v1
    Ingestion: https://ingestion.edgeimpulse.com

[SER] Connecting to /dev/ttyACM0
[SER] Serial is connected, trying to read config...
[SER] Retrieved configuration
[SER] Device is running AT command version 1.3.0

Setting upload host in device... OK
Configuring remote management settings... OK
Configuring API key in device... OK
Configuring HMAC key in device... OK
[SER] Device is not connected to remote management API, will use daemon
[WS ] Connecting to wss://remote-mgmt.edgeimpulse.com
[WS ] Connected to wss://remote-mgmt.edgeimpulse.com
? What name do you want to give this device? wiot01
[WS ] Device "wiot01" is now connected to project "rudy-project-1"
[WS ] Go to https://studio.edgeimpulse.com/studio/73336/acquisition/training to build your machine learning model!
```



### 3. 验证设备是否连接成功

打开 [Edge Impulse](https://studio.edgeimpulse.com) 网页，点击左边导航栏的 Devices，查看设备是否连接成功。如果看到类似下面的信息，则说明 Wio Terminal 已成功连接 Edge Impulse 平台。

![](https://static.getiot.tech/wio-terminal-edge-impulse-device.png#center)

下面我们一起来制作第一个 Edge Impulse 项目，快速训练和部署一个简单的神经网络。我们以 [石头剪刀布手势识别](/wiot/wio-terminal-codecraft-gestures-recognition/) 为例，因为它足够简单，只需要用到 Wio Terminal 内置的[光传感器](/wiot/wio-terminal-light-sensor/)，即可对石头剪刀布手势进行分类。

视频：[Wio Terminal TinyML Course #1 Intro - Machine Learning on Microcontrollers with Arduino IDE](https://www.youtube.com/watch?v=iCmlKyAp8eQ)



## 采集训练数据

打开 Edge Impulse，切换到 Data acquisition 页面。添加标签（rock、paper、scissors），选择传感器，设置采样长度为 10000 ms（10秒），频率为 100Hz。

![](https://static.getiot.tech/wio-terminal-edge-impulse-training.png#center)

点击“Start sampling”开始采集数据，为每个手势采集 10 个样本（在 Wio Terminal 光传感器附近挥手即可）。

![](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/gif1.gif#center)

这是一个很小的数据集，但我们也有一个很小的神经网络，因此在这种特殊情况下，欠拟合比过拟合的可能性更大。

- **欠拟合**：当统计模型或机器学习算法无法捕捉数据的潜在趋势时，就会被称为欠拟合，这种情况主要出现在模型大小太小而无法为数据制定一般规则时，存在许多不同种类的噪声。
- **过拟合**：当统计模型开始从我们数据集中的噪声和不准确的数据条目中学习时，它被称为过拟合。当你拥有大型模型和相对较小的数据集时，就会发生这种情况 —— 模型可以“by heart”学习所有数据点，而无需进行泛化。

因此，在收集样本时，重要的是为模型提供多样性以便能够更好地泛化。例如具有不同方向、速度和距离传感器的样本。一般来说，网络只能从数据集中存在的数据中学习。因此，如果你拥有的唯一样本是传感器上方从左向右移动的手势，则不应期望经过训练的模型能够识别从右向左或向上、向下移动的手势。



## 构建机器学习模型

样本采集完成后，点击“Impulse design”创建一个“impulse”。这里的 Impulse 是 Edge Impulse 这个词，用来表示数据处理中的训练管道（training pipeline）。设置 Window size 为 1000 毫秒，Window increase 为 50 毫秒。

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/main.png#center)

这些设置意味着每次执行推理时，我们将进行 1000 毫秒的传感器测量。你的设备要进行多少次测量取决于频率。在数据收集期间，你将采样频率设置为 40 Hz，或每 1 秒 40 次。 因此，总而言之，你的设备将在 1000 毫秒内收集 40 个数据样本。时间窗口，然后取这些值，对它们进行预处理并将它们馈送到神经网络以获得推理结果。当然，我们在训练期间使用相同的窗口大小。对于这个概念验证项目，我们将尝试三种不同的具有默认参数的预置块（除了添加缩放）——**Flatten** 块，它需要计算原始数据在时间窗口内的平均值、最小值、最大值和其他函数。

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/image_ZEX5ydSwOS.jpeg#center)

**Spectral Features** 模块，可提取信号随时间变化的频率和功率特性。

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/image_7uXlLwjT3E.jpeg#center)

和原始数据块，正如你可能已经猜到的那样，它只是将原始数据提供给 NN 学习块（可选地对数据进行标准化）。

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/image.png#center)

我们将从 Flatten 块开始。 添加此块，然后添加神经网络 (Keras) 作为学习块，选中 Flatten 作为输入特征，然后单击 Save Impulse。 转到下一个选项卡，其中包含您选择的处理块的名称 - Flatten。 在缩放中输入 0.001，其他参数保持不变。 按保存参数，然后生成特征。

特征可视化是 Edge Impulse Web 界面中特别有用的工具，因为它允许用户通过图形洞察预置后数据的外观。 例如，这是 Flatten 处理块后的数据：

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/image_4tnpR9t34s.jpeg#center)

我们可以看到，不同类的数据点是大致划分的，但是rock和其他类之间有很多重叠，这会导致这两个类的问题和准确率不高。 生成并检查特征后，转到 NN 分类器选项卡。 用 2 个隐藏层训练一个简单的全连接网络，每个隐藏层有 20 和 10 个神经元，训练 500 个 epoch，学习率为 1e-4。 训练完成后，您将在混淆矩阵中看到测试结果，类似于：

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/flatten.png#center)

返回 Create Impulse 选项卡，删除 Flatten 块并选择 Spectral Features 块，生成特征（记住将缩放设置为 0.001！）并在 Spectral 特征数据上训练神经网络。 您应该会看到轻微的改善。

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/spectral.png#center)

Flatten 和 Spectral Features 块实际上都不是石头剪刀布手势识别任务的最佳处理方法。如果我们考虑一下，为了对石头剪刀布手势进行分类，我们只需要计算光传感器接收到“低于正常”值的次数和时间。如果它是一个相对较长的时间 - 那么它是岩石（拳头从传感器上方穿过）。如果是两次，那就是剪刀。除此之外的任何东西都是纸。听起来很简单，但保留时间序列数据对于神经网络能够在数据点中学习这种关系非常重要。 Flatten 和 Spectral Features 处理块都删除了每个窗口内的时间关系——Flatten 块只是将原始值按顺序依次转换为对时间窗口中的所有值计算的平均值、最小值、最大值等值，而不管它们的顺序. Spectral Features 模块提取频率和功率特性，它在这个特定任务中效果不佳的原因可能是每个手势的持续时间太短。因此，实现最佳性能的方法是使用原始数据块，它将保留时间序列数据。查看示例项目，其中我们使用了原始数据和卷积 1D 网络，与完全连接的网络相比，这是一种更专业的网络类型。我们能够在相同的数据上达到 92.4% 的准确率！

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/raw.png#center)

训练后的最终结果是

- Flatten FC 69.9 % accuracy
- Spectral Features FC 70.4 % accuracy
- Raw Data Conv1D 92.4 % accuracy

训练后，您可以使用实时分类选项卡测试模型，该选项卡将从设备收集数据样本，并使用 Edge Impulse 上托管的模型对其进行分类。我们使用三种不同的手势进行测试，就概念验证而言，其准确性令人满意。

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/live_class.png#center)



## 部署到 Wio Terminal

下一步是在设备上部署。 单击部署选项卡后，选择 Arduino 库并下载它。

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/deploy.png#center)

提取存档并将其放在您的 Arduino 库文件夹中。打开 Arduino IDE 并选择静态缓冲区草图（位于文件 -> 示例 -> 项目名称 -> static_buffer），它已经包含了所有用于分类的样板代码，并且您的模型就位。 整洁的！

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/example.png#center)

唯一需要填写的是设备上的数据采集。 我们将使用带有延迟的简单 for 循环来计算频率（如果您还记得我们在为训练数据集收集数据时有 25 毫秒的延迟）。

```cpp showLineNumbers
int raw_feature_get_data(size_t offset, size_t length, float *out_ptr)
{
    float features[40];
    
    for (byte i = 0; i < 40; i = i + 1)
    {
    	features[i] = analogRead(WIO_LIGHT);
    	delay(25);
    }
    memcpy(out_ptr, features + offset, length * sizeof(float));
    return 0;
}
```

当然，有更好的方法来实现这一点，例如传感器数据缓冲区，这将使我们能够更频繁地执行推理。 但我们将在本系列的后续文章中讨论这一点。

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-EI-1/gif3.gif#center)

虽然这只是概念演示的证明，但它确实表明 TinyML 正在做大事。 你可能知道可以使用相机传感器识别手势，即使图像缩小了很多。 但是识别只有 1 个像素的手势是完全不同的水平！
