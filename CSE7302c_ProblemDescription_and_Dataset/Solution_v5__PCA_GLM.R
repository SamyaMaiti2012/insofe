library(DMwR)

rm(list=ls(all=TRUE))

getwd()
setwd("/Users/samyam/Documents/Samya/Insofe/insofe/CSE7302c_ProblemDescription_and_Dataset")

set.seed(4100)


######### EDA ##########
healthCaseData = read.csv("Dataset.csv", header = T, sep = ",")
dim(healthCaseData)
head(healthCaseData)
names(healthCaseData)
str(healthCaseData)
summary(healthCaseData)

"
Observations
1. There are 34281 observations & 25 columns (including target)
2. Column named Target is out prediction variable.
3. All the fields are loaded as int or num, need to analyze more to identify which of these could be categorical.
4. Majority of columns looks to have very high range of values, possibility of outliers.
5. NA Analysis :-
a. Columns with NA : A2 
b. Columns with -99 : A15, A16 
6. The Target variable is in the range of 0 & 1. So its a binary classification problem.
"

# Reload the data with -99 as NA handled
rm(healthCaseData)
healthCaseData= read.csv("Dataset.csv", header = T, sep = ",", na.strings=c("NA","-99"))

#Correlation Plot
library(corrplot)
corrplot(cor(healthCaseData, use = "complete.obs"), method = "number")
"
Observation:-
1. A11 is a coulumn with no variance. Will be removed from analysis.
2. A5, A6, A7 are highly corelated.
3. A9, A10 are highly corelated.
4. A9, A12 are highly corelated.
5. A10, A12 are highly corelated.
6. None of the features are having significant corelation with Target variable.
"


#Use Boxplots to see outliers
boxplot(healthCaseData, use.cols = TRUE)
"
Observation:-
1. Except ID field, all teh attribues have values towards zero, with few outliers.
"

#Remove ID field from analysis & plot boxplots
boxplot(healthCaseData[,-1], use.cols = TRUE)
"
Observation:-
1. We can see there are many outliers in IV, A1, A3, A5, A6, A7, A8, A9, A10, A12
"


# Count number of missing values in each Column
sapply(healthCaseData, function(x) sum(is.na(x) | -99 == x))
"
Observations :-
1. As none of the columns have not even 1% of missing values, we cannot discard any column
"


# We need to check the count of unique values in each column to decide if a variable is categorical.
sapply(sapply(healthCaseData, unique), length)

#% of unique value representation of total datapoints
sapply(sapply(sapply(healthCaseData, unique), length), function(x) (x/nrow(healthCaseData))*100)

"
Observations :-
1. Total number of records = 34281
2. ID field is a unique column, can be discarded from analysis
3. Continuous variables :-
a. IV, A1, A3, A4, A5, A6, A7, A8, A9, A10,A12, A14, A15, A16, A21
4. Categorical variables :-
a. A2, A13, A17, A18, A19, A20, A22, Target
5. Variables that need further analysis, as they have comparatively less unique count to be classified as Continuous. 
6. Variable A11 only has one value, so can be discarded from analysis.
"

"
Assumption :-
1. Any variable having unique values less than 100 will be considered Categorical for first cut
"

# Discard not required columns
head(healthCaseData)
healthCaseDataWithoutDisCol = subset(healthCaseData, select = - c(ID, A11))
head(healthCaseDataWithoutDisCol)


# Define continuous & Categorical Columns
continuousColumn = c('IV', 'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9', 'A10', 'A12', 'A14', 'A15', 'A16', 'A21')
continuousColumn
catColumn = setdiff(names(healthCaseDataWithoutDisCol), continuousColumn)
catColumn


# Datatype conversion
str(healthCaseDataWithoutDisCol)

catColumnConverted = sapply(healthCaseDataWithoutDisCol[catColumn], function(x) as.factor(x))
str(catColumnConverted)
summary(catColumnConverted)
head(catColumnConverted)

"
contColumnConverted = sapply(healthCaseDataWithoutDisCol[continuousColumn], function(x) as.numeric(x))
str(contColumnConverted)
summary(contColumnConverted)
head(contColumnConverted)
# Merge the categorical & continuous Column
healthCaseDataTypeAlt = cbind(catColumnConverted, contColumnConverted)
"

# Merge the categorical & continuous Column
healthCaseDataTypeAlt = cbind(catColumnConverted, healthCaseDataWithoutDisCol[continuousColumn])


str(healthCaseDataTypeAlt)
summary(healthCaseDataTypeAlt)
head(healthCaseDataTypeAlt)


