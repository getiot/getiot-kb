---
sidebar_position: 1
slug: /libqrencode
---

# libqrencode

**libqrencode** 是一个快速、紧凑的二维码（QR Code）编码库，使用 C 语言设计，遵循 LGPL-2.1 开源许可证。它支持将字符串或数据块编码为二维码，并以位图数组的形式输出，适用于嵌入式系统、桌面应用和命令行工具等多种场景。

libqrencode 库还包含一个命令行实用程序 [qrencode](/linux-command/qrencode/)，可输出各种格式的 QR 码图像。



## 主要特点

- **高性能与轻量级**：libqrencode 采用纯 C 实现，体积小，执行效率高，适合资源受限的系统。
- **支持多种编码模式**：支持数字、字母、8 位字节和日文汉字（Shift-JIS）等编码模式，满足多样化的数据编码需求。
- **结构化附加功能**：支持结构化附加（Structured Append），可将大数据分割为多个二维码，便于扫描器合并读取。
- **命令行工具**：提供 `qrencode` 命令行工具，可生成 PNG、EPS 等格式的二维码图像，方便快速使用。
- **开源许可**：遵循 LGPL 2.1 许可证，适合商业和开源项目集成。



## 安装与使用

在 Ubuntu 系统中，可以通过以下命令安装：

```bash
sudo apt-get install libqrencode-dev
```

或者从源代码编译安装：

```bash
git clone https://github.com/fukuchi/libqrencode.git
cd libqrencode
./configure
make
sudo make install
```

如果你使用 Windows 系统，可以通过 [vcpkg](https://vcpkg.io/en/package/libqrencode) 包管理器安装：

```bash
vcpkg install libqrencode
```

以下是一个简单的 C 语言示例，展示如何使用 libqrencode 生成二维码：

```c showLineNumbers
#include <qrencode.h>
#include <stdio.h>

int main() {
    const char *text = "https://example.com";
    QRcode *qrcode = QRcode_encodeString(text, 0, QR_ECLEVEL_Q, QR_MODE_8, 1);
    if (qrcode) {
        // 处理 qrcode->data，生成图像或其他操作
        QRcode_free(qrcode);
    } else {
        fprintf(stderr, "Failed to encode QR code.\n");
    }
    return 0;
}
```

在上述代码中，`QRcode_encodeString` 函数用于将字符串编码为二维码。参数说明如下：

- `text`：要编码的字符串。
- `version`：二维码版本，取值范围为 0（自动选择）到 40。
- `level`：纠错级别，可选值为 `QR_ECLEVEL_L`、`QR_ECLEVEL_M`、`QR_ECLEVEL_Q`、`QR_ECLEVEL_H`。
- `mode`：编码模式，可选值为 `QR_MODE_8`（8 位字节模式）等。
- `casesensitive`：是否区分大小写，1 表示区分，0 表示不区分。



## 常用 API

将字符串编码为二维码：

```c
QRcode_encodeString(const char *string, int version, QRecLevel level, QRencodeMode hint, int casesensitive)
```

以 8 位字节模式编码字符串：

```c
QRcode_encodeString8bit(const char *string, int version, QRecLevel level)
```

编码包含 NUL 字符的数据：

```c
QRcode_encodeData(const unsigned char *data, int length, int version, QRecLevel level)
```

编码自定义输入数据：

```c
QRcode_encodeInput(QRinput *input)
```

释放 QRcode 对象：

```c
QRcode_free(QRcode *qrcode)
```

此外，libqrencode 还提供了结构化附加的相关函数，如 `QRcode_encodeStringStructured` 和 `QRcode_List_free`，用于处理分割的大数据集。



## 相关链接

- [libqrencode 代码仓库（GitHub）](https://github.com/fukuchi/libqrencode)
