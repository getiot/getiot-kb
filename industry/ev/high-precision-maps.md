---
sidebar_position: 26
draft: true
authors: [luhuadong]
---

# 高精度地图技术



高精度地图和我们平常看到的导航地图不同，导航地图是给人看的，而高精度地图是给机器看的。高精度地图具有高精度、高动态、多维度的特征，可以帮助自动驾驶汽车实时检测多传感器融合的结果是否与地图匹配，不断地去计算累计误差值，从而检测规划的最优解是否是真实的最优解。

高精度地图的难点在于地图数据的采集和制作，对数据要求很高，需要采用专业设备，使用专业方法进行测绘。在实际作业中，高精地图厂商通常使用搭载了激光雷达、摄像头等大量传感器的车辆，在路上来回扫描获得数据。为了保证数据的准确性，高精度地图还需要保持更新，实现日更甚至是分钟级的更新，才能避免因数据更新不及时而让汽车做出错误的决策，因此对高精地图背后的数据存储、数据筛选、建模解析等技术提出了新的挑战。



应用场景

- 机场、港口、园区等封闭区域，可以利用高精度地图，提高货物转运效率，降低成本开支。



地图厂商

国外主要图商有：

- Here：专注高精度地图和位置服务，开放位置平台（OLP）运营商。于 2015 年被奔驰、宝马、奥迪以 28 亿欧元联合收购，之后引入英特尔、博世等自动驾驶领域厂商的投资，形成了一个成规模的高精地图联盟。
- TomTom：RoadDNA 技术，将原本的 3D 地图数据转换成 2D 视图，在对地图数据进行压缩的同时，保留道路上的关键要素。
- Waymo：Alphabet 公司（Google 母公司）旗下的子公司，依托谷歌地图，是自动驾驶领域的“领头羊”。
- Mobileye：主要从事汽车领域的计算机视觉算法、ADAS 和自动驾驶系统芯片 EyeQ 系列，2018年以众包方式构建高精度地图。
- DeepMap：高精地图可伸缩和可维护的高清映射技术，提供实时本地化的厘米级自动驾驶地图。
- CivilMaps：从汽车内部传感器上收集三维数据，众包采集交通信息，将其整合到自动驾驶地图中。
- lvl 5：纯视觉制图方式实现高精地图采集。
- Carmera：通过安装在物流车辆上的传感器组件，采集高精地图数据；基于实时数据挖掘，为物流车队反馈实时驾驶信息。

国内主要图商有：

- **四维图新**：导航业务起家，发力高精地图。公司于2002年成立，2010年上市，以导航业务起家，目前业务覆盖导航、车联网、车载智能芯片、高精地图、高精度定位以及自动驾驶整体解决方案。四维图新具有较强的国企背景，是由国家测绘局创建的唯一专业从事测绘的国家级公司。
- **高德地图**：首家商业化高精度地图企 高德地图成立于2001 年，是一家总部位于中国的导航电子地图内容和位置服务解决方案提供商，具备国家甲级导航电子地图测绘和甲级航空摄影的“双甲”资质，优质的电子地图数据库是公司的核心竞争力。2010年高德地图赴美上市。2014年高德地图被阿里收购并退市。2016年高德地图开始在高精度地图上布局。 目前该公司已经实现覆盖中国超过30万公里的高速及城快公路的高精度数据采集，实现绝对精度50厘米，相对精度10厘米，在采集里程和数据精度方面处于行业领先地位。
- **百度地图**：百度地图成立于2005年，目前已覆盖全球209个国家和地区，成为“全球地图”。伴随着AI时代的到来，百度地图实现了语音交互覆盖用户操控全流程，还上线AR步导、AR导游等实用功能，更加方便用户的出行。2013年百度地图收购拥有“电子导航地图制作”甲级测绘资质的长地万方，目前百度地图事业部员工超过2000人。



