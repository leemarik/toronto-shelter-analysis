#### Preamble ####
# Purpose: Cleans the Toronto Shelter System dataset for analysis
# Author:  Mariko Lee
# Date: 23 September 2024
# Contact: mariko.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

### Workspace setup ###
library(readr)
library(dplyr)
library(janitor)

### Load data ###
raw_data <- read_csv("data/raw_data/toronto-shelter-system-flow.csv")

### Clean column names ###
cleaned_data <- raw_data %>%
  janitor::clean_names()

### Handle missing values ###
cleaned_data <- cleaned_data %>%
  drop_na()

### Select relevant columns ###
# Include all specific age columns, gender, and population group percentage
cleaned_data <- cleaned_data %>%
  select(ageunder16, age16_24, age25_34, age35_44, age45_54, age55_64, age65over, 
         gender_male, gender_female, population_group_percentage)

### Clean population_group_percentage by removing non-numeric characters ###
cleaned_data <- cleaned_data %>%
  mutate(
    population_group_percentage = as.numeric(gsub("[^0-9.]", "", population_group_percentage)) # Remove non-numeric characters
  )

### Remove rows with NA in population_group_percentage ###
cleaned_data <- cleaned_data %>%
  filter(!is.na(population_group_percentage))

### Convert data types for gender columns ###
cleaned_data <- cleaned_data %>%
  mutate(
    gender_male = as.integer(gender_male),
    gender_female = as.integer(gender_female)
  )

### Save cleaned data ###
write_csv(cleaned_data, "data/analysis_data/cleaned_shelter_data.csv")
