########## 1 #########
qnorm(0.05)



########## 2 #########
qt(0.05,9)
#t.test(c(22,12,10,25),y = NULL, alternative = c("less"),mu = 25, paired = FALSE, conf.level = 0.95)



########## 3 #########
qt(0.95,8)
t.test(c(0.593,0.142,0.329,0.691,0.231,0.793,0.519,0.392,0.418),
       y = NULL, alternative = c("greater"),mu = .3, paired = FALSE, conf.level = 0.95)


########## 4 #########
t.test(x=c(19, 22, 24, 24, 25, 25, 26, 26, 28, 32),
       y = c(16, 20, 21, 22, 23, 22, 27, 25, 27, 28), alternative = c("greater"),mu =0, paired = TRUE, conf.level = 0.95)

qt(0.95,9)


########## 5 #########
rm(list = ls(all=T))
observed <- matrix(c(35, 30,20,15), ncol = 1)
observed
expected <- rep(sum(observed)/4,4)
expected
test_stat<- sum((observed - expected)^2 / expected) 
test_stat
crit<- qchisq(0.05, 3, lower.tail = F)
crit
pchisq(test_stat , 3, lower.tail = F)
chisq.test(observed)


########## 6 #########
observed <- matrix(c(200,150,50,250,300,50), byrow = TRUE, ncol = 3)
observed

crit<- qchisq(p = 0.05, df = (nrow(observed)-1)*(ncol(observed)-1) ,lower.tail = FALSE)
crit

test_stat<- chisq.test(observed)
test_stat


########## 7 #########
obsA = c(3.2,3.4,2.8,3,3,3,2.8,2.9,3,3) 
obsB = c(3,3.5,2.9,3.1,2.3,2,3,2.9,3,4.1)
obsA
obsB

qf(p = 0.05,df1 = 9, df2 = 9) 
qf(p = 0.95,df1 = 9, df2 = 9)

sdA = sd(obsA)
sdA
sdB = sd(obsB)
sdB
Fstat = ((sdA)^2)/((sdB)^2) 
Fstat


########## 8 #########
x1 <- c(643, 655, 702)
x2 <- c(469, 427, 525)
x3 <- c(484, 456, 402)
x <- c(x1,x2,x3)
x

m <- 3
n <- length(x1)

df_ssw<- m * (n-1)
df_ssb<- m-1

F_crit<- qf(0.05, df_ssb, df_ssw, lower.tail = F)
F_crit


sst<- sum((x- mean(x))^2)
sst
ssw<- sum((x1- mean(x1))^2) + sum((x2- mean(x2))^2) + sum((x3- mean(x3))^2) 
ssw
ssb<- sst - ssw
ssb
f_stat<- (ssb / df_ssb) / (ssw / df_ssw)
f_stat




########## A1 #########
sigmna= 25 
n = 100
x_bar = 1014
#Confidence_level = 95%
alpha = .05

qnorm(0.025,0,1)
qnorm(0.975,0,1)




########## A2 #########
Treat = c(101, 110, 103, 93, 99, 104)
Control = c(91, 87, 99, 77, 88, 91)

tValue= qt(0.95, 10) 
tValue

t.test(Treat, Control, alternative="greater", var.equal=TRUE)


########## A3 #########




########## A4 #########
observed <- c(21, 109, 62, 15)
observed
expected <- (c(8, 47,34, 11)/100)* sum(observed)
expected

crit<- qchisq(0.05, 3, lower.tail = F)
crit

test_stat<- sum((observed - expected)^2 / expected)
test_stat

chisq.test(observed, p = c(0.08,0.47, 0.34,0.11 ))
########## A5 #########
