########## Rough ##############

rm(list=ls(all=TRUE))

getwd()
setwd("/Users/samyam/Documents/Samya/Insofe/insofe/day10/datasets")
getwd()


data = data.frame(X=c(10,12,11,15,18), Y=c(18,24,20,29,35))
cov(data$Y, data$X)
cor(data$Y, data$X)
data$NewX = data$X*230
data$NewY = data$Y*1000
cov(data$NewX, data$NewY)
cor(data$NewX, data$NewY)


########## Linear Regression ##############

#understanding of data
library(DMwR)
data = read.csv("Data_Regression.csv", header = T, sep = ",")
dim(data)
head(data)
names(data)
str(data)
summary(data)
# Observations:-
# 1. We have 36 datapoints, 2 features
# 2. Both the features are int(numeric)
# 3. Feature Y can probablity have a outlier as the 3rd Qu value is much less than Max.


#See relations between models
plot(data$X, data$Y)
cor(data$X, data$Y) #47% corelation
cov(data$X, data$Y)


#model building
model_lm = lm(Y~X, data = data)
data$predict = predict(model_lm, data)
head(data)
tail(data)


#Evaluation of model
regr.eval(data$Y, data$predict)
summary(model_lm)


par(mfrow=c(2,2))
plot(model_lm)


data$lev = (((data$X - mean(data$X))/sd(data$X))^2 +1)/36
data$resid = model_lm$residuals
head(data, 36)
#Which datapoint has the highest leverage
data[which.max(data$lev),]
#From the plot we can see point 10 has highest residual, but using the above we see point 33 has the highest.


#Which of the models are significant?
data$cook = round(cooks.distance(model_lm),2)
head(data)


#Lets remove those outlier points
data1 = data[-c(10, 33), c(1,2)]
head(data1)
model_lm_1 = lm(Y~X, data=data1)
data1$predict = predict(model_lm_1, data1)
regr.eval(data$Y, data$predict)
summary(model_lm_1)
plot(data1$X, data1$Y)
par(mfrow=c(2,2))
plot(model_lm_1)



############ Practice Question ###############

#understanding of data
library(DMwR)
data = read.csv("Toyota.csv", header = T, sep = ",")
dim(data)
head(data)
names(data)
str(data)
summary(data)
#Observations--------------

#Drop not required columns
data = data[, c('Price', 'Age_06_15')]
head(data)
names(data)[2] = 'Age'
head(data)

#Check for relationship
plot(data$Age, data$Price)
cor(data$Age, data$Price)
cov(data$Age, data$Price)

model_lm = lm(Price~Age, data = data)
summary(model_lm)
par(mfrow=c(2,2))
plot(model_lm)
#Observations(Residual Analysis)--------------

head(data)
data$predict = predict(model_lm, data)
head(data)
regr.eval(data$Price, data$predict)

