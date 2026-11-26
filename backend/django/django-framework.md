---
sidebar_position: 4
---

# Django 框架



在开始 Django 旅程之前，先来了解一下 Web 架构中最基本的 MVC 模型，以及 DJango 改良版本 MVT 模型。

简单来说：

- MVC 即 “模型-视图-控制器”（Model View Controller）
- MVT 即 “模型-视图-模板”（Model View Template）



## MVC 模型

MVC 是一种软件设计典范，用一种业务逻辑、数据、界面显示分离的方法组织代码，将业务逻辑聚集到一个部件里面，在改进和个性化定制界面及用户交互的同时，不需要重新编写业务逻辑。

![MVC 模型](https://static.getiot.tech/django-mvc-diagram.png#center)

其中：

- Model 用于封装对数据库层的访问，对数据库中的数据进行增、删、改、查操作；
- View 用于封装结果，生成页面展示的 html 内容；
- Controller 则用于接收请求，处理业务逻辑，与 Model 和 View 交互，返回结果。

这样一来，整个 “请求-响应” 过程就变得简单、清晰明了，而且前后端解耦了，便于后期扩展和工程师们的协同开发。



## MVT 模型

DJango 框架遵循的模型是类似于 MVC 的 MVT，看起来只是 C 和 T 的区别，但其实 V 也有所不同。DJango 的 View 还承担了 MVC 模型中 Controller 的功能，也就是处理业务逻辑。而响应的 html 页面则由 Template 负责。

![MVT 模型](https://static.getiot.tech/django-mvt-diagram.png#center)

再来看看：

- Model 是数据存取层，与 MVC 中的 M 功能相同，负责和数据库交互，进行数据处理；
- View 是业务逻辑层，与 MVC 中的 C 功能类似，接收请求，进行业务处理，返回应答；（可以看作 M 和 T 之间的桥梁）
- Template 是表现层，与 MVC 中的 V 功能类似，负责封装构造要返回的 html 页面内容。



## Django Rest framework

Django 的 MVT 框架是一种基于模板的 Web 框架，对于传统网站来说已经够用。但随着移动互联网的发展，人人已经不满足于网页端的操作，往往还需要移动端的应用。因此，出现了“前后端分离”的架构。



### 前后端不分离

在前后端不分离的架构中，前端页面看到的内容和所有界面效果都是由服务端提供出来的，也就是后端需要控制前端的展示。前后端不分离的架构如下图所示。

![Django 前后端不分离](https://static.getiot.tech/web-framework-01.png#center)

可以看到，前端与后端的耦合度很高，这种模式比较适合纯网页应用。但是如果需要对接 App 时，App 其实并不需要后端返回一个 HTML 网页，而仅仅需要数据本身。为了解决这个问题，就需要为移动 App 端单独开发一套接口。如此一来，就会增加开发和维护的成本。



### 前后端分离

再来看看前后端分离的架构，后端仅返回前端所需要的数据，不再渲染 HTML 页面，也不需要控制前端的效果。不同的前端需要看到的效果，都由都由前端自己来决定。也就是说，网页端有它的处理方式，App 端有它的处理方式，但无论哪种前端所需要的数据基本相同，因此后端仅需开发一套逻辑对外提供数据即可。

![Django 前后端分离](https://static.getiot.tech/web-framework-02.png#center)

可以看到，在前后端分离的架构中，前端与后端的耦合度相对较低。我们通常将后端开发的每一视图都称为一个接口，或者 API，前端通过访问接口来对数据进行增删改查。

回到 Django 框架中，Django Rest Framework 就是为了实现前后端分离而设计的，可帮助用户快速实现自己的 API。

更多 >> [RESTful API 规范](/http/http-restful-api/)

