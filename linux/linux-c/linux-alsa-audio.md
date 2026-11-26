---
sidebar_position: 38
authors: [luhuadong]
---

# Linux ALSA 音频编程

在 Linux 系统中，如果你想开发一个可以录音或播放声音的应用程序，**ALSA**（Advanced Linux Sound Architecture） 是最常用的音频接口之一。它是 Linux 内核中提供音频支持的主要架构，功能强大，支持低延迟、混音、多通道音频等高级特性。

本文将带你初步了解 ALSA 音频编程的基本概念，包括如何打开音频设备、设置参数、读取与写入音频数据等。我们以 C 语言为主，帮助你快速上手音频采集与播放开发。



## 什么是 ALSA？

ALSA 是 Linux 下的高级音频系统，取代了早期的 OSS（Open Sound System）。ALSA 提供了：

- 低延迟音频传输能力
- 多通道支持（比如立体声、5.1 声道）
- 多个音频设备同时工作的能力
- Mixer、MIDI、PCM、硬件抽象层等功能

你可以通过使用 `libasound`（ALSA 的用户空间开发库）进行编程，控制音频播放、录音、音量调节等。



## 音频重要概念

1. **PCM**：PCM 是最常见的原始音频格式，它描述了音频的采样方式（如 16 位、单声道/立体声、采样率）。
2. **通道**：通道数决定了你是单声道（1）还是立体声（2）等。
3. **采样率**：每秒采集多少次声音样本，常见为 44100Hz（CD 质量）。
4. **位宽**：每个样本使用多少位，通常为 16 位或 24 位。



## ALSA 编程流程概览

使用 ALSA 进行音频编程通常包括以下步骤：

1. 打开音频设备
2. 配置硬件参数（采样率、通道数、格式等）
3. 读取（录音）或写入（播放）音频数据
4. 关闭设备，释放资源

ALSA 函数简析：

- `snd_pcm_open()`：打开音频设备
- `snd_pcm_hw_params_*`：配置硬件参数
- `snd_pcm_writei()` / `snd_pcm_readi()`：播放 / 录音
- `snd_pcm_close()`：关闭设备



## 示例：播放音频数据（写入 PCM）

你可以使用 `snd_pcm_writei()` 将音频数据写入 PCM（Pulse Code Modulation）设备，实现播放功能。

示例代码：

```c showLineNumbers title="alsa_play.c"
#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>

int main() {
    snd_pcm_t *handle;
    snd_pcm_hw_params_t *params;
    int rc;
    unsigned int sample_rate = 44100;
    int dir;
    snd_pcm_uframes_t frames = 32;
    char *buffer;
    int size;

    // 打开默认 PCM 播放设备
    rc = snd_pcm_open(&handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
    if (rc < 0) {
        fprintf(stderr, "无法打开音频设备: %s\n", snd_strerror(rc));
        exit(1);
    }

    // 分配硬件参数对象
    snd_pcm_hw_params_malloc(&params);
    snd_pcm_hw_params_any(handle, params);
    snd_pcm_hw_params_set_access(handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);
    snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16_LE);
    snd_pcm_hw_params_set_channels(handle, params, 2); // 立体声
    snd_pcm_hw_params_set_rate_near(handle, params, &sample_rate, &dir);
    snd_pcm_hw_params_set_period_size_near(handle, params, &frames, &dir);

    // 应用硬件参数
    rc = snd_pcm_hw_params(handle, params);
    if (rc < 0) {
        fprintf(stderr, "无法设置参数: %s\n", snd_strerror(rc));
        exit(1);
    }

    // 计算 buffer 大小
    snd_pcm_hw_params_get_period_size(params, &frames, &dir);
    size = frames * 2 * 2; // 2字节/样本，2通道
    buffer = (char *) malloc(size);

    FILE *fp = fopen("audio.raw", "rb"); // 读取 PCM 文件
    if (!fp) {
        perror("fopen");
        exit(1);
    }

    while (fread(buffer, 1, size, fp) > 0) {
        rc = snd_pcm_writei(handle, buffer, frames);
        if (rc == -EPIPE) {
            fprintf(stderr, "播放 underrun\n");
            snd_pcm_prepare(handle);
        } else if (rc < 0) {
            fprintf(stderr, "写入错误: %s\n", snd_strerror(rc));
        }
    }

    fclose(fp);
    snd_pcm_drain(handle);
    snd_pcm_close(handle);
    free(buffer);

    return 0;
}
```

编译方式：

```bash
gcc alsa_play.c -o alsa_play -lasound
```

