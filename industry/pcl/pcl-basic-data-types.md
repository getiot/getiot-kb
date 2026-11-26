---
sidebar_position: 6
---

# PCL 基本数据类型



## pcl::PointCloud

PCL 的基本数据类型是 `PointCloud`，它是一个 C++ 的模板类，它包含了以下字段：

- `width(int)`：指定点云数据集的宽度。 对于无组织格式的数据集，width代表了所有点的总数； 对于有组织格式的数据集，width代表了一行中的总点数。
- `height(int)`：制定点云数据集的高度。对于无组织格式的数据集，值为1；对于有组织格式的数据集，表示总行数。
- `is_dense` 于指示点云是否密集（dense）；是否是有限的。 当 is_dense = false 时，表示点云是非密集的；点云中可能存在一些缺失或无效的点，例如由于传感器噪声、遮挡或其他原因导致的点云数据不完整，某些点的位置信息可能会丢失或不准确。当 is_dense = true 时，表示点云是密集的；点云中的每个点都有有效和准确的位置信息。
- `points(std::vector)`：包含所是有 PointT 类型的点的数据列表。

不完整定义：

```cpp
template <typename PointT>
class PCL_EXPORTS PointCloud
{
  public:
    pcl::PCLHeader header;
    std::vector<PointT, Eigen::aligned_allocator<PointT> > points;
    std::uint32_t width = 0;
    std::uint32_t height = 0;
    bool is_dense = true;
    Eigen::Vector4f    sensor_origin_ = Eigen::Vector4f::Zero ();
    Eigen::Quaternionf sensor_orientation_ = Eigen::Quaternionf::Identity ();
}
```



## PointT

```cpp
PointXYZ - float x, y, z
PointXYZI - float x, y, z, intensity
PointXYZRGB - float x, y, z, rgb
PointXYZRGBA - float x, y, z, uint32_t rgba
Normal - float normal[3], curvature 法线方向，对应的曲率的测量值
PointNormal - float x, y, z, normal[3], curvature 采样点，法线和曲率
Histogram - float histogram[N] 用于存储一般用途的n维直方图
```





