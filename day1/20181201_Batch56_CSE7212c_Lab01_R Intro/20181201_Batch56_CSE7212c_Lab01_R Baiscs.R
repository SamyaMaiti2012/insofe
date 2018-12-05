# if statement
x = 1

if(x > 0){
  print("Positive Number")
}

# if else statement
x = -1
if(x > 0){
  print("Positive number")
} else {
  print("Negative number")
}

# Nested if...else statement
x = 0
if (x < 0) {
  print("Negative number")
} else if (x > 0) {
  print("Positive number")
} else
  print("Zero")

# ifelse() function
a = c(5,7,2,9)
ifelse(a %% 2 == 0, "even", "odd")

# for loop
x = c(2, 5, 3, 9, 8, 11, 6)
count = 0
for (val in x) {
  if(val %% 2 == 0)  
    count = count+1
}

count

x %% 2

# while loop
i = 1
while (i < 6) {
  print(i)
  i = i+1
}

# break statement
x = 1:5

for (val in x) {
  if (val == 3){
    break
  }
  print(val)
}

# next statement
x = 1:5

for (val in x) {
  if (val == 3){
    next
  }
  print(val)
}

# repeat loop
x <- 1

repeat {
  print(x)
  x = x+1
  if (x == 6){
    break
  }
}

# R functions

#   Function syntax
#   funcName <- function (argument) {
#     statements
#   }

pow <- function(x, y = 3) { #Default Values for y Arguments
  result <- x^y
  print(paste(x, "raised to the power", y, "is", result))
}

# Call a function
pow(3)

pow(8, 2)

pow(x = 8, y = 2) # Named Arguments 

pow(y = 2, x = 8)

# R Return Value from Function
check = function(x) {
  if (x > 0) {
    result <- "Positive"
  }
  else if (x < 0) {
    result <- "Negative"
  }
  else {
    result <- "Zero"
  }
  return(result)
}

check(1)

# Functions without return()
# If there are no explicit returns from a function, the value of the last evaluated expression is returned automatically in R.

check <- function(x) {
  if (x > 0) {
    result <- "Positive"
  }
  else if (x < 0) {
    result <- "Negative"
  }
  else {
    result <- "Zero"
  }
  result
}

check(-1)

# Multiple Returns
# The return() function can return only a single object. If we want to return multiple values in R, we can use a list (or other objects) and return it.

multiReturn = function() {
  myList <- list(1, 20, c("a","b"))
  return(myList) 
}

multiReturn()


# Data Structures

# Vectors 
# Create Vector using the c() function
x = c(1, 5, 4, 9, 0)

# Creating a vector using : operator
x = 1:7; x

# Creating a vector using seq() function
seq(1, 3, by=0.5)

# Matrix
matrix(1:9, nrow = 3, ncol = 3)
matrix(1:9, nrow=3, byrow=TRUE)
x = matrix(1:9, nrow = 3, dimnames = list(c("X","Y","Z"), c("A","B","C")))
dim(x)
colnames(x)
rownames(x)
cbind(c(1,2,3),c(4,5,6))
rbind(c(1,2,3),c(4,5,6))


class(x)
# List
x <- list("a" = 2.5, "b" = TRUE, "c" = 1:3)
x["a"]
x[["a"]]
x[[1]]
class(x)
# Data Frame
x <- data.frame("SN" = 1:2, "Age" = c(21,15), "Name" = c("John","Dora"))
str(x)
summary(x)


x <- factor(c("1", "2", "2", "1"))

x <- factor(c("1", "2", "2", "2"), levels = c("0", "1", "2"))


# apply 
#   Apply a function to the rows or columns of a matrix

# apply(X, MARGIN, FUN, ...)
# x       : an arry
# MARGIN  : For a matrix, MARGIN 1 indicates rows, 2 indicates columns, c(1, 2) indicates rows and columns.
# FUN     : the function to be applied


# Two dimensional matrix
m <- matrix(seq(1,16), 4, 4)

# apply min to rows
apply(m, 1, sum)  

# apply max to columns
apply(m, 2, sum)

colMeans(m)
rowMeans(m)
colSums(m)
rowSums(m)

# 3 dimensional array
m <- array(seq(32), dim = c(4,4,2))

# Apply sum across each M[*, , ] - i.e Sum across 2nd and 3rd dimension
apply(m, 1, sum)

# Apply sum across each M[*, *, ] - i.e Sum across 3rd dimension
apply(m, c(1,2), sum)

rm(m)

# lapply 
#   Apply a function to each element of a list in turn and get a list back.

x = list(a = 1, b = 1:3, c = 10:100) 

lapply(x, FUN = length) 

lapply(x, FUN = sum) 

# sapply 
#   Apply a function to each element of a list in turn, but get a vector back, rather than a list.

sapply(x, FUN = length)  

sapply(x, FUN = sum)

unlist(lapply(x, FUN = length))
unlist(lapply(x, FUN = sum))

rm(x)
# mapply 
#   When you have several data structures (e.g. vectors, lists) and you want to apply a function to the 1st elements of each, and then the 2nd elements of each, etc., coercing the result to a vector/array as in sapply.

#Sums the 1st elements, the 2nd elements, etc. 
mapply(sum, 1:5, 1:5, 1:5) 

# To do rep(1,4), rep(2,3), etc.
mapply(rep, 1:4, 4:1)   


# tapply 
#   Apply a function to subsets of a vector and the subsets are defined by some other vector, usually a factor.

df = data.frame(x=1:20, y = factor(rep(letters[1:5], each = 4)))

tapply(df$x, df$y, sum)

# aggregate
#   aggregate data frame mtcars by cyl and vs, returning means for numeric variables
head(mtcars)
aggregate(mtcars, by=list(mtcars$cyl,mtcars$vs), FUN=mean, na.rm=TRUE)


# Reference:
#   https://www.programiz.com/r-programming
#   https://stackoverflow.com/questions/3505701/r-grouping-functions-sapply-vs-lapply-vs-apply-vs-tapply-vs-by-vs-aggrega