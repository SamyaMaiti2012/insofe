##### Part A - 1 #####
vec1=c(98, 82, 102, 99,100)
vec1[1]
vec1[c(1,5)]



##### Part A - 2 #####
vec_natural_no_100 = c(1:100)
mean(vec_natural_no_100)
median(vec_natural_no_100)


vec2 = c(12, 13, 12, 15, 32, 32, 24, 24, 53, 45, 78, 53, 91)
mean(vec2)
median(vec2)


vec3 = sample(c(20:40), size=10, replace = FALSE)
vec3
mean(vec3)
median(vec3)


Y <- c(10, 10, 20, 20, 20, 20, 30, 30, 30, 25, 75, 30)
Y
X = table(Y)
X
mode_val = names(X)[which(X==max(X))]
mode_val



##### Part B - 1 #####
company_emplyee_data = data.frame(AgeGroup =c("20 to 25", "25 to 30", "30 to 35", "35 to 40", 
                                              "40 to 45", "45 to 50", "50 to 55", "55 to 60", "60 to 65"),
                                  NoOfPersons = c(30, 160,210,180,145,105,70,60,40))
company_emplyee_data