A high-precision map (HPM) is the key infrastructure to realizing the function of automated driving (AD) and ensuring its safety. However, the current laws and regulations on HPMs in China can lead to serious legal compliance problems. Thus, proper measures should be taken to remove these barriers. Starting with a complete view of the current legal obstacles to HPMs in China, this study first explains why these legal obstacles exist and the types of legal interests they are trying to protect. It then analyzes whether new technology could be used as an alternative to resolve these concerns. Factors such as national security, AD industry needs, and personal data protection, as well as the flexibility of applying technology, are discussed and analyzed hierarchically for this purpose. This study proposes that China should adhere to national security and AD industry development, pass new technical regulations that redefine the scope of national security regarding geographic information in the field of HPMs, and establish a national platform under the guidance and monitoring of the government to integrate scattered resources and promote the development of HPMs via crowdsourcing. Regarding the legal obstacles with higher technical plasticity, priority should be given to technical solutions such as “available but invisible” technology. Compared with the previous research, this study reveals the current legal barriers in China that have different levels of relevance to national security and different technical plasticity. It also proposes original measures to remove them, such as coordinating national security with the development of the AD industry, reshaping the boundary of national security and industrial interests, and giving priority to technical solutions for legal barriers that have strong technical plasticity.

高精度地图（HPM）是实现自动驾驶（AD）功能并保障其安全的关键基础设施。然而，中国现行的 HPM 法律法规可能会导致严重的法律合规问题。因此，应采取适当措施消除这些障碍。本研究从全面了解当前中国 HPM 面临的法律障碍入手，首先解释了这些法律障碍存在的原因以及它们试图保护的法律利益的类型。然后，它分析是否可以使用新技术作为解决这些问题的替代方案。为此目的，对国家安全、反倾销行业需求和个人数据保护以及应用技术的灵活性等因素进行了分层讨论和分析。本研究提出，中国应坚持国家安全和AD产业发展，通过新的技术法规，重新定义HPM领域地理信息国家安全范围，建立政府指导和监督下的国家平台，整合分散资源，通过众包促进 HPM 的发展。对于技术可塑性较高的法律障碍，应优先考虑“可用但不可见”的技术等技术解决方案。与以往研究相比，本研究揭示了中国目前存在的与国家安全相关程度不同、技术可塑性不同的法律壁垒。并提出原创性的消除措施，如协调国家安全与反倾销产业发展，重塑国家安全与产业利益边界，优先考虑技术可塑性强的法律壁垒技术解决方案。



## 高精度地图成智能汽车必争之地

智能网联汽车高精度地图城市试点应用已经启动。10月17日，百度宣布，已获得广州、深圳首次发放的城市高级辅助驾驶地图许可，百度地图将支持车企量产搭载城市领航辅助驾驶功能的智能汽车，在城市道路上满足单车智能辅助驾驶应用场景。根据8月初自然资源部办公厅印发的《关于做好智能网联汽车高精度地图应用试点有关工作的通知》(以下简称《应用试点通知》)，北上广等六个城市将开展智能网联汽车高精度地图应用试点，争取在试点工作基础上形成可在全国复制、推广的自动驾驶相关地图安全应用技术路径和示范模式。

### 百度获首批许可

“近日，广深两城发放了城市高级辅助驾驶地图许可，百度首批获准”，10月17日，百度相关人士向北京商报记者介绍，目前百度领航辅助驾驶功能已覆盖部分城市的高速公路和城市快速路，百度此次获得城市高级辅助驾驶地图许可，意味着百度地图将支持车企量产搭载城市领航辅助驾驶功能的智能汽车，在城市道路上满足单车智能辅助驾驶应用场景，实现泊车、高速、城市的三域融通。

该人士以百度Apollo智驾产品举例，“这是L4级自动驾驶能力的降维应用，具备量产能力可搭载在乘用车上，供普通用户购买使用的产品。目前，百度智驾产品已经实现了从泊车域到行车域的全域智能辅助驾驶能力，可以支持城市全场景”。

