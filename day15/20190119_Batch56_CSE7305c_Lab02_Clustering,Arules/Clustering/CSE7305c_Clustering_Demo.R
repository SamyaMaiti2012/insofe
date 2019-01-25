# Removing all the variables from the workspace
rm(list=ls(all=TRUE))

# To specify seeds
set.seed(1234)

# Taking iris data
data <- iris
head(data)

# Drop class labels (Species)
data$Species <- NULL
head(data)
dim(data)

# Standardize variables using scale function 
#-------------------
# Understand scale function 
x <- matrix(1:10, ncol = 2)
x
scale(x, scale = F)
scale(x, center=F,scale = F)
scale(x, scale = T)
scale(x, center=F,scale = T)
rm(x)
#-------------------
data1 = data #For k-means clustering

data <- data.frame(scale(data))
data


# ---------Hierarchical Clustering-----------------#
# Calculate distance
d <- dist(data, method = "euclidean") 
d

# Ward Hierarchical Clustering
fit <- hclust(d, method="ward.D2")

# display dendogram
plot(fit)

# draw dendogram with red borders around the 3 clusters
rect.hclust(fit, k=3, border="red") 

# cut tree into 3 clusters
cluster_Num <- cutree(fit, k=3) 
cluster_Num

data = data.frame(data, cluster_Num)

plot(data[c("Sepal.Length", "Sepal.Width")],
     col = data$cluster_Num, pch = 16)

## Stability of the clusters
# We will randomly sample 135 datapoints and plot the clusters to visualise
par(mfrow = c(2, 2))

set.seed(1234)
for (i in 1:4){
  # Randomly sample 135 data points
  sample_data = data[sample(1:nrow(data), 135),] 
  d <- dist(sample_data, method = "euclidean") 
  fit <- hclust(d, method="ward.D2")
  cluster_Num <- cutree(fit, k=3)
  #plot each sample to visualise the clusters
  plot(sample_data[,c("Sepal.Length", "Sepal.Width")] , 
       col = cluster_Num, pch = 16)
  #The clusters obtained look stable
}
#resetting to original
par(mfrow = c(1,1))
rm(sample_data)


# ---------k-means Clustering-----------------#
# Running kmeans 
clus <- kmeans(data1, 3)
clus

clus$cluster

table(clus$cluster)
clus$size

# Calculation of cluster centers
x = split(data1, clus$cluster)
x
class(x)
class(x[[1]])
sapply(x, function(x) scale(x, scale = FALSE)) 
rm(x)

clus$centers

# Calculation of betweenss
clus$cluster
clus$centers
x = clus$centers[clus$cluster,]
x
scale(x, scale = FALSE)
scale(x, scale = TRUE)
scale(x, scale = FALSE)^2
sum(scale(x, scale = FALSE)^2)
rm(x)
clus$betweenss

# Calculation of withinss
x = split(data1, clus$cluster)
sapply(x, function(x) sum(scale(x, scale = FALSE)^2)) 
rm(x)

clus$withinss

# Calculation of total withinss
sum(clus$withinss)
clus$tot.withinss

# Calculation of totalss
clus$tot.withinss +  clus$betweenss
clus$totss

# Check clustering result against class labels (Species)
table(clus$clus, iris$Species)

# Observation
#   Class "setosa" can be easily separated from the other clusters
#   Classes "versicolor" and "virginica" are to a small degree overlapped with each other.

plot(data1[c("Sepal.Length", "Sepal.Width")], 
     col = clus$cluster, pch = 16)
points(clus$centers[, c("Sepal.Length", "Sepal.Width")],
       col = 1:3, pch = 8, cex = 2) # plot cluster centers
rm(clus)

# Identifying right number of clusters
tot.wss <- 0
set.seed(1234)
for (i in 1:15) {
  tot.wss[i] <- kmeans(data1,centers=i)$tot.withinss
}

plot(1:15, tot.wss, 
     type="b", 
     xlab="Number of Clusters",
     ylab="Total within groups sum of squares") 
rm(i, tot.wss)
# Cluster may vary based on the where inition cluster center are picked 
# So, re-run the above code multiple time with different set.seed and find the right K

# From the above analysis k = 3 looks better 
# K-Means Cluster Analysis

clus <- kmeans(data1, 3) # 3 cluster solution

# append cluster numbers
data1 <- data.frame(data1, "cluster_Num" = clus$cluster) 
head(data1)

rm(clus)

## Stability of the clusters
# We will randomly sample 135 datapoints and plot the kmeans clusters to visualise
par(mfrow = c(2, 2))

set.seed(1234)
for (i in 1:4){
  # Randomly sample 135 data points
  sample_data = data1[sample(1:nrow(data1), 135),] 
  #Based on domain knowledge, we will go with 3 as the cluster numbers
  clus <- kmeans(sample_data, 3)
  #plot each sample to visualise the clusters
  plot(sample_data[,c("Sepal.Length", "Sepal.Width")] , col = clus$cluster, pch = 16)
  #Here clusters in Figures 2,3 and 4 look stable
}

#resetting to original
par(mfrow = c(1,1))

# ------------------------------------end------------------------------------------------------------------------------