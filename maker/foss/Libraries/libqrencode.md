---
sidebar_position: 1
slug: /libqrencode
---

# libqrencode



Libqrencode 是一个快速、紧凑的二维码（QR Code）编码库，使用 C 语言设计，遵循 LGPL-2.1 开源许可证。

Libqrencode 接受一个字符串或数据块列表，然后在二维码符号中编码为位图数组。 虽然其他二维码应用程序生成图像文件，但使用 libqrencode 允许应用程序直接从原始位图数据渲染二维码符号。 该库还包含一个命令行实用程序 [qrencode](/linux-command/qrencode/)，可输出各种格式的 QR 码图像。

- GitHub 仓库：[https://github.com/fukuchi/libqrencode](https://github.com/fukuchi/libqrencode)



---



Libqrencode 支持 JIS（日本工业标准）X0510:2004 或 ISO/IEC 18004 中描述的二维码模型 2。该规范中的大部分功能都已实现，例如：

- 可以嵌入数字、字母、日文汉字 (Shift-JIS) 或任何 8 位代码
- 优化字符串编码
- 符号的结构化附加
- 微二维码（实验性）

