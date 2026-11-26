---
sidebar_position: 4
slug: /geographic-data-storage-processing
authors: [luhuadong]
---

# 地理数据存储与处理

地理数据存储与处理是 GIS 系统的基础，它涉及空间数据模型、空间数据库、数据格式转换、数据处理等多个方面。理解地理数据存储与处理，对于开发 GIS 系统、管理地理数据、进行空间分析都非常重要。本文将介绍地理数据存储与处理的核心技术和实践。

## 空间数据模型

### 1. 矢量数据模型

**基本要素**：
- **点（Point）**：表示位置
- **线（Line）**：表示路径、边界
- **面（Polygon）**：表示区域

**数据结构**：
```javascript
// 矢量数据结构
const vectorData = {
  type: "FeatureCollection",
  features: [
    {
      type: "Feature",
      geometry: {
        type: "Point",
        coordinates: [116.4074, 39.9042]
      },
      properties: {
        name: "北京",
        population: 21540000
      }
    },
    {
      type: "Feature",
      geometry: {
        type: "Polygon",
        coordinates: [[
          [116.3, 39.8],
          [116.5, 39.8],
          [116.5, 40.0],
          [116.3, 40.0],
          [116.3, 39.8]
        ]]
      },
      properties: {
        name: "北京市区",
        area: 1000
      }
    }
  ]
};
```

### 2. 栅格数据模型

**基本要素**：
- **像元（Pixel）**：最小单位
- **栅格**：规则网格
- **值**：每个像元的值

**数据结构**：
```javascript
// 栅格数据结构
const rasterData = {
  width: 1000,
  height: 1000,
  bounds: {
    minX: 116.3,
    minY: 39.8,
    maxX: 116.5,
    maxY: 40.0
  },
  data: new Array(1000 * 1000).fill(0), // 栅格数据
  noDataValue: -9999
};
```

## 空间数据库

### 1. PostGIS

**创建空间表**：
```sql
-- 启用 PostGIS 扩展
CREATE EXTENSION IF NOT EXISTS postgis;

-- 创建空间表
CREATE TABLE cities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    location GEOMETRY(POINT, 4326),
    boundary GEOMETRY(POLYGON, 4326)
);

-- 创建空间索引
CREATE INDEX idx_cities_location ON cities USING GIST (location);
CREATE INDEX idx_cities_boundary ON cities USING GIST (boundary);
```

**空间查询**：
```sql
-- 查询范围内的点
SELECT name, ST_AsText(location)
FROM cities
WHERE ST_DWithin(
    location,
    ST_GeomFromText('POINT(116.4074 39.9042)', 4326),
    0.1
);

-- 计算距离
SELECT 
    name,
    ST_Distance(
        location,
        ST_GeomFromText('POINT(116.4074 39.9042)', 4326)
    ) * 111 AS distance_km
FROM cities
ORDER BY distance_km
LIMIT 10;
```

### 2. MongoDB

**存储地理数据**：
```javascript
// MongoDB 地理数据存储
const citySchema = {
  name: String,
  location: {
    type: {
      type: String,
      enum: ['Point'],
      required: true
    },
    coordinates: {
      type: [Number],
      required: true
    }
  }
};

// 创建地理索引
db.cities.createIndex({ location: "2dsphere" });

// 查询附近的城市
db.cities.find({
  location: {
    $near: {
      $geometry: {
        type: "Point",
        coordinates: [116.4074, 39.9042]
      },
      $maxDistance: 10000 // 10 公里
    }
  }
});
```

### 3. Redis

**存储地理数据**：
```javascript
// Redis GeoHash
const redis = require('redis');
const client = redis.createClient();

// 添加地理位置
client.geoadd('cities', 116.4074, 39.9042, '北京');
client.geoadd('cities', 121.4737, 31.2304, '上海');

// 查询附近的城市
client.georadius('cities', 116.4074, 39.9042, 100, 'km', (err, result) => {
  console.log(result);
});
```

## 数据格式转换

### 1. GeoJSON

**读取 GeoJSON**：
```javascript
// 读取 GeoJSON
const fs = require('fs');
const geojson = JSON.parse(fs.readFileSync('data.geojson', 'utf8'));

// 处理 GeoJSON
geojson.features.forEach(feature => {
  console.log(feature.properties.name);
  console.log(feature.geometry.coordinates);
});
```

**写入 GeoJSON**：
```javascript
// 写入 GeoJSON
const geojson = {
  type: "FeatureCollection",
  features: [
    {
      type: "Feature",
      geometry: {
        type: "Point",
        coordinates: [116.4074, 39.9042]
      },
      properties: {
        name: "北京"
      }
    }
  ]
};

fs.writeFileSync('output.geojson', JSON.stringify(geojson, null, 2));
```

### 2. Shapefile

**读取 Shapefile**：
```javascript
// 使用 shapefile 库读取
const shapefile = require('shapefile');

shapefile.open('data.shp')
  .then(source => source.read()
    .then(function log(result) {
      if (result.done) return;
      console.log(result.value);
      return source.read().then(log);
    })
  );
```

### 3. KML

