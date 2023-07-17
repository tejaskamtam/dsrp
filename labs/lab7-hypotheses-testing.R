library(dplyr)
library(ggplot2)
install.packages("corrplot")
library(corrplot)

data <- read.csv("data/songs.csv")
data$explicit <- as.logical(data$explicit)

# Independent T Test: compare popularity bw explicit and clean songs
# H0: popularity is the same independent of explicit
# HA: popularity is different

# c_mean = nc_mean
# H0: c_mean - nc_mean = 0
# HA: (difference) != 0

explicit <- data |> filter(explicit == T)
clean <- data |> filter(explicit == F)

t.test(explicit$popularity, clean$popularity)

# p-val < 0.05 -> null rejected, HA accepted

## ANOVA ####
aov_res <- aov(data$popularity ~ factor(data$explicit), data)
summary(aov_res)
tukey <- TukeyHSD(aov_res)

## Chi-Squared Test - check if groups are independent ####
con_table <- table(data$explicit, data$popularity)
# View(con_table)
chisq.test(con_table)


# try with different data
t <- table(mpg$year, mpg$drv)
t
chi <- chisq.test(t)
chi
chi$p.value
chi$residuals
corrplot(chi$residuals)







