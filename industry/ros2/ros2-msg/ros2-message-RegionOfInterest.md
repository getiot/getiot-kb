---
sidebar_position: 23
authors: [luhuadong]
---

# ROS2 消息格式 RegionOfInterest



文件：sensor_msgs/msg/RegionOfInterest.msg

## 消息定义

### 原始消息定义

```bash
# This message is used to specify a region of interest within an image.

#

# When used to specify the ROI setting of the camera when the image was

# taken, the height and width fields should either match the height and

# width fields for the associated image; or height = width = 0

# indicates that the full resolution image was captured.


#uint32 x_offset # Leftmost pixel of the ROI

# # (0 if the ROI includes the left edge of the image)

#uint32 y_offset # Topmost pixel of the ROI

# # (0 if the ROI includes the top edge of the image)

#uint32 height # Height of ROI

#uint32 width # Width of ROI


# True if a distinct rectified ROI should be calculated from the "raw"

# ROI in this message. Typically this should be False if the full image

# is captured (ROI not used), and True if a subwindow is captured (ROI

# used).

bool do_rectify
```



### 紧凑消息定义

```cpp
uint32 x_offset
uint32 y_offset
uint32 height
uint32 width
boolean do_rectify
```



