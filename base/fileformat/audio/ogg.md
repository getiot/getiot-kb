---
sidebar_position: 5
side_label: OGG 格式
slug: /ogg
---

# OGG 格式（开放格式）

**OGG**（Ogg Vorbis）是开源免费的音频容器格式，由 Xiph.Org 基金会于 2000 年发布。它采用基于 Bark 尺度的 MDCT 频段分割和矢量量化技术，音质在 160kbps 码率下接近 AAC，支持多声道（最高 255 轨）和动态比特率，无专利限制，被游戏开发（如《Minecraft》）和网络电台广泛采用，但硬件兼容性较弱。



## 格式简介

OGG 是一个开放的、免费的音频容器格式，通常与 Vorbis 音频编码一起使用（称为 Ogg Vorbis）。OGG 格式由 Xiph.Org 基金会开发，完全开源且无专利限制，是开源音频格式的重要代表。

OGG 文件扩展名为 `.ogg` 或 `.oga`（Ogg Audio），MIME 类型为 `audio/ogg` 或 `application/ogg`。OGG 格式在开源社区和游戏开发中广泛使用。



## 技术特点

### 核心特性

- **开源免费**：完全开源，无专利限制
- **高质量压缩**：Vorbis 编码提供高质量有损压缩
- **多声道支持**：支持最多 255 个声道
- **动态比特率**：支持 VBR（可变比特率）
- **流式支持**：支持流式传输和播放
- **元数据支持**：支持 Vorbis 注释

### Vorbis 编码

OGG 容器通常使用 Vorbis 音频编码：

- **有损压缩**：使用心理声学模型进行有损压缩
- **质量设置**：质量级别 0-10（-1 到 10）
- **比特率范围**：通常 32kbps 到 500kbps
- **采样率**：支持 8kHz 到 192kHz

### OGG 容器

OGG 是一个通用容器，可以包含：

- **Vorbis**：音频编码（最常见）
- **Opus**：现代音频编码
- **FLAC**：无损音频编码
- **Speex**：语音编码
- **Theora**：视频编码



## 文件结构

OGG 文件由多个页（Page）组成：

```bash showLineNumbers
[OGG 页 1]               # 包含 BOS（Beginning of Stream）标记
  - 页头
  - 段表
  - 段数据
[OGG 页 2]               # 包含数据包
  - 页头
  - 段表
  - 段数据
...
[OGG 页 N]               # 包含 EOS（End of Stream）标记
```

### 页结构

每个 OGG 页包含：

- **捕获模式**：4 字节标识 "OggS"
- **版本**：版本号
- **页类型**：BOS、EOS、继续标志
- **Granule Position**：时间戳
- **序列号**：流的序列号
- **页校验和**：CRC32 校验
- **段表**：段长度列表
- **段数据**：实际数据



## 使用场景

### 适用场景

- **游戏开发**：游戏音效和背景音乐（如 Minecraft）
- **网络电台**：在线音频流媒体
- **开源项目**：需要开源音频格式的项目
- **音频分发**：开源软件和内容分发
- **语音通信**：使用 Speex 编码的语音通信

### 优缺点

**优点：**

- 完全开源，无专利限制
- 高质量压缩，音质优秀
- 支持多声道和动态比特率
- 支持流式传输
- 文件体积相对较小

**缺点：**

- 硬件兼容性较弱（某些设备不支持）
- 不如 MP3/AAC 普及
- 某些播放器可能不支持
- 编码速度相对较慢



## 代码示例

### Python 读取 OGG

```python showLineNumbers
from pydub import AudioSegment

# 读取 OGG 文件
audio = AudioSegment.from_file("audio.ogg", format="ogg")
print(f"时长: {len(audio) / 1000} 秒")
print(f"采样率: {audio.frame_rate} Hz")
print(f"声道数: {audio.channels}")
```

### Python 转换 OGG

```python showLineNumbers
from pydub import AudioSegment

# 转换为 OGG
audio = AudioSegment.from_file("input.wav", format="wav")
audio.export("output.ogg", format="ogg", bitrate="192k")
```

### 命令行工具

```bash showLineNumbers
# 使用 ffmpeg
ffmpeg -i input.wav -c:a libvorbis -q:a 5 output.ogg

# 使用 oggenc（Vorbis 编码器）
oggenc -q 5 input.wav -o output.ogg

# 使用 oggdec（解码器）
oggdec audio.ogg -o audio.wav
```

### JavaScript 处理 OGG

```javascript showLineNumbers
// 在浏览器中播放 OGG（需要浏览器支持）
const audio = new Audio('audio.ogg');
audio.play();

// 使用 Web Audio API
const audioContext = new AudioContext();
fetch('audio.ogg')
    .then(response => response.arrayBuffer())
    .then(arrayBuffer => audioContext.decodeAudioData(arrayBuffer))
    .then(audioBuffer => {
        console.log(`采样率: ${audioBuffer.sampleRate} Hz`);
        console.log(`时长: ${audioBuffer.duration} 秒`);
    });
```



## 相关工具

- **播放器**：
  - VLC Media Player：跨平台播放器
  - Foobar2000：Windows 音频播放器
  - Audacious：Linux 音频播放器
- **编码工具**：
  - `oggenc`：Vorbis 编码器
  - `oggtools`：OGG 工具集
  - FFmpeg：支持 OGG 编码
- **音频编辑器**：
  - Audacity：支持 OGG 导入导出
- **编程库**：
  - Python: `pydub`、`mutagen`
  - C/C++: `libvorbis`、`libogg`
  - JavaScript: 浏览器原生支持（部分）



## 相关链接

- [OGG 官方网站](https://xiph.org/ogg/)
- [Vorbis 官方网站](https://xiph.org/vorbis/)
- [OGG 格式规范](https://xiph.org/ogg/doc/)



## 参考

- [OGG - Wikipedia](https://en.wikipedia.org/wiki/Ogg)
- [Vorbis - Wikipedia](https://en.wikipedia.org/wiki/Vorbis)
- [OGG 容器格式](https://xiph.org/ogg/doc/)
