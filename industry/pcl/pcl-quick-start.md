---
sidebar_position: 3
sidebar_label: PCL 快速上手
---

# PCL（点云库）快速上手

安装好 PCL 库后，下面我们动手编写一个 3D 点云可视化程序，带你快速上手 PCL 库的使用。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/pcl-courses/tree/main/hello-world) 下载。

:::



## 示例代码

下面是一个简单的 PCL 库示例程序，该程序将随机生成 1000 个点云数据，并将其通过 3D 视图可视化。

```cpp showLineNumbers title="main.cpp"
#include <iostream>
#include <pcl/point_types.h>
#include <pcl/visualization/pcl_visualizer.h>
#include <pcl/common/common.h>
#include <pcl/common/time.h>

int main()
{
    // 创建点云对象
    pcl::PointCloud<pcl::PointXYZI>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZI>);

    // 随机生成点云数据
    srand(time(NULL));
    for (int i = 0; i < 1000; ++i)
    {
        pcl::PointXYZI point;
        point.x = 10.0f * rand() / RAND_MAX;  // 在 x 方向上随机生成坐标
        point.y = 10.0f * rand() / RAND_MAX;  // 在 y 方向上随机生成坐标
        point.z = 10.0f * rand() / RAND_MAX;  // 在 z 方向上随机生成坐标
        point.intensity = rand() % 256;       // 生成随机强度值
        cloud->push_back(point);
    }

    // 创建可视化窗口对象
    pcl::visualization::PCLVisualizer::Ptr viewer(new pcl::visualization::PCLVisualizer("Point Cloud Viewer"));

    // 设置点云颜色为 intensity 值
    pcl::visualization::PointCloudColorHandlerGenericField<pcl::PointXYZI> fildColor(cloud, "intensity");
    
    // 将点云添加到可视化窗口中
    viewer->addPointCloud<pcl::PointXYZI>(cloud, fildColor, "cloud");

    // 设置点云大小
    viewer->setPointCloudRenderingProperties(pcl::visualization::PCL_VISUALIZER_POINT_SIZE, 2, "cloud");

    // 显示可视化窗口，直到用户关闭窗口为止
    while (!viewer->wasStopped())
    {
        viewer->spinOnce(1000);  // 每隔100毫秒渲染一次
    }

    return 0;
}
```



## CMakeLists.txt

我们编写一个 CMakeLists.txt 文件用于编译该程序。

```cmake showLineNumbers title="CMakeLists.txt"
cmake_minimum_required(VERSION 3.0)
project(pcl_hello LANGUAGES CXX)

# 设置 PCL 库的路径
find_package(PCL 1.7 REQUIRED COMPONENTS common io visualization)
include_directories(${PCL_INCLUDE_DIRS})
link_directories(${PCL_LIBRARY_DIRS})
add_definitions(${PCL_DEFINITIONS})

# 添加可执行文件
add_executable(${PROJECT_NAME} main.cpp)

# 链接 PCL 库
target_link_libraries(${PROJECT_NAME} ${PCL_COMMON_LIBRARIES} ${PCL_IO_LIBRARIES} ${PCL_VISUALIZATION_LIBRARIES} ${VTK_LIBRARIES})
```

CMake 的重点是先找到 PCL 库，再设置必要的链接库，包括 common、io 和 visualization。



## 编译运行

创建并切换到 `build` 构建目录，然后生成配置，编译即可。命令如下：

```bash
mkdir build
cd build
cmake ..
make
```

在 `build` 目录将生成一个 `pcl_hello` 可执行程序，运行它：

```bash
./pcl_hello
```

你将看到 3D 窗口中显示着点云，如下图：

![](https://static.getiot.tech/pcl-helloworld-view.png#center)