按照相关规定，高级辅助驾驶地图属于高精度地图的一种，是含有空间位置地理坐标，能够与空间定位系统和感知设备等相关装置结合，支撑智能汽车2-3级驾驶自动化功能，为其导航、感知、定位和决策起辅助作用，准确引导人或交通工具从出发地到达目的地的地理信息数据集。

高精度地图是实现自动驾驶的重要基础设施之一，因其高精准度、高丰富度和高新鲜度，专门为高级辅助驾驶、自动驾驶提供服务。百度在2013年布局自动驾驶时，即投入研发高精度地图，目前既拥有高精度地图领先技术，又能提供自动驾驶完整解决方案。据了解，百度还自研了高精度一体化AI采集技术，并拥有完整自主知识产权。在高速公路和城市快速路应用中，百度高级辅助驾驶地图更新能力达到分钟级，能自动识别包括交通标志、车道线、信号灯等上百种目标，并实现了对道路的动态变化快速响应。

### 城市试点开始

8月初，国家自然资源部选择北京、上海、广州、深圳、杭州、重庆六个城市开展智能网联汽车高精度地图应用试点。

《应用试点通知》明确，鼓励管理创新、技术创新和服务业态创新，支持不同类型地图面向自动驾驶应用多元化路径探索，支持不同主体就不同技术路线、不同应用场景开展测试验证和应用推广，支持试点城市根据产业实际需求，开展高级辅助驾驶地图城市普通道路、高精度位置导航应用等先行先试和示范应用。

《应用试点通知》同时要求，强化自动驾驶活动中地理信息采集、汇聚、处理、使用全流程的安全保密管理，制定并严格执行安全事件应急处置预案，确保所有试点行为不得危及国家地理信息安全。加强与试点企业的交流，积极提供试点区域地理信息成果，做好政策解读和指导工作，督促试点企业认真落实主体责任，争取在试点工作基础上形成可在全国复制、推广的自动驾驶相关地图安全应用技术路径和示范模式。

“自动驾驶概念诞生至今，安全性、可复制性是相关部门的关注重点。高精度地图则是自动驾驶技术实现的基础，从有代表性的区域试点再进行推广，既可以保证安全性又能降低推广难度”，比达咨询分析师李锦清表示。

### 测绘管理细化

值得注意的是，为统筹发展与安全，在守牢安全底线的前提下，积极扶持智能网联汽车新技术、新业态的发展，国家自然资源部在下发《应用试点通知》后，还发布了《关于促进智能网联汽车发展维护测绘地理信息安全的通知》(以下简称《通知》)。

《通知》明确，智能网联汽车安装或集成了卫星导航定位接收模块、惯性测量单元、摄像头、激光雷达等传感器后，在运行、服务和道路测试过程中对车辆及周边道路设施空间坐标、影像、点云及其属性信息等测绘地理信息数据进行采集、存储、传输和处理的行为，属于《中华人民共和国测绘法》规定的测绘活动，应当依照测绘法律法规政策进行规范和管理。各类车载传感器以及智能网联汽车的制造、集成、销售等，不属于法定的测绘活动。

根据相关规定，高精度地图测绘制作，只能由具备导航电子地图制作甲级资质的单位进行。“对于车联网企业，导航电子地图制作甲级资质的价值非常大，比如基于庞大的自动驾驶车队，运用车载的摄像头或者雷达的地理信息收集对高级辅助驾驶地图进行更新”，易观分析汽车出行行业高级咨询顾问江山美告诉北京商报记者。

“高精度地图和自动驾驶的实现是相辅相成的，高精度地图技术进步能带动自动驾驶的发展，自动驾驶的发展能促进高精度地图技术向前推进。从理论上来说，要实现高级别自动驾驶，也可以不通过高精度地图实现，比如特斯拉一直都采用不依赖高精度地图、通过纯视觉感知来识别道路环境的路线。但是与基于高精度地图的路线相比，安全性是一个值得认真思考的问题”，江山美进一步说道。



