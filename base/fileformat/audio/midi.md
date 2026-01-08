---
sidebar_position: 6
side_label: MIDI 格式
slug: /midi
---

# MIDI 格式（电子乐器）

**MIDI**（Musical Instrument Digital Interface，乐器数字接口）格式由 Dave Smith 等工程师于 1983 年提出，是电子乐器与计算机的通信协议标准。MIDI 文件不存储音频波形，而是记录音符、力度、音色编号等控制指令，体积极小（1 分钟音乐约 10KB），音质依赖终端音源库，广泛应用于电子音乐制作、游戏配乐和乐谱编辑。



## 格式简介

MIDI 是一种数字音乐标准，用于在电子乐器、计算机和其他设备之间传输音乐信息。MIDI 文件不包含实际的音频数据，而是包含音乐事件的指令，如音符、音色、力度、时间等。

MIDI 文件扩展名为 `.mid` 或 `.midi`，MIME 类型为 `audio/midi` 或 `audio/x-midi`。MIDI 格式是音乐制作和电子乐器控制的标准格式。



## 技术特点

### 核心特性

- **指令格式**：存储音乐事件指令而非音频波形
- **文件极小**：1 分钟音乐通常只有几 KB 到几十 KB
- **可编辑性**：易于编辑和修改
- **设备控制**：可以控制各种 MIDI 设备
- **标准化**：工业标准，广泛支持

### MIDI 消息类型

MIDI 消息包括：

- **音符开/关**：Note On/Off（音符、力度）
- **音色变化**：Program Change（音色编号）
- **控制变化**：Control Change（音量、效果等）
- **音高弯音**：Pitch Bend
- **系统消息**：系统专用消息

### MIDI 格式版本

- **MIDI 0**：单轨格式
- **MIDI 1**：多轨格式（标准格式）



## 文件结构

MIDI 文件由以下部分组成：

```bash showLineNumbers
[文件头块]                # MThd 标识 + 头信息
  - 格式类型（0/1/2）
  - 轨道数
  - 时间基准
[轨道块 1]               # MTrk 标识 + 轨道数据
  - 事件列表
[轨道块 2]               # 多轨格式的额外轨道
...
```

### 关键块说明

- **MThd**：文件头，包含格式信息和轨道数
- **MTrk**：轨道块，包含 MIDI 事件
- **事件**：包含时间戳和 MIDI 消息

### MIDI 事件格式

每个 MIDI 事件包含：

- **时间增量**：相对于上一个事件的时间
- **状态字节**：消息类型（音符、控制等）
- **数据字节**：消息参数（音符编号、力度等）



## 使用场景

### 适用场景

- **音乐制作**：电子音乐创作和编曲
- **游戏配乐**：游戏背景音乐和音效
- **乐谱编辑**：数字乐谱制作和编辑
- **音乐教育**：音乐学习和教学
- **设备控制**：MIDI 设备控制和同步
- **手机铃声**：传统手机铃声格式

### 优缺点

**优点：**

- 文件体积极小
- 易于编辑和修改
- 可以改变音色和速度
- 标准化格式，广泛支持
- 适合音乐制作和编曲

**缺点：**

- 不包含音频数据，需要音源
- 音质依赖音源库质量
- 不同设备播放效果可能不同
- 不适合直接播放（需要合成器）



## 代码示例

### Python 读取 MIDI

```python showLineNumbers
from mido import MidiFile

# 读取 MIDI 文件
mid = MidiFile('music.mid')
print(f"轨道数: {len(mid.tracks)}")
print(f"时长: {mid.length} 秒")
print(f"时间基准: {mid.ticks_per_beat}")

# 遍历所有消息
for i, track in enumerate(mid.tracks):
    print(f"\n轨道 {i}:")
    for msg in track:
        print(f"  {msg}")
```

### Python 创建 MIDI

```python showLineNumbers
from mido import MidiFile, MidiTrack, Message

# 创建新的 MIDI 文件
mid = MidiFile()
track = MidiTrack()
mid.tracks.append(track)

# 添加音符（C 大调音阶）
notes = [60, 62, 64, 65, 67, 69, 71, 72]  # C4 到 C5
for note in notes:
    track.append(Message('note_on', note=note, velocity=64, time=0))
    track.append(Message('note_off', note=note, velocity=64, time=480))

# 保存文件
mid.save('output.mid')
```

### Python 使用 music21

```python showLineNumbers
from music21 import converter, stream, note

# 读取 MIDI
score = converter.parse('music.mid')

# 分析音乐
key = score.analyze('key')
print(f"调性: {key}")

# 创建简单的 MIDI
s = stream.Stream()
n = note.Note('C4')
n.duration.quarterLength = 1.0
s.append(n)
s.write('midi', fp='output.mid')
```

### JavaScript 处理 MIDI

```javascript showLineNumbers
// 使用 Tone.js 播放 MIDI
import * as Tone from 'tone';

// 创建合成器
const synth = new Tone.Synth().toDestination();

// 播放音符
synth.triggerAttackRelease('C4', '8n');
synth.triggerAttackRelease('E4', '8n', '+0.5');
synth.triggerAttackRelease('G4', '8n', '+1');
```

### 使用 Web MIDI API

```javascript showLineNumbers
// 访问 MIDI 设备
navigator.requestMIDIAccess().then((midiAccess) => {
    const inputs = midiAccess.inputs;
    inputs.forEach((input) => {
        input.onmidimessage = (event) => {
            console.log('MIDI 消息:', event.data);
        };
    });
});
```



## 相关工具

- **音乐制作软件**：
  - FL Studio：专业音乐制作软件
  - Ableton Live：音乐制作和演出软件
  - Logic Pro：macOS 音乐制作软件
  - GarageBand：入门级音乐制作软件
- **乐谱编辑**：
  - MuseScore：开源乐谱编辑器
  - Sibelius：专业乐谱软件
- **MIDI 播放器**：
  - Windows Media Player：支持 MIDI
  - VLC Media Player：支持 MIDI
- **编程库**：
  - Python: `mido`、`music21`、`pretty_midi`
  - JavaScript: `tone.js`、`midi-parser-js`
  - C/C++: `libmidi`、`RtMidi`



## 相关链接

- [MIDI 官方网站](https://www.midi.org/)
- [MIDI 规范](https://www.midi.org/specifications)
- [MIDI 文件格式](https://www.midi.org/specifications-old/item/standard-midi-files-smf)



## 参考

- [MIDI - Wikipedia](https://en.wikipedia.org/wiki/MIDI)
- [MIDI 文件格式详解](https://en.wikipedia.org/wiki/MIDI#MIDI_files)
- [MIDI 1.0 规范](https://www.midi.org/specifications-old/item/midi-1-0-detailed-specifications)

