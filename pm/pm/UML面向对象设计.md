---
sidebar_position: 8
slug: /object-oriented-analysis-and-desigin
---



# 面向对象系统分析与设计



> Object-Oriented Systems Analysis and Design Using UML
>
> OOAD: Object Oriented Analysis and Desigin



面向对象系统分析与设计（Object Oriented Analysis and Desigin）简称 OOAD，是根据面向对象的方法学，对软件系统进行分析和设计的过程。可分为两个阶段：

- OOA（Object Oriented Analysis）：分析阶段
- OOD（Object Oriented Desigin）：设计阶段

在软件项目中，UML 常用于面向对象系统分析与设计。



## UML 建模方法

UML 是“统一建模语言”（Unified Modeling Language）的缩写，是一种用于软件开发的图形化建模语言。它提供了一套用于描述系统构成、行为和交互的图形符号和文本标记，并支持了面向对象的建模方法。

UML包含多种图形表示方法，包括用于表示系统结构和组成的类图、用于描述系统流程和行为的活动图以及用于描述系统交互的用例图等。如今，UML 已成为工业标准，广泛应用于信息系统开发、软件工程以及其他领域。

对象的三个基本要素分别是：对象标识、对象状态、对象行为。

对象是类的实例，类是对象的模板。



## UML 的 5 个视图

### 1）用例视图

用例视图（Use case view）用于定义系统的外部行为，它定义了系统的需求，是描述系统设计和构建的其他视图的基础，即用例驱动。用例视图又称为“用户模型视图”。

### 2）逻辑视图

逻辑视图（Logic view）用于描述逻辑结构，该逻辑结构支持用例视图描述的功能，它描述了问题空间中的概念以及实现系统功能的机制，如类、包、子系统等。逻辑视图又称为“结构模型视图”或“静态视图”。

### 3）实现视图

实现视图（Implementation view）描述用于组建系统的物理组件，如可执行文件、代码库和数据库等系统程序员所看到的软件产物，是和配置管理以及系统集成相关的信息。实现视图又称为“组件视图”。

### 4）过程视图

过程视图（Process view）描述将系统分解为过程和任务，以及这些并发元素之间的通信与同步。过程视图又称为“并发视图”、“动态视图”或“协作视图”。

### 5）部署视图

部署视图（Deployment view）描述系统的物理网络布局，是系统工程师和网络工程师所感兴趣的。部署视图又称为“物理视图”。



## UML 的 9 种图表

UML 中有九种建模的图表，可按静态和动态分为两大类：

- 静态图：用例图、类图、对象图、组件图、配置图
- 动态图：序列图、状态图、协作图、活动图



### 1）用例图

用例图（Use case diagram）描述系统的功能，作为一个外部的观察者的视角对系统的印象。它强调的是这个系统是什么而不是这个系统怎么工作，通常由由系统、用例和角色三种元素组成。

