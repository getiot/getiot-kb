---
sidebar_position: 1
side_label: MP3 格式
slug: /mp3
---

# MP3 格式（通用音频）

**MP3**（MPEG-1 Audio Layer III）格式由德国 Fraunhofer 研究所于 1993 年推出，是首个成功商业化的**有损音频压缩格式**。利用人耳听觉掩蔽效应（舍弃对人类听觉不重要的部分），通过 FFT 频域分析和动态量化技术，将 CD 音质压缩至原始体积的 1/10（128kbps），曾主导数字音乐传播，但高频截断和预回声问题使其逐渐被 AAC 替代。



## 起源

MP3 格式始于二十世纪 80 年代中期，由位于德国埃尔朗根（Erlangen）研究组织弗劳恩霍夫协会（Fraunhofer）的一组工程师发明，并于 1991 年标准化。该协会致力于研究高质量、低数据率的声音编码，虽然 MP3 是有损压缩格式，但对于大多数用户的听觉感受来说，MP3 的音质与最初的不压缩音频相比没有明显的下降。

后来随着 MP3 的普及，曾对音乐产业造成冲击与影响。



## MPEG Audio 标准

MPEG（Moving Picture Experts Group）是 ISO 下的一个动态图像专家组，它制定的 MPEG 标准广泛应用于各种多媒体中。MPEG 标准包括视频和音频标准，其中音频标准已制定出 MPEG-1、MPEG-2、MPEG-2AAC 和 MPEG-4。

MPEG-1 和 MPEG-2 标准使用同一个音频编码解码族 —— Layer1、2、3。MPEG-2 的一个新特点是采用低采样率扩展降低数据流量，另一特点是多通道扩展，将主声道增加为 5 个。MPEG-2AAC（MPEG-2 Advanced Audio Coding）标准是 FraunhoferIIS 和 AT&T 公司于 1997 年推出的，旨在显著减少数据流量，MPEG22AAC 采用的修正的离散余弦变换（MDCT，Modified Discrete Co2sine Transform）算法，采样率可在 8KHz 到 96KHz 之间，声道数可在 1-48 之间。

MPEG Audio Layer1、2、3 三个层使用相同的滤波器组、位流结构和头信息，采样频率为 32KHz、4411KHz 或 48KHz。

- Layer1 是为数字压缩磁带 DCC（DigitalCompactCassette）设计的，数据流量为 384kbps。
- Layer2 在复杂性和性能间作了权衡，数据流量下降到 256kbps-192kbps。
- Layer3一开始就为低数据流量而设计，数据流量在 128kbps-112kbps，Layer3 增加了 MDCT 变换，使其频率分辨能力是 Layer2 的 18 倍，Layer3 还使用了与 MPEGVid2eo 类似的平均信息量编码（EntropyCoding）减少了冗余信息。

目前，MP3 绝大部分使用的是 MPEG21 标准。



## 文件结构

MP3 文件大体分为三部分：TAG_V2（ID3V2），Frame, TAG_V1（ID3V1）。其中，音频数据由帧（frame）构成的，帧是 MP3 文件最小的组成单位。 

```bash showLineNumbers
[ID3V2 标签]             # 可选的元数据标签（文件开头）
[音频帧 1]               # MP3 音频帧
  - 帧头（同步字、版本、层、比特率等）
  - 音频数据
[音频帧 2]
...
[音频帧 N]
[ID3V1 标签]             # 可选的元数据标签（文件末尾，128 字节）
```

### 关键组件

| 组成  | 描述                                                         |
| ----- | ------------------------------------------------------------ |
| ID3V2 | 包含了作者、作曲、专辑等信息，长度不固定，扩展了 ID3V1 的信息量。 |
| Frame | 一系列的帧，个数由文件大小和帧长决定。每个 FRAME 的长度可能不固定，也可能固定，由位率 bitrate 决定；每个 FRAME 由分为帧头和数据实体两部分帧头记录了 mp3 的位率、采样率、版本等信息，每个帧之间相互独立。 |
| ID3V1 | 包含了作者、作曲、专辑等信息，长度为 128BYTE。               |



