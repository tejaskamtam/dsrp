library(tidyr)
library(janitor)
library(dplyr)

data <- read.csv("data/songs.csv")
# clean column names
data <- janitor::clean_names(data, case="snake")

# Pipe Operator
data |> filter(grepl("pop",genre))

# Slicing 
# _min/_max will get the top n max or min "values" but there can be ties so >= n outputs
slice_max(data, popularity, n=5, with_ties = F)
slice_min(data, popularity, n=5, with_ties=F)

# Tidy Data ####

## Pivot
table4a
pivot_longer(table4a, cols=c(`1999`,`2000`), names_to="year", values_to="cases")

table4b
pivot_longer(table4b, cols=c(`1999`,`2000`), names_to="year", values_to="population")

table2
pivot_wider(table2, names_from=type, values_from=count)


## Separate
table3
separate(table3, rate, into=c("cases", "population"), sep="/")

## Unite
tidy5 <- table5 |>
  unite("year", c("century","year"), sep="") |>
  separate(rate, into=c("cases", "population"), sep="/")

## Bind (rows)
# names, types must match
new_entry <- data.frame(country="USA", year="2000",cases="0",population="200000000")
bind_rows(tidy5, new_entry)



