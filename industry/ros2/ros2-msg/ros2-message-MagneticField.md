---
sidebar_position: 9
authors: [luhuadong]
---

# ROS2 消息格式 MagneticField



文件：sensor_msgs/msg/MagneticField.msg

## 消息定义

### 原始消息定义

```bash
# Measurement of the Magnetic Field vector at a specific location.

#

# If the covariance of the measurement is known, it should be filled in.

# If all you know is the variance of each measurement, e.g. from the datasheet,

# just put those along the diagonal.

# A covariance matrix of all zeros will be interpreted as "covariance unknown",

# and to use the data a covariance will have to be assumed or gotten from some

# other source.


#std_msgs/Header header # timestamp is the time the

# # field was measured

# # frame_id is the location and orientation

# # of the field measurement


#geometry_msgs/Vector3 magnetic_field # x, y, and z components of the

# # field vector in Tesla

# # If your sensor does not output 3 axes,

# # put NaNs in the components not reported.


#float64[9] magnetic_field_covariance # Row major about x, y, z axes

# # 0 is interpreted as variance unknown
```



### 紧凑消息定义

```cpp
std_msgs/msg/Header header
geometry_msgs/msg/Vector3 magnetic_field
double[9] magnetic_field_covariance
```



