
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
               values_to = 'confirmed')
confirmed_made_date_column

deaths_made_date_column <- deaths_import %>% 
  pivot_longer(c(`1/22/20`:`7/31/20`),
               names_to = 'date',
               values_to = 'deaths')
deaths_made_date_column

# Convert Date column to ISO 8601 format
confirmed_date_format <- confirmed_made_date_column %>% 
  mutate(date = mdy(date))
confirmed_date_format

deaths_date_format <- deaths_made_date_column %>% 
  mutate(date = dmy(date))
deaths_date_format

# Remove dates before first US case
confirmed_after_us_first <- confirmed_date_format %>% 
  filter(date >= dmy(first_us_case))
confirmed_after_us_first

deaths_after_us_first <- deaths_date_format %>% 
  filter(date >= dmy(first_us_case))
deaths_after_us_first

### Plot 1

# data set greater than or equal to first MO case
covid_confirmed_and_deaths <- left_join(deaths_after_us_first, confirmed_after_us_first)
covid_confirmed_and_deaths
covid_combined_mo <- covid_confirmed_and_deaths %>% 
  filter(date >= mdy(first_mo_case))
covid_combined_mo

# I can't put the graphs side by side, could not download package to do so.

# add regions to data
covid_combined_regions <- covid_combined_mo %>% 
  mutate(regions = case_when(stateFIPS %in% northeast ~ "Northeast",
                             stateFIPS %in% south ~ "South",
                             stateFIPS %in% midwest ~ "Midwest",
                             stateFIPS %in% west ~ "West"))
covid_combined_regions

# Make total columns
plot_one_data <- covid_combined_regions %>% 
  summarize('Total Deaths' = sum(deaths, na.rm = TRUE),
            'Total Confirmed' = sum(confirmed, na.rm = TRUE),
            .groups = "drop")
plot_one_data

# plot 1- confirmed
plot_one_data %>% 
  ggplot() +
  geom_line(mapping = aes(x = date, y = 'Total Confirmed', color = 'regions'), size = 0.8) +
  labs(x = NULL, y = "Total Cases")
  


















