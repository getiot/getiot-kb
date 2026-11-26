---
sidebar_label: Drake 机器人仿真环境
sidebar_position: 6
slug: /mit-drake
---

# Drake 机器人仿真环境

![](https://static.getiot.tech/MIT-Drake.jpeg#center)

Drake 是由 MIT 的 Russ Tedrake 教授团队开发的软件工具包，提供了 C++ 以及 Python 的接口函数，可用于机器人动力学分析，控制器设计以及仿真。

在 [Underactuated Robotics Algorithms for Walking, Running, Swimming, Flying, and Manipulation](https://underactuated.mit.edu/Spring2021/) 的这一门课程中，也提供了许多使用 Drake 开发的小例子，便于学生们更好的理解课程内容。

这些例子是基于 Pydrake 开发的，采用了 Jupyter Notebook 的形式，制作成了精致的教学文档。尽管官方已经提供了两种云端远程运行的方式（Binder 和 Google's Colaboratory），让学生可以运行 Jupyter Notebook 格式的实例，但是，云端的方式始终有一些不便，尤其是对于国内的学生来说。

搭建本地开发环境其实也很简单，例如你可以直接通过 pip 来安装：

```bash
python3 -m venv env
env/bin/pip install --upgrade pip
env/bin/pip install drake
```

如果你使用 Ubuntu 系统，那么还需要安装一些依赖：

```bash
sudo apt-get install --no-install-recommends \
  libpython3.8 libx11-6 libsm6 libxt6 libglib2.0-0
```

然后激活 Python 虚拟环境：

```bash
source env/bin/activate
```

现在，你可以运行 Drake 的教学用例啦！



## 相关链接

- 项目官网：[https://drake.mit.edu](https://drake.mit.edu/)
- 文档中心：[https://drake.mit.edu/doxygen_cxx/](https://drake.mit.edu/doxygen_cxx/)
- GitHub 仓库：[https://github.com/RobotLocomotion/drake](https://github.com/RobotLocomotion/drake)
- 课程：[MIT 6.832: Underactuated Robotics](https://underactuated.mit.edu/Spring2021/)



## 参考

- [Drake仿真环境搭建——欠驱动机器人系列相关](https://zhuanlan.zhihu.com/p/128108694)
- [Drake: Model-based design in the age of robotics and machine learning](https://medium.com/toyotaresearch/drake-model-based-design-in-the-age-of-robotics-and-machine-learning-59938c985515)

