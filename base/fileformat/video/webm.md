---
sidebar_position: 5
sidebar_label: WEBM 格式
slug: /webm
---

# WEBM 格式（网页视频）

**WEBM**（Web Media）是由 Google 主导的开放媒体联盟（AOMedia）于 2010 年推出的网络媒体格式，基于 Matroska 容器框架。强制使用 VP8/VP9 视频编码和 Opus/Vorbis 音频编码，支持 4K HDR 和低延迟模式，凭借开源免授权优势成为 HTML5 视频标签的推荐格式（如 Wikipedia 视频托管）。



## 格式简介

WEBM 是一种专为 Web 设计的开放视频格式，基于 Matroska 容器格式。WEBM 格式强制使用特定的开源编解码器，确保完全开源和免授权，是 HTML5 视频的标准格式之一。

WEBM 文件扩展名为 `.webm`，MIME 类型为 `video/webm`。WEBM 格式由 Google 主导开发，被 W3C 推荐为 HTML5 视频格式。



## 技术特点

### 核心特性

- **开源免费**：完全开源，无专利限制
- **Web 优化**：专为 Web 传输优化
- **强制编解码器**：使用特定的开源编解码器
- **高质量**：支持 4K、HDR 视频
- **低延迟**：支持低延迟模式

### 支持的编解码器

- **视频编解码器**：
  - VP8：基础视频编码
  - VP9：改进的视频编码（更高效）
  - AV1：新一代视频编码（WEBM 2.0）
- **音频编解码器**：
  - Vorbis：基础音频编码
  - Opus：改进的音频编码（更高效）

### WEBM vs MP4

- **开源性**：WEBM 完全开源，MP4 有专利限制
- **Web 支持**：WEBM 是 HTML5 推荐格式
- **兼容性**：MP4 兼容性更好
- **压缩率**：VP9/AV1 压缩率通常更高



## 文件结构

WEBM 文件基于 Matroska 容器（EBML 格式）：

```bash showLineNumbers
[EBML 头]                # EBML 标识
[Segment]                # 段容器
  - Segment Info        # 段信息
  - Tracks              # 轨道定义
    - Video Track (VP8/VP9/AV1)
    - Audio Track (Vorbis/Opus)
  - Cluster             # 数据簇
    - Block             # 数据块
  - Cues                # 索引（可选）
```

### 关键组件

- **EBML 头**：标识文件为 EBML 格式
- **Video Track**：VP8/VP9/AV1 编码的视频轨道
- **Audio Track**：Vorbis/Opus 编码的音频轨道
- **Cluster**：包含实际的音视频数据



## 使用场景

### 适用场景

- **Web 视频**：网站视频播放（HTML5 video 标签）
- **在线视频平台**：YouTube、Wikipedia 等
- **开源项目**：需要开源视频格式的项目
- **流媒体**：Web 流媒体服务
- **移动 Web**：移动端 Web 视频

### 优缺点

**优点：**

- 完全开源，无专利限制
- Web 原生支持
- 压缩效率高（VP9/AV1）
- 支持高质量视频（4K、HDR）
- 低延迟支持

**缺点：**

- 某些旧浏览器不支持
- Safari 支持较晚
- 硬件解码支持有限
- 某些设备可能不支持



## 代码示例

### HTML5 视频标签

```html showLineNumbers
<!-- HTML5 video 标签支持 WEBM -->
<video controls>
  <source src="video.webm" type="video/webm">
  <source src="video.mp4" type="video/mp4">
  您的浏览器不支持视频播放。
</video>
```

### JavaScript 处理 WEBM

```javascript showLineNumbers
// 使用 MediaRecorder API 录制 WEBM
const stream = canvas.captureStream(30);
const recorder = new MediaRecorder(stream, {
    mimeType: 'video/webm;codecs=vp9'
});

recorder.ondataavailable = (event) => {
    if (event.data.size > 0) {
        // 处理录制的视频数据
        const blob = new Blob([event.data], { type: 'video/webm' });
        const url = URL.createObjectURL(blob);
        // 下载或播放
    }
};

recorder.start();
recorder.stop();
```

### Python 处理 WEBM

```python showLineNumbers
import ffmpeg

# 转换为 WEBM
ffmpeg.input('input.mp4').output(
    'output.webm',
    vcodec='libvpx-vp9',
    acodec='libopus',
    crf=30
).run()

# 获取 WEBM 信息
probe = ffmpeg.probe('video.webm')
video_info = next(s for s in probe['streams'] if s['codec_type'] == 'video')
print(f"编码: {video_info['codec_name']}")
```

### 使用 FFmpeg

```bash showLineNumbers
# 转换为 WEBM（VP9 + Opus）
ffmpeg -i input.mp4 -c:v libvpx-vp9 -c:a libopus output.webm

# 转换为 WEBM（VP8 + Vorbis）
ffmpeg -i input.mp4 -c:v libvpx -c:a libvorbis output.webm

# 转换为 WEBM（AV1）
ffmpeg -i input.mp4 -c:v libaom-av1 -c:a libopus output.webm
```



## 相关工具

- **播放器**：
  - Chrome、Firefox、Edge：浏览器原生支持
  - VLC Media Player：跨平台播放器
- **编码工具**：
  - FFmpeg：支持 WEBM 编码
  - Google WebM Tools：官方工具集
- **编程库**：
  - JavaScript: `MediaRecorder API`、`ffmpeg.wasm`
  - Python: `ffmpeg-python`
  - C/C++: `libvpx`、`libopus`、`libavformat`（FFmpeg）



## 相关链接

- [WEBM 官方网站](https://www.webmproject.org/)
- [WEBM 格式规范](https://www.webmproject.org/docs/)
- [HTML5 视频格式](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/video)



## 参考

- [WEBM - Wikipedia](https://en.wikipedia.org/wiki/WebM)
- [VP9 编码](https://www.webmproject.org/vp9/)
- [HTML5 视频最佳实践](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/video)

