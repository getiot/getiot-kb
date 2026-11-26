---
sidebar_position: 7
authors: [luhuadong]
---

# ROS2 消息格式 Illuminance



文件：sensor_msgs/msg/Illuminance.msg

## 消息定义

### 原始消息定义

```bash
# Single photometric illuminance measurement. Light should be assumed to be

# measured along the sensor's x-axis (the area of detection is the y-z plane).

# The illuminance should have a 0 or positive value and be received with

# the sensor's +X axis pointing toward the light source.

#

# Photometric illuminance is the measure of the human eye's sensitivity of the

# intensity of light encountering or passing through a surface.

#

# All other Photometric and Radiometric measurements should not use this message.

# This message cannot represent:

# - Luminous intensity (candela/light source output)

# - Luminance (nits/light output per area)

# - Irradiance (watt/area), etc.


#std_msgs/Header header # timestamp is the time the illuminance was measured

# # frame_id is the location and direction of the reading


#float64 illuminance # Measurement of the Photometric Illuminance in Lux.


#float64 variance # 0 is interpreted as variance unknown
```



### 紧凑消息定义

```cpp
std_msgs/msg/Header header
double illuminance
double variance
```

