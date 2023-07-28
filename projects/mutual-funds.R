library(dplyr)

data_mf <- read.csv("data/mutual-funds.csv")

mf_stats <- data_mf |>  summarize(.by=ask_id, mean_return=mean(return__1y), sd_return=sd(return__1y), mean_vol=mean(volatility_1y), sd_vol=sd(volatility_1y), mean_drawdown=mean(max_drawdown_1y), sd_drawdown=sd(max_drawdown_1y))

# group by ####
library(ggplot2)
library(lubridate)

data_mf$as_of <- mdy(data_mf$as_of)

grouped_dates <- data_mf |> group_by(date=as_of) |> summarize(returns = mean(return__1y, na.rm=T)) |> na.omit()

grouped_months <- data_mf |> group_by(month = floor_date(as_of, "month")) |> summarize(returns = mean(return__1y, na.rm=T)) |> na.omit()

ggplot() +
  # daily
  geom_line(grouped_dates, mapping=aes(x=date, y=returns), color="black") +
  geom_smooth(grouped_dates, mapping=aes(x=date, y=returns), color="blue")

ggplot() +
  # monthly
  geom_line(grouped_months, mapping=aes(x=month, y=returns), color="red") +
  geom_smooth(grouped_months, mapping=aes(x=month, y=returns), color="pink")

  

# daily_stats <- data.frame(dates=unique(data_mf$as_of), returns=mean(data_mf$return__1y, na.rm=T, .))
