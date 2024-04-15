#XIAOHANG
#SA23008149
#第五次作业
library(reticulate)  # 连接Python和R
library(rdataretriever)  # 用于检索数据
library(ade4)  # 数据集Doubs所在的包
library(RPostgreSQL)  # PostgreSQL 数据库连接包

# 连接到PostgreSQL数据库
db <- dbConnect(RPostgreSQL::PostgreSQL(), 
                dbname = "X", 
                host = "localhost", 
                port = 5432, 
                user = "XH", 
                password = "123456")

# 加载Doubs数据集
data("Doubs", package = "ade4")

# 将Doubs数据集转换为数据框
doubs_df <- as.data.frame(Doubs)

# 上传数据到数据库
dbWriteTable(db, "doubs_data", doubs_df)

# 关闭数据库连接
dbDisconnect(db)
