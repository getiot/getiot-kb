---
sidebar_position: 32
authors: [luhuadong]
---

# Arduino Nano 33 BLE Sense 实验



Arduino Nano 33 BLE Sense 板旨在为寻求在其项目中实现低功耗蓝牙连接的制造商提供省电且经济高效的解决方案。它基于 [NINA B306](https://www.u-blox.com/sites/default/files/NINA-B3_DataSheet_(UBX-17052099).pdf) 模块，核心是包含 Cortex M4F 微控制器的 Nordic nRF52480。[Nano 33 BLE Sense](/arduino/arduino-nano-33-ble-sense/) 和 Arduino Nano 33 BLE 一样，只不过增加了一组传感器。下面将会逐一介绍这些传感器，了解如何设置编程环境并驱动硬件。

要对 Arduino Nano 33 BLE Sense 进行编程，可以使用 Arduino IDE 或者 Arduino Web Editor，下面以 Arduino IDE 进行讲解。



## 开发环境

要对 Arduino Nano 33 BLE Sense 进行编程，安装好 Arduino IDE 工具之后，还需要安装 Arduino Mbed OS Core。安装方法很简单，选择菜单栏的“工具” -> 开发板 -> 开发板管理器，在开发板管理器中输入 “nano 33 ble” 进行搜索，找到 Arduino Mbed OS Nano Boards，点击“安装”即可。请耐心等待安装完毕。

![](https://static.getiot.tech/arduino-board-manager-add-nano33ble.png#center)

Arduino Nano 33 BLE Sense 板是 Arduino Nano 33 BLE 的硬件变体，这两块板都会被识别为 **Arduino Nano 33 BLE**，所以当你连接 Arduino Nano 33 BLE Sense 板与电脑，IDE 显示开发板为 Arduino Nano 33 BLE 时不要惊讶。

![](https://static.getiot.tech/arduino-nano33-ble-board-information.png#center)

OSX 和 Linux 系统不需要额外安装驱动程序，而对于 Windows 系统，插入 Arduino Nano 33 BLE Sense 板卡后，将会启动其驱动程序安装过程。

如果一切正常，你可以打开 LED blink 示例程序，编译并上传到 Arduino 板上，看板载的橙色 LED 灯是否闪烁。



## 注意事项

开始之前，我们先来看看使用 Arduino Nano 33 BLE Sense 的一些注意事项。

- **工作电压**

  Arduino Nano 33 BLE Sense 微控制器的工作电压是 3.3V，这意味着你不能在其数字和模拟引脚上施加超过 3.3V 的电压。连接传感器和执行器时必须小心，以确保永远不会超过 3.3V 的限制。**连接更高电压的信号（如其他 Arduino 板常用的 5V）会损坏 Arduino Nano 33 BLE Sense。**

  由于默认出厂设置 VUSB 焊盘没有连接上，所以接口连接器上的 5V 引脚（位于 RST 和 A7 之间）并不能立即工作。这是为了安全考虑，提醒用户尽量连接器件到数字和模拟引脚上时，应尽量使用 3.3V 电压。如果你的设计必须从该引脚获取 5V 电压，那么你必须用焊锡连接上 VUSB 的两个焊盘，同时采用 USB 端口为 Nano 33 BLE Sense 供电。如果从 VIN 引脚为电路板供电，则不会得到 5V 稳压。

  3.3V 引脚始终可用，并且支持足够的电流来驱动传感器。因此，请在设计时尽可能选择 3.3V 驱动的传感器和执行器。这很容易实现，因为 3.3V 已经成为电子 IC 的标准电压了。

- **串口**

  评估板的 USB 接口直接连接到 NINA B306 模块的 USB 控制器。因此，你可以将 Arduino Nano 33 BLE Sense 用作 USB 外设（充当连接到计算机的鼠标或键盘），或者用作 USB 主机设备，以便将鼠标、键盘或 Android 手机之类的设备连接到 Arduino Nano 33 BLE。该 USB 端口也可用作虚拟串口，使用 Arduino 编程语言中的 `Serial` 对象操作。而 RX0 和 TX1 引脚可作为第二个串口，使用 `Serial1`。

- **ADC 和 PWM 分辨率**

  Arduino Nano 33 BLE 可以更改其模拟读取分辨率 —— 默认为10位，最高支持12位 ADC。PWM 具有8位分辨率。关于如何更改 ADC 分辨率，请查看 [analog read resolution](https://www.arduino.cc/zh/Reference/AnalogReadResolution) 页面。



## 实验示例

现在你已经知道怎么给 Arduino Nano 33 BLE Sense 板编程，接下来你可以去 [Project Hub](https://create.arduino.cc/projecthub) 找一些灵感，或者跟着下面的教程来学习如何使用开发板上的功能。



### 惯性测量单元（LSM9DS1）

Arduino Nano 33 BLE Sense 板载的 IMU（惯性测量单元）是 [LSM9DS1](https://www.st.com/resource/en/datasheet/lsm9ds1.pdf)，它包含三轴加速度计（3-axis accelerometer）、三轴陀螺仪（3-axis gyroscope）和三轴磁力计（3-axis magnetometer）。LSM9DS1 是意法半导体生产的，并已提供 [Arduino_LSM9DS1](https://www.arduino.cc/en/Reference/ArduinoLSM9DS1) 软件库。通过该软件库的示例代码，我们可以快速使用 LSM9DS1 传感器。

#### 加速度

```cpp showLineNumbers
/*
  Arduino LSM9DS1 - Simple Accelerometer
  从 LSM9DS1 传感器读取加速度值
*/

#include <Arduino_LSM9DS1.h>

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("Started");

  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU!");
    while (1);
  }

  Serial.print("Accelerometer sample rate = ");
  Serial.print(IMU.accelerationSampleRate());
  Serial.println(" Hz");
  Serial.println();
  Serial.println("Acceleration in G's");
  Serial.println("X\tY\tZ");
}

void loop() {
  float x, y, z;

  if (IMU.accelerationAvailable()) {
    IMU.readAcceleration(x, y, z);

    Serial.print(x);
    Serial.print('\t');
    Serial.print(y);
    Serial.print('\t');
    Serial.println(z);
  }
}
```

#### 陀螺仪

```cpp showLineNumbers
/*
  Arduino LSM9DS1 - Simple Gyroscope
  从 LSM9DS1 传感器中读取旋转率（角速度）
*/

#include <Arduino_LSM9DS1.h>

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("Started");

  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU!");
    while (1);
  }
  Serial.print("Gyroscope sample rate = ");
  Serial.print(IMU.gyroscopeSampleRate());
  Serial.println(" Hz");
  Serial.println();
  Serial.println("Gyroscope in degrees/second");
  Serial.println("X\tY\tZ");
}

void loop() {
  float x, y, z;

  if (IMU.gyroscopeAvailable()) {
    IMU.readGyroscope(x, y, z);

    Serial.print(x);
    Serial.print('\t');
    Serial.print(y);
    Serial.print('\t');
    Serial.println(z);
  }
}
```

#### 磁力计

```cpp showLineNumbers
/*
  Arduino LSM9DS1 - Simple Magnetometer
  从 LSM9DS1 传感器中读取地磁场数据
*/

#include <Arduino_LSM9DS1.h>

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("Started");

  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU!");
    while (1);
  }
  Serial.print("Magnetic field sample rate = ");
  Serial.print(IMU.magneticFieldSampleRate());
  Serial.println(" uT");
  Serial.println();
  Serial.println("Magnetic Field in uT");
  Serial.println("X\tY\tZ");
}

void loop() {
  float x, y, z;

  if (IMU.magneticFieldAvailable()) {
    IMU.readMagneticField(x, y, z);

    Serial.print(x);
    Serial.print('\t');
    Serial.print(y);
    Serial.print('\t');
    Serial.println(z);
  }
}
```



### 数字麦克风（MP34DT05）

Arduino Nano 33 BLE Sense 板载的数字麦克风（digital microphone）是 [MP34DT05](https://www.st.com/resource/en/datasheet/mp34dt05-a.pdf)，它也是来自意法半导体公司的芯片。是一个超紧凑、低功耗的全向数字 MEMS 麦克风，内置有电容式感应元件和 IC 接口，输出 PDM 编码格式数据。

PDM（Pulse Density Modulation）格式由 [PDM](https://www.arduino.cc/en/Reference/PDM) 库支持，也可以与 [ArduinoSound](https://www.arduino.cc/en/Reference/ArduinoSound) 一起使用。

```cpp showLineNumbers
/*
  读取板载 MP34DT05 传感器数据，并转换为环境噪声 dB 值
*/

#include <PDM.h>
#include <math.h>

static const char channels = 1;      // default number of output channels
static const int frequency = 16000;  // default PCM output frequency
short sampleBuffer[512];   // Buffer to read samples into, each sample is 16bits
volatile int samplesRead;  // Number of audio samples read

void setup()
{
    Serial.begin(9600);
    PDM.onReceive(onPDMdata);
    PDM.setGain(20);
    if (!PDM.begin(channels, frequency)) {
        Serial.println("Failed to start PDM!");
        while (1);
    }
}

void loop()
{
    double spl = 0;  // 环境噪声 dB
    double amp = 0;  // amp: amplitude of sound
    double sum = 0;
    int cnt = 0;     // max: 1023, 15.625Hz
    
    while (cnt<1020) { // 1024
        if (samplesRead) {
            for (int i=0; i<samplesRead; i++) {
                sum += double(sampleBuffer[i])*sampleBuffer[i];
            }
            cnt += samplesRead;
            samplesRead = 0;
        }
        amp = 20 * log10(10*sqrt(sum/cnt));
    }
    spl = amp;
    
    Serial.print(spl);
    Serial.println(" dB");
    delay(1000);
}

void onPDMdata()
{
    int bytesAvailable = PDM.available();
    PDM.read(sampleBuffer, bytesAvailable);
    samplesRead = bytesAvailable / 2;
}
```



### 感光传感器（APDS9960）

APDS9960 传感器具有先进的手势检测、接近检测、数字环境光感（ALS）和色感（RGBC）。它是博通（Broadcom ）公司生产的，并提供了 [Arduino_APDS9960](https://www.arduino.cc/en/Reference/ArduinoAPDS9960) 软件库。

#### 手势检测

```cpp showLineNumbers
/*
  APDS9960 - Gesture Sensor
  从板载 APDS9960 传感器中读取手势数据，将检测到的任何手势动作打印到监视器

  手势方向：
  - UP:    from USB connector towards antenna
  - DOWN:  from antenna towards USB connector
  - LEFT:  from analog pins side towards digital pins side
  - RIGHT: from digital pins side towards analog pins side
*/

#include <Arduino_APDS9960.h>

void setup() {
  Serial.begin(9600);
  while (!Serial);

  if (!APDS.begin()) {
    Serial.println("Error initializing APDS9960 sensor!");
  }

  APDS.setGestureSensitivity(80);
  Serial.println("Detecting gestures ...");
}

void loop() {
  if (APDS.gestureAvailable()) {
    // a gesture was detected, read and print to serial monitor
    int gesture = APDS.readGesture();

    switch (gesture) {
      case GESTURE_UP:
        Serial.println("Detected UP gesture");
        break;

      case GESTURE_DOWN:
        Serial.println("Detected DOWN gesture");
        break;

      case GESTURE_LEFT:
        Serial.println("Detected LEFT gesture");
        break;

      case GESTURE_RIGHT:
        Serial.println("Detected RIGHT gesture");
        break;

      default:
        // ignore
        break;
    }
  }
}
```

#### 距离检测

```cpp showLineNumbers
/*
  APDS9960 - Proximity Sensor
  从板载 APDS9960 传感器中读取距离数据，并每100ms打印一次到监视器
*/

#include <Arduino_APDS9960.h>

void setup() {
  Serial.begin(9600);
  while (!Serial);

  if (!APDS.begin()) {
    Serial.println("Error initializing APDS9960 sensor!");
  }
}

void loop() {
  // check if a proximity reading is available
  if (APDS.proximityAvailable()) {
    // read the proximity
    // - 0   => close
    // - 255 => far
    // - -1  => error
    int proximity = APDS.readProximity();

    // print value to the Serial Monitor
    Serial.println(proximity);
  }

  // wait a bit before reading again
  delay(100);
}
```

#### 颜色检测

```cpp showLineNumbers
/*
  APDS9960 - Color Sensor
  从板载 APDS9960 传感器中读取颜色数据（RGB），并每秒打印一次到监视器
*/

#include <Arduino_APDS9960.h>

void setup() {
  Serial.begin(9600);
  while (!Serial);

  if (!APDS.begin()) {
    Serial.println("Error initializing APDS9960 sensor.");
  }
}

void loop() {
  // check if a color reading is available
  while (! APDS.colorAvailable()) {
    delay(5);
  }
  int r, g, b;

  // read the color
  APDS.readColor(r, g, b);

  // print the values
  Serial.print("r = ");
  Serial.println(r);
  Serial.print("g = ");
  Serial.println(g);
  Serial.print("b = ");
  Serial.println(b);
  Serial.println();

  // wait a bit before reading again
  delay(1000);
}
```



### 读取大气压值（LPS22HB）

[LPS22HB](https://www.st.com/resource/en/datasheet/lps22hb.pdf) 是一个超紧凑的数字气压计，由意法半导体公司生产，并提供 [Arduino_LPS22HB](https://www.arduino.cc/en/Reference/ArduinoLPS22HB) 软件库。

```cpp showLineNumbers
/*
  读取板载 LPS22HB 传感器数据，并每秒打印一次气压值到监视器
*/

#include <Arduino_LPS22HB.h>

void setup() {
  Serial.begin(9600);
  while (!Serial);

  if (!BARO.begin()) {
    Serial.println("Failed to initialize pressure sensor!");
    while (1);
  }
}

void loop() {
  // read the sensor value
  float pressure = BARO.readPressure();

  // print the sensor value
  Serial.print("Pressure = ");
  Serial.print(pressure);
  Serial.println(" kPa");

  // print an empty line
  Serial.println();

  // wait 1 second to print again
  delay(1000);
}
```



### 读取温湿度值（HTS221）

[HTS221](https://www.st.com/resource/en/datasheet/HTS221.pdf) 是一个采用聚合物电介质平面电容器结构设计的温湿度传感器，可以检测环境温度和相对湿度，并通过串行接口输出数字信号。该传感器由意法半导体公司生产，并提供 [Arduino_HTS221](https://www.arduino.cc/en/Reference/ArduinoHTS221) 软件库。

```cpp showLineNumbers
/*
  读取板载 HTS221 传感器数据，并每秒打印一次温度和湿度值到监视器
*/

#include <Arduino_HTS221.h>

void setup() {
  Serial.begin(9600);
  while (!Serial);

  if (!HTS.begin()) {
    Serial.println("Failed to initialize humidity temperature sensor!");
    while (1);
  }
}

void loop() {
  // read all the sensor values
  float temperature = HTS.readTemperature();
  float humidity    = HTS.readHumidity();

  // print each of the sensor values
  Serial.print("Temperature = ");
  Serial.print(temperature);
  Serial.println(" °C");

  Serial.print("Humidity    = ");
  Serial.print(humidity);
  Serial.println(" %");

  // print an empty line
  Serial.println();

  // wait 1 second to print again
  delay(1000);
}
```

注意：由于 Arduino Nano 33 BLE Sense 运行期间会散发热量，因此测量的温湿度值并不能很好地反映所在环境的温湿度情况。

为了抵消电路板自身的热量，我们建议：

- 在软件上考虑温度上升的影响，并作数据补偿（但可能难以评估）；
- 如果重新设计电路，尽可能减少电路板发热，或将温度传感器放置在远离发热源的区域。

对于 Arduino Nano 33 BLE Sense 板，建议使用尽可能低的功耗模式，并将处理器活动将至最低。除此之外，还可以切断背面 3.3V 焊盘之间的连接，绕过 DC-DC 稳压器为电路板供电，通过 3.3V 和 GND 输入引脚供电。不过，这样处理之后就会隔离 DC/DC 5V->3.3V 电路，也就无法使用 USB 给板子烧写程序。因此，建议你在完成草图和最终程序之后，再切断 3.3V 焊盘的连接。



