
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
               values_to = 'cases')
confirmed_made_date_column

deaths_made_date_column <- deaths_import %>% 
  pivot_longer(c(`1/22/20`:`7/31/20`),
               names_to = 'date',
               values_to = 'cases')
deaths_made_date_column

# Convert Date column to ISO 8601 format
confirmed_date_format <- confirmed_made_date_column %>% 
  mutate(date = mdy(date))
confirmed_date_format

deaths_date_format <- deaths_made_date_column %>% 
  mutate(date = mdy(date))
deaths_date_format

# Remove dates before first US case
confirmed_after_us_first <- confirmed_date_format %>% 
  filter(date >= dmy(first_us_case))
confirmed_after_us_first

deaths_after_us_first <- deaths_date_format %>% 
  filter(date >= dmy(first_us_case))
deaths_after_us_first