**读取 KML**：
```javascript
// 使用 @mapbox/togeojson 转换 KML
const toGeoJSON = require('@mapbox/togeojson');
const fs = require('fs');
const DOMParser = require('xmldom').DOMParser;

const kml = new DOMParser().parseFromString(
  fs.readFileSync('data.kml', 'utf8')
);
const geojson = toGeoJSON.kml(kml);
```

## 数据处理

### 1. 数据清洗

**清洗数据**：
```javascript
// 数据清洗
function cleanGeographicData(data) {
  return data.features
    .filter(feature => {
      // 过滤无效几何
      if (!feature.geometry || !feature.geometry.coordinates) {
        return false;
      }
      
      // 验证坐标范围
      const coords = feature.geometry.coordinates;
      if (feature.geometry.type === 'Point') {
        const [lng, lat] = coords;
        if (lng < -180 || lng > 180 || lat < -90 || lat > 90) {
          return false;
        }
      }
      
      return true;
    })
    .map(feature => {
      // 标准化属性
      const properties = {};
      Object.keys(feature.properties).forEach(key => {
        const normalizedKey = key.toLowerCase().trim();
        properties[normalizedKey] = feature.properties[key];
      });
      
      return {
        ...feature,
        properties: properties
      };
    });
}
```

### 2. 数据转换

**坐标转换**：
```javascript
// 坐标转换
function transformCoordinates(feature, fromCRS, toCRS) {
  // 使用 proj4 进行坐标转换
  const proj4 = require('proj4');
  
  const transform = proj4(fromCRS, toCRS);
  
  function transformCoords(coords) {
    if (typeof coords[0] === 'number') {
      return transform(coords);
    }
    return coords.map(transformCoords);
  }
  
  return {
    ...feature,
    geometry: {
      ...feature.geometry,
      coordinates: transformCoords(feature.geometry.coordinates)
    }
  };
}
```

### 3. 数据聚合

**聚合数据**：
```javascript
// 数据聚合
function aggregateData(features, groupBy) {
  const groups = {};
  
  features.forEach(feature => {
    const key = feature.properties[groupBy];
    if (!groups[key]) {
      groups[key] = [];
    }
    groups[key].push(feature);
  });
  
  return Object.keys(groups).map(key => ({
    key: key,
    count: groups[key].length,
    features: groups[key]
  }));
}
```

## 性能优化

### 1. 空间索引

**创建索引**：
```sql
-- PostGIS 空间索引
CREATE INDEX idx_location ON cities USING GIST (location);

-- MongoDB 地理索引
db.cities.createIndex({ location: "2dsphere" });
```

### 2. 数据简化

**简化几何**：
```javascript
// 使用 Turf.js 简化几何
const turf = require('@turf/turf');

function simplifyGeometry(feature, tolerance) {
  return turf.simplify(feature, {
    tolerance: tolerance,
    highQuality: false
  });
}
```

### 3. 数据分片

**分片策略**：
```javascript
// 数据分片
function tileData(features, zoom) {
  const tiles = {};
  
  features.forEach(feature => {
    const bbox = turf.bbox(feature);
    const tileX = Math.floor((bbox[0] + 180) / 360 * Math.pow(2, zoom));
    const tileY = Math.floor((90 - bbox[3]) / 180 * Math.pow(2, zoom));
    const key = `${zoom}/${tileX}/${tileY}`;
    
    if (!tiles[key]) {
      tiles[key] = [];
    }
    tiles[key].push(feature);
  });
  
  return tiles;
}
```

## 数据验证

### 1. 几何验证

**验证几何**：
```javascript
// 几何验证
function validateGeometry(feature) {
  const errors = [];
  
  // 验证坐标
  if (!feature.geometry || !feature.geometry.coordinates) {
    errors.push('Missing geometry');
    return errors;
  }
  
  // 验证坐标范围
  const coords = feature.geometry.coordinates;
  if (feature.geometry.type === 'Point') {
    const [lng, lat] = coords;
    if (lng < -180 || lng > 180) {
      errors.push('Longitude out of range');
    }
    if (lat < -90 || lat > 90) {
      errors.push('Latitude out of range');
    }
  }
  
  return errors;
}
```

### 2. 拓扑验证

**验证拓扑**：
```javascript
// 拓扑验证
function validateTopology(features) {
  const errors = [];
  
  // 检查重叠
  for (let i = 0; i < features.length; i++) {
    for (let j = i + 1; j < features.length; j++) {
      if (turf.intersect(features[i], features[j])) {
        errors.push(`Features ${i} and ${j} overlap`);
      }
    }
  }
  
  return errors;
}
```

## 小结

地理数据存储与处理涉及多个方面：

- **数据模型**：矢量数据模型和栅格数据模型
- **空间数据库**：PostGIS、MongoDB、Redis 等
- **数据格式**：GeoJSON、Shapefile、KML 等
- **数据处理**：数据清洗、转换、聚合
- **性能优化**：空间索引、数据简化、数据分片
- **数据验证**：几何验证、拓扑验证

掌握地理数据存储与处理的知识，你就能高效地管理地理数据、进行空间分析！

---

> 💡 **思考题**：为什么需要空间数据库？如何优化地理数据的查询性能？答案在于空间数据需要特殊的存储和查询方式，而通过空间索引、数据简化、数据分片等方式可以优化性能！