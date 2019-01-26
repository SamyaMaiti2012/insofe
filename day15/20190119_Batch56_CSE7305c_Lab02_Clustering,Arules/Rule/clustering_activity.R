#install.packages("arules")
library(arules)

trans = read.transactions(file="/Users/samyam/Documents/Samya/Insofe/insofe/day15/
                          20190119_Batch56_CSE7305c_Lab02_Clustering,Arules/Rule/Transactions.csv",
                          rm.duplicates= FALSE, format="single", sep=",", cols =c(1,2))

inspect(trans)
trans

itemFrequency(trans)
itemFrequencyPlot(trans)

rules <- apriori(trans,parameter = list(sup = 0.2, conf = 0.6,target="rules"))
rules

inspect(rules)

rules = as(rules[sort(rules, by = c("confidence", "support"), order = TRUE)],"data.frame")
rules



require(stringr)
m = str_split(rules$rules,"=>")
rhs = data.frame(RHS = unlist(lapply(m,function(x){str_trim(x[2])}))) 
rhs
lhs = data.frame(LHS = unlist(lapply(m,function(x){str_trim(x[1])}))) 
lhs
rules_csv = data.frame(lhs, rhs, rules[,c("support", "confidence", "lift")]) 
rules_csv = unique(rules_csv)
rules_csv




################ Titanic dataset ####################
load("/Users/samyam/Documents/Samya/Insofe/insofe/day15/20190119_Batch56_CSE7305c_Lab02_Clustering,Arules/Rule/titanic.raw.rdata")
class(titanic.raw)
summary(titanic.raw) 
str(titanic.raw)

head(titanic.raw,5)
idx <- sample(1:nrow(titanic.raw), 5) 
titanic.raw[idx, ]

titanic = as(titanic.raw, "transactions")
inspect(titanic)

itemFrequency(titanic) 
itemFrequencyPlot(titanic)

rules.all <- apriori(titanic)
rules.all
inspect(rules.all)



rules <- apriori(titanic.raw, control = list(verbose=F),parameter = list(minlen=2, supp=0.005, conf=0.8), 
                 appearance = list(rhs=c("Survived=No","Survived=Yes"), default="lhs"))
inspect(rules)

quality(rules) <- round(quality(rules), digits=3)
rules.sorted <- sort(rules, by="lift")
inspect(rules.sorted)


subset.matrix <- is.subset(rules.sorted, rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag = T)] <- NA 
redundant <- colSums(subset.matrix, na.rm = T) >= 1
which(redundant)
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned)
