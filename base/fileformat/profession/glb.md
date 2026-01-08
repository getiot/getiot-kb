---
sidebar_position: 3
sidebar_label: GLB 格式
slug: /glb
---

# GLB 格式（3D 传输）

**GLB**（GL Transmission Format Binary）是 glTF 2.0 标准的单文件封装格式，由 Khronos Group 于 2017 年制定。采用二进制编码整合 3D 模型网格、材质贴图、骨骼动画和 PBR 渲染数据，支持 Draco 压缩算法，体积比 OBJ 小 60%，被 Microsoft 3D Viewer 和 Unreal Engine 广泛采用。



## 格式简介

GLB 是 glTF（GL Transmission Format）的二进制版本，将 glTF 的 JSON 描述文件和所有资源（纹理、几何体等）打包成单个二进制文件。GLB 格式专为高效传输和加载 3D 内容而设计，是 Web 3D 和移动应用的标准格式。

GLB 文件扩展名为 `.glb`，MIME 类型为 `model/gltf-binary`。GLB 格式由 Khronos Group 制定，是开放标准。



## 技术特点

### 核心特性

- **单文件格式**：所有资源打包在一个文件中
- **二进制编码**：高效的二进制格式
- **PBR 材质**：支持基于物理的渲染
- **动画支持**：支持骨骼动画和变形动画
- **压缩支持**：支持 Draco 几何压缩
- **Web 优化**：专为 Web 传输优化

### GLB vs glTF

- **GLB**：单文件二进制格式
- **glTF**：JSON + 外部资源文件
- **体积**：GLB 通常更小（二进制编码）
- **加载**：GLB 加载更快（单文件）

### 支持的功能

- **几何体**：网格、顶点、索引
- **材质**：PBR 材质、纹理
- **动画**：骨骼动画、变形动画
- **场景图**：节点层次结构
- **相机**：相机定义



## 文件结构

GLB 文件的基本结构：

```bash showLineNumbers
[GLB 头]                 # 12 字节
  - 魔数（4 字节）：glTF
  - 版本（4 字节）
  - 总长度（4 字节）
[JSON 块]                # JSON 描述数据
  - 块长度（4 字节）
  - 块类型（4 字节）：JSON
  - JSON 数据（可变长度）
[二进制块]               # 二进制资源数据
  - 块长度（4 字节）
  - 块类型（4 字节）：BIN
  - 二进制数据（可变长度）
```

### 关键组件

- **GLB 头**：文件标识和版本
- **JSON 块**：场景描述、节点、材质等
- **二进制块**：几何体、纹理等资源数据



## 使用场景

### 适用场景

- **Web 3D**：网页中的 3D 模型展示
- **移动应用**：AR/VR 应用中的 3D 内容
- **游戏开发**：游戏中的 3D 资源
- **3D 可视化**：数据可视化中的 3D 元素
- **电商展示**：产品 3D 展示

### 优缺点

**优点：**

- 单文件格式，易于传输
- 体积小，加载快
- 支持丰富的 3D 功能
- Web 原生支持
- 开放标准

**缺点：**

- 某些旧浏览器不支持
- 编辑需要转换为 glTF
- 某些工具支持有限



## 代码示例

### JavaScript 加载 GLB

```javascript showLineNumbers
import * as THREE from 'three';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js';

// 创建加载器
const loader = new GLTFLoader();

// 加载 GLB 文件
loader.load('model.glb', (gltf) => {
    const model = gltf.scene;
    scene.add(model);
    
    // 播放动画
    const mixer = new THREE.AnimationMixer(model);
    gltf.animations.forEach((clip) => {
        mixer.clipAction(clip).play();
    });
});
```

### Python 处理 GLB

```python showLineNumbers
import trimesh

# 加载 GLB 文件
mesh = trimesh.load('model.glb')

# 获取信息
print(f"顶点数: {len(mesh.vertices)}")
print(f"面数: {len(mesh.faces)}")

# 导出为其他格式
mesh.export('output.obj')
```

### 使用 gltf-pipeline

```bash showLineNumbers
# 压缩 GLB
gltf-pipeline -i input.glb -o output.glb -d

# 转换为 glTF
gltf-pipeline -i input.glb -o output.gltf

# 从 glTF 创建 GLB
gltf-pipeline -i input.gltf -o output.glb
```



## 相关工具

- **3D 建模软件**：
  - Blender：支持 GLB 导入导出
  - Maya：支持 GLB
  - 3ds Max：支持 GLB
- **转换工具**：
  - gltf-pipeline：GLB 处理工具
  - FBX2glTF：FBX 转 GLB
- **查看器**：
  - Three.js Viewer：在线 GLB 查看器
  - Babylon.js Viewer：在线查看器
- **编程库**：
  - JavaScript: `three.js`、`babylon.js`
  - Python: `trimesh`、`pygltflib`
  - C/C++: `tinygltf`



## 相关链接

- [glTF 官方网站](https://www.khronos.org/gltf/)
- [glTF 规范](https://www.khronos.org/registry/glTF/specs/2.0/glTF-2.0.html)
- [Three.js GLTFLoader](https://threejs.org/docs/#examples/en/loaders/GLTFLoader)



## 参考

- [GLB - Wikipedia](https://en.wikipedia.org/wiki/GlTF#GLB)
- [glTF 格式详解](https://www.khronos.org/gltf/)
- [GLB vs glTF](https://www.khronos.org/gltf/)

