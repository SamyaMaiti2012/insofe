#Load Libraries
library(dummies)

#Remove variables in env
rm(list=ls(all=TRUE))

#Load the input data
cereal_with_cat_data = read.csv("/Users/samyam/Documents/Samya/Insofe/insofe/day15/20190119_Batch56_CSE7305c_Lab02_Clustering,Arules/Clustering/cereal_with_cat.csv")
dim(cereal_with_cat_data)
head(cereal_with_cat_data)
str(cereal_with_cat_data)
structure(cereal_with_cat_data)

#Drop not required attributes
rownames(cereal_with_cat_data) = cereal_with_cat_data$name
cereal_with_cat_data$name = NULL

str(cereal_with_cat_data)

#Divide into Cat & numeric
attr = colnames(cereal_with_cat_data)
attr

cat_attr = c('mfr', 'type', 'shelf', 'vitamins')
num_attr = setdiff(attr, cat_attr)

#Alter required datatypes
cereal_with_cat_data$vitamins = as.factor(cereal_with_cat_data$vitamins)
cereal_with_cat_data$shelf = as.factor(cereal_with_cat_data$shelf)

cereal_with_cat_data[,num_attr] = data.frame(sapply(cereal_with_cat_data[,num_attr], as.numeric))

str(cereal_with_cat_data)
head(cereal_with_cat_data)


#Standardize the numeric data.
data = scale(cereal_with_cat_data[,num_attr])

#Create dummy variables and convert all categorical variables to numeric
mfr_dummy = dummy(cereal_with_cat_data$mfr)
type_dummy = dummy(cereal_with_cat_data$type)
shelf_dummy = dummy(cereal_with_cat_data$shelf)
vitamins_dummy = dummy(cereal_with_cat_data$vitamins)

cat_variables_df = data.frame(cbind(mfr_dummy, type_dummy, shelf_dummy, vitamins_dummy))
cat_variables_df


data = data.frame(data, cat_variables_df)
data
data1 = data

str(data1)  





  