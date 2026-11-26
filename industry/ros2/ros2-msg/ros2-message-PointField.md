---
sidebar_position: 8
authors: [luhuadong]
---

# ROS2 消息格式 PointField



文件：sensor_msgs/msg/PointField.msg

## 消息定义

### 原始消息定义

```bash
# This message holds the description of one point entry in the

# PointCloud2 message format.

uint8 INT8 = 1
uint8 UINT8 = 2
uint8 INT16 = 3
uint8 UINT16 = 4
uint8 INT32 = 5
uint8 UINT32 = 6
uint8 FLOAT32 = 7
uint8 FLOAT64 = 8

# Common PointField names are x, y, z, intensity, rgb, rgba

#string name # Name of field

#uint32 offset # Offset from start of point struct

#uint8 datatype # Datatype enumeration, see above

#uint32 count # How many elements in the field

```



### 紧凑消息定义

```cpp
uint8 INT8=1
uint8 UINT8=2
uint8 INT16=3
uint8 UINT16=4
uint8 INT32=5
uint8 UINT32=6
uint8 FLOAT32=7
uint8 FLOAT64=8
string name
uint32 offset
uint8 datatype
uint32 count
```



