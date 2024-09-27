#### Preamble ####
# Purpose: Cleans the Toronto Shelter System dataset for analysis
# Author:  Mariko Lee
# Date: 23 September 2024
# Contact: mariko.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


# Load raw data
raw_data <- read_csv("data/raw_data/toronto-shelter-system-flow.csv")

# Clean column names for consistency (e.g., snake_case)
cleaned_data <- raw_data %>%
  janitor::clean_names()

# Remove any rows with missing values
cleaned_data <- cleaned_data %>%
  drop_na()

# Select only the relevant columns (age groups, gender, population percentage, and transitions)
cleaned_data <- cleaned_data %>%
  select(ageunder16, age16_24, age25_34, age35_44, age45_54, age55_64, age65over,
         gender_male, gender_female, population_group_percentage, 
         returned_from_housing, moved_to_housing, newly_identified)

# Clean population_group_percentage by removing any non-numeric characters
cleaned_data <- cleaned_data %>%
  mutate(population_group_percentage = as.numeric(gsub("[^0-9.]", "", population_group_percentage)))  # Ensure only numeric values

# Population group column
cleaned_data <- cleaned_data %>%
  mutate(across(c(chronic, families, refugees, youth), 
                ~ ifelse(. == "Yes", 1, 0)))

# Remove rows with NA in population_group_percentage (if any remain)
cleaned_data <- cleaned_data %>%
  filter(!is.na(population_group_percentage))

# Convert gender columns (male and female) from characters to integers (if necessary)
cleaned_data <- cleaned_data %>%
  mutate(across(c(gender_male, gender_female), as.integer))  # Applies as.integer to both gender columns

# Handle missing values in transition columns (if applicable)
cleaned_data <- cleaned_data %>%
  mutate(across(c(returned_from_housing, moved_to_housing, newly_identified), ~ replace_na(.x, 0)))

# Create a date column (assuming monthly data, starting from January 2020)
cleaned_data <- cleaned_data %>%
  mutate(date = seq(as.Date("2020-01-01"), by = "month", length.out = nrow(cleaned_data)))

# Save the cleaned data to a new CSV file
write_csv(cleaned_data, "data/analysis_data/cleaned_shelter_data.csv")


