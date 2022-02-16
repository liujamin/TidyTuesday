# TidyTuesday 02/15/2022
# Set working directory
setwd("~/Documents/Github/challenge/")
# Load libraries
library(tidyverse)
library(ggplot2)
library(maps)

# Load in data
ch04 <- read_csv("2022/challenge03/data.csv")
ch04 <- read_csv("2022/challenge03/data_corrected.csv")
us_states <- map_data("state")

# merge us map for plotting with necessary fill color by population
ch04$Population <- factor(ch04$Population, 
                            levels = c("750,000 AND OVER", "600,000 - 750,000", "500,000 - 600,000",
                                       "300,000 - 500,000", "200,000 - 300,000", "100,000 - 200,000",
                                       "50,000 - 100,000", "25,000 - 50,000", "10,000 - 25,000",
                                       "UNDER - 10,000"))
ch04 <- left_join(ch04, data.frame(state.abb, state.name), by = c("State" = "state.abb")) %>%
  mutate(region = tolower(state.name)) %>% left_join(us_states)

dubois_palette <- c("black","#646464","#bcbcbc","#654321","#20124d","#d2b48c","#dc143c","#ffc0cb","#ffd700","#e5e0d9")
p <- ggplot(data = ch04, mapping = aes(x = long, y = lat, group = group, fill = Population))
p + scale_fill_manual(values = dubois_palette) +
  geom_polygon(color = "black", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  guides(scale = "none") +
  theme_void() +
  theme(text=element_text(family="mono"),
        plot.title.position = "plot",
        plot.title=element_text(hjust=0.5, size=12,face="bold", margin=margin(0,0,40,0)),
        plot.margin=margin(20,20,20,20)) +
  # build title
  labs(fill="",
       title="RELATIVE BLACK POPULATION OF THE STATES OF THE\nUNITED STATES.") + 
  # build legend
  theme(legend.position = 'bottom', legend.spacing.x = unit(0.5, 'cm'), legend.spacing.y = unit(0.25, 'cm')) +
  guides(fill=guide_legend(ncol=2, byrow = FALSE))


