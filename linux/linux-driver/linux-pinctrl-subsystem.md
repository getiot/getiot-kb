---
sidebar_position: 5
---

# Linux pinctrl 子系统

SoC 引脚往往**复用**：同一 PAD 可当 UART、I2C 或普通 GPIO。pinctrl（pin controller）子系统负责：

- **复用（mux）**：选功能  
- **配置（config）**：上下拉、驱动强度、输出电平、是否开漏等  

板级驱动工程师一般通过**设备树**描述需要哪些状态；具体 pin controller 驱动多由芯片原厂 BSP 提供。有了 pinctrl 后，外设驱动通常不必再手写寄存器去切复用。

## Client 与 Controller

pinctrl 采用典型的 **service / client** 模型：

| 角色 | 含义 |
| --- | --- |
| pin controller（service） | 提供引脚组、功能与配置节点 |
| 设备节点（client） | 通过 `pinctrl-names` / `pinctrl-N` 引用这些状态 |

要点：

1. **只在 controller 里写、没有任何 client 引用**，通常不会真正改硬件。真正生效是在 client 绑定并选择 state 时。  
2. 平台设备在匹配并 probe 前，内核常会自动选中 **`default`** state；`suspend` / `resume` 里可切到 `sleep` 等状态（由驱动或 PM 路径触发）。  

## 设备树：client 写法（相对统一）

```c showLineNumbers
device {
    pinctrl-names = "default", "sleep";
    pinctrl-0 = <&state_0_node_a>;   /* 对应 "default" */
    pinctrl-1 = <&state_1_node_a>;   /* 对应 "sleep" */
};
```

- `pinctrl-names`：状态名列表  
- `pinctrl-0`、`pinctrl-1`、…：与 names 下标一一对应，值为 controller 侧子节点的 phandle（可多个）  

## 设备树：controller 侧概念

Controller 节点写法**因 SoC 而异**（有的用 `function`/`groups`，有的用厂商属性如 `fsl,pins`、`rockchip,pins`），但概念类似：

### 复用节点（pin multiplexing）

把一组引脚复用到某功能，例如 UART 与 GPIO 切换：

```c showLineNumbers
pincontroller {
    state_0_node_a: state-0 {
        function = "uart0";
        groups = "u0rxtx", "u0rtscts";
    };
    state_1_node_a: state-1 {
        function = "gpio";
        groups = "u0rxtx", "u0rtscts";
    };
};
```

### 配置节点（pin configuration）

在已选功能（或 GPIO）上配置电气特性，例如休眠时输出高：

```c showLineNumbers
pincontroller {
    state_0_node_a: state-0 {
        function = "uart0";
        groups = "u0rxtx", "u0rtscts";
    };
    state_1_node_a: state-1 {
        groups = "u0rxtx", "u0rtscts";
        output-high;
    };
};
```

一个 client 可有多个 state；每个 state 可引用一个或多个子节点（复用、配置，或厂商自定义组合）。

## 厂商示例（示意）

### i.MX（fsl,pins）

```c showLineNumbers
&uart1 {
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_uart1>;
    status = "okay";
};

pinctrl_uart1: uart1grp {
    fsl,pins = <
        MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX 0x1b0b1
        MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX 0x1b0b1
    >;
};
```

宏同时表达「哪个 PAD + 复用到什么功能」；后面的数值是 PAD 控制寄存器配置（上下拉、速度等），以 SoC 手册与 binding 为准。

### Rockchip

```c showLineNumbers
&uart0 {
    pinctrl-names = "default";
    pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
    status = "okay";
};

uart0_xfer: uart0-xfer {
    rockchip,pins = <UART0BT_SIN>, <UART0BT_SOUT>;
    rockchip,pull = <VALUE_PULL_DISABLE>;
    rockchip,drive = <VALUE_DRV_DEFAULT>;
};
```

一个 `pinctrl-N` 可引用多个节点，分别描述不同引脚组。

### 一个设备多个 GPIO / 多状态

```c showLineNumbers
pcie0: pcie@... {
    compatible = "qcom,pci-msm";
    pinctrl-names = "default", "sleep";
    pinctrl-0 = <&pcie0_clkreq_default
                 &pcie0_perst_default
                 &pcie0_wake_default>;
    pinctrl-1 = <&pcie0_clkreq_sleep
                 &pcie0_perst_default
                 &pcie0_wake_default>;
};
```

同一组脚在 active / suspend 下功能不同时（例如 Wi-Fi 工作态为专用功能、休眠改为 GPIO），在 controller 里为两种 function 各写一套节点，再由 client 的不同 `pinctrl-N` 引用即可。

## 驱动里要不要手写 pinctrl？

对多数外设驱动工程师，pinctrl **几乎透明**：

- 设备与驱动匹配后，在 `probe` 之前内核会走 `pinctrl_bind_pins` 一类路径，选中 `default`  
- 睡眠 / 唤醒时按 `pinctrl-names` 切换 state  

只有需要运行时主动切换（例如中间态、特殊电源策略）时，才在驱动里用 `devm_pinctrl_get()`、`pinctrl_lookup_state()`、`pinctrl_select_state()` 等 API。

简化调用链（示意）：

```bash
driver_probe_device
  └─ really_probe
       ├─ pinctrl_bind_pins   ← 绑定并选 default
       └─ drv->probe(dev)
```

## 小结

- pinctrl 管引脚复用与电气配置；DT 里用 client 引用 controller 定义的 state  
- client 属性写法统一；controller 属性看各 SoC binding  
- 日常驱动写好 `pinctrl-names` / `pinctrl-N` 即可，少在代码里硬切复用  

