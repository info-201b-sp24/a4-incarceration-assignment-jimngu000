library(tidyverse)
library(dplyr)
library(maps)
library(mapproj)

# get data for washington in 2016
pop_per_100k_1990_wa <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-prison-jail-rates-1990-WA.csv")
no_na_values <- pop_per_100k_1990_wa %>%
  filter(year == 2016)

# get shapefile, join dataframes
county_shapes <- map_data("county") %>%
  unite(polyname, region, subregion, sep = ",") %>%
  left_join(county.fips, by = "polyname")

map_data <- county_shapes %>%
  left_join(no_na_values, by = "fips") %>%
  filter(state == "WA")

# create blank theme
blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
  )

#create map
ggplot(map_data) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = black_prison_pop_rate),
    color="gray", linewidth = 0.3
  ) + 
  coord_map() + 
  scale_fill_continuous(limits = c(0, max(map_data$black_prison_pop_rate)), na.value = "white", low ="gray", high="black") + 
  blank_theme + 
  ggtitle("Black Prison Population Rate in Washington By County") + labs(fill = "Rate Per 100,000 People")
