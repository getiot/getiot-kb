---
sidebar_position: 5
slug: /euler-angles-and-quaternions
---

# 欧拉角和四元数

欧拉角和四元数是表示三维旋转的两种重要方法！理解它们，能帮助我们处理三维空间中的旋转问题。

## 什么是旋转？

**旋转**（Rotation）是物体在三维空间中的方向变化。

### 简单理解

旋转就像"物体在空间中转动"：

- 从初始方向转到目标方向
- 可以用角度描述
- 可以用矩阵表示

## 欧拉角

### 定义

**欧拉角**（Euler Angles）是用三个角度表示三维旋转的方法。

### 基本旋转

#### 绕 X 轴旋转（俯仰，Pitch）

旋转矩阵：

$$R_x(\alpha) = \begin{pmatrix}
1 & 0 & 0 \\
0 & \cos \alpha & -\sin \alpha \\
0 & \sin \alpha & \cos \alpha
\end{pmatrix}$$

#### 绕 Y 轴旋转（偏航，Yaw）

旋转矩阵：

$$R_y(\beta) = \begin{pmatrix}
\cos \beta & 0 & \sin \beta \\
0 & 1 & 0 \\
-\sin \beta & 0 & \cos \beta
\end{pmatrix}$$

#### 绕 Z 轴旋转（翻滚，Roll）

旋转矩阵：

$$R_z(\gamma) = \begin{pmatrix}
\cos \gamma & -\sin \gamma & 0 \\
\sin \gamma & \cos \gamma & 0 \\
0 & 0 & 1
\end{pmatrix}$$

### 欧拉角表示

**ZYX 顺序**（最常见）：

$$R = R_z(\gamma) R_y(\beta) R_x(\alpha)$$

三个角度 $(\alpha, \beta, \gamma)$ 就是欧拉角。

### 优点

- ✅ **直观**：容易理解
- ✅ **紧凑**：只需 3 个参数
- ✅ **常用**：广泛使用

### 缺点

- ❌ **万向锁**：某些角度组合会导致自由度丢失
- ❌ **不唯一**：同一个旋转可能有多种表示
- ❌ **插值困难**：难以平滑插值

### 万向锁问题

**万向锁**（Gimbal Lock）是当中间轴旋转 90° 时，另外两个轴重合，导致失去一个自由度。

**例子**：当 $\beta = 90°$ 时，$R_x$ 和 $R_z$ 的效果相同。

## 四元数

### 定义

**四元数**（Quaternion）是用 4 个参数表示三维旋转的方法。

### 形式

四元数 $q$ 的形式：

$$q = w + xi + yj + zk = (w, x, y, z)$$

其中：
- $w$ 是**标量部分**
- $(x, y, z)$ 是**向量部分**
- $i, j, k$ 是虚数单位，满足：
  - $i^2 = j^2 = k^2 = ijk = -1$
  - $ij = k$，$jk = i$，$ki = j$
  - $ji = -k$，$kj = -i$，$ik = -j$

### 单位四元数

**单位四元数**满足：

$$w^2 + x^2 + y^2 + z^2 = 1$$

单位四元数可以表示旋转。

### 旋转表示

绕轴 $\mathbf{n} = (n_x, n_y, n_z)$（单位向量）旋转角度 $\theta$ 的四元数：

$$q = \left(\cos\frac{\theta}{2}, n_x \sin\frac{\theta}{2}, n_y \sin\frac{\theta}{2}, n_z \sin\frac{\theta}{2}\right)$$

### 四元数运算

#### 乘法

两个四元数 $q_1 = (w_1, x_1, y_1, z_1)$ 和 $q_2 = (w_2, x_2, y_2, z_2)$ 的乘积：

$$q_1 q_2 = (w_1 w_2 - x_1 x_2 - y_1 y_2 - z_1 z_2,$$
$$w_1 x_2 + x_1 w_2 + y_1 z_2 - z_1 y_2,$$
$$w_1 y_2 - x_1 z_2 + y_1 w_2 + z_1 x_2,$$
$$w_1 z_2 + x_1 y_2 - y_1 x_2 + z_1 w_2)$$

