---
sidebar_position: 3
---

# 第一个 OpenCV 程序



## 示例代码

helloworld.cpp（[GitHub](https://github.com/getiot/opencv-courses/tree/main/demo_01)）

```cpp
#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/core/types_c.h>

using namespace cv;

int main(int argc, char** argv) {
    
    //create a gui window:
    namedWindow("GetIoT",1);
    
    //initialize a 120X350 matrix of black pixels:
    Mat output = Mat::zeros( 120, 350, CV_8UC3 );
    
    //write text on the matrix:
    putText(output,
            "Hello World :)",
            cvPoint(15,70),
            FONT_HERSHEY_PLAIN,
            3,
            cvScalar(0,255,0),
            4);
    
    //display the image:
    imshow("GetIoT", output);
    
    //wait for the user to press any key:
    waitKey(0);
    
    return 0;
}
```



## 运行效果

编译

```bash
g++ -I /usr/include/opencv4 helloworld.cpp -o hello_opencv -lopencv_core -lopencv_highgui -lopencv_imgproc
```

运行

```bash
./hello_opencv
```

将显示如下窗口：

![第一个 OpenCV 程序](https://static.getiot.tech/opencv-helloworld.png#center)
