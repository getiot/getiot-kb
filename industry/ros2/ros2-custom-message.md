# ROS2 自定义消息类型



在ROS2中，PointCloud2消息是通过sensor_msgs包提供的，它是一种用于表示点云数据的消息类型。要在PointCloud2消息中增加一个自定义的字段（例如ID字段），你需要进行以下步骤：



1、**创建自定义消息：** 

首先，你需要创建一个自定义的消息类型，其中包含PointCloud2消息以及你要添加的额外字段，比如ID字段。这需要使用ROS2中的msg文件定义。

```
bashCopy code
ros2 msg create my_package/msg/CustomPointCloud.msg
```

在自定义消息文件中，你可以定义类似于以下内容的消息：

```
std_msgs/Header header
uint32 height
uint32 width
sensor_msgs/PointField[] fields
bool is_bigendian
uint32 point_step
uint32 row_step
uint8[] data
bool is_dense
uint32 msg_id
```



2、**修改PointCloud2发布者和订阅者：** 

在发布者端，你需要修改发布者以包含新的ID字段，然后在订阅者端进行相应的修改。

**发布者修改示例：**

```
cppCopy code// YourPointCloudPublisher.cpp
#include "my_package/msg/custom_point_cloud.hpp"

// ...

my_package::msg::CustomPointCloud pointCloudMsg;
// Populate the PointCloud2 fields as needed
pointCloudMsg.id = 123;  // Set your custom ID value

publisher.publish(pointCloudMsg);
```

**订阅者修改示例：**

```
cppCopy code// YourPointCloudSubscriber.cpp
#include "my_package/msg/custom_point_cloud.hpp"

// ...

void yourCallback(const my_package::msg::CustomPointCloud::SharedPtr msg)
{
    // Access your custom ID field
    uint32_t id = msg->id;
    // Process the rest of the PointCloud2 message
}
```



3、**编译和运行：** 

确保你的自定义消息被编译，然后运行你的ROS2节点。

```
bashCopy codecolcon build
source install/setup.bash
ros2 run your_package your_node
```

这样，你就可以在PointCloud2消息中添加一个自定义的ID字段，以表示该帧点云的序号。请注意，修改消息格式后，发布者和订阅者都需要相应的修改以支持新的消息格式。



