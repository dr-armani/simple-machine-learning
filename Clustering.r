install.packages("ggplot2")
install.packages("factoextra")
library(factoextra)

scores = read.csv("Scores.csv", header=TRUE)

dim(scores)

scores[1:10,]

hist(scores[,5], main="grade") 

plot(scores[,4:5]) 

pairs(scores) 

hist(scores[,5])

scores_data = scores[4:5] 

scores_data [1:10,] 

plot(scores_data)

scores_data_scaled = scale(scores_data)

fviz_nbclust(scores_data_scaled, kmeans, method = "wss")

km = kmeans (scores_data_scaled, centers = 3 , nstart = 100)

km

km$withinss

sum(km$withinss)

clustered_scores = cbind(scores,km$cluster) ; clustered_scores[1:10,]

order(km$cluster)

clustered_scores[order(km$cluster),]

fviz_cluster(km, data = scores_data_scaled, geom = c("point"), ellipse.type = "euclid")
