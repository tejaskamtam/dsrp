library(ggplot)
library(dplyr)
data <- read.csv("data/songs.csv")

## PCA ####

data_num <- select(data, -artist, -song, -explicit, -genre)
pca <- prcomp(data_num, scale. = T)
summary(pca)

pcds <- as.data.frame(pca$x)
pcds$explicit <- data$explicit

ggplot(pcds, aes(PC1, PC2, color=explicit)) + geom_point()
