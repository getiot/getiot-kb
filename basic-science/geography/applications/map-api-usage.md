---
sidebar_position: 3
slug: /map-api-usage
authors: [luhuadong]
---

# 地图 API 的使用

地图 API 是开发地图应用的重要工具，它提供了地图显示、地理编码、路径规划等功能。理解地图 API 的使用，对于开发地图应用、集成地图服务、提升用户体验都非常重要。本文将介绍主流地图 API 的使用方法。

## 主流地图 API

### 1. Google Maps API

**特点**：
- **功能强大**：功能强大
- **全球覆盖**：全球覆盖
- **文档完善**：文档完善

**基本使用**：
```javascript
// Google Maps API
function initGoogleMap() {
  const map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: 39.9042, lng: 116.4074 },
    zoom: 13
  });
  
  // 添加标记
  const marker = new google.maps.Marker({
    position: { lat: 39.9042, lng: 116.4074 },
    map: map,
    title: '北京'
  });
  
  return map;
}
```

**地理编码**：
```javascript
// 地理编码
const geocoder = new google.maps.Geocoder();

geocoder.geocode({ address: '北京市天安门' }, (results, status) => {
  if (status === 'OK') {
    const location = results[0].geometry.location;
    console.log('Latitude:', location.lat());
    console.log('Longitude:', location.lng());
  }
});
```

**路径规划**：
```javascript
// 路径规划
const directionsService = new google.maps.DirectionsService();
const directionsRenderer = new google.maps.DirectionsRenderer();

directionsService.route({
  origin: '北京市天安门',
  destination: '北京市故宫',
  travelMode: google.maps.TravelMode.DRIVING
}, (result, status) => {
  if (status === 'OK') {
    directionsRenderer.setDirections(result);
  }
});
```

### 2. 高德地图 API

**特点**：
- **中国覆盖**：中国覆盖好
- **中文支持**：中文支持好
- **免费额度**：有免费额度

**基本使用**：
```javascript
// 高德地图 API
function initAMap() {
  const map = new AMap.Map('map', {
    center: [116.4074, 39.9042],
    zoom: 13
  });
  
  // 添加标记
  const marker = new AMap.Marker({
    position: [116.4074, 39.9042],
    title: '北京'
  });
  map.add(marker);
  
  return map;
}
```

**地理编码**：
```javascript
// 地理编码
const geocoder = new AMap.Geocoder();

geocoder.getLocation('北京市天安门', (status, result) => {
  if (status === 'complete') {
    const location = result.geocodes[0].location;
    console.log('Latitude:', location.lat);
    console.log('Longitude:', location.lng);
  }
});
```

**路径规划**：
```javascript
// 路径规划
const driving = new AMap.Driving({
  map: map,
  panel: 'panel'
});

driving.search(
  new AMap.LngLat(116.379028, 39.865042), // 起点
  new AMap.LngLat(116.427281, 39.903719), // 终点
  (status, result) => {
    if (status === 'complete') {
      console.log('路径规划成功');
    }
  }
);
```

### 3. 百度地图 API

**特点**：
- **中国覆盖**：中国覆盖好
- **中文支持**：中文支持好
- **功能丰富**：功能丰富

**基本使用**：
```javascript
// 百度地图 API
function initBaiduMap() {
  const map = new BMap.Map('map');
  const point = new BMap.Point(116.4074, 39.9042);
  map.centerAndZoom(point, 13);
  
  // 添加标记
  const marker = new BMap.Marker(point);
  map.addOverlay(marker);
  
  return map;
}
```

**地理编码**：
```javascript
// 地理编码
const geocoder = new BMap.Geocoder();

geocoder.getPoint('北京市天安门', (point) => {
  if (point) {
    console.log('Latitude:', point.lat);
    console.log('Longitude:', point.lng);
  }
});
```

### 4. OpenStreetMap + Leaflet

**特点**：
- **开源免费**：开源免费
- **灵活**：灵活可定制
- **社区支持**：社区支持

**基本使用**：
```javascript
// Leaflet + OpenStreetMap
const map = L.map('map').setView([39.9042, 116.4074], 13);

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '© OpenStreetMap contributors',
  maxZoom: 19
}).addTo(map);

// 添加标记
const marker = L.marker([39.9042, 116.4074]).addTo(map);
marker.bindPopup('北京');
```

## 地图 API 核心功能

### 1. 地图显示

**显示地图**：
```javascript
// 通用地图显示函数
function displayMap(api, container, center, zoom) {
  switch(api) {
    case 'google':
      return initGoogleMap(container, center, zoom);
    case 'amap':
      return initAMap(container, center, zoom);
    case 'baidu':
      return initBaiduMap(container, center, zoom);
    case 'leaflet':
      return initLeafletMap(container, center, zoom);
  }
}
```

### 2. 地理编码

**地址转坐标**：
```javascript
// 地理编码（地址转坐标）
async function geocode(address, api) {
  switch(api) {
    case 'google':
      return geocodeGoogle(address);
    case 'amap':
      return geocodeAMap(address);
    case 'baidu':
      return geocodeBaidu(address);
  }
}
```

**逆地理编码**：
```javascript
// 逆地理编码（坐标转地址）
async function reverseGeocode(lat, lng, api) {
  switch(api) {
    case 'google':
      return reverseGeocodeGoogle(lat, lng);
    case 'amap':
      return reverseGeocodeAMap(lat, lng);
    case 'baidu':
      return reverseGeocodeBaidu(lat, lng);
  }
}
```

### 3. 路径规划

