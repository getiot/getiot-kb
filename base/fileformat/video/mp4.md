---
sidebar_position: 1
sidebar_label: MP4 格式
slug: /mp4
---

# MP4 格式（H.264/H.265）

**MP4**（MPEG-4 Part 14）格式是 MPEG 组织 2001 年制定的国际标准（ISO/IEC 14496-14），基于 QuickTime 格式改进。采用 MOOV 元数据头部结构，支持 H.264/H.265 编码、分段下载（DASH）和 DRM 保护，是流媒体（如 YouTube）、移动设备和数字发行的通用视频容器。



## 格式简介

MP4 是一种数字多媒体容器格式，用于存储视频、音频、字幕和元数据。MP4 格式基于 QuickTime 文件格式（MOV），但采用了更标准化的结构。MP4 是目前最流行的视频格式之一，被广泛用于视频分享、流媒体服务和移动设备。

MP4 文件扩展名为 `.mp4`，MIME 类型为 `video/mp4`。MP4 格式由国际标准化组织（ISO）和国际电工委员会（IEC）共同制定，是开放标准。



## 技术特点

### 容器特性

- **多轨道支持**：可以包含多个视频、音频、字幕轨道
- **元数据支持**：支持丰富的元数据（标题、作者、封面等）
- **流媒体优化**：支持分段下载和流式播放
- **DRM 保护**：支持数字版权管理
- **章节支持**：支持章节标记和导航

### 视频编码

MP4 容器支持多种视频编码格式：

- **H.264/AVC**：最常用的编码格式，兼容性最好
- **H.265/HEVC**：新一代编码，压缩率更高
- **VP9**：Google 开发的开放编码格式
- **AV1**：新一代开放编码格式

### 音频编码

MP4 容器支持多种音频编码格式：

- **AAC**：最常用的音频编码
- **MP3**：兼容性编码
- **AC-3**：杜比数字音频
- **Opus**：开放音频编码

### MP4 变体

- **MP4**：标准 MP4 格式
- **M4V**：Apple 的 MP4 变体，通常包含 DRM
- **M4A**：仅包含音频的 MP4 文件
- **3GP**：移动设备优化的 MP4 变体



## 文件结构

MP4 文件采用基于盒（Box）的结构，每个盒包含类型、大小和数据：

```bash showLineNumbers
[ftyp]                  # 文件类型盒
[moov]                  # 元数据盒（包含所有轨道信息）
  - mvhd               # 电影头
  - trak               # 轨道（视频/音频）
    - tkhd             # 轨道头
    - mdia             # 媒体信息
[mdat]                  # 媒体数据盒（实际音视频数据）
```

### 关键盒类型

- **ftyp**：文件类型，标识 MP4 版本和兼容性
- **moov**：元数据容器，包含所有轨道和媒体信息
- **mdat**：媒体数据，包含实际的音视频数据
- **free**：自由空间，用于优化文件结构

### MOOV 位置

- **前置 MOOV**：MOOV 盒在文件开头，适合流式播放
- **后置 MOOV**：MOOV 盒在文件末尾，需要完整下载才能播放



## 使用场景

### 适用场景

- **视频分享**：YouTube、Vimeo 等视频平台
- **流媒体服务**：Netflix、Amazon Prime 等
- **移动设备**：手机、平板电脑视频播放
- **数字发行**：电影、电视剧的数字发行
- **视频编辑**：视频编辑软件的中间格式

### 优缺点

**优点：**

- 广泛支持，几乎所有设备都支持
- 压缩效率高，文件体积相对较小
- 支持多种编码格式
- 支持流式播放和分段下载
- 支持丰富的元数据和字幕

**缺点：**

- 文件结构复杂，解析需要专业知识
- 某些编码格式需要授权费用
- 编辑 MP4 文件可能较慢（需要重建索引）



## 代码示例

### Python 读取 MP4 元数据

```python showLineNumbers
from moviepy.editor import VideoFileClip

# 读取视频信息
clip = VideoFileClip('video.mp4')
print(f"时长: {clip.duration} 秒")
print(f"分辨率: {clip.size}")
print(f"帧率: {clip.fps}")

# 获取音频信息
if clip.audio:
    print(f"音频时长: {clip.audio.duration} 秒")
```

### Python 使用 ffmpeg-python

```python showLineNumbers
import ffmpeg

# 获取视频信息
probe = ffmpeg.probe('video.mp4')
video_info = next(s for s in probe['streams'] if s['codec_type'] == 'video')
print(f"编码: {video_info['codec_name']}")
print(f"分辨率: {video_info['width']}x{video_info['height']}")
print(f"帧率: {video_info['r_frame_rate']}")

# 转换视频
ffmpeg.input('input.mp4').output('output.mp4', vcodec='libx264', crf=23).run()
```

### JavaScript 处理 MP4

```javascript showLineNumbers
// 在浏览器中读取 MP4
const video = document.createElement('video');
video.src = 'video.mp4';

video.addEventListener('loadedmetadata', () => {
    console.log(`时长: ${video.duration} 秒`);
    console.log(`分辨率: ${video.videoWidth}x${video.videoHeight}`);
});

// 使用 MediaRecorder 录制 MP4
const stream = canvas.captureStream(30);
const recorder = new MediaRecorder(stream, {
    mimeType: 'video/mp4'
});

recorder.ondataavailable = (event) => {
    if (event.data.size > 0) {
        // 处理录制的视频数据
    }
};
recorder.start();
```



## 相关工具

- **播放器**：
  - VLC Media Player：跨平台播放器
  - Windows Media Player：Windows 内置播放器
  - QuickTime Player：macOS 内置播放器
- **编辑工具**：
  - FFmpeg：命令行视频处理工具
  - HandBrake：视频转换工具
  - Adobe Premiere Pro：专业视频编辑软件
- **编程库**：
  - Python: `moviepy`、`ffmpeg-python`、`opencv-python`
  - JavaScript: `ffmpeg.wasm`、`fluent-ffmpeg`
  - C/C++: `libavformat`、`libavcodec`（FFmpeg）



## 相关链接

- [MP4 标准 (ISO/IEC 14496-14)](https://www.iso.org/standard/75929.html)
- [FFmpeg 官方网站](https://ffmpeg.org/)
- [MP4Box 工具](https://gpac.wp.imt.fr/mp4box/)



## 参考

- [MP4 - Wikipedia](https://en.wikipedia.org/wiki/MP4_file_format)
- [MP4 文件格式详解](https://en.wikipedia.org/wiki/ISO_base_media_file_format)
- [FFmpeg 文档](https://ffmpeg.org/documentation.html)

