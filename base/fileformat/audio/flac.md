---
sidebar_position: 3
side_label: FLAC 格式
slug: /flac
---

# FLAC 格式（无损压缩）

**FLAC**（Free Lossless Audio Codec）是一种开源**无损音频压缩格式**，由 Xiph.Org 基金会于 2001 年开发。其通过预测编码和熵编码技术，可将音频文件体积压缩至原始大小的 50%-70% 且完全保留音质，支持流式传输与快速定位采样点，常用于音乐母带存档和高保真音频播放，但文件体积仍显著大于有损格式。



## 格式简介

FLAC 是一种无损音频压缩格式，可以在不损失任何音质的情况下减小文件体积。FLAC 格式是完全开源的，没有任何专利限制，被广泛用于音乐收藏、高保真音频播放和专业音频制作。

FLAC 文件扩展名为 `.flac`，MIME 类型为 `audio/flac`。FLAC 格式是 Xiph.Org 基金会开发的开放标准，是开源音频格式的代表。



## 技术特点

### 压缩算法

FLAC 使用以下技术实现无损压缩：

1. **线性预测编码（LPC）**：预测音频样本值
2. **残差编码**：存储预测误差
3. **熵编码**：使用 Rice 编码或 Golomb 编码进一步压缩
4. **块级压缩**：将音频分成块进行独立压缩

### 核心特性

- **完全无损**：解压后与原始音频完全相同
- **压缩比**：通常可压缩至原始大小的 50%-70%
- **快速解码**：解码速度快，适合实时播放
- **流式支持**：支持流式传输和播放
- **快速定位**：支持快速定位到任意采样点
- **错误检测**：内置 CRC 校验，可检测数据损坏

### 支持的参数

- **采样率**：1Hz 到 655350Hz
- **位深度**：4 位到 32 位
- **声道数**：1 到 8 个声道（标准），最多 255 个（扩展）
- **压缩级别**：0-8（0 最快，8 最小体积）



## 文件结构

FLAC 文件由以下部分组成：

```bash showLineNumbers
[fLaC 标识]              # "fLaC" 标识（4 字节）
[元数据块]               # 可选的元数据块
  - STREAMINFO          # 流信息（必需）
  - PADDING             # 填充块
  - APPLICATION         # 应用数据
  - SEEKTABLE           # 查找表
  - VORBIS_COMMENT      # Vorbis 注释
  - CUESHEET            # 提示表
  - PICTURE             # 封面图片
[音频帧]                 # 压缩的音频数据帧
```

### 关键块说明

- **STREAMINFO**：包含采样率、声道数、总样本数等（必需）
- **SEEKTABLE**：用于快速定位的查找表
- **VORBIS_COMMENT**：元数据（标题、艺术家等）
- **PICTURE**：封面图片（PNG、JPEG 等）



## 使用场景

### 适用场景

- **音乐收藏**：高质量音乐文件存储
- **音乐母带存档**：专业音频制作和存档
- **高保真音频播放**：Hi-Fi 音频系统
- **音频分发**：需要无损音质的场景
- **开源项目**：需要开源音频格式的项目

### 优缺点

**优点：**

- 完全无损，音质完美
- 开源免费，无专利限制
- 压缩比好，节省存储空间
- 解码速度快，适合实时播放
- 支持丰富的元数据
- 广泛支持，主流播放器都支持

**缺点：**

- 文件体积仍比有损格式大
- 某些旧设备可能不支持
- 编码速度相对较慢（高压缩级别）



## 代码示例

### Python 读取 FLAC

```python showLineNumbers
import soundfile as sf

# 读取 FLAC 文件
data, sample_rate = sf.read('audio.flac')
print(f"采样率: {sample_rate} Hz")
print(f"数据形状: {data.shape}")
print(f"时长: {len(data) / sample_rate:.2f} 秒")
```

### Python 写入 FLAC

```python showLineNumbers
import soundfile as sf
import numpy as np

# 生成音频数据
sample_rate = 44100
duration = 2.0
t = np.linspace(0, duration, int(sample_rate * duration), False)
audio_data = np.sin(2 * np.pi * 440 * t)

# 保存为 FLAC
sf.write('output.flac', audio_data, sample_rate, format='FLAC')
```

### Python 使用 pydub

```python showLineNumbers
from pydub import AudioSegment

# 读取 FLAC
audio = AudioSegment.from_file("audio.flac", format="flac")
print(f"时长: {len(audio) / 1000} 秒")
print(f"采样率: {audio.frame_rate} Hz")

# 转换为其他格式
audio.export("output.mp3", format="mp3", bitrate="192k")
```

### 命令行工具

```bash showLineNumbers
# 使用 flac 命令行工具
flac audio.wav -o audio.flac              # 压缩
flac -d audio.flac -o audio.wav           # 解压
flac audio.wav -8 -o audio.flac           # 最高压缩级别

# 使用 ffmpeg
ffmpeg -i input.wav -c:a flac output.flac
ffmpeg -i input.flac output.wav
```



## 相关工具

- **播放器**：
  - VLC Media Player：跨平台播放器
  - Foobar2000：Windows 音频播放器
  - Audacious：Linux 音频播放器
- **编码工具**：
  - FLAC 命令行工具：官方编码工具
  - FFmpeg：支持 FLAC 编码
- **音频编辑器**：
  - Audacity：支持 FLAC 导入导出
  - Adobe Audition：支持 FLAC
- **编程库**：
  - Python: `soundfile`、`pydub`、`librosa`
  - C/C++: `libFLAC`
  - JavaScript: `flac.js`



## 相关链接

- [FLAC 官方网站](https://xiph.org/flac/)
- [FLAC 格式规范](https://xiph.org/flac/documentation.html)
- [FLAC 下载](https://xiph.org/flac/download.html)



## 参考

- [FLAC - Wikipedia](https://en.wikipedia.org/wiki/FLAC)
- [FLAC 格式详解](https://xiph.org/flac/format.html)
- [无损音频格式对比](https://en.wikipedia.org/wiki/Comparison_of_audio_coding_formats)