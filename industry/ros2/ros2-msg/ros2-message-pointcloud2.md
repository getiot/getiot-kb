---
sidebar_position: 4
authors: [luhuadong]
---

# ROS2 消息格式 PointCloud2



文件：sensor_msgs/msg/PointCloud2.msg

## 消息定义

### 原始消息定义

```bash
# This message holds a collection of N-dimensional points, which may

# contain additional information such as normals, intensity, etc. The

# point data is stored as a binary blob, its layout described by the

# contents of the "fields" array.

#

# The point cloud data may be organized 2d (image-like) or 1d (unordered).

# Point clouds organized as 2d images may be produced by camera depth sensors

# such as stereo or time-of-flight.


# Time of sensor data acquisition, and the coordinate frame ID (for 3d points).

std_msgs/Header header

# 2D structure of the point cloud. If the cloud is unordered, height is

# 1 and width is the length of the point cloud.

uint32 height
uint32 width

# Describes the channels and their layout in the binary data blob.

PointField[] fields

#bool is_bigendian # Is this data bigendian?

#uint32 point_step # Length of a point in bytes

#uint32 row_step # Length of a row in bytes

#uint8[] data # Actual point data, size is (row_step*height)


#bool is_dense # True if there are no invalid points
```



### 紧凑消息定义

```cpp
std_msgs/msg/Header header
uint32 height
uint32 width
sensor_msgs/msg/PointField[] fields
boolean is_bigendian
uint32 point_step
uint32 row_step
uint8[] data
boolean is_dense
```



在 ROS（机器人操作系统）中，PointCloud2 是一种常用的点云数据格式，用于表示三维点云数据，主要应用于激光雷达、机器人视觉等感知任务中。

点云（Point Cloud）就是由许多个点数据组成的数据集合，点云数据中包含每个三维坐标点的信息，如 XYZ、颜色、法向量等。

PointCloud2 的数据结构非常灵活，它可以用于表示不同类型的点云数据。其基本数据结构包含以下几个字段：

| 字段           | 描述                                                         |
| -------------- | ------------------------------------------------------------ |
| `header`       | 点云数据的头部信息，包括时间戳、坐标系等信息。               |
| `height`       | 点云数据的高度，如果点云数据是二维的，高度为 1；如果是三维的，高度为点云数据中的行数。 |
| `width`        | 点云数据的宽度，即点云数据中每行的点数。                     |
| `fields`       | 点云数据中每个点的字段信息，如坐标、颜色等。                 |
| `is_bigendian` | 表示数据的大小端模式。                                       |
| `point_step`   | 点云数据中每个点的字节数。                                   |
| `row_step`     | 点云数据中每行的字节数。                                     |
| `data`         | 点云数据的二进制数据。                                       |

通过这些字段，PointCloud2 可以表示不同类型的点云数据，并且支持在不同的 ROS2 节点之间传输和处理。例如，可以通过 PointCloud2 表示从激光雷达传感器获取的点云数据，或者通过它表示从 RGBD 相机获取的点云数据。



PointCloud2 数据格式由一个包含点云数据的头部信息和点云数据本身组成，具体格式如下：

```cpp
uint32    header_seq // Header序列号
time      header_stamp // Header时间戳
string    header_frame_id // Header参考坐标系

uint32    height // 点云高度，等于1时表示二维点云
uint32    width // 点云宽度，等于点云中点的数量

sensor_msgs/PointField[] fields // 包含点云数据的字段列表

bool      is_bigendian // 是否是大端字节序
uint32    point_step // 每个点的字节数
uint32    row_step // 每行点云数据的字节数

uint8[]   data // 点云数据

```

其中，头部信息包括序列号、时间戳和参考坐标系等，用于标识点云数据的来源和属性。height和width字段分别表示点云的高度和宽度，可以用来区分二维和三维点云。fields字段描述了每个点云数据的类型和名称，例如坐标、颜色、法向量等。is_bigendian字段表示数据的字节序，point_step字段表示每个点的字节数，row_step字段表示每行点云数据的字节数。最后，点云数据存储在data字段中，以二进制形式存储，每个点的数据按照fields中描述的顺序排列。

PointCloud2格式的优点在于其灵活性和扩展性，可以根据实际需求定义自己的点云数据格式，并且可以支持多种类型的数据，包括XYZ坐标、颜色、法向量、曲率等。此外，PointCloud2格式也提供了一些方便的API，例如可视化工具、点云过滤器和点云配准器等，使得点云数据的处理和应用更加方便和高效。



```bash
ros2 topic echo /lidar_points
```



```bash
header:
  stamp:
    sec: 1610391646
    nanosec: 783700466
  frame_id: aslidar
height: 16128
width: 8
fields:
- name: x
  offset: 0
  datatype: 7
  count: 1
- name: y
  offset: 4
  datatype: 7
  count: 1
- name: z
  offset: 8
  datatype: 7
  count: 1
- name: intensity
  offset: 12
  datatype: 7
  count: 1
is_bigendian: false
point_step: 16
row_step: 128
data:
- 54
- 136
- 198
- 64
- 202
- 86
```

