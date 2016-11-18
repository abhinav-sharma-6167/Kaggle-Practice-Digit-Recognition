# Using the neural networks
#Setting directory
setwd("D:/Learning/Kaggle/Digit Recogniser")
#Importing datasets

# Creates a simple random forest benchmark

library(randomForest)
library(readr)

library(neuralnet)

set.seed(100)


#read data
train <- read_csv("train.csv")
test <- read_csv("test.csv")


#Remove label from train and normalize the values
train_norm = train[,-1]/255


train_norm$label = train$label

# add dummy label variables
#fuction carried out is below

#train_norm$labd_00[train$label == 0]<-1
#train_norm$labd_00[train$label != 0]<-0

train_norm$labd_0 = (train$label == 0)*1
train_norm$labd_1 = (train$label == 1)*1
train_norm$labd_2 = (train$label == 2)*1
train_norm$labd_3 = (train$label == 3)*1
train_norm$labd_4 = (train$label == 4)*1
train_norm$labd_5 = (train$label == 5)*1
train_norm$labd_6 = (train$label == 6)*1
train_norm$labd_7 = (train$label == 7)*1
train_norm$labd_8 = (train$label == 8)*1
train_norm$labd_9 = (train$label == 9)*1

apply(train_norm, 2, max)

n = names(train_norm)

f = as.formula(paste(paste(names(train_norm)[786:795], collapse = " + ")," ~ ",paste(names(train_norm)[1:784], collapse = " + ")))

train_norm_sample = train_norm[1:10000,]


nn_1 <- neuralnet(f,data=train_norm_sample,hidden=c(10), linear.output = FALSE, learningrate = ) # try: learningrate



print(nn_1)