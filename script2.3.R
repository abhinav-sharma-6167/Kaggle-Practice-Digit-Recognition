setwd("D:/Learning/Kaggle/Digit Recogniser")
library(readr)
zip.train <- read_csv("train.csv")
zip.test <- read_csv("test.csv")

X.train = zip.train[,-1]
y.train = zip.train[,1]

# Normalized Image
X.norm = X.train/255
X.cov = cov(X.norm) 

# Function in order to see the differents numbers
drawDigit <- function(x) {
  for (i in 1:28) {
    for (j in 1:28) {
      color <- gray((x[(i - 1) * 28 + j]/255))
      grid.rect(j, 28 - i, 1, 1, default.units = "native",
                gp = gpar(col = color, fill = color))
    }
  }
}

pca_out = prcomp(x = X.cov) # If centered add center = TRUE

# How many values do we keep for the PCA?
barplot((pca_out$sdev[1:60]^2/sum(pca_out$sdev^2)) * 100, 
        xlab = "axe k", ylab = "inertia")
# keep the 30 first values
rotX = as.matrix(X.norm) %*% pca_out$rotation[,1:30]

# Model
ntreeMod <- 200 # can be changed depending of the runtime
library(randomForest)
reg.rf <- randomForest(as.factor(y.train) ~.,data = rotX,
                       ntree= ntreeMod)


## Predicition

# Normalizing the data test
test.work = (zip.test/255)#-mean(as.matrix(X.norm))
test.rot = as.matrix(test.work) %*% pca_out$rotation[,1:30]


prev.rf <-predict(reg.rf,test.rot)
# Comparision of the first 25 values with the images
prev.rf[1:25]
#Visiualisation of the first 25 images
library(grid)
grid.newpage()
pushViewport(viewport(xscale = c(0, 6), yscale = c(0, 6)))
for (k in 1:25) {
  pushViewport(viewport(x = (k - 1)%%5 + 1, y = 5 - floor((k - 1)/5), width = 1, 
                        height = 1, xscale = c(0, 28), yscale = c(0, 28),
                        default.units = "native"))
  drawDigit(zip.test[k, ])
  popViewport(1)
}
popViewport(1)


# Creating file for the competition
prediction <- as.data.frame(prev.rf)
finalprediction<- cbind(as.data.frame(1:nrow(prediction)),prediction)
colnames(finalprediction) <- c("ImageId","Label")
write.csv(finalprediction,file="rfPCAs.csv",row.names=FALSE)

