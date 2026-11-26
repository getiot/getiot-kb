---
sidebar_position: 1
slug: /wio-terminal-usb-host
---

# Wio Terminal USB 主设备



本文主要介绍如何将 Wio-Terminal 用作一个 USB 主设备，这意味着你可以将 USB 设备插入 Wio-Terminal 并像计算机一样使用它！



## 安装依赖库

首先需要为 Wio Terminal 安装 USB Host 库 `USB_Host_Library_SAMD`。

1、在 `USB_Host_Library_SAMD` 的 [GitHub 仓库](https://github.com/gdsports/USB_Host_Library_SAMD) 下载 zip 包。

2、然后将 `USB_Host_Library_SAMD` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库...*，然后选择刚刚下载的 USB_Host_Library_SAMD.zip 文件。



## USB Host 配置

要在 Wio Terminal 上启用 USB 主机，需要先配置两个引脚。将 `PIN_USB_HOST_ENABLE` 引脚配置为 *LOW*，并将 `OUTPUT_CTR_5V` 引脚配置为 *HIGH*。

简单地，你可以在 `setup()` 函数添加以下代码：

```cpp showLineNumbers
digitalWrite(PIN_USB_HOST_ENABLE, LOW);
digitalWrite(OUTPUT_CTR_5V, HIGH);
```



## 在 Wio Terminal 上使用 USB 键盘

下面这个示例介绍了如何在 Wio Terminal 上使用 USB 键盘，这样我们就可以将数据从键盘输入到 Wio Terminal！

**特别提醒**：

- 要使用此示例，你需要一个 **USB OTG 适配器** 和 **USB 转串口模块**，其中 OTG 适配器用于连接键盘，USB 转串口模块以读取来自 Wio Terminal 的输出。
- 另外，需要对 USB Host 引脚进行配置（参考前面 ☝）。



### 实验步骤

1. 使用 Arduino IDE 编译下面示例代码，并上传到 Wio Terminal。
2. 拔下 Wio Terminal 中用于上传代码的 USB type-C 线缆。
3. 通过 OTG 适配器将 USB 键盘连接到 Wio Terminal 的 USB-C 端口。
   - **`Keyboard`** -> **`OTG Adaptor`** -> **`Wio Terminal(Type-C Port)`**
4. 将 USB 转串口模块连接到 Wio Terminal，引脚说明如下：（参考 [Wio Terminal IO 引脚](/wiot/wio-terminal-io/)）
   - **`TXD(USB to Serial Module)`** -> **`RXD(Pin 10 on Wio Terminal)`**
   - **`RXD(USB to Serial Module)`** -> **`TXD(Pin 8 on Wio Terminal)`**
   - **`3.3V(USB to Serial Module)`** -> **`3.3V(Pin 1 on Wio Terminal)`**
   - **`GND(USB to Serial Module)`** -> **`GND(Pin 6 on Wio Terminal)`**
5. 将 USB 转串口模块的另一端连接到你的计算机。提示：你可能需要下载该模块的 USB 驱动程序，以便你的计算机可以识别它。
6. 对于 Windows 用户，你可以打开设备管理器来检查它是否被识别（应该会出现一个新的 COM 端口）；对于 Mac 用户，可以在终端中使用 `ls /dev/cu.*` 来检查模块可用性；对于 Linux 用户，则使用 `ls /dev/tty*` 命令。
7. 打开串口工具查看数据。（有许多好用的串口工具可供选择，参考 [串口工具合集](/tools/all-of-serial-tools/)）

**重要提示**：由于 Wio Terminal 的 USB 端口被用作 USB Host 功能，所以要将另一个程序重新上传到 Wio Terminal 时，需要通过按两次电源按钮进入 Bootloader 模式（LED 会变暗），然后你才可以看到串口被识别的提示。



### 完整代码

```cpp showLineNumbers
#include <KeyboardController.h>
#define SerialDebug Serial1

// Initialize USB Controller
USBHost usb;

// Attach keyboard controller to USB
KeyboardController keyboard(usb);

void printKey();
 
// This function intercepts key press
void keyPressed() {
  SerialDebug.print("Pressed:  ");
  printKey();
}
 
// This function intercepts key release
void keyReleased() {
  SerialDebug.print("Released: ");
  printKey();
}
 
void printKey() {
  // getOemKey() returns the OEM-code associated with the key
  SerialDebug.print(" key:");
  SerialDebug.print(keyboard.getOemKey());
 
  // getModifiers() returns a bits field with the modifiers-keys
  int mod = keyboard.getModifiers();
  SerialDebug.print(" mod:");
  SerialDebug.print(mod);
 
  SerialDebug.print(" => ");
 
  if (mod & LeftCtrl)
    SerialDebug.print("L-Ctrl ");
  if (mod & LeftShift)
    SerialDebug.print("L-Shift ");
  if (mod & Alt)
    SerialDebug.print("Alt ");
  if (mod & LeftCmd)
    SerialDebug.print("L-Cmd ");
  if (mod & RightCtrl)
    SerialDebug.print("R-Ctrl ");
  if (mod & RightShift)
    SerialDebug.print("R-Shift ");
  if (mod & AltGr)
    SerialDebug.print("AltGr ");
  if (mod & RightCmd)
    SerialDebug.print("R-Cmd ");
 
  // getKey() returns the ASCII translation of OEM key
  // combined with modifiers.
  SerialDebug.write(keyboard.getKey());
  SerialDebug.println();
}
 
uint32_t lastUSBstate = 0;
 
void setup()
{
  SerialDebug.begin( 115200 );
  SerialDebug.println("Keyboard Controller Program started");
 
  if (usb.Init())
      SerialDebug.println("USB host did not start.");
 
  delay( 20 );
 
  //Coqnfigure pins to enable USB Host on Wio Terminal
  digitalWrite(PIN_USB_HOST_ENABLE, LOW);
  digitalWrite(OUTPUT_CTR_5V, HIGH);
}
 
void loop()
{
  // Process USB tasks
  usb.Task();
 
  uint32_t currentUSBstate = usb.getUsbTaskState();
  if (lastUSBstate != currentUSBstate) {
    SerialDebug.print("USB state changed: 0x");
    SerialDebug.print(lastUSBstate, HEX);
    SerialDebug.print(" -> 0x");
    SerialDebug.println(currentUSBstate, HEX);
    switch (currentUSBstate) {
      case USB_ATTACHED_SUBSTATE_SETTLE: SerialDebug.println("Device Attached"); break;
      case USB_DETACHED_SUBSTATE_WAIT_FOR_DEVICE: SerialDebug.println("Detached, waiting for Device"); break;
      case USB_ATTACHED_SUBSTATE_RESET_DEVICE: SerialDebug.println("Resetting Device"); break;
      case USB_ATTACHED_SUBSTATE_WAIT_RESET_COMPLETE: SerialDebug.println("Reset complete"); break;
      case USB_STATE_CONFIGURING: SerialDebug.println("USB Configuring"); break;
      case USB_STATE_RUNNING: SerialDebug.println("USB Running"); break;
    }
    lastUSBstate = currentUSBstate;
  }
}
```



## 在 Wio Terminal 上使用 USB 鼠标

既然 Wio Terminal 能识别 USB 键盘，那当然也能识别 USB 鼠标。下面示例，可以实现将数据从鼠标输入到 Wio Terminal！

```cpp showLineNumbers
#include <MouseController.h>
#define SerialDebug Serial1
 
uint32_t lastUSBstate = 0;
 
// Initialize USB Controller
USBHost usb;
 
// Attach mouse controller to USB
MouseController mouse(usb);
 
// variables for mouse button states
bool leftButton = false;
bool middleButton = false;
bool rightButton = false;
 
// This function intercepts mouse movements
void mouseMoved() {
  SerialDebug.print("Move: ");
  SerialDebug.print(mouse.getXChange());
  SerialDebug.print(", ");
  SerialDebug.println(mouse.getYChange());
}
 
// This function intercepts mouse movements while a button is pressed
void mouseDragged() {
  SerialDebug.print("DRAG: ");
  SerialDebug.print(mouse.getXChange());
  SerialDebug.print(", ");
  SerialDebug.println(mouse.getYChange());
}
 
// This function intercepts mouse button press
void mousePressed() {
  SerialDebug.print("Pressed: ");
  if (mouse.getButton(LEFT_BUTTON)) {
    SerialDebug.print("L");
    leftButton = true;
  }
  if (mouse.getButton(MIDDLE_BUTTON)) {
    SerialDebug.print("M");
    middleButton = true;
  }
  if (mouse.getButton(RIGHT_BUTTON)) {
    SerialDebug.print("R");
    rightButton = true;
  }
  SerialDebug.println();
}
 
// This function intercepts mouse button release
void mouseReleased() {
  SerialDebug.print("Released: ");
  if (!mouse.getButton(LEFT_BUTTON) && leftButton == true) {
    SerialDebug.print("L");
    leftButton = false;
  }
  if (!mouse.getButton(MIDDLE_BUTTON) && middleButton == true) {
    SerialDebug.print("M");
    middleButton = false;
  }
  if (!mouse.getButton(RIGHT_BUTTON) && rightButton == true) {
    SerialDebug.print("R");
    rightButton = false;
  }
  SerialDebug.println();
}
 
void setup()
{
  SerialDebug.begin( 115200 );
  SerialDebug.println("Mouse Controller Program started");
 
  if (usb.Init())
      SerialDebug.println("USB host did not start.");
 
  delay( 20 );
 
  //Coqnfigure pins to enable USB Host on Wio Terminal
  digitalWrite(PIN_USB_HOST_ENABLE, LOW);
  digitalWrite(OUTPUT_CTR_5V, HIGH);
}
 
void loop()
{
  // Process USB tasks
  usb.Task();
 
  uint32_t currentUSBstate = usb.getUsbTaskState();
  if (lastUSBstate != currentUSBstate) {
    SerialDebug.print("USB state changed: 0x");
    SerialDebug.print(lastUSBstate, HEX);
    SerialDebug.print(" -> 0x");
    SerialDebug.println(currentUSBstate, HEX);
    switch (currentUSBstate) {
      case USB_ATTACHED_SUBSTATE_SETTLE: SerialDebug.println("Device Attached"); break;
      case USB_DETACHED_SUBSTATE_WAIT_FOR_DEVICE: SerialDebug.println("Detached, waiting for Device"); break;
      case USB_ATTACHED_SUBSTATE_RESET_DEVICE: SerialDebug.println("Resetting Device"); break;
      case USB_ATTACHED_SUBSTATE_WAIT_RESET_COMPLETE: SerialDebug.println("Reset complete"); break;
      case USB_STATE_CONFIGURING: SerialDebug.println("USB Configuring"); break;
      case USB_STATE_RUNNING: SerialDebug.println("USB Running"); break;
    }
    lastUSBstate = currentUSBstate;
  }
}
```



