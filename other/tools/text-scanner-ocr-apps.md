---
sidebar_position: 44
slug: /text-scanner-ocr-apps
---

# OCR 文字识别软件

OCR（Optical Character Recognition，光学字符识别）是一项能将图片中的文字提取为可编辑文本的技术。无论是扫书、截屏提字，还是发票识别、文档数字化，OCR 工具都能极大提高效率。下面是一些常用、靠谱的 OCR 工具推荐，包含开源免费与商用产品，适用于不同平台和需求。



## Tesseract OCR（跨平台、开源）

**Tesseract** 是由 Google 维护的一款强大的 OCR 引擎，被广泛用于各类开源和商用应用中。它本身是命令行工具，支持多语言文字识别，并且可以通过调用 API 集成到各种程序中（如 Python、C++）。

Tesseract 是开源的，采用 Apache 2.0 许可证，支持 Windows、macOS、Linux 操作系统，支持训练自定义语言模型。

**安装方法**：

- Ubuntu：

  ```bash
  sudo apt install tesseract-ocr
  ```

- macOS：

  ```bash
  brew install tesseract
  ```

- Windows: 可从官网下载安装包。

网址：[https://github.com/tesseract-ocr/tesseract](https://github.com/tesseract-ocr/tesseract)



## OCRmyPDF（免费，开源，专注 PDF）

**OCRmyPDF** 是一个为 PDF 添加 OCR 文本层的命令行工具，底层同样基于 Tesseract，支持平台 Windows、macOS、Linux 操作系统（推荐使用 Linux）。它能将扫描的 PDF 变成“可选中复制文字”的格式，非常适合用于归档和搜索。

- 安装方式（macOS）：

  ```bash
  brew install ocrmypdf
  ```

- 安装方式（Ubuntu）：

  ```bash
  sudo apt install ocrmypdf
  ```


官网：[https://github.com/ocrmypdf/OCRmyPDF](https://github.com/ocrmypdf/OCRmyPDF)



## Capture2Text（免费，轻量截图 OCR 工具）

**Capture2Text** 是 Windows 下非常轻巧的一款截图识字工具，启动快捷，识别迅速，非常适合日常临时识别屏幕文字。可设置快捷键调用，不需要复杂操作。

- 支持平台：Windows
- 安装方式：直接解压使用，无需安装
- 官网：[https://capture2text.sourceforge.net/](https://capture2text.sourceforge.net/)



## Adobe Acrobat Pro（付费，商用 PDF OCR）

**Adobe Acrobat Pro** 提供非常精准的 PDF OCR 识别功能，支持中文识别、图片优化、批量处理等高级功能，适合有高质量文字识别需求的专业用户。

- 支持平台：Windows / macOS
- 安装方式：Adobe 官网下载安装，需订阅授权
- 官网：[https://www.adobe.com/acrobat/](https://www.adobe.com/acrobat/)



## Google Docs OCR（免费，基于云端）

Google 云端硬盘内置 OCR 功能。你只需上传图片或 PDF，在 Google Docs 中打开，即可自动识别出文字。无需安装任何软件，识别效果在英文和印刷体文档中非常出色。

- 支持平台：网页浏览器
- 使用方式：上传文件到 Google Drive → 右键 → 使用 Google Docs 打开
- 官网：[https://docs.google.com](https://docs.google.com)



## pytesseract（Python 开发者专用）

**`pytesseract`** 是对 Google Tesseract OCR 引擎的 Python 封装，可以轻松将图像转换为文本。Tesseract + pytesseract 可以说是 Python 中使用最广泛的 OCR 组合，具有免费开源、支持多语言、可结合 PDF 和图像批处理使用等优点。

安装方式（同时你需要安装系统级的 Tesseract）：

```bash
pip install pytesseract
```

示例代码：

```python
import pytesseract
from PIL import Image

img = Image.open('test.png')
text = pytesseract.image_to_string(img, lang='eng')  # 支持多语言
print(text)
```

网址：[https://github.com/madmaze/pytesseract](https://github.com/madmaze/pytesseract)



## **EasyOCR**（简单易用，支持中文）

EasyOCR 是一个基于 PyTorch 的开源 OCR 库，支持 80+ 种语言，包括中文、日文、韩文等，安装后无需额外配置语言包。具有准确度高、安装即用、支持 GPU 加速等优点。

安装方式：

```bash
pip install easyocr
```

示例代码：

```python
import easyocr

reader = easyocr.Reader(['ch_sim', 'en'])  # 中文简体和英文
results = reader.readtext('test.jpg')
for res in results:
    print(res[1])  # 打印识别出的文本
```

网址：[https://github.com/JaidedAI/EasyOCR](https://github.com/JaidedAI/EasyOCR)



## PaddleOCR（中文识别最强）

PaddleOCR 是百度开源的 OCR 工具，特别优化了中文文字、表格、方向识别等任务。具有识别准确率高、支持批量处理、支持模型训练等优点。

安装方式：

```bash
pip install paddleocr
pip install paddlepaddle
```

网址：[https://github.com/PaddlePaddle/PaddleOCR](https://github.com/PaddlePaddle/PaddleOCR)



## Keras-OCR（适合训练自定义模型）

Keras-OCR 提供了一个端到端的 OCR 管道，包括文字检测和识别，适合有深度学习背景的开发者自定义训练或批量识别场景。

安装方式：

```bash
pip install keras-ocr
```

网址：[https://github.com/faustomorales/keras-ocr](https://github.com/faustomorales/keras-ocr)



## 白描 App

**白描**是一款专注于高效文字识别与 PDF 转换的国产 OCR 工具，特别适合学生、教师、写作者和办公人群使用。它的设计简洁、识别速度快、准确率高，支持多种导出方式和语言识别，深受用户好评。

白描 App 的基础功能是免费的，包含文字识别、导出、翻译等。批量识别、无限识别次数、表格识别、去广告等功能则需要收费（订阅制），价格相对合理，适合频繁使用 OCR 的用户。

支持平台：

- **移动端**：iOS 和 Android 均可使用
- **网页端**：[https://web.baimiaoapp.com](https://web.baimiaoapp.com)
- **微信小程序**：直接搜索“白描 OCR”即可使用
