########## 1. ############
#   Following are Kohli scores in 4 matches played between India and Australia, 
#   match 5 being the latest one played in a six match series.

#a. What are his median and mean scores for the first four matches played?
kohli_match_scores = data.frame(Match=c(1,2,3,4), Score=c(65,72,58,77))
kohli_match_scores

#Mean score
print(paste("Mean score is ",mean(kohli_match_scores$Score)))
print(paste("Median score is ",median(kohli_match_scores$Score)))

#b. If he scores 70 in his fifth match, does his series mean score increase or decrease w.r.t. scores obtained for first four matches. Find his new mean score.
kohli_match_scores_5 = data.frame(Match=c(5), Score=c(70))
kohli_match_scores_5
new_kohli_match_scores = rbind(kohli_match_scores, kohli_match_scores_5)
new_kohli_match_scores

print(paste("New Mean score is ",mean(new_kohli_match_scores$Score)))
print(paste("New Median score is ",median(new_kohli_match_scores$Score)))

#c. Which has increased more, his mean score or his median score after the fifth match?
print("So the series mean & median score inceases")








########## 2. ############
#a. Mean or Median
#b. Median
#c. Mode




########## 3. ############
time_taken_by_employee = data.frame(time_taken=c(1, 7, 8, 4, 12, 14, 22, 15, 18, 14))
time_taken_by_employee
#ordered
time_taken_by_employee[order(time_taken_by_employee$time_taken),]
#quantile
quantile(time_taken_by_employee$time_taken)
IQR(time_taken_by_employee$time_taken)
summary(time_taken_by_employee$time_taken)








########## 4. ############
student_score = data.frame(score=c(11, 7.5, 8.5, 10, 10, 10.5, 5.5, 10, 9, 9.5, 5.25, 8, 6.5, 10.5, 8.75, 0, 6, 6, 6.75, 8.75, 0, 9.5, 7.5, 8.5, 7))
student_score
#a. 
range(student_score$score)
#b.
hist(student_score$score)
#c
quantile(student_score$score)
#d
boxplot(student_score$score)
sprintf("Outlier is %.1f", 0.0)





########## 5. ############
#In notebook





########## 6. ############
dog_height = data.frame(height=c(600, 470, 170, 430, 300))
dog_height
mean(dog_height$height)
var(dog_height$height)
sd(dog_height$height)