#### 共轭

四元数 $q = (w, x, y, z)$ 的**共轭**：

$$q^* = (w, -x, -y, -z)$$

#### 逆

单位四元数的**逆**等于共轭：

$$q^{-1} = q^*$$

### 旋转向量

用四元数 $q$ 旋转向量 $\mathbf{v}$：

$$\mathbf{v}' = q \mathbf{v} q^{-1}$$

其中 $\mathbf{v}$ 被视为四元数 $(0, v_x, v_y, v_z)$。

### 优点

- ✅ **无万向锁**：不会出现万向锁问题
- ✅ **唯一表示**：每个旋转对应唯一的单位四元数（除了 $q$ 和 $-q$）
- ✅ **插值平滑**：可以平滑插值（球面线性插值，SLERP）

### 缺点

- ❌ **不直观**：不如欧拉角直观
- ❌ **需要 4 个参数**：比欧拉角多一个参数
- ❌ **计算复杂**：运算相对复杂

## 欧拉角和四元数的转换

### 欧拉角转四元数

对于 ZYX 顺序的欧拉角 $(\alpha, \beta, \gamma)$：

$$q = \left(\cos\frac{\alpha}{2}\cos\frac{\beta}{2}\cos\frac{\gamma}{2} + \sin\frac{\alpha}{2}\sin\frac{\beta}{2}\sin\frac{\gamma}{2},\right.$$
$$\left.\sin\frac{\alpha}{2}\cos\frac{\beta}{2}\cos\frac{\gamma}{2} - \cos\frac{\alpha}{2}\sin\frac{\beta}{2}\sin\frac{\gamma}{2},\right.$$
$$\left.\cos\frac{\alpha}{2}\sin\frac{\beta}{2}\cos\frac{\gamma}{2} + \sin\frac{\alpha}{2}\cos\frac{\beta}{2}\sin\frac{\gamma}{2},\right.$$
$$\left.\cos\frac{\alpha}{2}\cos\frac{\beta}{2}\sin\frac{\gamma}{2} - \sin\frac{\alpha}{2}\sin\frac{\beta}{2}\cos\frac{\gamma}{2}\right)$$

### 四元数转欧拉角

对于单位四元数 $q = (w, x, y, z)$，ZYX 顺序的欧拉角：

$$\alpha = \arctan2(2(wx + yz), 1 - 2(x^2 + y^2))$$

$$\beta = \arcsin(2(wy - xz))$$

$$\gamma = \arctan2(2(wz + xy), 1 - 2(y^2 + z^2))$$

## 应用

### 计算机图形学

- 🎮 **3D 游戏**：表示物体的旋转
- 🎨 **动画**：平滑的旋转动画

### 机器人学

- 🤖 **机器人控制**：控制机器人的姿态
- 🚁 **无人机**：控制无人机的方向

### 航空航天

- ✈️ **飞行器**：表示飞行器的姿态
- 🛰️ **卫星**：控制卫星的方向

## 常见错误

### 错误 1：万向锁问题

使用欧拉角时要注意万向锁问题。

### 错误 2：四元数归一化

使用四元数时要保持单位四元数（归一化）。

### 错误 3：顺序混淆

要注意旋转的顺序（ZYX、XYZ 等）。

## 小练习

1. 计算绕 Z 轴旋转 90° 的旋转矩阵
2. 将欧拉角 $(30°, 45°, 60°)$ 转换为四元数
3. 说明四元数为什么不会出现万向锁问题
4. 应用题：在 3D 游戏中，如何用四元数实现平滑的旋转动画？

---

> 💡 **小贴士**：欧拉角和四元数是表示三维旋转的两种方法。记住：欧拉角直观但有万向锁问题，四元数无万向锁但不够直观。掌握它们，你就能处理三维空间中的旋转问题！