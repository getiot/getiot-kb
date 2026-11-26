---
sidebar_position: 5
authors: [luhuadong]
---

# ROS2 消息格式 TimeReference



文件：sensor_msgs/msg/TimeReference.msg

## 消息定义

### 原始消息定义

```bash
# Measurement from an external time source not actively synchronized with the system clock.


#std_msgs/Header header # stamp is system time for which measurement was valid

# # frame_id is not used


#builtin_interfaces/Time time_ref # corresponding time from this external source

#string source # (optional) name of time source
```



### 紧凑消息定义

```cpp
std_msgs/msg/Header header
builtin_interfaces/msg/Time time_ref
string source
```



