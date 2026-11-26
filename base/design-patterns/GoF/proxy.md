---
sidebar_position: 13
slug: /proxy
sidebar_label: 代理模式
---

# 设计模式 - 代理模式

你去图书馆借书时，不是直接接触管理员，而是通过前台登记来完成借书流程。这个前台就是一个“代理”。

代理模式（Proxy Pattern）包含三个角色：

- **Subject（抽象主题）**：定义真实对象和代理对象的共同接口。
- **RealSubject（真实主题）**：真正执行操作的对象。
- **Proxy（代理对象）**：控制对真实对象的访问，可能在调用前后添加额外逻辑。

它的本质是**控制访问、延迟加载、增强功能**。

:::tip 核心思想 🌟

给某个对象提供一个代理对象，由代理对象控制对原始对象的访问。

:::



## 模式结构（UML 类图）

```scss
Client ─────► Proxy ─────► RealSubject
        ▲            │
        └──── Subject ◄┘
```



## 示例场景

假设你正在开发一个“视频加载”系统：

- `Video` 是通用接口；
- `RealVideo` 是真实的视频对象，加载需要时间；
- `VideoProxy` 是视频代理对象，延迟加载真正的视频资源；
- 你（客户端）调用代理对象，代理再决定是否加载真实视频。



### Java 实现

```java showLineNumbers
interface Video {
    void play();
}

class RealVideo implements Video {
    private String filename;

    public RealVideo(String filename) {
        this.filename = filename;
        loadFromDisk();
    }

    private void loadFromDisk() {
        System.out.println("从磁盘加载视频: " + filename);
    }

    public void play() {
        System.out.println("播放视频: " + filename);
    }
}

class VideoProxy implements Video {
    private String filename;
    private RealVideo realVideo;

    public VideoProxy(String filename) {
        this.filename = filename;
    }

    public void play() {
        if (realVideo == null) {
            realVideo = new RealVideo(filename);
        }
        realVideo.play();
    }
}

public class Main {
    public static void main(String[] args) {
        Video video = new VideoProxy("movie.mp4");
        System.out.println("首次调用：");
        video.play();
        System.out.println("再次调用：");
        video.play();
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
#include <string>
using namespace std;

class Video {
public:
    virtual void play() = 0;
    virtual ~Video() {}
};

class RealVideo : public Video {
    string filename;
    void loadFromDisk() {
        cout << "从磁盘加载视频: " << filename << endl;
    }
public:
    RealVideo(const string& file) : filename(file) {
        loadFromDisk();
    }

    void play() override {
        cout << "播放视频: " << filename << endl;
    }
};

class VideoProxy : public Video {
    string filename;
    RealVideo* realVideo = nullptr;
public:
    VideoProxy(const string& file) : filename(file) {}

    void play() override {
        if (!realVideo) {
            realVideo = new RealVideo(filename);
        }
        realVideo->play();
    }

    ~VideoProxy() {
        delete realVideo;
    }
};

int main() {
    Video* video = new VideoProxy("movie.mp4");
    cout << "首次调用：" << endl;
    video->play();
    cout << "再次调用：" << endl;
    video->play();
    delete video;
}
```



### Python 实现

```python showLineNumbers
from abc import ABC, abstractmethod

class Video(ABC):
    @abstractmethod
    def play(self):
        pass

class RealVideo(Video):
    def __init__(self, filename):
        self.filename = filename
        self.load_from_disk()

    def load_from_disk(self):
        print(f"从磁盘加载视频: {self.filename}")

    def play(self):
        print(f"播放视频: {self.filename}")

class VideoProxy(Video):
    def __init__(self, filename):
        self.filename = filename
        self._real_video = None

    def play(self):
        if not self._real_video:
            self._real_video = RealVideo(self.filename)
        self._real_video.play()

# 使用
video = VideoProxy("movie.mp4")
print("首次调用：")
video.play()
print("再次调用：")
video.play()
```



### TypeScript 实现

```typescript showLineNumbers
interface Video {
  play(): void;
}

class RealVideo implements Video {
  constructor(private filename: string) {
    this.loadFromDisk();
  }

  private loadFromDisk(): void {
    console.log(`从磁盘加载视频: ${this.filename}`);
  }

  play(): void {
    console.log(`播放视频: ${this.filename}`);
  }
}

class VideoProxy implements Video {
  private realVideo: RealVideo | null = null;

  constructor(private filename: string) {}

  play(): void {
    if (!this.realVideo) {
      this.realVideo = new RealVideo(this.filename);
    }
    this.realVideo.play();
  }
}

// 使用
const video: Video = new VideoProxy("movie.mp4");
console.log("首次调用：");
video.play();
console.log("再次调用：");
video.play();
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 结构型                                                       |
| 适用场景 | <ul><li>访问控制</li><li>延迟加载</li><li>记录日志</li><li>权限校验</li></ul> |
| 优点     | <ul><li>控制访问</li><li>增强功能（如缓存、日志、安全）</li><li>对真实对象解耦</li></ul> |
| 缺点     | <ul><li>增加代码量和系统复杂性</li></ul>                     |

代理模式就像是“中间人”，你可以通过它加权限、加缓存、延迟加载，灵活又强大！
