#### Imports ####
# install.packages("ggplot2")
library(ggplot2)
data <- read.csv("data/songs.csv")

## Replace NAs
x = c(1, 2, 3, 4, NA, 5, 6, NA)
x[is.na(x)] <- mean(x, na.rm=T)

#### Plotting ####

### Distribution of 1 Variable
## Options: Histogram, Barplot, Boxplot, Density
# Histogram
ggplot(data, aes(x=year, fill=explicit)) +
  geom_histogram(color="black", alpha=0.6) +
  labs(title="Song Distribution by Year")
# Density
ggplot(data, aes(x=year)) +
  geom_density() +
  labs(title="Ditribution of Songs by Year")

## Numeric and Categorical
# Options: Boxplot, Violin, Bar, Scatter (using geom_jitter)
ggplot(data, aes(x=year, y=explicit, color=explicit)) +
  geom_violin() + geom_boxplot(width=0.2, color="black", fill=NA) +
  labs(title="Distribution of Songs by Year", xlab="Year", ylab="Explicit")

## Numeric and Numeric
# Options: scatter, line, smooth (polynomial best fit)
ggplot(data, aes(x=tempo, y=speechiness, color=explicit)) +
  geom_point(alpha=0.3) + 
  geom_smooth(color="black") +
  geom_smooth() +
  labs(title="Song Speechiness by Tempo") +
  theme_bw()

