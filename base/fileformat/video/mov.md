---
sidebar_position: 4
sidebar_label: MOV 格式
slug: /mov
---

# MOV 格式（苹果专业）

**MOV**（QuickTime File Format，QuickTime 文件格式）是苹果公司 1991 年为 QuickTime 播放器设计的专有容器格式。基于“原子”（atom）分层结构，支持多轨道媒体、3D 特效和交互式内容，专业视频编辑领域常用其 ProRes 编码版本，但跨平台播放需额外解码器支持。



## 格式简介

MOV 是苹果公司开发的视频容器格式，用于 QuickTime 播放器。MOV 格式基于原子（atom）结构，支持多种媒体类型和高级功能，是专业视频编辑的标准格式之一。

MOV 文件扩展名为 `.mov`，MIME 类型为 `video/quicktime`。MOV 格式是 MP4 格式的前身，两者在结构上非常相似。



## 技术特点

### 核心特性

- **原子结构**：基于原子（atom）的分层结构
- **多轨道支持**：支持多个视频、音频、文本轨道
- **专业编码**：支持 ProRes、DNxHD 等专业编码
- **交互式内容**：支持交互式内容和 3D 特效
- **元数据支持**：支持丰富的元数据

### 支持的编解码器

- **视频编解码器**：H.264、H.265、ProRes、DNxHD、Motion JPEG 等
- **音频编解码器**：AAC、MP3、PCM、ALAC 等

### ProRes 编码

ProRes 是苹果开发的专业视频编码：

- **ProRes 422**：标准专业编码
- **ProRes 422 HQ**：高质量版本
- **ProRes 4444**：支持 Alpha 通道
- **ProRes RAW**：原始数据编码



## 文件结构

MOV 文件基于原子结构：

```bash showLineNumbers
[ftyp]                  # 文件类型原子
[moov]                  # 电影原子（元数据）
  - mvhd               # 电影头
  - trak               # 轨道原子
    - tkhd             # 轨道头
    - mdia             # 媒体原子
      - mdhd           # 媒体头
      - hdlr           # 处理器
      - minf           # 媒体信息
        - stbl         # 样本表
[mdat]                  # 媒体数据原子（实际数据）
```

### 关键组件

- **ftyp**：文件类型标识
- **moov**：包含所有元数据和轨道信息
- **mdat**：包含实际的音视频数据
- **trak**：定义视频或音频轨道



## 使用场景

### 适用场景

- **专业视频编辑**：Final Cut Pro、Premiere Pro 等
- **Apple 设备**：iPhone、iPad 视频录制
- **高质量视频**：需要专业编码的视频
- **视频制作**：电影、电视制作
- **交互式内容**：需要交互功能的视频

### 优缺点

**优点：**

- 专业编码支持（ProRes）
- 支持丰富的功能和特效
- Apple 生态深度集成
- 适合专业视频编辑

**缺点：**

- 跨平台兼容性有限
- 某些播放器可能不支持
- 文件体积可能较大（ProRes）
- 需要授权解码器



## 代码示例

### Python 处理 MOV

```python showLineNumbers
import ffmpeg

# 获取 MOV 文件信息
probe = ffmpeg.probe('video.mov')
video_info = next(s for s in probe['streams'] if s['codec_type'] == 'video')
print(f"编码: {video_info['codec_name']}")
print(f"分辨率: {video_info['width']}x{video_info['height']}")

# 转换为 MP4
ffmpeg.input('video.mov').output('output.mp4', vcodec='libx264', acodec='aac').run()
```

### 使用 FFmpeg

```bash showLineNumbers
# 转换 MOV 到 MP4
ffmpeg -i input.mov -c:v libx264 -c:a aac output.mp4

# 提取 ProRes 视频
ffmpeg -i input.mov -c:v prores_ks -profile:v 3 output.mov

# 转换为其他格式
ffmpeg -i input.mov output.mkv
```



## 相关工具

- **播放器**：
  - QuickTime Player：macOS 内置播放器
  - VLC Media Player：跨平台播放器
  - Windows Media Player：Windows 播放器（需要解码器）
- **编辑工具**：
  - Final Cut Pro：Apple 专业视频编辑
  - Adobe Premiere Pro：专业视频编辑
  - FFmpeg：命令行视频处理工具
- **编程库**：
  - Python: `ffmpeg-python`、`moviepy`
  - C/C++: `libavformat`、`libavcodec`（FFmpeg）



## 相关链接

- [QuickTime 文件格式](https://developer.apple.com/quicktime/)
- [ProRes 编码](https://www.apple.com/final-cut-pro/docs/)
- [FFmpeg MOV 文档](https://ffmpeg.org/ffmpeg-formats.html#mov)



## 参考

- [MOV - Wikipedia](https://en.wikipedia.org/wiki/QuickTime_File_Format)
- [QuickTime 格式详解](https://developer.apple.com/quicktime/)
- [ProRes 编码规范](https://www.apple.com/final-cut-pro/docs/)

