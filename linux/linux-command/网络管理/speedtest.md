---
sidebar_position: 18
slug: /speedtest
---

# speedtest 命令



## 介绍

**speedtest** 是一个测试网络速度的命令行工具，可在本地测量 Internet 连接性能指标，例如下载、上传、延迟和数据包丢失等，无需依赖 Web 浏览器。

speedtest 命令由 [speedtest-cli](https://github.com/sivel/speedtest-cli) 软件包提供，使用 Python 语言编写，因此你可以使用 pip 进行安装，在 Debian/Ubuntu 系统上也可以使用 apt 进行安装。

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="apt" label="Ubuntu" default>
    ```bash
    sudo apt install speedtest-cli
    ```
  </TabItem>
  <TabItem value="pip" label="Python">
    ```bash
    pip install speedtest-cli
    ```
  </TabItem>
</Tabs>



**语法**：

```bash
speedtest [OPTION]
```

**选项**：

- `--no-download`：不进行下载测试。
- `--no-upload`：不执行上传测试。
- `--single`：仅使用单个连接而不是多个连接（模拟了典型的文件传输）。
- `--bytes`：以字节而不是位显示值。不影响 `--share` 生成的图像，也不影响 `--json` 或 `--csv` 的输出。
- `--share`：在 speedtest.net 网站上生成网速测试结果的图片并提供 URL，使用 `--csv` 选项时不显示。
- `--simple`：抑制详细输出，仅显示基本信息。
- `--csv`：抑制详细输出，仅以 CSV 格式显示基本信息。速度以位/秒为单位列出，不受 `--bytes` 影响。
- `--csv-delimiter CSV_DELIMITER`：在 CSV 输出中使用的单字符分隔符。 默认是逗号 “,”。
- `--csv-header`：打印 CSV 标题。
- `--json`：抑制详细输出，仅以 JSON 格式显示基本信息。速度以位/秒为单位列出，不受 `--bytes` 影响。
- `--list`：根据距离排序显示 speedtest.net 的测试服务器列表。
- `--server SERVER`：指定列表中的服务器 ID 作为测试服务器。
- `--exclude EXCLUDE`：从选择中排除服务器。
- `--mini MINI`：Speedtest Mini 服务器的 URL。
- `--source SOURCE`：绑定的源 IP 地址。
- `--timeout TIMEOUT`：HTTP 超时（以秒为单位），默认为 10 秒。
- `--secure`：与 speedtest.net 运营的服务器通信时，使用 HTTPS 而不是 HTTP。
- `--no-pre-allocate`：不要预先分配上传数据，默认情况下启用预分配以提高上传性能。如果要支持内存不足的系统，请使用此选项以避免 MemoryError。
- `--version`：显示版本信息并退出。
- `-h, --help`：显示帮助信息并退出。



## 示例

直接执行 **`speedtest`** 命令使用默认参数测试，稍等片刻即可看到结果：

```bash
$ speedtest
Retrieving speedtest.net configuration...
Testing from China Telecom (61.144.49.139)...
Retrieving speedtest.net server list...
Selecting best server based on ping...
Hosted by HKBN (Hong Kong) [134.49 km]: 76.016 ms
Testing download speed................................................................................
Download: 11.15 Mbit/s
Testing upload speed......................................................................................................
Upload: 109.55 Mbit/s
```

列出所有测试服务器：

```bash
$ speedtest --list
Retrieving speedtest.net configuration...
33250) CTM Broadband (Macau, Macau) [106.48 km]
37639) CMHK Broadband (Hong Kong, Hong Kong) [129.25 km]
28912) fdcservers.net (Hong Kong, Hong Kong) [134.49 km]
59303) HKBN (Hong Kong, Hong Kong) [134.49 km]
60177) Club SIM by HKT (Hong Kong, Hong Kong) [134.49 km]
61296) HKIX (Hong Kong, Hong Kong) [134.49 km]
11711) Taiwan Mobile (Tainan, Taiwan) [709.09 km]
40728) SEEDNET (Tainan, Taiwan) [709.09 km]
32319) TNIC (Tainan, Taiwan) [713.48 km]
18458) Chunghwa Mobile (Kaohsiung, Taiwan) [720.41 km]
```

指定测试服务器 ID（37639），并生成网速测试结果的图片：

```bash
$ speedtest-cli --server=37639 --share
Retrieving speedtest.net configuration...
Testing from China Telecom (61.144.49.139)...
Retrieving speedtest.net server list...
Retrieving information for the selected server...
Hosted by CMHK Broadband (Hong Kong) [129.25 km]: 308.478 ms
Testing download speed................................................................................
Download: 1.46 Mbit/s
Testing upload speed......................................................................................................
Upload: 2.77 Mbit/s
Share results: http://www.speedtest.net/result/15645788944.png
```

网速测试结果图片如下：

![](https://static.getiot.tech/speedtest-20231218.png#center)
