
# Load Libraries ----------------------------------------------------------

library(tidyverse)
library(here)
library(lubridate)
library(gghighlight)
library(ggthemes)

# Define Constants --------------------------------------------------------

first_us_case <- '19 Jan 2020'
first_mo_case <- '08 Mar 2020'
lower_48 <- c("Alabama","Arizona","Arkansas","California","Colorado",
              "Connecticut","Delaware","Florida","Georgia","Idaho",
              "Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana",
              "Maine","Maryland","Massachusetts","Michigan","Minnesota",
              "Mississippi","Missouri","Montana","Nebraska","Nevada",
              "New Hampshire","New Jersey","New Mexico","New York",
              "North Carolina","North Dakota","Ohio","Oklahoma","Oregon",
              "Pennsylvania","Rhode Island","South Carolina","South Dakota",
              "Tennessee","Texas","Utah","Vermont","Virginia","Washington",
              "West Virginia","Wisconsin","Wyoming")
# CDC regions
northeast <- c(09, 23, 25, 33, 44, 50, 34, 36, 42)
south <- c(10, 11, 12, 13, 24, 37, 45, 51, 54, 01, 21, 28, 47, 05, 22, 40, 48)
midwest <- c(18, 17, 26, 39, 55, 19, 20, 27, 29, 31, 38, 46)
west <- c(04, 08, 16, 35, 30, 49, 32, 56, 02, 06, 15, 41, 53)

# Functions ---------------------------------------------------------------





# importing, wrangling, graphs --------------------------------------------

# Importing data

confirmed_import <- read_csv(here('data', 'covid_confirmed_usafacts.csv')) %>% 
  subset(countyFIPS != 0, stateFIPS != 0)
confirmed_import
deaths_import <- read_csv(here('data', 'covid_deaths_usafacts.csv')) %>% 
  subset(countyFIPS != 0, stateFIPS != 0)
deaths_import

# Tidy data
confirmed_made_date_column <- confirmed_import %>% 
  pivot_longer(c(`1/22/20`:`7/31/20`), 
               names_to = 'date', 
               values_to = 'confirmed') %>% 
  mutate(date = dmy(date)) %>% 
  filter(date <= dmy(first_us_case))
confirmed_made_date_column

deaths_made_date_column <- deaths_import %>% 
  pivot_longer(c(`1/22/20`:`7/31/20`),
               names_to = 'date',
               values_to = 'deaths') %>% 
  mutate(date = dmy(date)) %>% 
  filter(date <= dmy(first_us_case))
deaths_made_date_column


### Plot 1

# combined data
covid_confirmed_and_deaths <- left_join(deaths_made_date_column,
                                       confirmed_made_date_column)
covid_confirmed_and_deaths

# I can't put the graphs side by side, could not download package to do so.

# add regions to data
covid_combined_regions <- covid_confirmed_and_deaths %>% 
  filter(date >= mdy(first_mo_case)) %>% 
  mutate(regions = case_when(stateFIPS %in% northeast ~ "Northeast",
                             stateFIPS %in% south ~ "South",
                             stateFIPS %in% midwest ~ "Midwest",
                             stateFIPS %in% west ~ "West")) %>% 
  group_by(regions, date) %>% 
  summarise(total_cases = sum(confirmed,
                              na.rm=TRUE),
            total_deaths = sum(deaths,
                               na.rm=TRUE),
            .groups="drop")
covid_combined_regions

# plot 1- confirmed
covid_combined_regions %>% 
  ggplot() +
  geom_line(aes(x = date, y = total_cases, color = 'regions'), size = 0.8) +
  labs(x = NULL, y = 'Total Cases') +
  theme_test() +
  theme(legend.position = 'bottom')
  
# Plot 1- deaths
covid_combined_regions %>% 
  ggplot() +
  geom_line(aes(x = date, y = total_deaths, color = 'regions'), size = 0.8) +
  labs(x = NULL, y = "Total Deaths") +
  theme_test() +
  theme(legend.position = 'bottom')

### Plot 2

















