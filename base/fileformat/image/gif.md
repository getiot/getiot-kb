---
sidebar_position: 5
sidebar_label: GIF 格式
slug: /gif
---

# GIF 格式（动图）

**GIF**（Graphics Interchange Format，图形交换格式）格式由 CompuServe 公司 1987 年推出，采用 LZW 无损压缩算法。支持 256 色索引调色板和单帧透明色，通过多帧叠加实现动画效果（≤35 fps），曾是早期网络表情包和广告横幅的主流格式，因专利纠纷逐渐被 APNG/WEBP 替代。



## 格式简介

GIF 是一种位图图像格式，支持动画和透明度。GIF 格式在 1987 年由 CompuServe 开发，最初是为了在网络上传输图像而设计的。GIF 格式支持动画，这使得它成为早期网络表情包和简单动画的主要格式。

GIF 文件扩展名为 `.gif`，MIME 类型为 `image/gif`。虽然 GIF 格式已经存在多年，但由于其动画能力和广泛支持，仍然在网络上广泛使用。



## 技术特点

### 压缩算法

GIF 使用 LZW（Lempel-Ziv-Welch）压缩算法，这是一种无损压缩算法。LZW 算法通过识别重复的数据模式来实现压缩。

### 颜色支持

- **调色板**：GIF 使用调色板（Palette），最多支持 256 种颜色
- **索引色**：每个像素使用调色板中的索引值
- **透明色**：支持一种颜色作为透明色（单色透明）

### 动画支持

- **多帧图像**：GIF 可以包含多个图像帧
- **帧延迟**：每帧可以设置显示延迟时间
- **循环播放**：可以设置动画循环次数（0 表示无限循环）

### GIF 版本

- **GIF 87a**：1987 年发布，基础版本
- **GIF 89a**：1989 年发布，增加了透明度和动画支持



## 动画实现原理

GIF 动画的实现原理类似于“手翻书”（Flipbook），想象一下小时候玩的手翻书：每一页纸上画着动作的连续画面，当你快速翻动书页时，静态的画面就"动"起来了。

- **每一页 = 一帧图像**：GIF 文件里存储着多张静态图片（帧）
- **翻页速度 = 帧延迟**：每帧都有一个延迟时间（比如 0.1 秒），告诉播放器"这一帧要显示多久"
- **循环翻页 = 循环播放**：播放完所有帧后，可以设置从头再来，实现循环动画

具体来说，在 GIF 文件内部，动画是这样实现的：

1. **存储多帧**：GIF 文件按顺序存储多个图像帧，每个帧都是完整的图像数据

2. **图形控制扩展**：每帧前面有一个"图形控制扩展"（Graphic Control Extension），包含：
   - **延迟时间**：这一帧要显示多久（以 1/100 秒为单位）
   - **处置方法**：播放完这一帧后如何处理（保留、清除、恢复上一帧等）
   - **透明色索引**：如果使用透明，指定哪个颜色是透明的

3. **逐帧播放**：播放器按照顺序读取每一帧，根据延迟时间显示，然后切换到下一帧

4. **优化技巧**：为了减小文件体积，GIF 支持"局部更新"：
   - 不是每帧都存储完整图像
   - 可以只存储变化的部分（通过设置帧的位置和尺寸）
   - 就像只更新视频中移动的部分，而不是重绘整个画面

假设要做一个"眨眼"的动画：

```bash
帧 1：眼睛睁开（显示 0.5 秒）
帧 2：眼睛半闭（显示 0.1 秒）
帧 3：眼睛全闭（显示 0.1 秒）
帧 4：眼睛半闭（显示 0.1 秒）
帧 5：眼睛睁开（显示 0.5 秒）
```

当这些帧按顺序快速播放时，就形成了"眨眼"的动画效果。如果设置循环播放，这个眨眼动作就会不断重复。



:::tip 为什么 GIF 动画文件可能很大？

因为 GIF 存储的是**完整的图像数据**，而不是像视频那样只存储"变化的部分"：

- **视频格式**：只记录"这一帧相比上一帧改变了什么"（帧间压缩）
- **GIF 格式**：每一帧都是完整的图像（帧内压缩）

所以一个 10 秒的 GIF 动画，如果包含 100 帧，文件大小可能是 100 张静态图片的总和（经过压缩后）。这就是为什么复杂的 GIF 动画文件体积很大的原因。

:::



## 文件结构

GIF 文件的基本结构：

```bash showLineNumbers
[GIF 签名]               # "GIF87a" 或 "GIF89a"
[逻辑屏幕描述符]
[全局调色板]             # 可选
[图像数据/扩展块]
  - 图像描述符
  - 局部调色板（可选）
  - 图像数据
  - 图形控制扩展（动画用）
[文件结束符]             # 0x3B
```



## 使用场景

### 适用场景

- **简单动画**：表情包、简单动画效果
- **图标**：需要透明背景的简单图标
- **演示动画**：简单的演示动画
- **网络表情**：社交媒体表情包

### 优缺点

**优点：**

- 支持动画
- 支持透明度
- 广泛支持，所有浏览器都支持
- 文件体积相对较小（简单图像）

**缺点：**

- 仅支持 256 色，不适合照片
- 文件体积可能较大（复杂动画）
- LZW 专利问题（已过期）
- 逐渐被 APNG、WebP 等格式替代



## 代码示例

### Python 处理 GIF

```python showLineNumbers
from PIL import Image

# 打开 GIF
img = Image.open('animation.gif')

# 获取 GIF 信息
print(f"图像尺寸: {img.size}")
print(f"帧数: {getattr(img, 'n_frames', 1)}")
print(f"是否动画: {getattr(img, 'is_animated', False)}")

# 提取所有帧
if getattr(img, 'is_animated', False):
    frames = []
    for frame_num in range(img.n_frames):
        img.seek(frame_num)
        frames.append(img.copy())
    
    # 保存第一帧为 PNG
    frames[0].save('first_frame.png', 'PNG')

# 创建 GIF
frames = [Image.open(f'frame{i}.png') for i in range(5)]
frames[0].save(
    'output.gif',
    save_all=True,
    append_images=frames[1:],
    duration=200,  # 每帧延迟（毫秒）
    loop=0  # 无限循环
)
```

### JavaScript 处理 GIF

```javascript showLineNumbers
// 使用 gif.js 创建 GIF
const gif = new GIF({
    workers: 2,
    quality: 10,
    width: 200,
    height: 200
});

// 添加帧
const canvas = document.createElement('canvas');
const ctx = canvas.getContext('2d');
// ... 绘制内容
gif.addFrame(canvas, {delay: 200});

// 渲染 GIF
gif.on('finished', function(blob) {
    const url = URL.createObjectURL(blob);
    const img = document.createElement('img');
    img.src = url;
    document.body.appendChild(img);
});
gif.render();
```



## 相关工具

- **图像编辑器**：
  - Photoshop、GIMP
  - 在线工具：EZGIF、GIF Maker
- **命令行工具**：
  - `gifsicle`：GIF 优化和编辑工具
  - `ffmpeg`：视频转 GIF
- **编程库**：
  - Python: `Pillow (PIL)`、`imageio`
  - JavaScript: `gif.js`、`gifuct-js`



## 相关链接

- [GIF 规范](https://www.w3.org/Graphics/GIF/spec-gif89a.txt)



## 参考

- [GIF - Wikipedia](https://en.wikipedia.org/wiki/GIF)
- [GIF 文件格式详解](https://www.fileformat.info/format/gif/egff.htm)

