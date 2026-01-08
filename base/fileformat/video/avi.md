---
sidebar_position: 2
sidebar_label: AVI 格式
slug: /avi
---

# AVI 格式（传统格式）

**AVI**（Audio Video Interleave，音频视频交错格式）格式由微软于 1992 年推出，是早期多媒体容器格式的代表。采用 RIFF 文件结构封装音视频流，支持多种编解码器（如 DivX、Xvid），但缺乏流式传输支持和精确的同步机制，文件体积较大，曾是 CD-ROM 时代的主流视频格式。



## 格式简介

AVI 是一种多媒体容器格式，由微软开发，用于存储音频和视频数据。AVI 格式采用 RIFF（Resource Interchange File Format）文件结构，将音频和视频数据交错存储在同一文件中。

AVI 文件扩展名为 `.avi`，MIME 类型为 `video/x-msvideo` 或 `video/avi`。AVI 格式在 1990 年代和 2000 年代初非常流行，虽然现在已被 MP4 等格式取代，但仍被广泛支持。



## 技术特点

### 核心特性

- **RIFF 结构**：基于 RIFF 文件格式
- **交错存储**：音频和视频数据交错排列
- **多编解码器支持**：支持多种视频和音频编解码器
- **简单结构**：文件结构相对简单

### 支持的编解码器

- **视频编解码器**：DivX、Xvid、H.264、MPEG-4、MJPEG 等
- **音频编解码器**：MP3、AC3、PCM、WMA 等

### 局限性

- **文件大小限制**：标准 AVI 文件最大 2GB（AVI 2.0 支持更大文件）
- **流式传输**：不支持流式传输
- **同步问题**：同步机制不够精确
- **元数据支持**：元数据支持有限



## 文件结构

AVI 文件基于 RIFF 格式，基本结构：

```bash showLineNumbers
[RIFF 头]                # "RIFF" 标识 + 文件大小
[AVI 标识]               # "AVI " 标识
[LIST hdrl]              # 头部列表
  - avih                 # AVI 主头（视频参数）
  - LIST strl            # 流列表
    - strh               # 流头（视频流）
    - strf               # 流格式
    - strd               # 流数据（可选）
[LIST movi]              # 数据列表
  - 视频数据块
  - 音频数据块
  - ...
[idx1]                   # 索引块（可选）
```

### 关键组件

- **RIFF 头**：标识文件为 RIFF 格式
- **AVI 头**：包含视频和音频的基本信息
- **流列表**：定义视频和音频流
- **数据块**：实际的音视频数据



## 使用场景

### 适用场景

- **历史视频文件**：旧视频文件格式
- **本地播放**：本地视频播放
- **视频编辑**：某些视频编辑软件的中间格式
- **兼容性需求**：需要广泛兼容的场景

### 优缺点

**优点：**

- 兼容性好，几乎所有播放器都支持
- 结构简单，易于理解
- 支持多种编解码器

**缺点：**

- 文件体积较大
- 不支持流式传输
- 同步机制不够精确
- 文件大小有限制（标准版本）
- 逐渐被 MP4 等格式替代



## 代码示例

### Python 处理 AVI

```python showLineNumbers
import cv2

# 读取 AVI 文件
cap = cv2.VideoCapture('video.avi')

# 获取视频信息
fps = cap.get(cv2.CAP_PROP_FPS)
width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
frame_count = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))

print(f"帧率: {fps} fps")
print(f"分辨率: {width}x{height}")
print(f"总帧数: {frame_count}")

# 读取帧
while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        break
    # 处理帧
    cv2.imshow('Frame', frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
```

### Python 创建 AVI

```python showLineNumbers
import cv2

# 创建视频写入器
fourcc = cv2.VideoWriter_fourcc(*'XVID')
out = cv2.VideoWriter('output.avi', fourcc, 20.0, (640, 480))

# 写入帧
for i in range(100):
    frame = create_frame(i)  # 创建帧的函数
    out.write(frame)

out.release()
```

### 使用 FFmpeg

```bash showLineNumbers
# 转换 AVI 到 MP4
ffmpeg -i input.avi -c:v libx264 -c:a aac output.mp4

# 提取视频信息
ffprobe -v quiet -print_format json -show_format -show_streams input.avi

# 转换 AVI 到其他格式
ffmpeg -i input.avi output.mkv
```



## 相关工具

- **播放器**：
  - VLC Media Player：跨平台播放器
  - Windows Media Player：Windows 内置播放器
  - Media Player Classic：经典播放器
- **编辑工具**：
  - FFmpeg：命令行视频处理工具
  - VirtualDub：AVI 专用编辑器
- **编程库**：
  - Python: `opencv-python`、`moviepy`
  - C/C++: `libavformat`、`libavcodec`（FFmpeg）
  - JavaScript: `ffmpeg.wasm`



## 相关链接

- [AVI 格式规范](https://docs.microsoft.com/en-us/windows/win32/directshow/avi-file-format)
- [RIFF 文件格式](https://en.wikipedia.org/wiki/Resource_Interchange_File_Format)



## 参考

- [AVI - Wikipedia](https://en.wikipedia.org/wiki/Audio_Video_Interleave)
- [AVI 文件格式详解](https://en.wikipedia.org/wiki/Audio_Video_Interleave#File_structure)
- [FFmpeg AVI 文档](https://ffmpeg.org/ffmpeg-formats.html#avi)
