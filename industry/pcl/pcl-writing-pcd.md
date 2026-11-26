---
sidebar_position: 9
sidebar_label: PCL 输出 PCD 文件
---

# PCL 将点云保存为 PCD 文件

![PCL 输出 PCD 文件](https://static.getiot.tech/PCL_PCD_Banner.webp#center)

PCD 全称 Point Cloud Data，是一种存储三维点云数据的文件格式，本教程将介绍如何使用 PCL 点云库将点云数据写入 PCD 文件。由于 PCD 是一种开放数据格式，因此你可以使用各种点云处理工具来读取和写入 PCD 文件，并进一步对点云数据进行处理。

:::tip

本教程的示例代码和点云数据可在 [GitHub](https://github.com/getiot/pcl-courses/tree/main/PCD) 下载。

:::



## PCD 格式

PCD 格式是由 PCL 点云库使用的文件格式，用于存储三维点云数据。PCD 文件格式有两种主要的存储方式：ASCII（文本）格式和二进制格式。其中，ASCII 格式易于阅读和编辑，但文件较大；而二进制格式通常更紧凑，适用于大型点云数据。

PCD 文件由一个头部（header）和数据体（data body）组成。头部包含元数据和格式信息，数据体包含实际的点云数据。

### 头部信息

头部（Header）信息一般包括以下字段：

| 序号 | 字段名称        | 字段描述                                                  |
| ---- | --------------- | --------------------------------------------------------- |
| 1    | **`VERSION`**   | 文件格式的版本信息。                                      |
| 2    | **`FIELDS`**    | 点云数据的字段名称，例如 x, y, z, intensity。             |
| 3    | **`SIZE`**      | 每个字段的大小（以字节为单位）。                          |
| 4    | **`TYPE`**      | 每个字段的数据类型，例如 F（浮点型）、U（无符号整型）。   |
| 5    | **`COUNT`**     | 每个字段的元素个数，通常是 1。                            |
| 6    | **`WIDTH`**     | 点云数据的宽度，如果是 1 则表示无序点云。                 |
| 7    | **`HEIGHT`**    | 点云数据的高度，如果是 1 则表示无序点云。                 |
| 8    | **`VIEWPOINT`** | 相机视点信息（通常用于三维重建）。                        |
| 9    | **`POINTS`**    | 点云中的点的总数。                                        |
| 10   | **`DATA`**      | 数据存储的格式，可能是 ascii、binary、binary_compressed。 |

下面是一个典型的 PCD 文件头部示例：

```bash
# .PCD v0.7 - Point Cloud Data file format
VERSION 0.7
FIELDS x y z intensity
SIZE 4 4 4 4
TYPE F F F F
COUNT 1 1 1 1
WIDTH 1000
HEIGHT 1
VIEWPOINT 0 0 0 1 0 0 0
POINTS 1000
DATA ascii
```

### 数据体

数据体（Data Body）包含实际的点云数据，根据头部的描述以 ASCII 或二进制格式存储。

在 ASCII 格式下，点云数据以文本形式存储，每个点的数据在一行中按字段顺序排列，字段之间以空格分隔。例如，下面数据中的每一行对应一个三维点坐标（XYZ）和强度（Intensity）信息。

```bash
4.1249428 7.1494288 5.167275 6.0977383
3.532496 2.1198421 8.2864342 0.50844169
0.10034604 9.304101 9.876545 68.85511
6.0308199 1.1348503 9.8444204 63.933022
...
```

而在二进制格式下，数据按字段顺序紧凑地存储在文件中，没有任何分隔符，所有数据以二进制形式直接写入文件。这种格式更节省存储空间和读取时间。



## 示例程序

PCL 的 io 模块提供了读取和写入 PCD 文件的功能，下面我们通过三个简单的示例，演示如何将点云数据输出为 ASCII 格式和二进制格式的 PCD 文件，以及如何读取 PCD 文件并将其可视化出来。

### 以 ASCII 格式输出 PCD 文件

下面示例程序演示如何使用 PCL 库将随机生成的一组点云数据保存为一个文本格式的 PCD 文件。

```cpp showLineNumbers title="save_pcd_ascii.cpp"
#include <pcl/point_types.h>
#include <pcl/io/pcd_io.h>
#include <iostream>

int main()
{
    // 创建点云对象
    pcl::PointCloud<pcl::PointXYZI>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZI>);

    // 随机生成点云数据
    srand(static_cast<unsigned int>(time(NULL)));
    for (int i = 0; i < 1000; ++i)
    {
        pcl::PointXYZI point;
        point.x = 10.0f * rand() / RAND_MAX;  // 在 x 方向上随机生成坐标
        point.y = 10.0f * rand() / RAND_MAX;  // 在 y 方向上随机生成坐标
        point.z = 10.0f * rand() / RAND_MAX;  // 在 z 方向上随机生成坐标
        point.intensity = 255.0f * rand() / RAND_MAX;  // 生成随机强度值
        cloud->push_back(point);
    }

    // 保存点云数据到 PCD 文件
    pcl::io::savePCDFileASCII("output_ascii.pcd", *cloud);

    std::cout << "Saved " << cloud->points.size() << " data points to output_ascii.pcd in ASCII format." << std::endl;

    return 0;
}
```

这个程序将生成一个包含 1000 个随机点的点云数据，并将其保存为名为 `output_ascii.pcd` 的 PCD 文件。

代码重点：

- 使用 `pcl::PointCloud<pcl::PointXYZI>::Ptr` 创建一个指向点云对象的智能指针。
- 使用 `rand()` 函数生成随机点，并填充到点云对象中。
- 使用 `pcl::io::savePCDFileASCII` 函数将点云数据保存到 PCD 文件中。



### 以二进制格式输出 PCD 文件

下面示例程序演示如何使用 PCL 库将随机生成的一组点云数据保存为一个二进制格式的 PCD 文件。

```cpp showLineNumbers title="save_pcd_binary.cpp"
#include <pcl/point_types.h>
#include <pcl/io/pcd_io.h>
#include <iostream>

int main()
{
    // 创建点云对象
    pcl::PointCloud<pcl::PointXYZI>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZI>);

    // 随机生成点云数据
    srand(static_cast<unsigned int>(time(NULL)));
    for (int i = 0; i < 1000; ++i)
    {
        pcl::PointXYZI point;
        point.x = 10.0f * rand() / RAND_MAX;  // 在 x 方向上随机生成坐标
        point.y = 10.0f * rand() / RAND_MAX;  // 在 y 方向上随机生成坐标
        point.z = 10.0f * rand() / RAND_MAX;  // 在 z 方向上随机生成坐标
        point.intensity = 255.0f * rand() / RAND_MAX;  // 生成随机强度值
        cloud->push_back(point);
    }

    // 保存点云数据到二进制 PCD 文件
    pcl::io::savePCDFileBinary("output_binary.pcd", *cloud);

    std::cout << "Saved " << cloud->points.size() << " data points to output_binary.pcd in binary format." << std::endl;

    return 0;
}
```

这个程序将生成一个包含 1000 个随机点的点云数据，并将其保存为名为 `output_binary.pcd` 的 PCD 文件。

代码和前面的示例类似，不同的是这里使用 `pcl::io::savePCDFileBinary` 函数将点云数据保存到 PCD 文件中。



### 读取 PCD 文件并可视化

下面示例程序从命令行参数读取一个 PCD 文件（可以是 ASCII 格式或二进制格式），并使用 PCL 的可视化工具将其显示出来。

```cpp showLineNumbers title="pcd_viewer.cpp"
#include <iostream>
#include <pcl/io/pcd_io.h>
#include <pcl/point_types.h>
#include <pcl/visualization/pcl_visualizer.h>

int main(int argc, char** argv)
{
    // 检查命令行参数
    if (argc != 2)
    {
        std::cerr << "Usage: " << argv[0] << " <path-to-pcd-file>" << std::endl;
        return -1;
    }

    // 创建点云对象
    pcl::PointCloud<pcl::PointXYZI>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZI>);

    // 从文件中读取点云数据
    if (pcl::io::loadPCDFile<pcl::PointXYZI>(argv[1], *cloud) == -1)
    {
        PCL_ERROR("Couldn't read file %s \n", argv[1]);
        return -1;
    }

    std::cout << "Loaded " << cloud->width * cloud->height << " data points from " << argv[1] << std::endl;

    // 创建可视化窗口对象
    pcl::visualization::PCLVisualizer::Ptr viewer(new pcl::visualization::PCLVisualizer("PCD Viewer"));

    // 创建颜色处理对象
    pcl::visualization::PointCloudColorHandlerGenericField<pcl::PointXYZI> fildColor(cloud, "intensity");

    // 将点云添加到可视化窗口中
    viewer->addPointCloud<pcl::PointXYZI>(cloud, fildColor, "sample cloud");

    // 设置点云大小
    viewer->setPointCloudRenderingProperties(pcl::visualization::PCL_VISUALIZER_POINT_SIZE, 2, "sample cloud");

    // 显示可视化窗口，直到用户关闭窗口为止
    while (!viewer->wasStopped())
    {
        viewer->spinOnce(100);  // 每隔100毫秒渲染一次
    }

    return 0;
}
```



### 编译运行

为了编译这三个示例程序，你可以使用以下 `CMakeLists.txt` 文件：

```cmake showLineNumbers title="CMakeLists.txt"
cmake_minimum_required(VERSION 3.0)
project(pcd_example)

find_package(PCL REQUIRED)
find_package(VTK REQUIRED)

include_directories(${PCL_INCLUDE_DIRS})

add_executable(save_pcd_ascii save_pcd_ascii.cpp)
add_executable(save_pcd_binary save_pcd_binary.cpp)
add_executable(pcd_viewer pcd_viewer.cpp)

target_link_libraries(save_pcd_ascii ${PCL_LIBRARIES})
target_link_libraries(save_pcd_binary ${PCL_LIBRARIES})
target_link_libraries(pcd_viewer ${PCL_LIBRARIES} ${VTK_LIBRARIES})
```

依次执行以下命令编译程序：

```bash
mkdir build
cd build
cmake ..
make
```

在 build 目录下可以看到生成了三个可执行文件：`save_pcd_ascii`、`save_pcd_binary` 和 `pcd_viewer`。

- 执行 `./save_pcd_ascii`，将生成一个 `output_ascii.pcd` 文件；
- 执行 `./save_pcd_binary`，将生成一个 `output_binary.pcd` 文件。

对比两个文件的大小，可以发现：同样存储 1000 个点的数据，二进制格式比 ASCII 格式小得多。

```bash
$ ls -lh output_*
-rw-rw-r-- 1 rudy rudy 40K 5月  27 18:11 output_ascii.pcd
-rw-r--r-- 1 rudy rudy 16K 5月  27 16:31 output_binary.pcd
```

现在，可以执行 `pcd_viewer` 程序将点云显示出来：

```bash
$ ./pcd_viewer output_ascii.pcd
# 或者
$ ./pcd_viewer output_binary.pcd
```

可以看到类似如下窗口：

![](https://static.getiot.tech/pcl-writing-pcd-viewer.png#center)

## 其他 PCD 文件查看方式

除了像前面这样自己写一个 PCD Viewer 程序来显示 PCD 文件，还可以通过 pcl-tools 软件包中的 `pcl_viewer` 工具查看 PCD 文件，安装和使用方法如下。

```bash
$ sudo apt install pcl-tools
$ pcl_viewer output.pcd
```

另外，你可以在 VS Code 上安装 `pcd-viewer` 插件来查看 PCD 文件。安装完成后，直接打开 PCD 文件即可看到 3D 点云，插件提供了视角切换、颜色渲染、点云大小设置等基本功能，还是挺方便的！

![VSCode pcd-viewer 插件可视化 PCD 点云文件](https://static.getiot.tech/vscode-pcd-viewer-screenshot.png#center)

