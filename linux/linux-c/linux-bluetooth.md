---
sidebar_position: 43
authors: [luhuadong]
---

# Linux BlueZ 蓝牙编程

在 Linux 系统中，**BlueZ** 是官方提供的 Bluetooth 协议栈，它提供了丰富的工具和 API，允许你在 C 语言中直接操作蓝牙设备。本文将带你了解 BlueZ 编程的基本原理、使用方法，以及实现一个简单的设备扫描示例。



## BlueZ 简介

BlueZ 是 Linux 官方的蓝牙协议栈实现，最初由 Qualcomm 开发，后来集成进了 Linux 内核。它支持：

- 蓝牙经典（BR/EDR）和低功耗蓝牙（BLE）
- HCI、L2CAP、RFCOMM、GATT 等协议
- 蓝牙设备的扫描、连接、通信、GATT 服务管理等

在用户空间，你可以通过以下方式进行蓝牙开发：

- 使用 **命令行工具**（如 `bluetoothctl`, `hcitool`，`btmgmt`）
- 使用 **D-Bus API**（面向高级语言如 Python）
- 使用 **C API（libbluetooth）**，这是最底层、最灵活的方式



## 环境准备

你需要安装以下开发包：

```bash
sudo apt install libbluetooth-dev bluetooth bluez
```

头文件主要是：

```c
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
```



## 设备扫描示例（HCI API）

下面是一个使用 BlueZ HCI 接口的经典蓝牙设备扫描示例：

```c showLineNumbers title="scan.c"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

int main() {
    inquiry_info *ii = NULL;
    int max_rsp, num_rsp;
    int dev_id, sock, len, flags;
    char addr[19] = {0};
    char name[248] = {0};

    dev_id = hci_get_route(NULL);
    if (dev_id < 0) {
        perror("hci_get_route");
        return 1;
    }

    sock = hci_open_dev(dev_id);
    if (sock < 0) {
        perror("hci_open_dev");
        return 1;
    }

    len  = 8;             // 扫描持续时间（1.28 * len 秒）
    max_rsp = 255;        // 最多返回设备数
    flags = IREQ_CACHE_FLUSH;
    ii = (inquiry_info*)malloc(max_rsp * sizeof(inquiry_info));

    num_rsp = hci_inquiry(dev_id, len, max_rsp, NULL, &ii, flags);
    if (num_rsp < 0) {
        perror("hci_inquiry");
        free(ii);
        close(sock);
        return 1;
    }

    for (int i = 0; i < num_rsp; i++) {
        ba2str(&(ii[i].bdaddr), addr);
        memset(name, 0, sizeof(name));
        if (hci_read_remote_name(sock, &(ii[i].bdaddr), sizeof(name), name, 0) < 0)
            strcpy(name, "[unknown]");
        printf("发现设备 %s  %s\n", addr, name);
    }

    free(ii);
    close(sock);
    return 0;
}
```

编译运行：

```bash
gcc scan.c -o scan -lbluetooth
./scan
```

这个程序将扫描周围的蓝牙设备并尝试读取它们的名称。



## 常见的 BlueZ API 功能

除了设备扫描，BlueZ C API 还支持：

| 功能                                     | 函数或接口                                          |
| ---------------------------------------- | --------------------------------------------------- |
| 打开本地蓝牙设备                         | `hci_open_dev()`                                    |
| 设置设备名称                             | `hci_write_local_name()`                            |
| 设置设备可见                             | `hci_write_scan_enable()`                           |
| 创建 RFCOMM 连接（串口）                 | `socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)` |
| BLE 通信（需要 GATT + D-Bus 或 gattlib） | 建议使用高级库或 D-Bus                              |



:::tip

如果你要做 BLE 开发（如连接 BLE 传感器、智能手表），建议使用 `gattlib`、`tinyb` 或直接使用 D-Bus API，因为 BLE 支持在底层并不完整。

:::



## RFCOMM（蓝牙串口）编程思路

如果你要用蓝牙模拟串口通信，流程如下：

1. 创建 `AF_BLUETOOTH + SOCK_STREAM + BTPROTO_RFCOMM` 类型的 socket；
2. 使用 `bind()` 绑定到本地地址；
3. 使用 `connect()` 连接远程蓝牙地址；
4. 使用 `read()` 和 `write()` 进行收发数据。

这部分和普通 socket 编程很相似。



## BlueZ 的使用建议

- **普通蓝牙通信（经典蓝牙）** 用 HCI + RFCOMM 就能胜任；
- **低功耗蓝牙 BLE 开发** 推荐用 D-Bus 或 Python 库（如 `pybluez`、`bluepy`）；
- 编程时注意蓝牙需要 `CAP_NET_RAW` 权限，或者使用 `sudo` 运行；
- 使用 `bluetoothctl` 命令行工具进行调试也很方便。



## 小结

在这篇教程中，你学习了：

- 什么是 BlueZ，它的作用和应用场景；
- 如何使用 BlueZ 的 C API 扫描附近的蓝牙设备；
- 蓝牙通信的基本流程和函数；
- RFCOMM 和 BLE 的简要编程思路；

通过 `hci_` 和 `bluetooth.h` 提供的接口，你可以构建底层蓝牙应用。但如果你要处理复杂蓝牙协议，建议了解 BlueZ 的 D-Bus 接口，或使用更高级的语言绑定库。
