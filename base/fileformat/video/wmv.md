---
sidebar_position: 6
sidebar_label: WMV 格式
slug: /wmv
---

# WMV 格式（Windows 媒体）

**WMV**（Windows Media Video）是微软开发的专有视频格式，最初于 1999 年作为 Windows Media 格式的一部分推出。采用专有的视频编码算法，支持多种配置文件，曾是 Windows 平台的主流视频格式，但逐渐被 MP4 等开放格式替代。



## 格式简介

WMV 是微软开发的视频格式，用于 Windows Media Player 和 Windows 平台。WMV 格式使用专有的视频编码算法，提供良好的压缩效率，但受专利保护，跨平台支持有限。

WMV 文件扩展名为 `.wmv`，MIME 类型为 `video/x-ms-wmv`。WMV 格式在 Windows 平台上广泛使用，但在其他平台上支持有限。



## 技术特点

### 核心特性

- **专有格式**：微软专有格式
- **高压缩比**：提供良好的压缩效率
- **多种配置文件**：支持多种质量级别
- **DRM 支持**：支持数字版权管理

### WMV 版本

- **WMV 7**：Windows Media Video 7（1999 年）
- **WMV 8**：Windows Media Video 8（2000 年）
- **WMV 9**：Windows Media Video 9（2003 年，也称为 VC-1）
- **WMV 9 Advanced Profile**：高级配置文件

### VC-1 标准

WMV 9 的核心技术被标准化为 VC-1（SMPTE 421M），是蓝光光盘和 HD DVD 的标准编码格式之一。



## 文件结构

WMV 文件基于 ASF（Advanced Systems Format）容器：

```bash showLineNumbers
[ASF 头对象]             # ASF 文件头
  - Header Object      # 头对象
  - File Properties    # 文件属性
  - Stream Properties  # 流属性
  - Codec List         # 编解码器列表
[ASF 数据对象]           # 数据对象
  - Data Packets      # 数据包
[ASF 索引对象]           # 索引对象（可选）
```

### 关键组件

- **ASF 头**：包含文件元数据和流信息
- **数据对象**：包含实际的音视频数据
- **索引对象**：用于快速定位的索引



## 使用场景

### 适用场景

- **Windows 平台**：Windows Media Player 播放
- **企业视频**：企业内部视频分发
- **历史视频文件**：旧视频文件格式
- **Windows 应用**：Windows 应用程序中的视频

### 优缺点

**优点：**

- Windows 平台原生支持
- 压缩效率高
- 支持 DRM 保护

**缺点：**

- 专有格式，受微软控制
- 跨平台支持有限
- 某些播放器可能不支持
- 逐渐被开放格式替代



## 代码示例

### Python 处理 WMV

```python showLineNumbers
import ffmpeg

# 转换为 MP4
ffmpeg.input('video.wmv').output(
    'output.mp4',
    vcodec='libx264',
    acodec='aac'
).run()

# 获取 WMV 信息
probe = ffmpeg.probe('video.wmv')
video_info = next(s for s in probe['streams'] if s['codec_type'] == 'video')
print(f"编码: {video_info['codec_name']}")
```

### 使用 FFmpeg

```bash showLineNumbers
# 转换 WMV 到 MP4
ffmpeg -i input.wmv -c:v libx264 -c:a aac output.mp4

# 转换为其他格式
ffmpeg -i input.wmv output.mkv
ffmpeg -i input.wmv output.avi

# 提取音频
ffmpeg -i input.wmv -vn -acodec copy output.wma
```



## 相关工具

- **播放器**：
  - Windows Media Player：Windows 内置播放器
  - VLC Media Player：跨平台播放器
  - Media Player Classic：经典播放器
- **转换工具**：
  - FFmpeg：支持 WMV 解码
  - Windows Media Encoder：官方编码工具
- **编程库**：
  - Python: `ffmpeg-python`
  - C/C++: `libavformat`、`libavcodec`（FFmpeg）



## 相关链接

- [Windows Media 格式](https://docs.microsoft.com/en-us/windows/win32/wmformat/windows-media-format-sdk)
- [VC-1 标准](https://www.smpte.org/standards)



## 参考

- [WMV - Wikipedia](https://en.wikipedia.org/wiki/Windows_Media_Video)
- [ASF 格式](https://en.wikipedia.org/wiki/Advanced_Systems_Format)
- [VC-1 编码](https://en.wikipedia.org/wiki/VC-1)
