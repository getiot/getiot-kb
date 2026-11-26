---
sidebar_position: 18
authors: [luhuadong]
---

# ROS2 消息格式 LaserEcho



文件：sensor_msgs/msg/LaserEcho.msg

## 消息定义

### 原始消息定义

```bash
# This message is a submessage of MultiEchoLaserScan and is not intended

# to be used separately.


#float32[] echoes # Multiple values of ranges or intensities.

# # Each array represents data from the same angle increment.
```



### 紧凑消息定义

```cpp
float[] echoes
```



