---
sidebar_position: 19
slug: /wio-terminal-daplink
draft: true
---

# Wio Terminal DAPLink 调试器



Now, we have **developed the DAPLink firmware running on your Arduino Boards**(*SAMD Series*) such as [Wio Terminal](https://www.seeedstudio.com/Wio-Terminal-p-4509.html) and [Seeeduino Xiao](https://www.seeedstudio.com/Seeeduino-XIAO-Arduino-Microcontroller-SAMD21-Cortex-M0+-p-4426.html) so that you can upload and debug development boards that support DAPLink in a most cost-effective way!



## 功能特性

- Debug and Flash Arm Cortex CPUs
- Provides a virtual serial port, eliminating the need for a usb to serial port
- Drag and drop to upload firmware(coming soon)



## Get Started

Please visit the Arduino DAPLink Get Started Wiki [here](https://wiki.seeedstudio.com/Arduino-DAPLink/).

### uf2 方法

For convenience, we also provide `uf2` methods of uploading Wio Terminal's firmware. Simply download the `uf2` files from below.

- Download the [**simple_daplink_wt**](https://files.seeedstudio.com/wiki/Wio-Terminal/res/simple_daplink_wt.uf2) `uf2` files.

Entering the bootloader mode by sliding the power switch twice quickly. For more reference, please also see [here](https://wiki.seeedstudio.com/Wio-Terminal-Getting-Started/#faq).

An external drive named `Arduino` should appear in your PC. Drag the the downloaded uf2 files to the `Arduino` drive.



### 硬件连接

下面是引脚连接示意图：

![img](https://files.seeedstudio.com/wiki/DAPLink/daplink-wt.jpg#center)

