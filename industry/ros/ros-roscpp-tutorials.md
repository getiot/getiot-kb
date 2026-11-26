---
sidebar_position: 15
slug: /ros-roscpp-tutorials
authors: [luhuadong]
---

# roscpp 库基本用法



本文主要介绍如何使用 roscpp 客户端库编写 ROS 节点，包括 ROS 节点中使用的头文件介绍、初始化 ROS 节点，以及发布和订阅话题等基本用法。



## 头文件

使用 C++ 编程时，首先需要包含头文件。为了创建 ROS 节点，C++ 源文件中必须包含以下头文件：

```cpp
#include "ros/ros.h"
```

ros.h 文件中包含了实现 ROS 功能所必需的所有头文件，如果不包含该头文件，就不能创建 ROS 节点。

ROS 节点中使用的第二种头文件是 ROS 消息头文件。如果要在节点中使用某种特定的消息类型，那么一定要包含消息头文件。ROS 中有一些内置的消息类型，当然用户也可以自定义新的消息类型。

ROS 中有一个名为 `std_msgs` 的内置消息软件包，其中包含诸如整型、浮点型和字符串类型等的标准数据类型的消息定义。例如，如果代码中需要用到字符串消息，那么需要添加如下代码：

```cpp
#include "std_msgs/String.h"
```

在这行代码中，双引号的第一部分是软件包的名称，第二部分是消息类型的名称。如果需要使用定制的消息类型，可以使用如下代码：

```cpp
#include "msg_pkg_name/message_name.h"
```

以下是 `std_msgs` 软件包中的一些消息头文件：

```cpp
#include "std_msgs/Int32.h"
#include "std_msgs/Int64.h"
```

如果你想了解 `std_msgs` 软件包的完整消息类型列表，可以点击[这里](https://wiki.ros.org/std_msgs)查看。



## 初始化 ROS 节点

在编写任何 ROS 节点功能之前，首先要做的就是初始化节点。

在 C++ 中，使用下面几行代码即可完成初始化：

```cpp
int main(int argc, char **argv)
{
    ros::init(argc, argv, "name_of_node");
    ...
}
```

`ros::init()` 函数用于初始化 ROS 节点，在调用时可以向其传递 argc、argv 命令行参数和节点的名称。这个名称就是 ROS 节点的名称，后续可以通过 `rosnod list` 命令查看。



## 在 ROS 节点中打印信息

ROS 提供了记录日志信息的应用程序接口。这些信息是一些可读字符串，代表了节点的运行状态。

在 C++ 中，以下函数可以用于记录节点信息：

```cpp
ROS_INFO(string_msg, args);    /* 记录节点输出的基本信息 */
ROS_WARN(string_msg, args);    /* 记录节点输出的警告信息 */
ROS_DEBUG(string_msg, args);   /* 记录节点输出的调试信息 */
ROS_ERROR(string_msg, args);   /* 记录节点输出的错误信息 */
ROS_FATAL(string_msg, args);   /* 记录节点输出的致命信息 */
```

使用示例：

```cpp
ROS_INFO("Hello %s", "World");
```



## 创建节点句柄

初始化节点后，需要创建一个节点句柄实例，用于启动 ROS 节点和消息发布、订阅等操作。

在 C++ 中，我们可以使用 `ros::NodeHandle` 创建节点句柄，如下：

```cpp
ros::NodeHandle nh;
```



## 创建 ROS 消息定义

发布话题之前，需要创建一个 ROS 消息定义。

在 C++ 中，我们可以使用下面代码创建一个 ROS 消息的实例，并为其添加数据：

```cpp
std_msgs::String msg;
msg.data = "String data";
```



## 在 ROS 节点中发布话题

如果想在 ROS 节点中发布话题，可以使用下面代码创建发布者对象，并添加待发布的话题。

```cpp
ros::Publisher publisher_obj = node_handle.advertise<ROS message type> ("topic_name", 1000);
```

第一个参数是话题的名称，第二个参数是队列大小。

创建了待发布的话题后，就可以使用 `publish()` 方法将消息发布到对应话题。

```cpp
publisher_obj.publish(message);
```

使用示例：

```cpp
ros::Publisher chatter_pub = nh.advertise<std_msgs::String> ("chatter", 1000);
chatter_pub.publish(msg);
```



## 在 ROS 节点中订阅话题

与发布话题相对应的是订阅话题，在 C++ 中订阅话题的语法如下：

```cpp
ros::Subscriber subscriber_obj = node_handle.subscribe("topic_name", 1000, callback_function);
```

订阅话题时，不需要指定话题的消息类型，但是必须给定话题的名称和对应的回调函数。回调函数是用户自定义的函数，一旦节点从该话题接收到 ROS 消息，回调函数就会被执行，从而可以及时处理 ROS 消息。

例如，假设有一个 "chatter" 话题的回调函数 `chatterCallback()`，那么可以这样订阅话题：

```cpp
ros::Subscriber sub = n.subscribe("chatter", 1000, chatterCallback);
```



## 在 ROS 节点中编写回调函数

当订阅 ROS 话题并且有消息到达话题时，回调函数就被触发。下面是一个 C++ 处理回调函数的基本模型：

```cpp
void callback_name(const ros_message_const_pointer & pointer)
{
    // 获取数据
    pointer->data;
}
```

示例：在回调函数中处理 ROS 字符串消息并显示数据

```cpp
void chatterCallback(const std_msgs::String::ConstPtr & msg)
{
    ROS_INFO("I heard: [%s]", msg->data.c_str());
}
```



## ROS 节点中的 spin 函数

在订阅或者发布函数之后，我们还需要调用一个函数来处理来自其他节点的订阅请求或发布请求。在 C++ 节点中，发布话题后需要调用 `ros::spinOnce()` 函数。

- 如果只订阅话题，那么应该调用 `ros::spinOnce()` 函数；
- 如果既要发布话题又要订阅话题，那么可以使用 `spin()` 函数。



## ROS 节点中的 sleep 函数

如果想为节点中的循环设置一个恒定的速率，那么可以用 `ros::Rate` 功能。我们可以先创建一个 `ros::Rate` 实例，并在该实例中指定我们想要的速率，然后调用实例的 `sleep()` 函数来使其生效。

使用示例：

```cpp
ros::Rate r(10); // 10Hz
r.sleep();
```



## 设置和获取 ROS 参数

在 C++ 中，我们使用以下代码来获取 ROS 参数。通常，你需要先声明一个变量，然后用节点句柄 `node_handle` 中的 `getParam()` 函数来获取所需要的参数。

```cpp
std::string global_name;
if (nh.getParam("/global_name", global_name))
{
    /* ... */
}
```

使用示例：

```cpp
nh.setParam("/global_param", 5);
```



## 更多示例

- [ROS 发布/订阅节点示例（C++）](/ros/ros-writing-publisher-subscriber-cpp/)
- [ROS 服务/客户节点示例（C++）](/ros/ros-writing-service-client-cpp/)

