---
sidebar_position: 7
slug: /avif
---

# AVIF 格式（新一代图片）


**AVIF**（AV1 Image File Format）是一种基于 AV1 编码的视频压缩技术的图像文件格式，由 Alliance for Open Media（简称 AOM，开放媒体联盟）开发。它是一种现代、高效的图像格式，具有出色的压缩比和画质，特别适用于需要高质量图像和低存储空间的场景。相对于JPEG、WEBP 等图片格式，AVIF 的压缩率更高，画面细节更好。



## 发展历史

AVIF 图像格式最早由开放媒体联盟（AOM）与 Google、Cisco 以及 Xiph.org 合作开发，从设计之初，这种格式就被定义为一种开源且免版税的图像格式，而不像 JPEG XR 那样（一种压缩非常小但需要昂贵许可才能实现的文件格式）。AVIF 在 2019 年正式引入，旨在提供一种高效替代传统图像格式（如 JPEG 和 PNG）的解决方案。

- **起源**：基于开放且免版税的视频编码格式 AV1。
- **标准化**：由 AOM 开发，并被多家技术巨头支持，如 Google、Netflix 和 Mozilla。
- **发展趋势**：迅速成为 Web 和移动应用中图片优化的主流格式之一。



## 主要特点

AVIF 是一种基于开源 AV1 视频编解码器的新型开放图像格式。这种格式非常灵活，因为它支持任何图像编解码器，支持有损和无损编码，能够使用 alpha 通道，甚至能够存储一系列动画帧，就像高质量 gif 动画一样。同时，它也是最早支持 HDR 颜色的图像格式之一，提供更高的亮度、颜色位深度和颜色色域。

1. **高效压缩**：
   - 通过 AV1 的帧内编码实现高质量压缩。
   - 在相同文件大小下，比 JPEG 提供更高的视觉质量。
2. **HDR 支持**：
   - 支持 10 位和 12 位色深，适合高动态范围（HDR）显示。
3. **透明度支持**：
   - 像 PNG 一样支持透明背景，非常适合设计工作。
4. **免版税**：
   - 开放标准，无需支付专利费用，鼓励广泛应用。



## 文件结构

AVIF 文件基于 ISO 基础媒体文件格式（ISO/IEC 14496-12），包含以下核心部分：

1. **文件头（Header）**：元数据，包括文件版本和兼容性信息。
2. **元数据盒（Metadata Boxes）**：描述图像信息，如颜色空间和编码参数。
3. **图像数据（Image Data）**：存储经过 AV1 编码的图像内容。
4. **辅助数据（Auxiliary Data）**：如透明通道或图像缩略图。



## 示例

使用 ffmpeg 将 PNG 转换为 AVIF：

```bash
ffmpeg -i input.png -c:v libaom-av1 output.avif
```

加载 AVIF 图像示例（Python Pillow 库）：

```python
from PIL import Image

# 加载 AVIF 图像
img = Image.open("example.avif")
img.show()
```



## 相关链接

- [What is AVIF?](https://aomedia.org/specifications/avif/)
- [libavif 库代码仓库](https://github.com/AOMediaCodec/libavif)

