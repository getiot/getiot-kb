---
sidebar_position: 6
---

# 蓝牙协议栈 pygatt



[pygatt](https://github.com/peplin/pygatt) 是一个用于读写蓝牙设备的 GATT 描述符的 Python 模块，可用于任何符合标准 GATT 描述符行为的设备，例如健身追踪器、传感器等等。

pygatt 支持两种不同后端并提供了 Pythonic API：

- BlueZ (requires Linux), using the `gatttool` command-line utility.
- Bluegiga's BGAPI, compatible with USB adapters like the BLED112.

我们在 Linux 上进行测试，因此选择使用 gatttool 后端即可。



## 安装

```shell
$ pip install pygatt
```



## API

这里主要介绍几个常用的读写 characteristic 的接口函数。

### char_read

功能：通过 UUID 读取一个特征值

```python
char_read(uuid, *args, **kwargs) method of pygatt.backends.gatttool.device.GATTToolBLEDevice instance
    Reads a Characteristic by UUID.
    
    uuid -- UUID of Characteristic to read as a string.
    
    Returns a bytearray containing the characteristic value on success.
    
    Example:
        my_ble_device.char_read('a1e8f5b1-696b-4e4c-87c6-69dfe0b0093b')
```

### char_read_handle

功能：通过 handle 读取一个特征值

```python
char_read_handle(handle, *args, **kwargs) method of pygatt.backends.gatttool.device.GATTToolBLEDevice instance
    Reads a Characteristic by handle.
    
    handle -- handle of Characteristic to read.
    
    Returns a bytearray containing the characteristic value on success.
    
    Example:
        my_ble_device.char_read_handle(5)
```

### char_write

功能：通过 UUID 找到特征值，并写入 value

```python
char_write(uuid, value, wait_for_response=True) method of pygatt.backends.gatttool.device.GATTToolBLEDevice instance
    Writes a value to a given characteristic UUID.
    
    uuid -- the UUID of the characteristic to write to.
    value -- a bytearray to write to the characteristic.
    wait_for_response -- wait for response after writing. A GATT "command"
        is used when not waiting for a response. The remote host will not
        acknowledge the write.
    
    Example:
        my_ble_device.char_write('a1e8f5b1-696b-4e4c-87c6-69dfe0b0093b',
                                 bytearray([0x00, 0xFF]))
```

### char_write_handle

功能：通过 handle 找到特征值，并写入 value

```python
char_write_handle(handle, *args, **kwargs) method of pygatt.backends.gatttool.device.GATTToolBLEDevice instance
    Writes a value to a given characteristic handle. This can be used to
    write to the characteristic config handle for a primary characteristic.
    
    hande -- the handle to write to.
    value -- a bytearray to write to the characteristic.
    wait_for_response -- wait for response after writing.
    
    Example:
        my_ble_device.char_write_handle(42, bytearray([0x00, 0xFF]))
```



## 示例代码

针对 Thunderboard，我们要完成以下任务：

- 通过蓝牙读取开发板上的温度传感器数值；
- 当温度超过一定门槛后，再通过蓝牙控制开发板上的 LED 灯点亮以作报警。

实际上就变得很简单了！前面《[BlueZ gatttool 操作 Thunderboard 蓝牙开发板](https://luhuadong.blog.csdn.net/article/details/112307074)》已经知道了 Thunderboard 的地址、温度传感器和 LED IO 特征值的 UUID 和 handle。

```python showLineNumbers
import time
import pygatt

adapter = pygatt.GATTToolBackend()
counter = 10
threshold = 25

try:
    adapter.start()
    device = adapter.connect('60:A4:23:C9:69:9C')

    while counter > 0:
        value = device.char_read("00002a6e-0000-1000-8000-00805f9b34fb")
        temp = (value[1] * 256 + value[0]) / 100
        print("[{:0>2d}] temp: {:.2f} 'C".format(counter, temp))

        if temp > threshold:
            device.char_write_handle(0x0022, bytearray([0x01]))  # LED on
        else:
            device.char_write_handle(0x0022, bytearray([0x00]))  # LED off

        time.sleep(1)
        counter -= 1

finally:
    print("end")
    adapter.stop()
```

这里设置了温度阈值为 25 ℃。运行程序，你将会可以看到：当温度超过 25 ℃ 时，Thunderboard 板载的 LED 灯就会亮起；当温度降到 25 ℃ 以下，LED 等就会熄灭。