"
Observations:-
1. A13, A18 & A22 are highly imbalanced. So will not contribute to prediction much, hence can be dropped.
"
healthCaseDataRefined = subset(healthCaseDataTypeAlt, select = - c(A13, A18, A22))
str(healthCaseDataRefined)
summary(healthCaseDataRefined)
head(healthCaseDataRefined)


# Remove outliers Based on continuous variables
boxplot(healthCaseDataRefined[continuousColumn], use.cols = TRUE)
#looking at attribute IV, A5, A6, A7, A9, A10, A12 have few above 10000, so we will remove those datpoints if they are fraction of total population
healthCaseDataFiltered = healthCaseDataRefined[(healthCaseDataRefined$IV <= 10000 & healthCaseDataRefined$A5 <= 4000 & healthCaseDataRefined$A6 <= 7000 & 
                                                  healthCaseDataRefined$A7 <= 10000 & healthCaseDataRefined$A9 <= 4000 & healthCaseDataRefined$A10 <= 6000 & 
                                                  healthCaseDataRefined$A12 <= 10000 & healthCaseDataRefined$A1 <= 2000 & healthCaseDataRefined$A3 <= 2000 &
                                                  healthCaseDataRefined$A4 <= 1000 & healthCaseDataRefined$A8 <= 1000 & healthCaseDataRefined$A14 <= 1000),]
boxplot(healthCaseDataFiltered[continuousColumn], use.cols = TRUE)
cat("% of datapoints dropped : ", ((nrow(healthCaseData) -nrow(healthCaseDataFiltered))*100/nrow(healthCaseDataRefined)))


str(healthCaseDataFiltered)
summary(healthCaseDataFiltered)
head(healthCaseDataFiltered)


# Dummyfication before Splitting to ensure we dont encounter scenario of unseen data for both test & train.
library(caret)
healthCaseDataFilteredDummyFyModel = dummyVars(Target ~ ., data = healthCaseDataFiltered,fullRank = T)
healthCaseDataFilteredDummyfy = data.frame(predict(healthCaseDataFilteredDummyFyModel, newdata = healthCaseDataFiltered))

str(healthCaseDataFilteredDummyfy)
summary(healthCaseDataFilteredDummyfy)
head(healthCaseDataFilteredDummyfy)
dim(healthCaseDataFilteredDummyfy)

healthCaseDataFilteredDummyfy_1 = cbind(healthCaseDataFilteredDummyfy, healthCaseDataFiltered$Target)
names(healthCaseDataFilteredDummyfy_1)[names(healthCaseDataFilteredDummyfy_1) == 'healthCaseDataFiltered$Target'] = 'Target'
str(healthCaseDataFilteredDummyfy_1)
summary(healthCaseDataFilteredDummyfy_1)
head(healthCaseDataFilteredDummyfy_1)
dim(healthCaseDataFilteredDummyfy_1)

#####  Model Building #########


#Split te data into train, validation & test
dim(healthCaseDataFilteredDummyfy_1)

train_rows = createDataPartition(c(healthCaseDataFilteredDummyfy_1$Target), p = 0.7, list = F)
train_data = healthCaseDataFilteredDummyfy_1[train_rows,]
dim(train_data)
table(train_data$Target)

validation_data = healthCaseDataFilteredDummyfy_1[-train_rows,]
dim(validation_data)
table(validation_data$Target)

str(train_data)



# Pre-Processing of training data
head(train_data)

# Handling missing values
# Count number of missing values in each Column
sapply(train_data, function(x) sum(is.na(x) | -99 == x))
"
Observations:-
1. No missing values in Target, so no need to drop any row.
"
train_data_Imputed = centralImputation(train_data)
sapply(train_data_Imputed, function(x) sum(is.na(x) | -99 == x))

head(train_data_Imputed)
str(train_data_Imputed)
summary(train_data_Imputed)


#Get Imputation values of each column
imputedValues = sapply(train_data_Imputed[colnames(train_data_Imputed)], function(x) centralValue(unlist(x)))
typeof(imputedValues)
length(imputedValues)
imputedValues




#Standardize the Continuous variables for quick convergence
library(caret)
std_model = preProcess(train_data_Imputed[, !names(train_data_Imputed) %in% c("Target")], method = c("center", "scale"))
std_model


train_data_Imputed_stand = predict(object = std_model,newdata = train_data_Imputed[, !names(train_data_Imputed) %in% c("Target")])
train_data_Imputed_stand

train_data_Imputed_with_Stand = cbind(train_data_Imputed_stand, train_data_Imputed["Target"])
head(train_data_Imputed_with_Stand)




