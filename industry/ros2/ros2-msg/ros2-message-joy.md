---
sidebar_position: 16
authors: [luhuadong]
---

# ROS2 消息格式 Joy



文件：sensor_msgs/msg/Joy.msg

## 消息定义

### 原始消息定义

```bash
# Reports the state of a joystick's axes and buttons.


# The timestamp is the time at which data is received from the joystick.

std_msgs/Header header

# The axes measurements from a joystick.

float32[] axes

# The buttons measurements from a joystick.

int32[] buttons
```



### 紧凑消息定义

```cpp
std_msgs/msg/Header header
float[] axes
int32[] buttons
```

