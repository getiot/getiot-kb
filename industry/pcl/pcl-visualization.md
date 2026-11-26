---
sidebar_position: 8
---

# PCL 点云可视化

科学计算可视化（Visualization in Scientific Computing）能够把科学数据（包括测量获得的数值、图像或者计算中设计、产生的数字信息）变为直观的、可以用以图形图像信息表示的、随时间和空间变化的物理现象或物理量。进而呈现在研究者面前，使他们可以方便的观察、模拟和计算。



## CloudViewer

使用示例：cloud_viewer.cpp

```cpp
#include <pcl/visualization/cloud_viewer.h>
#include <iostream>
#include <pcl/io/io.h>
#include <pcl/io/pcd_io.h>

int user_data;

void viewerOneOff(pcl::visualization::PCLVisualizer &viewer){
    //设置背景颜色
    viewer.setBackgroundColor(1.1,0.5,1.0);
    pcl::PointXYZ o;
    o.x = 1.0;
    o.z = 0;
    o.y = 0;
    //添加一个圆心为o，半径为0.25m的球体
    viewer.addSphere(o, 0.25, "sphere", 0.2);
    std::cout << "i only run once" << std::endl;
}

void viewerPsycho(pcl::visualization::PCLVisualizer &viewer){
    static unsigned count = 0;
    std::stringstream ss;
    ss << "Once per viewer loop: " << count++;
    //每次刷新时，移除text，添加新的text
    viewer.removeShape("text", 0);
    viewer.addText(ss.str(), 200, 300, "text", 0);
    
    user_data++;
}

int main(){
    pcl::PointCloud<pcl::PointXYZRGBA>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZRGBA>);
    pcl::io::loadPCDFile("C:\\0APractice\\PclLearning\\CloudViewer\\bunny.pcd", *cloud);
    pcl::visualization::CloudViewer viewer("Cloud Viewer");
    
    //这里会一直阻塞直到点云被渲染
    viewer.showCloud(cloud);
    
    //只会调用一次（非必须）
    viewer.runOnVisualizationThreadOnce(viewerOneOff);
    //每次可视化迭代都会调用一次
    viewer.runOnVisualizationThread(viewerPsycho);
    while(!viewer.wasStopped()){
        user_data++;
    }
    return 0;
}
```





## PCLVisualizer

使用示例：pcl_visualizer.cpp

```cpp
#include <pcl/io/io.h>
#include <pcl/io/pcd_io.h>
#include <pcl/io/ply_io.h>
#include <pcl/visualization/pcl_visualizer.h>

int main(int argc, char **argv){
    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZ>);
    pcl::io::loadPCDFile("C:\\0APractice\\PclLearning\\PCLVisualizer\\bunny.pcd", *cloud);
    
    pcl::PointCloud<pcl::PointXYZRGB>::Ptr cloud_desk(new pcl::PointCloud<pcl::PointXYZRGB>);
    pcl::io::loadPLYFile("C:\\0APractice\\PclLearning\\PCLVisualizer\\Desk1.ply", *cloud_desk);
    
    //创建PCLVisualizer
    boost::shared_ptr<pcl::visualization::PCLVisualizer> viewer(new pcl::visualization::PCLVisualizer ("3D Viewer"));
    
    //设置背景颜色为灰色（非必须）
    viewer->setBackgroundColor(0.05, 0.05, 0.05, 0);
    
    //添加一个普通点云（可以设置指定颜色，也可以去掉single_color参数不设置）
    pcl::visualization::PointCloudColorHandlerCustom<pcl::PointXYZ> single_color(cloud, 0, 255, 0);
    viewer->addPointCloud<pcl::PointXYZ> (cloud, single_color, "sample cloud" );
    viewer->setPointCloudRenderingProperties (pcl::visualization::PCL_VISUALIZER_POINT_SIZE, 2, "sample cloud");
    
    //再添加一个彩色点云及配置
    pcl::visualization::PointCloudColorHandlerRGBField<pcl::PointXYZRGB> rgb(cloud_desk);
    viewer->addPointCloud<pcl::PointXYZRGB> (cloud_desk, rgb, "sample cloud milk");
    viewer->setPointCloudRenderingProperties (pcl::visualization::PCL_VISUALIZER_POINT_SIZE, 3, "sample cloud milk");
    
    //添加一个0.5倍缩放的坐标系（非必须）
    viewer->addCoordinateSystem(0.5);
    
    //直到窗口关闭才结束循环
    while(!viewer->wasStopped()){
        //每次循环调用内部的重绘函数
        viewer->spinOnce();
    }
    return 0;
}
```



