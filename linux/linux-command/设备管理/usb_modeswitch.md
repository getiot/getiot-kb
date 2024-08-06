---
sidebar_position: 24
slug: /usb_modeswitch
---

# usb_modeswitch 命令



## 介绍

**usb_modeswitch** 命令用于控制“多状态” USB 设备的模式，它基于 libusb1/libusbx 库开发。

**语法**：

```bash
usb_modeswitch [<params>] [-c filename]
```

**选项**：

- `-h`, `--help`：显示帮助信息。
- `-e`, `--version`：打印版本信息并退出。
- `-j`, `--find-mbim`：返回带 MBIM 接口的配置号（config no.）。
- `-v`, `--default-vendor NUM`：原始模式的供应商 ID（必填）。
- `-p`, `--default-product NUM`：原始模式的产品 ID（必填）。
- `-V`, `--target-vendor NUM`：目标模式供应商 ID（可选）。
- `-P`, `--target-product NUM`：目标模式产品 ID（可选）。
- `-C`, `--target-class NUM`：目标模式设备类（可选）。
- `-b`, `--bus-num NUM`：设备的系统总线号（用于硬 ID）。
- `-g`, `--device-num NUM`：系统设备号（用于硬 ID）。
- `-m`, `--message-endpoint NUM`：将消息传输定向到那里（可选）。
- `-M`, `--message-content <msg>`：要发送的消息（十六进制数字作为字符串）。
- `-2`, `--message-content2 <msg>`：要发送的附加消息（推荐 -n）。
- `-3`, `--message-content3 <msg>`：要发送的附加消息（推荐 -n）。
- `-w`, `--release-delay NUM`：在释放接口之前等待 NUM 毫秒。
- `-n`, `--need-response`：已过时，无效（始终开启）。
- `-r`, `--response-endpoint NUM`：从那里读取响应（可选）。
- `-K`, `--std-eject`：发送标准 EJECT 序列。
- `-d`, `--detach-only`：分离活动驱动程序，无进一步操作。
- `-H`, `--huawei-mode`：应用一个特殊的程序。
- `-J`, `--huawei-new-mode`：应用一个特殊的程序。
- `-X`, `--huawei-alt-mode`：应用一个特殊的程序。
- `-S`, `--sierra-mode`：应用一个特殊的程序。
- `-O`, `--sony-mode`：应用一个特殊的程序。
- `-G`, `--gct-mode`：应用一个特殊的程序。
- `-N`, `--sequans-mode`：应用一个特殊的程序。
- `-A`, `--mobileaction-mode`：应用一个特殊的程序。
- `-T`, `--kobil-mode`：应用一个特殊的程序。
- `-L`, `--cisco-mode`：应用一个特殊的程序。
- `-B`, `--qisda-mode`：应用一个特殊的程序。
- `-E`, `--quanta-mode`：应用一个特殊的程序。
- `-F`, `--pantech-mode NUM`：应用一个特殊的程序，需要传入 NUM 参数。
- `-Z`, `--blackberry-mode`：应用一个特殊的程序。
- `-U`, `--option-mode`：应用一个特殊的程序。
- `-R`, `--reset-usb`：在所有其他操作后重置设备。
- `-Q`, `--quiet`：不显示进度或错误消息。
- `-W`, `--verbose`：打印所有设置和调试输出。
- `-D`, `--sysmode`：具体结果和系统日志消息。
- `-s`, `--check-success <seconds>`：带超时的切换结果检查。
- `-I`, `--inquire`：已过时，没有影响。
- `-c`, `--config-file <filename>`：从文件加载长配置。
- `-t`, `--stdinput`：从标准输入读取长配置。
- `-f`, `--long-config <text>`：从字符串中获取长配置。
- `-i`, `--interface NUM`：选择初始 USB 接口（默认 0）。
- `-u`, `--configuration NUM`：选择 USB 配置。
- `-a`, `--altsetting NUM`：选择备用 USB 接口设置。



## 示例

执行 `lsusb` 扫描 USB 设备，查看目标设备的信息，如：

```bash
Bus 003 Device 006: ID 0bda:1a2b Realtek Semiconductor Corp. DISK
```

操作设备：

```bash
sudo usb_modeswitch -KW -v 0bda -p 1a2b
```

