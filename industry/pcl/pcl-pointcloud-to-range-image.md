---
sidebar_position: 10
---

# PCL 点云转深度图



## 什么是深度图

深度图像（depth image）也被称为距离影像（range image），是指将从图像采集器（相机或雷达）到场景中各点的距离（深度）作为像素值的图像，它直接反映了景物可见表面的几何形状。深度图像经过坐标转换可以计算为点云数据，有规则及必要信息的点云数据也可以反算为深度图像数据。

深度数据流所提供的图像帧中，每一个像素点代表的是在深度感应器的视野中，该特定的（x, y）坐标处物体到离摄像头平面最近的物体到该平面的距离（以毫米为单位）。



```cpp
#include <pcl/range_image/range_image.h>    //深度图像的头文件

int main(int argc, char** argv)
{
	pcl::PointCloud<pcl::PointXYZ> pointCloud;   //定义点云的对象

	// 循环产生点云的数据
	for (float y = -0.5f; y <= 0.5f; y += 0.01f) {
		for (float z = -0.5f; z <= 0.5f; z += 0.01f) {
			pcl::PointXYZ point;
			point.x = 2.0f - y;
			point.y = y;
			point.z = z;
			pointCloud.points.push_back(point); //循环添加点数据到点云对象
		}
	}
	pointCloud.width = (uint32_t)pointCloud.points.size();
	pointCloud.height = 1;                                        //设置点云对象的头信息
	
    //实现一个呈矩形形状的点云
	// We now want to create a range image from the above point cloud, with a 1deg angular resolution
	//angular_resolution为模拟的深度传感器的角度分辨率，即深度图像中一个像素对应的角度大小
	float angularResolution = (float)(1.0f * (M_PI / 180.0f));  //   1.0 degree in radians
	//max_angle_width为模拟的深度传感器的水平最大采样角度，
	float maxAngleWidth = (float)(360.0f * (M_PI / 180.0f));  // 360.0 degree in radians
	//max_angle_height为模拟传感器的垂直方向最大采样角度  都转为弧度
	float maxAngleHeight = (float)(180.0f * (M_PI / 180.0f));  // 180.0 degree in radians
	//传感器的采集位置
	Eigen::Affine3f sensorPose = (Eigen::Affine3f)Eigen::Translation3f(0.0f, 0.0f, 0.0f);
	//深度图像遵循坐标系统
	pcl::RangeImage::CoordinateFrame coordinate_frame = pcl::RangeImage::CAMERA_FRAME;
	float noiseLevel = 0.0f;   //noise_level获取深度图像深度时，近邻点对查询点距离值的影响水平
	float minRange = 0.0f;     //min_range设置最小的获取距离，小于最小获取距离的位置为传感器的盲区
	int borderSize = 1;        //border_size获得深度图像的边缘的宽度

	pcl::RangeImage rangeImage;
	rangeImage.createFromPointCloud(pointCloud, 
                                    angularResolution, 
                                    maxAngleWidth, 
                                    maxAngleHeight,
                                    sensorPose, 
                                    coordinate_frame, 
                                    noiseLevel, 
                                    minRange, 
                                    borderSize);

	std::cout << rangeImage << "\n";
}
```



## API 说明

### createFromPointCloud [1/2]

Create the depth image from a point cloud。

```cpp
template<typename PointCloudType >
void pcl::RangeImage::createFromPointCloud(const PointCloudType & 	point_cloud,
                                           float angular_resolution = pcl::deg2rad(0.5f),
                                           float max_angle_width = pcl::deg2rad(360.0f),
                                           float max_angle_height = pcl::deg2rad(180.0f),
                                           const Eigen::Affine3f &sensor_pose = Eigen::Affine3f::Identity(),
                                           RangeImage::CoordinateFrame coordinate_frame = CAMERA_FRAME,
                                           float noise_level = 0.0f,
                                           float min_range = 0.0f,
                                           int border_size = 0);
```

共有 9 个参数，如下表所示：

| 参数               | 描述                                                         |
| ------------------ | ------------------------------------------------------------ |
| point_cloud        | the input point cloud                                        |
| angular_resolution | the angular difference (in radians) between the individual pixels in the image |
| max_angle_width    | an angle (in radians) defining the horizontal bounds of the sensor |
| max_angle_height   | an angle (in radians) defining the vertical bounds of the sensor |
| sensor_pose        | an affine matrix defining the pose of the sensor (defaults to Eigen::Affine3f::Identity () ) |
| coordinate_frame   | the coordinate frame (defaults to CAMERA_FRAME)              |
| noise_level        | - The distance in meters inside of which the z-buffer will not use the minimum, but the mean of the points. If 0.0 it is equivalent to a normal z-buffer and will always take the minimum per cell. |
| min_range          | the minimum visible range (defaults to 0)                    |
| border_size        | the border size (defaults to 0). Set to `std::numeric_limits<int>::min()` to turn cropping off. |



