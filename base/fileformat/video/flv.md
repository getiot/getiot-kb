---
sidebar_position: 7
sidebar_label: FLV 格式
slug: /flv
---

# FLV 格式（Flash 视频）

**FLV**（Flash Video）是 Adobe 公司 2002 年为 Flash Player 开发的视频容器格式。采用简单的文件结构，支持流式传输和渐进式下载，曾是网络视频的主流格式（如 YouTube 早期），但随着 Flash 技术的淘汰，逐渐被 MP4、WEBM 等格式替代。



## 格式简介

FLV 是 Adobe Flash 平台使用的视频格式，用于在网页中播放视频。FLV 格式设计简单，支持流式传输，在 2000 年代和 2010 年代初非常流行。随着 HTML5 和 Flash 的淘汰，FLV 格式的使用逐渐减少。

FLV 文件扩展名为 `.flv`，MIME 类型为 `video/x-flv` 或 `application/x-flash-video`。FLV 格式现在主要用于历史视频文件和某些特定场景。



## 技术特点

### 核心特性

- **简单结构**：文件结构相对简单
- **流式支持**：支持流式传输和渐进式下载
- **Flash 集成**：与 Flash Player 深度集成
- **元数据支持**：支持基本的元数据

### 支持的编解码器

- **视频编解码器**：
  - Sorenson Spark（H.263）：早期编码
  - VP6：On2 视频编码
  - H.264：现代编码（FLV 4.0+）
- **音频编解码器**：
  - MP3：最常用的音频编码
  - AAC：现代编码（FLV 4.0+）
  - ADPCM：早期编码

### FLV 版本

- **FLV 1**：支持 Sorenson Spark 和 MP3
- **FLV 2**：支持 VP6 视频编码
- **FLV 3**：支持屏幕录制
- **FLV 4**：支持 H.264 和 AAC



## 文件结构

FLV 文件的基本结构：

```bash showLineNumbers
[FLV 头]                 # "FLV" 标识 + 版本 + 标志
[Previous Tag Size]      # 前一个标签大小（通常为 0）
[Tag 1]                  # 第一个标签
  - Tag Type            # 标签类型（音频/视频/脚本）
  - Data Size           # 数据大小
  - Timestamp           # 时间戳
  - Stream ID           # 流 ID
  - Data                # 实际数据
[Previous Tag Size]      # 前一个标签大小
[Tag 2]                  # 下一个标签
...
```

### 关键组件

- **FLV 头**：标识文件为 FLV 格式
- **Tag**：包含音频、视频或脚本数据
- **Previous Tag Size**：用于快速定位



## 使用场景

### 适用场景

- **历史视频文件**：旧网络视频文件
- **Flash 应用**：Flash 应用程序中的视频
- **视频存档**：历史视频存档
- **特定场景**：某些特定应用场景

### 优缺点

**优点：**

- 结构简单，易于解析
- 支持流式传输
- 文件体积相对较小
- 加载速度快

**缺点：**

- Flash 技术已淘汰
- 现代浏览器不支持
- 逐渐被 MP4、WEBM 替代
- 某些编解码器支持有限



## 代码示例

### Python 处理 FLV

```python showLineNumbers
import ffmpeg

# 转换为 MP4
ffmpeg.input('video.flv').output(
    'output.mp4',
    vcodec='libx264',
    acodec='aac'
).run()

# 获取 FLV 信息
probe = ffmpeg.probe('video.flv')
video_info = next(s for s in probe['streams'] if s['codec_type'] == 'video')
print(f"编码: {video_info['codec_name']}")
```

### 使用 FFmpeg

```bash showLineNumbers
# 转换 FLV 到 MP4
ffmpeg -i input.flv -c:v libx264 -c:a aac output.mp4

# 转换为其他格式
ffmpeg -i input.flv output.mkv
ffmpeg -i input.flv output.webm

# 提取音频
ffmpeg -i input.flv -vn -acodec copy output.mp3
```

### Python 使用 flvlib

```python showLineNumbers
from flvlib import tags
from flvlib.helpers import open_file_or_url

# 读取 FLV 文件
with open_file_or_url('video.flv') as f:
    flv = tags.FLV(f)
    for tag in flv:
        if tag.tag_type == tags.FLASH_VIDEO_TAG:
            print(f"视频标签: {tag.timestamp}")
        elif tag.tag_type == tags.FLASH_AUDIO_TAG:
            print(f"音频标签: {tag.timestamp}")
```



## 相关工具

- **播放器**：
  - VLC Media Player：跨平台播放器
  - Flash Player：官方播放器（已停止支持）
- **转换工具**：
  - FFmpeg：支持 FLV 解码和转换
  - FLV Extract：FLV 提取工具
- **编程库**：
  - Python: `flvlib`、`ffmpeg-python`
  - C/C++: `libavformat`、`libavcodec`（FFmpeg）



## 相关链接

- [FLV 格式规范](https://www.adobe.com/devnet/flex/articles/video_file_format_spec_flv.html)
- [Flash Video 文档](https://www.adobe.com/devnet/video/articles/video_file_format_spec_v10.html)



## 参考

- [FLV - Wikipedia](https://en.wikipedia.org/wiki/Flash_Video)
- [FLV 文件格式详解](https://www.adobe.com/devnet/flex/articles/video_file_format_spec_flv.html)
- [Flash 技术淘汰](https://www.adobe.com/products/flashplayer/end-of-life.html)
