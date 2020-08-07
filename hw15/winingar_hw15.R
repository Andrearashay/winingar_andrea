
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
  filter(date >= dmy(first_us_case))
confirmed_made_date_column

deaths_made_date_column <- deaths_import %>% 
  pivot_longer(c(`1/22/20`:`7/31/20`),
               names_to = 'date',
               values_to = 'deaths') %>% 
  mutate(date = dmy(date)) %>% 
  filter(date >= dmy(first_us_case))
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

# make data with only mo confirmed
mo_confirmed <- confirmed_made_date_column %>%  
  filter(State == 'MO', date >= dmy(first_mo_case))
mo_confirmed

# fix county names
mo_counties_renamed <- mo_confirmed %>% 
  mutate(`County Name` = str_replace(`County Name`, " County$", ""),
         `County Name` = str_replace(`County Name`, "^Jackson ", "")) %>% 
  group_by(`County Name`, date) %>% 
  rename('County' = `County Name`) %>% 
  summarise(total_cases = sum(confirmed, na.rm=TRUE))
mo_counties_renamed

# Import semo_counties and reduce to needed columns
semo_counties_import <- read_csv(here('data', 'semo_county_enrollment.csv'), skip = 1) %>% 
  rename('County' = X1)
semo_counties_import
semo_counties <- semo_counties_import %>% 
  select(County, `2019`)
semo_counties

# make changes to semo county data
semo_counties_fixed <- semo_counties %>% 
  mutate(`County`=str_replace(`County`,"De Kalb", "DeKalb"),
         `County`=str_replace(`County`,"^Sainte ","Ste\\. "),
         `County`=str_replace(`County`,"^Saint ","St\\. "),
         `County`=str_replace(`County`,"^St. Louis City$","City of St. Louis"))
semo_counties_fixed

# merge by left_join
plot_2_data <- left_join(semo_counties_fixed, mo_counties_renamed)
plot_2_data

# plot 2
plot_2_data %>% 
  ggplot() +
  geom_line(aes(x = date, y = total_cases, color=County)) +
  labs(x = NULL, y = "Total Confirmed Cases") +
  gghighlight(`2019` >= 200, use_direct_label = FALSE) +
  scale_x_date(date_labels = "%d %b") + 
  theme_test()






