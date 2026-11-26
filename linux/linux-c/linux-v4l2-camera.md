---
sidebar_position: 39
authors: [luhuadong]
---

# Linux V4L2 视频采集

在本篇教程中，你将学习如何使用 V4L2（Video for Linux 2）接口在 Linux 下采集视频数据。我们会先介绍 V4L2 的基本概念，然后带你一步步完成一个简单的摄像头视频采集程序，帮助你掌握实际开发中的用法。



## 什么是 V4L2？

**V4L2** 是 Linux 下的视频捕获设备驱动框架，它支持摄像头、电视卡、调谐器等设备。通过 V4L2，你可以以统一的方式访问不同厂商的摄像设备。V4L2 的核心接口是 `ioctl()` 系统调用，它通过各种命令与设备进行通信。

V4L 全称 **Video4Linux**，是 Linux 内核中为视频设备（如摄像头、电视卡）提供的驱动框架。最早的 V4L（现在称为 **V4L1**）在 Linux 2.2 时代被引入，当时的视频采集功能非常基础，仅支持少数设备，接口也比较粗糙，难以扩展。

为了解决 V4L1 在结构、功能和可扩展性方面的缺陷，**V4L2**（Video4Linux 2） 在 Linux 2.5.x 版本中引入，正式在 Linux 2.6 内核中稳定使用，替代了早期的 V4L1 接口。相比前代，V4L2 提供了更规范的 API、更丰富的功能支持，并为各种现代视频设备打下了统一的基础。

V4L2 是当前 Linux 系统中唯一被官方维护的视频输入框架，V4L1 已于 2010 年前后被完全废弃（相关支持代码也在内核中移除）。目前，几乎所有主流 USB 摄像头、嵌入式摄像头模块、图像采集卡等都支持 V4L2 接口，Linux 内核社区也仍在积极维护和扩展其能力。

它支持的功能包括但不限于：

- 视频采集（实时流）
- 静态图像采集
- 多种像素格式（YUYV、MJPEG、H264 等）
- 视频输出（如嵌入式 LCD 视频渲染）
- 视频格式自动协商
- 多缓冲处理、DMA 接口、硬件加速等

随着嵌入式设备、AI 视觉系统的发展，V4L2 的使用范围也越来越广泛。



## V4L2 应用领域

你可以在很多与视频采集有关的 Linux 应用场景中看到 V4L2 的身影：

| 应用方向            | 具体说明                                                     |
| ------------------- | ------------------------------------------------------------ |
| 视频聊天 / 视频会议 | 如基于 Linux 的 Zoom、WebRTC、OBS Studio 等使用 V4L2 获取摄像头画面。 |
| 视频监控系统        | 安防摄像头、NVR 系统中广泛采用 V4L2 + GStreamer + OpenCV 方案。 |
| 机器视觉 / 工业相机 | 工业检测、AOI 检测中的图像输入模块多基于 V4L2 编写驱动与应用。 |
| 教学与开发板        | 树莓派、BeagleBone、NVIDIA Jetson 等板卡上用于学习和实验。   |
| 图像识别 / AI 视觉  | 深度学习系统中常通过 V4L2 接入视频流并传给 AI 模型处理。     |
| 嵌入式多媒体终端    | 像 Android、OpenWRT、车载系统中的拍照、录像功能也底层调用 V4L2 驱动。 |
| 多媒体应用开发      | FFmpeg、GStreamer 等音视频框架内部对接 V4L2 作为采集后端。   |



## 基本采集流程

使用 V4L2 采集视频通常需要以下步骤：

1. 打开设备
2. 查询设备能力
3. 设置视频格式
4. 申请内存缓冲区
5. 将缓冲区映射到用户空间
6. 启动视频采集
7. 读取视频帧
8. 停止采集并释放资源



## 示例：V4L2 视频采集程序

下面是一个简单的 V4L2 视频采集程序示例：

```c showLineNumbers title="v4l2_capture.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/videodev2.h>
#include <sys/mman.h>

#define DEVICE "/dev/video0"
#define WIDTH 640
#define HEIGHT 480

struct buffer {
    void *start;
    size_t length;
};

int main() {
    int fd = open(DEVICE, O_RDWR);
    if (fd < 0) {
        perror("打开设备失败");
        return 1;
    }

    // 查询设备能力
    struct v4l2_capability cap;
    ioctl(fd, VIDIOC_QUERYCAP, &cap);
    printf("驱动: %s\n", cap.driver);

    // 设置格式
    struct v4l2_format fmt;
    memset(&fmt, 0, sizeof(fmt));
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = WIDTH;
    fmt.fmt.pix.height = HEIGHT;
    fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
    fmt.fmt.pix.field = V4L2_FIELD_INTERLACED;
    ioctl(fd, VIDIOC_S_FMT, &fmt);

    // 请求缓冲区
    struct v4l2_requestbuffers req;
    memset(&req, 0, sizeof(req));
    req.count = 1;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
    ioctl(fd, VIDIOC_REQBUFS, &req);

    // 映射缓冲区
    struct v4l2_buffer buf;
    memset(&buf, 0, sizeof(buf));
    buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    buf.memory = V4L2_MEMORY_MMAP;
    buf.index = 0;
    ioctl(fd, VIDIOC_QUERYBUF, &buf);

    struct buffer video_buf;
    video_buf.length = buf.length;
    video_buf.start = mmap(NULL, buf.length, PROT_READ | PROT_WRITE, MAP_SHARED, fd, buf.m.offset);

    // 入队缓冲区
    ioctl(fd, VIDIOC_QBUF, &buf);

    // 开始采集
    enum v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    ioctl(fd, VIDIOC_STREAMON, &type);

    // 读取一帧数据
    ioctl(fd, VIDIOC_DQBUF, &buf);
    printf("采集到 %d 字节数据\n", buf.bytesused);

    // 写入文件
    FILE *fp = fopen("frame.yuv", "wb");
    fwrite(video_buf.start, 1, buf.bytesused, fp);
    fclose(fp);

    // 停止采集
    ioctl(fd, VIDIOC_STREAMOFF, &type);
    munmap(video_buf.start, video_buf.length);
    close(fd);

    return 0;
}
```

你可以使用如下命令编译示例代码：

```bash
gcc v4l2_capture.c -o v4l2_capture
```

运行程序前，确保你已经插入摄像头并具有 `/dev/video0` 设备的权限。



## 相关工具和生态

为了配合 V4L2 开发和调试，Linux 社区提供了很多配套工具：

- `v4l2-ctl`：命令行工具，用于查询、设置和测试视频设备。
- `qv4l2`：Qt 图形化工具，实时查看摄像头画面。
- `cheese`、`guvcview`、`ffplay /dev/video0`：快速预览设备。
- `FFmpeg -f v4l2`：采集并保存/转码视频数据。

另外，OpenCV、GStreamer、FFmpeg 等多媒体开发库都原生支持 V4L2，可供你在高层应用中调用。



## 小结

通过本教程，你了解了 V4L2 的基本结构以及视频采集的流程。你学会了如何打开视频设备、设置采集参数、申请缓冲区并获取视频帧。V4L2 是进行音视频开发的重要工具，掌握这些基本操作能帮助你开发自己的媒体采集和处理应用。
