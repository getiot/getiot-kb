---
sidebar_position: 7
slug: /wio-terminal-hmi-for-pc
draft: true
---

# Wio Terminal 电脑显示器



本文主要介绍如何将 Wio Terminal 用作 PC 的人机交互界面（HMI）。与 [Wio Terminal 树莓派显示器](/wiot/wio-terminal-hmi-for-rpi/) 的方法不同，本文介绍使用 **Usermod SDK** 的方式实现 Wio Terminal 的 HMI 显示功能，因此该方法可用于 Windows、MacOS 和 Linux 系统。这也大大扩展了 Wio Terminal 在工业领域的用途和可能性。

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-HMI-SDK/banner.png#center)



## Wio Terminal 固件

First, you will need to upload an Arduino program to your Wio Terminal via your PC.

- Download the [**Seeed_Arduino_USBDISP**](https://github.com/Seeed-Studio/Seeed_Arduino_USBDISP) library here.

There are two **examples**, `NullFunctional` and `USBDisplayAndMouseControl`:

1. If you want **higher screen refresh rate on Wio Terminal**, upload **`NullFunctional`** to Wio Terminal.
2. If you want **Wio Terminal to also act as a USB Mouse**, upload **`USBDisplayAndMouseControl`** to Wio Terminal.

注意：Please **make sure read the notes**, for usermode SDK, `USBDISP().begin(true);` becomes `USBDISP().begin(true, true);`.

### `uf2` Method

For convenience, we also provide `uf2` methods of uploading Wio Terminal's firmware. Simply download the `uf2` files from below.

- Download the [NullFunctional](http://files.seeedstudio.com/wiki/Wio-Terminal-HMI-SDK/NullFunctional-sdk.uf2) `uf2` files.
- Download the [USBDisplayAndMouseControl](https://files.seeedstudio.com/wiki/Wio-Terminal-HMI-SDK/USBDisplayAndMouseControl-sdk.uf2) `uf2` files.

Entering the bootloader mode by sliding the power switch twice quickly. For more reference, please also see [here](https://wiki.seeedstudio.com/Wio-Terminal-Getting-Started/#faq).

An external drive named `Arduino` should appear in your PC. Drag the the downloaded uf2 files to the `Arduino` drive.



## Host Device 固件

This time our host device becomes our PC, let's walk through how you can use Wio Terminal as HMI display with the usermode SDK!

### MacOS/Linux OS - C++ SDK

- Download the firmware repo:

```bash
cd ~
git clone https://github.com/Seeed-Studio/seeed-linux-usbdisp.git
```

- Navigate to the usermode sdk path:

```bash
cd ~/seeed-linux-usbdisp/drivers/usermode-sdk/rpusbdisp-drv/src
```

Open the `rpusbdisp.cc` and **define macros depending on your Wio Terminals firmware (Nullfunctional or USBDisplayAndMouseControl)**. Uncomment the one that you are using:

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-HMI-SDK/macros.png#center)

- Navigate back to the usermode sdk path:

```bash
cd ~/seeed-linux-usbdisp/drivers/usermode-sdk
```

- Make and build the driver:

```bash
make
```

注意：You may require some dependent library such as `lisusb`. MacOS can use [`brew`](https://brew.sh/) and Linux OS can use `apt-get` to install.

- Navigate the build directory:

```bash
cd ~/seeed-linux-usbdisp/drivers/usermode-sdk/build/
```

- Run the demo:

```bash
sudo ./rpusbdispdemo --demo 1
```

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-HMI-SDK/demo.gif#center)

You should see that Wio Terminal is starting to display, the graphics are drawn. The source code for this is under: `seeed-linux-usbdisp/drivers/usermode-sdk/demo/src/main.cc`.

#### 多屏幕显示

This C++ SDK also supports multiple screens (multiple Wio Terminals), for 2 screens usage simply run the demo 2:

```bash
sudo ./rpusbdispdemo --demo 2
```

**Note:** Here provides 4 demos up to using 4 screens, you may check the source code for referencing your applications.

### Windows - Python SDK

For Windows, you can run the usermode sdk on Python! First, make sure you have installed python and install the dependent library:

注意：**Python is cross-platform and you can run this demo on all platforms, including Windows/Linux/MacOS**

```bash
pip3 install pyusb
```

- Go to the python-demo path:

```bash
cd ~/seeed-linux-usbdisp/drivers/python-demo/
```

- Open the `simple-test.py` and define the right macros with the firmware inside your Wio Terminal, and save.

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-HMI-SDK/macros-2.png#center)

- Run the Python demo:

```bash
python3 simple-test.py
```

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-HMI-SDK/simple-test.gif#center)

#### 多屏幕显示

This Python SDK also supports multiple screens (multiple Wio Terminals), you may check the `USBDisplay.py` as reference.

This examples use 4 Wio Terminals as displays, which has a format looks like the following:

```bash
devices = list(usb.core.find(find_all=True, idVendor=0x2886, idProduct=0x802D))
dev1 = devices[0] # device 0
dev2 = devices[1] # device 1
dev3 = devices[2] # device 2
dev4 = devices[3] # device 3
```



## Simple Demo

This example simple transfer a image from PC side to the Wio Terminal using Python.

- Go to the demo path:

```bash
cd ~/seeed-linux-usbdisp/drivers/python-demo/
```

- Download the `image.jpg` and save it in the same location as `image-test.py`.

**Note:** Please **choose the macros that match your Wio Terminal firmware**, otherwise there will be an error.

- Run the demo:

```bash
python3 image-test.py
```

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-HMI-SDK/image-demo.png#center)



## 资源链接

- [rpusbdisp interface protocols document](https://files.seeedstudio.com/wiki/Wio-Terminal-HMI-SDK/rpusbdisp_interface_protocol.pdf)

