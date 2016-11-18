#Setting directory
setwd("D:/Learning/Kaggle/Digit Recogniser")
#Importing datasets

# Creates a simple random forest benchmark

library(randomForest)
library(readr)

set.seed(0)

numTrain <- 10000
numTrees <- 250

train <- read_csv("D:/Learning/Kaggle/Digit Recogniser/train.csv")
test <- read_csv("D:/Learning/Kaggle/Digit Recogniser/test.csv")

#Taking 10000 samples
rows <- sample(1:nrow(train), numTrain)

#Finding labels of all those samples, saved as factor cos u need to use random forest ahead
labels <- as.factor(train[rows,1])
#Removing all the labels from train data
train <- train[rows,-1]

rf <- randomForest(train, labels, xtest=test, ntree=numTrees, importance = TRUE, mtry = 2)
predictions <- data.frame(ImageId=1:nrow(test), Label=levels(labels)[rf$test$predicted])


write_csv(predictions, "rf_benchmark01.csv") 