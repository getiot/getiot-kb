---
sidebar_label: cwebp 命令
sidebar_position: 6
slug: /cwebp
---

# cwebp 命令



## 介绍

**cwebp**（英文全拼：compress WebP）命令用于将 JPEG、PNG 或 TIFF 格式的图片编码成 WebP 格式。

WebP 格式是谷歌在 2010 年推出的新一代图片格式，旨在加快图片加载速度。图片压缩体积大约只有 JPEG 的2/3，能节省大量的服务器宽带资源和数据空间。WebP 既支持有损压缩也支持无损压缩，相较编码 JPEG 文件，编码同样质量的 WebP 文件需要占用更多的计算资源。

cwebp 命令由 webp 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install webp
```

相关命令：[dwebp](/linux-command/dwebp)

**语法**：

```bash
cwebp [options] input_file -o output_file.webp
```

**选项**：

- `-h`, `-help` ：显示帮助信息（简单版）。
- `-H`, `-longhelp` ：显示帮助信息（详细版）。
- `-q <float>` ：品质参数（0：最小，100：最优），缺省值为 75。
- `-alpha_q <int>` ：为 alpha 压缩指定一个 0 到 100 的数值。alpha 无损压缩用 100，小于 100 将产生有损压缩。默认值100。
- `-preset <string>` ：指定一组预定义的值用来区分不同的文件材料。可能的值有 default、photo、picture、drawing、icon、text。由于 -preset 覆盖其他参数的值（除了 -q），这个值最好出现在所有参数最前面。
- `-z <int>` ：切换无损压缩模式级别从 0 到 9，0 最快，9 最慢。速度越快文件越大。比较好的默认值是 6。这个参数是一个预定义压缩质量快捷阐述。如果参数 -q 或者 -m 被随后用到，这个 -z 就无效了。
- `-m <int>` ：制定压缩模式。这个参数控制了编码的速度，压缩文件大小，质量。值范围为 0 到 6，默认 4。值越大，花费时间越大用来检查额外的编码能力和质量。小的值会产生快的压缩速度，大的文件和低的压缩质量。
- `-segments <int>` ：更改在 sns 算法分段期间要使用的分区数。段的范围应为 1 到 4，默认值为 4。除非使用 -low_memory，否则此选项对方法 3 及更高版本无效。
- `-size <int>` ：为输出文件指定一个目标大小（单位 bytes），压缩器将多次压缩以接近这个目标。如果 -size 和 -psnr 同时使用, 那么 -size 优先。
- `-psnr <float>` ：指定目标 PSNR（以 dB 为单位）以尝试达到压缩输出。 压缩程序将通过几次部分编码，以便尽可能接近此目标。 如果同时使用 -size 和 -psnr，则以 -size 值为准。
- `-s <int> <int>` ：YUV 的输入大小（宽 x 高）。
- `-sns <int>` ：指定空间噪声整形的幅度（0：off，100：最大），缺省值为 50。
- `-f <int>` ：指定解过滤器的强度（0：off，100：最大），缺省值为 60。
- `-sharpness <int>` ：指定过滤的清晰度（0：最清晰，7：最不清晰），缺省值为 0。
- `-strong` ：使用强过滤替代简单过滤（默认开启强过滤）。
- `-nostrong` ：禁用强过滤，使用简单过滤。
- `-sharp_yuv` ：如果需要，请使用更准确，更清晰的 RGB-> YUV 转换。 请注意，此过程比默认的“快速” RGB-> YUV 转换要慢。
- `-partition_limit <int>` ：限制质量以适应第一个分区的 512k 限制（0：无降级，100：完全降级），缺省值为 0。
- `-pass <int>` ：设置选项 -size 或 -psnr 程序执行期间要使用的最大通过次数。参数范围 1 到 10，默认值为 1。如果使用选项 -size 或 -psnr，但未指定 -pass，则将使用默认值 6。
- `-crop <x> <y> <w> <h>` ：从左边顶部的点开始 (x_position, y_position) 计算来裁切图片。裁切区域必须在原文件图片区域内。
- `-resize <w> <h>` ：调整源文件的宽高。如果任意一个宽或者高的参数为 0，那么将按比例计算。
- `-mt` ：如果支持，采用多线程编码。
- `-low_memory` ：通过节省四倍于压缩大小（通常）来减少有损编码的内存使用。 这将使编码变慢，并且输出的大小和失真会稍有不同。 
- `-map <int>` ：输出额外的 ASCII 映射编码信息。 可能的映射值范围是1到6。这仅是为了帮助调试。
- `-print_psnr` ：计算并报告平均 PSNR（峰值信噪比）。
- `-print_ssim` ：计算并报告平均 SSIM（结构相似性指标）。
- `-print_lsim` ：计算并报告局部相似性度量（像素邻居中的最低误差之和）。
- `-d <file.pgm>` ：转储压缩的输出（PGM 文件）。
- `-alpha_method <int>` ：指定用于 alpha 压缩的算法：0 或 1。算法 0 表示无压缩，1 使用 WebP 无损格式进行压缩。 预设值为 1。
- `-alpha_filter <string>` ：指定 Alpha 平面的预测过滤方法。有效值：none、fast、best，默认为 fast。
- `-exact` ：将 RGB 值保留在透明区域中。默认为关闭，以帮助压缩。
- `-blend_alpha <hex>` ：将颜色与以十六进制写入的 RGB 值表示的背景颜色混合，例如 0xc0e0d0 代表红色=0xc0，绿色=0xe0，蓝色=0xd0。
- `-noalpha` ：使用此选项将丢弃 Alpha 通道。
- `-lossless` ：无损编码图片处理。意味着整个图片，包含透明区域、看不见的像素值（R/G/B 或 Y/U/V）都会被保存。
- `-near_lossless <int>` ：指定无损压缩级别对图片处理预处理（0..100=off），缺省值为 100。这个参数用来调整像素帮助图片的可压缩性，但是尽可能减少图片可见区域质量。
- `-hint <string>` ：指定有关输入图像类型的提示。可能的值为：photo、picture 或 graph。
- `-metadata <string>` ：逗号分隔的元数据列表，如果存在，则从输入复制到输出。有效值：all、none、exif、icc、xmp。默认为 none。
- `-short` ：仅出于测试目的打印简要信息（输出文件大小和 PSNR）。
- `-quiet` ：安静模式（不打印任何东西）。
- `-version` ：打印版本信息并退出。
- `-noasm` ：禁用所有装配优化。
- `-v` ：打印更多信息（特别是编码时间）。
- `-progress` ：报告编码进度（百分比）。



## 示例

```bash
cwebp -q 80 image.png -o image.webp
```



