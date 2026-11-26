---
sidebar_position: 9
slug: /rotation-matrices
---

# 旋转矩阵

旋转矩阵是描述旋转的矩阵！理解旋转矩阵，能帮助我们进行图形变换和空间旋转。

## 什么是旋转矩阵？

**旋转矩阵**（Rotation Matrix）是描述旋转的矩阵，用于将向量或点绕某个轴旋转一定角度。

### 简单理解

旋转矩阵就像"旋转的规则"：

- 用矩阵表示旋转
- 矩阵乘以向量，得到旋转后的向量
- 旋转矩阵是正交矩阵

## 二维旋转矩阵

### 绕原点旋转

绕原点逆时针旋转 $\theta$ 角的旋转矩阵：

$$
R(\theta) = \begin{bmatrix}
\cos\theta & -\sin\theta \\
\sin\theta & \cos\theta
\end{bmatrix}
$$


### 点的旋转

点 $(x, y)$ 绕原点旋转 $\theta$ 角后的坐标：

$$
\begin{bmatrix} x' \\ y' \end{bmatrix} = \begin{bmatrix}
\cos\theta & -\sin\theta \\
\sin\theta & \cos\theta
\end{bmatrix} \begin{bmatrix} x \\ y \end{bmatrix}
$$


即：

$$x' = x\cos\theta - y\sin\theta$$

$$y' = x\sin\theta + y\cos\theta$$

### 例子

**例子**：点 $(1, 0)$ 绕原点旋转 $90°$（$\frac{\pi}{2}$）

$$
R\left(\frac{\pi}{2}\right) = \begin{bmatrix}
0 & -1 \\
1 & 0
\end{bmatrix}
$$

$$
\begin{bmatrix} x' \\ y' \end{bmatrix} = \begin{bmatrix}
0 & -1 \\
1 & 0
\end{bmatrix} \begin{bmatrix} 1 \\ 0 \end{bmatrix} = \begin{bmatrix} 0 \\ 1 \end{bmatrix}
$$
所以旋转后的点是 $(0, 1)$。

## 三维旋转矩阵

### 绕 x 轴旋转

绕 x 轴旋转 $\theta$ 角的旋转矩阵：

$$
R_x(\theta) = \begin{bmatrix}
1 & 0 & 0 \\
0 & \cos\theta & -\sin\theta \\
0 & \sin\theta & \cos\theta
\end{bmatrix}
$$


### 绕 y 轴旋转

绕 y 轴旋转 $\theta$ 角的旋转矩阵：

$$
R_y(\theta) = \begin{bmatrix}
\cos\theta & 0 & \sin\theta \\
0 & 1 & 0 \\
-\sin\theta & 0 & \cos\theta
\end{bmatrix}
$$


### 绕 z 轴旋转

绕 z 轴旋转 $\theta$ 角的旋转矩阵：

$$
R_z(\theta) = \begin{bmatrix}
\cos\theta & -\sin\theta & 0 \\
\sin\theta & \cos\theta & 0 \\
0 & 0 & 1
\end{bmatrix}
$$


### 复合旋转

多个旋转可以组合：

$$
R = R_z(\gamma) R_y(\beta) R_x(\alpha)
$$
**注意**：旋转的顺序很重要，不同的顺序得到不同的结果。

## 旋转矩阵的性质

### 性质 1：正交性

旋转矩阵是**正交矩阵**：

$$
R^T R = RR^T = I
$$
即 $R^{-1} = R^T$。

### 性质 2：行列式

旋转矩阵的行列式：

$$
\det(R) = 1
$$


### 性质 3：保持长度

旋转不改变向量的长度：

$$
|R\vec{v}| = |\vec{v}|
$$


### 性质 4：保持角度

旋转不改变向量之间的夹角。

## 欧拉角

### 定义

**欧拉角**（Euler Angles）是用三个角度描述三维旋转的方法。

### 表示

- **$\alpha$**：绕 x 轴的旋转角（Roll，翻滚）
- **$\beta$**：绕 y 轴的旋转角（Pitch，俯仰）
- **$\gamma$**：绕 z 轴的旋转角（Yaw，偏航）

### 旋转矩阵

$$
R = R_z(\gamma) R_y(\beta) R_x(\alpha)
$$



## 四元数

**四元数**（Quaternion）是另一种描述旋转的方法，在某些应用中比旋转矩阵更高效。



## 生活中的应用

#### 计算机图形学

- 💻 **3D 图形**：用旋转矩阵进行 3D 图形变换
- 🎮 **游戏开发**：用旋转矩阵进行游戏开发

#### 机器人

- 🤖 **机器人控制**：用旋转矩阵控制机器人的姿态
- 🚁 **无人机**：用旋转矩阵控制无人机的姿态

#### 航空航天

- ✈️ **飞行器**：用旋转矩阵描述飞行器的姿态
- 🚀 **航天器**：用旋转矩阵描述航天器的姿态

## 常见错误

#### 错误 1：旋转方向混淆

要分清顺时针和逆时针旋转。

#### 错误 2：旋转顺序错误

多个旋转的顺序很重要，不能随意改变。

#### 错误 3：角度单位混淆

要分清角度和弧度，注意换算关系。

## 小练习

1. 写出绕原点旋转 $45°$ 的二维旋转矩阵
2. 点 $(1, 1)$ 绕原点旋转 $90°$ 后的坐标是什么？
3. 写出绕 z 轴旋转 $30°$ 的三维旋转矩阵
4. 应用题：在计算机图形学中，如何用旋转矩阵实现物体的旋转？

---

> 💡 **小贴士**：旋转矩阵是描述旋转的矩阵。记住：旋转矩阵是正交矩阵，$\det(R) = 1$，$R^{-1} = R^T$。掌握旋转矩阵，你就能进行图形变换和空间旋转！