你需要准备一个 16bit 立体声、采样率 44100Hz 的 PCM 音频文件，命名为 `audio.raw`。



## 示例：录制音频数据（读取 PCM）

使用 `snd_pcm_readi()` 读取音频数据，实现录音功能，即从音频设备中读取音频数据并写入文件。这个过程的逻辑和播放非常相似，不同的是方向改为了 `SND_PCM_STREAM_CAPTURE`，读取的是麦克风输入。

示例代码：

```c showLineNumbers title="alsa_record.c"
#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>

int main() {
    snd_pcm_t *handle;
    snd_pcm_hw_params_t *params;
    int rc;
    unsigned int sample_rate = 44100;
    int dir;
    snd_pcm_uframes_t frames = 32;
    char *buffer;
    int size;

    // 打开默认的录音设备
    rc = snd_pcm_open(&handle, "default", SND_PCM_STREAM_CAPTURE, 0);
    if (rc < 0) {
        fprintf(stderr, "无法打开音频设备: %s\n", snd_strerror(rc));
        exit(1);
    }

    // 分配和初始化硬件参数结构体
    snd_pcm_hw_params_malloc(&params);
    snd_pcm_hw_params_any(handle, params);
    snd_pcm_hw_params_set_access(handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);
    snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16_LE);
    snd_pcm_hw_params_set_channels(handle, params, 2); // 立体声
    snd_pcm_hw_params_set_rate_near(handle, params, &sample_rate, &dir);
    snd_pcm_hw_params_set_period_size_near(handle, params, &frames, &dir);

    rc = snd_pcm_hw_params(handle, params);
    if (rc < 0) {
        fprintf(stderr, "无法设置硬件参数: %s\n", snd_strerror(rc));
        exit(1);
    }

    // 获取 period size 并为 buffer 分配内存
    snd_pcm_hw_params_get_period_size(params, &frames, &dir);
    size = frames * 2 * 2; // 2通道 * 2字节
    buffer = (char *)malloc(size);

    FILE *fp = fopen("record.raw", "wb");
    if (!fp) {
        perror("fopen");
        exit(1);
    }

    // 录制 5 秒的音频
    int loops;
    snd_pcm_hw_params_get_period_time(params, &sample_rate, &dir);
    loops = 5000000 / sample_rate;  // 5000000 微秒 = 5 秒

    while (loops-- > 0) {
        rc = snd_pcm_readi(handle, buffer, frames);
        if (rc == -EPIPE) {
            fprintf(stderr, "Overrun occurred\n");
            snd_pcm_prepare(handle);
        } else if (rc < 0) {
            fprintf(stderr, "读取错误: %s\n", snd_strerror(rc));
        } else if (rc != (int)frames) {
            fprintf(stderr, "短读，仅读取 %d 帧\n", rc);
        }

        fwrite(buffer, 1, size, fp);
    }

    fclose(fp);
    snd_pcm_drain(handle);
    snd_pcm_close(handle);
    free(buffer);

    printf("录音完成，保存为 record.raw 文件\n");
    return 0;
}
```

编译方式：

```bash
gcc alsa_record.c -o alsa_record -lasound
```

你可以用音频编辑软件（如 [Audacity](/tools/audio-recording-software/#audacity)）打开 `record.raw`，指定格式为：

- 采样率：44100 Hz
- 通道：立体声
- 格式：16-bit PCM 小端（little endian）



## 查看本机支持的设备和参数

你可以通过以下 [aplay](/linux-command/aplay/) 和 [arecord](/linux-command/arecord/) 命令查看本地设备：

```bash
aplay -l     # 查看播放设备
arecord -l   # 查看录音设备
```

也可以用 C 函数如 `snd_device_name_hint()` 枚举可用设备。



## 常见问题

- **underrun / overrun**：数据供给不及时（播放）或读取不及时（录音），可用 `snd_pcm_prepare()` 重新准备设备。
- **权限不足**：音频设备通常需要权限或加入 `audio` 用户组。
- **数据格式不匹配**：确保你设置的格式与实际音频数据一致。



## 小结

通过这篇教程，你了解了 Linux ALSA 音频编程的基本流程和使用方式。你学会了如何打开音频设备、配置参数、播放和录制 PCM 音频数据。虽然 ALSA 接口相对底层，但它性能高、控制力强，是构建专业音频应用的首选工具。

在实际开发中，你可以在 ALSA 的基础上封装自己的音频处理接口，也可以进一步探索更高级的音频库（如 PulseAudio、JACK），它们都建立在 ALSA 之上。
