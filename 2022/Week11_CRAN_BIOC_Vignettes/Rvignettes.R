library(ggplot2)
library(tidyverse)
library(dplyr)
library(lubridate)

#Import necessary datsets
#tuesdata <- tidytuesdayR::tt_load('2022-03-15')
#cran_df <- tuesdata$cran
cran_df <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-15/cran.csv")
bioc_df <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-15/bioc.csv")
cran_df <- subset(cran_df, date!='0') #2689

#Sort out date issues
cran_df$date2 <- strptime(cran_df$date, "%Y-%m-%d")
cran_df$date2[is.na(cran_df$date2)] <- strptime(cran_df$date[is.na(cran_df$date2)], "%a %b %d")
sum(is.na(cran_df$date2)) #13 missing all from leap year dates
#We will omit these 13 for now...
cran_df <- subset(cran_df, !is.na(cran_df$date2))
cran_df$date2 <- ymd(cran_df$date2)

#Select year >   
cran_df <- cran_df[cran_df$date2 >= "2009-01-01" & cran_df$date2 <= "2021-01-01",]
bioc_df <- bioc_df[bioc_df$date >= "2009-01-01",]

# Sum data over months
cran_tallied <- cran_df %>% arrange(date2) %>% mutate(dummie = 1)
bioc_tallied <- bioc_df %>% arrange(date) %>% mutate(dummie = 1)

cran_daily_subs <- cran_tallied %>% group_by(date = date2) %>%
  summarise(n = sum(dummie)) %>% filter(n < 500) %>% group_by(year = year(date)) %>%
  mutate(is_max = ifelse(n == max(n), TRUE, FALSE))
bioc_daily_subs <- bioc_tallied %>% group_by(date = date) %>%
  summarise(n = sum(dummie)) %>% filter(n < 300) %>% group_by(year = year(date)) %>%
  mutate(is_max = ifelse(n == max(n), TRUE, FALSE))

#plotting
cran_daily_subs %>%
  ggplot(aes(date, n)) + geom_line() + 
  scale_x_date(breaks="1 year", labels=scales::date_format("%Y"))+
  labs(title="Uploads to CRAN by date",
       y = "Uploads",
       x = "Years") +
  theme_grey()
  

bioc_daily_subs %>%
  ggplot(aes(date, n)) + geom_point()