## 操作方法

**基本使用**

- 进入：pcl_viewer xxxxx.pcd
- 帮助：在界面中输入h，可以在控制台看到帮助信息
- 退出：界面中输入q
- 放大缩小：鼠标滚轮 或 Alt + [+/-]
- 平移：Shift+鼠标拖拽
- 旋转：Ctrl+鼠标拖拽

**其他技巧**

- 修改点颜色：数字1,2,3,4,5…9，重复按1可切换不同颜色方便观察
- 放大缩小点：放大Ctrl+Shift+加号，缩小> Ctrl+减号
- 保存截图：j
- 显示颜色尺寸：u
- 显示比例尺寸：g
- 在控制列出所有几何和颜色信息：l

**鼠标选点打印坐标**

- 选点模式进入：pcl_viewer -use_point_picking bunny.pcd
- 选择指定点：shift+鼠标左键



## 点云同窗口多幅显示

```cpp
#include <pcl/point_types.h>
#include <pcl/io/ply_io.h>
#include <pcl/io/pcd_io.h>
#include <pcl/visualization/pcl_visualizer.h>

int user_data;
typedef pcl::PointXYZ PointType;

int main(int argc, char **argv){
	
	//Create point cloud class and load the cloud
	pcl::PointCloud<PointType>::Ptr cloud1(new pcl::PointCloud<PointType>);
	pcl::PointCloud<PointType>::Ptr cloud2(new pcl::PointCloud<PointType>);
	pcl::PointCloud<PointType>::Ptr cloud3(new pcl::PointCloud<PointType>);

	/*pcl::io::loadPLYFile<PointType>("C:\\0APractice\\PclLearning\\PCLMultiWindow\\20230712-05.ply", *cloud1);
	pcl::io::loadPLYFile<PointType>("C:\\0APractice\\PclLearning\\PCLMultiWindow\\Desk1.ply", *cloud1);*/
	pcl::io::loadPCDFile<PointType>("C:\\0APractice\\PclLearning\\PCLMultiWindow\\bunny.pcd", *cloud2);
	pcl::io::loadPCDFile<PointType>("C:\\0APractice\\PclLearning\\PCLMultiWindow\\bunny.pcd", *cloud1);
	pcl::io::loadPCDFile<PointType>("C:\\0APractice\\PclLearning\\PCLMultiWindow\\bunny.pcd", *cloud3);
	
		
	boost::shared_ptr<pcl::visualization::PCLVisualizer> viewer(new pcl::visualization::PCLVisualizer("3D viewer"));
	pcl::visualization::PointCloudColorHandlerCustom <PointType> cloud1_color(cloud1, 0, 255, 0);
	pcl::visualization::PointCloudColorHandlerCustom <PointType> cloud2_color(cloud2, 255, 0, 0);
	pcl::visualization::PointCloudColorHandlerCustom <PointType> cloud3_color(cloud3, 0, 0, 255);

	viewer->initCameraParameters();
	int V1(0);
	viewer->createViewPort(0.0, 0.0, 0.3, 1.0, V1);
	int V2(0);
	viewer->createViewPort(0.3, 0.0, 0.7, 1.0, V2);
	int V3(0);
	viewer->createViewPort(0.7, 0.0, 1.0, 1.0, V3);
	viewer->setBackgroundColor(255, 0, 0, V1);
	viewer->setBackgroundColor(0, 0, 255, V2);
	viewer->setBackgroundColor(0, 255, 0, V3);

	viewer->addCoordinateSystem(0.5);

	viewer->addPointCloud<PointType>(cloud1, cloud1_color, "cloud1", V1);
	viewer->addPointCloud<PointType>(cloud2, cloud2_color, "cloud2", V2);
	viewer->addPointCloud<PointType>(cloud3, cloud3_color, "cloud3", V3);
	viewer->spin();
	
	while (!viewer->wasStopped()) {
		user_data++;
	}

	return 0;
}
```

注意：在设置每个窗口的左上角和右下角时要注意，x、y坐标的最大值不能超过1，否则该窗口无法显示出来！



