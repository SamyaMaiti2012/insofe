#Set Current working directory to the dataset directory
setwd("/Users/samyam/Documents/Samya/Insofe/insofe/day7/CSE7212c_R_DataPreprocessing_Assignment-1537795825770")

#Clean up environment
rm(list = ls(all=TRUE))


#Import the data files into R (without changing file format)
demographicDetails = read.csv(file = "Census Income Data Set1.csv",header=TRUE,sep=",")
otherDetails = read.csv(file = "Census Income Data Set2.csv",header=TRUE,sep=",")

sum(is.na(demographicDetails))
sum(is.na(otherDetails))


#Combine two data-frames and start data analysis
censusDetails = merge(x = demographicDetails,y = otherDetails, by.x = "PersonID", by.y = "PersonID")
head(censusDetails)


#Understand the data and perform required pre-processing steps
str(censusDetails)
#Observations:-
# 1. Categorical datatype : PersonID, workclass, education, marital.status, occupation, relationship, race, gender, native.country, class
# 2. Integer datatype : age, fnlwgt, education.num, capital.gain, capital.loss, hours.per.week
# 3. Total 48842 datapoints, with 16 features.
# 4. Conversion of datatypes not required.

summary(censusDetails)
# 1. No missing/Na values in the dataset.
# 2. PersonID is an unique field.
# 3. age attribute is equally spaced.
# 4. Majority(~70%) of working class is Private
# 5. fnlwgt is having a wide range of values, the max value is much higher than the 3rd Qu, llooks to be a outlier.
# 6. frequency of education feature is higher for HS-grad, Some-college
# 7. education.num, not sure of the significance of this feature.
# 8. marital.status feature with higher frequency for Married-civ-spouse
# 9. occupation looks uniformly distributed.
#10. White race is close to 80% of observations.
#11. Its a male dominated observation with close to 65% being Male.
#12. capital.gain & capital.loss, both show few observations with higher values. Screwed dataset.
#13. hours.per.week has a diverse range from 1 to 99.
#14. native.country  states, majority are from United-States
#15. class feature shows 78% observations are having income <=50K.


#Compute inter quartile range for each attribute
numsCol = sapply(censusDetails, is.numeric)
featureNumeric = censusDetails[ , numsCol]
featureNumeric
class(featureNumeric)
lapply(featureNumeric,quantile,probs=c(0.25, 0.75))
lapply(featureNumeric,quantile,probs=c(0.0, 0.25, 0.75, 1.0))



#Create dummy variables for attribute 'occupation'
names(censusDetails)
dummy(censusDetails$occupation)



#Calculate the mean 'capital.loss' w.r.to each level in the attributes workclass, education,occupation and gender
tapply(censusDetails$capital.loss,censusDetails$workclass,mean)
tapply(censusDetails$capital.loss,censusDetails$education,mean)
tapply(censusDetails$capital.loss,censusDetails$occupation,mean)
tapply(censusDetails$capital.loss,censusDetails$gender,mean)

tapply(censusDetails$capital.loss,list(censusDetails$workclass, censusDetails$education, censusDetails$occupation, censusDetails$gender),mean)


#Standardize numerical attributes using range method
numsCol = sapply(censusDetails, is.numeric)
featureNumeric = censusDetails[ , numsCol]
head(featureNumeric)

featureNumeric_range = decostand(x =featureNumeric[,names(featureNumeric)],method ="range",MARGIN = 2)
str(featureNumeric_range)
head(featureNumeric_range)


#Create new column "outcome".  Mark it as 1 for the records with Class <=50K otherwise 0
head(censusDetails)
censusDetails$outcome <- ifelse(censusDetails$class %in% c("<=50K"), 1, 2)
head(censusDetails)
