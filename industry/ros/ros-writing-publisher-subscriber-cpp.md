---
sidebar_position: 17
slug: /ros-writing-publisher-subscriber-cpp
authors: [luhuadong]
---

# ROS 发布/订阅节点示例（C++）



本文将基于 roscpp 客户端库创建一个简单的 Hello World 软件包，实现一个发布节点（Publisher）和一个订阅节点（Subscriber），两个节点之间会循环传递“Hello World”字符串消息。

完成本次实验，你将学会如何使用 C++ 编写一个 ROS 节点。



## 创建软件包

在 ROS 中，源代码是以包的形式组织的，所以在编写任何 ROS 程序之前，都必须先创建一个 ROS 软件包。当然创建软件包之前，你还需要创建工作空间，创建步骤参考 [ROS Catkin 工作空间](/ros/ros-catkin-workspace/)，这里假设你已经创建好了工作空间。

切换到 Catkin 工作空间的 src 目录，执行以下命令创建软件包：

```bash
$ catkin_create_pkg beginner_tutorials std_msgs rospy roscpp
```



## 创建 ROS 节点

该示例包含两个 ROS 节点：talker 和 listener，对应 talker.cpp 和 listener.cpp 源文件。切换到 beginner_tutorials/src 目录，执行下面命令创建源文件。

```bash
$ touch talker.cpp
$ touch listener.cpp
```



### talker 节点

```cpp
#include "ros/ros.h"
#include "std_msgs/String.h"
#include <sstream>

int main(int argc, char **argv)
{
    ros::init(argc, argv, "talker");
    ros::NodeHandle n;
    ros::Publisher chatter_pub = n.advertise<std_msgs::String>("chatter", 1000);
    ros::Rate loop_rate(10);
    
    int count = 0;
    while (ros::ok())
    {
        std_msgs::String msg;
        std::stringstream ss;
        ss << "hello world " << count;
        msg.data = ss.str();
        ROS_INFO("%s", msg.data.c_str());
        
        chatter_pub.publish(msg);
        ros::spinOnce();
        loop_rate.sleep();
        ++count;
    }
    return 0;
}
```



### listener 节点

```cpp
#include "ros/ros.h"
#include "std_msgs/String.h"

void chatterCallback(const std_msgs::String::ConstPtr& msg)
{
    ROS_INFO("I heard: [%s]", msg->data.c_str());
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "listener");
    ros::NodeHandle n;
    
    ros::Subscriber sub = n.subscribe("chatter", 1000, chatterCallback);
    ros::spin();
    
    return 0;
}
```



## 修改 CMakeLists.txt 文件

将下面几行添加到 `beginner_tutorials/CMakeLists.txt` 文件的底部。

```cmake
add_executable(talker src/talker.cpp)
target_link_libraries(talker ${catkin_LIBRARIES})

add_executable(listener src/listener.cpp)
target_link_libraries(listener ${catkin_LIBRARIES})

# (optional) Install the executables.
install(TARGETS talker listener
        DESTINATION bin)
```



## 编译 ROS 软件包

在 `catkin_ws` 目录执行 `catkin_make` 命令编译软件包。

```bash
$ catkin_make
...
[ 50%] Linking CXX executable /home/rudy/catkin_ws/devel/lib/beginner_tutorials/talker
[ 50%] Linking CXX executable /home/rudy/catkin_ws/devel/lib/beginner_tutorials/listener
[ 75%] Built target listener
[100%] Built target talker
```



## 运行 ROS 节点

打开 3 个终端，分别执行下面命令设置环境变量

```bash
$ source devel/setup.bash
```

先在第一个终端启动 roscore

```bash
$ roscore
```

在第二个终端启动 talker 节点，这里使用 rosrun 命令启动

```bash
$ rosrun beginner_tutorials talker
```

在第三个终端启动 listener 节点，同样使用 rosrun 命令启动

```bash
$ rosrun beginner_tutorials listener
```

可以看到终端在不断地打印消息。此时我们可以通过 `rostopic` 命令检查当前系统中的 ROS 话题，如下：

```bash
$ rostopic list
/chatter
/rosout
/rosout_agg
```

这里的 `chatter` 就是 talker 节点发布的话题；`rosout` 则是用于日志记录的话题，当我们启动 `roscore` 后就已经创建好了。



## 创建启动文件

启动文件（launch）的好处是可以通过一条命令快速启动任意多个 ROS 节点。在软件包中（beginner_tutorials 目录）创建一个名为 launch 的目录用于存放启动文件，并新建一个 talker_listener.launch 文件。

```bash
$ mkdir launch
$ cd launch
$ touch talker_listener.launch
```

talker_listener.launch 启动文件的内容如下：

```xml
<launch>
    <node name="listener_node" pkg="beginner_tutorials" type="listener" output="screen"/>
    <node name="talker_node" pkg="beginner_tutorials" type="talker" output="screen"/>
</launch>
```

这个启动文件将一次性启动 talker 和 listener 两个节点，节点的程序包含在 `pkg` 域中，可执行文件名在 `type` 域中，你可以任意命名这些节点。当然，建议将节点名取得与可执行文件名相近，这样更有利于维护。

现在，我们可以使用 `roslaunch` 命令执行该启动文件：

```bash
$ roslaunch beginner_tutorials talker_listener.launch
```

运行效果和前面类似，如果要终止运行启动文件，在终端中按 Ctrl + C 即可。



