library(tidymodels)
library(dplyr)

#### 1. Get Data ####
raw <- read.csv("data/songs.csv")

#### 2. Clean Dataset ####

## remove NAs (preferably replace if numeric)
data <- na.omit(raw)

## Encode categorical data
data <- data |> mutate(artist = as.factor(artist), genre=as.factor(genre), explicit=as.logical(explicit))

#### 3. Visualize correlation (via PCA for high-dims) ####
library(reshape2)
library(ggplot2)

## Correlation
cors <- data |> select(popularity, energy, tempo) |>
  cor() |> melt() |> as.data.frame()
cors

ggplot(cors, aes(x=Var1, y=Var2, fill=value)) +
  geom_tile()

## PCA
data_num <- select(data, -artist, -song, -explicit, -genre)
pca <- prcomp(data_num, scale. = T)
summary(pca)

pcds <- as.data.frame(pca$x)
pcds$explicit <- data$explicit

ggplot(pcds, aes(PC1, PC2, color=explicit)) + geom_point()

#### 4. Feature Selection ####

# Choose type: prediction or classification
# Choose vars: labels and features

# e.g. classify genre (label), using artist, year, explicit, popularity, energy, key, acousticness, instrumentalness, liveness, valence, tempo. (features)

data <- select(data, genre, artist, year, explicit, popularity, energy, key, acousticness, instrumentalness, liveness, valence, tempo)
data

#### 5. Split data ####
library(rsample)
## Train-Test Split 80:20

split <- initial_split(data, prop=.8)
train <- training(split) # 80% of the data, randomly sampled w/o replacement
test <- testing(split)   # 20% 

#### 6. Fit Data ####
library(parsnip)
## Select a model (classifier or predictor): e.g. boosted tree for classification

fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("classification") |>
  fit(genre ~ artist + year + explicit + popularity + energy + key + acousticness + instrumentalness + liveness + valence + tempo, data=train)

fit$fit
summary(fit$fit) 

#### 7. Make test predictions ####
library(yardstick)
# install.packages("Metrics")
library(Metrics)
results <- test

results$predictions <- predict(fit, test)$.pred_class
acc_table <- data.frame(actual=results$genre, preds=results$predictions)
f1(results$genre, results$predictions)

library(caret)
out <- confusionMatrix(results$genre, results$predictions, mode="everything")
byclass <- out[['byClass']]

