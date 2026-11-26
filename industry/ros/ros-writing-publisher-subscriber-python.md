---
sidebar_position: 18
slug: /ros-writing-publisher-subscriber-python
authors: [luhuadong]
---

# ROS 发布/订阅节点示例（Python）




本文将基于 rospy 客户端库创建一个简单的 Hello World 软件包，实现一个发布节点（Publisher）和一个订阅节点（Subscriber），两个节点之间会循环传递“Hello World”字符串消息。

完成本次实验，你将学会如何使用 Python 编写一个 ROS 节点。



## 创建软件包

在 ROS 中，源代码是以包的形式组织的，所以在编写任何 ROS 程序之前，都必须先创建一个 ROS 软件包。当然创建软件包之前，你还需要创建工作空间，创建步骤参考 [ROS Catkin 工作空间](/ros/ros-catkin-workspace/)，这里假设你已经创建好了工作空间。

切换到 Catkin 工作空间的 src 目录，执行以下命令创建软件包：

```bash
$ catkin_create_pkg beginner_tutorials std_msgs rospy roscpp
```



## 创建 ROS 节点

该示例包含两个 ROS 节点：talker 和 listener，对应 talker.py 和 listener.py 源文件。注意：和 C++ 代码不同，Python 代码需要放在 scripts 目录。切换到 beginner_tutorials/src 目录，执行下面命令创建目录和文件。

```bash
$ mkdir scripts
$ cd scripts/
$ touch talker.py
$ touch listener.py
```



### talker 节点

```python
#!/usr/bin/env python3
import rospy
from std_msgs.msg import String

def talker():
    rospy.init_node('talker', anonymous=True)
    pub = rospy.Publisher('chatter', String, queue_size=10)
    rate = rospy.Rate(10) # 10hz
    while not rospy.is_shutdown():
        hello_str = "hello world %s" % rospy.get_time()
        rospy.loginfo(hello_str)
        pub.publish(hello_str)
        rate.sleep()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
```

在 talker.py 代码中，首先导入了 rospy 和 ros 消息模块中的 String 数据类型。然后在 `talker()` 函数中，我们对 ROS 节点进行了初始化，并创建了一个新的 ROS 发布器。之后，我们使用 while 循环来向 `/chatter` 话题发布“hello world”字符串消息。



### listener 节点

```python
#!/usr/bin/env python3
import rospy
from std_msgs.msg import String

def callback(data):
    rospy.loginfo(rospy.get_caller_id() + "I heard %s", data.data)
    
def listener():

    # In ROS, nodes are uniquely named. If two nodes with the same
    # name are launched, the previous one is kicked off. The
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaneously.
    rospy.init_node('listener', anonymous=True)

    rospy.Subscriber("chatter", String, callback)

    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()

if __name__ == '__main__':
    listener()
```

在 listener.py 代码中，首先对节点进行初始化，然后创建一个订阅器，订阅 `/chatter` 话题，之后就开始等待 ROS 消息了，这里的等待由 `rospy.spin()` 函数完成。当接收到消息，就会在 `callback()` 函数中打印出来。



## 运行 ROS 节点

和 C++ 节点不同，Python 编写的 ROS 节点不需要编译即可运行。

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
$ rosrun beginner_tutorials talker.py
```

在第三个终端启动 listener 节点，同样使用 rosrun 命令启动

```bash
$ rosrun beginner_tutorials listener.py
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

启动文件（launch）的好处是可以通过一条命令快速启动任意多个 ROS 节点。在软件包中（beginner_tutorials 目录）创建一个名为 launch 的目录用于存放启动文件，并新建一个 talker_listener_python.launch 文件。

```bash
$ mkdir launch
$ cd launch
$ touch talker_listener_python.launch
```

talker_listener_python.launch 启动文件的内容如下：

```xml
<launch>
    <node name="listener_node" pkg="beginner_tutorials" type="listener.py" output="screen"/>
    <node name="talker_node" pkg="beginner_tutorials" type="talker.py" output="screen"/>
</launch>
```

现在，我们可以使用 `roslaunch` 命令执行该启动文件：

```bash
$ roslaunch beginner_tutorials talker_listener_python.launch
```

运行效果和前面类似，如果要终止运行启动文件，在终端中按 Ctrl + C 即可。



