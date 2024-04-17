#肖航
#SA23008149
#写一段简短的代码来移除 Doubs 数据集中存在缺失数据的站点，并检测环境因素是否存在共线性。
# 加载所需的库
library(tidyverse)
library(corrplot)
library(ade4)

# 加载 Doubs 数据集
data(doubs, package = 'ade4')

# 删除带有缺失数据的行
doubs_data <- na.omit(doubs$env)

# 检查环境因素之间的共线性
env_factors <- select(doubs_data, starts_with("dfs"))
env_corr <- cor(env_factors)

# 使用 corrplot 可视化共线性
corrplot(env_corr, method = "circle")

# 保存相关性图
png("env_factors_correlation.png")
corrplot(env_corr, method = "circle")
dev.off()

# 分析鱼类与环境因素之间的关系并对其进行可视化
# 绘制鱼类和环境因素之间的关系
fish_env_plot <- ggplot(doubs$fish, aes(x = Cogo, y = Satr)) +
  geom_point() +
  labs(x = "Cogo", y = "Satr") +
  theme_minimal()

# 保存图形
ggsave("fish_env_relationship.png", plot = fish_env_plot, width = 8, height = 6, dpi = 300)


