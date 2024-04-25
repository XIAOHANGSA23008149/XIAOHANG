#肖航
#SA23008149
#第八次作业
# 加载必要的库
library(sf)

# 加载 Le Doubs 河流的 Shapefile 文件
#使用的是从OpenStreetmap里下载的osm格式文件然后通过Qgis转成Shp格式
le_doubs <- st_read("/home/kali/Desktop/kali/LE_doubs.shp")


# 检查 Le Doubs 河流数据的坐标参考系统 (CRS)
st_crs(le_doubs)


# 假设 CRS 是以米为单位的 (如果不是，请重新投影数据)

# 创建沿着 Le Doubs 河流的 2 公里缓冲区
buffer_2km <- st_buffer(le_doubs, dist = 2000)  # 2000 米 = 2 公里

# 加载要裁剪的地图
map_to_clip <- st_read("/home/kali/Desktop/kali/LE_doubs.shp")

# 检查要裁剪的地图的坐标参考系统
st_crs(map_to_clip)

# 假设地图的 CRS 与 Le Doubs 河流的 CRS 匹配，如果不匹配，需要重新投影

# 使用 Le Doubs 河流的 2 公里缓冲区对地图进行裁剪
clipped_map <- st_intersection(map_to_clip, buffer_2km)

# 将裁剪后的地图保存为新的 Shapefile 文件
st_write(clipped_map, "/home/kali/Desktop/kali/clipped_map.shp")
