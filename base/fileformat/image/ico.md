---
sidebar_position: 4
sidebar_label: ICO 格式
slug: /ico
---

# ICO 格式（图标文件）

**ICO**（Icon，图标格式）格式由微软 1985 年为 Windows 1.0 设计，支持多分辨率（16×16 至 256×256）和多色深（24 bit + 8 bit Alpha）图标封装。采用 BMP 或 PNG 压缩数据块，文件包含多个图像层以适配不同显示环境，是 Windows 系统图标和网站 Favicon 的强制格式。

:::tip

ICO 格式可以利用应用程序 [ACDSee](https://www.acdsee.com) 打开。

:::



## 格式简介

ICO 是 Windows 操作系统使用的图标文件格式。ICO 文件可以包含多个不同尺寸和色深的图像，系统会根据显示环境自动选择最合适的图像。ICO 格式也被广泛用于网站 Favicon。

ICO 文件扩展名为 `.ico`，MIME 类型为 `image/x-icon` 或 `image/vnd.microsoft.icon`。



## 技术特点

### 核心特性

- **多分辨率**：一个文件可以包含多个尺寸的图像
- **多色深**：支持不同色深的图像
- **Alpha 通道**：支持透明度
- **自适应选择**：系统自动选择最合适的图像

### 支持的尺寸

ICO 格式支持多种尺寸：

- **标准尺寸**：16×16、32×32、48×48、64×64、128×128、256×256
- **自定义尺寸**：可以包含任意尺寸（最大 256×256）

### 支持的色深

- **1 位**：单色（黑白）
- **4 位**：16 色
- **8 位**：256 色
- **24 位**：真彩色
- **32 位**：真彩色 + Alpha 通道

### 图像格式

ICO 文件中的图像可以使用：

- **BMP**：Windows 位图格式（传统）
- **PNG**：PNG 格式（现代，支持更好的压缩）



## 文件结构

ICO 文件的基本结构：

```bash showLineNumbers
[ICO 头]                # 文件头（6 字节）
  - 保留字段（2 字节）
  - 图像类型（1 = ICO，2 = CUR）
  - 图像数量（1 字节）
[图像目录]               # 每个图像的目录项（16 字节 × N）
  - 宽度
  - 高度
  - 调色板颜色数
  - 保留字段
  - 颜色平面数
  - 位深度
  - 图像数据大小
  - 图像数据偏移
[图像数据 1]             # 第一个图像数据（BMP 或 PNG）
[图像数据 2]             # 第二个图像数据
...
```

### 关键组件

- **ICO 头**：标识文件类型和图像数量
- **图像目录**：每个图像的元数据
- **图像数据**：实际的图像数据（BMP 或 PNG 格式）



## 使用场景

### 适用场景

- **Windows 图标**：应用程序图标、文件类型图标
- **网站 Favicon**：浏览器标签页图标
- **系统图标**：Windows 系统图标
- **应用程序图标**：软件图标

### 优缺点

**优点：**

- 支持多分辨率，一个文件满足多种需求
- Windows 原生支持
- 广泛用于网站 Favicon
- 支持透明度和多种色深

**缺点：**

- 文件体积可能较大（包含多个图像）
- 某些非 Windows 系统支持有限
- 格式相对复杂



## 代码示例

### Python 创建 ICO

```python showLineNumbers
from PIL import Image

# 创建不同尺寸的图像
sizes = [(16, 16), (32, 32), (48, 48), (64, 64), (128, 128), (256, 256)]
images = []

for size in sizes:
    # 创建图像（示例：简单的圆形图标）
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    # ... 绘制图标内容
    images.append(img)

# 保存为 ICO（Pillow 会自动处理多尺寸）
images[0].save('icon.ico', format='ICO', sizes=[(img.width, img.height) for img in images])
```

### Python 读取 ICO

```python showLineNumbers
from PIL import Image

# 打开 ICO 文件
ico = Image.open('icon.ico')

# ICO 文件可能包含多个图像
print(f"图像数量: {len(ico.ico_sizes) if hasattr(ico, 'ico_sizes') else 1}")

# 获取特定尺寸
ico_16 = ico.resize((16, 16))
ico_16.save('icon_16.png', 'PNG')
```

### 使用 ImageMagick

```bash showLineNumbers
# 创建 ICO 文件
convert icon_16.png icon_32.png icon_48.png icon.ico

# 从 PNG 创建 ICO
convert icon.png -define icon:auto-resize=16,32,48,64,128,256 icon.ico

# 提取 ICO 中的图像
convert icon.ico[0] icon_16.png  # 提取第一个图像
```

关于 convert 命令的更多用法，请阅读 [Linux convert 命令](/linux-command/convert/)。



## 相关工具

- **图标编辑器**：
  - IcoFX：Windows 图标编辑器
  - GIMP：支持 ICO 导入导出
  - ImageMagick：命令行工具
- **在线工具**：
  - Favicon Generator：在线生成工具
  - ICO Convert：在线转换工具
- **编程库**：
  - Python: `Pillow (PIL)`
  - JavaScript: `sharp`、`jimp`
  - C/C++: Windows API



## 相关链接

- [ICO 格式规范 (Microsoft)](https://docs.microsoft.com/en-us/windows/win32/uxguide/vis-icons)
- [Favicon 标准](https://en.wikipedia.org/wiki/Favicon)



## 参考

- [ICO - Wikipedia](https://en.wikipedia.org/wiki/ICO_(file_format))
- [ICO 文件格式详解](https://en.wikipedia.org/wiki/ICO_(file_format)#Outline)
- [Favicon 最佳实践](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/link#attr-icon)
