---
sidebar_position: 18
slug: /wio-terminal-connect-to-microsoft-azure-iot-central
---

# Wio Terminal 连接 Azure IoT Central



![](https://static.getiot.tech/wio-terminal-connect-to-microsoft-azure-iot-central.png#center)



## Azure 简介

在本教程中，我们将带领你完成将 Wio Terminal 连接到 Microsoft Azure IoT Central 并将遥测数据从 Wio Terminal 上的板载传感器/硬件（例如 3 轴加速度计、光线传感器、3 个按钮）发送到 Microsoft Azure 物联网中心。之后，你将能够在交互式仪表板上可视化传感器数据。此外，你还可以使用 Azure IoT Central 来控制硬件，例如使 Wio Terminal 上的板载蜂鸣器发出哔哔声。Microsoft Azure IoT Central 支持 HTTP、MQTT 和 AMQP 协议进行通信，但是在本教程中我们只会使用到 MQTT 协议。

**Microsoft Azure**

[Microsoft Azure](https://azure.microsoft.com/) 是微软的公共云计算平台，是微软托管的数据中心。你可以使用 Microsoft Azure 构建、测试、部署和管理应用程序和服务。

此外，它还提供一系列云服务，包括计算（compute）、分析（analytics）、存储（storage）和网络（networking）。Microsoft Azure 提供软件即服务（SaaS）、平台即服务（PaaS）、基础设施即服务（IaaS）和无服务器（serverless）。最后，它支持许多不同的编程语言、工具和框架。

**Microsoft Azure IoT**

[Microsoft Azure IoT](https://azure.microsoft.com/en-us/overview/iot) 是一组 Microsoft 托管的云服务，可连接、监视和控制数十亿 IoT 资产。它包括设备的安全和操作系统，以及帮助企业构建、部署和管理物联网应用程序的数据和分析。

![](https://static.getiot.tech/wio-terminal-connect-to-microsoft-azure-iot-central_01.png#center)

**Microsoft Azure IoT Central**

[Microsoft Azure IoT Central](https://azure.microsoft.com/en-us/services/iot-central) 是一个完全托管的全球物联网 SaaS（软件即服务）解决方案，可以轻松连接、监控和大规模管理你的物联网资产。它高度安全，并且会随着你的业务增长而扩展，确保你的投资可重复并与你现有的业务应用程序集成。同时，它还缩小了业务应用程序和 IoT 数据之间的差异。最后，它提供集中管理来重新配置和更新你的设备。

**IoT 即插即用**

IoT 即插即用（[IoT Plug and Play](https://docs.microsoft.com/en-us/azure/iot-pnp)）使解决方案构建者无需任何手动配置即可将智能设备与其解决方案集成。IoT Plug and Play 的核心是一个设备模型，设备使用该模型向支持 IoT Plug and Play 的应用程序声明其功能。包括：

| 功能       | 中文 | 描述                               |
| ---------- | ---- | ---------------------------------- |
| Properties | 属性 | 表示设备或其他实体的只读或可写状态 |
| Telemetry  | 遥测 | 设备发送的数据                     |
| Commands   | 命令 | 描述可以在设备上完成的功能或操作   |

IoT 即插即用认证设备消除了在 Azure IoT Central 中配置设备的麻烦，例如创建模板以及添加功能和接口。

**IoT 即插即用认证设备**

IoT 即插即用认证设备（IoT Plug and Play Certified Devices）是在 [Azure 认证设备目录](https://devicecatalog.azure.com/) 中列出的带有 IoT 即插即用徽章的设备。Wio Terminal 就是一款 IoT 即插即用认证设备。[via](https://devicecatalog.azure.com/devices/8b9c5072-68fd-4fc3-8e5f-5b15e3a20bd9)

![](https://static.getiot.tech/Wio-Terminal.jpg#center)

要获得 IoT 即插即用认证，你需要明确一些标准，其中之一是发布 DTDL（数字孪生定义语言）模型，该模型将设备的功能定义为 Azure/iot-plugandplay-models (DMR)，它存储在 [GitHub](https://github.com/Azure/iot-plugandplay-models) 仓库中。允许使用 IoT Plug and Play 认证设备的云服务从该存储库中了解设备功能。

![](https://static.getiot.tech/wio-terminal-connect-to-microsoft-azure-iot-central_02.png#center)



## 通过 MQTT 连接 Azure IoT Central

如前所述，我们将使用 MQTT 在 Wio Terminal 和 Microsoft Azure IoT Central 之间进行通信。但是，如果你需要，也可以使用 HTTP 桥接器。

![Azure IoT Wio Terminal send](https://static.getiot.tech/wio-terminal-connect-to-microsoft-azure-iot-central_03.png#center)

![Azure IoT Wio Terminal receive](https://static.getiot.tech/wio-terminal-connect-to-microsoft-azure-iot-central_04.png#center)

### Azure IoT Central 设置

首先，你需要访问 Microsoft Azure IoT Central，登录 Microsoft 帐户并为你的项目创建一个新应用程序。

- **第 1 步**：访问 [这里](https://apps.azureiotcentral.com/) 创建一个新应用（new application）
- **第 2 步**：点击左边导航菜单中的 **Build**，然后点击 **Custom apps**
- **第 3 步**：填写 **Application name**，然后在 **Pricing plan** 中选择 **Free**
- **第 4 步**：点击 **Create** 创建一个新的应用

现在，你已经成功设置 Azure IoT Central 啦！

### Wio Terminal 设置

下面将使用演示代码将 Wio Terminal 板载传感器的遥测数据发送到 Microsoft Azure IoT Central。

#### 更新 RTL8720 固件

我们需要使用 Wio Terminal 的 WiFi 功能，因此需要更新 Realtek RTL8720 的固件。请参考 [Wio Terminal 网卡固件更新](/wiot/wio-terminal-network-firmware/)，并完成固件更新和 Arduino 依赖库的安装。

**注意：** 请务必根据版本说明下的指定版本更新[固件](https://github.com/SeeedJP/wioterminal-aziot-example/releases)。

#### 下载示例代码

- **第 1 步**：导航到 GitHub 仓库 [wioterminal-aziot-example](https://github.com/SeeedJP/wioterminal-aziot-example)
- **第 2 步**：点击 **Releases**
- **第 3 步**：选择最新的 release，点击 **wioterminal-aziot-example.uf2** 下载 .uf2 文件

#### 上传示例程序

- **第 1 步**：将 Wio Terminal 连接到 PC，然后上电
- **第 2 步**：将电源开关从“ON”位置进一步向下滑动，松开，再次滑动并松开，进入 **Bootloader 模式**

<img src="https://static.getiot.tech/Wio-Terminal-Bootloader.png" alt="pir" width="600" />

**提示**：当 Wio Terminal 处于 Bootloader 模式，蓝色 LED 将开始以不同于闪烁的方式呼吸。

- **第 3 步**：打开 PC 的文件管理器，你会看到一个名为 Arduino 的外置存储驱动器
- **第 4 步**：将前面下载的 **.uf2** 文件放进 **Arduino** 驱动器
- **第 5 步**：将 Wio Terminal 的电源开关打到“OFF”位置

现在，我们已经将示例代码成功上传到 Wio Terminal。

#### WiFi 和 Azure IoT 配置

接下来，我们要配置 WiFi 和 Azure IoT 连接。

- **第 1 步**：同时按住 Wio Terminal 上方 3 个按键，然后将电源开关打到“ON”，进入配置模式

![](https://static.getiot.tech/wio-terminal-azure-iot-config.png#center)

- **第 2 步**：打开一个串口终端，例如 PUTTY（可参考 [串口工具合集](/tools/all-of-serial-tools/)）
- **第 3 步**：设置串口参数 **COM Port**、波特率 **9600**，进入控制台

![](https://static.getiot.tech/wio-terminal-azure-iot-config-putty.png#center)

- **第 4 步**：按 **ENTER** 键，输入 **`help`** 命令查看配置方法

- **第 5 步**：使用 **set_wifissid** 命令设置 WiFi SSID，如：`set_wifissid your_WI-Fi_network_name`

- **第 6 步**：使用 **set_wifipwd** 命令设置 WiFi 密码，如：`set_wifipwd your_WI-Fi_network_password`

- **第 7 步**：根据之前在 [Azure IoT Central](https://apps.azureiotcentral.com/) 上创建的应用来设置 Azure IoT 的连接信息

- **第 8 步**：在左边导航菜单找到 *Administration > Device Connection*，然后复制 ID scope 的值

- **第 9 步**：点击下方的 **SAS-IoT-Devices**，然后复制 **primary key** 的值

- **第 10 步**：在之前打开的串口终端，使用 **set_az_iotc** 设置 Azure IoT 连接参数，格式如下：

  ```bash
  set_az_iotc <your_ID_scope> <your_primary_key> <your_device_name>
  ```

  提示：设备名称（device name）可以自行选择

- **第 11 步**：通过将电源开关向下滑动到远离“ON”的位置并松开来重启 Wio Terminal

<img src="https://static.getiot.tech/wio-terminal-azure-iot-config-reset.png" alt="pir" width="600" />

现在，可以看到 Wio Terminal 的 LCD 屏上显示连接 WiFi 和 Azure IoT Hub 的信息。连接成功后，将会显示发送到 Azure IoT Central 的遥测数据。



### 显示 Telemetry 数据

接下来，我们将在 Azure IoT Central Dashboard 上显示来自 Wio Terminal 的 3 轴加速度计、光线传感器和 3 个按钮的传入遥测数据。

- **第 1 步**：打开 Azure IoT Central Dashboard
- **第 2 步**：在左边导航菜单中点击 **Devices**
- **第 3 步**：可以看到 Devices 有一个 **Seeed Wio Terminal** 条目，点击它
- **第 4 步**：点击前面设置的 **device name**

![](https://static.getiot.tech/wio-terminal-azure-iot-wio_demo.png#center)

现在，可以在交互式仪表板上可视化来自 Wio Terminal 板载 3 轴加速度计的数据。

![](https://static.getiot.tech/wio-terminal-azure-iot-wio_demo-accel.png#center)

这是默认视图，我们需要进行一些更改以显示其他遥测数据。

- **第 5 步**：点击左边导航菜单的 **Device templates**，然后点击 **Seeed Wio Terminal**，开始配置模板

![](https://static.getiot.tech/wio-terminal-azure-iot-device-template.png#center)

- **第 6 步**：点击 **Overview**

![](https://static.getiot.tech/wio-terminal-azure-iot-device-template-overview.png#center)

- **第 7 步**：展开 **telemetry** 下拉菜单，然后选择要可视化的遥测数据。

![](https://static.getiot.tech/wio-terminal-azure-iot-device-template-telemetry.png#center)

- **第 8 步**：点击 **Add tile**，你将看到添加到 Azure IoT Central Dashboard 的磁贴

![](https://static.getiot.tech/wio-terminal-azure-iot-device-template-add-tile.png#center)

- **第 9 步**：重复上述操作添加 3 个按键（left、center、right）

![](https://static.getiot.tech/wio-terminal-azure-iot-device-template-add-tile2.png#center)

下面是相关的配置情况：

| Tile Name       | Tile Size | Tile Visualization |
| :-------------- | :-------- | :----------------- |
| Light Intensity | 2 x 2     | Line chart         |
| Left button     | 1 x 1     | KPI                |
| Right button    | 1 x 1     | KPI                |
| Center button   | 2 x 2     | KPI                |

- **第 10 步**：点击 **Save**，然后 **Publish**

![](https://static.getiot.tech/wio-terminal-azure-iot-device-template-save.png#center)

- **第 11 步**：返回 Azure IoT Central 仪表板，你将能够可视化来自 Wio Terminal 的所有数据。

![](https://static.getiot.tech/wio-terminal-azure-iot-device-template-final.png#center)

- **第 12 步**：还可以单击 **Raw data** 选项卡实时查看所有遥测数据。

![](https://static.getiot.tech/wio-terminal-azure-iot-device-raw-data.png#center)

### 添加规则发送邮件

IoT Central 中的规则用作可自定义的响应工具，可触发来自连接设备的主动监控事件。例如，在此演示中，我们可以在 IoT Central 设置一条规则，当光照强度低于 50 时发送电子邮件。

- **第 1 步**：点击左边导航菜单中的 **Rules**
- **第 2 步**：点击 **+New** 或 **Create a rule**
- **第 3 步**：输入规则的名称
- **第 4 步**：在 **Device template** 一栏选择 **Seeed Wio Terminal**

![](https://static.getiot.tech/wio-terminal-azure-iot-rules.png#center)

- **第 5 步**：在 **Conditions** 下，打开 **time aggregation** 并选择一个 **time window**，这里我们将其设置为 5 分钟。这意味着每隔每 5 分钟，规则对最后第 5 分钟的数据进行一次评估。
- **第 6 步**：在 **Telemetry** 下拉菜单中选择遥测数据，这里我们选择 **Light intensity**
- **第 7 步**：在 **Aggregation** 选项中，选择 **Average**，表示将在之前设置的 **time window** 取平均值
- **第 8 步**：在 **Operator** 选项中，选择 **is less than** 条件
- **第 9 步**：在 **Value** 框中输入 **50**

![](https://static.getiot.tech/wio-terminal-azure-iot-rules-conditions.png#center)

- **第 10 步**：在 **Actions** 中选择 **Email**
- **第 11 步**：输入 **Display name**、**To address** 和 **Note** 信息

![](https://static.getiot.tech/wio-terminal-azure-iot-rules-email.png#center)

**注意**：此处的 **电子邮件地址** 应添加到此 **Azure IoT Central Application** 中，并且至少要登录一次。

设置步骤：导航到 *Administration > Users*，点击 **Assign user**，填写 **Email**，分配一个 **Role**，然后点击 **Save**。

- **第 14 步**：最后，点击 **Save** 保存



### 远程控制硬件

当然，你不仅可以在 Azure IoT Central 上查看遥测数据，还可以使用它来控制硬件。在这个演示中，我们将控制 Wio Terminal 上的内置蜂鸣器并指定蜂鸣器发出哔哔声的持续时间。

- **第 1 步**：点击 **Command** 选项卡
- **第 2 步**：在 **Duration** 下输入 **value** 值（单位是毫秒，例如 1000 = 1000ms = 1s）
- **第 3 步**：点击 **Run**，你将会在上述指定的持续时间内听到蜂鸣器发出的哔哔声

![](https://static.getiot.tech/wio-terminal-azure-iot-command.png#center)



## 如何添加传感器

可以将任何传感器添加到 Wio Terminal，并将遥测数据从连接的传感器发送到 Azure IoT Central。下面我们将一个 [Grove 温度和湿度传感器（DHT11）](https://www.seeedstudio.com/Grove-Temperature-Humidity-Sensor-DHT11.html) 连接到 Wio Terminal，并将温度和湿度数据发送到 Azure IoT Central 在仪表板上进行可视化。

### Microsoft VSCode 设置

#### 下载安装和配置 VSCode

如果我们想向 Wio Terminal 添加更多传感器以将遥测数据发送到 Azure IoT Central，我们就不能像以前那样轻松地使用 .uf2 文件。因为代码已经在 .uf2 文件中编译过了。所以，如果我们想在演示中添加更多代码，我们需要使用一个名为 Microsoft Visual Studio Code 的 IDE，添加必要的代码，最后将它们上传到 Wio Terminal。

所以，首先需要下载、安装和配置好 VSCode：

- **第 1 步**：访问 [code.visualstudio.com](https://code.visualstudio.com/)，点击 **Download** 适合你所用操作系统的安装包
- **第 2 步**：运行安装包，根据提示完成安装
- **第 3 步**：打开 Visual Studio Code
- **第 4 步**：点击 **Extensions** 安装 **PlatformIO** 插件

![](https://static.getiot.tech/wio-terminal-azure-iot-platformio-install.png#center)



#### VSCode 上的演示代码

- **第 1 步**：访问 [wioterminal-aziot-example](https://github.com/SeeedJP/wioterminal-aziot-example) 仓库
- **第 2 步**：找到最新的 **release** 版本，点击 **Source code (zip)** 下载 .zip 源码压缩包
- **第 3 步**：在本地解压缩 .zip 文件
- **第 4 步**：在 VSCode 上点击 `File > Open Folder...`，打开该工程
- **第 5 步**：打开 `include > config.h` 文件
- **第 6 步**：找到 **"dtmi:seeedkk:wioterminal:wioterminal_aziot_example;5"** 一行，并修改为 **"dtmi:local:wioterminal_aziot_example;5"**
- **第 7 步**：打开 `seeedkk-wioterminal-wioterminal_aziot_example.json` 文件（DTDL 模型），同样修改为 **"dtmi:local:wioterminal_aziot_example;5"**

当前的模型定义了加速度、光强度和按钮计数数据，我们将继续向这个 DTDL 模型添加温度和湿度。

- **第 8 步**：在 **"contents": [** 后面添加下面内容：

```json
  "contents": [
    {
      "@type": [
        "Telemetry",
        "Temperature"
      ],
      "name": "temp",
      "unit": "degreeCelsius",
      "displayName": {
        "en": "Temperature (C)",
        "ja": "温度"
      },
      "schema": "integer"
    },
    {
      "@type": "Telemetry",
      "name": "humi",
      "displayName": {
        "en": "Humidity (%RH)",
        "ja": "湿度"
      },
      "schema": "integer"
    },
```

**说明**：`name` 是我们后面代码中用来标识具体遥测数据的，`unit` 是数据对应的单位，`displayName` 是显示在 Azure IoT Central 上（“en”代表英语，“ja”代表日语，居然没有中文！），`schema` 是数据类型。

- **第 9 步**：打开 `platformio.ini` 文件，在 **lib_deps** 下添加 DHT11 库的 URL

```ini
lib_deps = 
    https://github.com/Seeed-Studio/Grove_Temperature_And_Humidity_Sensor
```

- **第 10 步**：打开 `src/main.cpp`，在 `#include "CliMode.h"` 后面添加 DHT11 头文件

```cpp showLineNumbers
#include "CliMode.h"
#include "DHT.h"
```

- **第 11 步**：添加 DHT11 定义和初始化代码（引脚定义可以根据你的实际连接修改）

```cpp showLineNumbers
LIS3DHTR<TwoWire> AccelSensor;
 
#define DHTPIN 0 //Define signal pin of DHT sensor 
// #define DHTPIN PIN_WIRE_SCL //Use I2C port as Digital Port */
#define DHTTYPE DHT11 //Define DHT sensor type 
DHT dht(DHTPIN, DHTTYPE); //Initializing DHT sensor
```

- **第 12 步**：在 **SendTelemetry()** 函数中添加下面代码，解析 json 文件和遥测数据

```cpp showLineNumbers
static az_result SendTelemetry()
{
    float accelX;
    float accelY;
    float accelZ;
    AccelSensor.getAcceleration(&accelX, &accelY, &accelZ);
 
    int light;
    light = analogRead(WIO_LIGHT) * 100 / 1023;
 
    int temp; //assign variable to store temperature
    int humi; //assign variable to store humidity
    temp = dht.readTemperature(); //read temperature
    humi = dht.readHumidity(); //read humidity
 
    char telemetry_topic[128];
    if (az_result_failed(az_iot_hub_client_telemetry_get_publish_topic(&HubClient, NULL, telemetry_topic, sizeof(telemetry_topic), NULL)))
    {
        Log("Failed az_iot_hub_client_telemetry_get_publish_topic" DLM);
        return AZ_ERROR_NOT_SUPPORTED;
    }
 
    az_json_writer json_builder;
    char telemetry_payload[200];
    AZ_RETURN_IF_FAILED(az_json_writer_init(&json_builder, AZ_SPAN_FROM_BUFFER(telemetry_payload), NULL));
    AZ_RETURN_IF_FAILED(az_json_writer_append_begin_object(&json_builder));
    AZ_RETURN_IF_FAILED(az_json_writer_append_property_name(&json_builder, AZ_SPAN_LITERAL_FROM_STR("temp")));
    AZ_RETURN_IF_FAILED(az_json_writer_append_int32(&json_builder, temp));
    AZ_RETURN_IF_FAILED(az_json_writer_append_property_name(&json_builder, AZ_SPAN_LITERAL_FROM_STR("humi")));
    AZ_RETURN_IF_FAILED(az_json_writer_append_int32(&json_builder, humi));
```

- **第 13 步**：在 **ntp.begin** 后面添加下面代码，以便让 DHT11 传感器准备工作

```cpp showLineNumbers
dht.begin(); //start DHT sensor
```

- **第 14 步**：点击 **PlatformIO** 图标，点击 **Build** 构建工程

![](https://static.getiot.tech/wio-terminal-azure-iot-platformio-build.png#center)

如果看到下面信息，说明已经编译完成。

```bash
================================== [SUCCESS] Took 30.56 seconds ==================================
```



### Azure IoT Central 设置

接下来我们要创建一个自定义的设备模板，以便于 Wio Terminal 的数据能够在 Azure IoT Central Dashboard 上显示。

#### 创建一个新设备模板

- **第 1 步**：访问 Azure IoT Central，点击左侧导航菜单中的 Device templates
- **第 2 步**：点击 **+ New**，选择 **IoT device** 类型，然后点击 **Next:Customize**
- **第 3 步**：在 **Device template name** 框输入名称，然后点击 **Next:Review**
- **第 4 步**：点击 **Create**

#### 导入自定义设备模型

- **第 1 步**：点击 **Import a model**
- **第 2 步**：打开之前解压好的 **wioterminal-aziot-example** 文件夹，选择 **seeedkk-wioterminal-wioterminal_aziot_example.json** 文件
- **第 3 步**：点击 **Open**
- **第 4 步**：在左边菜单中点击 **Views**，再点击 **Generate default views**
- **第 5 步**：点击 **Generate default dashboard view(s)**
- **第 6 步**：在左边菜单中点击 **Overview**，根据你的喜好定制化仪表板
- **第 7 步**：下面是我们的配置情况

| Tile Name                       | Tile Size | Tile Visualization |
| :------------------------------ | :-------- | :----------------- |
| Light Intensity                 | 2 x 2     | Line chart         |
| Light Intensity                 | 1 x 1     | Last Known Value   |
| Temperature (C), Humidity (%RH) | 2 x 2     | Line chart         |
| Temperature (C)                 | 1 x 1     | Last Known Value   |
| Humidity (%RH)                  | 1 x 1     | Last Known Value   |
| Left button                     | 1 x 1     | KPI                |
| Middle button                   | 1 x 1     | KPI                |
| Right button                    | 1 x 1     | KPI                |

![](https://static.getiot.tech/wio-terminal-azure-iot-dashboard-custom.png#center)

- **第 8 步**：点击 **Save** 保存，然后点击 **Publish** 发布

### Wio Terminal 设置

#### 硬件连接

将 DHT11 传感器连接到 Wio Terminal 的 Grove 数字端口

<img src="https://static.getiot.tech/wio-terminal-azure-iot-hardware-connect.png" alt="Wio Terminal connect DHT11 Sensor" />

#### 软件配置

首先需要将 PlatformIO 的程序上传到 Wio Terminal，这样才能将新增的温湿度遥测数据发送到 Azure IoT Central。回到 VSCode，点击 PlatformIO 图标，然后点击 Upload。

![](https://static.getiot.tech/wio-terminal-azure-iot-platform-upload.png#center)

接下来我们要配置 WiFi 和 Azure IoT，具体操作与前面介绍一致，这里不再累述。



### Azure IoT Central 可视化

好啦，现在我们回到 Azure IoT Central，点击左边导航菜单的 **Devices**，再点击对应的 **Device name**。

![](https://static.getiot.tech/wio-terminal-azure-iot-dashboard-final.png#center)

现在，你可以在 Azure IoT Central Dashboard 中看到来自 Wio Terminal 的所有传感器数据！