#Create model             
model_healthCareData = glm(formula = Target ~ ., data = (train_data_Imputed_with_Stand), family = binomial)
#http://r.789695.n4.nabble.com/glm-fit-quot-fitted-probabilities-numerically-0-or-1-occurred-quot-td849242.html
summary(model_healthCareData)
"
Observations:-
1. Some of the variables are insignificant, check vif for multicolinearity
"


library(car)
vif(model_healthCareData)

"
Observations:-
1. Many of the IV's show multicolierity.
2. We can try out PCA to remove multicolierity.
"

train_data_Imputed_with_Stand_x = train_data_Imputed_with_Stand[, !names(train_data_Imputed_with_Stand) %in% c("Target")]
train_data_Imputed_with_Stand_Y = train_data_Imputed_with_Stand['Target']
pca_scaled = prcomp(train_data_Imputed_with_Stand_x, center = TRUE,scale. = TRUE)
summary(pca_scaled)
"
Observation:-
1. First 12 PC, explains the ~97% variance, so we will select first 12 & do our model building.
"

train_data_Imputed_with_Stand_x_pca = as.data.frame(predict(pca_scaled, train_data_Imputed_with_Stand_x))
train_data_Imputed_with_Stand_x_pca_imp = train_data_Imputed_with_Stand_x_pca[,1:12]
head(train_data_Imputed_with_Stand_x_pca_imp)

# Merge back Target
train_data_Imputed_with_Stand_pca_imp = cbind(train_data_Imputed_with_Stand_x_pca_imp, train_data_Imputed_with_Stand_Y)


model_healthCareData_pca = glm(formula = Target ~ ., data = (train_data_Imputed_with_Stand_pca_imp), family = binomial)
summary(model_healthCareData_pca)
vif(model_healthCareData_pca)
"
Observations:-
1. All the variables are significant.
"




#Decide on the threshold, sensitivity - specificity graph
library(Epi)
ROC( form = Target ~ . , plot="sp" , data = train_data_Imputed_with_Stand)
"
Observation:-
1. 0.38 or less looks to be the threshold based on sensitivity - specificity - cutoff graph
"


#Predict on training set
target_pred = predict(model_healthCareData_pca,train_data_Imputed_with_Stand_pca_imp,type=c("response"))
train_data_Imputed_with_Stand$target_pred=target_pred
target_pred_round_num = ifelse(target_pred > 0.38, 1, 0)
#convert this to factor datatype
train_data_Imputed_with_Stand$target_pred_round=as.factor(target_pred_round_num)
head(train_data_Imputed_with_Stand)


#ROC & AUC
library(ROCR)
ROCRpred = prediction(target_pred, train_data_Imputed_with_Stand$Target)
as.numeric(performance(ROCRpred, "auc")@y.values)
ROCRperf <- performance(ROCRpred, "tpr", "fpr")
par(mfrow=c(1,1))
plot(ROCRperf, colorize = TRUE, print.cutoffs.at=seq(0,1,by=0.025), text.adj=c(-0.2,1.7))
"
Observation:-
1. AUC : 0.8737695
2. Threshold : 0.38
"


confusionMatrix(train_data_Imputed_with_Stand$target_pred_round, train_data_Imputed_with_Stand$Target, positive = "1")
"
Observation:-
1. Sensitivity / Recall = 92.33 % . As we are looking for high Recall .3 threshold looks good.
2. 1 : Disease, 0 : Not Disease
"













####### Test on validation_data  ###############
head(validation_data)
str(validation_data)
summary(validation_data)



#Impute Validation set data with imputedValues
for(i in names(validation_data)){
  validation_data[is.na(validation_data[,i]), i] = as.numeric(imputedValues[i])
}


head(validation_data)
str(validation_data)
summary(validation_data)

#Standardise the data
validation_data_Imputed_stand = predict(object = std_model,newdata = validation_data[, !names(validation_data) %in% c("Target")])
validation_data_Imputed_stand
validation_data_Imputed_with_Stand = cbind(validation_data_Imputed_stand, validation_data["Target"])
head(validation_data_Imputed_with_Stand)


#Predict on validation set
target_valid_pred = predict(model_healthCareData,validation_data_Imputed_with_Stand,type=c("response"))
validation_data_Imputed_with_Stand$target_valid_pred=target_valid_pred
target_valid_pred_round_num = ifelse(target_valid_pred > 0.38, 1, 0)
#convert this to factor datatype
validation_data_Imputed_with_Stand$target_valid_pred_round_num=as.factor(target_valid_pred_round_num)
head(validation_data_Imputed_with_Stand)

confusionMatrix(validation_data_Imputed_with_Stand$target_valid_pred_round_num, validation_data_Imputed_with_Stand$Target, positive = "1")


"
Observation:-
1. Recall of 84.% on validation data.
"
