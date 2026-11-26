---
sidebar_position: 2
authors: [luhuadong]
---

# ROS2 消息格式 Imu



文件：sensor_msgs/msg/Imu.msg

## 消息定义

### 原始消息定义

```bash
# This is a message to hold data from an IMU (Inertial Measurement Unit)
#
# Accelerations should be in m/s^2 (not in g's), and rotational velocity should be in rad/sec
#
# If the covariance of the measurement is known, it should be filled in (if all you know is the
# variance of each measurement, e.g. from the datasheet, just put those along the diagonal)
# A covariance matrix of all zeros will be interpreted as "covariance unknown", and to use the data a covariance will have to be assumed or gotten from some other source
#
# If you have no estimate for one of the data elements (e.g. your IMU doesn't produce an
# orientation estimate), please set element 0 of the associated covariance matrix to -1
# If you are interpreting this message, please check for a value of -1 in the first element of each
# covariance matrix, and disregard the associated estimate.

std_msgs/Header header

geometry_msgs/Quaternion orientation # 方向
#float64[9] orientation_covariance # Row major about x, y, z axes

geometry_msgs/Vector3 angular_velocity # 角速度
#float64[9] angular_velocity_covariance # Row major about x, y, z axes

geometry_msgs/Vector3 linear_acceleration # 加速度
#float64[9] linear_acceleration_covariance # Row major x, y z
```



### 紧凑消息定义

```cpp
std_msgs/msg/Header header
geometry_msgs/msg/Quaternion orientation       // 四元数
double[9] orientation_covariance               // 四元数协方差
geometry_msgs/msg/Vector3 angular_velocity     // 角速度
double[9] angular_velocity_covariance          // 角速度协方差
geometry_msgs/msg/Vector3 linear_acceleration  // 加速度
double[9] linear_acceleration_covariance       // 加速度协方差
```



```cpp
// topic /imu
sensor_msgs::msg::Imu imu_data;
imu_data.orientation.w;          // 四元数Q1
imu_data.orientation.x;          // 四元数Q2
imu_data.orientation.y;          // 四元数Q3
imu_data.orientation.z;          // 四元数Q4
imu_data.angular_velocity.x;     // 机体系X轴角速度
imu_data.angular_velocity.y;     // 机体系Y轴角速度
imu_data.angular_velocity.z;     // 机体系Z轴角速度
imu_data.linear_acceleration.x;  // 机体系X轴加速度(未分离重力加速度)
imu_data.linear_acceleration.y;  // 机体系Y轴加速度(未分离重力加速度)
imu_data.linear_acceleration.z;  // 机体系Z轴加速度(未分离重力加速度)

// topic /euler_angles
geometry_msgs::msg::Vector3 Euler_angles_2d;
Euler_angles_2d.x;    // 横滚角(unit: rad)
Euler_angles_2d.y;    // 俯仰角(unit: rad)
Euler_angles_2d.z;    // 偏航角(unit: rad)
```



