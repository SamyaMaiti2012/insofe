############ Practice Question ###############

rm(list=ls(all=TRUE))

#understanding of data
library(DMwR)
data = read.csv("/Users/samyam/Documents/Samya/Insofe/insofe/day10/Toyota-1546518196027.csv", header = T, sep = ",")
dim(data)
head(data)
names(data)
str(data)
summary(data)
# Observations
# 1. Id is a unique field.
# 2. Model is a categorical attribure.
# 3. Price has an wide range in values.


#Drop not required columns
data = data[, c('Age_06_15', 'Price')]
head(data)
names(data)[1] = 'Age'
head(data)

#Check for relationship
plot(data$Age, data$Price)
cor(data$Age, data$Price)
cov(data$Age, data$Price)

model_lm = lm(Price~Age, data = data)
summary(model_lm)
# Observations
# R2 of 76.84%
# P score is less than f 0.05 (95% CL), so the model is significant.
# P score for Y intersept is also very small, so the slope is significant.

par(mfrow=c(2,2))
plot(model_lm)
#Observations(Residual Analysis)
# The Residual plot is almost linear, with a few points (110, 111, 112) away.
# The qq plot is almost normal, with the few points (110, 111, 112) away.
# The Residual plot is almost homoscedastic.
# There looks to be similar trend for cooks distance also for thr above three points, which seeam sto be very influencial.

head(data)
data$predict = predict(model_lm, data)
head(data)
regr.eval(data$Price, data$predict)

#The RMSE looks to be fairly good.



# Now lets remove those 3 influential points.
dim(data)
data1 = data[-c(110, 111, 112), c(1,2)]
dim(data1)
head(data1)
names(data1)
str(data1)
summary(data1)


#Check for relationship
plot(data1$Age, data1$Price)
cor(data1$Age, data1$Price)
cov(data1$Age, data1$Price)
# Observation 
# Correlation Coefficient has improved from 87% to 88%, though not significant.


model_lm_1 = lm(Price~Age, data = data1)
summary(model_lm_1)
# Observation 
# R2 of 77.6%
# P score remains same for the model
# P score remains same for the Y intercept


par(mfrow=c(2,2))
plot(model_lm_1)
# All the 4 plots are more aligned to the assumptions of linear regression as compared to the previous mode.


head(data1)
data1$predict = predict(model_lm, data1)
head(data1)
regr.eval(data1$Price, data1$predict)

# The RMSE has gone bad.


# Hence the previous model is a better alternative.
