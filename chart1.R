library(tidyverse)
library(dplyr)
library(ggplot2)

no_na_values <- na.omit(pop_per_100k_per_county_state)

# average black and white prison pop rates over time
mean_blk_whi_pri_pop_rates_df <- no_na_values %>%
  group_by(year) %>%
  summarise(mean_blk_pri_pop_rate = mean(black_prison_pop_rate),
            mean_whi_pri_pop_rate = mean(white_prison_pop_rate))

# create lineplot
colors <- c("Black" = "blue",
            "White" = "red")

ggplot(mean_blk_whi_pri_pop_rates_df, aes(x = year)) +
  geom_line(aes(y = mean_blk_pri_pop_rate, color = "Black"), linewidth = 1.25) +
  geom_line(aes(y = mean_whi_pri_pop_rate, color = "White"), linewidth = 1.25) +
  labs(x = "Year",
       y = "Prison Population Rate",
       color = "Race") +
  scale_color_manual(values = colors) +
  ggtitle("Average Black and White Prison Population Rates Over Time In The U.S\n(Per 100,000 People)")
