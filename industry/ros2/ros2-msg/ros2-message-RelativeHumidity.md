---
sidebar_position: 19
authors: [luhuadong]
---

# ROS2 消息格式 RelativeHumidity



文件：sensor_msgs/msg/RelativeHumidity.msg

## 消息定义

### 原始消息定义

```bash
# Single reading from a relative humidity sensor.

# Defines the ratio of partial pressure of water vapor to the saturated vapor

# pressure at a temperature.


#std_msgs/Header header # timestamp of the measurement

# # frame_id is the location of the humidity sensor


#float64 relative_humidity # Expression of the relative humidity

# # from 0.0 to 1.0.

# # 0.0 is no partial pressure of water vapor

# # 1.0 represents partial pressure of saturation


#float64 variance # 0 is interpreted as variance unknown
```



### 紧凑消息定义

```cpp
std_msgs/msg/Header header
double relative_humidity
double variance
```



