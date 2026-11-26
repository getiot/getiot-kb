---
sidebar_position: 12
authors: [luhuadong]
---

# ROS2 消息格式 JoyFeedback



文件：sensor_msgs/msg/JoyFeedback.msg

## 消息定义

### 原始消息定义

```bash
# Declare of the type of feedback

uint8 TYPE_LED = 0
uint8 TYPE_RUMBLE = 1
uint8 TYPE_BUZZER = 2

uint8 type

# This will hold an id number for each type of each feedback.

# Example, the first led would be id=0, the second would be id=1

uint8 id

# Intensity of the feedback, from 0.0 to 1.0, inclusive. If device is

# actually binary, driver should treat 0<=x<0.5 as off, 0.5<=x<=1 as on.

float32 intensity

```



### 紧凑消息定义

```cpp
uint8 TYPE_LED=0
uint8 TYPE_RUMBLE=1
uint8 TYPE_BUZZER=2
uint8 type
uint8 id
float intensity
```