## 使用场景

### 适用场景

- **音乐播放**：个人音乐收藏和播放
- **音乐分发**：在线音乐平台和下载
- **播客**：播客音频文件
- **音频存储**：需要压缩存储的场景
- **移动设备**：手机、MP3 播放器

### 优缺点

**优点：**

- 压缩率高，文件体积小
- 广泛支持，几乎所有设备都支持
- 专利已过期，完全免费
- 兼容性极好
- 适合网络传输

**缺点：**

- 有损压缩，会丢失音频信息
- 高频细节可能损失
- 低码率下音质明显下降
- 逐渐被 AAC 等格式替代



## 代码示例

### Python 读取 MP3

```python showLineNumbers
from pydub import AudioSegment

# 读取 MP3 文件
audio = AudioSegment.from_mp3("audio.mp3")
print(f"时长: {len(audio) / 1000} 秒")
print(f"采样率: {audio.frame_rate} Hz")
print(f"声道数: {audio.channels}")
print(f"比特率: {audio.frame_width * 8} 位")
```

### Python 读取 MP3 元数据

```python showLineNumbers
from mutagen.mp3 import MP3
from mutagen.id3 import ID3NoHeaderError

try:
    audio = MP3('audio.mp3')
    print(f"时长: {audio.info.length} 秒")
    print(f"比特率: {audio.info.bitrate} bps")
    
    # 读取 ID3 标签
    if audio.tags:
        print(f"标题: {audio.tags.get('TIT2', ['未知'])[0]}")
        print(f"艺术家: {audio.tags.get('TPE1', ['未知'])[0]}")
        print(f"专辑: {audio.tags.get('TALB', ['未知'])[0]}")
except ID3NoHeaderError:
    print("文件没有 ID3 标签")
```

### Python 转换 MP3

```python showLineNumbers
from pydub import AudioSegment

# 转换为 MP3
audio = AudioSegment.from_file("input.wav", format="wav")
audio.export("output.mp3", format="mp3", bitrate="192k")

# 调整质量
audio.export("high_quality.mp3", format="mp3", bitrate="320k")
audio.export("low_quality.mp3", format="mp3", bitrate="128k")
```

### 命令行工具

```bash showLineNumbers
# 使用 ffmpeg 转换
ffmpeg -i input.wav -b:a 192k output.mp3
ffmpeg -i input.mp3 output.wav

# 使用 lame 编码器
lame -b 192 input.wav output.mp3
lame --preset standard input.wav output.mp3  # VBR 编码
```



## 相关工具

- **播放器**：
  - VLC Media Player：跨平台播放器
  - Windows Media Player：Windows 播放器
  - iTunes：Apple 播放器
- **编码工具**：
  - LAME：开源 MP3 编码器
  - FFmpeg：支持 MP3 编码
- **音频编辑器**：
  - Audacity：开源音频编辑器
  - Adobe Audition：专业音频编辑
- **编程库**：
  - Python: `pydub`、`mutagen`、`eyeD3`
  - C/C++: `libmp3lame`、`libmad`
  - JavaScript: `jsmediatags`、`music-metadata`



## 相关链接

- [MP3 标准 (ISO/IEC 11172-3)](https://www.iso.org/standard/22412.html)
- [LAME MP3 编码器](https://lame.sourceforge.io/)
- [FFmpeg MP3 编码指南](https://trac.ffmpeg.org/wiki/Encode/MP3)



## 参考

- [MP3 - Wikipedia](https://zh.m.wikipedia.org/zh-sg/MP3)
- [MP3 格式音频文件结构解析](https://www.cnblogs.com/ranson7zop/p/7655474.html)
- [MP3 编码原理](https://en.wikipedia.org/wiki/MP3#Encoding_and_decoding)
