library(tidyverse)
library(dplyr)

pop_per_100k_per_county_state <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates.csv")

# average black prison rate across all locations across all years of dataset
# average white prison rate across all locations across all years of dataset
# county, state with highest black prison rate in 2016
# county, state with highest white prison rate in 2016
# ratio of average black prison rate to white prison rate across all counties across all years

# create new column combining county and state for convenience
pop_per_100k_per_county_state <- pop_per_100k_per_county_state %>%
  unite(location, c(county_name, state), sep = ", ", remove = FALSE)

# get average black and white prison pop rates across all locations across all years of dataset
mean_black_prison_pop_rate <- mean(pop_per_100k_per_county_state$black_prison_pop_rate,
                                   na.rm = TRUE)

mean_white_prison_pop_rate <- mean(pop_per_100k_per_county_state$white_prison_pop_rate,
                                   na.rm = TRUE)

# create dataframe containing only data from 2016, the most recent year in dataset with non-missing
# prison population rate data
pop_per_100k_per_county_state_2016 <- pop_per_100k_per_county_state %>%
  filter(year == 2016)

# find locations with highest black prison pop rate and highest white prison pop rate
highest_blk_pri_pop_rate_2016 <- pop_per_100k_per_county_state_2016 %>%
  filter(black_prison_pop_rate == max(black_prison_pop_rate, na.rm = TRUE)) %>%
  pull(location, black_prison_pop_rate)

highest_whi_pri_pop_rate_2016 <- pop_per_100k_per_county_state_2016 %>%
  filter(white_prison_pop_rate == max(white_prison_pop_rate, na.rm = TRUE)) %>%
  pull(location, white_prison_pop_rate)

# get ratio of average black prison pop rates vs white prison pop rates
ratio_blk_whi_pri_pop_rate <- mean_black_prison_pop_rate / mean_white_prison_pop_rate