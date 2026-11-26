---
sidebar_position: 7
sidebar_label: 项目 - 触控远程遥控器
slug: /rtt-psoc6-demo-capsense-remote-controller
draft: true
---

# 英飞凌 PSoC6 评估板项目 - 触控远程遥控器

![](https://static.getiot.tech/capsense-remote-controller.png)

## 项目介绍

使用 Python 编写一个 JSON-RPC 服务器来接收来自单片机通过 WiFi 发送的 JSON 格式的命令，并根据参数调整电脑屏幕的亮度。为了实现这一目的，可以使用以下步骤：

1. **创建 JSON-RPC 服务器**：使用 `jsonrpcserver` 库来处理接收到的 JSON 请求。
2. **调整屏幕亮度**：在 Linux 和 macOS 系统上，可以使用 `xrandr` 或 `brightness` 等工具，在 Windows 上可以使用 `screen-brightness-control` 库。

安装依赖

```bash
pip install jsonrpcserver screen-brightness-control
```

编写 Python 代码

```python
from jsonrpcserver import method, serve
import screen_brightness_control as sbc

# 方法用于接收并处理来自单片机的JSON请求
@method
def set_brightness(level: int):
    if 0 <= level <= 100:
        # 设置屏幕亮度
        sbc.set_brightness(level)
        return f"Brightness set to {level}%"
    else:
        return "Invalid brightness level. Must be between 0 and 100."

# 启动 JSON-RPC 服务器
if __name__ == "__main__":
    print("Starting JSON-RPC server...")
    serve()
```



## 工作原理

该程序会启动一个 JSON-RPC 服务器，监听来自单片机的请求。

单片机通过 WiFi 网络发送类似以下格式的 JSON 请求：

```bash
{
    "jsonrpc": "2.0",
    "method": "set_brightness",
    "params": [75],
    "id": 1
}
```

Python 服务器接收到请求后，会提取参数，并调用 `set_brightness` 函数来调整屏幕亮度。



### 测试方法

你可以通过发送 POST 请求来测试此服务器，例如使用 `curl` 命令：

```bash
curl -X POST http://localhost:5000 -d '{"jsonrpc": "2.0", "method": "set_brightness", "params": [50], "id": 1}' -H "Content-Type: application/json"
```



