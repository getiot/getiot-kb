---
sidebar_position: 14
slug: /wio-terminal-tinyml-tflm-meteostation
---

# Wio Terminal Tensorflow Lite 智能气象站



![](https://static.getiot.tech/wio-terminal-Intelligent-meteostation-01.jpeg#center)

本项目使用 Wio Terminal 和 Tensorflow Lite for Microcontrollers 创建一个智能气象站，它能够根据来自 BME280 环境传感器的本地数据预测未来 24 小时的天气和降水量。在这个项目中，我们将学习模型优化技术，将中等规模的卷积神经网络和流畅的 GUI 和 WiFi 网络连接等功能同时运行在 Wio Terminal 上。



## 项目概述

我们将在 Wio Terminal 的屏幕上显示当前的温度、湿度和大气压值，以及城市名称、预测的天气类型和预测的降水率，并且在屏幕底部有一个日志输出字段，我们可以轻松地将其重新用于显示其他信息，如极端天气信息。或者我们可以手动添加更多东西，例如在屏幕上显示新闻等。

![](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML-TFLM-2/result.gif#center)

在这个项目中，我们将处理时间序列数据。我们将每小时进行一次测量，并对 24 小时的数据进行预测。由于我们要预测未来 24 小时的天气类型，所以我们将使用相同的模型预测未来 24 小时的降水几率。为了做到这一点，我们将利用 Keras Functional API 和多输出模型。

在多输出模型中，有一个通用的“主干”，将预测出两个不同的输出。与两个独立模型相比，使用多输出模型的好处主要是用于预测天气类型和降水几率的数据和学习的特征是高度相关的。



## 安装依赖

- 如果在 Windows 上完成这个项目，我们需要先下载 Arduino IDE 的夜间版本；
- 其次，需要确保在 Arduino IDE 中拥有 1.8.2 版本以上的 Seeed SAMD 板卡库。
- 最后，由于我们要使用 Keras API 构建卷积神经网络，而它包含了 Tensorflow Micro 不支持的操作。所以需要你从该项目 Github 存储库下载已编译的库并将其放入本地的 Arduino 库文件夹中，并确保当前只有一个 Tensorflow lite 库。



## **了解数据**

当然，这一切都始于数据。在本教程中，我们将使用来自 Kaggle 的一个现成的天气数据集，Historical Hourly Weather Data 2012-2017。然而 Seeed EDU 总部位于中国南方城市深圳，该城市不在数据集中，因此我们选择了一个位于相似纬度且具有亚热带气候的城市 —— 迈阿密。

![](https://static.getiot.tech/wio-terminal-Intelligent-meteostation-02.jpeg#center)

你需要选择一个至少与你居住的气候相似的城市，如果你决定使用迈阿密的数据训练，然后冬天部署在芝加哥的模型不会输出正确的预测。



## **构建机器学习模型**

对于数据处理和模型训练步骤，让我们打开 Jupyter Notebook。运行这个 notebook 的最简单方法是将它上传到 Google Colab，因为它已经安装了所有包并准备运行。

![](https://static.getiot.tech/wio-terminal-Intelligent-meteostation-03.png#center)

当然，你也可以在本地运行 Notebook。使用你在激活之前创建的 ML 虚拟环境。然后在同一环境中运行 jupyter notebook 命令，这将在浏览器中打开 Notebook 服务器。Jupyter Notebooks 允许在同一环境中同时包含文本和可执行代码，是探索和呈现数据的好方法。



## 部署到 Wio Terminal

我们在上一步中训练的模型已转换为数组，其中包含模型结构和权重，现在可以与 C++ 代码一起加载到 Wio Terminal。

![](https://static.getiot.tech/wio-terminal-Intelligent-meteostation-04.png#center)

Tensorflow Lite for Microcontrollers 包括模型解释器，它旨在精简和快速。解释器使用静态图排序和自定义（非动态）内存分配器来确保最小的负载、初始化和执行延迟。放置在输入缓冲区中的数据被馈送到模型图，然后在推理完成后，结果被放置在输出缓冲区中。

为了减小模型的大小并减少推理时间，我们执行了两个重要的优化：执行全整数量化，将模型权重、输入和输出从 32 位浮点（每个占用 32 位内存）更改为 8 位整数（每个仅占用 8 位），从而将程序大小减少 4 倍。

![](https://static.getiot.tech/wio-terminal-Intelligent-meteostation-05.png#center)

使用 micro_mutable_op_resolver 并指定我们在神经网络中的操作，仅使用运行模型所需的操作来编译我们的代码，而不是使用 all_ops_resolver，后者包括当前 Tensorflow Lite for Microcontrollers 解释器支持的所有操作。

模型训练完成后，创建一个空的草图并保存。然后将你训练的模型复制到草图文件夹并重新打开草图。将模型的变量名称和模型长度更改为较短的名称。然后使用 [wio_terminal_tfmicro_weather_prediction_static.ino](https://github.com/Seeed-Studio/Seeed_Arduino_Sketchbook/tree/master/examples/WioTerminal_TinyML_4_Weather_Prediction) 中的代码。

![](https://static.getiot.tech/wio-terminal-Intelligent-meteostation-06.png#center)

让我们来看一下 C++ 代码中的主要步骤，首先包括 Tensorflow 库的头文件和带有模型 flatbuffer 的文件。

```cpp showLineNumbers
#include <TensorFlowLite.h>
//#include "tensorflow/lite/micro/micro_mutable_op_resolver.h"
#include "tensorflow/lite/micro/all_ops_resolver.h"
#include "tensorflow/lite/micro/micro_error_reporter.h"
#include "tensorflow/lite/micro/system_setup.h"
#include "tensorflow/lite/micro/micro_interpreter.h"
#include "tensorflow/lite/schema/schema_generated.h"
#include "model_Conv1D.h"
```

注意：这里注释掉了 micro_mutable_op_resolver.h，并启用 all_ops_resolver.h 头文件。all_ops_resolver.h 头文件编译了 Tensorflow Micro 当前存在的所有操作，方便测试，但是一旦你完成测试，最好切换到 micro_mutable_op_resolver.h 进行设备内存的保存，两者确实有很大的不同。

接下来我们定义错误报告器、模型、输入和输出张量以及解释器的指针。注意我们的模型有两个输出 —— 一个是降水量，另一个是天气类型。我们还定义了 tensor arena，你可以把它想象成一个草稿板，保存输入、输出和中间数组 —— 所需的大小取决于你使用的模型，可能需要通过实验来确定。

```cpp showLineNumbers
// Globals, used for compatibility with Arduino-style sketches.
namespace {
tflite::ErrorReporter* error_reporter = nullptr;
const tflite::Model* model = nullptr;
tflite::MicroInterpreter* interpreter = nullptr;
TfLiteTensor* input = nullptr;
TfLiteTensor* output_type = nullptr;
TfLiteTensor* output_precip = nullptr;
constexpr int kTensorArenaSize = 1024*25;
uint8_t tensor_arena[kTensorArenaSize];
}  // namespace
```

然后在 setup 函数中，有更多样板的东西，例如实例化错误报告器、操作解析器、解释器、映射模型、分配张量，最后检查分配后的张量形状。如果当前版本的 Tensorflow Micro 库不支持某些模型操作，则代码可能会在运行时抛出错误。 如果你有不受支持的操作，可以更改模型架构或自己添加对操作符的支持，通常是通过从 Tensorflow Lite 移植它。

```cpp showLineNumbers
void setup() {
  Serial.begin(115200);
  while (!Serial) {delay(10);}
 
  // Set up logging. Google style is to avoid globals or statics because of
  // lifetime uncertainty, but since this has a trivial destructor it's okay.
  // NOLINTNEXTLINE(runtime-global-variables)
  static tflite::MicroErrorReporter micro_error_reporter;
  error_reporter = &micro_error_reporter;
  // Map the model into a usable data structure. This doesn't involve any
  // copying or parsing, it's a very lightweight operation.
  model = tflite::GetModel(Conv1D_tflite);
  if (model->version() != TFLITE_SCHEMA_VERSION) {
    TF_LITE_REPORT_ERROR(error_reporter,
                         "Model provided is schema version %d not equal "
                         "to supported version %d.",
                         model->version(), TFLITE_SCHEMA_VERSION);
    return;
  }
  // This pulls in all the operation implementations we need.
  // NOLINTNEXTLINE(runtime-global-variables)
  //static tflite::MicroMutableOpResolver<1> resolver;
  static tflite::AllOpsResolver resolver;
  // Build an interpreter to run the model with.
  static tflite::MicroInterpreter static_interpreter(model, resolver, tensor_arena, kTensorArenaSize, error_reporter);
  interpreter = &static_interpreter;
  // Allocate memory from the tensor_arena for the model's tensors.
  TfLiteStatus allocate_status = interpreter->AllocateTensors();
  if (allocate_status != kTfLiteOk) {
    TF_LITE_REPORT_ERROR(error_reporter, "AllocateTensors() failed");
    return;
  }
  // Obtain pointers to the model's input and output tensors.
  input = interpreter->input(0);
  output_type = interpreter->output(1);
  output_precip = interpreter->output(0);
 
  Serial.println(input->dims->size);
  Serial.println(input->dims->data[1]);
  Serial.println(input->dims->data[2]);
  Serial.println(input->type);
  Serial.println(output_type->dims->size);
  Serial.println(output_type->dims->data[1]);
  Serial.println(output_type->type);
  Serial.println(output_precip->dims->size);
  Serial.println(output_precip->dims->data[1]);
  Serial.println(output_precip->type);
}
```

最后，在循环函数中，我们为量化的 INT8 值定义了一个占位符和一个带有浮点值的数组，你可以从 Colab 笔记本中复制粘贴，以比较设备上与 Colab 中的模型推理。

```cpp showLineNumbers
void loop() {
  int8_t x_quantized[72];
  float x[72] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0};
```

我们在 for 循环中将浮点值量化为 INT8 并将它们一一放入输入张量中：

```cpp showLineNumbers
for (byte i = 0; i < 72; i = i + 1) {
        input->data.int8[i] = x[i] / input->params.scale + input->params.zero_point;
  }
```

然后由 Tensorflow Micro 解释器执行推理，如果没有报告错误，则将值放置在输出张量中。

```cpp showLineNumbers
// Run inference, and report any error
  TfLiteStatus invoke_status = interpreter->Invoke();
 
  if (invoke_status != kTfLiteOk) {
    TF_LITE_REPORT_ERROR(error_reporter, "Invoke failed");
    return;
  }
```

与输入类似，模型的输出也是量化的，所以我们需要进行反向操作，将其从 INT8 转换为浮点数。

```cpp showLineNumbers
// Obtain the quantized output from model's output tensor
  float y_type[4];
  // Dequantize the output from integer to floating-point
  int8_t y_precip_q = output_precip->data.int8[0];
  Serial.println(y_precip_q);
  float y_precip = (y_precip_q - output_precip->params.zero_point) * output_precip->params.scale;  
  Serial.print("Precip: ");
  Serial.print(y_precip);
  Serial.print("\t");
  Serial.print("Type: ");
  for (byte i = 0; i < 4; i = i + 1) {
    y_type[i] = (output_type->data.int8[i] - output_type->params.zero_point) * output_type->params.scale;
    Serial.print(y_type[i]);
    Serial.print(" ");
  }
  Serial.print("\n");
}
```

检查并比较相同数据点的值，对于 Colab notebook 中的量化 Tensorflow Lite 模型和在 Wio Terminal 上运行的 Tensorflow Micro 模型，它们应该相同。

![](https://static.getiot.tech/wio-terminal-Intelligent-meteostation-07.png#center)

最后，加上 LVGL 图形界面和 WiFi 网络功能即可。

