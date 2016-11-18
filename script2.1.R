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


#to visualize the image
#making a function that



#  rotate <- function(x) t(apply(x, 2, rev))
#  m = rotate(matrix(unlist(train[45,-1]),nrow = 28,byrow = T))
#  image(m,col=grey.colors(255))


#Use of knn
library(class)
model1 <- knn(train[,2:785],test,cl=train[,1],k=10)
predictions <- data.frame(ImageId = seq(1,28000), Label = model1)
write.csv(predictions,file="knn_model.csv",row.names=FALSE)
