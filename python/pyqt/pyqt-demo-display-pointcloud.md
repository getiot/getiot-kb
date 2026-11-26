---
sidebar_position: 5
---

# PyQt 示例：显示点云



本示例演示如何使用 PyQt 创建一个可视化窗口，并在该窗口中显示点云（Point Cloud）数据。本示例基于 VTK 库编程，学习完本文，你将对基于 Python 的 VTK 库使用有一个大致的认识。项目代码存放与 GitHub 仓库 [getiot/pyqt-courses](https://github.com/getiot/pyqt-courses)，欢迎 Star！



## 示例代码

app.py 文件

```python
# -*- coding: utf-8 -*-

from PyQt5 import QtCore
from PyQt5.QtWidgets import QWidget, QVBoxLayout
import vtk
from vtk.qt.QVTKRenderWindowInteractor import QVTKRenderWindowInteractor
from numpy import random


class VtkPointCloud:
    def __init__(self, zMin=-10.0, zMax=10.0, maxNumPoints=1e6):
        self.maxNumPoints = maxNumPoints
        self.vtkPolyData = vtk.vtkPolyData()
        self.clearPoints()
        mapper = vtk.vtkPolyDataMapper()
        mapper.SetInputData(self.vtkPolyData)
        mapper.SetColorModeToDefault()
        mapper.SetScalarRange(zMin, zMax)
        mapper.SetScalarVisibility(1)
        self.vtkActor = vtk.vtkActor()
        self.vtkActor.SetMapper(mapper)
        self.vtkActor.GetProperty().SetPointSize(5)

    def addPoint(self, point):
        if self.vtkPoints.GetNumberOfPoints() < self.maxNumPoints:
            pointId = self.vtkPoints.InsertNextPoint(point[:])
            self.vtkDepth.InsertNextValue(point[2])
            self.vtkCells.InsertNextCell(1)
            self.vtkCells.InsertCellPoint(pointId)
        else:
            r = random.randint(0, self.maxNumPoints)
            self.vtkPoints.SetPoint(r, point[:])
        self.vtkCells.Modified()
        self.vtkPoints.Modified()
        self.vtkDepth.Modified()

    def clearPoints(self):
        self.vtkPoints = vtk.vtkPoints()
        self.vtkCells = vtk.vtkCellArray()
        self.vtkDepth = vtk.vtkDoubleArray()
        self.vtkDepth.SetName('DepthArray')
        self.vtkPolyData.SetPoints(self.vtkPoints)
        self.vtkPolyData.SetVerts(self.vtkCells)
        self.vtkPolyData.GetPointData().SetScalars(self.vtkDepth)
        self.vtkPolyData.GetPointData().SetActiveScalars('DepthArray')


class VtkPointCloudCanvas(QWidget):
    def __init__(self, *args, **kwargs):
        super(VtkPointCloudCanvas, self).__init__(*args, **kwargs)

        self._layout = QVBoxLayout()
        self.setLayout(self._layout)
        self._vtk_widget = QVTKRenderWindowInteractor(self)
        self._layout.addWidget(self._vtk_widget)

        self._render = vtk.vtkRenderer()
        self._vtk_widget.GetRenderWindow().AddRenderer(self._render)
        self._iren = self._vtk_widget.GetRenderWindow().GetInteractor()

        self._point_cloud = VtkPointCloud()

        self._render.AddActor(self._point_cloud.vtkActor)

        self.show()
        self._iren.Initialize()

    def updatePointCloud(self):
        self._point_cloud.clearPoints()
        for k in range(1000):
            point = 20 * (random.rand(3) - 0.5)
            self._point_cloud.addPoint(point)
        self._vtk_widget.GetRenderWindow().Render()


if __name__ == '__main__':
    from PyQt5.QtWidgets import QApplication
    import sys
    app = QApplication(sys.argv)
    window = VtkPointCloudCanvas()

    timer = QtCore.QTimer()
    timer.timeout.connect(window.updatePointCloud)
    timer.start(1000)

    sys.exit(app.exec_())
```



## 运行效果

激活 PyQt5 虚拟环境

```bash
$ source ~/.venv/PyQt5/bin/activate
```

安装依赖库

```bash
$ pip install vtk

# 国内的小伙伴使用国内源会更快
$ pip install vtk -i https://pypi.tuna.tsinghua.edu.cn/simple
```

提示：否则会出现 `ModuleNotFoundError: No module named 'vtk'` 错误


运行应用程序

```bash
$ cd PyQt5/DisplayPointCloud
$ python app.py
```

运行效果如下图所示

![](https://static.getiot.tech/PyQt5-DisplayPointCloud-Simple.png#center)


