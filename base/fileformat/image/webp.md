---
sidebar_position: 6
sidebar_label: WEBP 格式
slug: /webp
---

# WEBP 格式（Web优化）

**WEBP**（Web Picture）是 Google 2010 年基于 VP8 视频编码推出的图像存储模式，支持有损（预测编码）和无损（熵编码）压缩模式。相比 JPEG 节省 25%-35% 体积且支持 Alpha 透明，动画性能优于 GIF，现为 Chrome 生态和电商平台的首选图像格式，但 Safari 兼容性曾长期受限。



## 格式简介

WebP 是一种现代图像格式，由 Google 开发，旨在提供更好的压缩比和更丰富的功能。WebP 格式支持有损和无损压缩，以及动画和透明度，是 Web 图像优化的理想选择。

WebP 文件扩展名为 `.webp`，MIME 类型为 `image/webp`。WebP 格式基于 VP8 视频编码技术，利用帧内编码来压缩图像。



## 技术特点

### 压缩模式

WebP 支持三种压缩模式：

- **有损压缩**：使用预测编码，类似 VP8 视频编码
- **无损压缩**：使用熵编码和颜色缓存
- **动画**：支持多帧动画（类似 GIF）

### 核心特性

- **高压缩比**：比 JPEG 节省 25%-35% 文件体积
- **Alpha 通道**：支持透明度（类似 PNG）
- **动画支持**：支持多帧动画（类似 GIF）
- **元数据支持**：支持 EXIF 和 XMP 元数据
- **ICC 配置文件**：支持颜色配置文件

### 压缩算法

- **有损模式**：使用预测编码、变换编码和量化
- **无损模式**：使用颜色缓存、LZ77 和熵编码
- **动画模式**：每帧可以是有损或无损



## 文件结构

WebP 文件的基本结构：

```bash showLineNumbers
[RIFF 头]                # "RIFF" 标识 + 文件大小
[WEBP 标识]              # "WEBP" 标识
[VP8/VP8L/VP8X 块]      # 图像数据块
  - VP8：有损图像
  - VP8L：无损图像
  - VP8X：扩展格式（动画、透明度等）
[可选块]                 # 元数据、ICC 配置文件等
```

### 关键块说明

- **RIFF 头**：标识文件为 RIFF 格式
- **VP8**：有损压缩图像数据
- **VP8L**：无损压缩图像数据
- **VP8X**：扩展格式，支持动画和透明度



## 使用场景

### 适用场景

- **Web 图像优化**：网站图片、图标、缩略图
- **电商平台**：产品图片、商品展示
- **移动应用**：应用图标、界面元素
- **动画图像**：简单动画（替代 GIF）
- **需要透明度的图像**：Logo、图标

### 优缺点

**优点：**

- 压缩比高，文件体积小
- 支持透明度和动画
- 质量好，视觉损失小
- 现代浏览器广泛支持
- 适合 Web 使用

**缺点：**

- 某些旧浏览器不支持
- Safari 支持较晚（macOS 14+、iOS 14+）
- 编码速度相对较慢
- 某些工具支持有限



## 代码示例

### Python 处理 WebP

```python showLineNumbers
from PIL import Image

# 打开 WebP 图像
img = Image.open('image.webp')
print(f"图像尺寸: {img.size}")
print(f"图像模式: {img.mode}")

# 转换为 WebP
img.save('output.webp', 'WEBP', quality=85, method=6)

# 处理透明度
if img.mode == 'RGBA':
    # 保存带透明度的 WebP
    img.save('transparent.webp', 'WEBP', quality=90, lossless=False)
```

### Python 创建动画 WebP

```python showLineNumbers
from PIL import Image

# 创建动画 WebP
frames = [Image.open(f'frame{i}.png') for i in range(5)]
frames[0].save(
    'animation.webp',
    save_all=True,
    append_images=frames[1:],
    duration=200,  # 每帧延迟（毫秒）
    loop=0,  # 无限循环
    quality=85
)
```

### 命令行工具

```bash showLineNumbers
# 使用 cwebp 编码
cwebp -q 85 input.jpg -o output.webp
cwebp -lossless input.png -o output.webp

# 使用 dwebp 解码
dwebp input.webp -o output.png

# 使用 ffmpeg
ffmpeg -i input.jpg -c:v libwebp -quality 85 output.webp
```

### JavaScript 处理 WebP

```javascript showLineNumbers
// 在浏览器中检测 WebP 支持
function checkWebPSupport() {
    const canvas = document.createElement('canvas');
    canvas.width = 1;
    canvas.height = 1;
    return canvas.toDataURL('image/webp').indexOf('data:image/webp') === 0;
}

// 加载 WebP 图像
const img = new Image();
img.onload = function() {
    console.log(`图像尺寸: ${img.width} x ${img.height}`);
};
img.src = 'image.webp';
```



## 相关工具

- **图像编辑器**：
  - GIMP：支持 WebP 导入导出
  - ImageMagick：命令行图像处理工具
- **命令行工具**：
  - `cwebp`：WebP 编码器
  - `dwebp`：WebP 解码器
  - `gif2webp`：GIF 转 WebP
  - `webpmux`：WebP 动画工具
- **在线工具**：
  - Squoosh：Google 在线图像压缩工具
  - Cloudinary：图像优化服务
- **编程库**：
  - Python: `Pillow (PIL)`、`webp`
  - JavaScript: `sharp`、`imagemin-webp`
  - C/C++: `libwebp`



## 相关链接

- [WebP 官方网站](https://developers.google.com/speed/webp)
- [WebP 格式规范](https://developers.google.com/speed/webp/docs/riff_container)
- [WebP 工具下载](https://developers.google.com/speed/webp/download)



## 参考

- [WebP - Wikipedia](https://en.wikipedia.org/wiki/WebP)
- [WebP 格式详解](https://developers.google.com/speed/webp/docs/format)
- [WebP 压缩原理](https://developers.google.com/speed/webp/docs/compression)

