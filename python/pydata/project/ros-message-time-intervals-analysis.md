---
sidebar_position: 2
slug: /ros-message-time-intervals-analysis
---

# ROS 消息时间间隔抖动分析



[ROS](/ros/ros-intro/) 是一个分布式机器人操作系统软件框架，节点之间通过松耦合的方式进行组合，包括使用 Topic、RPC 服务和参数服务器等方式进行通信。其中，Topic 是最常见的一种通信方式，例如一个雷达传感器节点实时采集三维点云数据，通过 Topic 发布到 ROS 系统，而 ROS 系统中的其他节点（如 Rviz）可以订阅这个 Topic，接收来自雷达的点云数据，将其显示出来。



## 案例背景

在使用 Rviz 显示雷达点云数据的过程中，我们发现 Rviz2 的三维视窗周期性地出现卡顿。数据由雷达驱动节点发布，Rviz2 节点订阅，我们想要知道卡顿的具体情况，进一步分析卡顿是由于发布端慢了还是订阅端慢了导致的，因此需要对数据进行分析。

每一个 ROS 消息都带有时间戳信息（字段名为 `stamp`），在 ROS2 中，可以通过 `ros2 topic echo` 命令打印指定 Topic 的信息。假设雷达的 Topic 为 `/lidar_topic`，通过下面命令即可过滤出每一条消息的时间戳信息。

```bash
ros2 topic echo /lidar_topic | grep -w -A 2 "stamp"
```

打印内容如下所示，ROS 消息的时间戳包括秒和纳秒两部分。

```bash
  stamp:
    sec: 1702388539
    nanosec: 988327026
--
  stamp:
    sec: 1702388540
    nanosec: 107672930
--
  stamp:
    sec: 1702388540
    nanosec: 226908922
--
  stamp:
    sec: 1702388540
    nanosec: 346390963
--
```

为了采集足够多的数据，我们将输出的内容写入到文件中，以便后续处理。

```bash
ros2 topic echo /lidar_topic | grep -w -A 2 "stamp" > ts-data.txt
```

作为对比，我们关闭 Rviz2，只启动雷达驱动节点，再采集一组数据。

```bash
ros2 topic echo /lidar_topic | grep -w -A 2 "stamp" > ts-data-quiet.txt
```



## 分析数据

新建一个终端，执行 `jupyter-notebook` 命令，打开 Jupyter Notebook 浏览器界面。然后点击 “新建”，选择 Python3，开始编写 Python 代码。

程序的流程大致如下：

1. 读取文件内容，并将其中的 sec 和 nanosec 字段信息重新组合成一个完整的 timestamp 时间戳，保存到列表 timestamps 中（这里保存 800 组数据）。
2. 将时间戳两两相减，得到时间间隔信息，保存到列表 time_intervals 中。
3. 从 time_intervals 列表计算时间间隔的均值、中值、最大值、最小值等指标，可用于衡量抖动情况。
4. 以时间间隔大小为纵轴，绘制图表，可直观看出抖动情况。

下面是完整代码，这里使用 matplotlib 库绘制图表，因此首先需要引入相关 Python 库。

```python showLineNumbers title="ROS-Message-Time-Intervals.py"
import matplotlib.pyplot as plt
from datetime import datetime
from matplotlib.font_manager import FontProperties

# 设置中文显示
font = FontProperties(fname='/usr/share/fonts/truetype/wqy/wqy-zenhei.ttc')

file_path = 'ts-data.txt'
timestamps = []

with open(file_path, 'r') as file:
    lines = file.readlines()
    for i in range(len(lines) - 1):  # 避免越界
        if 'sec' in lines[i] and 'nanosec' in lines[i + 1]:
            sec = int(lines[i].split(':')[-1].strip())
            nanosec = int(lines[i + 1].split(':')[-1].strip())
            timestamp = sec + nanosec * 1e-9
            timestamps.append(timestamp)
            if (len(timestamps) > 800):
                break

time_intervals = [timestamps[i + 1] - timestamps[i] for i in range(len(timestamps) - 1)]

mean_interval = sum(time_intervals) / len(time_intervals)
median_interval = sorted(time_intervals)[len(time_intervals) // 2]
max_interval = max(time_intervals)
min_interval = min(time_intervals)

print(f"均值: {mean_interval} 秒")
print(f"中值: {median_interval} 秒")
print(f"最大值: {max_interval} 秒")
print(f"最小值: {min_interval} 秒")

# 绘制时间间隔的图表
plt.figure(figsize=(10, 6))
plt.plot(time_intervals, marker='o', linestyle='-', color='b')
plt.title('ROS Message Time Intervals (with Rviz)')
plt.xlabel('index')
plt.ylabel('interval (s)')
plt.grid(True)
plt.show()
```



:::tip

代码和数据可在 [GitHub](https://github.com/luhuadong/python-data-demos/tree/main/project/ROS-Message) 仓库下载，你也可以参考该示例程序分析其他类似的数据。

:::



## 输出结果

在 Jupyter Notebook 中点击 *Run* 执行代码，可以看到如下输入：

```bash
均值: 0.1342798188328743 秒
中值: 0.11950397491455078 秒
最大值: 0.7162301540374756 秒
最小值: 0.11851811408996582 秒
```

时间间隔分布情况如下：

![](https://static.getiot.tech/ros-message-time-intervals-analysis-result-01.png#center)

将上述 ROS-Message-Time-Intervals.py 程序中的第8行修改为 ts-data-quiet.txt，第37行修改为 `plt.title('ROS Message Time Intervals (no Rviz)')`，再次点击 *Run* 重新执行程序。可以看到如下输出：

```bash
均值: 0.12153411984443664 秒
中值: 0.1189870834350586 秒
最大值: 0.8321161270141602 秒
最小值: 0.11800003051757812 秒
```

时间间隔分布情况如下：

![](https://static.getiot.tech/ros-message-time-intervals-analysis-result-02.png#center)

可以看到，在不启动 Rviz2 的情况下，时间间隔抖动情况有明显改善。



## 分析结果

结合上述两次测试结果，可以发现时间间隔抖动有一定的规律 —— 呈现一定的倍率关系，即多有突出的时间抖动，都是正常水平的整数倍。

因此，我们可以得出初步的结论：造成该现象（Rviz2 的画面出现卡顿）的原因是由于丢帧导致的。接下来就可以深入分析 ROS 系统发生丢帧的原因。
