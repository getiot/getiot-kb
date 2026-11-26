---
sidebar_position: 15
authors: [luhuadong]
---

# ROS2 消息格式 Temperature



文件：sensor_msgs/msg/Temperature.msg

## 消息定义

### 原始消息定义

```bash
# Single temperature reading.


#std_msgs/Header header # timestamp is the time the temperature was measured

# # frame_id is the location of the temperature reading


#float64 temperature # Measurement of the Temperature in Degrees Celsius.


#float64 variance # 0 is interpreted as variance unknown.

```



### 紧凑消息定义

```cpp
std_msgs/msg/Header header
double temperature
double variance
```



