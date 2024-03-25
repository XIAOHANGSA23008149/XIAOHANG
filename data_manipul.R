# 导入所需的库
library(tidyverse)  # 用于数据处理
library(ggplot2)    # 用于数据可视化

# 1. 导入和保存数据
# 假设你的工作目录中有一个名为 "example_data.csv" 的CSV文件
# 你可以使用tidyverse中的read_csv()函数导入数据，并将其保存到一个数据框中
example_data <- read_csv("example_data.csv")

# 2. 检查数据结构
# 打印数据框的结构以了解其变量和类型
str(example_data)

# 3. 检查列或行是否有缺失数据
# 使用any()函数和is.na()函数来检查是否有任何列具有缺失值
col_missing <- any(colSums(is.na(example_data)) > 0)
if (col_missing) {
  print("数据集中有缺失值。")
} else {
  print("数据集中没有缺失值。")
}

# 4. 从列中提取值或选择/添加列
# 使用$或[[]]表示法从列中提取值（例如，名为 "variable" 的列）
variable_values <- example_data$variable

# 使用dplyr中的select()或mutate()函数选择/添加列
# 例如，添加一个名为 "new_column" 的新列，并计算一些值
example_data <- example_data %>%
  mutate(new_column = variable_values * 2)

# 5. 将宽表转换为长表
# 使用tidyr中的gather()函数将宽表转换为长表
long_data <- example_data %>%
  gather(key = "variable_type", value = "value", -new_column)

# 6. 对数据进行可视化
# 使用ggplot2进行绘图
# 例如，创建一个散点图，将value绘制在new_column上
ggplot(long_data, aes(x = new_column, y = value, color = variable_type)) +
  geom_point() +
  labs(title = "Value在New Column上的散点图",
       x = "New Column",
       y = "Value",
       color = "变量类型")
