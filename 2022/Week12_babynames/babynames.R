# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load(2022, week = 12)

# Set up packages
library(ggplot2)
library(tidyverse)
library(dplyr)
library(tidyr)
library(cowplot)

# Let's just look at US babynames
babynames <- tuesdata$babynames

# Plot a multiplot with many Harry Potter character names
p1 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Hermione' & babynames$sex == 'F', ], aes(x = year, y = n), color='red') +
  labs(x = "Year", y = "Count", title = "Hermione") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p2 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Luna' & babynames$sex == 'F', ], aes(x = year, y = n), color='red') +
  labs(x = "Year", y = "Count", title = "Luna") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p3 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Ginny' & babynames$sex == 'F', ], aes(x = year, y = n), color='red') +
  labs(x = "Year", y = "Count", title = "Ginny") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p4 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Minerva' & babynames$sex == 'F', ], aes(x = year, y = n), color='red') + 
  labs(x = "Year", y = "Count", title = "Minerva") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p5 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Lily' & babynames$sex == 'F', ], aes(x = year, y = n), color='red') +
  labs(x = "Year", y = "Count", title = "Lily") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p6 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Bellatrix' & babynames$sex == 'F', ], aes(x = year, y = n), color='red') + 
  labs(x = "Year", y = "Count", title = "Bellatrix") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p7 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Dolores' & babynames$sex == 'F', ], aes(x = year, y = n), color='red') +
  labs(x = "Year", y = "Count", title = "Dolores") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
plot_grid(p1,p2,p3,p4,p5,p6,p7,ncol=3,align = "v")

p8 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Harry' & babynames$sex == 'M',], aes(x = year, y = n), color='blue') +
  labs(x = "Year", y = "Count", title = "Harry") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p9 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Ron' & babynames$sex == 'M',], aes(x = year, y = n), color='blue') +
  labs(x = "Year", y = "Count", title = "Ron") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p10 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Albus' & babynames$sex == 'M',], aes(x = year, y = n), color='blue') +
  labs(x = "Year", y = "Count", title = "Albus") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p11 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Severus' & babynames$sex == 'M',], aes(x = year, y = n), color='blue') +
  labs(x = "Year", y = "Count", title = "Severus") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p12 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Draco' & babynames$sex == 'M',], aes(x = year, y = n), color='blue') +
  labs(x = "Year", y = "Count", title = "Draco") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p13 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Neville' & babynames$sex == 'M',], aes(x = year, y = n), color='blue') +
  labs(x = "Year", y = "Count", title = "Neville") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p14 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Rubeus' & babynames$sex == 'M',], aes(x = year, y = n), color='blue') +
  labs(x = "Year", y = "Count", title = "Rubeus") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p15 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Fred' & babynames$sex == 'M',], aes(x = year, y = n), color='blue') +
  labs(x = "Year", y = "Count", title = "Fred") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p16 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'George' & babynames$sex == 'M',], aes(x = year, y = n), color='blue') +
  labs(x = "Year", y = "Count", title = "George") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p17 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Sirius' & babynames$sex == 'M',], aes(x = year, y = n), color='blue') +
  labs(x = "Year", y = "Count", title = "Sirius") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p18 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Remus' & babynames$sex == 'M',], aes(x = year, y = n), color='blue') +
  labs(x = "Year", y = "Count", title = "Remus") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
p19 <- ggplot (data = babynames) + 
  geom_line(data = babynames[babynames$name == 'Cedric' & babynames$sex == 'M',], aes(x = year, y = n), color='blue') +
  labs(x = "Year", y = "Count", title = "Cedric") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlim(1960, 2020)
plot_grid(p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,ncol=4,align = "v")



