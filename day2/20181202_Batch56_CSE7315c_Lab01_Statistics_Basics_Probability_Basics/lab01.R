#Q1

kohli_scores<- c(65, 72, 58, 77)
kohli_scores
old_median<- median(kohli_scores)
old_median
old_mean<- mean(kohli_scores)
old_mean
new_kohli_scores<- c(kohli_scores, 70)
new_kohli_scores
new_median<- median(new_kohli_scores)
new_median
new_mean<- mean(new_kohli_scores)
new_mean


#Q4

Ans: R Code:
  # (a) How is the spread of the scores?
  rote_scores<- c(11, 7.5, 8.5, 10, 10, 10.5, 5.5, 10, 9, 9.5, 5.25, 8, 6.5, 10.5, 8.75, 0, 6, 6, 6.75, 8.75, 0, 9.5, 7.5, 8.5, 7)
rote_mean<- mean(rote_scores)
rote_mean
diff_mean<- rote_scores - rote_mean
diff_mean
diff_mean_sq<- diff_mean^2
diff_mean_sq
diff_mean_sq_sum<- sum(diff_mean_sq)/length(rote_scores)
diff_mean_sq_sum
sd_rote<- sqrt(diff_mean_sq_sum)
sd_rote
range <- max(rote_scores) - min(rote_scores) #Range
range
sd_rote<- sqrt(sum((rote_scores - mean(x = rote_scores))^2)/length(x = rote_scores))
quantile(x = rote_scores)
quantile(x = rote_scores, prob = seq(from = 0, to = 1, by = 0.1),type = 1)
### (b) Draw a histogram to visualize the data distribution.
hist(x = rote_scores)
### (c) Find the 25th percentile, 50th percentile and 75 percentile for this data.
quantile(x = rote_scores, prob = c(0,0.25, 0.5, 0.75))
### (d) Find outliers, if any. Do a boxplot to visualize the same.
boxplot(x = rote_scores)
