#肖航SA23008149
#第十次作业
# 加载所需的库
library(tidyverse)
library(tsibble)
library(ggplot2)
library(tidymodels)
library(lubridate)
# 设定数据集文件路径
data_path <- "/home/kali/13095380/Prunier et al._RawBiomassData.txt"

# 读取数据集
fish_data <- read_csv(data_path)

# 筛选指定站点和物种的数据
selected_data <- fish_data %>%
  filter(STATION == "VERCah", SP == "VIA") %>%
  select(DATE, DENSITY) %>%
  mutate(DATE = ymd(DATE))  # 使用lubridate将日期列转换为Date格式

# 查看筛选后的数据的前几行
head(selected_data)
# 使用 separate() 函数拆分字符串列
fish_data <- fish_data %>%
  separate(`STATION YEAR DATE X_L93 Y_L93 SP BIOMASS DENSITY`,
           into = c("STATION", "YEAR", "DATE", "X_L93", "Y_L93", "SP", "BIOMASS", "DENSITY"),
           sep = " ")

# 查看拆分后的数据结构和列名
str(fish_data)
colnames(fish_data)
# 将 BIOMASS 和 DENSITY 列转换为数值型
fish_data <- fish_data %>%
  mutate(
    YEAR = as.integer(YEAR),  # 将 YEAR 列转换为整数型
    BIOMASS = as.numeric(BIOMASS),  # 将 BIOMASS 列转换为数值型
    DENSITY = as.numeric(DENSITY)  # 将 DENSITY 列转换为数值型
  )

# 查看转换后的数据结构和前几行数据
str(fish_data)
head(fish_data)
# 筛选出 VERCah 站点的 VAI 物种数据
selected_data <- fish_data %>%
  filter(STATION == "VERCah", SP == "VAI") %>%
  select(DATE, DENSITY)  # 选择日期和鱼类密度列

# 将 DATE 列转换为 Date 类型
selected_data$DATE <- as.Date(selected_data$DATE)

# 创建时间序列对象并进行可视化
if (nrow(selected_data) > 0) {
  time_series <- ts(selected_data$DENSITY, start = min(selected_data$DATE), frequency = 12)
  
  # 可视化时间序列
  plot(time_series, main = "Fish Density Time Series at VERCah (Species: VAI)",
       ylab = "Density", xlab = "Date")
} else {
  print("No observations found for VERCah station and VAI species.")
}
