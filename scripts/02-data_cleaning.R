#### Preamble ####
# Purpose: Cleans the Toronto Shelter System dataset for analysis
# Author:  Mariko Lee
# Date: 23 September 2024
# Contact: mariko.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(readr)
library(dplyr)
library(janitor)

#### Clean data ####
raw_data <- read_csv("data/raw_data/toronto-shelter-system-flow.csv")

### Clean column names ###
cleaned_data <- raw_data %>%
  janitor::clean_names()

### Handle missing values ###
cleaned_data <- cleaned_data %>%
  drop_na()

### Select relevant columns ###
cleaned_data <- cleaned_data %>%
  select(date, shelter_type, age_group, gender_male, gender_female, population)

### Convert data types ###
cleaned_data <- cleaned_data %>%
  mutate(
    date = as.Date(date, format = "%Y-%m-%d"),
    gender_male = as.integer(gender_male),
    gender_female = as.integer(gender_female),
    population = as.integer(population)
  )

### Create new columns ###
cleaned_data <- cleaned_data %>%
  mutate(total_population = gender_male + gender_female)

### Save cleaned data ###
write_csv(cleaned_data, "data/analysis_data/cleaned_shelter_data.csv")