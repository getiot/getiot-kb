---
sidebar_position: 8
sidebar_label: TS 格式
slug: /ts
---

# TS 格式（流传输）

**TS**（MPEG-2 Transport Stream，MPEG-2 传输流）是 MPEG 组织 1995 年针对数字电视广播开发的传输协议。将音视频分割为 188 字节固定长度包，内置纠错码和时钟同步机制，支持实时流传输，广泛应用于数字电视、IPTV 和蓝光碟片（BDMV 目录），但文件体积冗余度较高。



## 格式简介

TS 是一种用于数字电视广播和流媒体传输的容器格式。TS 格式设计用于在不可靠的传输介质（如广播、网络）上传输音视频数据，具有强大的错误纠正和同步机制。

TS 文件扩展名为 `.ts`，MIME 类型为 `video/mp2t` 或 `video/MP2T`。TS 格式是数字电视广播的标准格式，也被广泛用于 IPTV 和流媒体服务。



## 技术特点

### 核心特性

- **固定包大小**：每个传输包固定为 188 字节
- **错误纠正**：内置纠错码（FEC）
- **时钟同步**：精确的时钟同步机制
- **多路复用**：支持多个节目流
- **实时传输**：专为实时流传输设计

### 传输包结构

每个 TS 包包含：

- **同步字节**（1 字节）：0x47
- **传输错误指示**（1 位）
- **有效载荷单元起始指示**（1 位）
- **传输优先级**（1 位）
- **PID**（13 位）：包标识符
- **传输加扰控制**（2 位）
- **适配字段控制**（2 位）
- **连续计数器**（4 位）
- **有效载荷**（可变长度，最多 184 字节）

### 支持的编解码器

- **视频编解码器**：MPEG-2 Video、H.264、H.265/HEVC
- **音频编解码器**：MPEG-2 Audio、AAC、AC-3



## 文件结构

TS 文件由连续的传输包组成：

```bash showLineNumbers
[TS 包 1]                # 188 字节
  - 同步字节 (0x47)
  - PID
  - 有效载荷
[TS 包 2]                # 188 字节
[TS 包 3]                # 188 字节
...
```

### 关键组件

- **PAT（Program Association Table）**：节目关联表
- **PMT（Program Map Table）**：节目映射表
- **PES（Packetized Elementary Stream）**：打包的基本流
- **PSI（Program Specific Information）**：节目特定信息



## 使用场景

### 适用场景

- **数字电视广播**：DVB、ATSC 等数字电视标准
- **IPTV**：网络电视服务
- **蓝光光盘**：BDMV 目录中的视频文件
- **直播流媒体**：实时视频流传输
- **视频录制**：数字电视录制

### 优缺点

**优点：**

- 专为实时传输设计
- 强大的错误纠正能力
- 精确的时钟同步
- 支持多节目流
- 广播标准格式

**缺点：**

- 文件体积冗余度较高
- 结构复杂
- 不适合存储（更适合传输）
- 某些播放器可能不支持



## 代码示例

### Python 处理 TS

```python showLineNumbers
import ffmpeg

# 转换为 MP4
ffmpeg.input('video.ts').output(
    'output.mp4',
    vcodec='libx264',
    acodec='aac'
).run()

# 合并多个 TS 文件
ffmpeg.input('concat:file1.ts|file2.ts|file3.ts').output(
    'output.ts',
    c='copy'
).run()
```

### 使用 FFmpeg

```bash showLineNumbers
# 转换 TS 到 MP4
ffmpeg -i input.ts -c:v libx264 -c:a aac output.mp4

# 合并 TS 文件
ffmpeg -i "concat:file1.ts|file2.ts|file3.ts" -c copy output.ts

# 提取视频流
ffmpeg -i input.ts -c:v copy -bsf:v h264_mp4toannexb output.h264

# 提取音频流
ffmpeg -i input.ts -c:a copy output.aac
```

### Python 使用 m3u8 下载 TS

```python showLineNumbers
import m3u8
import requests

# 下载 M3U8 播放列表
playlist = m3u8.load('playlist.m3u8')

# 下载所有 TS 片段
for segment in playlist.segments:
    url = segment.absolute_uri
    response = requests.get(url)
    with open(f'segment_{segment.sequence}.ts', 'wb') as f:
        f.write(response.content)
```



## 相关工具

- **播放器**：
  - VLC Media Player：跨平台播放器
  - MPC-HC：Windows 播放器
  - Kodi：媒体中心
- **处理工具**：
  - FFmpeg：支持 TS 处理
  - tsMuxer：TS 复用工具
  - TSDuck：TS 处理工具集
- **编程库**：
  - Python: `ffmpeg-python`、`m3u8`
  - C/C++: `libavformat`、`libavcodec`（FFmpeg）



## 相关链接

- [MPEG-2 TS 标准 (ISO/IEC 13818-1)](https://www.iso.org/standard/25524.html)
- [TS 格式规范](https://en.wikipedia.org/wiki/MPEG_transport_stream)
- [FFmpeg TS 文档](https://ffmpeg.org/ffmpeg-formats.html#mpegts)



## 参考

- [TS - Wikipedia](https://en.wikipedia.org/wiki/MPEG_transport_stream)
- [MPEG-2 TS 详解](https://en.wikipedia.org/wiki/MPEG_transport_stream#Packet_structure)
- [数字电视标准](https://en.wikipedia.org/wiki/Digital_television)

