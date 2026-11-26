---
sidebar_position: 4
slug: /wio-terminal-quick-start
---

# Wio Terminal 快速上手



## 硬件连接

准备材料：

- Wio Terminal x 1
- 电脑 x 1
- USB Type-C数据线 x 1

通过 USB 数据线将 Wio Terminal 连接到计算机，这时您应该发现板背面的蓝色 LED 点亮。

<img src="https://static.getiot.tech/Wio-Terminal-Powerup.png" width="400"/>



## 软件环境

### 安装 Arduino IDE



**打开Blink示例**

打开LED闪烁示例项目: **File（文件） > Examples（示例） >01.Basics > Blink**



将Wio Terminal添加到您的Arduino IDE

点击 **File（文件） > Preference（偏好设置）** ，并将以下网址复制到 **Additional Boards Manager URLs** 中：

```bash
https://files.seeedstudio.com/arduino/package_seeeduino_boards_index.json
```

点击 **Tools（工具） > Board（开发板）> Boards Manager...** ，在搜索栏中搜索关键字 **Wio Terminal** 后，点击并安装它。

**选择您的板和端口**

您需要在 **Tools（工具）> Board（开发板）** 菜单中选择与您的Arduino相对应的条目。 选择 **Wio Terminal**.

从 **Tools（工具） | Serial Port（端口）** 中选择Wio Terminal的串行设备。它应该COM3或数字更大的串口（**COM1** 和 **COM2** 通常为硬件串行端口保留）。如果您不知道是哪个，您可以断开Wio Terminal并重新打开菜单; 消失的条目应该是它的串口。重新连接电路板并选择该串行端口。

**上传程序**

现在，只需单击工具栏中的 **上传（Upload）** 按钮，等待几秒程序上传成功之后，状态栏中将显示“完成上传（Done uploading.）”的信息。

上传完成几秒钟后，您应该会看到Wio Terminal背面的LED开始闪烁。 如果LED闪烁了的话，恭喜！您已经启动并运行了Wio Terminal。如果遇到问题，请参阅故障排除建议。

请随时阅读Wio Terminal的其他教程，并开始构建属于您自己的IoT项目吧！