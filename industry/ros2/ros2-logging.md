---
sidebar_position: 15
authors: [luhuadong]
---

# ROS2 日志管理



日志信息对于 ROS 节点程序的开发和调试有着重要作用，ROS 2 中为我们提供了完善的日志消息接口和管理工具。本节我们将学习在 ROS 2 中如何打印日志，以及使用 rqt_console 工具对日志进行管理和可视化。



## 日志等级

在 ROS2 中，一共有五个日志级别，级别自高到低分别是：

| 级别  | 中文   | 描述                                       |
| ----- | ------ | ------------------------------------------ |
| Fatal | 致命级 | 描述系统为了自我保护即将终止的消息         |
| Error | 错误级 | 描述非致命但是会阻碍程序运行的消息         |
| Warn  | 警告级 | 描述不损坏功能运行但是预期之外的行为的消息 |
| Info  | 信息级 | 描述系统正常运行时事件和状态消息           |
| Debug | 调试级 | 描述系统一步一步运行的详细消息             |

ROS2 中默认开启的日志级别是 Info，会自动显示 info 级别以上的所有日志，包括 Info、Warn、Error、Fatal。

当运行 ROS 节点时，你可以实时修改日志级别，以达到动态控制日志输出的目的。例如，只显示 Warn 级别以上的日志，可以执行如下命令：

```bash
ros2 run turtlesim turtlesim_node --ros-args --log-level WARN
```

此时，启动的仿真器就只会向外发布 Warn 级别以上的日志，Info 和 Debug 级别的日志都将被忽略。



## C++ API 接口

### 常规接口

```cpp
#define 	RCLCPP_DEBUG(logger, ...)
#define 	RCLCPP_INFO(logger, ...)
#define 	RCLCPP_WARN(logger, ...)
#define 	RCLCPP_ERROR(logger, ...)
#define 	RCLCPP_FATAL(logger, ...)
```

### 多种模式

```cpp
// Log a message with severity DEBUG.
#define 	RCLCPP_DEBUG(logger, ...)
// Log a message with severity DEBUG with the following conditions: All subsequent log calls except the first one are being ignored.
#define 	RCLCPP_DEBUG_ONCE(logger, ...)
// Log a message with severity DEBUG with the following conditions: Log calls are being ignored when the expression evaluates to false.
#define 	RCLCPP_DEBUG_EXPRESSION(logger, expression, ...)
```

Log a message with severity DEBUG with the following conditions: Log calls are being ignored when the function returns false.

```cpp
#define 	RCLCPP_DEBUG_FUNCTION(logger, function, ...)
```

Log a message with severity DEBUG with the following conditions: The first log call is being ignored but all subsequent calls are being processed.

```
#define 	RCLCPP_DEBUG_SKIPFIRST(logger, ...)
```

Log a message with severity DEBUG with the following conditions: Log calls are being ignored if the last logged message is not longer ago than the specified duration.

```
#define 	RCLCPP_DEBUG_THROTTLE(logger, clock, duration, ...)
```

Log a message with severity DEBUG with the following conditions: The first log call is being ignored but all subsequent calls are being processed. Log calls are being ignored if the last logged message is not longer ago than the specified duration.

```
#define 	RCLCPP_DEBUG_SKIPFIRST_THROTTLE(logger, clock, duration, ...)
```

Log a message with severity DEBUG.

```
#define 	RCLCPP_DEBUG_STREAM(logger, stream_arg)
```

Log a message with severity DEBUG with the following conditions: All subsequent log calls except the first one are being ignored.

```
#define 	RCLCPP_DEBUG_STREAM_ONCE(logger, stream_arg)
```

Log a message with severity DEBUG with the following conditions: Log calls are being ignored when the expression evaluates to false.

```
#define 	RCLCPP_DEBUG_STREAM_EXPRESSION(logger, expression, stream_arg)
```

Log a message with severity DEBUG with the following conditions: Log calls are being ignored when the function returns false.

```
#define 	RCLCPP_DEBUG_STREAM_FUNCTION(logger, function, stream_arg)
```

Log a message with severity DEBUG with the following conditions: The first log call is being ignored but all subsequent calls are being processed.

```
#define 	RCLCPP_DEBUG_STREAM_SKIPFIRST(logger, stream_arg)
```

Log a message with severity DEBUG with the following conditions: Log calls are being ignored if the last logged message is not longer ago than the specified duration.

```
#define 	RCLCPP_DEBUG_STREAM_THROTTLE(logger, clock, duration, stream_arg)
```

Log a message with severity DEBUG with the following conditions: The first log call is being ignored but all subsequent calls are being processed. Log calls are being ignored if the last logged message is not longer ago than the specified duration.

```
#define 	RCLCPP_DEBUG_STREAM_SKIPFIRST_THROTTLE(logger, clock, duration, stream_arg)
```



### 示例代码

```cpp
// printf style
RCLCPP_DEBUG(node->get_logger(), "My log message %d", 4);

// C++ stream style
RCLCPP_DEBUG_STREAM(node->get_logger(), "My log message " << 4);
```





## rqt_console 工具

`rqt_console` 工具可以帮助我们有效的查看机器人系统中的日志信息，提高调试、测试、开发的效率，快速找到你想要看到的日志。

在终端中运行 ROS2 节点时，节点的日志信息会在终端中显示出来，但是这种方式呈现的日志比较凌乱，所以 ROS2 提供了一个专门用于管理日志信息的可视化工具——`rqt_console`。

`rqt_console` 是一个 GUI 工具，用于自检 ROS 2 中的日志消息。通常，日志消息显示在终端中。使用 `rqt_console`，您可以随着时间的推移收集这些消息，以更有条理的方式仔细查看它们，过滤它们，保存它们，甚至重新加载保存的文件以在不同的时间进行内部检查。

节点使用日志以各种方式输出有关事件和状态的消息。为了用户的利益，它们的内容通常是信息性的。日志消息的意图由节点的作者定义，尽管内容可以在运行时编写。

首先打开一个新的终端，使用如下指令即可启动rqt_console：

```bash
ros2 run rqt_console rqt_console
```

在打开的窗口中，我们可以看到三个子窗口。最上边一个窗口会显示所有 ROS2 系统中的日志，是内容最多的，如果我们想做筛选，可以在中间的窗口中选择日志级别，此时中间窗口则会剔除无关级别的日志，如果我们想在日志中搜索某一字符串，那就可以在最下边的窗口中输入，确任后该窗口只显示包含此字符串的日志。中间和下边的窗口还可以添加更多筛选规则。

我们来启动小海龟仿真器试一试。

```bash
ros2 run turtlesim turtlesim_node
```

为了产生日志信息，我们可以控制海龟撞到仿真器的边缘：

```bash
ros2 topic pub -r 1 /turtle1/cmd_vel geometry_msgs/msg/Twist "{linear:{x: 2.0,y: 0.0,z: 0.0}, angular:{x: 0.0,y: 0.0,z: 0.0}}"
```

当海龟撞到边缘时，`rqt_console` 中就会弹出很多警告信息：

![](https://static.getiot.tech/rqt_console-testing.png)



