# 加载必要的库
library(caret)
library(randomForest)

# 加载数据集
data(mtcars)

# 检查数据集的结构
str(mtcars)

# 数据预处理
# 在 mtcars 数据集中没有缺失值需要处理

# 特征选择和可视化
# 散点图矩阵
pairs(mtcars)

# 将数据分割为训练集和测试集
set.seed(123) # 为了可重现性
train_index <- createDataPartition(mtcars$mpg, p = 0.8, list = FALSE)
train_data <- mtcars[train_index, ]
test_data <- mtcars[-train_index, ]

# 训练模型
# 定义控制参数
ctrl <- trainControl(method = "cv", number = 5)

# 使用随机森林算法训练模型
model <- train(mpg ~ ., data = train_data, method = "rf", trControl = ctrl)

# 打印模型摘要
print(model)

# 调整模型
# 在本示例中，随机森林没有调整参数

# 评估模型
# 在测试集上进行预测
predictions <- predict(model, newdata = test_data)

# 计算 RMSE
rmse <- sqrt(mean((predictions - test_data$mpg)^2))
print(paste("RMSE:", rmse))

# 可视化实际值与预测值
plot(predictions, test_data$mpg, main = "Actual vs. Predicted MPG", xlab = "Predicted MPG", ylab = "Actual MPG")

# 特征重要性图
varImp(model)

# 最终模型的摘要
summary(model)

# 保存模型
saveRDS(model, file = "random_forest_model.rds")
