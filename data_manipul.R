#加载库
library(tidyverse)
#导入数据
data_example <- tibble(
  Name = c("XiaoHang", "Raradina", "Asgarta", "Diana","Tanaka"),
  Age = c(11, 45, 14, 19,81),
  countryside = c("China", "France", "India", "America","Japan")
)
#保存文件
write_csv(data_example, "data_example.csv")
#导入数据
data <- read_csv("data_example.csv")
#查看数据
glimpse(data)
# 检查每列的缺失数据
colSums(is.na(data))
# 检查每行的缺失数据
rowSums(is.na(data))
# 从数据框中提取一列
extracted_column <-data$Name
#使用dplyr的select函数提取
extracted_column <- select(data, Name)
# 向数据框中添加新列
data <- mutate(data, NewColumn = Age * 2)
# 5. 将宽格式表格转换为长格式
data_long <- pivot_longer(data, cols = -Name, names_to = "Variable", values_to = "Value")
# 6. 可视化数据
# 使用ggplot2绘制Age的直方图
library(ggplot2)
Age<- c(11,45,14,19,81)
ggplot(data = NULL, aes(x = Age)) +
  geom_histogram(binwidth = 2, fill = "skyblue", color = "black") +
  labs(title = "Height Distribution", x = "Age(year)", y = "Frequency")
# 保存修改后的数据框到新文件
write_csv(data, "modified_data.csv")