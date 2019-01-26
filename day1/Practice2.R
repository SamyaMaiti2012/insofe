#https://www.guru99.com/r-apply-sapply-tapply.html

m1 <- matrix(C<-(1:10),nrow=5, ncol=6)
m1
apply(m1, 2, sum)








movies <- c("SPYDERMAN","BATMAN","VERTIGO","CHINATOWN")
movies
movies_lower <-lapply(movies, tolower)
movies_lower

movies_lower <-unlist(lapply(movies,tolower))
str(movies_lower)
movies_lower







dt <- cars
typeof(dt)
lmn_cars <- lapply(dt, min)
smn_cars <- sapply(dt, min)
lmn_cars
typeof(lmn_cars)
class(lmn_cars)
smn_cars
typeof(smn_cars)
class(smn_cars)


lmxcars <- lapply(dt, max)
smxcars <- sapply(dt, max)
lmxcars
smxcars



data(iris)
tapply(iris$Sepal.Width, iris$Species, median)
