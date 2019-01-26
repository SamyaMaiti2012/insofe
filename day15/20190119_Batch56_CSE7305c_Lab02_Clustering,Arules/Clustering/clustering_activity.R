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
cat_attr
num_attr

#Alter required datatypes
cereal_with_cat_data$vitamins = as.factor(cereal_with_cat_data$vitamins)
cereal_with_cat_data$shelf = as.factor(cereal_with_cat_data$shelf)

str(cereal_with_cat_data)

cereal_with_cat_data[,num_attr] = data.frame(sapply(cereal_with_cat_data[,num_attr], as.numeric))

str(cereal_with_cat_data)
head(cereal_with_cat_data)


#Standardize the numeric data.
data = scale(cereal_with_cat_data[,num_attr])
data

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

#Perform Ward.D2 Hierarchical Clustering.
d = dist(data, method = "euclidean")
fit = hclust(d, method = "ward.D2")
plot(fit)

rect.hclust(fit, k=5, border = "red")

cluster_Num = cutree(fit, k=5)
cluster_Num


data = data.frame(data, cluster_Num)
plot(data[c("fiber", "sugars")], col = data$cluster_Num, pch = 16)


## Stability of the clusters
# We will randomly sample 50 datapoints and plot the clusters to visualise
par(mfrow = c(2, 2))

set.seed(1234)
for (i in 1:4){
  # Randomly sample 50 data points
  sample_data = data[sample(1:nrow(data), 50),] 
  d <- dist(sample_data, method = "euclidean") 
  fit <- hclust(d, method="ward.D2")
  cluster_Num <- cutree(fit, k=3)
  #plot each sample to visualise the clusters
  plot(sample_data[,c("fiber", "sugars")] , 
       col = cluster_Num, pch = 16)
  #The clusters obtained look stable
}
#resetting to original
par(mfrow = c(1,1))
rm(sample_data)







#Perform k-means clustering and understand the resultant components


