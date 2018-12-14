###### 2 ########
#QA 2
func = function(x){
    3*x^-4
}

integrate(func, 1, 4)


#QA 3
integrate(func, 2, 3)


###### 4 ########
#QA 1
dbinom(3,12,.5)


#QA 2
pbinom(2,12,.5)
1-pbinom(2,12,.5)


dbinom(0,12,.5)+dbinom(1,12,.5)+dbinom(2,12,.5)


###### 5 ########
#QA 1
dpois(3,5)
#QA 3
dpois(0,5)



###### 7 ########

1-pnorm(x,2, 5.41) 


########## Practice ##############

rbinom(0,12,.5)

require(graphics)
# Compute P(45 < X < 55) for X Binomial(100,0.5)
sum(dbinom(46:54, 100, 0.5))
