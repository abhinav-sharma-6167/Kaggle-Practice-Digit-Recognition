#Setting directory
setwd("D:/Learning/Kaggle/Digit Recogniser")
#Importing datasets

# Creates a simple random forest benchmark

library(randomForest)
library(data.table)

set.seed(100)

#making a data.frame, having 
train <- as.data.frame(fread("train.csv"))
train$label <- as.factor(train$label)
test <- as.data.frame(fread("test.csv"))



rotate <- function(x) t(apply(x, 2, rev))
m = rotate(matrix(unlist(train[45,-1]),nrow = 28,byrow = TRUE))
a<-m


p<-c(1:28)
for(i in p){
  for (j in p) {
    a[i,j]<-127
  if( m[i,j]<=63) a[i,j]<-0
  if( m[i,j]>=190) a[i,j]<-255
  
  
  }
}
