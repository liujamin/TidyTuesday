library(tidyverse)
library(dplyr)
library(ggplot2)
#install.packages("circlize")
library(circlize)
library(countrycode)
library(cowplot)
library(ggplotify)

# Get the Data
erasmus <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-08/erasmus.csv')
glimpse(erasmus)

#Use countrycode to replace iso abbreviation to country names
erasmus <- erasmus %>% mutate(
  receiving_country= countrycode(receiving_country_code, origin="iso2c", destination="iso.name.en"),
  sending_country= countrycode(sending_country_code, origin="iso2c", destination="iso.name.en"),
  ) %>%
#Error thrown with EL, UK, and XK so manually mutate
#XK is apparently Kosovo (https://geonames.wordpress.com/2010/03/08/xk-country-code-for-kosovo/)
# Also change Netherlands (the) to The Netherlands
  mutate(
    receiving_country = replace(receiving_country, receiving_country_code=="UK","United Kingdom"),
    sending_country = replace(sending_country, sending_country_code=="UK","United Kingdom"), 
    receiving_country = replace(receiving_country, receiving_country_code=="EL","Greece"),
    sending_country = replace(sending_country, sending_country_code=="EL","Greece"),
    receiving_country = replace(receiving_country, receiving_country_code=="XK","Kosovo"),
    sending_country = replace(sending_country, sending_country_code=="XK","Kosovo"),
    receiving_country = replace(receiving_country, receiving_country=="Netherlands (the)","The Netherlands"),
    sending_country = replace(sending_country, sending_country=="Netherlands (the)","The Netherlands")
  )

#Create dataframe for plotting
data <- erasmus %>% group_by(academic_year, sending_country, receiving_country)%>%
  summarise(value=sum(participants))%>%
  arrange(-value)
chordDiagram(data[2:4])
#Upon looking at this data, we see that most students actually remain in their country
#Which is not very interesting for plotting purposes

data_abroad <- data %>% filter(sending_country != receiving_country)
chordDiagram(data_abroad[2:4])
#After filtering out domestic exchanges, we see a more interesting plot
#But this is over all the years so let's look at year by year

#convert chordDiagram (base plot) to grid plot to combine with ggplot annotations and theme details
data_2014 <- data_abroad %>% filter(academic_year == '2014-2015') %>% subset(select = -c(1)) %>% filter(value > 15) %>% chordDiagram
data_2015 <- data_abroad %>% filter(academic_year == '2015-2016') %>% subset(select = -c(1)) %>% filter(value > 15)%>% chordDiagram
data_2016 <- data_abroad %>% filter(academic_year == '2016-2017') %>% subset(select = -c(1)) %>% filter(value > 15)%>% chordDiagram
data_2017 <- data_abroad %>% filter(academic_year == '2017-2018') %>% subset(select = -c(1)) %>% filter(value > 15)%>% chordDiagram
data_2018 <- data_abroad %>% filter(academic_year == '2018-2019') %>% subset(select = -c(1)) %>% filter(value > 15)%>% chordDiagram
data_2019 <- data_abroad %>% filter(academic_year == '2019-2020') %>% subset(select = -c(1)) %>% filter(value > 15)%>% chordDiagram

#In honor of International Womens Day let's look at where women went for Eramus
data_women <- erasmus %>% filter(sending_country != receiving_country) %>%
  filter(participant_gender != 'Male') %>% group_by(academic_year, sending_country, receiving_country)%>%
  summarise(value=sum(participants))
data_2019_women <- data_women %>% filter(academic_year == '2019-2020')
chordDiagram(data_2019_women[2:4])

#Now, looking at people who are not from a the same country where they were 
#about to depart from, where did they go?
#1100 learners who were foreign and traveled abroad
#910 learners who did not go abroad back to their national country
data_foreign <- erasmus %>% filter(sending_country_code != participant_nationality) %>%
  filter(sending_country != receiving_country) %>% filter(receiving_country_code != participant_nationality)%>%
  group_by(sending_country, receiving_country) %>% summarise(value=sum(participants)) %>%
  filter(value > 10)


par(cex = 0.7, mar = c(0, 0, 0, 0))
chordDiagram(data_foreign,
             transparency = 0.25,
             directional = 1,
             direction.type = c("arrows", "diffHeight"), 
             diffHeight  = -0.02,
             annotationTrack = c("name","grid"),
             link.arr.type = "big.arrow", 
             link.sort = TRUE, 
             link.largest.ontop = TRUE)

p<-recordPlot()
as.ggplot(ggdraw(p))+
  labs(title="ERASMUS STUDENT MOBILITY",
       subtitle="Foreign Erasmus student mobility between participating countries \n from 2014 to 2020",
       caption="Data from Data.Europa.eu")+
  theme(text=element_text(family="Arial"),
        plot.title=element_text(hjust=0.5, face="bold", size=18),
        plot.subtitle=element_text(hjust=0.5, size=12, margin=margin(t=10)),
        plot.caption=element_text(size=10, hjust=0.95, margin=margin(b=12)),
        plot.margin   =margin(t=20))

