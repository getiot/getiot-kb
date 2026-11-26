---
sidebar_position: 1
slug: /wio-terminal-network-firmware
---

# Wio Terminal 网卡固件更新



本文主要介绍如何更新 Wio-Terminal 中的无线网卡 Realtek RTL8720 核心固件，同时介绍如何安装无线网络连接需要的依赖库。

为什么要更新固件？—— 因为官方将 WiFi 固件移到了新的 eRPC 结构，这意味着无线连接更稳定，同时可以与蓝牙一起工作。为了避免使用 WiFi 和蓝牙无线网络时出现不必要的错误，建议更新 Wio-Terminal 的 eRPC WiFi 固件和相关库。



## 更新 Wireless Core 固件

首先，我们需要更新 Wio Terminal 上无线网卡 Realtek RTL8720 的核心固件。**这是必不可少的，在学习和运行 WiFi 和蓝牙的示例之前必须更新到最新固件**。下面是更新固件的步骤。

### 第 1 步：擦除初始的出厂固件

当我们第一次拿到 Wio Terminal 开发板时，首先需要擦除初始 RTL8720 固件并刷新最新固件。为了轻松完成这一工作，SeeedStudio 为我们准备了一个名为 **ambd_flash_tool** 的工具。它是一个 Python 脚本工具，运行时首先会建立从 SAMD51 到 RTL8720 的串口通信链路，以便将固件安装在 RTL8720 上。这样做是因为我们不能直接与 RTL8720 通信，只能由 SAMD51 代理。建立串口通信后，这个工具就可以擦除 RTL8720 上的现有固件，并刷新最新固件。

下面以 Ubuntu 系统为例进行说明。

**步骤 1**：打开一个 Shell 终端，执行下面命令下载 ambd_flash_tool 工具，并切换目录。

```bash
git clone https://github.com/Seeed-Studio/ambd_flash_tool
cd ambd_flash_tool
```

**步骤 2**：将 Wio Terminal 连接到 PC 上，并上电。

**步骤 3**：安装 ambd_flash_tool 工具所需的依赖。

```bash
pip3 install -r requirements.txt
```

**步骤 4**：执行下面命令开始擦除初始固件。

```bash
python3 ambd_flash_tool.py erase
```

**步骤 5**：耐心等待。在此过程中串口会断开并自动连接上，如果看到下面提示则说明固件擦除成功。

```bash
Verify successful
Done in 0.293 seconds
writeWord(addr=0xe000ed0c,value=0x5fa0004)
wait...
wait...
wait...
Flashing...
All images are sent successfully!
Image tool closed!

Success!
```

**提示**：执行 `python3 ambd_flash_tool.py` 可以查看该工具的使用说明。

```bash
Usage: ambd_flash_tool.py [OPTIONS] COMMAND [ARGS]...

  RTL872XD Flash tool

  This tool is used to burn rtl8720d firmware.

Options:
  --version  Show the version and exit.
  --help     Show this message and exit.

Commands:
  erase
  flash
```



### 第 2 步：烧写最新的固件

擦除初始固件之后，我们就可以为 RTL8720 烧写最新的固件了。执行下面命令：

```bash
python3 ambd_flash_tool.py flash
```

稍等片刻，看到下面提示则说明新固件烧写成功。

```bash
Verify successful
Done in 0.290 seconds
writeWord(addr=0xe000ed0c,value=0x5fa0004)
wait...
wait...
wait...
copy img to workspace...
Flashing...
All images are sent successfully!
Image tool closed!

Success!
```



### 烧写旧固件（可选）

有时候，你可能需要使用旧固件版本来测试你的代码，所以这里也介绍一下如何烧写旧固件。

- **步骤 1**：访问 [**RTL8720 Firmware**](https://github.com/Seeed-Studio/seeed-ambd-firmware/releases) GitHub 仓库；
- **步骤 2**：选择你需要的固件版本，并下载 ZIP 包，命名如 **xxx-seeed-ambd-firmware-rpc-vxxx.zip**；
- **步骤 3**：打开 Shell 终端，切换到 **ambd_flash_tool** 目录，执行下面命令。

```bash
python3 ambd_flash_tool.py flash -d [RTL8720-firmware-path]
```

**注意**：将 `[RTL8720-firmware-path]` 替代为你刚才下载的 RTL8720 固件路径。里面包含三个文件：`km0_boot_all.bin`、`km0_km4_image2.bin` 和 `km4_boot_all.bin`。

如果一切顺利，应该会看到一条成功的消息。说明已经将 RTL8720 固件刷入 RTL8720 内核！



## 安装依赖库

为了顺利使用 Wio Terminal 的无线连接功能，我们还需要安装一些 Arduino 库。打开 Arduino 库管理器，搜索下面关键字安装所有最新的库。

| 关键字           | Arduino 库                                                   |
| ---------------- | ------------------------------------------------------------ |
| seeed rpcwifi    | [Seeed_Arduino_rpcWiFi](https://github.com/Seeed-Studio/Seeed_Arduino_rpcWiFi) |
| seeed rpcunified | [Seeed_Arduino_rpcUnified](https://github.com/Seeed-Studio/Seeed_Arduino_rpcUnified) |
| seeed mbedtls    | [Seeed_Arduino_mbedtls](https://github.com/Seeed-Studio/Seeed_Arduino_mbedtls) |
| seeed fs         | [Seeed_Arduino_FS](https://github.com/Seeed-Studio/Seeed_Arduino_FS) |
| seeed sfud       | [Seeed_Arduino_SFUD](https://github.com/Seeed-Studio/Seeed_Arduino_SFUD) |



## 检查 RTL8720 固件版本

更新完 RTL8720 固件，并且安装好 Arduino 库，我们就可以在 Arduino IDE 中输入以下代码，编译上传到 Wio Terminal，检查固件是否安装正确。

```cpp showLineNumbers
#include "rpcWiFi.h"

void setup() {
    Serial.begin(115200);
    while(!Serial); // Wait to open Serial Monitor
    Serial.printf("RTL8720 Firmware Version: %s", rpc_system_version());
}

void loop() {}
```

打开 Serial Monitor（串口监视器），可以看到打印出 RTL8720 固件版本。

![](https://static.getiot.tech/wio-terminal-check-RTL8720-Firmware-Version.png#center)



## 升级 SAMD ArduinoCore

最后，为了避免不必要的错误，请定期更新 Wio Terminal 的固件（Seeed SAMD ArduinoCore）。

升级步骤：点击 *Tools（工具） > Board（开发板）> Boards Manager…* ，打开“开发板管理器”，在搜索栏中搜索关键字 **Wio Terminal** 后，点击并安装 **Seeed SAMD Boards** 最新版本。

![](https://static.getiot.tech/Arduino-IDE-Board-Manager-add-Wio-Terminal.png#center)

你可以在[这里](https://github.com/Seeed-Studio/ArduinoCore-samd)查看 Seeed SAMD ArduinoCore 的代码。

