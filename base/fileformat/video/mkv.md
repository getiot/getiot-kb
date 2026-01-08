---
sidebar_position: 3
sidebar_label: MKV 格式
slug: /mkv
---

# MKV 格式（封装容器）

**MKV**（Matroska Multimedia Container）是开源社区 2002 年开发的开放标准容器格式，以俄罗斯嵌套娃娃命名。支持无限量音轨、字幕和章节，可封装 H.265/VP9 等先进编码，提供 XML 元数据和错误修复功能，是蓝光备份和动画资源的首选封装格式，但硬件播放器兼容性弱于 MP4。



## 格式简介

MKV 是一种开放的多媒体容器格式，由 Matroska 项目开发。MKV 格式设计灵活，支持多种视频、音频和字幕格式，是开源社区广泛使用的视频容器格式。

MKV 文件扩展名为 `.mkv`，MIME 类型为 `video/x-matroska`。MKV 格式完全开源，无专利限制，被广泛用于视频存储和分发。



## 技术特点

### 核心特性

- **多轨道支持**：支持无限数量的视频、音频、字幕轨道
- **章节支持**：支持章节标记和导航
- **元数据支持**：支持丰富的 XML 元数据
- **错误修复**：内置错误修复功能
- **流式支持**：支持流式传输

### 支持的编解码器

- **视频编解码器**：H.264、H.265/HEVC、VP8、VP9、AV1 等
- **音频编解码器**：AAC、MP3、Opus、Vorbis、FLAC 等
- **字幕格式**：SRT、ASS、SSA、VOBSUB 等

### Matroska 格式系列

- **MKV**：视频文件（Matroska Video）
- **MKA**：音频文件（Matroska Audio）
- **MKS**：字幕文件（Matroska Subtitles）



## 文件结构

MKV 文件使用 EBML（Extensible Binary Meta Language）格式：

```bash showLineNumbers
[EBML 头]                # EBML 标识和版本
[Segment]                # 段容器
  - Segment Info        # 段信息
  - Tracks              # 轨道定义
    - Video Track       # 视频轨道
    - Audio Track       # 音频轨道
    - Subtitle Track    # 字幕轨道
  - Cluster             # 数据簇
    - Block             # 数据块
    - Block Group       # 数据块组
  - Cues                # 索引（可选）
  - Attachments         # 附件（可选）
  - Chapters            # 章节（可选）
  - Tags                 # 标签（可选）
```

### 关键组件

- **EBML 头**：标识文件为 EBML 格式
- **Segment Info**：包含段的基本信息
- **Tracks**：定义所有轨道
- **Cluster**：包含实际的音视频数据
- **Cues**：用于快速定位的索引



## 使用场景

### 适用场景

- **蓝光备份**：蓝光光盘内容备份
- **动画资源**：动画视频存储（支持多音轨和字幕）
- **高清视频**：4K、HDR 视频存储
- **多语言内容**：需要多音轨和多字幕的内容
- **开源项目**：需要开源格式的项目

### 优缺点

**优点：**

- 完全开源，无专利限制
- 支持多轨道和章节
- 支持丰富的元数据
- 错误修复功能
- 灵活性高

**缺点：**

- 硬件播放器兼容性不如 MP4
- 某些设备可能不支持
- 文件结构相对复杂



## 代码示例

### Python 处理 MKV

```python showLineNumbers
import ffmpeg

# 获取 MKV 文件信息
probe = ffmpeg.probe('video.mkv')
video_info = next(s for s in probe['streams'] if s['codec_type'] == 'video')
print(f"编码: {video_info['codec_name']}")
print(f"分辨率: {video_info['width']}x{video_info['height']}")

# 提取字幕
ffmpeg.input('video.mkv').output('subtitle.srt', codec='srt').run()
```

### 使用 FFmpeg

```bash showLineNumbers
# 转换 MKV 到 MP4
ffmpeg -i input.mkv -c:v copy -c:a copy output.mp4

# 提取字幕
ffmpeg -i input.mkv -map 0:s:0 output.srt

# 提取音轨
ffmpeg -i input.mkv -map 0:a:0 output.aac

# 合并多个文件到 MKV
ffmpeg -i video.mp4 -i audio.aac -c copy output.mkv
```

### Python 使用 pymkv

```python showLineNumbers
from pymkv import MKVFile

# 创建 MKV 文件
mkv = MKVFile()
mkv.add_track('video.mp4')
mkv.add_track('audio.aac')
mkv.add_track('subtitle.srt')
mkv.mux('output.mkv')
```



## 相关工具

- **播放器**：
  - VLC Media Player：跨平台播放器
  - MPC-HC：Windows 播放器
  - Kodi：媒体中心
- **编辑工具**：
  - MKVToolNix：MKV 编辑和合并工具
  - FFmpeg：命令行视频处理工具
- **编程库**：
  - Python: `pymkv`、`ffmpeg-python`
  - C/C++: `libmatroska`、`libavformat`（FFmpeg）



## 相关链接

- [Matroska 官方网站](https://www.matroska.org/)
- [MKV 格式规范](https://www.matroska.org/technical/specs/index.html)
- [MKVToolNix](https://mkvtoolnix.download/)



## 参考

- [MKV - Wikipedia](https://en.wikipedia.org/wiki/Matroska)
- [Matroska 格式详解](https://www.matroska.org/technical/specs/index.html)
- [EBML 规范](https://datatracker.ietf.org/doc/html/rfc8794)
