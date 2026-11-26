---
sidebar_label: GeoJSON 地理数据格式
sidebar_position: 12
slug: /geojson
---

# GeoJSON 地理数据格式



## 概述

**GeoJSON** 是一种基于 JSON 的地理空间数据交换格式，它定义了几种类型 JSON 对象以及它们组合在一起的方法，以表示有关地理要素、属性和它们的空间范围的数据。GeoJSON 支持以下几何类型：点、线、多边形、点集合、线集合、多边形集合和几何体集合。

最早在2015年，由互联网工程任务组（IETF）与原始规范作者组建了一个 GeoJSON 工作组，一起规范 GeoJSON 标准。在2016年8月，推出了最新的 GeoJSON 数据格式标准规范（RFC 7946）。

一个完整的 GeoJSON 数据结构是一个以 JSON 术语表示的对象。 在 GeoJSON 中，对象由名称/值对（也称为成员）的集合组成。对于每个成员，名字总是字符串。成员值可以是字符串、数字、对象、数组，或者 true、false 和 null。

GeoJSON 使用唯一地理坐标参考系统 WGS1984 和十进制度单位，一个 GeoJSON 对象可以是 Geometry、Feature 或者 FeatureCollection。其几何对象包括有点（表示地理位置）、线（表示街道、公路、边界）、多边形（表示国家、省、领土），以及由以上类型组合成的复合几何图形。



## GeoJSON 对象

GeoJSON 通常是由单个对象组成。此对象（以下称为 GeoJSON 对象）表示几何、要素或要素集合。

- GeoJSON 对象可能是具有任意数量的成员（名称/值对）。
- GeoJSON 对象必须是名为 “type” 的成员。 此成员的值是由 GeoJSON 对象的类型所确定的字符串。
- type 成员的值必须是下面之一：`Point`、`MultiPoint`、`LineString`、`MultiLineString`、`Polygon`、`MultiPolygon`、`GeometryCollection`、`Feature` 或 `FeatureCollection`。type 成员值的大小写必须如这所示。
- GeoJSON 对象可能有一个可选的 “crs” 成员，其值必须是坐标参考系统对象。
- GeoJSON 对象可能有一个 “bbox” 成员，其值必须是边界框数组。



## 使用示例

### 安装

通过 pip 安装 GeoJSON 的 Python 软件包

```bash
pip install geojson
```

### 点（Point）



### 点集合（MultiPoint）



### 线（LineString）



### 线集合（MultiLineString）



### 多边形（Polygon）



### 多边形集合（MultiPolygon）



### 几何集合（GeometryCollection）



### 要素对象（Feature）



### 要素集合对象（FeatureCollection）



### GeoJSON 编解码



### 自定义类



### 实用程序





## 参考

- [https://zh.wikipedia.org/zh-cn/GeoJSON](https://zh.wikipedia.org/zh-cn/GeoJSON)
- [https://www.osgeo.cn/pygis/others-geojson.html](https://www.osgeo.cn/pygis/others-geojson.html)
- [Python地理数据可视化工具mapboxgl jupyter](https://www.biaodianfu.com/mapboxgl-jupyter.html)

