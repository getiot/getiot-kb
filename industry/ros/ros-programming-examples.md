---
sidebar_position: 10
slug: /ros-programming-examples
authors: [luhuadong]
---

# ROS 编程实验



```bash
$ mkdir -p ~/catkin_ws/src
$ cd ~/catkin_ws/src
```



```bash
$ catkin_init_workspace 
Creating symlink "/home/rudy/catkin_ws/src/CMakeLists.txt" pointing to "/opt/ros/noetic/share/catkin/cmake/toplevel.cmake"
```



```bash
$ cd ..
$ catkin_make
-- Found PythonInterp: /usr/bin/python3 (found version "3.8.10") 
-- Found Threads: TRUE  
-- Using Python nosetests: /usr/bin/nosetests3
-- catkin 0.8.10
-- BUILD_SHARED_LIBS is on
-- BUILD_SHARED_LIBS is on
-- Configuring done
-- Generating done
-- Build files have been written to: /home/rudy/catkin_ws/build
####
#### Running command: "make -j8 -l8" in "/home/rudy/catkin_ws/build"
####
```



```bash
$ source ~/catkin_ws/devel/setup.bash
```