### createFromPointCloud [2/2]

Create the depth image from a point cloud.

```cpp
template<typename PointCloudType >
void pcl::RangeImage::createFromPointCloud(const PointCloudType &point_cloud,
                                           float angular_resolution_x = pcl::deg2rad(0.5f),
                                           float angular_resolution_y = pcl::deg2rad(0.5f),
                                           float max_angle_width = pcl::deg2rad(360.0f),
                                           float max_angle_height = pcl::deg2rad(180.0f),
                                           const Eigen::Affine3f &sensor_pose = Eigen::Affine3f::Identity(),
                                           RangeImage::CoordinateFrame coordinate_frame = CAMERA_FRAME,
                                           float noise_level = 0.0f,
                                           float min_range = 0.0f,
                                           int border_size = 0);
```

共有 10 个参数，如下表所示：

| 参数                 | 描述                                                         |
| -------------------- | ------------------------------------------------------------ |
| point_cloud          | the input point cloud                                        |
| angular_resolution_x | the angular difference (in radians) between the individual pixels in the image in the x-direction |
| angular_resolution_y | the angular difference (in radians) between the individual pixels in the image in the y-direction |
| max_angle_width      | an angle (in radians) defining the horizontal bounds of the sensor |
| max_angle_height     | an angle (in radians) defining the vertical bounds of the sensor |
| sensor_pose          | an affine matrix defining the pose of the sensor (defaults to Eigen::Affine3f::Identity () ) |
| coordinate_frame     | the coordinate frame (defaults to CAMERA_FRAME)              |
| noise_level          | - The distance in meters inside of which the z-buffer will not use the minimum, but the mean of the points. If 0.0 it is equivalent to a normal z-buffer and will always take the minimum per cell. |
| min_range            | the minimum visible range (defaults to 0)                    |
| border_size          | the border size (defaults to 0). Set to `std::numeric_limits<int>::min()` to turn cropping off. |



### createFromPointCloud 实现

```c
template <typename PointCloudType> void 
RangeImage::createFromPointCloud (const PointCloudType& point_cloud,
                                  float angular_resolution_x, float angular_resolution_y,
                                  float max_angle_width, float max_angle_height,
                                  const Eigen::Affine3f& sensor_pose, RangeImage::CoordinateFrame coordinate_frame,
                                  float noise_level, float min_range, int border_size)
{
  setAngularResolution (angular_resolution_x, angular_resolution_y);
  
  width  = static_cast<std::uint32_t> (pcl_lrint (std::floor (max_angle_width*angular_resolution_x_reciprocal_)));
  height = static_cast<std::uint32_t> (pcl_lrint (std::floor (max_angle_height*angular_resolution_y_reciprocal_)));
  
  int full_width  = static_cast<int> (pcl_lrint (std::floor (pcl::deg2rad (360.0f)*angular_resolution_x_reciprocal_))),
      full_height = static_cast<int> (pcl_lrint (std::floor (pcl::deg2rad (180.0f)*angular_resolution_y_reciprocal_)));
  image_offset_x_ = (full_width -static_cast<int> (width) )/2;
  image_offset_y_ = (full_height-static_cast<int> (height))/2;
  is_dense = false;
  
  getCoordinateFrameTransformation (coordinate_frame, to_world_system_);
  to_world_system_ = sensor_pose * to_world_system_;
  
  to_range_image_system_ = to_world_system_.inverse (Eigen::Isometry);
  //std::cout << "to_world_system_ is\n"<<to_world_system_<<"\nand to_range_image_system_ is\n"<<to_range_image_system_<<"\n\n";
  
  unsigned int size = width*height;
  points.clear ();
  points.resize (size, unobserved_point);
  
  int top=height, right=-1, bottom=-1, left=width;
  doZBuffer (point_cloud, noise_level, min_range, top, right, bottom, left);
  
  cropImage (border_size, top, right, bottom, left);
  
  recalculate3DPointPositions ();
}
```



## Debug

```c
createFromPointCloud
    doZBuffer
    	getImagePoint
    		EIGEN_STRONG_INLINE Matrix
```



