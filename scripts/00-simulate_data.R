#### Preamble ####
# Purpose: Simulates a dataset to mirror the Toronto Shelter System dataset for testing purposes
# Author: Mariko Lee
# Date: 23 September 2024
# Contact: mariko.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)


#### Simulate data ####

# Set seed for reproducibility
set.seed(1234)

# Simulate dates for 100 days
dates <- seq(as.Date('2023-01-01'), by = "day", length.out = 100)

# Simulate shelter types
shelter_types <- sample(c('All Population', 'Chronic', 'Refugees', 'Families', 'Youth', 'Single Adult', 'Non-refugees'), 100, replace = TRUE)

# Simulate age groups
age_groups <- sample(c('age25-34', 'age35-44', 'age45-54', 'age55-64', 'age65over'), 100, replace = TRUE)

# Simulate gender counts
gender_male <- sample(100:1000, 100, replace = TRUE)
gender_female <- sample(100:1000, 100, replace = TRUE)

# Simulate population counts
population <- sample(100:2000, 100, replace = TRUE)

# Combine all variables into a data frame
simulated_data <- data.frame(
  date = dates,
  shelter_type = shelter_types,
  age_group = age_groups,
  gender_male = gender_male,
  gender_female = gender_female,
  population = population
)

# View simulated data
head(simulated_data)

# Save the simulated data as a CSV
write_csv(simulated_data, "data/raw_data/simulated_shelter_data.csv")




