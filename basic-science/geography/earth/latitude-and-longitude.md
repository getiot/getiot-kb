---
sidebar_position: 4
slug: /latitude-and-longitude
authors: [luhuadong]
---

# 经纬度的概念

经度（Longitude）和纬度（Latitude）是地理坐标系的基本概念，用于确定地球上任意位置的准确位置。经度和纬度的概念和应用在各个领域都非常广泛，比如地图导航、气象预测、航海航空、旅游规划等等。本文将详细介绍经度和纬度的含义和计算方法，并探讨其在不同领域中的应用。



## 经度

经度（Longitude）是指位于地球表面上某一点的东西方位置，以子午线为基准，从 0° 到 180°，东经以正值表示，西经以负值表示。经度的计算方法基于地球的 360° 环形性质，每一度约对应着 111 公里的距离。

计算经度时，我们首先要确定一个参考点，通常选择本初子午线，即通过英国伦敦的经线。然后，根据被测点与参考点之间的夹角，可以计算出该点的经度。例如，如果被测点位于参考点的东侧 60° 处，则该点的经度为 60° 东经。

![](https://static.getiot.tech/longitude.webp#center)



## 纬度

纬度（Latitude）是指位于地球表面上某一点的南北位置，以赤道（Equator）为基准，从 0° 到 90°，北纬以正值表示，南纬以负值表示。纬度的计算方法是基于地球的赤道分为 360°，并以 90° 为北极和南极。

计算纬度时，我们需要确定一个参考点，通常选择赤道作为基准线。然后，根据被测点位于参考点的夹角，可以计算出该点的纬度。例如，如果被测点位于参考点的南侧 30° 处，则该点的纬度为 30° 南纬。

![](https://static.getiot.tech/latitude.webp#center)

## 经纬度的表示方法

### 度分秒表示法（DMS）

**格式**：度°分'秒"

**例子**：
- 北京天安门：39°54'27"N, 116°23'17"E
- 纽约自由女神像：40°41'21"N, 74°02'40"W

### 十进制度数表示法（DD）

**格式**：小数度数

**例子**：
- 北京天安门：39.9075°N, 116.3881°E
- 纽约自由女神像：40.6892°N, -74.0445°W（西经用负值表示）

### 两种表示法的转换

**度分秒 → 十进制度数**：
```
十进制度数 = 度 + 分/60 + 秒/3600
```

**十进制度数 → 度分秒**：
```
度 = 整数部分
分 = (小数部分 × 60) 的整数部分
秒 = ((小数部分 × 60) 的小数部分) × 60
```

**例子**：39°54'27" 转换为十进制度数
```
39 + 54/60 + 27/3600 = 39 + 0.9 + 0.0075 = 39.9075°
```

## 经纬度的应用

### 1. 定位

经纬度是 GPS 定位的基础，可以精确定位地球上的任意位置。

**精度**：
- **GPS 精度**：通常为 3-5 米
- **高精度 GPS**：可以达到厘米级精度

### 2. 导航

经纬度用于计算两点之间的距离和方向，是导航系统的基础。

**应用**：
- **路径规划**：计算最优路径
- **距离计算**：计算两点之间的距离
- **方向计算**：计算两点之间的方向

### 3. 地图制作

经纬度是地图制作的基础，用于将地球表面投影到平面上。

**应用**：
- **地图投影**：将球面坐标转换为平面坐标
- **地图标注**：在地图上标注位置
- **地图搜索**：根据经纬度搜索地点

## 经纬度在软件开发中的应用

### 1. 获取位置

**使用 GPS API**：
```javascript
// 获取当前位置
navigator.geolocation.getCurrentPosition(
  (position) => {
    const lat = position.coords.latitude;   // 纬度
    const lng = position.coords.longitude;   // 经度
    const accuracy = position.coords.accuracy; // 精度（米）
    
    console.log(`位置: ${lat}, ${lng}`);
    console.log(`精度: ${accuracy} 米`);
  },
  (error) => {
    console.error('获取位置失败:', error);
  }
);
```

### 2. 距离计算

**Haversine 公式**：计算地球表面两点之间的距离

```javascript
function calculateDistance(lat1, lng1, lat2, lng2) {
  const R = 6371000; // 地球半径（米）
  
  // 转换为弧度
  const dLat = (lat2 - lat1) * Math.PI / 180;
  const dLng = (lng2 - lng1) * Math.PI / 180;
  
  // Haversine 公式
  const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
            Math.sin(dLng/2) * Math.sin(dLng/2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
  
  return R * c; // 返回距离（米）
}

// 计算北京和上海之间的距离
const beijing = { lat: 39.9042, lng: 116.4074 };
const shanghai = { lat: 31.2304, lng: 121.4737 };
const distance = calculateDistance(
  beijing.lat, beijing.lng,
  shanghai.lat, shanghai.lng
);
console.log(`距离: ${(distance / 1000).toFixed(2)} 公里`);
```

### 3. 方向计算

**计算方位角**：
```javascript
function calculateBearing(lat1, lng1, lat2, lng2) {
  const dLng = (lng2 - lng1) * Math.PI / 180;
  const lat1Rad = lat1 * Math.PI / 180;
  const lat2Rad = lat2 * Math.PI / 180;
  
  const y = Math.sin(dLng) * Math.cos(lat2Rad);
  const x = Math.cos(lat1Rad) * Math.sin(lat2Rad) -
            Math.sin(lat1Rad) * Math.cos(lat2Rad) * Math.cos(dLng);
  
  const bearing = Math.atan2(y, x) * 180 / Math.PI;
  return (bearing + 360) % 360; // 转换为 0-360 度
}

// 转换为方向描述
function bearingToDirection(bearing) {
  const directions = ['正北', '东北', '正东', '东南', '正南', '西南', '正西', '西北'];
  const index = Math.round(bearing / 45) % 8;
  return directions[index];
}
```

### 4. 坐标转换

**度分秒 ↔ 十进制度数**：
```javascript
// 度分秒 → 十进制度数
function dmsToDD(degrees, minutes, seconds, direction) {
  let dd = degrees + minutes/60 + seconds/3600;
  if (direction === 'S' || direction === 'W') {
    dd = -dd;
  }
  return dd;
}

// 十进制度数 → 度分秒
function ddToDMS(dd) {
  const degrees = Math.floor(Math.abs(dd));
  const minutes = Math.floor((Math.abs(dd) - degrees) * 60);
  const seconds = ((Math.abs(dd) - degrees) * 60 - minutes) * 60;
  
  const direction = dd >= 0 ? 'N' : 'S'; // 纬度用 N/S，经度用 E/W
  return { degrees, minutes, seconds, direction };
}
```

### 5. 边界检查

**检查点是否在边界内**：
```javascript
function isPointInBounds(lat, lng, bounds) {
  return lat >= bounds.south &&
         lat <= bounds.north &&
         lng >= bounds.west &&
         lng <= bounds.east;
}

// 检查点是否在中国范围内
const chinaBounds = {
  north: 53.5588,
  south: 18.1977,
  east: 135.0000,
  west: 73.5577
};

const point = { lat: 39.9042, lng: 116.4074 }; // 北京
console.log(isPointInBounds(point.lat, point.lng, chinaBounds)); // true
```

### 6. 坐标系统转换

**WGS84 ↔ GCJ02**（中国常用的坐标系统）：
```javascript
// WGS84 转 GCJ02（火星坐标）
function wgs84ToGcj02(wgsLat, wgsLng) {
  const a = 6378245.0;
  const ee = 0.00669342162296594323;
  
  let dLat = transformLat(wgsLng - 105.0, wgsLat - 35.0);
  let dLng = transformLng(wgsLng - 105.0, wgsLat - 35.0);
  
  const radLat = wgsLat / 180.0 * Math.PI;
  let magic = Math.sin(radLat);
  magic = 1 - ee * magic * magic;
  const sqrtMagic = Math.sqrt(magic);
  dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * Math.PI);
  dLng = (dLng * 180.0) / (a / sqrtMagic * Math.cos(radLat) * Math.PI);
  
  return {
    lat: wgsLat + dLat,
    lng: wgsLng + dLng
  };
}

function transformLat(lng, lat) {
  let ret = -100.0 + 2.0 * lng + 3.0 * lat + 0.2 * lat * lat +
            0.1 * lng * lat + 0.2 * Math.sqrt(Math.abs(lng));
  ret += (20.0 * Math.sin(6.0 * lng * Math.PI) + 20.0 * Math.sin(2.0 * lng * Math.PI)) * 2.0 / 3.0;
  ret += (20.0 * Math.sin(lat * Math.PI) + 40.0 * Math.sin(lat / 3.0 * Math.PI)) * 2.0 / 3.0;
  ret += (160.0 * Math.sin(lat / 12.0 * Math.PI) + 320 * Math.sin(lat * Math.PI / 30.0)) * 2.0 / 3.0;
  return ret;
}

function transformLng(lng, lat) {
  let ret = 300.0 + lng + 2.0 * lat + 0.1 * lng * lng +
            0.1 * lng * lat + 0.1 * Math.sqrt(Math.abs(lng));
  ret += (20.0 * Math.sin(6.0 * lng * Math.PI) + 20.0 * Math.sin(2.0 * lng * Math.PI)) * 2.0 / 3.0;
  ret += (20.0 * Math.sin(lng * Math.PI) + 40.0 * Math.sin(lng / 3.0 * Math.PI)) * 2.0 / 3.0;
  ret += (150.0 * Math.sin(lng / 12.0 * Math.PI) + 300.0 * Math.sin(lng / 30.0 * Math.PI)) * 2.0 / 3.0;
  return ret;
}
```

## 常见坐标系统

### WGS84

**WGS84**（World Geodetic System 1984）是 GPS 使用的坐标系统，是全球通用的标准。

**特点**：
- **精度高**：GPS 定位精度高
- **全球通用**：被广泛使用
- **标准**：国际标准坐标系统

### GCJ02

**GCJ02**（国测局坐标系统）是中国使用的坐标系统，对 WGS84 进行了加密偏移。

**特点**：
- **中国标准**：中国官方使用的坐标系统
- **加密偏移**：对 WGS84 进行了加密
- **常用**：高德地图、腾讯地图使用

### BD09

**BD09**（百度坐标系统）是百度地图使用的坐标系统，对 GCJ02 进行了进一步偏移。

**特点**：
- **百度专用**：百度地图使用
- **二次偏移**：对 GCJ02 进行了偏移

## 小结

经纬度是地理坐标系的基础概念：

- **经度**：表示东西位置，从 0° 到 180°，东经为正，西经为负
- **纬度**：表示南北位置，从 0° 到 90°，北纬为正，南纬为负
- **表示方法**：度分秒（DMS）和十进制度数（DD）
- **应用**：定位、导航、地图制作

在软件开发中，经纬度用于：

- **获取位置**：使用 GPS API 获取用户位置
- **距离计算**：使用 Haversine 公式计算两点距离
- **方向计算**：计算两点之间的方向
- **坐标转换**：在不同坐标系统之间转换
- **边界检查**：检查点是否在特定区域内

理解经纬度，你就能更好地开发 GPS 导航、地图应用、位置服务等应用！

---

> 💡 **小贴士**：在使用经纬度时，要注意不同坐标系统之间的转换。在中国，GPS 返回的是 WGS84 坐标，但地图服务可能使用 GCJ02 或 BD09，需要进行坐标转换！