![用例图（Use case diagram）](https://static.getiot.tech/uml-usecase-diagram.png#center)



![](https://static.getiot.tech/Use_case_restaurant_model.svg)

[维基百科](https://zh.wikipedia.org/wiki/%E7%94%A8%E4%BE%8B%E5%9B%BE)



用例图由系统、用例和角色三种元素组成。用例图与情节紧紧相关的，情节（scenario）是指当某个人与系统进行互动时发生的情况。例如，下面是一个医院门诊部的情节。

“一个病人打电话给门诊部预约一年一次的身体检查。接待员找出在预约记录本上找出最近的没有预约过的时间，并记上那个时间的预约记录。”

用例（Use case）是为了完成一个工作或者达到一个目的的一系列情节的总和。角色（actor）是发动与这个工作有关的事件的人或者事情。角色简单的扮演着人或者对象的作用。下面的图是一个门诊部（Make Appointment）用例。角色是病人。角色与用例的联系是通讯联系communication association（或简称通讯communication）

![Use case](http://www.uml.org.cn/oobject/images/usecaseactorno3.gif#center)

角色是人状的图标，用例是一个椭圆，通讯是连接角色和用例的线。

一个用例图是角色，用例，和它们之间的联系的集合。我们已经把 Make Appointment 作为一个含有四个角色和四个用例的图的一部分。注意一个单独的用例可以有多个角色。

![Use case diagram](http://www.uml.org.cn/oobject/images/actorsmultipleno3d.gif#center)

用例图在三个领域很有作用。

- 决定特征（需求）。当系统已经分析好并且设计成型时，新的用例产生新的需求。
- 客户通讯。使用用例图很容易表示开发者与客户之间的联系。
- 产生测试用例。一个用例的情节可能产生这些情节的一批测试用例。



### 2）类图

类图（Class diagram）用于表示系统中的类以及类与类之间的关系，描述系统的静态结构，用于逻辑视图中。由于类图是静态的，因此它们能显示出什么可以产生影响，但不能显示什么时候产生影响。

![类图（Class diagram）](https://static.getiot.tech/uml-class-diagram.png#center)



![](https://static.getiot.tech/uml-class-diagram_vehicle.png)

- Vehicle 类为一个抽象类
- Vehicle 类下面有两个继承类：Car 和 Bicycle，它们之间的关系为实现关系，使用带空心箭头的虚线表示；
- Car 与 SUV 之间也是继承关系，它们之间的关系为泛化关系，使用带空心的实线表示；
- Car 与 Engine 之间是组合关系，使用实心菱形的实线表示；
- Student 与 Class 之间是聚合关系，使用空心菱形的实线表示；
- Student 与 IdCard 之间为关联关系，使用实线表示；
- Student 上学需要骑 Bicycle，与 Bicycle 是一种依赖关系，使用带箭头的虚线表示；



下面是一个顾客从零售商处预定商品的模型的类图。中心的类是Order。连接它的是购买货物的Customer和Payment。Payment有三种形式：Cash，Check，或者Credit。订单包括OrderDetails（line item），每个这种类都连着Item。

![Class diagram](http://www.uml.org.cn/oobject/images/classdiagramno3d.gif#center)

UML类的符号是一个被划分成三块的方框：类名，属性，和操作。抽象类的名字，像Payment是斜体的。类之间的关系是连接线。

类图有三种关系。

- 关联association－表示两种类的实例间的关系。如果一个类的实例必须要用另一个类的实例才能完成工作时就要用关联。在图中，关联用两个类之间的连线表示。
- 聚合aggregation－当一个类属于一个容器是的一种特殊关系。聚合用一个带菱形的连线，菱形指向具有整体性质的类。在我们的图里，Order是OrderDetails的容器。
- 泛化generalization－一个指向以其他类作为超类的继承连线。泛化关系用一个三角形指向超类。Payment是Cash，Check和Credit的超类。

一个关联有两个尾端。每个尾端可以有一个角色名role name来说明关联的作用。比如，一个OrderDetail实例是一个Order实例的项目。

关联上的方向性navigability箭头表示该关联传递或查询的方向。OrderDetail类可以查询他的Item，但不可以反过来查询。箭头方向同样可以告诉你哪个类拥有这个关联的实现；也就是，OrderDetail拥有Item。没有方向性的箭头的关联是双向。

关联尾端的数字表示该关联另一边的一个实例可以对应的数字端的实例的格数，通过这种方式表达关联的多样性multiplicity。多样性的数字可以是一个单独的数字或者是一个数字的范围。在例子中，每个Order只有一个Customer，但一个Customer可以有任意多个Order。

下面这个表给出了最普遍的多样性示例。

| 多样性               | 意义                                 |
| -------------------- | ------------------------------------ |
| **0..1**             | 0或1个实例. n..m符号表示有n到m个实例 |
| **0..\*** *or* ***** | 没有实例格数的限制（包括没有）.      |
| **1**                | 只有一个实例                         |
| **1..\***            | 最少一个实例                         |

每个类图包括类，关联和多样性表示。方向性和角色是为了使图示得更清楚时可选的项目。



### 3）对象图

对象图（Object diagram）是类图的实例，表示在某一时刻这些类的具体实例以及这些实例之间的具体连接关系，可以帮助人们理解比较复杂的类图。对象图也可以用于显示类图中的对象在某一点的连接关系，常用于用例视图和逻辑视图中。

![对象图（Object diagram）](https://static.getiot.tech/uml-object-diagram.png#center)



为了简单地表示出复杂的类图，可以把类组合成包packages。一个包是UML上有逻辑关系的元件的集合。下面这个图是是一个把类组合成包的一个商业模型。

dependencies关系。如果另一个的包B改变可能会导致一个包A改变，则包A依赖包B。

![Package diagram](http://www.uml.org.cn/oobject/images/packageno3d.gif#center)

包是用一个在上方带有小标签的矩形表示的。包名写在标签上或者在矩形里面。点化线箭头表示依赖

对象图Object diagrams用来表示类的实例。他们在解释复杂关系的细小问题时（特别是递归关系时）很有用。

这个类图示一个大学的Department可以包括其他很多的Departments。

![Recursive class diagram](http://www.uml.org.cn/oobject/images/departmentno3d.gif#center)

这个对象图示上面类图的实例。用了很多具体的例子。

UML中实例名带有下划线。只要意思清楚，类或实例名可以在对象图中被省略。

![Object diagram](http://www.uml.org.cn/oobject/images/objdiagno3d.gif#center)

每个类图的矩形对应了一个单独的实例。实例名称中所强调的UML图表。类或实例的名称可能是省略对象图表只要图的意义仍然是明确的。



### 4）状态图

状态图（State diagram）主要用来描述对象、子系统、系统的生命周期。通过状态图可以了解一个对象可能具有的所有状态，导致对象状态改变的事件，以及状态转移引发的动作。

状态图是对类描述的事物的补充说明，用在逻辑视图中描述类的行为。

对象拥有行为和状态。对象的状态是由对象当前的行动和条件决定的。状态图statechart diagram显示出了对象可能的状态以及由状态改变而导致的转移。
我们的模型例图建立了一个银行的在线登录系统。登录过程包括输入合法的密码和个人账号，再提交给系统验证信息。

登录系统可以被划分为四种不重叠的状态：Getting SSN, Getting PIN, Validating, 以及 Rejecting。每个状态都有一套完整的转移transitions来决定状态的顺序。

![State diagram](http://www.uml.org.cn/oobject/images/statediagno3d.gif#center)

状态是用圆角矩形来表示的。转移则是使用带箭头的连线表示。触发转移的事件或者条件写在箭头的旁边。我们的图上有两个自转移。一个是在Getting SSN，另一个则在上Getting PIN。

初始状态（黑色圆圈）是开始动作的虚拟开始。结束状态也是动作的虚拟结束。

事件或条件触发动作时用（/动作）表示。当进入Validating状态时，对象并不等外部事件触发转移。取而代之，它产生一个动作。动作的结果决定了下一步的状态。

### 5）序列图

序列图（Sequence diagram）又称“顺序图”或“交互图”，用于将系统的交互关系表示为一个二维图，其中纵向是时间轴，时间沿竖线向下延伸。横向轴代表了在协作中各独立对象的类元角色，类元角色用生命线表示。当对象存在时，角色用一条虚线表示，当对象的过程处于激活状态时，生命线是一个双道线。

类图和对象图是静态模型的视图，而序列图是动态的，它描述了对象间的交互作用。

消息用从一个对象的生命线到另一个对象生命线的箭头表示，箭头以时间顺序在图中从上到下排列。

![序列图（Sequence diagram）](https://static.getiot.tech/uml-sequence-diagram.png#center)



![Sequence diagram](http://www.uml.org.cn/oobject/images/sequencediagno3d.gif#center)



### 6）协作图

协作图（Collaboration diagram）主要描述协作对象之间的交互和连接。协作图和序列图同样反映对象间的动态协作，也可以表达消息序列，但重点描述交换消息的对象之间的关系，强调的是空间关系而非时间顺序。

协作图也是互动的图表。他们像序列图一样也传递相同的信息，但他们不关心什么时候消息被传递，只关心对象的角色。在序列图中，对象的角色放在上面而消息则是连接线。

![Collaboration diagram](http://www.uml.org.cn/oobject/images/collaborationo3d.gif#center)

对象角色矩形上标有类或对象名（或者都有）。类名前面有个冒号（：）。

协作图的每个消息都有一个序列号。顶层消息的数字是1。同一个等级的消息（也就是同一个调用中的消息）有同样的数字前缀，再根据他们出现的顺序增加一个后缀1，2等等。

### 7）活动图

活动图（Activity diagram）显示动作及其结果，着重描述操作实现中所完成的工作以及用例实例或对象中的活动。活动图中反映了一个连续的活动流，常用于描述一个操作执行过程的所完成的工作。

活动图可以视为是种结构化的流程图，由若干不同形状的图形组成，图形之间由箭头连接。其中比较重要的形状有：

- 圆角矩形：表示“动作”
- 菱形：表示“决策”
- 粗实线：表示并行（并发性）活动的开始（分离）和结束（汇合）
- 黑圆：工作流的开始（初始节点）
- 黑圈套住的黑圆：工作流的结束（结束节点）

箭头从开始一路指向结束，用来表示活动的先后顺序。

![活动图（Activity diagram）](https://static.getiot.tech/Activity_conducting.svg)



活动图activity diagram是一个很特别的流程图。活动图和状态图之间是有关系的。状态图把焦点集中在过程中的对象身上，而活动图则集中在一个单独过程动作流程。活动图告诉了我们活动之间的依赖关系。

对我们的例子来说，我们使用如下的过程。

“通过ATM来取钱。”

这个活动有三个类Customer, ATM和 Bank。整个过程从黑色圆圈开始到黑白的同心圆结束。活动用圆角矩形表示。

![Activity diagram](http://www.uml.org.cn/oobject/images/activityno3d.gif#center)

活动图可以被分解成许多对象泳道swimlanes ，可以决定哪些对象负责那些活动。每个活动都有一个单独的转移transition连接这其他的活动。

转移可能分支branch成两个以上的互斥的转移。保护表达式（在[]中）表示转移是从一个分支中引出的。分支以及分支结束时的合并merge在图中用菱形表示。

转移也可以分解fork成两个以上的并行活动。分解以及分解结束时的线程结合join在图中用粗黑线表示

### 8）组件图

组件图（Component diagram）用来反映代码的物理结构，组件可以是源代码、二进制文件或可执行文件，包含逻辑类的实现信息。

组件（component）可理解为一个个代码模块，组件图表达的是类图的物理实现。配置图（Deployment diagram）则是显示软件及硬件的配置。

![组件图（Component diagram）](https://static.getiot.tech/uml-component-diagram.png#center)



下面的配置图说明了与房地产事务有关的软件及硬件组件的关系。

![Deployment diagram](http://www.uml.org.cn/oobject/images/deploymentno3d.gif#center)

物理上的硬件使用节点nodes表示。每个组件属于一个节点。组件用左上角带有两个小矩形的矩形表示。

### 9）配置图

配置图（Deployment diagram）又称“部署图”，用于显示系统中软件和硬件的物理架构。图中通常显示实际的计算机和设备及其之间的关系。配置图用来构成配置视图，描述系统的实际物理结构。

![配置图（Deployment diagram）](https://static.getiot.tech/uml-deployment-diagram.png#center)





