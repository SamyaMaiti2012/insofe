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
