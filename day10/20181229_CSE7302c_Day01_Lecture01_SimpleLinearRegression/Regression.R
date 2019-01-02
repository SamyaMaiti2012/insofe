setwd("F:/Batch47/20181006_Batch47_CSE7302c_LinearRegression")

# Regression

bigmac <- read.csv("BigMac-NetHourlyWage.csv", header = T, sep = ",")
bigmac
lm(bigmac$Net.Hourly.Wage....~bigmac$Big.Mac.Price....,bigmac)
bigmaclm <- lm(bigmac$Net.Hourly.Wage....~bigmac$Big.Mac.Price....,bigmac)
summary(bigmaclm)
par(mfrow=c(1,1))
plot(bigmac$Big.Mac.Price....,bigmac$Net.Hourly.Wage....)
abline(bigmaclm)
par(mfrow=c(2,2))
plot(bigmaclm)

#Influential Observations
x <- c(0.1,0.45401,1.09765,1.27936,2.20611,2.50064,3.0403,
       3.23583,4,4.1699,4.45308,5.28474,5.59238,5.92091,
       6.66066,6.79953,7.97943,8.41536,8.70156,8.71607,9.16463)
y <- c(-0.0716,4.1673,6.5703,13.815,11.4501,12.9554,20.1575,
       17.5633,40,22.7573,26.0317,26.303,30.6885,33.9402,
       30.9228,34.11,44.4536,46.5022,46.5475,50.0568,45.7762)
simple.lm = lm(y~x)
CooksD = cooks.distance(simple.lm)
CooksD
leverage = lm.influence(simple.lm)$hat
leverage
stdres(simple.lm)
studres(simple.lm)
par(mfrow=c(2,1))
plot(x,y,col=ifelse(CooksD > qf(0.1,2,19),'red','black'))
plot(x,y,col=ifelse(leverage > 4/21,'blue','black'))
qf(0.1,2,19)
