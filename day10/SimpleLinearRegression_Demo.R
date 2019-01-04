# Clear environment variables
rm(list=ls(all=TRUE))

# Create sample data frame
data = data.frame(X=c(10,12,11,15,18), Y= c(18,24,20,29,35))

### Covariance
cov(data$Y,data$X)

# Create new features
data$NewX=data$X*230; data$NewY=data$Y*1000

# Covariance
cov(data$NewY, data$NewX)

# Correlation
cor(data$X, data$Y)
cor(data$NewX,data$NewY)

# Observation: When the scales change, cov change but correlation doesn't

# Get current working directory
getwd()

# Set working directory
set(" ")


######Simple linear Regression- 
# Plan- Consider a data set-- simple linear regression, identify outliers, influentiential observations leverages and 
# remove those observations again build the lm model- Interpretation


# Load requierd libraries
library(DMwR) # For obtaining evaluation metrics

# Read the data from CSV file
data  = read.csv("Data_Regression.csv", header=T, sep=",")

# Understand the data
dim(data)
head(data)
names(data)      
str(data)        
summary(data)    


# Using plots, check whether there is any relationship between X and Y?
plot(data$X, data$Y)

# Correlation
cor(data$X, data$Y)

# Build simple linear Regression model
mod_lm = lm(Y~X, data=data)

# Make prediction using built model
data$pred = predict(mod_lm, newdata = data)

head(data)

# Calculate Error
regr.eval(data$Y, data$pred)

## Look at master summary
summary(mod_lm)

## Observations
# p value for F statistic is less than 0.05 implies that the model is better than naive one (predicting mean for any X)
# X is significant in predicting Y as the p value for estimated slope is less than 0.05

# Looking at the R square value (0.23).  23% variance in Y is explained by X 

# Plotting the residuals and check for assumptions
par(mfrow=c(2,2))
plot(mod_lm)

# From the residual plots, What is point 10. 
# Does it have a high leverage, is it influential.
# Is it an outlier

# Lets compute Leverage values and the residual
data$lev = (((data$X - mean(data$X))/sd(data$X))^2 +1)/36
data$resid = mod_lm$residuals

# Which datapoint has the highest leverage
data[which.max(data$lev),] 

# Observe that the point with highest leverage is point 33 which has a residual of 171.18

# From the plot, we observe that point 10 has a highest residual
data[which.max(data$resid),]
# Observe that though, this point has high residual its leverage is not very high.

# Which of these points are outliers. Lets consider cook's distance
data$cook<-round(cooks.distance(mod_lm),2)

#Influential points are those, which change the regression line too much. What if 
#we remove these points and build the lm model again

data1 = data[-c(10,33),c(1,2)]
mod_lm_1 = lm(Y~X,data=data1)
summary(mod_lm_1)
plot(data1$X,data1$Y)
par(mfrow=c(2,2))
plot(mod_lm_1)

# Observe that the model significance, variable significance and R2 values improved over the previous
# model. Now X is able to explain 31.4% variance in Y. 
data1$pred = predict(mod_lm_1,data1)
data1$resid = mod_lm_1$residuals

data1$lev<-(((data1$X - mean(data1$X))/sd(data1$X))^2 +1)/34
data1$cook<-cooks.distance(mod_lm_1)

data1[which.max(data1$lev),] 
data1[which.max(data1$cook),]
data1[which.max(data1$resid),]
regr.eval(data1$Y,data1$pred)