#Setting directory
setwd("D:/Learning/Kaggle/Digit Recogniser")
#Importing datasets

# Creates a simple random forest benchmark

library(randomForest)
library(data.table)

set.seed(100)

train <- as.data.frame(fread("train.csv"))
train$label <- as.factor(train$label)
test <- as.data.frame(fread("test.csv"))
