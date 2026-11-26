---
sidebar_position: 16
slug: /ros-rospy-tutorials
authors: [luhuadong]
---

# rospy 库基本用法



本文主要介绍如何使用 rospy 客户端库编写 ROS 节点，包括 ROS 节点中导入模块、初始化 ROS 节点，以及发布和订阅话题等基本用法。



## 模块导入

使用 Python 编程时，首先需要导入 rospy 模块，才能创建 ROS 节点。

```python
import rospy
```

rospy 模块包含了所有重要的 ROS 功能。另一个常用的模块是 msg 消息类型模块，下面是在 Python 中导入字符串消息类型的代码：

```python
from std_msgs.msg import String
```

如果你想了解 `std_msgs` 软件包的完整消息类型列表，可以点击[这里](https://wiki.ros.org/std_msgs)查看。



## 初始化 ROS 节点

在编写任何 ROS 节点功能之前，首先要做的就是初始化节点。

在 Python 中，使用下面代码即可完成初始化：

```python
rospy.init_node('name_of_node', anonymous = True)
```

第一个参数是 ROS 节点的名称，第二个参数 `anonymous=True` 意味着可以在系统中同时运行该节点的多个实例。初始化后可通过 `rosnod list` 命令查看 ROS 节点信息。



## 在 ROS 节点中打印信息

ROS 提供了记录日志信息的应用程序接口。这些信息是一些可读字符串，代表了节点的运行状态。

在 Python 中，以下函数可以用于记录节点信息：

```python
rospy.loginfo(msg, *args)    # 记录节点输出的基本信息 */
rospy.logwarn(msg, *args)    # 记录节点输出的警告信息 */
rospy.logdebug(msg, *args)   # 记录节点输出的调试信息 */
rospy.logerr(msg, *args)     # 记录节点输出的错误信息 */
rospy.logfatal(msg, *args)   # 记录节点输出的致命信息 */
```

使用示例：

```python
rospy.logerr("%s returned the invalid value %s", other_name, other_value)
```



## 创建节点句柄

在 Python 中，不需要像 C++ 那样创建节点句柄，因为 rospy 模块在内部已经自动解决了这个问题。



## 创建 ROS 消息定义

在 Python 中，创建 ROS 消息很简单。例如，我们可以使用下面代码向字符串中添加数据：

```python
msg = String()
msg.data = "string data"
```



## 在 ROS 节点中发布话题

在 Python 中，发布话题的语法如下：

```python
publisher_obj = rospy.Publisher('topic_name', message_type, queue_size)
```

使用示例：

```python
pub = rospy.Publisher('chatter', String, queue_size = 10)
pub.publish(hello_str)
```

该示例发布了一个名为 chatter 的话题，消息类型为 `std_msgs/String`，队列大小为 10。



## 在 ROS 节点中订阅话题

与发布话题相对应的是订阅话题，在 Python 中订阅话题的语法如下：

```python
rospy.Subscriber("topic_name", message_type, callback_function)
```

回调函数是用户自定义的函数，一旦节点从该话题接收到 ROS 消息，回调函数就会被执行，从而可以及时处理 ROS 消息。

例如，假设有一个 "chatter" 话题的回调函数 `chatterCallback()`，那么可以这样订阅话题：

```python
rospy.Subscriber("chatter", String, chatterCallback)
```



## 在 ROS 节点中编写回调函数

当订阅 ROS 话题并且有消息到达话题时，回调函数就被触发。下面是一个 Python 处理回调函数的示例：

```python
def chatterCallback(data):
    rospy.loginfo(rospy.get_caller_id() + "I heard %s", data.data)
```



## ROS 节点中的 spin 函数

Python 中没有 `spin()` 函数，但是却可以在发布话题后使用 `rospy.sleep()` 函数。如果只订阅话题，那么可以使用 `rospy.spin()` 函数。



## ROS 节点中的 sleep 函数

如果想为节点中的循环设置一个恒定的速率，那么可以用 `rospy.Rate()` 函数。我们可以先创建一个 `rospy.Rate` 实例，并在该实例中指定我们想要的速率，然后调用实例的 `sleep()` 函数来使其生效。

使用示例：

```python
rate = rospy.Rate(10)  # 10Hz
rate.sleep()
```



## 设置和获取 ROS 参数

在 Python 中，我们使用 `rospy.get_param` 和 `rospy.set_param` 来获取或设置 ROS 参数。例如：

```python
global_name = rospy.get_param("/global_name")  # 获取参数
rospy.set_param('private_int', '2')            # 设置参数
```



## 更多示例

- [ROS 发布/订阅节点示例（Python）](/ros/ros-writing-publisher-subscriber-python/)
- [ROS 服务/客户节点示例（Python）](/ros/ros-writing-service-client-python/)

