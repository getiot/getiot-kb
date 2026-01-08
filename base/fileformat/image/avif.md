---
sidebar_position: 7
sidebar_label: AVIF 格式
slug: /avif
---

# AVIF 格式（新一代图片）

**AVIF**（AV1 Image File Format）是基于 AV1 视频压缩技术的图像文件格式，由 Alliance for Open Media（简称 AOM，开放媒体联盟）开发。它是一种现代、高效的图像格式，具有出色的压缩比和画质，支持 10/12 bit 色深、HDR 和广色域（BT.2020），采用分块编码和内容自适应优化，压缩效率比 JPEG 高 50% 以上。特别适用于需要高质量图像和低存储空间的场景，现已成为 Netflix 等流媒体平台的新一代图像标准，但解码复杂度较高。



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



## 使用场景

### 适用场景

- **Web 图像优化**：网站图片、产品图片
- **流媒体平台**：Netflix、YouTube 等平台
- **移动应用**：应用图标、界面元素
- **高质量图像存储**：需要高质量和低体积的场景
- **HDR 图像**：高动态范围图像

### 优缺点

**优点：**

- 压缩效率极高，比 JPEG 高 50% 以上
- 支持 HDR 和广色域
- 支持透明度和动画
- 开源免费，无专利限制
- 质量优秀

**缺点：**

- 解码复杂度较高
- 某些旧浏览器不支持
- 编码速度相对较慢
- 某些工具支持有限



## 代码示例

### Python 处理 AVIF

```python showLineNumbers
from PIL import Image

# 注意：Pillow 需要 pillow-avif-plugin 支持 AVIF
try:
    from pillow_avif import register_avif_opener
    register_avif_opener()
    
    # 打开 AVIF 图像
    img = Image.open('image.avif')
    print(f"图像尺寸: {img.size}")
    print(f"图像模式: {img.mode}")
    
    # 转换为其他格式
    img.save('output.jpg', 'JPEG', quality=95)
except ImportError:
    print("需要安装 pillow-avif-plugin: pip install pillow-avif-plugin")
```

### 命令行工具

```bash showLineNumbers
# 使用 ffmpeg
ffmpeg -i input.jpg -c:v libaom-av1 -still-picture 1 output.avif
ffmpeg -i input.avif output.jpg

# 使用 libavif 工具
avifenc -c aom -s 4 input.png output.avif
avifdec output.avif output.png

# 使用 ImageMagick
magick convert input.jpg output.avif
magick convert input.avif output.jpg
```



## 相关工具

- **图像编辑器**：
  - GIMP：支持 AVIF（需要插件）
  - ImageMagick：支持 AVIF
- **命令行工具**：
  - `avifenc`：AVIF 编码器
  - `avifdec`：AVIF 解码器
  - FFmpeg：支持 AVIF
- **在线工具**：
  - Squoosh：Google 在线图像压缩工具
- **编程库**：
  - Python: `pillow-avif-plugin`、`pyavif`
  - C/C++: `libavif`
  - JavaScript: `sharp`（支持 AVIF）



## 相关链接

- [AVIF 官方网站](https://aomedia.org/av1/avif/)
- [AVIF 规范](https://aomedia.org/av1/avif/)
- [libavif 库代码仓库](https://github.com/AOMediaCodec/libavif)



## 参考

- [AVIF - Wikipedia](https://en.wikipedia.org/wiki/AV1#AV1_Image_File_Format_(AVIF))
- [AVIF 格式详解](https://aomedia.org/av1/avif/)
- [AVIF vs JPEG 对比](https://jakearchibald.com/2020/avif-has-landed/)

