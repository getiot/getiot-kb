---
sidebar_position: 5
sidebar_label: URDF 格式
slug: /urdf
---

# URDF 格式文件（机器人）

**URDF**（Unified Robot Description Format，统一机器人描述格式）是 ROS 生态中广泛使用的 **XML 文本格式**，用于描述机器人的 **连杆（link）**、**关节（joint）** 以及各连杆上的 **惯性、视觉与碰撞几何**。URDF 本身不存储三角网格本体，常通过引用外部 **STL、DAE、OBJ** 等网格文件来描述外形；仿真与运动学工具可据此构建运动链、碰撞检测与可视化。



## 格式简介

URDF 用一棵以 **关节** 连接的 **连杆树** 描述机器人拓扑（不支持闭链机构；闭链常需 SRDF、额外约束或改用 **SDFormat / USD** 等格式配合）。每个连杆可包含惯性参数、视觉模型与碰撞模型；关节则声明父子连杆、坐标变换与运动类型（旋转、平移、固定等）。

URDF 文件扩展名通常为 `.urdf`，也可与 **Xacro**（`.xacro`）配合：先用宏与参数生成完整 URDF 再供程序读取。内容本质为 XML，常见以 `text/xml` 或 `application/xml` 传输。



## 技术特点

### 核心特性

- **XML 文本**：人类可读，易于版本管理与 diff
- **运动链模型**：`link` + `joint` 描述父子关系与运动学
- **视觉 / 碰撞 / 惯性分离**：便于仿真与显示解耦
- **外部网格引用**：`mesh` 几何体可指向 STL、DAE 等文件
- **ROS 工具链成熟**：`check_urdf`、`urdf_parser_py`、RViz 等支持广泛

### 格式限制

- **仅开链树**：标准 URDF 难以表达并联机构、差动轮闭链等（需扩展或别的格式）
- **无统一世界坐标语义**：依赖各工具对根连杆、固定关节的约定
- **网格与材质路径**：相对路径解析依赖运行工作目录与包路径
- **表达能力有限**：传感器、传动、Gazebo 插件等常通过 **SDF 插件块** 或 **xacro 宏** 扩展

### URDF 与 Xacro

- **URDF**：最终给解析器使用的「展开后」描述
- **Xacro**：带宏、属性、数学表达式的模板，构建时展开为 URDF，减少重复与硬编码



## 文件结构

### 顶层与连杆

```xml showLineNumbers
<?xml version="1.0"?>
<robot name="example_robot">
  <link name="base_link">
    <inertial>
      <origin xyz="0 0 0" rpy="0 0 0"/>
      <mass value="1.0"/>
      <inertia ixx="0.01" ixy="0" ixz="0" iyy="0.01" iyz="0" izz="0.01"/>
    </inertial>
    <visual>
      <origin xyz="0 0 0" rpy="0 0 0"/>
      <geometry>
        <box size="0.2 0.2 0.1"/>
      </geometry>
    </visual>
    <collision>
      <origin xyz="0 0 0" rpy="0 0 0"/>
      <geometry>
        <box size="0.2 0.2 0.1"/>
      </geometry>
    </collision>
  </link>
  <!-- 更多 link ... -->
</robot>
```

### 关节

```xml showLineNumbers
<joint name="joint1" type="revolute">
  <parent link="base_link"/>
  <child link="link1"/>
  <origin xyz="0 0 0.1" rpy="0 0 0"/>
  <axis xyz="0 0 1"/>
  <limit lower="-3.14" upper="3.14" effort="10" velocity="5"/>
</joint>
```

常见 `joint` 的 `type` 包括：`fixed`、`revolute`、`continuous`、`prismatic`、`floating`、`planar` 等（各解析器对子集支持略有差异，以所用仿真器文档为准）。



## 使用场景

### 适用场景

- **ROS / ROS 2 机器人**：MoveIt、导航、TF 树与可视化
- **仿真导入**：Gazebo、Webots 等经转换或插件加载
- **数字孪生与标定**：运动学、碰撞体与质心参数管理
- **文档与协作**：与版本库一起维护机构描述

### 优缺点

**优点：**

- 文本格式，易于审阅与合并请求
- 与 ROS 工具链集成度高
- 视觉 / 碰撞 / 惯性分离清晰
- 可与 Xacro 组合降低维护成本

**缺点：**

- 不擅长闭链与复杂装配约束
- 大型网格全路径管理易出错
- 跨工具时需留意单位（米、弧度）与轴约定



## 代码示例

### Python 解析 URDF（标准库）

```python showLineNumbers
import xml.etree.ElementTree as ET

tree = ET.parse("robot.urdf")
root = tree.getroot()

assert root.tag == "robot"
print("robot name:", root.attrib.get("name"))

for link in root.findall("link"):
    print("link:", link.attrib.get("name"))

for joint in root.findall("joint"):
    name = joint.attrib.get("name")
    jtype = joint.attrib.get("type")
    parent = joint.find("parent").attrib.get("link")
    child = joint.find("child").attrib.get("link")
    print(f"joint: {name} ({jtype}) {parent} -> {child}")
```

### 使用 urdfpy 读取（需安装 `urdfpy`）

```python showLineNumbers
# pip install urdfpy
from urdfpy import URDF

robot = URDF.load("robot.urdf")
print("links:", [l.name for l in robot.links])
print("joints:", [j.name for j in robot.joints])
```



## 相关工具

- **ROS 工具**：
  - `check_urdf`：语法与结构检查
  - `urdf_to_graphviz`：拓扑可视化
  - RViz：加载 RobotModel 显示
- **建模与转换**：
  - SolidWorks / Fusion 等导出插件或中间格式再转 URDF
  - `phobos`、开源 SolidWorks 转 URDF 脚本等社区工具
- **编程库**：
  - Python：`urdfpy`、`yourdfpy`、`urdf_parser_py`（ROS）
  - C++：`urdfdom`（ROS 常用解析库）



## 相关链接

- [URDF - ROS Wiki](http://wiki.ros.org/urdf)
- [URDF XML Specification](http://wiki.ros.org/urdf/XML)