**规划路径**：
```javascript
// 路径规划
async function planRoute(start, end, mode, api) {
  switch(api) {
    case 'google':
      return planRouteGoogle(start, end, mode);
    case 'amap':
      return planRouteAMap(start, end, mode);
    case 'baidu':
      return planRouteBaidu(start, end, mode);
  }
}
```

### 4. 地点搜索

**搜索地点**：
```javascript
// 地点搜索
async function searchPlaces(keyword, location, radius, api) {
  switch(api) {
    case 'google':
      return searchPlacesGoogle(keyword, location, radius);
    case 'amap':
      return searchPlacesAMap(keyword, location, radius);
    case 'baidu':
      return searchPlacesBaidu(keyword, location, radius);
  }
}
```

## 坐标系统转换

### 1. WGS84 转 GCJ02

**转换算法**：
```javascript
// WGS84 转 GCJ02（火星坐标系）
function wgs84ToGcj02(lng, lat) {
  const a = 6378245.0;
  const ee = 0.00669342162296594323;
  
  let dLat = transformLat(lng - 105.0, lat - 35.0);
  let dLng = transformLng(lng - 105.0, lat - 35.0);
  
  const radLat = lat / 180.0 * Math.PI;
  let magic = Math.sin(radLat);
  magic = 1 - ee * magic * magic;
  const sqrtMagic = Math.sqrt(magic);
  dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * Math.PI);
  dLng = (dLng * 180.0) / (a / sqrtMagic * Math.cos(radLat) * Math.PI);
  
  return [lng + dLng, lat + dLat];
}

function transformLat(lng, lat) {
  let ret = -100.0 + 2.0 * lng + 3.0 * lat + 0.2 * lat * lat + 
    0.1 * lng * lat + 0.2 * Math.sqrt(Math.abs(lng));
  ret += (20.0 * Math.sin(6.0 * lng * Math.PI) + 20.0 * 
    Math.sin(2.0 * lng * Math.PI)) * 2.0 / 3.0;
  ret += (20.0 * Math.sin(lat * Math.PI) + 40.0 * 
    Math.sin(lat / 3.0 * Math.PI)) * 2.0 / 3.0;
  ret += (160.0 * Math.sin(lat / 12.0 * Math.PI) + 320 * 
    Math.sin(lat * Math.PI / 30.0)) * 2.0 / 3.0;
  return ret;
}

function transformLng(lng, lat) {
  let ret = 300.0 + lng + 2.0 * lat + 0.1 * lng * lng + 
    0.1 * lng * lat + 0.1 * Math.sqrt(Math.abs(lng));
  ret += (20.0 * Math.sin(6.0 * lng * Math.PI) + 20.0 * 
    Math.sin(2.0 * lng * Math.PI)) * 2.0 / 3.0;
  ret += (20.0 * Math.sin(lng * Math.PI) + 40.0 * 
    Math.sin(lng / 3.0 * Math.PI)) * 2.0 / 3.0;
  ret += (150.0 * Math.sin(lng / 12.0 * Math.PI) + 300.0 * 
    Math.sin(lng / 30.0 * Math.PI)) * 2.0 / 3.0;
  return ret;
}
```

### 2. GCJ02 转 BD09

**转换算法**：
```javascript
// GCJ02 转 BD09（百度坐标系）
function gcj02ToBd09(lng, lat) {
  const z = Math.sqrt(lng * lng + lat * lat) + 0.00002 * Math.sin(lat * Math.PI * 3000.0 / 180.0);
  const theta = Math.atan2(lat, lng) + 0.000003 * Math.cos(lng * Math.PI * 3000.0 / 180.0);
  
  return [
    z * Math.cos(theta) + 0.0065,
    z * Math.sin(theta) + 0.006
  ];
}
```

## 最佳实践

### 1. API 密钥管理

**安全存储**：
```javascript
// API 密钥管理
const API_KEYS = {
  google: process.env.GOOGLE_MAPS_API_KEY,
  amap: process.env.AMAP_API_KEY,
  baidu: process.env.BAIDU_MAPS_API_KEY
};

function getApiKey(provider) {
  return API_KEYS[provider];
}
```

### 2. 错误处理

**统一错误处理**：
```javascript
// 统一错误处理
async function callMapAPI(apiFunction, ...args) {
  try {
    return await apiFunction(...args);
  } catch (error) {
    console.error('Map API Error:', error);
    // 记录错误
    logError(error);
    // 返回默认值或重试
    return handleError(error);
  }
}
```

### 3. 性能优化

**优化策略**：
- **缓存结果**：缓存 API 调用结果
- **批量请求**：批量处理请求
- **延迟加载**：延迟加载地图

```javascript
// 结果缓存
const apiCache = new Map();

async function cachedApiCall(key, apiFunction, ...args) {
  if (apiCache.has(key)) {
    return apiCache.get(key);
  }
  
  const result = await apiFunction(...args);
  apiCache.set(key, result);
  
  // 设置过期时间
  setTimeout(() => apiCache.delete(key), 3600000); // 1 小时
  
  return result;
}
```

## 小结

地图 API 是开发地图应用的重要工具：

- **主流 API**：Google Maps、高德地图、百度地图、OpenStreetMap
- **核心功能**：地图显示、地理编码、路径规划、地点搜索
- **坐标转换**：WGS84、GCJ02、BD09 之间的转换
- **最佳实践**：API 密钥管理、错误处理、性能优化

掌握地图 API 的使用，你就能开发出功能完善的地图应用！

---

> 💡 **思考题**：为什么不同地图 API 使用不同的坐标系统？如何选择合适的地图 API？答案在于不同地区使用不同的坐标系统，而选择 API 需要考虑覆盖范围、功能需求、成本等因素！