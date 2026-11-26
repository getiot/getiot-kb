---
sidebar_position: 4
---

# OpenCV 组成结构

OpenCV 计算机视觉库的主要包括以下几大模块。

## 核心模块

核心模块（Core Module）是 OpenCV 的基础，提供了图像处理、数据结构、矩阵运算等基本功能。其中的核心数据结构包括：

- **Mat 类**：用于表示图像和矩阵数据，是OpenCV中最基本的数据结构。
- **Point、Rect、Size 类**：用于表示点、矩形和尺寸等基本几何结构。

## 图像处理模块

图像处理模块（Image Processing Module）包含了丰富的图像处理功能，涵盖了图像滤波、边缘检测、颜色空间转换等各种操作。一些常见的函数包括：

- **cv::filter2D()**：卷积运算，用于图像滤波。
- **cv::Canny()**：边缘检测算法。
- **cv::cvtColor()**：颜色空间转换。

## 计算机视觉模块

计算机视觉模块（Computer Vision Module）提供了更高级的图像处理和计算机视觉算法，包括特征检测、目标检测、物体跟踪等。一些典型的函数有：

- **cv::HoughCircles()**：用于检测圆。
- **cv::findContours()**：用于查找图像中的轮廓。
- **cv::matchTemplate()**：模板匹配。

## 机器学习模块

OpenCV 的机器学习模块（Machine Learning Module）提供了一些常用的机器学习算法，包括支持向量机、决策树等。一些重要的类和函数有：

- **cv::ml::SVM**：支持向量机。
- **cv::ml::DTrees**：决策树。

## 高级计算模块

高级计算模块（High Level GUI and Media I/O Module）包括了图形用户界面和媒体输入输出功能。其中包括图像的读写、视频捕获与处理等。

- **cv::imshow() 和 cv::imwrite()**：用于图像的显示和保存。
- **cv::VideoCapture 和 cv::VideoWriter**：用于视频的读取和写入。

## 辅助工具

OpenCV 提供了一些辅助工具（Utility Tools），包括数学和统计功能、文件和文件夹操作、内存管理等。

- **cv::FileStorage**：用于文件读写操作，支持XML和YAML格式。
- **cv::getTickCount() 和 cv::getTickFrequency()**：用于性能测量。

## Python 接口

OpenCV 提供了丰富的 Python 接口，使得开发者能够方便地使用 OpenCV 库进行图像处理和计算机视觉应用的开发。

这些模块和工具共同构成了 OpenCV 的软件框架，为图像处理和计算机视觉领域的开发者提供了强大而灵活的工具。通过这些组成结构，开发者可以高效地进行各种图像处理任务和计算机视觉应用的开发。
