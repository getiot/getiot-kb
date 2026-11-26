---
sidebar_position: 21
authors: [luhuadong]
---

# ROS2 消息格式 FluidPressure



文件：sensor_msgs/msg/FluidPressure.msg

## 消息定义

### 原始消息定义

```bash
# Single pressure reading. This message is appropriate for measuring the

# pressure inside of a fluid (air, water, etc). This also includes

# atmospheric or barometric pressure.

#

# This message is not appropriate for force/pressure contact sensors.


#std_msgs/Header header # timestamp of the measurement

# # frame_id is the location of the pressure sensor


#float64 fluid_pressure # Absolute pressure reading in Pascals.


#float64 variance # 0 is interpreted as variance unknown
```



### 紧凑消息定义

```cpp
std_msgs/msg/Header header
double fluid_pressure
double variance
```

