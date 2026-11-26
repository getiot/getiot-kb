---
sidebar_position: 4
slug: /debug-ros2-in-vscode
authors: [luhuadong]
---

# VS Code 编译和调试 ROS 2 工程



本文以 Ubuntu 20.04（ROS2 Foxy）系统为例，介绍如何在 VS Code 上配置 ROS2 的编译环境，并把 ROS 节点（C++）运行、调试起来。

:::tip

开始之前，建议先阅读《[VS Code 编译和调试 C/C++ 程序](/vscode/debug-cpp-in-vscode/)》和《[VS Code 配置文件](/vscode/vscode-config-files/)》。

:::

## 准备工作

### 安装依赖

安装编译器、调试器和 CMake 等依赖工具：

```bash
sudo apt install gcc g++ gdb cmake
```

安装 ROS，参考《[Ubuntu 20.04 安装 ROS2 Foxy](/ros2/ros2-installation-foxy-on-ubuntu/)》。

### 安装插件

安装以下 VS Code 扩展（选择 Microsoft 提供的）：

- C/C++
- Python
- CMake Tools
- ROS

### 下载示例工程

本示例完整工程代码可在 [GitHub](https://github.com/getiot/vscode-courses/tree/main/project/ros2_demo) 获取，下面展示主要代码。在这个示例中有一个 `MyNode` 类，它包含一个发布者和一个订阅者，发布者执行定时任务，每一秒往 `/my_topic` 主题发布一条消息，订阅者则订阅该主题并将消息内容打印出来。

```cpp showLineNumbers title="ros2_demo"
#include <chrono>
#include <functional>
#include <memory>
#include <string>

#include <rclcpp/rclcpp.hpp>
#include <std_msgs/msg/string.hpp>

using namespace std::chrono_literals;

class MyNode : public rclcpp::Node
{
public:
    MyNode(const std::string &name)
        : Node(name)
    {
        publisher_ = create_publisher<std_msgs::msg::String>("/my_topic", 10);
        timer_ = this->create_wall_timer(1000ms, std::bind(&MyNode::timer_callback, this));

        subscription_ = create_subscription<std_msgs::msg::String>(
            "/my_topic", 10, std::bind(&MyNode::sub_callback, this, std::placeholders::_1));
    }

private:
    void timer_callback()
    {
      auto message = std_msgs::msg::String();
      message.data = "Hello, world! " + std::to_string(count_++);
      RCLCPP_INFO(this->get_logger(), "Publishing: '%s'", message.data.c_str());
      publisher_->publish(message);
    }

    void sub_callback(const std_msgs::msg::String::SharedPtr msg)
    {
        RCLCPP_INFO(get_logger(), "Received: %s", msg->data.c_str());
    }

    rclcpp::Publisher<std_msgs::msg::String>::SharedPtr publisher_;
    rclcpp::Subscription<std_msgs::msg::String>::SharedPtr subscription_;
    rclcpp::TimerBase::SharedPtr timer_;
    size_t count_;
};

int main(int argc, char ** argv)
{
    rclcpp::init (argc, argv);

    auto my_node = std::make_shared<MyNode>("my_node");

    rclcpp::spin(my_node);
    rclcpp::shutdown();

    return 0;
}
```



## 配置文件

这里涉及 tasks.json、launch.json 和 c_cpp_properties.json 三个配置文件，这三个文件的作用和创建方法可参考《[VS Code 编译和调试 C/C++ 程序](/vscode/debug-cpp-in-vscode/)》。

### tasks.json

```json showLineNumbers title="tasks.json" {6}
{
    "tasks": [
        {
            "type": "shell",
            "label": "build",
            "command": "colcon build --symlink-install --cmake-args '-DCMAKE_BUILD_TYPE=Debug' -Wall -Wextra -Wpendantic && source install/setup.bash",
            "options": {
                "cwd": "${workspaceRoot}"
            },
            "problemMatcher": [
                "$gcc"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "detail": "调试器生成的任务。"
        }
    ],
    "version": "2.0.0"
}
```



### launch.json

```json showLineNumbers title="launch.json"
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "ROS: Launch",
            "preLaunchTask": "build",
            "type": "ros",
            "request": "launch",
            "target": "${workspaceFolder}/launch/start.py"
        }
    ]
}
```



### c_cpp_properties.json

```json showLineNumbers title="c_cpp_properties.json" {7}
{
    "configurations": [
        {
            "name": "Linux",
            "includePath": [
                "${workspaceFolder}/**",
                "/opt/ros/foxy/include/**"
            ],
            "defines": [],
            "compilerPath": "/usr/bin/clang-9",
            "cStandard": "c17",
            "cppStandard": "c++14",
            "intelliSenseMode": "linux-clang-x64"
        }
    ],
    "version": 4
}
```



## 运行调试

完成前面的工作后，就可以开始运行调试 ROS 程序。在开始之前，请确保你已经配置好 ROS 环境，打开终端，切换到 ros2_demo 工程目录，依次执行如下命令。

```bash
source /opt/ros/foxy/setup.bash
colcon build
source install/setup.bash
```

然后尝试启动 ROS 节点：

```bash
ros2 run ros2_demo my_node      # 方法一
ros2 launch ros2_demo start.py  # 方法二
```

此时你应该可以在当前终端看到如下打印：

```bash
[INFO] [1705859655.333671971] [my_node]: Publishing: 'Hello, world! 0'
[INFO] [1705859655.334122140] [my_node]: Received: Hello, world! 0
```

接着，在同一个终端输入 `code .` 启动 VS Code，点击左侧 “Run and Debug” 按钮打开运行和调试窗口，点击窗口上方 `ROS: Launch` 旁边的绿色小三角按钮开始调试（也可以直接按 `F5` 键进入调试模式）。

![](https://static.getiot.tech/vscode-debugging-ros-project.png#center)

现在，ROS 节点已经运行调试起来了。你可以在你想要停下了的代码处打上断点，并在左侧的窗口查看变量、监视变量的值，以及调用堆栈、线程运行情况等信息。

