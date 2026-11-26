---
sidebar_position: 22
slug: /ros-launch-files
authors: [luhuadong]
---

# ROS 启动文件



本文主要介绍 ROS 启动文件（launch file）的作用、组成以及编写方法。



## launch 文件的作用

在 ROS 中，我们可以通过 `rosrun` 命令启动 ROS 节点，启动命令如下：

```bash
rosrun <ros_pkg_name> <node_name>
```

通常来说，一个节点程序一般只能完成功能单一的任务，但是一个完整的 ROS 机器人一般由很多个节点程序同时运行、相互协作才能完成复杂的任务。这就要求我们必须高效、可靠地启动很多个节点，而不是通过 `rosrun` 命令来依次启动。实际上，launch 启动文件就是为解决这个需求出现的。

launch 文件是一个 xml 格式的脚本文件，把需要启动的节点写进 launch 文件中，并通过 `roslaunch` 工具来调用 launch 文件，执行这个脚本文件即可一次性启动所有的节点程序。

运行 launch 文件的命令语法如下：

```bash
roslaunch <ros_pkg_name> <launch_file_name>
```

`roslaunch` 命令的另一优势是可以自动执行 `roscore` 命令，所以我们不必在运行这些节点前先去运行 `roscore` 命令。



## launch 文件组成元素

launch 文件遵循 XML 格式规范，是一种标签文本，ROS 支持的标签如下表所示。

| 标签           | 描述                           |
| -------------- | ------------------------------ |
| `<launch>`     | 根标签                         |
| `<node>`       | 需要启动的 node 节点及其参数   |
| `<include>`    | 包含其他 launch 文件           |
| `<machine>`    | 指定运行的机器                 |
| `<env-loader>` | 设置环境变量                   |
| `<param>`      | 定义参数到参数服务器           |
| `<rosparam>`   | 启动 yaml 文件参数到参数服务器 |
| `<arg>`        | 定义变量                       |
| `<remap>`      | 设定参数映射                   |
| `<group>`      | 设定命名空间                   |

官方参考链接：[https://wiki.ros.org/roslaunch/XML](https://wiki.ros.org/roslaunch/XML)



### `<launch>` 标签

每个 .xml 文件都必须包含一个根元素，这个根元素由一对 `<launch>` 标签定义。

```xml
<launch>

</launch>
```



### `<node>` 标签

`<node>` 标签的上一级根标签是 `<launch>` 标签，用于启动一个 ROS 节点。启动一个节点的写法如下：

```xml
<node pkg="package-name" type="executable-name" name="node-name" />
```

`<node>` 标签至少包含三个属性：pkg、type 和 name。其中，pkg 属性指定了要运行的节点属于哪个功能包；type 属性指定要运行节点的可执行文件的名称；name 属性给节点指派了名称，它将覆盖任何通过调用 `ros::init` 来赋予的节点名称。

另外，较常用的属性还有下面这些：

- output：节点输出属性。例如 `output="screen"` 可以将节点的标准输出到屏幕（终端），而不是存储到日志文件中。
- respawn：节点重生属性。当 roslaunch 开启所有节点后，roslaunch 会监视每个节点，记录那些仍然活动的节点。如果想在某个节点终止后要求 roslaunch 重启该节点，可以通过该属性来完成，例如 `respawn="true"`。
- required：必要节点属性。当一个节点被声明为必要节点，即 `required="true"`，当该节点终止时，roslaunch 会终止所有其他活跃节点并退出。例如，在依赖激光雷达的机器人导航中，如果激光雷达节点意外退出，那么 roslaunch 将会终止其他节点，然后退出。

注意：required 属性的优先级高于 respawn 属性。



### `<include>` 标签

如果想在一个 launch 文件中调用另一个 launch 文件，可以使用 `<include>` 包含标签。

```xml
<include file="$(find package-name)/launch-file-name" />
```

提示：由于直接输入路径信息很烦琐、容易出错，因此大多数包含元素都使用查找（find）命令搜索功能包的位置来替代直接输入绝对路径。



### `<param>` 标签

在开发 ROS 程序时，经常需要随时调整一些参数，为了避免每次调整参数后都要重新编译源码，我们可以使用 `<param>` 标签在 launch 文件中直接设定节点中的参数，这样只需要修改 launch 文件中的节点参数即可。

一个 `<param>` 标签的写法如下：

```xml
<param name="参数的名称" type="参数的类型" value="参数的值" />
```

其中，name 属性用于指定该参数的名称；type 属性指定该参数的类型，包括 str、int、double、bool、yaml 等类型；value 属性是该参数要设定的值。

下面是一个简单的示例：

```xml
<launch>
	<node pkg="test_pkg" type="test_pkg_node" name="test_pkg_node">
        <param name="name" type="str" value="rudy" />
        <param name="age" type="int" value="30" />
        <param name="handsome" type="bool" value="true" />
    </node>
</launch>
```



### `<arg>` 标签

`<arg>` 标签用于在 launch 文件中定义一些变量以方便修改。

一个 `<arg>` 标签的写法如下：

```xml
<arg name="参数的名称" default="默认值" doc="描述" />
```

下面是一个简单的示例，这个示例通过参数的配置决定加载哪个 launch 文件。

```xml
<launch>
	<arg name="driver_methods" default="two_wheels" doc="driver_type [two_wheels, three_wheels]" />
    <node pkg="bobac2_base" type="bobac2_base_node" name="bobac2_base_node" />
    <include file="$(find bobac2_kinematics)/launch/bobac2_kinematics_$(arg driver_methods).launch" />
</launch>
```

在该示例中，变量 `driver_methods` 默认为 two_wheels，你可以在启动时通过命令修改变量值，例如：

```bash
$ roslaunch bobac2_base startup.launch driver_methods:=three_wheels
```



### `<group>` 标签

`<group>` 标签允许将节点分组放到不同的命名空间。这是一个很实用的标签，比如要将同一个节点运行两次，就可以将这个节点放到两个不同的 group 中。

一个 `<group>` 标签的写法如下：

```xml
<group ns="命名空间的名字" clear_params="true|false" />
```

其中，属性 ns 用于指定命名空间的名字，属性 clear_params 用于指定在运行前是否清空该命名空间下的所有参数。
