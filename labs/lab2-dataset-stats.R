#### Imports ####
# install.packages("tidyverse")
library(tidyverse)

data <- read.csv("data/songs.csv")
glimpse(data)
summary(data)


#### Raw Data ####
energy <- data$energy

## Basic Stats
mean_energy <- mean(energy, na.rm=T) # na.rm = TRUE (remove NAs)
med_energy <- median(energy)
range_energy <- range(energy)
var_energy <- var(energy)
stdev_energy <- sd(energy)
iqr_energy <- IQR(energy)

## Quantiles
q1_energy <- quantile(energy, .25, na.rm=T) # also mean - 3*sd
q3_energy <- quantile(energy, .75, na.rm=T) # also mean + 3*sd

## Limits
upper_limit <- q3_energy + 1.5 * iqr_energy
lower_limit <- q1_energy - 1.5 * iqr_energy

## Get Outliers
outliers = energy[energy < lower_limit | energy > upper_limit]


### Without Outliers ####
### if there are no outliers -> add some using c()
energy <- c(energy, 0.1, 0.001, 1.2, 1.4)

energy2 <- energy[energy > lower_limit & energy <= upper_limit]
plot.new()
boxplot(energy)
boxplot(energy2)
# or with subset: var2 <- subset(var, var >= low & var <= high)
# or with c(): var2 <- c(var[var >= low], var[var <= high])

summary(energy2)

mean_energy2 <- mean(energy2)
med_energy2 <- median(energy2)




















