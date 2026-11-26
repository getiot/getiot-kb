---
sidebar_position: 14
---

# 婴儿哭泣检测器



在夏天炎热的天气里，父母会不经意地把孩子留在车里，这太危险了。因此，ST（意法半导体）的工程师提出了一个简单的问题：我们能否利用现有技术防止此类悲剧的发生？因为处于困境中的孩子几乎总是会哭，所以发现他们的尖叫声可以触发警报。问题是，要想有效，应用程序必须精确。因此，人工智能是必要的，因为硬编码算法将起到巨大作用。此外，该平台需要足够强大的传感器来捕获高质量的数据。因此，ST工程师采用了SensorTile.box。

ST 公司基于 SensorTile.box 硬件平台和 STBLESensor  应用程序实现了一个名为「婴儿哭泣检测器」的项目。实际上，该应用程序是 STBLESensor 上众多演示中的一个，STBLESensor 是我们面向 iOS 和 Android 的移动工具。该应用程序与 SensorTile.box —— ST 最强大的传感器平台相结合。

![](https://static.getiot.tech/baby-crying-detector-process.jpg#center)

顾名思义，婴儿啼哭检测器检测婴儿是否在哭。SensorTile.box 使用 MP23ABS1 MEMS 麦克风录制 16 kHz 样本的声音。之后处理信号，再将其传递给运行在 STM32L4R9 上的机器学习算法。如果系统确定有孩子在哭，传感器板上的 LED 变绿，智能手机通过蓝牙接收警报。



## 获取数据

![](https://static.getiot.tech/baby-crying-detector-apps.jpg#center)

当 ST 工程师开始研究婴儿啼哭检测器时，他们遇到的第一个障碍是找到有用的训练数据。著名的格言“垃圾进，垃圾出”与机器学习特别相关。因此，我们的研究小组从梳理婴儿哭闹的数十小时录音开始。他们也意识到筛选数据同样重要。因此，有必要采集周围噪音、动物和成人哭泣的样本以及其他各类。



## 分辨误判

一旦 ST 团队觉得他们的数据集令人满意，他们就开始测试神经网络。初步评估令人鼓舞。然而，他们也意识到他们有一些反复出现的误判。其中一个发生在系统误认为狗的嚎叫是婴儿的哭声。为了解决这个问题，我们的团队在将音频信号发送到神经网络之前调整了音频信号的快速傅立叶变换。ST 工程师还实现了一个惯性探测系统。婴儿哭闹检测器开启条件是假设婴儿独自在车内，如果车辆在移动，就意味着有司机，警报就不会运行。当前的实现是相对基本的，但是开发人员可以使用 LSM6DSOX 的机器学习核心 SensorTile.box 在保持最小功耗的同时感知运动。



## 用 STM32 转换神经网络 Cube.AI

婴儿哭闹检测器的另一个突出特点是能够在 STM32L4 上运行机器学习算法。为了实现这样的壮举，ST 工程师使用了 STM32 Cube.AI。扩展软件将神经网络转换为 STM32 的优化代码。在这个例子中，我们的开发人员在 Keras 上创建了一个神经网络。基于 TensorFlow2.0，API 生成了一个 Python 库，用户可以使用 X-CUBE-AI 处理该库。结果是开发人员可以在主循环中调用的二进制文件。因此，婴儿啼哭检测器从麦克风中获取信号，将其发送到由 X-CUBE-AI 优化的神经网络，并返回系统是否检测到处于困境中的婴儿。



## 不是最终产品

婴儿哭闹探测器能防止一个孩子死亡吗？我们相信答案是“是的”，但我们也知道我们的开发还没有市场化。一家想要销售类似解决方案的公司将不得不收集更多的数据，并创建一个更复杂的神经网络来提高其准确性。然而，我们的应用程序显示了我们在短时间内可以完成的工作，并且使用了来自互联网的简单数据集。因此，婴儿啼哭探测器以一种非常真实的方式展示了人工智能和传感器的潜力，以及工程师在热衷于 SensorTile.box 以及 ST 生态系统。



## STBLESensor

STBLESensor 应用程序

![](https://www.st.com/bin/ecommerce/api/image.PF267396.en.feature-description-include-personalized-no-cpn-medium.jpg#center)

STBLESensor application is available for Android and iOS and shows the data exported by a BLE device using the BlueST protocol. The app shows different panels based on the data types exported by the firmware, including: environmental data, MEMS sensor fusion, plot, activity recognition, carry position, acceleration event, BlueVoice, speech to text, beamforming, sound source localization, pedometer, switch, motion intensity, compass, cloud logging, node status.

All the data received by the app can be logged in CVS files and exported by e-mail.

If the firmware supports the functionality, the application can also show a serial console to exchange string messages with the board. This functionality is also used to upgrade the board firmware.

Both Android and iOS applications support the Bluetooth secure pairing with pin.

For Android it is also possible to use an NFC tag to read the pin and trigger the connection with the node.

### 功能特性

- Sensor data reception and command transmission over Bluetooth Low Energy (BLE)
- Support for multiple STM32Cube function packs and boards
- Available on Android and iOS app stores
- Cross-platform user interface and functionality
- Based on BlueST-SDK library
- Data logging support
- Data plotting support
- Included serial console (stdout/stdin/stderr) over Bluetooth
- Secure pairing (with pin) support
- Data publishing on the cloud support

### 软件下载

- "ST BLE Sensor" Android application source code ：[https://github.com/STMicroelectronics/STBlueMS_Android](https://github.com/STMicroelectronics/STBlueMS_Android)
- "ST BLE Sensor" iOS application source code ：[https://github.com/STMicroelectronics/STBlueMS_iOS](https://github.com/STMicroelectronics/STBlueMS_iOS)
- Android apk 百度网盘链接：[https://pan.baidu.com/s/1UtIHH2aWomQXCWQ5K7sjhw](https://pan.baidu.com/s/1UtIHH2aWomQXCWQ5K7sjhw)，提取码：xxoc





## 参考

- [Baby Crying Detector: The Voice of Babies Left Alone in Cars (st.com)](https://blog.st.com/baby-crying-detector/)
- [STBLESensor - BLE sensor application for Android and iOS - STMicroelectronics](https://www.st.com/en/embedded-software/stblesensor.html)
- [SensorTile.Box 开箱即用物联网开发套件入门](https://www.arrow.com/zh-cn/research-and-events/videos/getting-started-with-the-sensortilebox-iot-dev-kit)

