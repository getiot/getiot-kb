---
sidebar_position: 3
slug: /wio-terminal-imu
---

# Wio Terminal 惯量传感器



Wio-Terminal 内置了一个 3 轴加速度传感器（[LIS3DHTR](https://www.st.com/zh/mems-and-sensors/lis3dh.html)），有时候也称为 IMU（Inertial measurement unit，惯性测量单元）。本文主要介绍如何在 Wio Terminal 上使用 LIS3DHTR 加速度传感器，并演示一些运动控制的案例。



## 电路原理图

下图是 LIS3DHTR 传感器的电路，通过 I2C 接口与主控制器 SAMD51 通信，I2C 地址是 `0x19`。

![](https://static.getiot.tech/wio-terminal-SCH-LIS3DHTR.png#center)



## 安装依赖库

首先需要为 Wio Terminal 安装加速度传感器库 `Seeed_Arduino_LIS3DHTR`。

1、在 `Seeed_Arduino_LIS3DHTR` 的 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_LIS3DHTR) 下载 zip 包。

2、然后将 `Seeed_Arduino_LIS3DHTR` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库…*，然后选择刚刚下载的 Seeed_Arduino_LIS3DHTR.zip 文件。



## 传感器使用示例

下面示例演示如何初始化 Wio Terminal 内置加速器 LIS3DHTR，读取并将数据显示在串口监视器。

### 初始化

初始化加速度传感器的要点：

- 设置数据输出速率：`lis.setOutputDataRate()`，范围 1Hz 到 5kHz。
- 设置刻度范围：`lis.FullScaleRange()`，范围 2g 到 16g。

```cpp showLineNumbers
#include"LIS3DHTR.h"
LIS3DHTR<TwoWire> lis;

void setup() {
    ...
    lis.begin(Wire1); 
    lis.setOutputDataRate(LIS3DHTR_DATARATE_25HZ); // Setting output data rage to 25Hz, can be set up tp 5kHz 
    lis.setFullScaleRange(LIS3DHTR_RANGE_2G); // Setting scale range to 2g, select from 2,4,8,16g
    ...
}
```



### 读取数据

读取加速度计包含三个轴的数据，即 X、Y、Z，代码如下：

```cpp showLineNumbers
void loop() {
    float x_values, y_values, z_values;
    x_values = lis.getAcceleratationX();
    y_values = lis.getAcceleratationY();
    z_values = lis.getAcceleratationZ();
    delay(50);  // delay to avoid large amount of data being read
    ...
}
```

注意：强烈建议使用延迟以避免一次性大量数据。



### 示例代码

下面示例将在串口监视器上循环打印加速度计的三轴数值。

```cpp showLineNumbers
#include"LIS3DHTR.h"
LIS3DHTR<TwoWire> lis;
 
void setup() {
  Serial.begin(115200);
  lis.begin(Wire1);
 
  if (!lis) {
    Serial.println("ERROR");
    while(1);
  }
  lis.setOutputDataRate(LIS3DHTR_DATARATE_25HZ); //Data output rate
  lis.setFullScaleRange(LIS3DHTR_RANGE_2G); //Scale range set to 2g
}
 
void loop() {
  float x_values, y_values, z_values;
  x_values = lis.getAccelerationX();
  y_values = lis.getAccelerationY();
  z_values = lis.getAccelerationZ();
 
  Serial.print("X: "); Serial.print(x_values);
  Serial.print(" Y: "); Serial.print(y_values);
  Serial.print(" Z: "); Serial.print(z_values);
  Serial.println();
  delay(50);
}
```



## 运动感知示例

下面示例演示 Wio Terminal 如何使用内置加速器来感知单击或双击敲击动作！

![img](https://files.seeedstudio.com/wiki/Wio-Terminal/img/2019-12-10%2010-33-58.2019-12-10%2010_35_11.gif#center)



### 敲击灵敏度配置

对于敲击的灵敏度，根据 IMU 的刻度范围调整 THRESHOLD 的值：

| Scale Range | 2g    | 4g    | 8g    | 16g  |
| :---------- | :---- | :---- | :---- | :--- |
| THRESHOLD   | 40-80 | 20-40 | 10-20 | 5-10 |



### 单击或双击

要使用 `click()` 函数，只需如下调用它，其中第一个参数用于确定感应单击或双击（1 或 2），第二个参数用于设置阈值（threshold）。

```cpp showLineNumbers
void setup() {
    ...
    lis.click(1, THRESHOLD);
    //Interrupt signal to trigger when a tap is detected!
    attachInterrupt(digitalPinToInterrupt(GYROSCOPE_INT1), count, RISING);
}
```

**注意**：`GYROSCOPE_INT1` 是加速度计中断引脚 1。



### 完整代码

```cpp showLineNumbers
#include "LIS3DHTR.h"
LIS3DHTR<TwoWire> lis;

//Adjust this threshold value for sensitivity of clicking
#define THRESHOLD 40
uint8_t cnt = 0;

void count() {
    cnt++;
    Serial.print("Tap Count: ");
    Serial.println(cnt);
}

void setup() {
    Serial.begin(115200);
    lis.begin(Wire1);

    if (!lis) {
        Serial.println("ERROR");
        while(1);
    }
    lis.setOutputDataRate(LIS3DHTR_DATARATE_25HZ); //Data output rate
    lis.setFullScaleRange(LIS3DHTR_RANGE_2G); //Scale range set to 2g

    //1 for single click, 2 for double click
    //smaller the threshold value, the more sensitive
    lis.click(1, THRESHOLD);
    //Interrupt signal to trigger when a tap is detected!
    attachInterrupt(digitalPinToInterrupt(GYROSCOPE_INT1), count, RISING);
}

void loop() {
}
```

