---
sidebar_position: 20
sidebar_label: LidarView 构建流程
authors: [luhuadong]
---

# LidarView 构建流程



## CMake 文件

- Application
  - CMakeLists.txt
  - branding.cmake
  - Ui/CMakeLists.txt
  - Ui/python/CMakeLists.txt
- LVCore
  - CMakeLists.txt
  - ApplicationComponents/CMakeLists.txt
  - DatasetIOPlugin
  - LidarPlugin
  - LidarSlamPlugin
  - Python
  - PythonQtPlugin
  - 
  - CMake



LVCore/CMake/SetupLidarviewProject.cmake

```cmake
# Paraview
#must be included after Python and Determine version
if(NOT ParaView_DIR)
  message(WARNING "ParaView_DIR not found")
  message(FATAL_ERROR "Building with external Paraview not yet implemented")
endif()

find_package(ParaView REQUIRED)
message(STATUS "Paraview-${ParaView_VERSION}")
# WIP should check if EQUAL ${paraview_version}, in the event of from-source builds
```



