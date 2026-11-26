---
sidebar_position: 13
authors: [luhuadong]
---

# ROS2 组件



## ROS2 组件是什么

在 ROS1 中，我们可以把代码写成一个 node（节点）或者一个 nodelet。ROS1 的 node 会被编译成可执行文件，而 nodelets 会被编译成库之后在运行时被一个容器加载。

在 ROS2 里，我们建议使用一种和 nodelet 类似的方式编程，我们把这种方式命名为——组件（component）。这种方法可以使一些通用的概念更加容易地被加入到代码中，例如“生命周期”（life cycle）。在 ROS2 中使用了统一的 API，组件编程方式可以避免使用不同 API 造成的缺陷。

注意：现在还是可以自己给节点写 main 函数的，但是并不推荐这么做。

通过使这个过程变成“运行时决定”，码农们有了以下两种选择：

- 让不同的节点跑在不同的进程中，这样可以使 运行/错误 分离，同时对单个节点的 debug 也更容易。
- 在一个进程里跑多个节点，这样开销更小，通信效率更高。

另外，ros2 launch 可以通过特殊的加载动作自动地实现这些操作。



## 编写一个 ROS2 组件

因为组件只会被编译成库，所以不需要main()函数，看这里的例子：

示例：[talker_component.cpp](https://github.com/getiot/ros2-demos/blob/rolling/composition/src/talker_component.cpp)

组件通常都是 rclcpp::Node 的子类，因为组件不能控制线程，所以其构造函数里不能进行占用时间太长的或者是阻塞的任务。然而它可以使用计时器（tmier）来获取周期性的节律（就是可以用 timer 按照一定时间回调，跟 spin 差不多），除此以外它还可以创建 publisher、subscriber、server、client 等等。

这样做（把这样的 class 做成一个 component）的一个重要原因是，这个 class 用 rclcpp_components 里的一个宏把自己注册成一个组件。

就是写好一个 Node 以后，在后面加上：

```cpp
#include "rclcpp_components/register_node_macro.hpp"

// Register the component with class_loader.
// This acts as a sort of entry point, allowing the component to be discoverable when its library
// is being loaded into a running process.
RCLCPP_COMPONENTS_REGISTER_NODE(composition::Talker)
```

这样当这个 Node 的库被加载时，就能发现这个组件了。

另外，组件的 CMakeLists.txt 里必须加上

```cmake
add_library(talker_component SHARED
   src/talker_component.cpp)
rclcpp_components_register_nodes(talker_component "composition::Talker")
# To register multiple components in the same shared library, use multiple calls
# rclcpp_components_register_nodes(talker_component "composition::Talker2")
```

提示：为了让 component_container 能够找到想要的 component，这个 container 必须在一个 source 过相关工作空间的 shell 里打开。



## 使用组件

composition 包里有许多不同的组件使用方法，三个最常用的：

1. 打开一个 container，然后 load_node。ROS 服务就会加载传进来的包和库名字对应的组件，然后开始跑这个组件。不使用代码来激活 ROS 服务也行，可以通过命令行来。
2. 写一个包含多个节点的程序，这时程序里需要包含组件的头文件。
3. 写一个 launch 文件，用 ros2 launch 来创建 container，并加载多个组件。



## 完整代码

```cpp
// Copyright 2016 Open Source Robotics Foundation, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "composition/talker_component.hpp"

#include <chrono>
#include <iostream>
#include <memory>
#include <utility>

#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"

using namespace std::chrono_literals;

namespace composition
{

// Create a Talker "component" that subclasses the generic rclcpp::Node base class.
// Components get built into shared libraries and as such do not write their own main functions.
// The process using the component's shared library will instantiate the class as a ROS node.
Talker::Talker(const rclcpp::NodeOptions & options)
: Node("talker", options), count_(0)
{
  // Create a publisher of "std_mgs/String" messages on the "chatter" topic.
  pub_ = create_publisher<std_msgs::msg::String>("chatter", 10);

  // Use a timer to schedule periodic message publishing.
  timer_ = create_wall_timer(1s, std::bind(&Talker::on_timer, this));
}

void Talker::on_timer()
{
  auto msg = std::make_unique<std_msgs::msg::String>();
  msg->data = "Hello World: " + std::to_string(++count_);
  RCLCPP_INFO(this->get_logger(), "Publishing: '%s'", msg->data.c_str());
  std::flush(std::cout);

  // Put the message into a queue to be processed by the middleware.
  // This call is non-blocking.
  pub_->publish(std::move(msg));
}

}  // namespace composition

#include "rclcpp_components/register_node_macro.hpp"

// Register the component with class_loader.
// This acts as a sort of entry point, allowing the component to be discoverable when its library
// is being loaded into a running process.
RCLCPP_COMPONENTS_REGISTER_NODE(composition::Talker)
```





