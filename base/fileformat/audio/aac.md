---
sidebar_position: 4
side_label: AAC 格式
slug: /aac
---

# AAC 格式（流媒体优化）

**AAC**（Advanced Audio Coding，高级音频编码）是一种**有损压缩音频格式**，诞生于1997年，由 Fraunhofer IIS、杜比实验室、索尼等公司联合开发，现为 MPEG-2/MPEG-4 标准的核心组成部分。其设计目标是替代 MP3，在相同比特率下提供更高音质，或在更低比特率下保持同等音质，是当今流媒体与移动设备的主流音频格式。

## 技术原理与核心特性

### 编码技术演进

AAC 在 MP3 基础上进行了多项技术革新：

- **MDCT（修正离散余弦变换）**：采用更长的时域信号块（1024点）与短块（128点）动态切换，减少频谱泄露，提升频域分辨率。
- **心理声学模型优化**：更精准的掩蔽效应计算，去除人耳不敏感的冗余信息。
- **分块策略**：支持可变块长（KBD 窗口），动态适配瞬态信号与稳态信号。
- **多声道编码**：支持最高48声道，支持声道耦合（如5.1环绕声的联合编码）。

### 文件结构与封装

可以使用 **ADTS**（Audio Data Transport Stream）面向流媒体的封装格式，含帧头（同步字、采样率、声道数等）和原始数据块。

```c showLineNumbers
// ADTS帧头结构示例（7字节）
typedef struct {
    uint16_t syncword;          // 同步字0xFFF
    uint8_t  protection_absent; // 是否含CRC校验
    uint8_t  profile;           // 编码配置（LC/HE/HEv2）
    uint8_t  sampling_freq_idx; // 采样率索引（如44.1kHz=4）
    uint8_t  private_bit;
    uint8_t  channel_config;    // 声道配置（单声道/立体声等）
    uint16_t frame_length;      // 帧长度
} ADTSHeader;
```

也可以使用 **原始 AAC 流（Raw AAC）** 无封装头，依赖外部元数据（如 MP4 容器中的 `moov` 原子）。



## 技术对比

下表对比了 AAC 和 MP3 音频格式的优势和劣势。

| **特性**       | **AAC**                             | **MP3**                            |
| :------------- | :---------------------------------- | :--------------------------------- |
| **频域分辨率** | 最高支持 20k Hz以上（采样率 48kHz） | 通常限制在 16kHz（采样率 44.1kHz） |
| **压缩效率**   | 相同码率下音质提升约 30%            | 低码率下易出现“金属感”失真         |
| **多声道支持** | 原生支持 5.1/7.1 声道               | 需通过扩展（如 MP3 Surround）      |
| **专利状态**   | 专利已部分过期（部分编码器免费）    | 专利已全面过期                     |



## 使用场景

### 适用场景

- **流媒体服务**：Spotify、Apple Music、YouTube Music
- **移动设备**：手机、平板电脑音频播放
- **数字广播**：数字电台和广播
- **视频音频**：MP4 视频的音频轨道
- **播客**：播客音频文件

### 优缺点

**优点：**

- 相同码率下音质优于 MP3
- 支持多声道（5.1、7.1）
- 广泛支持，主流设备都支持
- 文件体积相对较小
- 适合流媒体传输

**缺点：**

- 有损压缩，会丢失音频信息
- 某些编码器需要授权费用
- 编码延迟相对较高
- 高频细节可能损失



## 代码示例

### Python 转换 AAC

```python showLineNumbers
from pydub import AudioSegment

# 转换为 AAC
audio = AudioSegment.from_file("input.wav", format="wav")
audio.export("output.m4a", format="ipod", bitrate="192k")  # M4A 使用 AAC
```

### 命令行工具

```bash showLineNumbers
# 使用 ffmpeg 编码 AAC
ffmpeg -i input.wav -c:a libfdk_aac -b:a 128k output.aac
ffmpeg -i input.wav -c:a aac -b:a 192k output.m4a

# 使用 faac 编码器
faac -b 128 input.wav -o output.aac

# 解码 AAC
ffmpeg -i input.aac output.wav
```

### 使用 ffmpeg-python

```python showLineNumbers
import ffmpeg

# 编码为 AAC
stream = ffmpeg.input('input.wav')
stream = ffmpeg.output(stream, 'output.aac', acodec='libfdk_aac', audio_bitrate='128k')
ffmpeg.run(stream)
```



## 相关工具

- **播放器**：
  - iTunes：Apple 官方播放器
  - VLC Media Player：跨平台播放器
  - Windows Media Player：Windows 播放器
- **编码工具**：
  - FFmpeg：支持多种 AAC 编码器
  - faac：开源 AAC 编码器
  - iTunes：可以转换音频格式
- **音频编辑器**：
  - Audacity：支持 AAC 导入导出
  - Adobe Audition：专业音频编辑
- **编程库**：
  - Python: `pydub`、`ffmpeg-python`
  - C/C++: `libfdk-aac`、`faac`、`libavcodec`（FFmpeg）



## 相关链接

- [AAC 标准 (ISO/IEC 14496-3)](https://www.iso.org/standard/53943.html)
- [FFmpeg AAC 编码指南](https://trac.ffmpeg.org/wiki/Encode/AAC)
- [AAC 编码器对比](https://trac.ffmpeg.org/wiki/Encode/AAC#Encoder%20comparison)



## 参考

- [AAC - Wikipedia](https://en.wikipedia.org/wiki/Advanced_Audio_Coding)
- [MPEG-4 Part 3 标准](https://www.iso.org/standard/53943.html)
- [AAC 编码原理](https://en.wikipedia.org/wiki/Advanced_Audio_Coding#Technical_details)

