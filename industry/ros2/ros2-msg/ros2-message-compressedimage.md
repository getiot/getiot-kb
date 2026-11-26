---
sidebar_position: 3
authors: [luhuadong]
---

# ROS2 消息格式 CompressedImage



文件：sensor_msgs/msg/CompressedImage.msg

## 消息定义

### 原始消息定义

```bash
# This message contains a compressed image.


#std_msgs/Header header # Header timestamp should be acquisition time of image

# # Header frame_id should be optical frame of camera

# # origin of frame should be optical center of cameara

# # +x should point to the right in the image

# # +y should point down in the image

# # +z should point into to plane of the image


#string format # Specifies the format of the data

# # Acceptable values:

# # jpeg, png


#uint8[] data # Compressed image buffer
```



### 紧凑消息定义

```cpp
std_msgs/msg/Header header
string format
uint8[] data
```

