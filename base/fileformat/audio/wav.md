---
sidebar_position: 2
side_label: WAV 格式
slug: /wav
---

# WAV 格式（未压缩）

**WAV**（Waveform Audio File Format，波形音频文件格式）是 Windows 系统标准无损音频格式，由微软与 IBM 于 1991 年联合开发。它基于 RIFF 文件结构直接存储 PCM 原始数据，支持高达 384kHz 采样率和 32bit 位深，兼容性极强但体积庞大（1 分钟 CD 音质约 10MB），主要用于专业音频制作和科研领域原始数据保存。



## 格式简介

WAV 是一种未压缩的音频文件格式，采用线性脉冲编码调制（PCM）存储音频数据。WAV 格式基于 RIFF（Resource Interchange File Format）文件结构，是 Windows 操作系统的标准音频格式。

WAV 文件扩展名为 `.wav`，MIME 类型为 `audio/wav` 或 `audio/wave`。虽然 WAV 文件体积较大，但由于其未压缩的特性，在专业音频制作和需要最高音质的场景中仍然广泛使用。



## 技术特点

### 核心特性

- **无损存储**：不进行任何压缩，完全保留原始音频数据
- **高质量**：支持高采样率和位深度
- **兼容性强**：几乎所有音频软件和设备都支持
- **简单结构**：文件结构简单，易于解析和编辑

### 采样率和位深度

WAV 格式支持多种采样率和位深度：

- **采样率**：8kHz 到 384kHz（常见：44.1kHz、48kHz、96kHz、192kHz）
- **位深度**：8 位、16 位、24 位、32 位（常见：16 位、24 位）
- **声道数**：单声道、立体声、多声道（最高支持 65535 个声道）

### 文件大小计算

WAV 文件大小计算公式：

```bash
文件大小（字节）= 采样率 × 位深度 / 8 × 声道数 × 时长（秒）
```

例如，CD 音质（44.1kHz、16 位、立体声）1 分钟：
```bash
44,100 × 16 / 8 × 2 × 60 = 10,584,000 字节 ≈ 10.1 MB
```



## 文件结构

WAV 文件基于 RIFF 格式，基本结构如下：

```bash showLineNumbers
[RIFF 头]                # "RIFF" 标识 + 文件大小
[WAVE 标识]              # "WAVE" 标识
[fmt 块]                 # 格式信息（采样率、位深、声道等）
  - 音频格式（PCM/压缩）
  - 声道数
  - 采样率
  - 字节率
  - 块对齐
  - 位深度
[data 块]                # 音频数据（PCM 样本）
[可选块]                 # 其他元数据块
```

### 关键块说明

- **RIFF 头**：标识文件为 RIFF 格式，包含文件总大小
- **WAVE 标识**：标识为 WAV 音频文件
- **fmt 块**：包含音频格式信息（必需）
- **data 块**：包含实际的 PCM 音频数据（必需）



## 使用场景

### 适用场景

- **专业音频制作**：录音、混音、母带处理
- **科研领域**：需要原始音频数据的科学研究
- **音频编辑**：作为编辑的中间格式
- **高质量音频存储**：需要无损保存的场景
- **系统音效**：Windows 系统音效文件

### 优缺点

**优点：**

- 完全无损，音质完美
- 兼容性极好，所有设备都支持
- 文件结构简单，易于处理
- 支持高采样率和位深度
- 适合专业音频制作

**缺点：**

- 文件体积大（未压缩）
- 不适合网络传输
- 存储成本高
- 播放需要较大带宽



## 代码示例

### Python 读取 WAV

```python showLineNumbers
import wave

# 打开 WAV 文件
with wave.open('audio.wav', 'rb') as wav_file:
    # 获取音频参数
    channels = wav_file.getnchannels()
    sample_width = wav_file.getsampwidth()
    framerate = wav_file.getframerate()
    frames = wav_file.getnframes()
    duration = frames / framerate
    
    print(f"声道数: {channels}")
    print(f"采样宽度: {sample_width} 字节")
    print(f"采样率: {framerate} Hz")
    print(f"总帧数: {frames}")
    print(f"时长: {duration:.2f} 秒")
    
    # 读取音频数据
    audio_data = wav_file.readframes(frames)
```

### Python 创建 WAV

```python showLineNumbers
import wave
import numpy as np

# 生成音频数据（440Hz 正弦波，1秒）
sample_rate = 44100
duration = 1.0
frequency = 440.0

t = np.linspace(0, duration, int(sample_rate * duration), False)
audio_data = np.sin(2 * np.pi * frequency * t)

# 转换为 16 位整数
audio_data = (audio_data * 32767).astype(np.int16)

# 创建 WAV 文件
with wave.open('output.wav', 'wb') as wav_file:
    wav_file.setnchannels(1)  # 单声道
    wav_file.setsampwidth(2)  # 16 位 = 2 字节
    wav_file.setframerate(sample_rate)
    wav_file.writeframes(audio_data.tobytes())
```

### Python 使用 scipy

```python showLineNumbers
from scipy.io import wavfile

# 读取 WAV 文件
sample_rate, audio_data = wavfile.read('audio.wav')
print(f"采样率: {sample_rate} Hz")
print(f"数据形状: {audio_data.shape}")

# 写入 WAV 文件
wavfile.write('output.wav', sample_rate, audio_data)
```

### JavaScript 处理 WAV

```javascript showLineNumbers
// 使用 Web Audio API 读取 WAV
const audioContext = new AudioContext();

fetch('audio.wav')
    .then(response => response.arrayBuffer())
    .then(arrayBuffer => audioContext.decodeAudioData(arrayBuffer))
    .then(audioBuffer => {
        console.log(`采样率: ${audioBuffer.sampleRate} Hz`);
        console.log(`时长: ${audioBuffer.duration} 秒`);
        console.log(`声道数: ${audioBuffer.numberOfChannels}`);
        
        // 获取音频数据
        const channelData = audioBuffer.getChannelData(0);
        console.log('音频数据:', channelData);
    });
```



## 相关工具

- **音频编辑器**：
  - Audacity：开源音频编辑软件
  - Adobe Audition：专业音频编辑软件
  - GoldWave：音频编辑工具
- **命令行工具**：
  - `sox`：音频处理工具
  - `ffmpeg`：音视频转换工具
- **编程库**：
  - Python: `wave`（标准库）、`scipy.io.wavfile`、`soundfile`
  - JavaScript: `Web Audio API`、`wavefile`
  - C/C++: `libsndfile`、`WAV` 库
  - Java: `javax.sound.sampled`



## 相关链接

- [WAV 格式规范 (Microsoft)](https://docs.microsoft.com/en-us/windows/win32/api/mmreg/ns-mmreg-waveformatex)
- [RIFF 文件格式](https://en.wikipedia.org/wiki/Resource_Interchange_File_Format)



## 参考

- [WAV - Wikipedia](https://en.wikipedia.org/wiki/WAV)
- [WAV 文件格式详解](https://en.wikipedia.org/wiki/WAV#Technical_details)
- [PCM 音频格式](https://en.wikipedia.org/wiki/Pulse-code_modulation)
