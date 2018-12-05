#### Atomic type #####
a = 5
a = vector()
print(a)

#### Vector #####
x = 1:20
x
x[2]

#### Vector #####

x = c(0.5,0.6)
x
x = c(TRUE, FALSE)
x
typeof(x)
x = c("a", "b", "c")
typeof(x)
class(x)
x = c("a", 1.0, 1, TRUE)
x
x = c(T,F)
x
x = NULL
x

#### Matrix #####
m = matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
m
m[2]
m[2][1]
m[2][2]
class(m)
typeof(m)
mode(m)
dim(m)
colnames(m)
rownames(m)

#### Matrix #####
m
m[,]
m[2,3]
m[2,2]
attributes(m)
dim(m)
m[2,]
m[,3]

#### Matrix #####
x=1:3
x
y=10:12
y
cbind(x,y)
rbind(x,y)

#### Dataframes #####
x = data.frame(foo = 1:9, bar = c(T,T,T,T,T,F,F,F,F), row.names =c("a","s","d","f","g","h","j","k","l"))
x
attributes(x)
names(x)
colnames(x)
rownames(x)
dim(x)
class(x)

#### Subsetting #####
x = c("a","s","d","f","g","h","j","k","l")
x
x[x>"a"]
i = x>"a"
i
x[i]

#### Operations #####
a=c(1:10)
b=c(1:3)
a-b #not work
d=c(1:5)
a-d


#### Slicing #####
y = data.frame(foo = 1:9, bar = c(T,T,T,T,T,F,F,F,F), row.names =c("a","s","d","f","g","h","j","k","l"))
y


#### Conditional Statements #####
x = 1
if(x > 0){
  print("Posative")
}

x=-1
if(x>0){
  print("Positive")
}else{
  print("Negative")
}

x=0
if(x<0){
  print("Negative")
}else if(x>0){
  print("Positive")
}else
  print("Zero")

a=c(5,6,3,4,6)
class(a)
ifelse(a %% 2 == 0, "even", "odd")
b = ifelse(a %% 2 == 0, "even", "odd")
b


#### Looping #####
x = c(2:8)
x
count=0
for (val in x) {
  if(val %% 2 == 0)
    count=count+1
}
count


i=1
while(i<6){
  print(i)
  i=i+1
}


#### Functions #####
pow = function(x, y=3){
  result = x^y
  print(paste("result is ", result))
  return(result)
}

powResult = pow(2,7)
powResult


check=function(x){
  if(x<0){
    res="Negative"
  }else if(x>0){
    res="Positive"
  }else{
    res="Zero"
  }
  return(res)
}
check(-2)


######## apply ########
m=matrix(1:16,4,4)
m
apply(m, 1, min)
apply(m, 1, max)
apply(m, 1, sum)

apply(m, 1:2, pow)

######## aggregate ########
head(mtcars)
c = aggregate(mtcars, by=list(mtcars$cyl, mtcars$vs), FUN = mean, na.rm=TRUE)
c
class(c)
typeof(c)



######## Rough ########
x = 8
x%%2.0
