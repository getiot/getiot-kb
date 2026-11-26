---
sidebar_position: 11
slug: /facade
sidebar_label: 外观模式
---

# 设计模式 - 外观模式

你有没有过这样的体验：为了播放一个视频，你得先打开解码器、设置播放器、加载文件、初始化渲染引擎，操作一大堆类，才终于开始播放。

这时候你一定会想：**能不能有个“总控按钮”帮我一键播放？**

外观模式（Facade Pattern）就是为了解决这个问题：**它为复杂子系统提供一个统一的接口，屏蔽内部细节，简化使用方式。**

:::tip 核心思想 🌟

外观模式通过引入一个“外观类”，把多个子系统封装起来，让你只需要跟这个外观类打交道，而不必深入复杂的内部结构。

:::



## 模式结构（UML 类图）

```scss
Client
  │
  ▼
Facade ───► SubsystemA
        └─► SubsystemB
        └─► SubsystemC
```

- `Client`：客户端，只与 `Facade` 打交道。
- `Facade`：外观类，对外提供统一接口。
- `SubsystemX`：子系统中的组件，真正完成各项功能。



## 示例场景

我们用“家庭影院系统”为例：

- 子系统：
  - DVD 播放器
  - 音响系统
  - 投影仪
- 客户端只需要调用 `HomeTheaterFacade.watchMovie()` 即可完成启动流程。



### Java 实现

```java showLineNumbers
// 子系统
class DVDPlayer {
    void on() { System.out.println("DVD 播放器开启"); }
    void play() { System.out.println("DVD 开始播放"); }
}

class Amplifier {
    void on() { System.out.println("音响开启"); }
    void setVolume(int level) { System.out.println("设置音量为 " + level); }
}

class Projector {
    void on() { System.out.println("投影仪开启"); }
    void wideScreenMode() { System.out.println("切换至宽屏模式"); }
}

// 外观类
class HomeTheaterFacade {
    private DVDPlayer dvd;
    private Amplifier amp;
    private Projector projector;

    public HomeTheaterFacade(DVDPlayer dvd, Amplifier amp, Projector projector) {
        this.dvd = dvd;
        this.amp = amp;
        this.projector = projector;
    }

    public void watchMovie() {
        System.out.println("准备观看电影...");
        projector.on();
        projector.wideScreenMode();
        amp.on();
        amp.setVolume(5);
        dvd.on();
        dvd.play();
    }
}

// 使用
public class Main {
    public static void main(String[] args) {
        DVDPlayer dvd = new DVDPlayer();
        Amplifier amp = new Amplifier();
        Projector projector = new Projector();

        HomeTheaterFacade homeTheater = new HomeTheaterFacade(dvd, amp, projector);
        homeTheater.watchMovie();
    }
}
```



### C++ 实现

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 子系统
class DVDPlayer {
public:
    void on() { cout << "DVD 播放器开启" << endl; }
    void play() { cout << "DVD 开始播放" << endl; }
};

class Amplifier {
public:
    void on() { cout << "音响开启" << endl; }
    void setVolume(int level) { cout << "设置音量为 " << level << endl; }
};

class Projector {
public:
    void on() { cout << "投影仪开启" << endl; }
    void wideScreenMode() { cout << "切换至宽屏模式" << endl; }
};

// 外观类
class HomeTheaterFacade {
    DVDPlayer* dvd;
    Amplifier* amp;
    Projector* projector;

public:
    HomeTheaterFacade(DVDPlayer* d, Amplifier* a, Projector* p)
        : dvd(d), amp(a), projector(p) {}

    void watchMovie() {
        cout << "准备观看电影..." << endl;
        projector->on();
        projector->wideScreenMode();
        amp->on();
        amp->setVolume(5);
        dvd->on();
        dvd->play();
    }
};

// 使用
int main() {
    DVDPlayer dvd;
    Amplifier amp;
    Projector projector;

    HomeTheaterFacade homeTheater(&dvd, &amp, &projector);
    homeTheater.watchMovie();
}
```



### Python 实现

```python showLineNumbers
# 子系统
class DVDPlayer:
    def on(self):
        print("DVD 播放器开启")
    def play(self):
        print("DVD 开始播放")

class Amplifier:
    def on(self):
        print("音响开启")
    def set_volume(self, level):
        print(f"设置音量为 {level}")

class Projector:
    def on(self):
        print("投影仪开启")
    def wide_screen_mode(self):
        print("切换至宽屏模式")

# 外观类
class HomeTheaterFacade:
    def __init__(self, dvd, amp, projector):
        self.dvd = dvd
        self.amp = amp
        self.projector = projector

    def watch_movie(self):
        print("准备观看电影...")
        self.projector.on()
        self.projector.wide_screen_mode()
        self.amp.on()
        self.amp.set_volume(5)
        self.dvd.on()
        self.dvd.play()

# 使用
dvd = DVDPlayer()
amp = Amplifier()
projector = Projector()

home_theater = HomeTheaterFacade(dvd, amp, projector)
home_theater.watch_movie()
```



### TypeScript 实现

```typescript showLineNumbers
// 子系统
class DVDPlayer {
  on() {
    console.log("DVD 播放器开启");
  }
  play() {
    console.log("DVD 开始播放");
  }
}

class Amplifier {
  on() {
    console.log("音响开启");
  }
  setVolume(level: number) {
    console.log(`设置音量为 ${level}`);
  }
}

class Projector {
  on() {
    console.log("投影仪开启");
  }
  wideScreenMode() {
    console.log("切换至宽屏模式");
  }
}

// 外观类
class HomeTheaterFacade {
  constructor(
    private dvd: DVDPlayer,
    private amp: Amplifier,
    private projector: Projector
  ) {}

  watchMovie() {
    console.log("准备观看电影...");
    this.projector.on();
    this.projector.wideScreenMode();
    this.amp.on();
    this.amp.setVolume(5);
    this.dvd.on();
    this.dvd.play();
  }
}

// 使用
const dvd = new DVDPlayer();
const amp = new Amplifier();
const projector = new Projector();

const homeTheater = new HomeTheaterFacade(dvd, amp, projector);
homeTheater.watchMovie();
```



## 小结

| 特性     | 内容                                                         |
| -------- | ------------------------------------------------------------ |
| 模式类型 | 结构型                                                       |
| 适用场景 | 简化复杂系统的使用、对外暴露统一接口                         |
| 优点     | <ul><li>客户端无需关心子系统细节</li><li>提高代码可读性与可维护性</li><li>符合“最少知识原则”</li></ul> |
| 缺点     | <ul><li>可能成为“上帝类”，过于臃肿</li><li>新增子系统时需修改外观类</li></ul> |

外观模式是“让系统更好用”的经典手法，尤其适合封装多个子系统，如：多媒体系统、数据库启动流程、第三方 API 等等。



