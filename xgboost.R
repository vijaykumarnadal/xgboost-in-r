#xgboost in r
library(xgboost)
'%ni%'<-Negate('%in%')
#here we are using iris dataset
irisdata<-iris
#we will convert species column into integer
irisdata$Species<-as.integer(factor(irisdata$Species))-1
#splitting the data into training and testing
s<-sample(2,nrow(irisdata),replace = T,prob = c(0.7,0.3))
iristrain<-irisdata[s==1,]
iristest<-irisdata[s==2,]
#creating datamatrix for training the dataset
train_xg<-xgb.DMatrix(data.matrix(iristrain[, colnames(iristrain) %ni% 'Species']), 
                      label = iristrain$Species)
test_xg<-xgb.DMatrix(data.matrix(iristest[, colnames(iristest) %ni% 'Species']))
watchlist <- list(train = train_xg, test = test_xg)
param <- list("objective" = "multi:softmax",
              "eval_metric" = "mlogloss",
              "num_class" = 3)
# Build the XGBoost model
nrounds = 50
xgMod = xgboost(param=param, data = trainData_xg, nrounds=nrounds, watchlist=watchlist)
#variable importance
names <- colnames(iristrain)[colnames(iristrain) %ni% 'Species']  
# Compute feature importance matrix
featureImp <- xgb.importance(names, model = xgMod)
featureImp
# Predict
pred <- predict(xgMod, testData_xg)

#to do things
#tune parameters and use cross vaidation method
#more params
