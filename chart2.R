library(tidyverse)
library(dplyr)
library(ggplot2)

pop_per_100k_per_county_state <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates.csv")

pop_per_100k_per_county_state <- na.omit(pop_per_100k_per_county_state)

pop_per_100k_per_county_state <- pop_per_100k_per_county_state %>%
  filter(year == 2016) %>%
  group_by(state) %>%
  summarise(mean_total_pop = mean(total_pop, na.rm = TRUE),
            mean_black_prison_pop_rate = mean(black_prison_pop_rate, na.rm = TRUE))

ggplot(pop_per_100k_per_county_state, aes(x = mean_black_prison_pop_rate,
                                          y = mean_total_pop)) +
  geom_point() +
  labs(x = "Avg. Black Incarceration Rates Across Counties In A State",
       y = "Avg. Total Population Across Counties In A State") +
  ggtitle("Avg. Black Incarceration Rates And Avg. Population Totals")