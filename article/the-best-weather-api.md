---
sidebar_position: 9
slug: /the-best-weather-api
---

# 城市天气查询 API



本文收集一些好用的天气 Web API 平台，包括高德地图、心知天气、和风天气等等。使用这些 API，可以在你的应用程序或 Web 网页中增加天气情况、空气质量、水文等信息，改善用户体验。同时，我们也会介绍这些 Web API 的基本使用，包括天气城市代码的概念等等。



## 高德地图 API

高德地图的天气查询是一个简单的HTTP接口，根据用户输入的 `adcode`，查询目标区域当前/未来的天气情况。

**使用说明**：

- 第一步，申请 “web 服务 API” 密钥（Key）；
- 第二步，拼接 HTTP 请求 URL，第一步申请的 Key 需作为必填参数一同发送；
- 第三步，接收 HTTP 请求返回的数据（JSON 或 XML 格式），解析数据。
- 如无特殊声明，接口的输入参数和输出数据编码全部统一为 UTF-8。

**天气查询 API 服务地址**：（请求方式为 GET）

```bash
https://restapi.amap.com/v3/weather/weatherInfo?parameters
```

`parameters` 代表的参数包括必填参数和可选参数。所有参数均使用和号字符（&）进行分隔。

**更多信息**：

- [https://lbs.amap.com/api/webservice/guide/api/weatherinfo](https://lbs.amap.com/api/webservice/guide/api/weatherinfo)



## 心知天气 API

心知天气是中国气象局官方授权的商业气象服务公司，基于气象数值预报和人工智能技术，提供高精度气象数据、天气监控机器人、气象数据可视化产品，以及能源、电力、保险、农业、交通、互联网、物联网行业解决方案。

**更多信息**：

- [https://www.seniverse.com](https://www.seniverse.com)



## 和风天气 API

和风天气为开发者和企业用户提供了全球天气数据服务，并提供了天气API接口，天气插件，开源天气APP，天气SDK等开发工具，数据包括灾害预警、实时天气和预报、PM2.5空气质量AQI、台风、潮汐、日出日落、生活指数等。

**更多信息**：

- [https://dev.qweather.com](https://dev.qweather.com)



## 天气城市代码

当我们想要通过 Web API 查询天气时，需要提供你想要查询的城市对应的编码作为参数。例如：

- 北京市是 `110000`
- 上海市是 `310000`
- 广州市是 `440100`
- 深圳市是 `440300`
- 成都市是 `510100`
- 大理市是 `532901`
- 景德镇是 `360200`

这个编码是精确到县/区的，并且随着时间的推移可能会发生变化。因此，我们建议你通过地址解析等线上服务实时获取最新编码。

参考：[Web 服务 API 相关下载 - 高德开放平台](https://lbs.amap.com/api/webservice/download)
